Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A5DC2BB85
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 21:17:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD3D720753
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 21:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EIjH0pA8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD3D720753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMeY5-0003mQ-VV
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 17:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42311)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jMeWQ-00022R-Qb
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 17:15:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jMeWN-0005dc-SE
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 17:15:38 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:54758)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jMeWN-0005cm-Hs
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 17:15:35 -0400
Received: by mail-wm1-x335.google.com with SMTP id h2so265712wmb.4
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 14:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ITHp/kEolbZdKkPDRbNKDAnTtqhWxFt1FMIeHrkT1Fo=;
 b=EIjH0pA8pRF3CNcxE03g2+5nGHDowHA39kZWdTjM91Kzzaw1U1G1u+s0gKRYWOo11H
 s1HjkmXEOUorKI/gNKyP6V2zco1sl0GItYVdAsTVCCaMo4tmx/kEV09bs8rufKb2FRSl
 nap6IfIVU8OrusxITIVo6TxLXJEPaTBbRTuOpRTknPw0kOE/tZxtFvvg7lbuMXfkspNn
 d54oPH+1K9Bg3LJMR0ZJjiJUiHuFNhsSxUo0i2dcMCijbwcJlX7dQk0GSpd4LwFuW9el
 DG/yetckzKTpN0hBBvgdIIBWOSH5gFdidgZaGgvaOFYHiy0afVBmMCsrP1l72RRC63MO
 g7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ITHp/kEolbZdKkPDRbNKDAnTtqhWxFt1FMIeHrkT1Fo=;
 b=JEeKOotHduOeLrSjBH8kC2VcI1LO0pj0I7zG4yNNYKxed2tk9wUgzjrmjAkwzrutai
 SrYyoX6KT2h/d+lXsNvIp5Whob2FAa2IyDTpFyzIozgUyhyqVYSJs1/TEKIL5tkece3T
 BArL0tcee3JmAoWTq1431eq+VtUkhq5sz2J5/s2P6D1JmgislUvuDdtmKV/+iqajAh1k
 G+l4xwuZJHg8iq1no3vSTGIWld9PTthilQFKyKTqHYgaqwGRcQcuyz0Oa798AkW+MyuV
 M78FhcogLiZRVwufSQHdhT2jkGYGVV9tFNzd6ih5+yLmmlDRZG9WAaR3rkTf9IRwA8ud
 TTVw==
X-Gm-Message-State: AGi0PuZDWToxtS3eXP+3vUDGJktB2w+4ko7MnLUaLDd9SnXakxI0ZR55
 QNyeYjsOcBZRONGHKkYAkX4faDjhfPU=
X-Google-Smtp-Source: APiQypIb+qRCYotv8l+yos4iMt7XE/cxP8YlRWt9H216oe7Fr86ISv7VjsQK4z07yvDPlz2I4vtlHA==
X-Received: by 2002:a7b:cd07:: with SMTP id f7mr1775219wmj.30.1586466933990;
 Thu, 09 Apr 2020 14:15:33 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x11sm40545386wru.62.2020.04.09.14.15.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2020 14:15:31 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 211EA1FF87;
 Thu,  9 Apr 2020 22:15:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 01/11] linux-user: completely re-write init_guest_space
Date: Thu,  9 Apr 2020 22:15:19 +0100
Message-Id: <20200409211529.5269-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200409211529.5269-1-alex.bennee@linaro.org>
References: <20200409211529.5269-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

First we ensure all guest space initialisation logic comes through
probe_guest_base once we understand the nature of the binary we are
loading. The convoluted init_guest_space routine is removed and
replaced with a number of pgb_* helpers which are called depending on
what requirements we have when loading the binary.

We first try to do what is requested by the host. Failing that we try
and satisfy the guest requested base address. If all those options
fail we fall back to finding a space in the memory map using our
recently written read_self_maps() helper.

There are some additional complications we try and take into account
when looking for holes in the address space. We try not to go directly
after the system brk() space so there is space for a little growth. We
also don't want to have to use negative offsets which would result in
slightly less efficient code on x86 when it's unable to use the
segment offset register.

Less mind-binding gotos and hopefully clearer logic throughout.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - include rth updates that
    - split probe_guest_base into multiple functions
    - more heuristics on gap finding
---
 linux-user/qemu.h     |  31 ++-
 linux-user/elfload.c  | 503 +++++++++++++++++++++---------------------
 linux-user/flatload.c |   6 +
 linux-user/main.c     |  23 +-
 4 files changed, 277 insertions(+), 286 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 792c74290f8..e1febb88cf5 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -219,18 +219,27 @@ void init_qemu_uname_release(void);
 void fork_start(void);
 void fork_end(int child);
 
-/* Creates the initial guest address space in the host memory space using
- * the given host start address hint and size.  The guest_start parameter
- * specifies the start address of the guest space.  guest_base will be the
- * difference between the host start address computed by this function and
- * guest_start.  If fixed is specified, then the mapped address space must
- * start at host_start.  The real start address of the mapped memory space is
- * returned or -1 if there was an error.
+/**
+ * probe_guest_base:
+ * @image_name: the executable being loaded
+ * @loaddr: the lowest fixed address in the executable
+ * @hiaddr: the highest fixed address in the executable
+ *
+ * Creates the initial guest address space in the host memory space.
+ * 
+ * If @loaddr == 0, then no address in the executable is fixed,
+ * i.e. it is fully relocatable.  In that case @hiaddr is the size
+ * of the executable.
+ *
+ * This function will not return if a valid value for guest_base
+ * cannot be chosen.  On return, the executable loader can expect
+ *
+ *    target_mmap(loaddr, hiaddr - loaddr, ...)
+ *
+ * to succeed.
  */
-unsigned long init_guest_space(unsigned long host_start,
-                               unsigned long host_size,
-                               unsigned long guest_start,
-                               bool fixed);
+void probe_guest_base(const char *image_name,
+                      abi_ulong loaddr, abi_ulong hiaddr);
 
 #include "qemu/log.h"
 
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 619c054cc48..01a9323a637 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -11,6 +11,7 @@
 #include "qemu/queue.h"
 #include "qemu/guest-random.h"
 #include "qemu/units.h"
+#include "qemu/selfmap.h"
 
 #ifdef _ARCH_PPC64
 #undef ARCH_DLINFO
@@ -382,68 +383,30 @@ enum {
 
 /* The commpage only exists for 32 bit kernels */
 
-/* Return 1 if the proposed guest space is suitable for the guest.
- * Return 0 if the proposed guest space isn't suitable, but another
- * address space should be tried.
- * Return -1 if there is no way the proposed guest space can be
- * valid regardless of the base.
- * The guest code may leave a page mapped and populate it if the
- * address is suitable.
- */
-static int init_guest_commpage(unsigned long guest_base,
-                               unsigned long guest_size)
-{
-    unsigned long real_start, test_page_addr;
-
-    /* We need to check that we can force a fault on access to the
-     * commpage at 0xffff0fxx
-     */
-    test_page_addr = guest_base + (0xffff0f00 & qemu_host_page_mask);
-
-    /* If the commpage lies within the already allocated guest space,
-     * then there is no way we can allocate it.
-     *
-     * You may be thinking that that this check is redundant because
-     * we already validated the guest size against MAX_RESERVED_VA;
-     * but if qemu_host_page_mask is unusually large, then
-     * test_page_addr may be lower.
-     */
-    if (test_page_addr >= guest_base
-        && test_page_addr < (guest_base + guest_size)) {
-        return -1;
-    }
+#define ARM_COMMPAGE (intptr_t)0xffff0f00u
 
-    /* Note it needs to be writeable to let us initialise it */
-    real_start = (unsigned long)
-                 mmap((void *)test_page_addr, qemu_host_page_size,
-                     PROT_READ | PROT_WRITE,
-                     MAP_ANONYMOUS | MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+static bool init_guest_commpage(void)
+{
+    void *want = g2h(ARM_COMMPAGE & -qemu_host_page_size);
+    void *addr = mmap(want, qemu_host_page_size, PROT_READ | PROT_WRITE,
+                      MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
 
-    /* If we can't map it then try another address */
-    if (real_start == -1ul) {
-        return 0;
+    if (addr == MAP_FAILED) {
+        perror("Allocating guest commpage");
+        exit(EXIT_FAILURE);
     }
-
-    if (real_start != test_page_addr) {
-        /* OS didn't put the page where we asked - unmap and reject */
-        munmap((void *)real_start, qemu_host_page_size);
-        return 0;
+    if (addr != want) {
+        return false;
     }
 
-    /* Leave the page mapped
-     * Populate it (mmap should have left it all 0'd)
-     */
-
-    /* Kernel helper versions */
-    __put_user(5, (uint32_t *)g2h(0xffff0ffcul));
+    /* Set kernel helper versions; rest of page is 0.  */
+    __put_user(5, (uint32_t *)g2h(0xffff0ffcu));
 
-    /* Now it's populated make it RO */
-    if (mprotect((void *)test_page_addr, qemu_host_page_size, PROT_READ)) {
+    if (mprotect(addr, qemu_host_page_size, PROT_READ)) {
         perror("Protecting guest commpage");
-        exit(-1);
+        exit(EXIT_FAILURE);
     }
-
-    return 1; /* All good */
+    return true;
 }
 
 #define ELF_HWCAP get_elf_hwcap()
@@ -2075,239 +2038,267 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
     return sp;
 }
 
-unsigned long init_guest_space(unsigned long host_start,
-                               unsigned long host_size,
-                               unsigned long guest_start,
-                               bool fixed)
-{
-    /* In order to use host shmat, we must be able to honor SHMLBA.  */
-    unsigned long align = MAX(SHMLBA, qemu_host_page_size);
-    unsigned long current_start, aligned_start;
-    int flags;
-
-    assert(host_start || host_size);
-
-    /* If just a starting address is given, then just verify that
-     * address.  */
-    if (host_start && !host_size) {
-#if defined(TARGET_ARM) && !defined(TARGET_AARCH64)
-        if (init_guest_commpage(host_start, host_size) != 1) {
-            return (unsigned long)-1;
-        }
+#ifndef ARM_COMMPAGE
+#define ARM_COMMPAGE 0
+#define init_guest_commpage() true
 #endif
-        return host_start;
-    }
 
-    /* Setup the initial flags and start address.  */
-    current_start = host_start & -align;
-    flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_NORESERVE;
-    if (fixed) {
-        flags |= MAP_FIXED;
-    }
+static void pgb_fail_in_use(const char *image_name)
+{
+    error_report("%s: requires virtual address space that is in use "
+                 "(omit the -B option or choose a different value)",
+                 image_name);
+    exit(EXIT_FAILURE);
+}
 
-    /* Otherwise, a non-zero size region of memory needs to be mapped
-     * and validated.  */
+static void pgb_have_guest_base(const char *image_name, abi_ulong guest_loaddr,
+                                abi_ulong guest_hiaddr, long align)
+{
+    const int flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_NORESERVE;
+    void *addr, *test;
 
-#if defined(TARGET_ARM) && !defined(TARGET_AARCH64)
-    /* On 32-bit ARM, we need to map not just the usable memory, but
-     * also the commpage.  Try to find a suitable place by allocating
-     * a big chunk for all of it.  If host_start, then the naive
-     * strategy probably does good enough.
-     */
-    if (!host_start) {
-        unsigned long guest_full_size, host_full_size, real_start;
-
-        guest_full_size =
-            (0xffff0f00 & qemu_host_page_mask) + qemu_host_page_size;
-        host_full_size = guest_full_size - guest_start;
-        real_start = (unsigned long)
-            mmap(NULL, host_full_size, PROT_NONE, flags, -1, 0);
-        if (real_start == (unsigned long)-1) {
-            if (host_size < host_full_size - qemu_host_page_size) {
-                /* We failed to map a continous segment, but we're
-                 * allowed to have a gap between the usable memory and
-                 * the commpage where other things can be mapped.
-                 * This sparseness gives us more flexibility to find
-                 * an address range.
-                 */
-                goto naive;
-            }
-            return (unsigned long)-1;
+    if (!QEMU_IS_ALIGNED(guest_base, align)) {
+        fprintf(stderr, "Requested guest base 0x%lx does not satisfy "
+                "host minimum alignment (0x%lx)\n",
+                guest_base, align);
+        exit(EXIT_FAILURE);
+    }
+
+    /* Sanity check the guest binary. */
+    if (reserved_va) {
+        if (guest_hiaddr > reserved_va) {
+            error_report("%s: requires more than reserved virtual "
+                         "address space (0x%" PRIx64 " > 0x%lx)",
+                         image_name, (uint64_t)guest_hiaddr, reserved_va);
+            exit(EXIT_FAILURE);
         }
-        munmap((void *)real_start, host_full_size);
-        if (real_start & (align - 1)) {
-            /* The same thing again, but with extra
-             * so that we can shift around alignment.
-             */
-            unsigned long real_size = host_full_size + qemu_host_page_size;
-            real_start = (unsigned long)
-                mmap(NULL, real_size, PROT_NONE, flags, -1, 0);
-            if (real_start == (unsigned long)-1) {
-                if (host_size < host_full_size - qemu_host_page_size) {
-                    goto naive;
-                }
-                return (unsigned long)-1;
-            }
-            munmap((void *)real_start, real_size);
-            real_start = ROUND_UP(real_start, align);
+    } else {
+        if ((guest_hiaddr - guest_base) > ~(uintptr_t)0) {
+            error_report("%s: requires more virtual address space "
+                         "than the host can provide (0x%" PRIx64 ")",
+                         image_name, (uint64_t)guest_hiaddr - guest_base);
+            exit(EXIT_FAILURE);
         }
-        current_start = real_start;
     }
- naive:
-#endif
 
-    while (1) {
-        unsigned long real_start, real_size, aligned_size;
-        aligned_size = real_size = host_size;
+    /*
+     * Expand the allocation to the entire reserved_va.
+     * Exclude the mmap_min_addr hole.
+     */
+    if (reserved_va) {
+        guest_loaddr = (guest_base >= mmap_min_addr ? 0
+                        : mmap_min_addr - guest_base);
+        guest_hiaddr = reserved_va;
+    }
 
-        /* Do not use mmap_find_vma here because that is limited to the
-         * guest address space.  We are going to make the
-         * guest address space fit whatever we're given.
-         */
-        real_start = (unsigned long)
-            mmap((void *)current_start, host_size, PROT_NONE, flags, -1, 0);
-        if (real_start == (unsigned long)-1) {
-            return (unsigned long)-1;
-        }
+    /* Reserve the address space for the binary, or reserved_va. */
+    test = g2h(guest_loaddr);
+    addr = mmap(test, guest_hiaddr - guest_loaddr, PROT_NONE, flags, -1, 0);
+    if (test != addr) {
+        pgb_fail_in_use(image_name);
+    }
+}
 
-        /* Check to see if the address is valid.  */
-        if (host_start && real_start != current_start) {
-            qemu_log_mask(CPU_LOG_PAGE, "invalid %lx && %lx != %lx\n",
-                          host_start, real_start, current_start);
-            goto try_again;
+/* Return value for guest_base, or -1 if no hole found. */
+static uintptr_t pgb_find_hole(uintptr_t guest_loaddr, uintptr_t guest_size,
+                               long align)
+{
+    GSList *maps, *iter;
+    uintptr_t this_start, this_end, next_start, brk;
+    intptr_t ret = -1;
+
+    assert(QEMU_IS_ALIGNED(guest_loaddr, align));
+
+    maps = read_self_maps();
+
+    /* Read brk after we've read the maps, which will malloc. */
+    brk = (uintptr_t)sbrk(0);
+
+    /* The first hole is before the first map entry. */
+    this_start = mmap_min_addr;
+
+    for (iter = maps; iter;
+         this_start = next_start, iter = g_slist_next(iter)) {
+        uintptr_t align_start, hole_size;
+
+        this_end = ((MapInfo *)iter->data)->start;
+        next_start = ((MapInfo *)iter->data)->end;
+        align_start = ROUND_UP(this_start, align);
+
+        /* Skip holes that are too small. */
+        if (align_start >= this_end) {
+            continue;
+        }
+        hole_size = this_end - align_start;
+        if (hole_size < guest_size) {
+            continue;
         }
 
-        /* Ensure the address is properly aligned.  */
-        if (real_start & (align - 1)) {
-            /* Ideally, we adjust like
-             *
-             *    pages: [  ][  ][  ][  ][  ]
-             *      old:   [   real   ]
-             *             [ aligned  ]
-             *      new:   [     real     ]
-             *               [ aligned  ]
-             *
-             * But if there is something else mapped right after it,
-             * then obviously it won't have room to grow, and the
-             * kernel will put the new larger real someplace else with
-             * unknown alignment (if we made it to here, then
-             * fixed=false).  Which is why we grow real by a full page
-             * size, instead of by part of one; so that even if we get
-             * moved, we can still guarantee alignment.  But this does
-             * mean that there is a padding of < 1 page both before
-             * and after the aligned range; the "after" could could
-             * cause problems for ARM emulation where it could butt in
-             * to where we need to put the commpage.
-             */
-            munmap((void *)real_start, host_size);
-            real_size = aligned_size + align;
-            real_start = (unsigned long)
-                mmap((void *)real_start, real_size, PROT_NONE, flags, -1, 0);
-            if (real_start == (unsigned long)-1) {
-                return (unsigned long)-1;
+        /* If this hole contains brk, give ourselves some room to grow. */
+        if (this_start <= brk && brk < this_end) {
+            hole_size -= guest_size;
+            if (sizeof(uintptr_t) == 8 && hole_size >= 1 * GiB) {
+                align_start += 1 * GiB;
+            } else if (hole_size >= 16 * MiB) {
+                align_start += 16 * MiB;
+            } else {
+                align_start = (this_end - guest_size) & -align;
+                if (align_start < this_start) {
+                    continue;
+                }
             }
-            aligned_start = ROUND_UP(real_start, align);
-        } else {
-            aligned_start = real_start;
         }
 
-#if defined(TARGET_ARM) && !defined(TARGET_AARCH64)
-        /* On 32-bit ARM, we need to also be able to map the commpage.  */
-        int valid = init_guest_commpage(aligned_start - guest_start,
-                                        aligned_size + guest_start);
-        if (valid == -1) {
-            munmap((void *)real_start, real_size);
-            return (unsigned long)-1;
-        } else if (valid == 0) {
-            goto try_again;
+        /* Record the lowest successful match. */
+        if (ret < 0) {
+            ret = align_start - guest_loaddr;
         }
-#endif
-
-        /* If nothing has said `return -1` or `goto try_again` yet,
-         * then the address we have is good.
-         */
-        break;
-
-    try_again:
-        /* That address didn't work.  Unmap and try a different one.
-         * The address the host picked because is typically right at
-         * the top of the host address space and leaves the guest with
-         * no usable address space.  Resort to a linear search.  We
-         * already compensated for mmap_min_addr, so this should not
-         * happen often.  Probably means we got unlucky and host
-         * address space randomization put a shared library somewhere
-         * inconvenient.
-         *
-         * This is probably a good strategy if host_start, but is
-         * probably a bad strategy if not, which means we got here
-         * because of trouble with ARM commpage setup.
-         */
-        if (munmap((void *)real_start, real_size) != 0) {
-            error_report("%s: failed to unmap %lx:%lx (%s)", __func__,
-                         real_start, real_size, strerror(errno));
-            abort();
+        /* If this hole contains the identity map, select it. */
+        if (align_start <= guest_loaddr &&
+            guest_loaddr + guest_size <= this_end) {
+            ret = 0;
         }
-        current_start += align;
-        if (host_start == current_start) {
-            /* Theoretically possible if host doesn't have any suitably
-             * aligned areas.  Normally the first mmap will fail.
-             */
-            return (unsigned long)-1;
+        /* If this hole ends above the identity map, stop looking. */
+        if (this_end >= guest_loaddr) {
+            break;
         }
     }
+    free_self_maps(maps);
 
-    qemu_log_mask(CPU_LOG_PAGE, "Reserved 0x%lx bytes of guest address space\n", host_size);
-
-    return aligned_start;
+    return ret;
 }
 
-static void probe_guest_base(const char *image_name,
-                             abi_ulong loaddr, abi_ulong hiaddr)
+static void pgb_static(const char *image_name, abi_ulong orig_loaddr,
+                       abi_ulong orig_hiaddr, long align)
 {
-    /* Probe for a suitable guest base address, if the user has not set
-     * it explicitly, and set guest_base appropriately.
-     * In case of error we will print a suitable message and exit.
-     */
-    const char *errmsg;
-    if (!have_guest_base && !reserved_va) {
-        unsigned long host_start, real_start, host_size;
+    uintptr_t loaddr = orig_loaddr;
+    uintptr_t hiaddr = orig_hiaddr;
+    uintptr_t addr;
 
-        /* Round addresses to page boundaries.  */
-        loaddr &= qemu_host_page_mask;
-        hiaddr = HOST_PAGE_ALIGN(hiaddr);
+    if (hiaddr != orig_hiaddr) {
+        error_report("%s: requires virtual address space that the "
+                     "host cannot provide (0x%" PRIx64 ")",
+                     image_name, (uint64_t)orig_hiaddr);
+        exit(EXIT_FAILURE);
+    }
 
-        if (loaddr < mmap_min_addr) {
-            host_start = HOST_PAGE_ALIGN(mmap_min_addr);
+    loaddr &= -align;
+    if (ARM_COMMPAGE) {
+        /*
+         * Extend the allocation to include the commpage.
+         * For a 64-bit host, this is just 4GiB; for a 32-bit host,
+         * the address arithmetic will wrap around, but the difference
+         * will produce the correct allocation size.
+         */
+        if (sizeof(uintptr_t) == 8 || loaddr >= 0x80000000u) {
+            hiaddr = (uintptr_t)4 << 30;
         } else {
-            host_start = loaddr;
-            if (host_start != loaddr) {
-                errmsg = "Address overflow loading ELF binary";
-                goto exit_errmsg;
-            }
+            loaddr = ARM_COMMPAGE & -align;
         }
-        host_size = hiaddr - loaddr;
+    }
 
-        /* Setup the initial guest memory space with ranges gleaned from
-         * the ELF image that is being loaded.
+    addr = pgb_find_hole(loaddr, hiaddr - loaddr, align);
+    if (addr == -1) {
+        /*
+         * If ARM_COMMPAGE, there *might* be a non-consecutive allocation
+         * that can satisfy both.  But as the normal arm32 link base address
+         * is ~32k, and we extend down to include the commpage, making the
+         * overhead only ~96k, this is unlikely.
          */
-        real_start = init_guest_space(host_start, host_size, loaddr, false);
-        if (real_start == (unsigned long)-1) {
-            errmsg = "Unable to find space for application";
-            goto exit_errmsg;
-        }
-        guest_base = real_start - loaddr;
+        error_report("%s: Unable to allocate %#zx bytes of "
+                     "virtual address space", image_name,
+                     (size_t)(hiaddr - loaddr));
+        exit(EXIT_FAILURE);
+    }
+
+    guest_base = addr;
+}
+
+static void pgb_dynamic(const char *image_name, long align)
+{
+    /*
+     * The executable is dynamic and does not require a fixed address.
+     * All we need is a commpage that satisfies align.
+     * If we do not need a commpage, leave guest_base == 0.
+     */
+    if (ARM_COMMPAGE) {
+        uintptr_t addr, commpage;
 
-        qemu_log_mask(CPU_LOG_PAGE, "Relocating guest address space from 0x"
-                      TARGET_ABI_FMT_lx " to 0x%lx\n",
-                      loaddr, real_start);
+        /* 64-bit hosts should have used reserved_va. */
+        assert(sizeof(uintptr_t) == 4);
+
+        /*
+         * By putting the commpage at the first hole, that puts guest_base
+         * just above that, and maximises the positive guest addresses.
+         */
+        commpage = ARM_COMMPAGE & -align;
+        addr = pgb_find_hole(commpage, -commpage, align);
+        assert(addr != -1);
+        guest_base = addr;
     }
-    return;
+}
 
-exit_errmsg:
-    fprintf(stderr, "%s: %s\n", image_name, errmsg);
-    exit(-1);
+static void pgb_reserved_va(const char *image_name, abi_ulong guest_loaddr,
+                            abi_ulong guest_hiaddr, long align)
+{
+    const int flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_NORESERVE;
+    void *addr, *test;
+
+    if (guest_hiaddr > reserved_va) {
+        error_report("%s: requires more than reserved virtual "
+                     "address space (0x%" PRIx64 " > 0x%lx)",
+                     image_name, (uint64_t)guest_hiaddr, reserved_va);
+        exit(EXIT_FAILURE);
+    }
+
+    /* Widen the "image" to the entire reserved address space. */
+    pgb_static(image_name, 0, reserved_va, align);
+
+    /* Reserve the memory on the host. */
+    assert(guest_base != 0);
+    test = g2h(0);
+    addr = mmap(test, reserved_va, PROT_NONE, flags, -1, 0);
+    if (addr == MAP_FAILED) {
+        error_report("Unable to reserve 0x%lx bytes of virtual address "
+                     "space for use as guest address space (check your "
+                     "virtual memory ulimit setting or reserve less "
+                     "using -R option)", reserved_va);
+        exit(EXIT_FAILURE);
+    }
+    assert(addr == test);
 }
 
+void probe_guest_base(const char *image_name, abi_ulong guest_loaddr,
+                      abi_ulong guest_hiaddr)
+{
+    /* In order to use host shmat, we must be able to honor SHMLBA.  */
+    uintptr_t align = MAX(SHMLBA, qemu_host_page_size);
+
+    if (have_guest_base) {
+        pgb_have_guest_base(image_name, guest_loaddr, guest_hiaddr, align);
+    } else if (reserved_va) {
+        pgb_reserved_va(image_name, guest_loaddr, guest_hiaddr, align);
+    } else if (guest_loaddr) {
+        pgb_static(image_name, guest_loaddr, guest_hiaddr, align);
+    } else {
+        pgb_dynamic(image_name, align);
+    }
+
+    /* Reserve and initialize the commpage. */
+    if (!init_guest_commpage()) {
+        /*
+         * With have_guest_base, the user has selected the address and
+         * we are trying to work with that.  Otherwise, we have selected
+         * free space and init_guest_commpage must succeeded.
+         */
+        assert(have_guest_base);
+        pgb_fail_in_use(image_name);
+    }
+
+    assert(QEMU_IS_ALIGNED(guest_base, align));
+    qemu_log_mask(CPU_LOG_PAGE, "Locating guest address space "
+                  "@ 0x%" PRIx64 "\n", (uint64_t)guest_base);
+}
 
 /* Load an ELF image into the address space.
 
@@ -2399,6 +2390,12 @@ static void load_elf_image(const char *image_name, int image_fd,
              * MMAP_MIN_ADDR or the QEMU application itself.
              */
             probe_guest_base(image_name, loaddr, hiaddr);
+        } else {
+            /*
+             * The binary is dynamic, but we still need to
+             * select guest_base.  In this case we pass a size.
+             */
+            probe_guest_base(image_name, 0, hiaddr - loaddr);
         }
     }
 
diff --git a/linux-user/flatload.c b/linux-user/flatload.c
index 0122ab3afe6..952b4cb26d8 100644
--- a/linux-user/flatload.c
+++ b/linux-user/flatload.c
@@ -441,6 +441,12 @@ static int load_flat_file(struct linux_binprm * bprm,
     indx_len = MAX_SHARED_LIBS * sizeof(abi_ulong);
     indx_len = (indx_len + 15) & ~(abi_ulong)15;
 
+    /*
+     * Alloate the address space.
+     */
+    probe_guest_base(bprm->filename, 0,
+                     text_len + data_len + extra + indx_len);
+
     /*
      * there are a couple of cases here,  the separate code/data
      * case,  and then the fully copied to RAM case which lumps
diff --git a/linux-user/main.c b/linux-user/main.c
index 22578b16336..1d20a83d4e8 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -24,6 +24,7 @@
 #include "qemu-version.h"
 #include <sys/syscall.h>
 #include <sys/resource.h>
+#include <sys/shm.h>
 
 #include "qapi/error.h"
 #include "qemu.h"
@@ -747,28 +748,6 @@ int main(int argc, char **argv, char **envp)
     target_environ = envlist_to_environ(envlist, NULL);
     envlist_free(envlist);
 
-    /*
-     * Now that page sizes are configured in tcg_exec_init() we can do
-     * proper page alignment for guest_base.
-     */
-    guest_base = HOST_PAGE_ALIGN(guest_base);
-
-    if (reserved_va || have_guest_base) {
-        guest_base = init_guest_space(guest_base, reserved_va, 0,
-                                      have_guest_base);
-        if (guest_base == (unsigned long)-1) {
-            fprintf(stderr, "Unable to reserve 0x%lx bytes of virtual address "
-                    "space for use as guest address space (check your virtual "
-                    "memory ulimit setting or reserve less using -R option)\n",
-                    reserved_va);
-            exit(EXIT_FAILURE);
-        }
-
-        if (reserved_va) {
-            mmap_next_start = reserved_va;
-        }
-    }
-
     /*
      * Read in mmap_min_addr kernel parameter.  This value is used
      * When loading the ELF image to determine whether guest_base
-- 
2.20.1


