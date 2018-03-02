Received: from eggs.gnu.org ([2001:4830:134:3::10]:42597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ergPL-000853-2Y
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 03:51:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ergPG-0003cv-2V
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 03:51:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40572
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ergPF-0003cI-SW
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 03:51:09 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w228naME040228
	for <qemu-devel@nongnu.org>; Fri, 2 Mar 2018 03:51:07 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gexd62dq6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 03:51:07 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 2 Mar 2018 08:51:06 -0000
References: <1519760121-24594-1-git-send-email-walling@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 2 Mar 2018 09:51:03 +0100
MIME-Version: 1.0
In-Reply-To: <1519760121-24594-1-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <dfc713d2-6c97-c009-c1b0-c58ada85b686@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2] s390/ipl: only print boot menu error if
 -boot menu=on was specified
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: cohuck@redhat.com, thuth@redhat.com, mihajlov@linux.vnet.ibm.com

On 02/27/2018 08:35 PM, Collin L. Walling wrote:
> It is possible that certain QEMU configurations may not
> create an IPLB (such as when -kernel is provided). In
> this case, a misleading error message will be printed
> stating that the "boot menu is not supported for this
> device type".
> 
> To amend this, only print this message iff boot menu=on
> was provided on the commandline. Otherwise, return silently.
> 
> While we're at it, remove trailing periods from error
> messages.
> 
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>

This also Fixes qemu iotest 200.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>


> ---
>  hw/s390x/ipl.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 798e99a..d7fb33f 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -234,7 +234,7 @@ static void s390_ipl_set_boot_menu(S390IPLState *ipl)
>      if (!get_boot_device(0)) {
>          if (boot_menu) {
>              error_report("boot menu requires a bootindex to be specified for "
> -                         "the IPL device.");
> +                         "the IPL device");
>          }
>          return;
>      }
> @@ -250,7 +250,9 @@ static void s390_ipl_set_boot_menu(S390IPLState *ipl)
>      case S390_IPL_TYPE_QEMU_SCSI:
>          break;
>      default:
> -        error_report("boot menu is not supported for this device type.");
> +        if (boot_menu) {
> +            error_report("boot menu is not supported for this device type");
> +        }
>          return;
>      }
> 
> @@ -263,13 +265,13 @@ static void s390_ipl_set_boot_menu(S390IPLState *ipl)
>      tmp = qemu_opt_get(opts, "splash-time");
> 
>      if (tmp && qemu_strtoul(tmp, NULL, 10, &splash_time)) {
> -        error_report("splash-time is invalid, forcing it to 0.");
> +        error_report("splash-time is invalid, forcing it to 0");
>          *timeout = 0;
>          return;
>      }
> 
>      if (splash_time > 0xffffffff) {
> -        error_report("splash-time is too large, forcing it to max value.");
> +        error_report("splash-time is too large, forcing it to max value");
>          *timeout = 0xffffffff;
>          return;
>      }
> 
