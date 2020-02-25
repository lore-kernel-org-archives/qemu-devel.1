Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48857C35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:42:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 137652082F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AbbAUInu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 137652082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6cLx-0005Jx-7D
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 10:42:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33951)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6cKw-0003GE-Aw
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:41:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6cKu-0000wn-OM
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:41:30 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36742)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6cKu-0000wB-HC
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:41:28 -0500
Received: by mail-wr1-x444.google.com with SMTP id z3so15283203wru.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 07:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wCTKn3w1EKof7r94cqLWmGGGpk2G1lh5srO/fJUl1aE=;
 b=AbbAUInuSqHzf53lXGSgFB23nvmTWXORscA1PTWp/QDLfWXodl4+6/XLEQkOnsGlC1
 S9jXbyz34tMHJ1FiJMiJQVCdHMAONTQlGXVPYGGQhUxFv/3Xeistu28uG9nP0Mipt/m1
 XjCQuL9TB6zLK/QVxx2yuKo7ANF+KKeJA4JdCn4A5LPAKRMp21dSykY5x4ffL0QbweLH
 +RyL/C1siO+W3QX/aSZc22ukqGGTb9UOeqYu2adMHdwf3fbkaCy8bJrB+90WU1mcxYdh
 TueoqZQd6cThkF+pCd3h/zaEAbh1RmdBqXqzh+rzYHzhFSdWmqy9WHL2ztTKLoZzsqdm
 z+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wCTKn3w1EKof7r94cqLWmGGGpk2G1lh5srO/fJUl1aE=;
 b=GTESiAcqYAX94CdesPhyKy7Ncsma4Z2JQUKUZ8FJNwdLLNBRkxUFCs4ZRPvbtcduBt
 g95Jlrk4Df5cTFi68ZtxadWneOoXJ9ZRqfxvafx67L1eeDblCqcTTi4LvyP9H99Dhj/u
 UMELIAEkvs1PkvclyMWUI/lhn3qdh1pKIhFc3lRMCB/pfQRq6zRuG70QPGAFdpw9la2d
 mgRy7lcLzb6UzvSBp1LnhznJ8qCJ733mYR6CFrwLjvnUTCclUsws7u1x8mtvG54qeKcP
 TrW/dDRlSMi+xq6Gl6d6bPWUgLUBihNFbcOnXPIiPTYknHWnZbrF41UsoNROpz6ZyCt/
 l2Aw==
X-Gm-Message-State: APjAAAUKdtszYmpmCt/iuRrx3gYZyWzD6hG69i7NyLsp9fFDuRhzSh8s
 gJlwRXgVm6YxcY/JQDG+oNdxvIDYMSbffw==
X-Google-Smtp-Source: APXvYqxmLn/KIMD6w7m6MG0FtSdoXZzmkFSn4mfdO6X3153JCSGllK1i0dVQy2xNzv9MgKVVXTNrQQ==
X-Received: by 2002:adf:82ef:: with SMTP id 102mr22247087wrc.23.1582645287124; 
 Tue, 25 Feb 2020 07:41:27 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c9sm24438604wrq.44.2020.02.25.07.41.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 07:41:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] docs: Remove the "CPU emulation" part of the
 "Implementation notes"
Date: Tue, 25 Feb 2020 15:41:19 +0000
Message-Id: <20200225154121.21116-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225154121.21116-1-peter.maydell@linaro.org>
References: <20200225154121.21116-1-peter.maydell@linaro.org>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 qemu-tech.texi | 153 -------------------------------------------------
 1 file changed, 153 deletions(-)

diff --git a/qemu-tech.texi b/qemu-tech.texi
index 0380de77b62..35da6a40af1 100644
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
2.20.1


