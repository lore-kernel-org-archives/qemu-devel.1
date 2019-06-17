Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37C7C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:39:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B19C92084A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lWWGc0FW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B19C92084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48596 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hctjf-0002C1-VL
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 11:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53431)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hct4x-0000Tp-HV
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:57:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hct4u-0007NG-Dv
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:57:51 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:51756)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hct4t-0007IT-Ts
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:57:48 -0400
Received: by mail-wm1-x32b.google.com with SMTP id 207so9639336wma.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=syAgF6UVWodyfm7jwq7zefShMNqE/U+4j9xJ9ZtoV0M=;
 b=lWWGc0FWLSOXIkIrELNOVXbrbHdCmUthde4+dW2aAXMk8v2rgS4v9KuQsEmUSsb0BB
 4S2yKwbVRWJI1eu0jwIqJOwcSP6a8CvGDgmd9eHlvVA7Ur9//pNaUVxbGBO55WtLnNsi
 e17JEqHSwyW6OFOGXCKNh2qrm/wwfrcSZAaSTWhQVncMKp+nbXn7Y4cS+v7y7qb7HePN
 7bZ2rVwudUvZ3NOhv8YKfLUAx3QlrYRrcnq32WMoHLF4Mco5TcLMJj6yWYO9qvTd2KKs
 Evv1tnTAD4CFIHrvBnrcHLAKnEOEwL7yFd1QjFMTSAA32/4eowy/QkXElx1/abYH3LpI
 qpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=syAgF6UVWodyfm7jwq7zefShMNqE/U+4j9xJ9ZtoV0M=;
 b=kUMn5O6ZfWfzfj83x2hsR5LDu2BEPD1J2pOpaTGGNSz1UKNAIV/SN7bpvUgryFgUdt
 klY4L6UlPlQq+0i9wTfQCdBPVOnv8PUVK47g8E30FJ3W/muSXwrl8CG4+JqWNmZ1bSw7
 VaZUyyMvlx8GIk4ITmJwwZvdXPrkal3nnT3xUpqhQWMURZ+4zBQJemCQ9Cgkj44Lx/8Z
 Tdoc3lJkEuN7VsaG7RGvmK9sonwBA3YEO4KySGvP3+lm+VAAS0aRmq4fr27bgBIWh01i
 lH4AZB8z9PBwPnWtn+x6/DFB0dUJ7aLUYcJnKfokjiGev+vSTGu5yZMW3pquBn7/XtjD
 wtNA==
X-Gm-Message-State: APjAAAUNFG8nkvl4ZnRQ8z81GGiJdQ71yMrnqGTy7x7YSLWNhhWHHJX9
 qT++h5ILYSnPx02+IDLEWwdkt+ixMj7huw==
X-Google-Smtp-Source: APXvYqwacjwJ9YwulD6oOYthfrMaiyri0bqp1jqyvXVtdQ3OTrsFe0hRD0amZsuY35VLHrPnytYxjg==
X-Received: by 2002:a1c:56d7:: with SMTP id k206mr18766768wmb.56.1560783463454; 
 Mon, 17 Jun 2019 07:57:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s10sm14690750wmf.8.2019.06.17.07.57.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 07:57:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 15:57:37 +0100
Message-Id: <20190617145740.9881-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617145740.9881-1-peter.maydell@linaro.org>
References: <20190617145740.9881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
Subject: [Qemu-devel] [PULL 1/4] Convert "translator internals" docs to RST,
 move to devel manual
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

Our user-facing manual currently has a section "translator internals"
which has some high-level information about the design of the
TCG translator. This should really be in our new devel/ manual.
Convert it to RST format and move it there.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190607152827.18003-2-peter.maydell@linaro.org
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 docs/devel/index.rst |   1 +
 docs/devel/tcg.rst   | 111 +++++++++++++++++++++++++++++++++++++++++++
 qemu-tech.texi       | 103 ---------------------------------------
 3 files changed, 112 insertions(+), 103 deletions(-)
 create mode 100644 docs/devel/tcg.rst

diff --git a/docs/devel/index.rst b/docs/devel/index.rst
index 2a4ddf40ad3..1ec61fcfed9 100644
--- a/docs/devel/index.rst
+++ b/docs/devel/index.rst
@@ -21,3 +21,4 @@ Contents:
    testing
    decodetree
    secure-coding-practices
+   tcg
diff --git a/docs/devel/tcg.rst b/docs/devel/tcg.rst
new file mode 100644
index 00000000000..4956a30a4e6
--- /dev/null
+++ b/docs/devel/tcg.rst
@@ -0,0 +1,111 @@
+====================
+Translator Internals
+====================
+
+QEMU is a dynamic translator. When it first encounters a piece of code,
+it converts it to the host instruction set. Usually dynamic translators
+are very complicated and highly CPU dependent. QEMU uses some tricks
+which make it relatively easily portable and simple while achieving good
+performances.
+
+QEMU's dynamic translation backend is called TCG, for "Tiny Code
+Generator". For more information, please take a look at ``tcg/README``.
+
+Some notable features of QEMU's dynamic translator are:
+
+CPU state optimisations
+-----------------------
+
+The target CPUs have many internal states which change the way it
+evaluates instructions. In order to achieve a good speed, the
+translation phase considers that some state information of the virtual
+CPU cannot change in it. The state is recorded in the Translation
+Block (TB). If the state changes (e.g. privilege level), a new TB will
+be generated and the previous TB won't be used anymore until the state
+matches the state recorded in the previous TB. The same idea can be applied
+to other aspects of the CPU state.  For example, on x86, if the SS,
+DS and ES segments have a zero base, then the translator does not even
+generate an addition for the segment base.
+
+Direct block chaining
+---------------------
+
+After each translated basic block is executed, QEMU uses the simulated
+Program Counter (PC) and other cpu state information (such as the CS
+segment base value) to find the next basic block.
+
+In order to accelerate the most common cases where the new simulated PC
+is known, QEMU can patch a basic block so that it jumps directly to the
+next one.
+
+The most portable code uses an indirect jump. An indirect jump makes
+it easier to make the jump target modification atomic. On some host
+architectures (such as x86 or PowerPC), the ``JUMP`` opcode is
+directly patched so that the block chaining has no overhead.
+
+Self-modifying code and translated code invalidation
+----------------------------------------------------
+
+Self-modifying code is a special challenge in x86 emulation because no
+instruction cache invalidation is signaled by the application when code
+is modified.
+
+User-mode emulation marks a host page as write-protected (if it is
+not already read-only) every time translated code is generated for a
+basic block.  Then, if a write access is done to the page, Linux raises
+a SEGV signal. QEMU then invalidates all the translated code in the page
+and enables write accesses to the page.  For system emulation, write
+protection is achieved through the software MMU.
+
+Correct translated code invalidation is done efficiently by maintaining
+a linked list of every translated block contained in a given page. Other
+linked lists are also maintained to undo direct block chaining.
+
+On RISC targets, correctly written software uses memory barriers and
+cache flushes, so some of the protection above would not be
+necessary. However, QEMU still requires that the generated code always
+matches the target instructions in memory in order to handle
+exceptions correctly.
+
+Exception support
+-----------------
+
+longjmp() is used when an exception such as division by zero is
+encountered.
+
+The host SIGSEGV and SIGBUS signal handlers are used to get invalid
+memory accesses.  QEMU keeps a map from host program counter to
+target program counter, and looks up where the exception happened
+based on the host program counter at the exception point.
+
+On some targets, some bits of the virtual CPU's state are not flushed to the
+memory until the end of the translation block.  This is done for internal
+emulation state that is rarely accessed directly by the program and/or changes
+very often throughout the execution of a translation block---this includes
+condition codes on x86, delay slots on SPARC, conditional execution on
+ARM, and so on.  This state is stored for each target instruction, and
+looked up on exceptions.
+
+MMU emulation
+-------------
+
+For system emulation QEMU uses a software MMU. In that mode, the MMU
+virtual to physical address translation is done at every memory
+access.
+
+QEMU uses an address translation cache (TLB) to speed up the translation.
+In order to avoid flushing the translated code each time the MMU
+mappings change, all caches in QEMU are physically indexed.  This
+means that each basic block is indexed with its physical address.
+
+In order to avoid invalidating the basic block chain when MMU mappings
+change, chaining is only performed when the destination of the jump
+shares a page with the basic block that is performing the jump.
+
+The MMU can also distinguish RAM and ROM memory areas from MMIO memory
+areas.  Access is faster for RAM and ROM because the translation cache also
+hosts the offset between guest address and host memory.  Accessing MMIO
+memory areas instead calls out to C code for device emulation.
+Finally, the MMU helps tracking dirty pages and pages pointed to by
+translation blocks.
+
diff --git a/qemu-tech.texi b/qemu-tech.texi
index 7c3d1f05e13..eb430daacf2 100644
--- a/qemu-tech.texi
+++ b/qemu-tech.texi
@@ -161,109 +161,6 @@ may be created from overlay with minimal amount of hand-written code.
 
 @end itemize
 
-@node Translator Internals
-@section Translator Internals
-
-QEMU is a dynamic translator. When it first encounters a piece of code,
-it converts it to the host instruction set. Usually dynamic translators
-are very complicated and highly CPU dependent. QEMU uses some tricks
-which make it relatively easily portable and simple while achieving good
-performances.
-
-QEMU's dynamic translation backend is called TCG, for "Tiny Code
-Generator". For more information, please take a look at @code{tcg/README}.
-
-Some notable features of QEMU's dynamic translator are:
-
-@table @strong
-
-@item CPU state optimisations:
-The target CPUs have many internal states which change the way it
-evaluates instructions. In order to achieve a good speed, the
-translation phase considers that some state information of the virtual
-CPU cannot change in it. The state is recorded in the Translation
-Block (TB). If the state changes (e.g. privilege level), a new TB will
-be generated and the previous TB won't be used anymore until the state
-matches the state recorded in the previous TB. The same idea can be applied
-to other aspects of the CPU state.  For example, on x86, if the SS,
-DS and ES segments have a zero base, then the translator does not even
-generate an addition for the segment base.
-
-@item Direct block chaining:
-After each translated basic block is executed, QEMU uses the simulated
-Program Counter (PC) and other cpu state information (such as the CS
-segment base value) to find the next basic block.
-
-In order to accelerate the most common cases where the new simulated PC
-is known, QEMU can patch a basic block so that it jumps directly to the
-next one.
-
-The most portable code uses an indirect jump. An indirect jump makes
-it easier to make the jump target modification atomic. On some host
-architectures (such as x86 or PowerPC), the @code{JUMP} opcode is
-directly patched so that the block chaining has no overhead.
-
-@item Self-modifying code and translated code invalidation:
-Self-modifying code is a special challenge in x86 emulation because no
-instruction cache invalidation is signaled by the application when code
-is modified.
-
-User-mode emulation marks a host page as write-protected (if it is
-not already read-only) every time translated code is generated for a
-basic block.  Then, if a write access is done to the page, Linux raises
-a SEGV signal. QEMU then invalidates all the translated code in the page
-and enables write accesses to the page.  For system emulation, write
-protection is achieved through the software MMU.
-
-Correct translated code invalidation is done efficiently by maintaining
-a linked list of every translated block contained in a given page. Other
-linked lists are also maintained to undo direct block chaining.
-
-On RISC targets, correctly written software uses memory barriers and
-cache flushes, so some of the protection above would not be
-necessary. However, QEMU still requires that the generated code always
-matches the target instructions in memory in order to handle
-exceptions correctly.
-
-@item Exception support:
-longjmp() is used when an exception such as division by zero is
-encountered.
-
-The host SIGSEGV and SIGBUS signal handlers are used to get invalid
-memory accesses.  QEMU keeps a map from host program counter to
-target program counter, and looks up where the exception happened
-based on the host program counter at the exception point.
-
-On some targets, some bits of the virtual CPU's state are not flushed to the
-memory until the end of the translation block.  This is done for internal
-emulation state that is rarely accessed directly by the program and/or changes
-very often throughout the execution of a translation block---this includes
-condition codes on x86, delay slots on SPARC, conditional execution on
-ARM, and so on.  This state is stored for each target instruction, and
-looked up on exceptions.
-
-@item MMU emulation:
-For system emulation QEMU uses a software MMU. In that mode, the MMU
-virtual to physical address translation is done at every memory
-access.
-
-QEMU uses an address translation cache (TLB) to speed up the translation.
-In order to avoid flushing the translated code each time the MMU
-mappings change, all caches in QEMU are physically indexed.  This
-means that each basic block is indexed with its physical address.
-
-In order to avoid invalidating the basic block chain when MMU mappings
-change, chaining is only performed when the destination of the jump
-shares a page with the basic block that is performing the jump.
-
-The MMU can also distinguish RAM and ROM memory areas from MMIO memory
-areas.  Access is faster for RAM and ROM because the translation cache also
-hosts the offset between guest address and host memory.  Accessing MMIO
-memory areas instead calls out to C code for device emulation.
-Finally, the MMU helps tracking dirty pages and pages pointed to by
-translation blocks.
-@end table
-
 @node QEMU compared to other emulators
 @section QEMU compared to other emulators
 
-- 
2.20.1


