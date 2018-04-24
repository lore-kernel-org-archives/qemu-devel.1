Received: from eggs.gnu.org ([2001:4830:134:3::10]:33130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fAw3I-0002Gz-RF
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 07:24:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fAw3D-0002f8-OV
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 07:24:04 -0400
References: <1524470305-26484-1-git-send-email-thuth@redhat.com>
	<1524470305-26484-3-git-send-email-thuth@redhat.com>
	<06bd598b-7c14-03fc-9720-36a4b68f10b4@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b3d9d176-94ca-70d3-27e8-1a9dc969a29a@redhat.com>
Date: Tue, 24 Apr 2018 13:23:47 +0200
MIME-Version: 1.0
In-Reply-To: <06bd598b-7c14-03fc-9720-36a4b68f10b4@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/4] pc-bios/s390-ccw/net: Add support
 for pxelinux-style config files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor VM Mihajlovski <mihajlov@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>

On 24.04.2018 13:07, Viktor VM Mihajlovski wrote:
> On 23.04.2018 09:58, Thomas Huth wrote:
>> Since it is quite cumbersome to manually create a combined kernel with
>> initrd image for network booting, we now support loading via pxelinux
>> configuration files, too. In these files, the kernel, initrd and comma=
nd
>> line parameters can be specified seperately, and the firmware then tak=
es
>> care of glueing everything together in memory after the files have bee=
n
>> downloaded.
>>
>> The user can either specify a config file directly as bootfile via DHC=
P
>> (but in this case, the file has to start either with "default" or a "#=
"
>> comment so we can distinguish it from binary kernels), or a folder (i.=
e.
>> the bootfile name must end with "/") where the firmware should look fo=
r
>> the typical pxelinux.cfg file names based on MAC or IP address. If no
>> direct file or folder has been specified, we still look for certain
>> files in the default "pxelinux.cfg/" folder, but omit some of the file
>> names to avoid to download x86 config files here by mistake.
> I don't think this is necessary, since the DHCP server configuration
> SHOULD take into consideration the processor architecture. In fact it i=
s
> even annoying and hard to understand that an attempt is made to load th=
e
> uuid, mac and "full ip" based config files but not the "abbreviated ip"
> or default file.

If the DHCP server has been been properly configured to take the
processor architecture into account, there should be a usable entry in
the bootfile (i.e. either a binary, a config file or a folder where
config files should be probed). So in this case the skipping does not
take place.

And if you want the full probing in the pxelinux.cfg/ directory, you can
also specify "pxelinux.xfg/" in the bootfile entry.

The skipping only happens if there is no valid entry in the bootfile,
i.e. the server configuration was likely wrong anyway, and we just do
some desperate final guesses with the default "pxelinux.cfg/" directory
before giving up.

> After all, even if the config file for x86 was loaded,
> the effect will be that the network boot fails (as it does now).

Ok, that's true, too.

Actually, I don't mind too much whether we probe the files based on the
partial IP address or the "default" name, or whether we skip them. I
thought it might be a good idea to avoid a potential clash with x86
files, but if you think that this is rather confusing, I also see your
point. So I'd say let's wait for some more opinions from others before
we decide about the final behavior...

 Thomas
