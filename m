Received: from eggs.gnu.org ([2001:4830:134:3::10]:40734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fTPv3-0007Hn-2w
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 06:55:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fTPuy-00013p-Vm
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 06:55:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51244)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fTPuy-00013A-Ns
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 06:55:52 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5EAnP9E013834
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 06:55:51 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jkpakhrf9-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 06:55:51 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 14 Jun 2018 11:55:48 +0100
References: <1528966108-28324-1-git-send-email-thuth@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 14 Jun 2018 12:55:45 +0200
MIME-Version: 1.0
In-Reply-To: <1528966108-28324-1-git-send-email-thuth@redhat.com>
Content-Language: en-US
Message-Id: <5b07c617-318d-53d5-46ee-8e4f3646cd79@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] pc-bios/s390-ccw: Optimize
 the s390-ccw bios for size
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


On 06/14/2018 10:48 AM, Thomas Huth wrote:
> Since we're storing the firmware blobs in the QEMU git repository, it
> would be nice if the blobs would be a little bit smaller. By using -Os
> and -fno-asynchronous-unwind-tables the size of the s390-ccw.img can be
> decreased by ca. 4kB, and the size of s390-netboot.img even by ca. 45kB.
> The change of speed of the firmware should not really matter compared to
> a binary that has been compiled with -O2 since the firmware still starts
> very fast.


> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  pc-bios/s390-ccw/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
> index 439e3cc..f22a5ca 100644
> --- a/pc-bios/s390-ccw/Makefile
> +++ b/pc-bios/s390-ccw/Makefile
> @@ -13,6 +13,7 @@ OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o \
>  	  virtio.o virtio-scsi.o virtio-blkdev.o libc.o
>  
>  QEMU_CFLAGS := $(filter -W%, $(QEMU_CFLAGS))
> +QEMU_CFLAGS += -Os -fno-asynchronous-unwind-tables

Hmm, it looks like that the O2 comes after Os for me (which would override Os).

cc -iquote /home/cborntra/REPOS/qemu/build/. -iquote . -iquote /home/cborntra/REPOS/qemu/tcg -iquote /home/cborntra/REPOS/qemu/tcg/s390 -I/home/cborntra/REPOS/qemu/linux-headers -I/home/cborntra/REPOS/qemu/build/linux-headers -iquote . -iquote /home/cborntra/REPOS/qemu -iquote /home/cborntra/REPOS/qemu/accel/tcg -iquote /home/cborntra/REPOS/qemu/include -Werror -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -Wexpansion-to-defined -Wendif-labels -Wno-shift-negative-value -Wno-missing-include-dirs -Wempty-body -Wnested-externs -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-style-declaration -Wold-style-definition -Wtype-limits -Os -fno-asynchronous-unwind-tables -ffreestanding -fno-delete-null-pointer-checks -msoft-float -march=z900 -fPIE -fno-strict-aliasing   -fno-stack-protector -MMD -MP -MT libc.o -MF ./libc.d -O2 -g  -c -o libc.o /home/cborntra/REPOS/qemu/pc-bios/s390-ccw/libc.c


so the effect is only because of the -fno-asynchronous-unwind-tables.



>  QEMU_CFLAGS += -ffreestanding -fno-delete-null-pointer-checks -msoft-float
>  QEMU_CFLAGS += -march=z900 -fPIE -fno-strict-aliasing
>  QEMU_CFLAGS += $(call cc-option, $(QEMU_CFLAGS), -fno-stack-protector)
> 
