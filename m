Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF67C33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:34:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 126F124655
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:34:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 126F124655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuXwb-00086e-2k
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 03:34:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56001)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iuXlM-00014r-0w
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:22:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iuXlG-0002tW-ON
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:22:51 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:42647)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iuXlG-0002qO-En
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:22:46 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mi2eP-1jXz7D2MDZ-00e7Vw; Thu, 23 Jan 2020 09:22:34 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 02/17] linux-user: Reserve space for brk
Date: Thu, 23 Jan 2020 09:22:12 +0100
Message-Id: <20200123082227.2037994-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200123082227.2037994-1-laurent@vivier.eu>
References: <20200123082227.2037994-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yyYTQ6TTuAdWqXFFVCVNYHK+iP45nYTEaSADh1Q9vNrinQUKSRS
 mZ/H0r/XGc7aW7/FTxHC8nOo3dNwOScc4D5kycVu7od2tPtdAOv+usx0SOrP9G7NLvrktVZ
 QqyMv3TtHqVCnhbFAlIsc/3g7gf14C16cP0151xXxqR1JJjre8bHUVPW/YM4YlgvSLOvSIG
 fv7JleOOQzVg/LevBUmxA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iRwKJMiXTTk=:7ZePQvzAleG+hYP2plFoBO
 e5T+pTe7gnjV/zEpITkFLIeV9u+3BQ2YDDDgggjIiR1jcNe0JZkskcGBp2Cfe08YvubG15/BH
 5twqUjSbEYQ/F0NpzxyVNJfX57WqIobvsWPtkEOq8Cl54mVCQ1QedPNO9V6dSN2R+kmx4tuRC
 2qOeIx8d6oAkrt+NQXeN2IY7PbsHo9bgqRbht4+P/r/aYd9goucl+gdRFwpKOK9sg/kSMIhY4
 eB48P6eRSb7xRp0g+X3xW25T+Ztirix4cSkWHTnf/o9cPu9BKz0tAikGZ8zO9iU9GBENCebsV
 jUS5NdDodKyKrvx8+gmACts1cBRgyQuHeiB6nTOOekBSoTKkQPnxvmZbKRFu9D+/HnCMBI4q9
 dZQsIhiGcBlstK4DmwSBYMHNPwIVRWuviJNRyyuAEm2oheL8DzIpBKVLAFV9JlauCkS5pWOVR
 HtbNNZ9Ogww8a0i+eEbReDQlua4iYQzxEeiJlYb/wNSDjD2TsOjaCTJq4TbZNE8JBqfPIGqcP
 6PawTKdN1hoKra2Sg9cw3YDz42WPOwBDrjb3fp1qWeeAnmk0TGVNehKj9u7uIXjSKCe+GuBxS
 blDvlVkc3+8fzLFI/iQEPfyciCQWC2QuiGmTAfF87fMtWCt8fLpL/CetqxOQIIbT5DMgzx3aq
 Trkh7Zaj5C4EoQmsHB8DYpwsbUBQQig4pUcXFJ6/jF/91YiNM+nJWbVIFlnOcwy+OIEfTPknk
 9zcvpCnyym2JSs7Dx5iawTGTmeMJhKLfYUdkNeGWWM4AbjKT4tHFCP4br8k5IC8KGB+yILPU3
 TER3vrUvHh1Eu/tOl6UnlAu2mblmM5OnPsckpUgdr+mdcR8h8k=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
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
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200117230245.5040-1-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/elfload.c | 73 +++++++++++++++++++++++++++++++++-----------
 linux-user/qemu.h    |  1 +
 2 files changed, 57 insertions(+), 17 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 511e4500788b..f3080a16358c 100644
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
 
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index f6f5fe5fbb55..560a68090e14 100644
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
-- 
2.24.1


