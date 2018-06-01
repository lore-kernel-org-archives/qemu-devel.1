Received: from eggs.gnu.org ([2001:4830:134:3::10]:41726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fOcru-0008Fo-8e
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 01:44:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fOcrr-0002Sg-5c
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 01:44:54 -0400
References: <1527671818-23809-1-git-send-email-thuth@redhat.com>
	<1527671818-23809-3-git-send-email-thuth@redhat.com>
	<07fcdd6a-1ff2-0c14-aaa7-18457c8be1dd@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9d57d5e0-450d-c315-8b33-603d02583c46@redhat.com>
Date: Fri, 1 Jun 2018 07:44:46 +0200
MIME-Version: 1.0
In-Reply-To: <07fcdd6a-1ff2-0c14-aaa7-18457c8be1dd@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] pc-bios/s390-ccw/net: Add support for
 pxelinux-style config files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor VM Mihajlovski <mihajlov@linux.vnet.ibm.com>, qemu-s390x@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>

On 30.05.2018 13:07, Viktor VM Mihajlovski wrote:
> On 30.05.2018 11:16, Thomas Huth wrote:
>> Since it is quite cumbersome to manually create a combined kernel with
>> initrd image for network booting, we now support loading via pxelinux
>> configuration files, too. In these files, the kernel, initrd and comma=
nd
>> line parameters can be specified seperately, and the firmware then tak=
es
>> care of glueing everything together in memory after the files have bee=
n
>> downloaded. See this URL for details about the config file layout:
>> https://www.syslinux.org/wiki/index.php?title=3DPXELINUX
>>
>> The user can either specify a config file directly as bootfile via DHC=
P
>> (but in this case, the file has to start either with "default" or a "#=
"
>> comment so we can distinguish it from binary kernels), or a folder (i.=
e.
>> the bootfile name must end with "/") where the firmware should look fo=
r
>> the typical pxelinux.cfg file names, e.g. based on MAC or IP address.
>> We also support the pxelinux.cfg DHCP options 209 and 210 from RFC 507=
1.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  pc-bios/s390-ccw/netboot.mak |  7 ++--
>>  pc-bios/s390-ccw/netmain.c   | 79 +++++++++++++++++++++++++++++++++++=
++++++++-
>>  2 files changed, 82 insertions(+), 4 deletions(-)
> [...]
>> diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
>> index 7533cf7..e84bb2b 100644
>> --- a/pc-bios/s390-ccw/netmain.c
>> +++ b/pc-bios/s390-ccw/netmain.c
> [...]
>> @@ -301,6 +363,18 @@ static int net_try_direct_tftp_load(filename_ip_t=
 *fn_ip)
>>          if (!strncmp("* ", cfgbuf, 2)) {
>>              return handle_ins_cfg(fn_ip, cfgbuf, rc);
>>          }
>> +        if (!strncasecmp("default", cfgbuf, 7) || !strncmp("# ", cfgb=
uf, 2)) {
> Minor, but I'm wondering whether this is not too cautious and could rul=
e
> out valid config files. You might just unconditionally call
> pxelinux_parse_cfg and let it find out if this is as pxelinux config
> file or not.

I thought about this for a while, but I think I'd rather avoid this.
It's also possible that the user tried to load a small binary which
accidentally contained a string like "label" and "kernel", and then the
bios would try to interpret this as config file instead of just running
the binary.

If you feel really unhappy about the magic string matching with
"default" and "# " here, I think it would be better to remove this magic
completely instead. The original pxelinux loader and petitboot also do
not support this, but rely on the DHCP options 209 and 210 instead
(which we also support now). I only added this magic here for my own
convenience, since the built-in DHCP server of QEMU does not support the
options 209 and 210, and I still wanted to have a way to quickly change
from one config file to another... but now that the code is basically up
and running, it's not really required anymore, so removing this should
be fine. Alternatively, we could use a more sophisticated magic here,
like "# pxelinux" for example, just for the developers' convenience ...
what do you think?

 Thomas
