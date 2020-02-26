Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4638C4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:39:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFBF424685
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E68GRuC+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFBF424685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6v1y-0003Xa-RI
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 06:39:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52785)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6utu-0000rv-T7
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:30:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6utp-0006GP-CI
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:30:50 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46248)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6utp-0006Bd-4s
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:30:45 -0500
Received: by mail-wr1-x444.google.com with SMTP id j7so2492959wrp.13
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 03:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xRK8bFWoSZBwkrBOa3bJQtvJAa0FRzsjPWhzdUOTyc8=;
 b=E68GRuC+SmiF+NHZz0SaJowVi2RNlZjKeMC+bI1roLoonDLvNz5171eG1NNZAr/iGy
 5+LeUpy18gBRTWGK1BtGepvkx62Qu8qf92jWR6m/k2WKpVWxYAudUD/ZDq/QH62mCS3P
 iwuSlPj3KQKD2zpf7LGT3TATSV0psUC59V/sDihN27WGS3XQvgxjkj4OX5HEZIlrPcp0
 IO8omzmptPv8k3aWq3lwSpCxkEnRzT/b2WU6/PsyglaLanErLODycF18khxM/59FDlOM
 zTCHVYHybNPaFgslcga8b10Xs2HthNuD+515wN1ZEiCAlyLWJ+avPUaP1xjj+/nHJyMV
 C7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=xRK8bFWoSZBwkrBOa3bJQtvJAa0FRzsjPWhzdUOTyc8=;
 b=tkLVdfp+YqPX1f2PkcKMHW4stWgt8EPOzIOGC6p9JTmN5a4AzjWLeqfnq1JBq9/+Ir
 pTbKDqcgLPdBukdRvXzT/ZxUuZ+iXkBiLvjkDhe/L4epC4LQiAwGFblc6Up9ObFJ5mYM
 kNh1htPEY+29bbLcZgLUwTkGwAqYFqjSmu3v2eTmCWBh35R0wnaUGOQtkYk62fPwOjpv
 ancrol6MmF/8nGNP6mTmG3m4DyCRoG89FPG0BzS1ZUFbxDuXMyfIdhEDrOrDj75bOYqo
 9Q9vWjVHr1jwByaR/svz4awwXu4zsDxTei6QmmSZv7YN2xW6MCn6AmA8B827j+FBKmjx
 86Mw==
X-Gm-Message-State: APjAAAXXa145v4U7h/m0YMvPD90IcfVG0a5mgxHKZjZumy0ABsQ/n87v
 xfkAB06TLBZ/tfrL68L3TnmafwuU
X-Google-Smtp-Source: APXvYqz1+vrS4/O9QHbmIUFhB8YWLVddxb5Hf6x31xRSVll6nrGNECtt2DrCkx/bkYQCW8SoFirrJA==
X-Received: by 2002:a5d:4b03:: with SMTP id v3mr5341314wrq.178.1582716643671; 
 Wed, 26 Feb 2020 03:30:43 -0800 (PST)
Received: from donizetti.lan ([2001:b07:6468:f312:d0d9:ea10:9775:f33f])
 by smtp.gmail.com with ESMTPSA id h128sm2628154wmh.33.2020.02.26.03.30.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 03:30:43 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/18] qemu-doc: Remove the "CPU emulation" part of the
 "Implementation notes"
Date: Wed, 26 Feb 2020 12:30:25 +0100
Message-Id: <20200226113034.6741-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200226113034.6741-1-pbonzini@redhat.com>
References: <20200226113034.6741-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

From: Peter Maydell <peter.maydell@linaro.org>

The "CPU emulation" part of the "Implementation notes" in
qemu-tech.texi looks like it is documenting what features of various
CPUs we do or don't emulate.  However:
 * it covers only six of our 21 guest architectures
 * the last time anybody updated it for actual content was in
   2011/2012 for Xtensa; the content for the other five
   architectures is even older, being from 2008 or before!

What we have is out of date, misleading and incomplete.
Just delete this part of the document rather than trying to
convert it to rST.

(It would be nice eventually to have documentation of the
scope and limitations of our emulation; but we will want to
separate out the generic "system emulation" information from
the parts that are specific to linux-user anyway, as they will
be in different manuals.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200225154121.21116-3-peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-tech.texi | 153 -------------------------------------------------
 1 file changed, 153 deletions(-)

diff --git a/qemu-tech.texi b/qemu-tech.texi
index 0380de77b6..35da6a40af 100644
--- a/qemu-tech.texi
+++ b/qemu-tech.texi
@@ -2,162 +2,9 @@
 @appendix Implementation notes
 
 @menu
-* CPU emulation::
 * Managed start up options::
 @end menu
 
-@node CPU emulation
-@section CPU emulation
-
-@menu
-* x86::     x86 and x86-64 emulation
-* ARM::     ARM emulation
-* MIPS::    MIPS emulation
-* PPC::     PowerPC emulation
-* SPARC::   Sparc32 and Sparc64 emulation
-* Xtensa::  Xtensa emulation
-@end menu
-
-@node x86
-@subsection x86 and x86-64 emulation
-
-QEMU x86 target features:
-
-@itemize
-
-@item The virtual x86 CPU supports 16 bit and 32 bit addressing with segmentation.
-LDT/GDT and IDT are emulated. VM86 mode is also supported to run
-DOSEMU. There is some support for MMX/3DNow!, SSE, SSE2, SSE3, SSSE3,
-and SSE4 as well as x86-64 SVM.
-
-@item Support of host page sizes bigger than 4KB in user mode emulation.
-
-@item QEMU can emulate itself on x86.
-
-@item An extensive Linux x86 CPU test program is included @file{tests/test-i386}.
-It can be used to test other x86 virtual CPUs.
-
-@end itemize
-
-Current QEMU limitations:
-
-@itemize
-
-@item Limited x86-64 support.
-
-@item IPC syscalls are missing.
-
-@item The x86 segment limits and access rights are not tested at every
-memory access (yet). Hopefully, very few OSes seem to rely on that for
-normal use.
-
-@end itemize
-
-@node ARM
-@subsection ARM emulation
-
-@itemize
-
-@item Full ARM 7 user emulation.
-
-@item NWFPE FPU support included in user Linux emulation.
-
-@item Can run most ARM Linux binaries.
-
-@end itemize
-
-@node MIPS
-@subsection MIPS emulation
-
-@itemize
-
-@item The system emulation allows full MIPS32/MIPS64 Release 2 emulation,
-including privileged instructions, FPU and MMU, in both little and big
-endian modes.
-
-@item The Linux userland emulation can run many 32 bit MIPS Linux binaries.
-
-@end itemize
-
-Current QEMU limitations:
-
-@itemize
-
-@item Self-modifying code is not always handled correctly.
-
-@item 64 bit userland emulation is not implemented.
-
-@item The system emulation is not complete enough to run real firmware.
-
-@item The watchpoint debug facility is not implemented.
-
-@end itemize
-
-@node PPC
-@subsection PowerPC emulation
-
-@itemize
-
-@item Full PowerPC 32 bit emulation, including privileged instructions,
-FPU and MMU.
-
-@item Can run most PowerPC Linux binaries.
-
-@end itemize
-
-@node SPARC
-@subsection Sparc32 and Sparc64 emulation
-
-@itemize
-
-@item Full SPARC V8 emulation, including privileged
-instructions, FPU and MMU. SPARC V9 emulation includes most privileged
-and VIS instructions, FPU and I/D MMU. Alignment is fully enforced.
-
-@item Can run most 32-bit SPARC Linux binaries, SPARC32PLUS Linux binaries and
-some 64-bit SPARC Linux binaries.
-
-@end itemize
-
-Current QEMU limitations:
-
-@itemize
-
-@item IPC syscalls are missing.
-
-@item Floating point exception support is buggy.
-
-@item Atomic instructions are not correctly implemented.
-
-@item There are still some problems with Sparc64 emulators.
-
-@end itemize
-
-@node Xtensa
-@subsection Xtensa emulation
-
-@itemize
-
-@item Core Xtensa ISA emulation, including most options: code density,
-loop, extended L32R, 16- and 32-bit multiplication, 32-bit division,
-MAC16, miscellaneous operations, boolean, FP coprocessor, coprocessor
-context, debug, multiprocessor synchronization,
-conditional store, exceptions, relocatable vectors, unaligned exception,
-interrupts (including high priority and timer), hardware alignment,
-region protection, region translation, MMU, windowed registers, thread
-pointer, processor ID.
-
-@item Not implemented options: data/instruction cache (including cache
-prefetch and locking), XLMI, processor interface. Also options not
-covered by the core ISA (e.g. FLIX, wide branches) are not implemented.
-
-@item Can run most Xtensa Linux binaries.
-
-@item New core configuration that requires no additional instructions
-may be created from overlay with minimal amount of hand-written code.
-
-@end itemize
-
 @node Managed start up options
 @section Managed start up options
 
-- 
2.21.1



