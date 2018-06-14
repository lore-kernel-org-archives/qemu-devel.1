Received: from eggs.gnu.org ([2001:4830:134:3::10]:58245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fTSwU-0005o2-7M
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 10:09:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fTSwP-0004Zm-6d
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 10:09:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56736)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fTSwO-0004ZI-Tc
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 10:09:33 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5EE1FuR116831
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 10:09:31 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jkrhc5dp9-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 10:09:31 -0400
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 14 Jun 2018 15:04:10 +0100
References: <1528983995-16233-1-git-send-email-thuth@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 14 Jun 2018 16:04:06 +0200
MIME-Version: 1.0
In-Reply-To: <1528983995-16233-1-git-send-email-thuth@redhat.com>
Content-Language: en-US
Message-Id: <caa65014-bfd0-f4d8-c293-9d4c2f1b9a90@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2] pc-bios/s390-ccw: Optimize
 the s390-netboot.img for size
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



On 06/14/2018 03:46 PM, Thomas Huth wrote:
> The -O2 optimization flag is passed via CFLAGS to the firmware Makefile,
> but in netbook.mak, we've got some rules that only use QEMU_CFLAGS for
> compiling the libc and libnet from SLOF, so these files get compiled
> without optimization so far. Use CFLAGS here, too, to create faster
> and smaller code.
> 
> We can additionally save some more bytes in the firmware images by compi-
> ling the code with -fno-asynchronous-unwind-tables. This will omit some
> ELF sections (used for stack unwinding for example) from the image that
> we do not need in the firmware.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>


> ---
>  pc-bios/s390-ccw/Makefile    | 1 +
>  pc-bios/s390-ccw/netboot.mak | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
> index 439e3cc..1eb316b 100644
> --- a/pc-bios/s390-ccw/Makefile
> +++ b/pc-bios/s390-ccw/Makefile
> @@ -15,6 +15,7 @@ OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o \
>  QEMU_CFLAGS := $(filter -W%, $(QEMU_CFLAGS))
>  QEMU_CFLAGS += -ffreestanding -fno-delete-null-pointer-checks -msoft-float
>  QEMU_CFLAGS += -march=z900 -fPIE -fno-strict-aliasing
> +QEMU_CFLAGS += -fno-asynchronous-unwind-tables
>  QEMU_CFLAGS += $(call cc-option, $(QEMU_CFLAGS), -fno-stack-protector)
>  LDFLAGS += -Wl,-pie -nostdlib
>  
> diff --git a/pc-bios/s390-ccw/netboot.mak b/pc-bios/s390-ccw/netboot.mak
> index 8af0cfd..14e96b2 100644
> --- a/pc-bios/s390-ccw/netboot.mak
> +++ b/pc-bios/s390-ccw/netboot.mak
> @@ -19,7 +19,7 @@ s390-netboot.img: s390-netboot.elf
>  
>  # libc files:
>  
> -LIBC_CFLAGS :=  $(QEMU_CFLAGS) $(LIBC_INC) $(LIBNET_INC)
> +LIBC_CFLAGS :=  $(QEMU_CFLAGS) $(CFLAGS) $(LIBC_INC) $(LIBNET_INC)
>  
>  CTYPE_OBJS = isdigit.o isxdigit.o toupper.o
>  %.o : $(SLOF_DIR)/lib/libc/ctype/%.c
> @@ -52,7 +52,7 @@ libc.a: $(LIBCOBJS)
>  
>  LIBNETOBJS := args.o dhcp.o dns.o icmpv6.o ipv6.o tcp.o udp.o bootp.o \
>  	      dhcpv6.o ethernet.o ipv4.o ndp.o tftp.o pxelinux.o
> -LIBNETCFLAGS := $(QEMU_CFLAGS) -DDHCPARCH=0x1F $(LIBC_INC) $(LIBNET_INC)
> +LIBNETCFLAGS := $(QEMU_CFLAGS) $(CFLAGS) -DDHCPARCH=0x1F $(LIBC_INC) $(LIBNET_INC)
>  
>  %.o : $(SLOF_DIR)/lib/libnet/%.c
>  	$(call quiet-command,$(CC) $(LIBNETCFLAGS) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
> 
