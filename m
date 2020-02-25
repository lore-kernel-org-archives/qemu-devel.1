Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610D1C35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 16:41:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DABB20732
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 16:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERS8oZ0a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DABB20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6dGu-00026H-Dw
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 11:41:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42783)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6dDl-0005xq-Bh
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:38:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6dDj-0004NR-Te
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:38:09 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45537)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6dDj-0004MV-NY
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:38:07 -0500
Received: by mail-wr1-x442.google.com with SMTP id g3so15468751wrs.12
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 08:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=33klGj+MaqDBW8JE316uDTQOxPupHP/ixtndYnSVbss=;
 b=ERS8oZ0aoeXqGU9Lv2Peo9wy5f5RGbESSWr63i5fm14+tLYa9hGEyAVqdFCeIXZb99
 INiMoSHi/ORGzXAJWUveNPrPFhnNHuVmyUI6DSAYRP/B6LBnuzxH+O+fIyE7jH5EdfSm
 C3ieQa7DaU/tCD+iDCV5ld/zJJGHBT3H8XKSBDYvO9GoUcjM62gLF5CTBv8OY/zTx+dN
 Cq6BFxHbSwIiMUVDTAZNeYlhezRzI3sM3kSxpVT9adcVOyHb6GtNH6/IRJxVfCZFmW5Y
 FLdXVzZ8+ebxV5zW133iHerRx5UX1YxG3gcvk4D6o/VTEDlnBu2IfGlKoD/Ow9yXDkMy
 JO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=33klGj+MaqDBW8JE316uDTQOxPupHP/ixtndYnSVbss=;
 b=BlmfQiw15htdS0wI/SpzhEtjgoQtkN6iSmjjEgk1xesQ0ffuQk2jggc/8mwJxuvRBh
 vhH6Tf/oRqzeBJ/lySUB6uwdDOHoixiK5hhLRiaxhK5ASzrZ9/CEiH53TdVWRCTimuf2
 s1JU/bFBML44XjG04Rb+uJn6+OYxbGdCJDO+eNeBEjr9H6B6XPuJ9guGl/DIwcjYSKmk
 2UV9vxR42YktSCkOKrruKqtulwBxUBk/fgXDvUEUq3LoQTfahjjjCRq/a20+jvBJh/WQ
 enk0N/CZmh5Yiq2OeZ7FldnRPAhyhxYvuJnqp8LEk/CXEFFJiRUOU9DnZMKh8sb99OKN
 ejdw==
X-Gm-Message-State: APjAAAVUbCEbki5bC40uRFQRiu0goDquiM+VlDj7zuKV6TTWE0D3VkYV
 9P5GQ7ROO6c92hwQ4MQ5q+2kGXsI
X-Google-Smtp-Source: APXvYqyPtjUKriSSwaLkX+QCZ+zfGL/1mgLwTIzZt0t0TpyDWi1a2NA3ZHoiWDnLBMfneJTD3JiCOw==
X-Received: by 2002:adf:f787:: with SMTP id q7mr74031045wrp.297.1582648683289; 
 Tue, 25 Feb 2020 08:38:03 -0800 (PST)
Received: from donizetti.lan ([2001:b07:6468:f312:3577:1cfe:d98a:5fb6])
 by smtp.gmail.com with ESMTPSA id q6sm18171398wrf.67.2020.02.25.08.38.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 08:38:02 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] qemu-doc: extract common system emulator documentation
 from the PC section
Date: Tue, 25 Feb 2020 17:37:58 +0100
Message-Id: <20200225163758.12996-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200225163758.12996-1-pbonzini@redhat.com>
References: <20200225163758.12996-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
 qemu-doc.texi               | 104 +++++++++++++++++++-----------------
 2 files changed, 57 insertions(+), 49 deletions(-)

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
index 169dcd9830..996ee5952b 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -36,8 +36,8 @@
 
 @menu
 * Introduction::
-* QEMU PC System emulator::
-* QEMU System emulator for non PC targets::
+* QEMU System emulator::
+* QEMU System emulator targets::
 * QEMU User space emulator::
 * System requirements::
 * Security::
@@ -128,36 +128,77 @@ accelerator is required to use more than one host CPU for emulation.
 
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
-* cpu_models::         CPU models
 * disk_images::        Disk Images
 * pcsys_network::      Network emulation
-* pcsys_other_devs::   Other Devices
-* direct_linux_boot::  Direct Linux Boot
 * pcsys_usb::          USB emulation
+* pcsys_ivshmem::      Inter-VM Shared Memory Device
+* direct_linux_boot::  Direct Linux Boot
 * vnc_security::       VNC security
 * network_tls::        TLS setup for network services
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
+@node QEMU PC System emulator
+@section x86 (PC) System emulator
+@cindex system emulation (PC)
+
+@menu
+* pcsys_devices::      Peripherals
+* cpu_models::         CPU models
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
@@ -223,40 +264,7 @@ CS4231A is the chip used in Windows Sound System and GUSMAX products
 
 @c man end
 
-@include docs/system/quickstart.texi
-@include docs/system/invocation.texi
-@include docs/system/keys.texi
-@include docs/system/mux-chardev.texi
-@include docs/system/monitor.texi
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
 
 @node PowerPC System emulator
 @section PowerPC System emulator
-- 
2.21.1


