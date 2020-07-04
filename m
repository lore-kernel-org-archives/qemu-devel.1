Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C87FC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:34:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F53520724
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F53520724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrl76-0000rF-9f
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 12:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jrkzb-0005ax-JA
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 12:26:19 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:57367)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jrkzS-0002Pd-Ak
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 12:26:18 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MqJyX-1kepBq0PLv-00nSNG; Sat, 04 Jul 2020 18:26:01 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 09/12] linux-user: Add strace support for printing arguments of
 fallocate()
Date: Sat,  4 Jul 2020 18:25:42 +0200
Message-Id: <20200704162545.311133-10-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704162545.311133-1-laurent@vivier.eu>
References: <20200704162545.311133-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7XmTRK8VlOZpkscqkLnES9Gyntcavkz6rWMS0o7riS0XVxq4SQ9
 eTbdSCRO//59HhlEcqNxCxYhKt6zm7bWFsjQcLd0P4NFxR5hEjduPLt8wHoP3OQAPkPWGHi
 R3vj4HYcNLzHZG8b/osaSNUCdrW7H5TN0nEYe3JgKyjFgMhWDSVgRyh+Zp8qNCZIn9JLH8L
 FaAbGlIbot7g8voJPIIqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d/l9t9vXShE=:6UFHjv4pdA6mR8XQD1cddt
 GqyDbN7EpEzpN5ARAh4ql/qAcva6vOnpQBVIrNHxuo271yGdFZuEPh9db4nalOhSoBCprgCQG
 m1mTlIaXeS+GLD86wrSIOU7+UF8icQSiLaMuoTHioZ5tVE7gbF4vZIKecVHYzJbCVb/acnEPN
 0L3WCFgF7ZLjjoc+Wbmr9b/fUU9s1dcMyXT+hYjRJ2hm6btBA1jX8S6s3BLzDdLR4zEOgD+8o
 SI3KbPMLM4rAjZFCbmCJceFashP2x8OGBHTfBm0wLAGbIsb6OWdir4Eo1+gf7hVRg1a6x8UfN
 R3f2U3Wmo+wYEh8TE3xZihHoiw8IjmndlfKrpH9bOjG1DTC+DHcp8S/PhL1rsq6ArF/zXTD3b
 uYQLjnukKpcsKYbNpu+kzAy2j8OXKZLQZrOBmk3wMKZnOxDTsoKT2FXUaEeWddU3p/rgQPKIw
 GQtvqc05IEwLwOFXeqc76b/kXHpw6Cd+YBhOPtWl11slqf1yir9EaYRqq7gU/6LuToXUoew/S
 7NPd2A0EUQ77ofpwekR2qKINq6+E8yfU4ZEMCdSDBs81Z2GU8oveZw0GTXnqJEO1T7GaGf3NC
 pPplzNA1idygZ3onC+rTKmJL6opq0Gtgfzi4HX0Js3CTtDt5RrG2byxVCod/mG328MO4f35cf
 aAQEDDnwYrWnj9C3mfmwLiUOWGjBfBo8M/TSFGOviH1DWWl+5aF9YpYYvnK8fxsnoYQP5uIvR
 8oNxUUNO/rOBvw2np5VYcQR7mCY9T6LJiS7yBFoh9uDzMqqApdAL1gXiNWwLp8RlhDTtN/Bf8
 AU0tqh6lnjOoI+X7p4w5hHGssmBqHWvaKZzrGcW8jZsRVqc1GA=
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 12:26:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Filip Bozuta <Filip.Bozuta@syrmia.com>, Riku Voipio <riku.voipio@iki.fi>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Filip Bozuta <Filip.Bozuta@syrmia.com>

This patch implements strace argument printing functionality for following syscall:

    *fallocate - manipulate file space

        int fallocate(int fd, int mode, off_t offset, off_t len)
        man page: https://www.man7.org/linux/man-pages/man2/fallocate.2.html

Implementation notes:

    This syscall's second argument "mode" is composed of predefined values
    which represent flags that determine the type of operation that is
    to be performed on the file space. For that reason, a printing
    function "print_fallocate" was stated in file "strace.list". This printing
    function uses an already existing function "print_flags()" to print flags of
    the "mode" argument. These flags are stated inside an array "falloc_flags"
    that contains values of type "struct flags". These values are instantiated
    using an existing macro "FLAG_GENERIC()". Most of these flags are defined
    after kernel version 3.0 which is why they are enwrapped in an #ifdef
    directive.
    The syscall's third ant fourth argument are of type "off_t" which can
    cause variations between 32/64-bit architectures. To handle this variation,
    function "target_offset64()" was copied from file "strace.c" and used in
    "print_fallocate" to print "off_t" arguments for 32-bit architectures.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200619123331.17387-7-filip.bozuta@syrmia.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/qemu.h      | 16 ++++++++++++++++
 linux-user/strace.c    | 40 ++++++++++++++++++++++++++++++++++++++++
 linux-user/strace.list |  2 +-
 linux-user/syscall.c   | 16 ----------------
 4 files changed, 57 insertions(+), 17 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 8f938b8105b3..be67391ba49d 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -670,6 +670,22 @@ static inline int is_error(abi_long ret)
     return (abi_ulong)ret >= (abi_ulong)(-4096);
 }
 
+#if TARGET_ABI_BITS == 32
+static inline uint64_t target_offset64(uint32_t word0, uint32_t word1)
+{
+#ifdef TARGET_WORDS_BIGENDIAN
+    return ((uint64_t)word0 << 32) | word1;
+#else
+    return ((uint64_t)word1 << 32) | word0;
+#endif
+}
+#else /* TARGET_ABI_BITS == 32 */
+static inline uint64_t target_offset64(uint64_t word0, uint64_t word1)
+{
+    return word0;
+}
+#endif /* TARGET_ABI_BITS != 32 */
+
 /**
  * preexit_cleanup: housekeeping before the guest exits
  *
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 957f08f1adf2..32e5e987acbb 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1135,6 +1135,26 @@ UNUSED static struct flags statx_mask[] = {
     FLAG_END,
 };
 
+UNUSED static struct flags falloc_flags[] = {
+    FLAG_GENERIC(FALLOC_FL_KEEP_SIZE),
+    FLAG_GENERIC(FALLOC_FL_PUNCH_HOLE),
+#ifdef FALLOC_FL_NO_HIDE_STALE
+    FLAG_GENERIC(FALLOC_FL_NO_HIDE_STALE),
+#endif
+#ifdef FALLOC_FL_COLLAPSE_RANGE
+    FLAG_GENERIC(FALLOC_FL_COLLAPSE_RANGE),
+#endif
+#ifdef FALLOC_FL_ZERO_RANGE
+    FLAG_GENERIC(FALLOC_FL_ZERO_RANGE),
+#endif
+#ifdef FALLOC_FL_INSERT_RANGE
+    FLAG_GENERIC(FALLOC_FL_INSERT_RANGE),
+#endif
+#ifdef FALLOC_FL_UNSHARE_RANGE
+    FLAG_GENERIC(FALLOC_FL_UNSHARE_RANGE),
+#endif
+};
+
 /*
  * print_xxx utility functions.  These are used to print syscall
  * parameters in certain format.  All of these have parameter
@@ -1552,6 +1572,26 @@ print_faccessat(const struct syscallname *name,
 }
 #endif
 
+#ifdef TARGET_NR_fallocate
+static void
+print_fallocate(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_raw_param("%d", arg0, 0);
+    print_flags(falloc_flags, arg1, 0);
+#if TARGET_ABI_BITS == 32
+    print_raw_param("%" PRIu64, target_offset64(arg2, arg3), 0);
+    print_raw_param("%" PRIu64, target_offset64(arg4, arg5), 1);
+#else
+    print_raw_param(TARGET_ABI_FMT_ld, arg2, 0);
+    print_raw_param(TARGET_ABI_FMT_ld, arg3, 1);
+#endif
+    print_syscall_epilogue(name);
+}
+#endif
+
 #ifdef TARGET_NR_fchmodat
 static void
 print_fchmodat(const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index e99030c9ef39..ebb713252ce3 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -182,7 +182,7 @@
 { TARGET_NR_fadvise64_64, "fadvise64_64" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_fallocate
-{ TARGET_NR_fallocate, "fallocate" , NULL, NULL, NULL },
+{ TARGET_NR_fallocate, "fallocate" , NULL, print_fallocate, NULL },
 #endif
 #ifdef TARGET_NR_fanotify_init
 { TARGET_NR_fanotify_init, "fanotify_init" , NULL, NULL, NULL },
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1b971c06b270..506b94a12c1e 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6712,22 +6712,6 @@ void syscall_init(void)
     }
 }
 
-#if TARGET_ABI_BITS == 32
-static inline uint64_t target_offset64(uint32_t word0, uint32_t word1)
-{
-#ifdef TARGET_WORDS_BIGENDIAN
-    return ((uint64_t)word0 << 32) | word1;
-#else
-    return ((uint64_t)word1 << 32) | word0;
-#endif
-}
-#else /* TARGET_ABI_BITS == 32 */
-static inline uint64_t target_offset64(uint64_t word0, uint64_t word1)
-{
-    return word0;
-}
-#endif /* TARGET_ABI_BITS != 32 */
-
 #ifdef TARGET_NR_truncate64
 static inline abi_long target_truncate64(void *cpu_env, const char *arg1,
                                          abi_long arg2,
-- 
2.26.2


