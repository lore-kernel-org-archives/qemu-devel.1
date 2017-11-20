Received: from eggs.gnu.org ([2001:4830:134:3::10]:59953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eGiGH-0006uF-4U
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 04:21:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eGiGE-0005j6-0i
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 04:21:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eGiGD-0005hs-Mm
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 04:21:01 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAK9IvJw123992
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 04:20:52 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ebtc9f705-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 04:20:52 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 20 Nov 2017 09:20:49 -0000
References: <1510942228-22822-1-git-send-email-thuth@redhat.com>
	<b083a168-4743-46a7-d78c-78b86d300dbc@de.ibm.com>
	<b4f16003-a1ff-c5dd-dc06-c285929254ba@de.ibm.com>
	<e40a4f25-3384-f670-7cc9-ca6334213f1b@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 20 Nov 2017 10:20:46 +0100
MIME-Version: 1.0
In-Reply-To: <e40a4f25-3384-f670-7cc9-ca6334213f1b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <08016a8f-1310-d596-8c32-ec1702df5a78@de.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH for-2.11] pc-bios/s390-ccw:
 Fix problem with invalid virtio-scsi LUN when rebooting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org



On 11/20/2017 10:18 AM, Thomas Huth wrote:
> On 20.11.2017 09:48, Christian Borntraeger wrote:
>> Thomas,
>>
>> does this patch help as well?
>>
>> diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
>> index 6d0c2ee..2687590 100644
>> --- a/pc-bios/s390-ccw/Makefile
>> +++ b/pc-bios/s390-ccw/Makefile
>> @@ -12,7 +12,7 @@ $(call set-vpath, $(SRC_PATH)/pc-bios/s390-ccw)
>>  OBJECTS = start.o main.o bootmap.o sclp.o virtio.o virtio-scsi.o virtio-blkdev.o
>>  QEMU_CFLAGS := $(filter -W%, $(QEMU_CFLAGS))
>>  QEMU_CFLAGS += -ffreestanding -fno-delete-null-pointer-checks -msoft-float
>> -QEMU_CFLAGS += -march=z900 -fPIE -fno-strict-aliasing
>> +QEMU_CFLAGS += -march=z900 -fPIE -fno-strict-aliasing -fno-zero-initialized-in-bss
>>  QEMU_CFLAGS += $(call cc-option, $(QEMU_CFLAGS), -fno-stack-protector)
>>  LDFLAGS += -Wl,-pie -nostdlib
> 
> No, that alone does not help, the default_scsi_device variable is still
> in the normal .bss section in that case (you can also check that with
> objdump for example). You'd have to apply this patch on top to fix it
> that way:
> 
> diff --git a/pc-bios/s390-ccw/virtio-scsi.c b/pc-bios/s390-ccw/virtio-scsi.c
> index c92f5d3..64ab095 100644
> --- a/pc-bios/s390-ccw/virtio-scsi.c
> +++ b/pc-bios/s390-ccw/virtio-scsi.c
> @@ -15,7 +15,7 @@
>  #include "scsi.h"
>  #include "virtio-scsi.h"
> 
> -static ScsiDevice default_scsi_device;
> +static ScsiDevice default_scsi_device = { 0 };
>  static VirtioScsiCmdReq req;
>  static VirtioScsiCmdResp resp;
> 
> ... then the variable is in the .data section instead.
> 
> But since the problem with other uninitialized .bss variables is then
> still pending, I think we should rather go with my patch for 2.11 and
> fix future problems properly in v2.12 by initializing the complete .bss
> to zero in the start.S file.

Yes. Ack.
> 
>  Thomas
> 
