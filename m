Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92820C4BA10
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:32:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60A352467B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="be8aeyCU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A352467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6uvB-0002Uw-9m
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 06:32:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52669)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6utp-0000gY-0X
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:30:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6utn-00066s-JC
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:30:44 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54018)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6utm-000609-C2
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:30:42 -0500
Received: by mail-wm1-x342.google.com with SMTP id f15so1834072wml.3
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 03:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9vFKkNLhQuGCjnHJQckdqqH/bXoxAWdSnwcFBUn62QY=;
 b=be8aeyCUF1+it0fe6CuVHQ1u96A74+ppL18ft0VxaeOQ7O5C6Onkx0K1FDnDtwt8je
 PAq6lnx/jYVxIQcGABBqTG25kZLQ71sc9m5+AZHxYleZP7ItJDP35aQo1LKHd0laz8hL
 +DSFo5xDM+y5hQWCQGeKBFMYmjMF6tMs/B2HEiYpDiiyRONB4UeqsxuDUTkTVigijR8H
 VfwHdgjttm9R3Ew9CH+T9w/vClpS14XFa0Qr76vfM7b6frTo/djJwy6qKtOlACwIIlpz
 8xalKqzhkv22ATZoT7ACu9/+8JIoe6ToK0BO74z/gRRBY6rVET6Vd2fMEo65afeo45ac
 /2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=9vFKkNLhQuGCjnHJQckdqqH/bXoxAWdSnwcFBUn62QY=;
 b=rBJxTPTlac9HMdcj1lEUZ1bICBb+cr35xxCYwQfJ9R/hrHobe1gqn1ZhhqTwmyXW9n
 DqgR4C/c/gqZCcbVmougBvLQ+zmwVUEKToJTc4ovtwQXw16CVxVnC0m6gN1STjzHer0+
 e3EqBhd3KhL/Ozs0i0+c2GEjpLm0Kalx462YUN7vqBWZqOE8054jJbNbn1EvTbBX4te3
 cTX1SmukDP78XuOL1hi1NOx9reN/+eXxM/hihfe1GJgGGBr6b+Y105qF322B0SiFWJcx
 LsoyyYaLBkvDyNW/g1zXNCOHgh21Ei6eWr2BInpXJ64QA/wOEayOygl80wZjRwxkPlNg
 fJWw==
X-Gm-Message-State: APjAAAWp7abU/dnTrs0TCA6HBBYMf/lHwCvuVLjK2NkOqo17h+gCbzpL
 KmMpJCuN+7t4KPHxNAXK32PUrgmy
X-Google-Smtp-Source: APXvYqw5ZYY/RgNDFLVoWZaxEoqNWuxWHGbbEOgb8ZdSHmZmcAs+UMwRJ+fP19i1Onk2yJ52SFO2WQ==
X-Received: by 2002:a7b:c957:: with SMTP id i23mr5224395wml.174.1582716640835; 
 Wed, 26 Feb 2020 03:30:40 -0800 (PST)
Received: from donizetti.lan ([2001:b07:6468:f312:d0d9:ea10:9775:f33f])
 by smtp.gmail.com with ESMTPSA id h128sm2628154wmh.33.2020.02.26.03.30.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 03:30:40 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/18] qemu-doc: extract common system emulator documentation
 from the PC section
Date: Wed, 26 Feb 2020 12:30:22 +0100
Message-Id: <20200226113034.6741-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200226113034.6741-1-pbonzini@redhat.com>
References: <20200226113034.6741-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move the section on PC peripherals together with other targets.
While some x86-specific information remains in the main system
emulation chapter, it can be tackled more easily a section at a
time.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/system/quickstart.texi |   2 +-
 qemu-doc.texi               | 102 ++++++++++++++++++++----------------
 2 files changed, 57 insertions(+), 47 deletions(-)

diff --git a/docs/system/quickstart.texi b/docs/system/quickstart.texi
index 8cd5b4bc6e..ed7295de7a 100644
--- a/docs/system/quickstart.texi
+++ b/docs/system/quickstart.texi
@@ -2,7 +2,7 @@
 @section Quick Start
 @cindex quick start
 
-Download and uncompress a hard disk image with Linux installed (e.g.
+Download and uncompress a PC hard disk image with Linux installed (e.g.
 @file{linux.img}) and type:
 
 @example
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 33d24caf94..88e84300e9 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -36,8 +36,8 @@
 
 @menu
 * Introduction::
-* QEMU PC System emulator::
-* QEMU System emulator for non PC targets::
+* QEMU System emulator::
+* QEMU System emulator targets::
 * System requirements::
 * Security::
 * Implementation notes::
@@ -127,19 +127,16 @@ accelerator is required to use more than one host CPU for emulation.
 
 @end itemize
 
-
-@node QEMU PC System emulator
-@chapter QEMU PC System emulator
-@cindex system emulation (PC)
+@node QEMU System emulator
+@chapter QEMU System emulator
+@cindex system emulation
 
 @menu
-* pcsys_introduction:: Introduction
-* pcsys_quickstart::   Quick Start
+* pcsys_quickstart::   Quick start
 * sec_invocation::     Invocation
 * pcsys_keys::         Keys in the graphical frontends
 * mux_keys::           Keys in the character backend multiplexer
 * pcsys_monitor::      QEMU Monitor
-* cpu_models_x86::     Supported CPU model configurations on x86 hosts
 * disk_images::        Disk Images
 * pcsys_network::      Network emulation
 * pcsys_usb::          USB emulation
@@ -150,13 +147,57 @@ accelerator is required to use more than one host CPU for emulation.
 * gdb_usage::          GDB usage
 @end menu
 
-@node pcsys_introduction
-@section Introduction
+@include docs/system/quickstart.texi
+@include docs/system/invocation.texi
+@include docs/system/keys.texi
+@include docs/system/mux-chardev.texi
+@include docs/system/monitor.texi
+@include docs/system/images.texi
+@include docs/system/net.texi
+@include docs/system/usb.texi
+@include docs/system/ivshmem.texi
+@include docs/system/linuxboot.texi
+@include docs/system/vnc-security.texi
+@include docs/system/tls.texi
+@include docs/system/gdb.texi
+
+@node QEMU System emulator targets
+@chapter QEMU System emulator targets
+@cindex system emulation (PC)
+
+QEMU is a generic emulator and it emulates many machines. Most of the
+options are similar for all machines. Specific information about the
+various targets are mentioned in the following sections.
+
+@menu
+* x86 (PC) System emulator::
+* PowerPC System emulator::
+* Sparc32 System emulator::
+* Sparc64 System emulator::
+* MIPS System emulator::
+* ARM System emulator::
+* ColdFire System emulator::
+* Cris System emulator::
+* Microblaze System emulator::
+* SH4 System emulator::
+* Xtensa System emulator::
+@end menu
+
+@node x86 (PC) System emulator
+@section x86 (PC) System emulator
+@cindex system emulation (PC)
+
+@menu
+* pcsys_devices::      Peripherals
+* cpu_models_x86::     Supported CPU model configurations on x86 hosts
+@end menu
+
+@node pcsys_devices
+@subsection Peripherals
 
 @c man begin DESCRIPTION
 
-The QEMU PC System emulator simulates the
-following peripherals:
+The QEMU PC System emulator simulates the following peripherals:
 
 @itemize @minus
 @item
@@ -222,40 +263,9 @@ CS4231A is the chip used in Windows Sound System and GUSMAX products
 
 @c man end
 
-@include docs/system/quickstart.texi
-@include docs/system/invocation.texi
-@include docs/system/keys.texi
-@include docs/system/mux-chardev.texi
-@include docs/system/monitor.texi
+@lowersections
 @include docs/system/cpu-models-x86.texi
-@include docs/system/images.texi
-@include docs/system/net.texi
-@include docs/system/usb.texi
-@include docs/system/ivshmem.texi
-@include docs/system/linuxboot.texi
-@include docs/system/vnc-security.texi
-@include docs/system/tls.texi
-@include docs/system/gdb.texi
-
-@node QEMU System emulator for non PC targets
-@chapter QEMU System emulator for non PC targets
-
-QEMU is a generic emulator and it emulates many non PC
-machines. Most of the options are similar to the PC emulator. The
-differences are mentioned in the following sections.
-
-@menu
-* PowerPC System emulator::
-* Sparc32 System emulator::
-* Sparc64 System emulator::
-* MIPS System emulator::
-* ARM System emulator::
-* ColdFire System emulator::
-* Cris System emulator::
-* Microblaze System emulator::
-* SH4 System emulator::
-* Xtensa System emulator::
-@end menu
+@raisesections
 
 @node PowerPC System emulator
 @section PowerPC System emulator
-- 
2.21.1



