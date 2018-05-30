Received: from eggs.gnu.org ([2001:4830:134:3::10]:38071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1fNyxC-0000UF-Ej
	for qemu-devel@nongnu.org; Wed, 30 May 2018 07:07:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1fNyx4-0002KT-0H
	for qemu-devel@nongnu.org; Wed, 30 May 2018 07:07:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1fNyx3-0002I8-Kk
	for qemu-devel@nongnu.org; Wed, 30 May 2018 07:07:33 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4UB3xXI129822
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 07:07:31 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2j9svbjk0x-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 07:07:30 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Wed, 30 May 2018 12:07:28 +0100
References: <1527671818-23809-1-git-send-email-thuth@redhat.com>
	<1527671818-23809-3-git-send-email-thuth@redhat.com>
From: Viktor VM Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Wed, 30 May 2018 13:07:24 +0200
MIME-Version: 1.0
In-Reply-To: <1527671818-23809-3-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <07fcdd6a-1ff2-0c14-aaa7-18457c8be1dd@linux.vnet.ibm.com>
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
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>

On 30.05.2018 11:16, Thomas Huth wrote:
> Since it is quite cumbersome to manually create a combined kernel with
> initrd image for network booting, we now support loading via pxelinux
> configuration files, too. In these files, the kernel, initrd and command
> line parameters can be specified seperately, and the firmware then takes
> care of glueing everything together in memory after the files have been
> downloaded. See this URL for details about the config file layout:
> https://www.syslinux.org/wiki/index.php?title=PXELINUX
> 
> The user can either specify a config file directly as bootfile via DHCP
> (but in this case, the file has to start either with "default" or a "#"
> comment so we can distinguish it from binary kernels), or a folder (i.e.
> the bootfile name must end with "/") where the firmware should look for
> the typical pxelinux.cfg file names, e.g. based on MAC or IP address.
> We also support the pxelinux.cfg DHCP options 209 and 210 from RFC 5071.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  pc-bios/s390-ccw/netboot.mak |  7 ++--
>  pc-bios/s390-ccw/netmain.c   | 79 +++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 82 insertions(+), 4 deletions(-)
[...]
> diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
> index 7533cf7..e84bb2b 100644
> --- a/pc-bios/s390-ccw/netmain.c
> +++ b/pc-bios/s390-ccw/netmain.c
[...]
> @@ -301,6 +363,18 @@ static int net_try_direct_tftp_load(filename_ip_t *fn_ip)
>          if (!strncmp("* ", cfgbuf, 2)) {
>              return handle_ins_cfg(fn_ip, cfgbuf, rc);
>          }
> +        if (!strncasecmp("default", cfgbuf, 7) || !strncmp("# ", cfgbuf, 2)) {
Minor, but I'm wondering whether this is not too cautious and could rule
out valid config files. You might just unconditionally call
pxelinux_parse_cfg and let it find out if this is as pxelinux config
file or not.
> +            /* Looks like it is a pxelinux.cfg */
> +            struct pl_cfg_entry entries[MAX_PXELINUX_ENTRIES];
> +            int num_ent, def_ent = 0;
> +
> +            num_ent = pxelinux_parse_cfg(cfgbuf, sizeof(cfgbuf), entries,
> +                                         MAX_PXELINUX_ENTRIES, &def_ent);
> +            if (num_ent <= 0) {
> +                return -1;
> +            }
> +            return load_kernel_with_initrd(fn_ip, &entries[def_ent]);
> +        }>      }
> 
>      /* Move kernel to right location */
> @@ -406,6 +480,9 @@ void main(void)
>      if (fnlen > 0 && fn_ip.filename[fnlen - 1] != '/') {
>          rc = net_try_direct_tftp_load(&fn_ip);
>      }
> +    if (rc <= 0) {
> +        rc = net_try_pxelinux_cfg(&fn_ip);
> +    }
> 
>      net_release(&fn_ip);
> 


-- 
Regards,
  Viktor Mihajlovski
