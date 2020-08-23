Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EE4C433E3
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 15:00:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25BB620724
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 15:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25BB620724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9rTd-0006W4-8p
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 11:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k9rSr-0004rM-Rs
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 10:59:21 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:40005)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k9rSp-0006dq-Ap
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 10:59:21 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N18I8-1kbt0r2bl4-012W6Y; Sun, 23 Aug 2020 16:59:15 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 2/6] linux-user: Validate mmap/mprotect prot value
Date: Sun, 23 Aug 2020 16:59:08 +0200
Message-Id: <20200823145912.1171738-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200823145912.1171738-1-laurent@vivier.eu>
References: <20200823145912.1171738-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Go7dNnmGWvrNwcfNOSZtXSLggfMJP+pnuQ1MiqldJQLatJdV5Bp
 7rod3jpuAIgYINDwB9/9/yNwXCHC/F0QcZCVXmV6RL2cbV3Yne9fEygttjz87Y6kJuo8zQT
 Cs7vdmrV5JZu+oPHg2kiCF2RQy1B8bzs8Lr1BstahPjIv0EtVMAB528wnjxAdErGcbUIttN
 cL5I2OcKKFI8/DYhX4WUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/wutq+zkr2A=:ex7dAghrSnrnQAjeiAe10v
 U5dlOgNLBo2EAGR6IpPx7j06p9DF5u3d/d37YkuJU1JryH9qcufAvSO6Et294Tjb8bjyul1aV
 QNeU4e+3wmssnUopNixLT5u0MvU720AkVx+X6HSQnq1VHLKpPttEVeb47BBePOtO7rAI4ElGQ
 6DCmR2G8u4r1dh5z6S3dnC5DQBegEe6mmvhjmnnoVB9pYUxlW5MJ5GGluNUYlJpS6Spiti0dc
 C/TueLKsLCeYynGnXkflhiU2umHMNtuxl+LfKckBSbjLaEfsUW2g1jw9lJOcnU3QG8wSMCT1t
 8xV4v3oiU7BDMYcP6Q/H7gMWQcwZdh3J/R+mp4vNEXF87Lf1dgFweYs2ULFBOBgZlsS3nh6HI
 fXiFHHKErkNPNnyGXxkQryQBs9DO3RmeFX0sdlyvXKIxrsELPZcKhM9p8LfoyOPJgEG5n+dNF
 F5zzqsZHX3VDB9zPc9d7gZ+sitZHIO1/3b5YX0J7F3r7JBxcU7Z+alYOl2a3G6NBMphJ7nPVV
 eG3x/dl/eVMGEgmiU+S5EHIPxcSKJVNyiBN3U+SbxYlOXH3BLdh/7RGUMY6TOPg8indZSLelO
 2V05tVymVR0t9uMLwntgEqipRyxpkoSfHFnueTSXLLufRwKV910Zlp6iGMtyfydobggvp43Cg
 FilZg2LiWfz0PgIXb5pQ4SLGb6XVDvrmhpvk7ljL9HU2Zhjs+yJnLEMhANLmIuOLuFfxfOF97
 evy8l7BtevQhTwVrSYoz59MYORFafFh0cY1UfUG3hW+j3vFk2pbrRCR2CbImXFR3NTCOm9gNt
 gPtV8iij/kGvfetkGQFfxvn+RBi8yq/3/ICscxYP70rSDHFRUCdqgIl7mSt//l+gqcB9r/4
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/23 10:59:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

The kernel will return -EINVAL for bits set in the prot argument
that are unknown or invalid.  Previously we were simply cropping
out the bits that we care about.

Introduce validate_prot_to_pageflags to perform this check in a
single place between the two syscalls.  Differentiate between
the target and host versions of prot.  Compute the qemu internal
page_flags value at the same time.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200519185645.3915-2-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/mmap.c | 106 +++++++++++++++++++++++++++++++---------------
 1 file changed, 73 insertions(+), 33 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 0019447892e0..46c7eeba9bd2 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -59,64 +59,96 @@ void mmap_fork_end(int child)
         pthread_mutex_unlock(&mmap_mutex);
 }
 
+/*
+ * Validate target prot bitmask.
+ * Return the prot bitmask for the host in *HOST_PROT.
+ * Return 0 if the target prot bitmask is invalid, otherwise
+ * the internal qemu page_flags (which will include PAGE_VALID).
+ */
+static int validate_prot_to_pageflags(int *host_prot, int prot)
+{
+    int valid = PROT_READ | PROT_WRITE | PROT_EXEC | TARGET_PROT_SEM;
+    int page_flags = (prot & PAGE_BITS) | PAGE_VALID;
+
+    /*
+     * For the host, we need not pass anything except read/write/exec.
+     * While PROT_SEM is allowed by all hosts, it is also ignored, so
+     * don't bother transforming guest bit to host bit.  Any other
+     * target-specific prot bits will not be understood by the host
+     * and will need to be encoded into page_flags for qemu emulation.
+     */
+    *host_prot = prot & (PROT_READ | PROT_WRITE | PROT_EXEC);
+
+    return prot & ~valid ? 0 : page_flags;
+}
+
 /* NOTE: all the constants are the HOST ones, but addresses are target. */
-int target_mprotect(abi_ulong start, abi_ulong len, int prot)
+int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
 {
     abi_ulong end, host_start, host_end, addr;
-    int prot1, ret;
+    int prot1, ret, page_flags, host_prot;
 
-    trace_target_mprotect(start, len, prot);
+    trace_target_mprotect(start, len, target_prot);
 
-    if ((start & ~TARGET_PAGE_MASK) != 0)
+    if ((start & ~TARGET_PAGE_MASK) != 0) {
         return -TARGET_EINVAL;
+    }
+    page_flags = validate_prot_to_pageflags(&host_prot, target_prot);
+    if (!page_flags) {
+        return -TARGET_EINVAL;
+    }
     len = TARGET_PAGE_ALIGN(len);
     end = start + len;
     if (!guest_range_valid(start, len)) {
         return -TARGET_ENOMEM;
     }
-    prot &= PROT_READ | PROT_WRITE | PROT_EXEC;
-    if (len == 0)
+    if (len == 0) {
         return 0;
+    }
 
     mmap_lock();
     host_start = start & qemu_host_page_mask;
     host_end = HOST_PAGE_ALIGN(end);
     if (start > host_start) {
         /* handle host page containing start */
-        prot1 = prot;
-        for(addr = host_start; addr < start; addr += TARGET_PAGE_SIZE) {
+        prot1 = host_prot;
+        for (addr = host_start; addr < start; addr += TARGET_PAGE_SIZE) {
             prot1 |= page_get_flags(addr);
         }
         if (host_end == host_start + qemu_host_page_size) {
-            for(addr = end; addr < host_end; addr += TARGET_PAGE_SIZE) {
+            for (addr = end; addr < host_end; addr += TARGET_PAGE_SIZE) {
                 prot1 |= page_get_flags(addr);
             }
             end = host_end;
         }
-        ret = mprotect(g2h(host_start), qemu_host_page_size, prot1 & PAGE_BITS);
-        if (ret != 0)
+        ret = mprotect(g2h(host_start), qemu_host_page_size,
+                       prot1 & PAGE_BITS);
+        if (ret != 0) {
             goto error;
+        }
         host_start += qemu_host_page_size;
     }
     if (end < host_end) {
-        prot1 = prot;
-        for(addr = end; addr < host_end; addr += TARGET_PAGE_SIZE) {
+        prot1 = host_prot;
+        for (addr = end; addr < host_end; addr += TARGET_PAGE_SIZE) {
             prot1 |= page_get_flags(addr);
         }
-        ret = mprotect(g2h(host_end - qemu_host_page_size), qemu_host_page_size,
-                       prot1 & PAGE_BITS);
-        if (ret != 0)
+        ret = mprotect(g2h(host_end - qemu_host_page_size),
+                       qemu_host_page_size, prot1 & PAGE_BITS);
+        if (ret != 0) {
             goto error;
+        }
         host_end -= qemu_host_page_size;
     }
 
     /* handle the pages in the middle */
     if (host_start < host_end) {
-        ret = mprotect(g2h(host_start), host_end - host_start, prot);
-        if (ret != 0)
+        ret = mprotect(g2h(host_start), host_end - host_start, host_prot);
+        if (ret != 0) {
             goto error;
+        }
     }
-    page_set_flags(start, start + len, prot | PAGE_VALID);
+    page_set_flags(start, start + len, page_flags);
     mmap_unlock();
     return 0;
 error:
@@ -360,19 +392,26 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
 }
 
 /* NOTE: all the constants are the HOST ones */
-abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
+abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
                      int flags, int fd, abi_ulong offset)
 {
     abi_ulong ret, end, real_start, real_end, retaddr, host_offset, host_len;
+    int page_flags, host_prot;
 
     mmap_lock();
-    trace_target_mmap(start, len, prot, flags, fd, offset);
+    trace_target_mmap(start, len, target_prot, flags, fd, offset);
 
     if (!len) {
         errno = EINVAL;
         goto fail;
     }
 
+    page_flags = validate_prot_to_pageflags(&host_prot, target_prot);
+    if (!page_flags) {
+        errno = EINVAL;
+        goto fail;
+    }
+
     /* Also check for overflows... */
     len = TARGET_PAGE_ALIGN(len);
     if (!len) {
@@ -438,14 +477,15 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
         /* Note: we prefer to control the mapping address. It is
            especially important if qemu_host_page_size >
            qemu_real_host_page_size */
-        p = mmap(g2h(start), host_len, prot,
+        p = mmap(g2h(start), host_len, host_prot,
                  flags | MAP_FIXED | MAP_ANONYMOUS, -1, 0);
-        if (p == MAP_FAILED)
+        if (p == MAP_FAILED) {
             goto fail;
+        }
         /* update start so that it points to the file position at 'offset' */
         host_start = (unsigned long)p;
         if (!(flags & MAP_ANONYMOUS)) {
-            p = mmap(g2h(start), len, prot,
+            p = mmap(g2h(start), len, host_prot,
                      flags | MAP_FIXED, fd, host_offset);
             if (p == MAP_FAILED) {
                 munmap(g2h(start), host_len);
@@ -479,19 +519,19 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
             /* msync() won't work here, so we return an error if write is
                possible while it is a shared mapping */
             if ((flags & MAP_TYPE) == MAP_SHARED &&
-                (prot & PROT_WRITE)) {
+                (host_prot & PROT_WRITE)) {
                 errno = EINVAL;
                 goto fail;
             }
-            retaddr = target_mmap(start, len, prot | PROT_WRITE,
+            retaddr = target_mmap(start, len, target_prot | PROT_WRITE,
                                   MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS,
                                   -1, 0);
             if (retaddr == -1)
                 goto fail;
             if (pread(fd, g2h(start), len, offset) == -1)
                 goto fail;
-            if (!(prot & PROT_WRITE)) {
-                ret = target_mprotect(start, len, prot);
+            if (!(host_prot & PROT_WRITE)) {
+                ret = target_mprotect(start, len, target_prot);
                 assert(ret == 0);
             }
             goto the_end;
@@ -502,13 +542,13 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
             if (real_end == real_start + qemu_host_page_size) {
                 /* one single host page */
                 ret = mmap_frag(real_start, start, end,
-                                prot, flags, fd, offset);
+                                host_prot, flags, fd, offset);
                 if (ret == -1)
                     goto fail;
                 goto the_end1;
             }
             ret = mmap_frag(real_start, start, real_start + qemu_host_page_size,
-                            prot, flags, fd, offset);
+                            host_prot, flags, fd, offset);
             if (ret == -1)
                 goto fail;
             real_start += qemu_host_page_size;
@@ -517,7 +557,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
         if (end < real_end) {
             ret = mmap_frag(real_end - qemu_host_page_size,
                             real_end - qemu_host_page_size, end,
-                            prot, flags, fd,
+                            host_prot, flags, fd,
                             offset + real_end - qemu_host_page_size - start);
             if (ret == -1)
                 goto fail;
@@ -533,13 +573,13 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
             else
                 offset1 = offset + real_start - start;
             p = mmap(g2h(real_start), real_end - real_start,
-                     prot, flags, fd, offset1);
+                     host_prot, flags, fd, offset1);
             if (p == MAP_FAILED)
                 goto fail;
         }
     }
  the_end1:
-    page_set_flags(start, start + len, prot | PAGE_VALID);
+    page_set_flags(start, start + len, page_flags);
  the_end:
     trace_target_mmap_complete(start);
     if (qemu_loglevel_mask(CPU_LOG_PAGE)) {
-- 
2.26.2


