Received: from eggs.gnu.org ([2001:4830:134:3::10]:58992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eGiE1-0005QC-K6
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 04:18:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eGiDy-0004gG-FS
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 04:18:45 -0500
References: <1510942228-22822-1-git-send-email-thuth@redhat.com>
	<b083a168-4743-46a7-d78c-78b86d300dbc@de.ibm.com>
	<b4f16003-a1ff-c5dd-dc06-c285929254ba@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e40a4f25-3384-f670-7cc9-ca6334213f1b@redhat.com>
Date: Mon, 20 Nov 2017 10:18:38 +0100
MIME-Version: 1.0
In-Reply-To: <b4f16003-a1ff-c5dd-dc06-c285929254ba@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org

On 20.11.2017 09:48, Christian Borntraeger wrote:
> Thomas,
> 
> does this patch help as well?
> 
> diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
> index 6d0c2ee..2687590 100644
> --- a/pc-bios/s390-ccw/Makefile
> +++ b/pc-bios/s390-ccw/Makefile
> @@ -12,7 +12,7 @@ $(call set-vpath, $(SRC_PATH)/pc-bios/s390-ccw)
>  OBJECTS = start.o main.o bootmap.o sclp.o virtio.o virtio-scsi.o virtio-blkdev.o
>  QEMU_CFLAGS := $(filter -W%, $(QEMU_CFLAGS))
>  QEMU_CFLAGS += -ffreestanding -fno-delete-null-pointer-checks -msoft-float
> -QEMU_CFLAGS += -march=z900 -fPIE -fno-strict-aliasing
> +QEMU_CFLAGS += -march=z900 -fPIE -fno-strict-aliasing -fno-zero-initialized-in-bss
>  QEMU_CFLAGS += $(call cc-option, $(QEMU_CFLAGS), -fno-stack-protector)
>  LDFLAGS += -Wl,-pie -nostdlib

No, that alone does not help, the default_scsi_device variable is still
in the normal .bss section in that case (you can also check that with
objdump for example). You'd have to apply this patch on top to fix it
that way:

diff --git a/pc-bios/s390-ccw/virtio-scsi.c b/pc-bios/s390-ccw/virtio-scsi.c
index c92f5d3..64ab095 100644
--- a/pc-bios/s390-ccw/virtio-scsi.c
+++ b/pc-bios/s390-ccw/virtio-scsi.c
@@ -15,7 +15,7 @@
 #include "scsi.h"
 #include "virtio-scsi.h"

-static ScsiDevice default_scsi_device;
+static ScsiDevice default_scsi_device = { 0 };
 static VirtioScsiCmdReq req;
 static VirtioScsiCmdResp resp;

... then the variable is in the .data section instead.

But since the problem with other uninitialized .bss variables is then
still pending, I think we should rather go with my patch for 2.11 and
fix future problems properly in v2.12 by initializing the complete .bss
to zero in the start.S file.

 Thomas
