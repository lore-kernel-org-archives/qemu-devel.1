Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB68AC00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:55:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 841AD2077B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fC5Y6rMa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 841AD2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2RY-0000DH-5g
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 22:55:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49423)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2Ik-0004XV-Oj
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2Ii-0003NC-4R
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:34 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:35579)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ip2Ih-0003MI-Sb
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:32 -0500
Received: by mail-pj1-x1042.google.com with SMTP id s7so478318pjc.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 19:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gEAlRH/6E/do1dPM1Y5Beo98Aszl0pfXxuarudYqYio=;
 b=fC5Y6rMa534jjRKWcD5QhYMg38t/CfeFF7Rl0/O1/Ln5CJjhEgZ/r6bu12rQ1lpQDC
 /NkxyNwe68zV9QbiaT4gEoDurz8MxWYacm0bSCbkl0gSXlC/zFG13fH51/p3ulKhbxyH
 U2SnUhfc8oyN+JDwwol493OdKPtvq3rmIQnIbMghWyal06JN/axMf3R8IHJY/YK5mqSp
 RfVXKF8TF26X0/U/pSCycIjIajU3xxSagvYqyiNWxMnlDstvjE1RMt/muBACo8IOGTZq
 bSVreyCgB9G8LvOyxY336cNm3ZSvXLhHs8XkSaLcAOjqcKP7E5/ZpG3lI/3fzpILlLtF
 g+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gEAlRH/6E/do1dPM1Y5Beo98Aszl0pfXxuarudYqYio=;
 b=j17hEdDQAn9XdxEhydUcs8Abx4MNdigGIrn3YO2C3rpr53CmFguxzFpndH1uFa57fr
 P+LjQnw1kp4k/TL0ZPAlMOCLkZ+mapO2MGfGoaLJOjWUvgCSUOwnYckGSdpfys04+qQj
 CP4CayjDwhsiHTV0YhAkDJuiJEGOaaTwBUbjnDS1dSzdCbyCtIX0cDpTBPpd0sS4mR5s
 13wqCa5cTfzRTejt9Xi8ui6vkWV5DePfaG1cu8GSfpx1Tt2/a8E9VaSqIoTck+8vomNu
 TV3NIuK1Z3ivK/zBWnfgEVeF5wBUFblAA/2zRLnVdGqN7SnfqYmeoseXmVu+jT9+AMeT
 fXPA==
X-Gm-Message-State: APjAAAUT2WpITFYPyRpK38A96BspwGs8SQsLYmea+Nk1oR4RoTs8/jFy
 qBdzfveBcMFINJkQyvEcJZIfYnPbNBunQQ==
X-Google-Smtp-Source: APXvYqyXZqjCFy35TOypgqGLHIAOEZ/eAkJ9T3mkZqU86fQYQcoaiHQBWnkt+Lsn1VHLRzvF8Tsldw==
X-Received: by 2002:a17:90a:6587:: with SMTP id
 k7mr2048821pjj.40.1578455190361; 
 Tue, 07 Jan 2020 19:46:30 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id f23sm1198433pgj.76.2020.01.07.19.46.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 19:46:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/41] cputlb: Provide cpu_(ld,st}*_mmuidx_ra for user-only
Date: Wed,  8 Jan 2020 14:45:02 +1100
Message-Id: <20200108034523.17349-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108034523.17349-1-richard.henderson@linaro.org>
References: <20200108034523.17349-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This finishes the new interface began with the previous patch.
Document the interface and deprecate MMU_MODE<N>_SUFFIX.

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst.h     |  80 +++++++++++++-
 docs/devel/loads-stores.rst | 211 ++++++++++++++++++++++++++----------
 2 files changed, 230 insertions(+), 61 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index ef59ed61e4..41b98ba801 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -25,9 +25,13 @@
  *
  * The syntax for the accessors is:
  *
- * load: cpu_ld{sign}{size}_{mmusuffix}(env, ptr)
+ * load:  cpu_ld{sign}{size}_{mmusuffix}(env, ptr)
+ *        cpu_ld{sign}{size}_{mmusuffix}_ra(env, ptr, retaddr)
+ *        cpu_ld{sign}{size}_mmuidx_ra(env, ptr, mmu_idx, retaddr)
  *
- * store: cpu_st{sign}{size}_{mmusuffix}(env, ptr, val)
+ * store: cpu_st{size}_{mmusuffix}(env, ptr, val)
+ *        cpu_st{size}_{mmusuffix}_ra(env, ptr, val, retaddr)
+ *        cpu_st{size}_mmuidx_ra(env, ptr, val, mmu_idx, retaddr)
  *
  * sign is:
  * (empty): for 32 and 64 bit sizes
@@ -40,9 +44,10 @@
  *   l: 32 bits
  *   q: 64 bits
  *
- * mmusuffix is one of the generic suffixes "data" or "code", or
- * (for softmmu configs)  a target-specific MMU mode suffix as defined
- * in target cpu.h.
+ * mmusuffix is one of the generic suffixes "data" or "code", or "mmuidx".
+ * The "mmuidx" suffix carries an extra mmu_idx argument that specifies
+ * the index to use; the "data" and "code" suffixes take the index from
+ * cpu_mmu_index().
  */
 #ifndef CPU_LDST_H
 #define CPU_LDST_H
@@ -145,6 +150,71 @@ static inline void clear_helper_retaddr(void)
 #undef MEMSUFFIX
 #undef CODE_ACCESS
 
+/*
+ * Provide the same *_mmuidx_ra interface as for softmmu.
+ * The mmu_idx argument is ignored.
+ */
+
+static inline uint32_t cpu_ldub_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                                          int mmu_idx, uintptr_t ra)
+{
+    return cpu_ldub_data_ra(env, addr, ra);
+}
+
+static inline uint32_t cpu_lduw_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                                          int mmu_idx, uintptr_t ra)
+{
+    return cpu_lduw_data_ra(env, addr, ra);
+}
+
+static inline uint32_t cpu_ldl_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                                         int mmu_idx, uintptr_t ra)
+{
+    return cpu_ldl_data_ra(env, addr, ra);
+}
+
+static inline uint64_t cpu_ldq_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                                         int mmu_idx, uintptr_t ra)
+{
+    return cpu_ldq_data_ra(env, addr, ra);
+}
+
+static inline int cpu_ldsb_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                                     int mmu_idx, uintptr_t ra)
+{
+    return cpu_ldsb_data_ra(env, addr, ra);
+}
+
+static inline int cpu_ldsw_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                                     int mmu_idx, uintptr_t ra)
+{
+    return cpu_ldsw_data_ra(env, addr, ra);
+}
+
+static inline void cpu_stb_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                                     uint32_t val, int mmu_idx, uintptr_t ra)
+{
+    cpu_stb_data_ra(env, addr, val, ra);
+}
+
+static inline void cpu_stw_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                                     uint32_t val, int mmu_idx, uintptr_t ra)
+{
+    cpu_stw_data_ra(env, addr, val, ra);
+}
+
+static inline void cpu_stl_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                                     uint32_t val, int mmu_idx, uintptr_t ra)
+{
+    cpu_stl_data_ra(env, addr, val, ra);
+}
+
+static inline void cpu_stq_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                                     uint64_t val, int mmu_idx, uintptr_t ra)
+{
+    cpu_stq_data_ra(env, addr, val, ra);
+}
+
 #else
 
 /* Needed for TCG_OVERSIZED_GUEST */
diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
index 8a5bc912a5..03aa9e7ff8 100644
--- a/docs/devel/loads-stores.rst
+++ b/docs/devel/loads-stores.rst
@@ -72,31 +72,34 @@ Regexes for git grep
  - ``\<ldn_\([hbl]e\)?_p\>``
  - ``\<stn_\([hbl]e\)?_p\>``
 
-``cpu_{ld,st}_*``
-~~~~~~~~~~~~~~~~~
+``cpu_{ld,st}*_mmuidx_ra``
+~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-These functions operate on a guest virtual address. Be aware
-that these functions may cause a guest CPU exception to be
-taken (e.g. for an alignment fault or MMU fault) which will
-result in guest CPU state being updated and control longjumping
-out of the function call. They should therefore only be used
-in code that is implementing emulation of the target CPU.
+These functions operate on a guest virtual address plus a context,
+known as a "mmu index" or ``mmuidx``, which controls how that virtual
+address is translated.  The meaning of the indexes are target specific,
+but specifying a particular index might be necessary if, for instance,
+the helper requires an "always as non-privileged" access rather that
+the default access for the current state of the guest CPU.
 
-These functions may throw an exception (longjmp() back out
-to the top level TCG loop). This means they must only be used
-from helper functions where the translator has saved all
-necessary CPU state before generating the helper function call.
-It's usually better to use the ``_ra`` variants described below
-from helper functions, but these functions are the right choice
-for calls made from hooks like the CPU do_interrupt hook or
-when you know for certain that the translator had to save all
-the CPU state that ``cpu_restore_state()`` would restore anyway.
+These functions may cause a guest CPU exception to be taken
+(e.g. for an alignment fault or MMU fault) which will result in
+guest CPU state being updated and control longjmp'ing out of the
+function call.  They should therefore only be used in code that is
+implementing emulation of the guest CPU.
+
+The ``retaddr`` parameter is used to control unwinding of the
+guest CPU state in case of a guest CPU exception.  This is passed
+to ``cpu_restore_state()``.  Therefore the value should either be 0,
+to indicate that the guest CPU state is already synchronized, or
+the result of ``GETPC()`` from the top level ``HELPER(foo)``
+function, which is a return address into the generated code.
 
 Function names follow the pattern:
 
-load: ``cpu_ld{sign}{size}_{mmusuffix}(env, ptr)``
+load: ``cpu_ld{sign}{size}_mmuidx_ra(env, ptr, mmuidx, retaddr)``
 
-store: ``cpu_st{size}_{mmusuffix}(env, ptr, val)``
+store: ``cpu_st{size}_mmuidx_ra(env, ptr, val, mmuidx, retaddr)``
 
 ``sign``
  - (empty) : for 32 or 64 bit sizes
@@ -109,56 +112,151 @@ store: ``cpu_st{size}_{mmusuffix}(env, ptr, val)``
  - ``l`` : 32 bits
  - ``q`` : 64 bits
 
-``mmusuffix`` is one of the generic suffixes ``data`` or ``code``, or
-(for softmmu configs) a target-specific MMU mode suffix as defined
-in the target's ``cpu.h``.
+Regexes for git grep:
+ - ``\<cpu_ld[us]\?[bwlq]_mmuidx_ra\>``
+ - ``\<cpu_st[bwlq]_mmuidx_ra\>``
 
-Regexes for git grep
- - ``\<cpu_ld[us]\?[bwlq]_[a-zA-Z0-9]\+\>``
- - ``\<cpu_st[bwlq]_[a-zA-Z0-9]\+\>``
+``cpu_{ld,st}*_data_ra``
+~~~~~~~~~~~~~~~~~~~~~~~~
 
-``cpu_{ld,st}_*_ra``
-~~~~~~~~~~~~~~~~~~~~
-
-These functions work like the ``cpu_{ld,st}_*`` functions except
-that they also take a ``retaddr`` argument. This extra argument
-allows for correct unwinding of any exception that is taken,
-and should generally be the result of GETPC() called directly
-from the top level HELPER(foo) function (i.e. the return address
-in the generated code).
+These functions work like the ``cpu_{ld,st}_mmuidx_ra`` functions
+except that the ``mmuidx`` parameter is taken from the current mode
+of the guest CPU, as determined by ``cpu_mmu_index(env, false)``.
 
 These are generally the preferred way to do accesses by guest
-virtual address from helper functions; see the documentation
-of the non-``_ra`` variants for when those would be better.
-
-Calling these functions with a ``retaddr`` argument of 0 is
-equivalent to calling the non-``_ra`` version of the function.
+virtual address from helper functions, unless the access should
+be performed with a context other than the default.
 
 Function names follow the pattern:
 
-load: ``cpu_ld{sign}{size}_{mmusuffix}_ra(env, ptr, retaddr)``
+load: ``cpu_ld{sign}{size}_data_ra(env, ptr, ra)``
 
-store: ``cpu_st{sign}{size}_{mmusuffix}_ra(env, ptr, val, retaddr)``
+store: ``cpu_st{size}_data_ra(env, ptr, val, ra)``
+
+``sign``
+ - (empty) : for 32 or 64 bit sizes
+ - ``u`` : unsigned
+ - ``s`` : signed
+
+``size``
+ - ``b`` : 8 bits
+ - ``w`` : 16 bits
+ - ``l`` : 32 bits
+ - ``q`` : 64 bits
+
+Regexes for git grep:
+ - ``\<cpu_ld[us]\?[bwlq]_data_ra\>``
+ - ``\<cpu_st[bwlq]_data_ra\>``
+
+``cpu_{ld,st}*_data``
+~~~~~~~~~~~~~~~~~~~~~
+
+These functions work like the ``cpu_{ld,st}_data_ra`` functions
+except that the ``retaddr`` parameter is 0, and thus does not
+unwind guest CPU state.
+
+This means they must only be used from helper functions where the
+translator has saved all necessary CPU state.  These functions are
+the right choice for calls made from hooks like the CPU ``do_interrupt``
+hook or when you know for certain that the translator had to save all
+the CPU state anyway.
+
+Function names follow the pattern:
+
+load: ``cpu_ld{sign}{size}_data(env, ptr)``
+
+store: ``cpu_st{size}_data(env, ptr, val)``
+
+``sign``
+ - (empty) : for 32 or 64 bit sizes
+ - ``u`` : unsigned
+ - ``s`` : signed
+
+``size``
+ - ``b`` : 8 bits
+ - ``w`` : 16 bits
+ - ``l`` : 32 bits
+ - ``q`` : 64 bits
 
 Regexes for git grep
- - ``\<cpu_ld[us]\?[bwlq]_[a-zA-Z0-9]\+_ra\>``
- - ``\<cpu_st[bwlq]_[a-zA-Z0-9]\+_ra\>``
+ - ``\<cpu_ld[us]\?[bwlq]_data\>``
+ - ``\<cpu_st[bwlq]_data\+\>``
 
-``helper_*_{ld,st}*mmu``
-~~~~~~~~~~~~~~~~~~~~~~~~
+``cpu_ld*_code``
+~~~~~~~~~~~~~~~~
+
+These functions perform a read for instruction execution.  The ``mmuidx``
+parameter is taken from the current mode of the guest CPU, as determined
+by ``cpu_mmu_index(env, true)``.  The ``retaddr`` parameter is 0, and
+thus does not unwind guest CPU state, because CPU state is always
+synchronized while translating instructions.  Any guest CPU exception
+that is raised will indicate an instruction execution fault rather than
+a data read fault.
+
+In general these functions should not be used directly during translation.
+There are wrapper functions that are to be used which also take care of
+plugins for tracing.
+
+Function names follow the pattern:
+
+load: ``cpu_ld{sign}{size}_code(env, ptr)``
+
+``sign``
+ - (empty) : for 32 or 64 bit sizes
+ - ``u`` : unsigned
+ - ``s`` : signed
+
+``size``
+ - ``b`` : 8 bits
+ - ``w`` : 16 bits
+ - ``l`` : 32 bits
+ - ``q`` : 64 bits
+
+Regexes for git grep:
+ - ``\<cpu_ld[us]\?[bwlq]_code\>``
+
+``translator_ld*``
+~~~~~~~~~~~~~~~~~~
+
+These functions are a wrapper for ``cpu_ld*_code`` which also perform
+any actions required by any tracing plugins.  They are only to be
+called during the translator callback ``translate_insn``.
+
+There is a set of functions ending in ``_swap`` which, if the parameter
+is true, returns the value in the endianness that is the reverse of
+the guest native endianness, as determined by ``TARGET_WORDS_BIGENDIAN``.
+
+Function names follow the pattern:
+
+load: ``translator_ld{sign}{size}(env, ptr)``
+
+swap: ``translator_ld{sign}{size}_swap(env, ptr, swap)``
+
+``sign``
+ - (empty) : for 32 or 64 bit sizes
+ - ``u`` : unsigned
+ - ``s`` : signed
+
+``size``
+ - ``b`` : 8 bits
+ - ``w`` : 16 bits
+ - ``l`` : 32 bits
+ - ``q`` : 64 bits
+
+Regexes for git grep
+ - ``\<translator_ld[us]\?[bwlq]\(_swap\)\?\>``
+
+``helper_*_{ld,st}*_mmu``
+~~~~~~~~~~~~~~~~~~~~~~~~~
 
 These functions are intended primarily to be called by the code
 generated by the TCG backend. They may also be called by target
-CPU helper function code. Like the ``cpu_{ld,st}_*_ra`` functions
-they perform accesses by guest virtual address; the difference is
-that these functions allow you to specify an ``opindex`` parameter
-which encodes (among other things) the mmu index to use for the
-access. This is necessary if your helper needs to make an access
-via a specific mmu index (for instance, an "always as non-privileged"
-access) rather than using the default mmu index for the current state
-of the guest CPU.
+CPU helper function code. Like the ``cpu_{ld,st}_mmuidx_ra`` functions
+they perform accesses by guest virtual address, with a given ``mmuidx``.
 
-The ``opindex`` parameter should be created by calling ``make_memop_idx()``.
+These functions specify an ``opindex`` parameter which encodes
+(among other things) the mmu index to use for the access.  This parameter
+should be created by calling ``make_memop_idx()``.
 
 The ``retaddr`` parameter should be the result of GETPC() called directly
 from the top level HELPER(foo) function (or 0 if no guest CPU state
@@ -166,8 +264,9 @@ unwinding is required).
 
 **TODO** The names of these functions are a bit odd for historical
 reasons because they were originally expected to be called only from
-within generated code. We should rename them to bring them
-more in line with the other memory access functions.
+within generated code. We should rename them to bring them more in
+line with the other memory access functions. The explicit endianness
+is the only feature they have beyond ``*_mmuidx_ra``.
 
 load: ``helper_{endian}_ld{sign}{size}_mmu(env, addr, opindex, retaddr)``
 
-- 
2.20.1


