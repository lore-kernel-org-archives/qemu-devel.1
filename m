Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E117C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:07:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A844214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWm2+pIQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A844214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVGn-0007Ea-C7
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:07:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57189)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV3n-0005l6-QC
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV3m-0007Ks-2w
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:53:59 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:39652)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV3l-0007Iq-QV
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:53:57 -0500
Received: by mail-wm1-x331.google.com with SMTP id c84so3550817wme.4
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=X2lfVM7ckKSwoX89GxD0295PFR6/+IbeOu9As0+XJQM=;
 b=oWm2+pIQQcFTSSeShwv8uzWCDUNO6kSTpLxhXHRvM2tCIQDaQCr/xZjJHtr3x5y7v1
 bxAYI03TFjTgSCSPD967uUGEgl/HJmMnB69Rp4OuJyokbqdYTYkYJQvmoGBeS7cYd+D2
 Yese4tJzb0+xoNGB3PpSGYQLvSg3fRrTb+bdXbfXtNW3RqAQ494DtBqdtL/RaMo/J6yh
 giSijEzh02ZqqibOyOtjbn03B+ap0OnI9ea9+HCyzZhluF7mQxz0+O58QiQll5fZ8Q8P
 5/rPtrBHWlXdbK+S/k8G2xSU0j2Al7JjMkjrkTV4pJ6x7hM68UAZ4Mo13Rs9mBiIJz2u
 FXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=X2lfVM7ckKSwoX89GxD0295PFR6/+IbeOu9As0+XJQM=;
 b=gTY1lt6Fj85n9h4Q+fkUwDNcx3yiLBSbD7w8/ZuC60AXQNex80SnoPiB5P7jtw2t3z
 9ZKRHOhzjrL6mQVu/JM94G5Bpzjy/Xmr+WrJNhvu2ZMSHJOngJUbrVtcBDgpFJGzyCfM
 vIs9THdYKM8pv77G0sn5Gbdj+yEjTiERJ4x5ExC6Q6ICLeegUwcFjP0ktFODBqV9aYSY
 ZkAt6/DsCBaccI6oliVHlxTseO/42AMw0HRFBhH2mOfq1Plon4fcvWL1OKC9mGjN4uCa
 CKT/Y/xbvaAWFIg6W2ULljloeKuMBucr0SBGybXU33sjThdb7/NlCLklPJF02sm7Cj4F
 vejA==
X-Gm-Message-State: APjAAAWELTAbwcHXIJRr5HDOX/cbF2OMHo9r4+sZ/wbyyQX4W1GQ/hOG
 tCmZgu4bYNxDieAnR2MNVkBac8+/
X-Google-Smtp-Source: APXvYqxVsjDLrl7K+IuIRqAIV0+snXiz3jQDQdH5BrTVk4PpENLqKJW5cTkxK/uDfTFcAuQcZLPxqQ==
X-Received: by 2002:a1c:1b4d:: with SMTP id b74mr6505267wmb.33.1580234036536; 
 Tue, 28 Jan 2020 09:53:56 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.53.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:53:56 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 003/142] pc-bios/s390-ccw: simplify Makefile
Date: Tue, 28 Jan 2020 18:51:23 +0100
Message-Id: <20200128175342.9066-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make it independent from the rules.mak, and clean up to use pattern rules.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 pc-bios/s390-ccw/Makefile    | 103 ++++++++++++++++++++++++++++-------
 pc-bios/s390-ccw/netboot.mak |  61 ---------------------
 2 files changed, 82 insertions(+), 82 deletions(-)
 delete mode 100644 pc-bios/s390-ccw/netboot.mak

diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index a048b6b077..b512074e3a 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -1,42 +1,103 @@
-all: build-all
+CURRENT_MAKEFILE := $(realpath $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST)))
+SRC_DIR := $(dir $(CURRENT_MAKEFILE))
+TOPSRC_DIR := $(SRC_DIR)/../..
+VPATH = $(SRC_DIR)
+
+all:
 # Dummy command so that make thinks it has done something
 	@true
 
 include ../../config-host.mak
-include $(SRC_PATH)/rules.mak
 
-$(call set-vpath, $(SRC_PATH)/pc-bios/s390-ccw)
+quiet-command = $(if $(V),$1,$(if $(2),@printf "  %-7s %s\n" $2 $3 && $1, @$1))
+cc-option = $(if $(shell $(CC) $1 -S -o /dev/null -xc /dev/null >/dev/null 2>&1 && echo OK), $1, $2)
 
-.PHONY : all clean build-all
+override CFLAGS += $(filter -W%, $(QEMU_CFLAGS))
+override CFLAGS += -ffreestanding -fno-delete-null-pointer-checks -msoft-float
+override CFLAGS += -march=z900 -fPIE -fno-strict-aliasing
+override CFLAGS += -fno-asynchronous-unwind-tables
+override CFLAGS += $(call cc-option, -fno-stack-protector)
+LDFLAGS += -Wl,-pie -nostdlib
 
 OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o \
 	  virtio.o virtio-scsi.o virtio-blkdev.o libc.o cio.o dasd-ipl.o
 
-QEMU_CFLAGS := $(filter -W%, $(QEMU_CFLAGS))
-QEMU_CFLAGS += -ffreestanding -fno-delete-null-pointer-checks -msoft-float
-QEMU_CFLAGS += -march=z900 -fPIE -fno-strict-aliasing
-QEMU_CFLAGS += -fno-asynchronous-unwind-tables
-QEMU_CFLAGS += $(call cc-option, $(QEMU_CFLAGS), -fno-stack-protector)
-LDFLAGS += -Wl,-pie -nostdlib
+STRIP ?= strip
 
-build-all: s390-ccw.img s390-netboot.img
+$(OBJECTS): Makefile
 
-s390-ccw.elf: $(OBJECTS)
-	$(call quiet-command,$(CC) $(LDFLAGS) -o $@ $(OBJECTS),"BUILD","$(TARGET_DIR)$@")
+SLOF_DIR := $(SRC_PATH)/roms/SLOF
 
-STRIP ?= strip
+NETOBJS := start.o sclp.o cio.o virtio.o virtio-net.o jump2ipl.o netmain.o \
+	   libnet.a libc.a
 
-s390-ccw.img: s390-ccw.elf
+LIBC_INC := -nostdinc -I$(SLOF_DIR)/lib/libc/include
+LIBNET_INC := -I$(SLOF_DIR)/lib/libnet
+
+$(NETOBJS): QEMU_CFLAGS += $(LIBC_INC) $(LIBNET_INC)
+
+# libc files:
+
+LIBC_CFLAGS :=  $(QEMU_CFLAGS) $(CFLAGS) $(LIBC_INC) $(LIBNET_INC)
+
+CTYPE_OBJS = isdigit.o isxdigit.o toupper.o
+$(CTYPE_OBJS) : %.o : $(SLOF_DIR)/lib/libc/ctype/%.c
+	$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
+
+STRING_OBJS = strcat.o strchr.o strrchr.o strcpy.o strlen.o strncpy.o \
+	      strcmp.o strncmp.o strcasecmp.o strncasecmp.o strstr.o \
+	      memset.o memcpy.o memmove.o memcmp.o
+$(STRING_OBJS) : %.o : $(SLOF_DIR)/lib/libc/string/%.c
+	$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
+
+STDLIB_OBJS = atoi.o atol.o strtoul.o strtol.o rand.o malloc.o free.o
+$(STDLIB_OBJS) : %.o : $(SLOF_DIR)/lib/libc/stdlib/%.c
+	$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
+
+STDIO_OBJS = sprintf.o snprintf.o vfprintf.o vsnprintf.o vsprintf.o fprintf.o \
+	     printf.o putc.o puts.o putchar.o stdchnls.o fileno.o
+$(STDIO_OBJS) : %.o : $(SLOF_DIR)/lib/libc/stdio/%.c
+	$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
+
+sbrk.o: $(SLOF_DIR)/slof/sbrk.c
+	$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
+
+LIBCOBJS := $(STRING_OBJS) $(CTYPE_OBJS) $(STDLIB_OBJS) $(STDIO_OBJS) sbrk.o
+
+libc.a: $(LIBCOBJS)
+	$(call quiet-command,$(AR) -rc $@ $^,"AR","$(TARGET_DIR)$@")
+
+# libnet files:
+
+LIBNETOBJS := args.o dhcp.o dns.o icmpv6.o ipv6.o tcp.o udp.o bootp.o \
+	      dhcpv6.o ethernet.o ipv4.o ndp.o tftp.o pxelinux.o
+LIBNETCFLAGS := $(CFLAGS) -DDHCPARCH=0x1F $(LIBC_INC) $(LIBNET_INC)
+
+$(LIBNETOBJS) : %.o : $(SLOF_DIR)/lib/libnet/%.c
+	$(call quiet-command,$(CC) $(LIBNETCFLAGS) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
+
+libnet.a: $(LIBNETOBJS)
+	$(call quiet-command,$(AR) -rc $@ $^,"AR","$(TARGET_DIR)$@")
+
+%.elf:
+	$(call quiet-command,$(CC) $(LDFLAGS) -o $@ $^,"BUILD","$(TARGET_DIR)$@")
+
+%.img: %.elf
 	$(call quiet-command,$(STRIP) --strip-unneeded $< -o $@,"STRIP","$(TARGET_DIR)$@")
 
-$(OBJECTS): Makefile
+s390-ccw.elf: $(OBJECTS)
+s390-ccw.img: s390-ccw.elf
+all: s390-ccw.img
+
+ifneq ($(wildcard $(SLOF_DIR)/lib/libnet),)
+s390-netboot.elf: $(NETOBJS)
+s390-netboot.elf: LDFLAGS += -Ttext=0x7800000
 
-ifneq ($(wildcard $(SRC_PATH)/roms/SLOF/lib/libnet),)
-include $(SRC_PATH)/pc-bios/s390-ccw/netboot.mak
-else
-s390-netboot.img:
-	@echo "s390-netboot.img not built since roms/SLOF/ is not available."
+s390-netboot.img: s390-netboot.elf
+all: s390-netboot.img
 endif
 
 clean:
 	rm -f *.o *.d *.img *.elf *~ *.a
+
+.PHONY : all clean
diff --git a/pc-bios/s390-ccw/netboot.mak b/pc-bios/s390-ccw/netboot.mak
deleted file mode 100644
index 5eefb7c289..0000000000
--- a/pc-bios/s390-ccw/netboot.mak
+++ /dev/null
@@ -1,61 +0,0 @@
-
-SLOF_DIR := $(SRC_PATH)/roms/SLOF
-
-NETOBJS := start.o sclp.o cio.o virtio.o virtio-net.o jump2ipl.o netmain.o \
-	   libnet.a libc.a
-
-LIBC_INC := -nostdinc -I$(SLOF_DIR)/lib/libc/include
-LIBNET_INC := -I$(SLOF_DIR)/lib/libnet
-
-NETLDFLAGS := $(LDFLAGS) -Ttext=0x7800000
-
-$(NETOBJS): QEMU_CFLAGS += $(LIBC_INC) $(LIBNET_INC)
-
-s390-netboot.elf: $(NETOBJS)
-	$(call quiet-command,$(CC) $(NETLDFLAGS) -o $@ $(NETOBJS),"BUILD","$(TARGET_DIR)$@")
-
-s390-netboot.img: s390-netboot.elf
-	$(call quiet-command,$(STRIP) --strip-unneeded $< -o $@,"STRIP","$(TARGET_DIR)$@")
-
-# libc files:
-
-LIBC_CFLAGS :=  $(QEMU_CFLAGS) $(CFLAGS) $(LIBC_INC) $(LIBNET_INC)
-
-CTYPE_OBJS = isdigit.o isxdigit.o toupper.o
-%.o : $(SLOF_DIR)/lib/libc/ctype/%.c
-	$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
-
-STRING_OBJS = strcat.o strchr.o strrchr.o strcpy.o strlen.o strncpy.o \
-	      strcmp.o strncmp.o strcasecmp.o strncasecmp.o strstr.o \
-	      memset.o memcpy.o memmove.o memcmp.o
-%.o : $(SLOF_DIR)/lib/libc/string/%.c
-	$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
-
-STDLIB_OBJS = atoi.o atol.o strtoul.o strtol.o rand.o malloc.o free.o
-%.o : $(SLOF_DIR)/lib/libc/stdlib/%.c
-	$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
-
-STDIO_OBJS = sprintf.o snprintf.o vfprintf.o vsnprintf.o vsprintf.o fprintf.o \
-	     printf.o putc.o puts.o putchar.o stdchnls.o fileno.o
-%.o : $(SLOF_DIR)/lib/libc/stdio/%.c
-	$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
-
-sbrk.o: $(SLOF_DIR)/slof/sbrk.c
-	$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
-
-LIBCOBJS := $(STRING_OBJS) $(CTYPE_OBJS) $(STDLIB_OBJS) $(STDIO_OBJS) sbrk.o
-
-libc.a: $(LIBCOBJS)
-	$(call quiet-command,$(AR) -rc $@ $^,"AR","$(TARGET_DIR)$@")
-
-# libnet files:
-
-LIBNETOBJS := args.o dhcp.o dns.o icmpv6.o ipv6.o tcp.o udp.o bootp.o \
-	      dhcpv6.o ethernet.o ipv4.o ndp.o tftp.o pxelinux.o
-LIBNETCFLAGS := $(QEMU_CFLAGS) $(CFLAGS) -DDHCPARCH=0x1F $(LIBC_INC) $(LIBNET_INC)
-
-%.o : $(SLOF_DIR)/lib/libnet/%.c
-	$(call quiet-command,$(CC) $(LIBNETCFLAGS) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
-
-libnet.a: $(LIBNETOBJS)
-	$(call quiet-command,$(AR) -rc $@ $^,"AR","$(TARGET_DIR)$@")
-- 
2.21.0



