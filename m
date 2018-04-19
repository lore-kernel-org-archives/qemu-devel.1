Received: from eggs.gnu.org ([2001:4830:134:3::10]:51670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1f94X6-0001v9-UF
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 04:03:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1f94WV-0001jj-Fg
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 04:03:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37392
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1f94WV-0001jS-9P
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 04:02:31 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3J7xiBK105078
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 04:02:30 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2heq4t8bj9-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 04:02:29 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Thu, 19 Apr 2018 09:02:28 +0100
References: <1524054707-20663-1-git-send-email-thuth@redhat.com>
	<1524054707-20663-5-git-send-email-thuth@redhat.com>
From: Viktor VM Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Thu, 19 Apr 2018 10:02:25 +0200
MIME-Version: 1.0
In-Reply-To: <1524054707-20663-5-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <ac1ab286-38ab-66b0-612a-a487f7a314a0@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 for-2.13 4/4] pc-bios/s390-ccw/net: Add
 support for .INS config files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>

On 18.04.2018 14:31, Thomas Huth wrote:
> The .INS config files can normally be found on CD-ROM ISO images,
> so by supporting these files, it is now possible to boot directly
> when the TFTP server is set up with the contents of such an CD-ROM
> image.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  pc-bios/s390-ccw/netmain.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
> index fa62bfe..e52e17d 100644
> --- a/pc-bios/s390-ccw/netmain.c
> +++ b/pc-bios/s390-ccw/netmain.c
> @@ -441,6 +441,55 @@ static int net_try_pxelinux_cfgs(filename_ip_t *fn_ip)
>      return -1;
>  }
> 
> +/**
> + * Load via information from a .INS file (which can be found on CD-ROMs
> + * for example)
> + */
> +static int handle_ins_cfg(filename_ip_t *fn_ip, char *cfg, int cfgsize)
> +{
> +    char *ptr;
> +    int rc = -1, llen;
> +    void *destaddr;
> +    char *insbuf = cfg;
> +
> +    ptr = strchr(insbuf, '\n');
> +    if (!ptr) {
> +        puts("Does not seem to be a valid .INS file");
> +        return -1;
> +    }
> +
> +    *ptr = 0;
> +    printf("\nParsing .INS file:\n %s\n", &insbuf[2]);
> +
> +    insbuf = ptr + 1;
> +    while (*insbuf && insbuf < cfg + cfgsize) {
> +        ptr = strchr(insbuf, '\n');
> +        if (ptr) {
> +            *ptr = 0;
> +        }
> +        llen = strlen(insbuf);
> +        if (!llen) {
> +            insbuf = ptr + 1;
> +            continue;
> +        }
> +        ptr = strchr(insbuf, ' ');
> +        if (!ptr) {
> +            puts("Missing space separator in .INS file");
> +            return -1;
> +        }
> +        *ptr = 0;
> +        strncpy((char *)fn_ip->filename, insbuf, sizeof(fn_ip->filename));
> +        destaddr = (char *)atol(ptr + 1);
> +        rc = tftp_load(fn_ip, destaddr, (long)_start - (long)destaddr);
> +        if (rc <= 0) {
> +            break;
> +        }
> +        insbuf += llen + 1;
> +    }
> +
> +    return rc;
> +}
> +
>  static int net_try_direct_tftp_load(filename_ip_t *fn_ip)
>  {
>      int rc;
> @@ -455,6 +504,8 @@ static int net_try_direct_tftp_load(filename_ip_t *fn_ip)
>          if (!strncasecmp("default", cfgbuf, 7) || !strncmp("# ", cfgbuf, 2)) {
>              /* Looks like it is a pxelinux.cfg */
>              return handle_pxelinux_cfg(fn_ip, cfgbuf, rc);
> +        } else if (!strncmp("* ", cfgbuf, 2)) {
> +            return handle_ins_cfg(fn_ip, cfgbuf, rc);
>          }
>      }
> 
You could consider to move the magic matching code into a helper
function, I could imagine that the detection might grow more complex
over time and then could clutter the try-load code.
I.e. something like

typedef enum {
	FT_UNKOWN,
	FT_PXECFG,
	FT_INSFILE,
} FileType;

static FileType probe_file_type(const char * cfgbuf, size_t cfgbuflen)
{
        ...
        if (!strncasecmp("default", cfgbuf, 7) || !strncmp("# ",
                          cfgbuf, 2)) {
            /* Looks like it is a pxelinux.cfg */
            return FT_PXECFG;
        } else if (!strncmp("* ", cfgbuf, 2)) {
            return FT_INSFILE;
        } else {
	    return FT_UNKOWN;
        }
}

...
  FileType ft = probe_file_type(cfgbuf, ...);
  switch (ft)
  {
     case FT_PXECFG:
       return handle_pxelinux_cfg(fn_ip, cfgbuf, rc);
       break;
     ...
     case FT_UNKNOWN:
       /* got to be a kernel */
       memmove(...);
       return rc;
  }
...



-- 
Regards,
  Viktor Mihajlovski
