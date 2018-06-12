Received: from eggs.gnu.org ([2001:4830:134:3::10]:41796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fSdre-0002Xn-TS
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 03:37:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fSdrb-00056O-Od
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 03:37:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fSdrb-00055m-FE
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 03:37:11 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5C7YRnU056879
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 03:37:10 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jj726q7ev-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 03:37:09 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 12 Jun 2018 08:37:07 +0100
References: <1528738007-29122-1-git-send-email-thuth@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 12 Jun 2018 09:37:02 +0200
MIME-Version: 1.0
In-Reply-To: <1528738007-29122-1-git-send-email-thuth@redhat.com>
Content-Language: en-US
Message-Id: <612e28bf-b9de-4750-4953-abaa84595e10@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2] hw/s390x/ipl: Fix crashes
 that occurs when -kernel is used with small images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org



On 06/11/2018 07:26 PM, Thomas Huth wrote:
> Add a sanity checks to fix the following two crashes:
> 
> $ echo "Insane in the mainframe" > /tmp/test.txt
> $ s390x-softmmu/qemu-system-s390x -kernel /tmp/test.txt -append xyz
> Segmentation fault (core dumped)
> $ s390x-softmmu/qemu-system-s390x -kernel /tmp/test.txt -initrd /tmp/test.txt
> Segmentation fault (core dumped)
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  v2: Fixed 2nd crash with -initrd
> 
>  hw/s390x/ipl.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 04245b5..2ff8f20 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -168,7 +168,8 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
>           * we can not rely on the ELF entry point - it was 0x800 (the SALIPL
>           * loader) and it won't work. For this case we force it to 0x10000, too.
>           */
> -        if (pentry == KERN_IMAGE_START || pentry == 0x800) {
> +        if ((pentry == KERN_IMAGE_START || pentry == 0x800) &&
> +            kernel_size > KERN_PARM_AREA + strlen(ipl->cmdline)) {
>              ipl->start_addr = KERN_IMAGE_START;
>              /* Overwrite parameters in the kernel image, which are "rom" */
>              strcpy(rom_ptr(KERN_PARM_AREA), ipl->cmdline);
> @@ -195,8 +196,10 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
>               * we have to overwrite values in the kernel image,
>               * which are "rom"
>               */
> -            stq_p(rom_ptr(INITRD_PARM_START), initrd_offset);
> -            stq_p(rom_ptr(INITRD_PARM_SIZE), initrd_size);
> +            if (kernel_size > INITRD_PARM_SIZE + 8) {
> +                stq_p(rom_ptr(INITRD_PARM_START), initrd_offset);
> +                stq_p(rom_ptr(INITRD_PARM_SIZE), initrd_size);
> +            }
>          }
>      }
>      /*
> 
