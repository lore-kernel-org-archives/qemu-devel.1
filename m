Received: from eggs.gnu.org ([2001:4830:134:3::10]:50215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fSHaJ-0002EQ-8D
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 03:49:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fSHaG-0003HF-5p
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 03:49:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53240
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fSHaG-0003H5-0T
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 03:49:48 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5B7mqFE168718
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 03:49:46 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2jhkm244cr-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 03:49:46 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 11 Jun 2018 08:49:44 +0100
References: <1528636325-4237-1-git-send-email-thuth@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 11 Jun 2018 09:49:39 +0200
MIME-Version: 1.0
In-Reply-To: <1528636325-4237-1-git-send-email-thuth@redhat.com>
Content-Language: en-US
Message-Id: <3a7d6318-c827-3aa3-2799-7e383132beb3@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/s390x/ipl: Fix crash that occurs when
 -kernel is used with small images
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



On 06/10/2018 03:12 PM, Thomas Huth wrote:
> Add a sanity check to fix the following crash:
> 
> $ echo "Insane in the mainframe" > /tmp/test.txt
> $ s390x-softmmu/qemu-system-s390x -nographic -kernel /tmp/test.txt
> Segmentation fault (core dumped)
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

I think a similar problem exists for INITRD_PARM_START and INITRD_PARM_SIZE. No?


> ---
>  hw/s390x/ipl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 04245b5..9bb9b50 100644
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
> 
