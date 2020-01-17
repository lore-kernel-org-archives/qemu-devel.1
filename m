Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FB0C33C9E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 23:03:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D927D21D56
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 23:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H5HcVSRY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D927D21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isaeS-0005DN-W5
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 18:03:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60466)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1isadi-0004nY-Tk
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 18:02:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1isadh-0005SC-Bt
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 18:02:54 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:54498)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1isadh-0005RP-4E
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 18:02:53 -0500
Received: by mail-pj1-x1042.google.com with SMTP id kx11so3789632pjb.4
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 15:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mqwe24H3WsoE3utDrl3oS0jUQFJQ4y0iDX1chnXSTXU=;
 b=H5HcVSRYqVI4uAc7TQ+a0XijffNVjkk7kHHRIv+wjGcrnlZZDb2uQWXA80Zt53TdZy
 DsfVOJj3g/nFOKBaIO2SFvwAOBjbH7zW8fL9g17uK9GGL+rVnrVcr7V+Q12/Z9o3T+SM
 cmcYUlVn+j/JTneyUVCW4AQEnhuQoLWZLe9BVvhGuk/mCTrfS+KJTxuF8unpfExY+XAT
 kWaDVjXZKeNX/eM2lK5e65O1u0AyPyHHf4bp+WL/n2hMFSMu8sEEiQhXNvAyuUZOcWFa
 oM1mLq0A7dehLk59EiGZln41KTZeVm6a1AF+8sjPcfr3kC4l6dkvFq6TzqBxtVlBXAeF
 PNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mqwe24H3WsoE3utDrl3oS0jUQFJQ4y0iDX1chnXSTXU=;
 b=fNNuQ7+wy3d2O5dLYiJIN35x+1BrKfWc9NFkhP1Y+5VUjd4TJ8LF/RWoWHNzXIVxf8
 NQtz7p//fQF0FsEbmAXnNhZXFqF+o2RpU1q5ErUkiRVZ0VhfcP/Ocd2TaE74sekbcQEy
 Jli/jVN6AT6JFrA3Za+fm3AeDSH5DCgojHpMm65k3EbqNDH/BIjEeFzARGfz9jX7t/Gc
 xrkISxWXC8GqOWHLgEgZiU3Cr0kA84bWRBAB8rJKCie4oheQEtyL59CNssb67oOAPtTV
 THkopQlX6JX4JfWGGXWR66XRixEnZgvDGlsmPqTQmHln+2ekk2L37lHCJ2dw9wqTkEtL
 XYwA==
X-Gm-Message-State: APjAAAU5/y5KiJl2blJaAq4Ssl3aOeAXVqpnlgcmd/RKDmPreHUYBF8p
 2OIeIdn0LVpAO8CqPbsmrCcaeiWlv/I=
X-Google-Smtp-Source: APXvYqzn64039hbAI0DrNsQonHcdT4txWnS055Gn12M4vrCdQTJasbEqyqIOELr2ru8XvXBdyJjIiQ==
X-Received: by 2002:a17:90a:d156:: with SMTP id
 t22mr8401400pjw.108.1579302171504; 
 Fri, 17 Jan 2020 15:02:51 -0800 (PST)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id g8sm30181688pfh.43.2020.01.17.15.02.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2020 15:02:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] linux-user: Reserve space for brk
Date: Fri, 17 Jan 2020 13:02:45 -1000
Message-Id: <20200117230245.5040-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
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
Cc: alex.bennee@linaro.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With bad luck, we can wind up with no space at all for brk,
which will generally cause the guest malloc to fail.

This bad luck is easier to come by with ET_DYN (PIE) binaries,
where either the stack or the interpreter (ld.so) gets placed
immediately after the main executable.

But there's nothing preventing this same thing from happening
with ET_EXEC (normal) binaries, during probe_guest_base().

In both cases, reserve some extra space via mmap and release
it back to the system after loading the interpreter and
allocating the stack.

The choice of 16MB is somewhat arbitrary.  It's enough for libc
to get going, but without being so large that 32-bit guests or
32-bit hosts are in danger of running out of virtual address space.
It is expected that libc will be able to fall back to mmap arenas
after the limited brk space is exhausted.

Launchpad: https://bugs.launchpad.net/qemu/+bug/1749393
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

Note that the LP comments mention the fix for this in the kernel,
and about there being a "guaranteed 128MB gap" for x86_64.  As far
as I can see, this "gap" is part of the unmapped_area() algorithm.
For qemu, this would correspond to mmap_find_vma(), except that,
except when we fall back to mmap_find_vma_reserved(), we are not
100% in control over the allocation.


r~

---
 linux-user/qemu.h    |  1 +
 linux-user/elfload.c | 73 +++++++++++++++++++++++++++++++++-----------
 2 files changed, 57 insertions(+), 17 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index f6f5fe5fbb..560a68090e 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -35,6 +35,7 @@ struct image_info {
         abi_ulong       end_data;
         abi_ulong       start_brk;
         abi_ulong       brk;
+        abi_ulong       reserve_brk;
         abi_ulong       start_mmap;
         abi_ulong       start_stack;
         abi_ulong       stack_limit;
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 07b16cc0f4..2edb5d5b31 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -10,6 +10,7 @@
 #include "qemu/path.h"
 #include "qemu/queue.h"
 #include "qemu/guest-random.h"
+#include "qemu/units.h"
 
 #ifdef _ARCH_PPC64
 #undef ARCH_DLINFO
@@ -2364,24 +2365,51 @@ static void load_elf_image(const char *image_name, int image_fd,
         }
     }
 
-    load_addr = loaddr;
-    if (ehdr->e_type == ET_DYN) {
-        /* The image indicates that it can be loaded anywhere.  Find a
-           location that can hold the memory space required.  If the
-           image is pre-linked, LOADDR will be non-zero.  Since we do
-           not supply MAP_FIXED here we'll use that address if and
-           only if it remains available.  */
-        load_addr = target_mmap(loaddr, hiaddr - loaddr, PROT_NONE,
-                                MAP_PRIVATE | MAP_ANON | MAP_NORESERVE,
-                                -1, 0);
-        if (load_addr == -1) {
-            goto exit_perror;
+    if (pinterp_name != NULL) {
+        /*
+         * This is the main executable.
+         *
+         * Reserve extra space for brk.
+         * We hold on to this space while placing the interpreter
+         * and the stack, lest they be placed immediately after
+         * the data segment and block allocation from the brk.
+         *
+         * 16MB is chosen as "large enough" without being so large
+         * as to allow the result to not fit with a 32-bit guest on
+         * a 32-bit host.
+         */
+        info->reserve_brk = 16 * MiB;
+        hiaddr += info->reserve_brk;
+
+        if (ehdr->e_type == ET_EXEC) {
+            /*
+             * Make sure that the low address does not conflict with
+             * MMAP_MIN_ADDR or the QEMU application itself.
+             */
+            probe_guest_base(image_name, loaddr, hiaddr);
         }
-    } else if (pinterp_name != NULL) {
-        /* This is the main executable.  Make sure that the low
-           address does not conflict with MMAP_MIN_ADDR or the
-           QEMU application itself.  */
-        probe_guest_base(image_name, loaddr, hiaddr);
+    }
+
+    /*
+     * Reserve address space for all of this.
+     *
+     * In the case of ET_EXEC, we supply MAP_FIXED so that we get
+     * exactly the address range that is required.
+     *
+     * Otherwise this is ET_DYN, and we are searching for a location
+     * that can hold the memory space required.  If the image is
+     * pre-linked, LOADDR will be non-zero, and the kernel should
+     * honor that address if it happens to be free.
+     *
+     * In both cases, we will overwrite pages in this range with mappings
+     * from the executable.
+     */
+    load_addr = target_mmap(loaddr, hiaddr - loaddr, PROT_NONE,
+                            MAP_PRIVATE | MAP_ANON | MAP_NORESERVE |
+                            (ehdr->e_type == ET_EXEC ? MAP_FIXED : 0),
+                            -1, 0);
+    if (load_addr == -1) {
+        goto exit_perror;
     }
     load_bias = load_addr - loaddr;
 
@@ -2860,6 +2888,17 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
     bprm->core_dump = &elf_core_dump;
 #endif
 
+    /*
+     * If we reserved extra space for brk, release it now.
+     * The implementation of do_brk in syscalls.c expects to be able
+     * to mmap pages in this space.
+     */
+    if (info->reserve_brk) {
+        abi_ulong start_brk = HOST_PAGE_ALIGN(info->brk);
+        abi_ulong end_brk = HOST_PAGE_ALIGN(info->brk + info->reserve_brk);
+        target_munmap(start_brk, end_brk - start_brk);
+    }
+
     return 0;
 }
 
-- 
2.20.1


