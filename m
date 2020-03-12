Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD06DC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 10:57:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A10F320716
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 10:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A10F320716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCLWe-00024R-S9
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 06:57:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44413)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <teawaterz@linux.alibaba.com>) id 1jCLW4-0000m5-Vp
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 06:56:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <teawaterz@linux.alibaba.com>) id 1jCLVy-0005Ax-5Z
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 06:56:36 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:10908)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <teawaterz@linux.alibaba.com>)
 id 1jCLVx-00059j-OF
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 06:56:34 -0400
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=teawaterz@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0TsNlBqu_1584010574; 
Received: from localhost(mailfrom:teawaterz@linux.alibaba.com
 fp:SMTPD_---0TsNlBqu_1584010574) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 12 Mar 2020 18:56:18 +0800
From: Hui Zhu <teawater@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] virtio_balloon: Add option mprotect to handle guest kernel
 cheat issue
Date: Thu, 12 Mar 2020 18:56:12 +0800
Message-Id: <1584010572-10308-1-git-send-email-teawater@gmail.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 47.88.44.36
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
Cc: Hui Zhu <teawaterz@linux.alibaba.com>, Hui Zhu <teawater@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU virtio_balloon decreases the memory usage of VM depends on the
cooperation of the guest kernel.  If the guest kernel cheats with
the virtio_balloon, it can break the limit.

[1] is a Linux kernel with a cheat code.
This is an example in a VM with 1G memory 1CPU that use this kernel:
// Start VM.
// In the guest, use usemem(https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git)
// allocate 800M memory then the usage of VM will increase.
usemem 800m

// Check anon memory usage of QEMU in the host.
ps -e | grep qemu
67768 pts/5    00:00:02 qemu-system-x86
cat /proc/67768/status | grep RssAnon:
RssAnon:          994892 kB

// Connect to the monitor of QEMU and inflate the balloon 800M.
(qemu) device_add virtio-balloon-pci,id=balloon1
(qemu) info balloon
balloon: actual=1024
(qemu) balloon 224
(qemu) info balloon
balloon: actual=224

// Check anon memory usage of QEMU in the host again.
cat /proc/67768/status | grep RssAnon:
RssAnon:          175848 kB

// Use the cheat code inside the guest kernel to
// access the memory of the balloon.
cat /proc/virtio_balloon
204800

// The memory usage of QEMU increase back without deflation the balloon.
cat /proc/67768/status | grep RssAnon:
RssAnon:          995036 kB

This commit tries to handle the issue.
It set the address of balloon pages to cannot access with mprotect
when inflating the balloon and set it back when deflating the balloon.
When guest kernel cheat code tries to access the pages inside the balloon,
the host kernel will call handle_ept_violation-> tdp_page_fault to handle it.
tdp_page_fault will call hva_to_pfn to get PFN of the page.
hva_to_pfn_fast and hva_to_pfn_slow will check the VMA access permission.
Then change the VMA access permission can handle the issue.

This is an example in a VM with 1G memory 1CPU that use this kernel:
// Start VM.
// In the guest, use usemem(https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git)
// allocate 800M memory then the usage of VM will increase.
usemem 800m

// Connect to the monitor of QEMU and inflate the balloon 800M.
(qemu) device_add virtio-balloon-pci,id=balloon1,mprotect=on
(qemu) info balloon
balloon: actual=1024
(qemu) balloon 224
(qemu) info balloon
balloon: actual=224

// Use the cheat code inside the guest kernel to access the memory of balloon.
cat /proc/virtio_balloon
error: kvm run failed Bad address
RAX=000000000783c000 RBX=0000000000000000 RCX=ffff88803952bc00 RDX=ffff888000000000
RSI=ffffea00001e0f40 RDI=ffffea00001e0f48 RBP=ffff88803aac7180 RSP=ffffc90000207a70
R8 =ffff8880396af100 R9 =ffff88803a802700 R10=0000000000001000 R11=ffffffffffffffff
R12=ffff8880396af120 R13=0000000000000001 R14=ffffc90000207c60 R15=ffff88803aac7180
RIP=ffffffff81604aad RFL=00010206 [-----P-] CPL=0 II=0 A20=1 SMM=0 HLT=0
ES =0000 0000000000000000 ffffffff 00c00000
CS =0010 0000000000000000 ffffffff 00a09b00 DPL=0 CS64 [-RA]
SS =0018 0000000000000000 ffffffff 00c09300 DPL=0 DS   [-WA]
DS =0000 0000000000000000 ffffffff 00c00000
FS =0000 0000000000bcd880 ffffffff 00c00000
GS =0000 ffff88803ec00000 ffffffff 00c00000
LDT=0000 0000000000000000 ffffffff 00c00000
TR =0040 fffffe0000003000 00004087 00008b00 DPL=0 TSS64-busy
GDT=     fffffe0000001000 0000007f
IDT=     fffffe0000000000 00000fff
CR0=80050033 CR2=00000000008a2260 CR3=00000000396b6004 CR4=00360ef0
DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 DR3=0000000000000000
DR6=00000000fffe0ff0 DR7=0000000000000400
EFER=0000000000000d01
Code=05 72 5b e1 00 48 8b 15 7b 5b e1 00 48 c1 f8 06 48 c1 e0 0c <c6> 04 10 01 83 a9 a8 12 00 00 01 48 8b 46 08 83 c3 01 48 8d 50 f8 48 8d 46 08 49 35

This shows that the access is refused and QEMU stops.

[1] https://github.com/teawater/linux/tree/write_balloon

Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
---
 exec.c                             | 33 +++++++++++++++++++++++----------
 hw/virtio/virtio-balloon.c         | 20 +++++++++++++++++---
 include/exec/cpu-common.h          |  2 ++
 include/hw/virtio/virtio-balloon.h |  2 ++
 include/qemu/osdep.h               |  1 +
 util/osdep.c                       |  9 +++++++++
 6 files changed, 54 insertions(+), 13 deletions(-)

diff --git a/exec.c b/exec.c
index 0cc500d..ea14412 100644
--- a/exec.c
+++ b/exec.c
@@ -3846,17 +3846,20 @@ int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque)
  * they a) read as 0, b) Trigger whatever fault mechanism
  * the OS provides for postcopy.
  * The pages must be unmapped by the end of the function.
+ * If do_mprotect is true, call mprotect to change the
+ * protection to PROT_NONE before unmap.
  * Returns: 0 on success, none-0 on failure
  *
  */
-int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
+int __ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length,
+                              bool do_mprotect)
 {
     int ret = -1;
 
     uint8_t *host_startaddr = rb->host + start;
 
     if (!QEMU_PTR_IS_ALIGNED(host_startaddr, rb->page_size)) {
-        error_report("ram_block_discard_range: Unaligned start address: %p",
+        error_report("__ram_block_discard_range: Unaligned start address: %p",
                      host_startaddr);
         goto err;
     }
@@ -3864,11 +3867,16 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
     if ((start + length) <= rb->used_length) {
         bool need_madvise, need_fallocate;
         if (!QEMU_IS_ALIGNED(length, rb->page_size)) {
-            error_report("ram_block_discard_range: Unaligned length: %zx",
+            error_report("__ram_block_discard_range: Unaligned length: %zx",
                          length);
             goto err;
         }
 
+        if (do_mprotect && qemu_mprotect_none(host_startaddr, length) < 0) {
+            ret = -errno;
+            goto err;
+        }
+
         errno = ENOTSUP; /* If we are missing MADVISE etc */
 
         /* The logic here is messy;
@@ -3887,15 +3895,15 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
                             start, length);
             if (ret) {
                 ret = -errno;
-                error_report("ram_block_discard_range: Failed to fallocate "
+                error_report("__ram_block_discard_range: Failed to fallocate "
                              "%s:%" PRIx64 " +%zx (%d)",
                              rb->idstr, start, length, ret);
                 goto err;
             }
 #else
             ret = -ENOSYS;
-            error_report("ram_block_discard_range: fallocate not available/file"
-                         "%s:%" PRIx64 " +%zx (%d)",
+            error_report("__ram_block_discard_range: fallocate not "
+                         "available/file %s:%" PRIx64 " +%zx (%d)",
                          rb->idstr, start, length, ret);
             goto err;
 #endif
@@ -3910,14 +3918,14 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
             ret =  madvise(host_startaddr, length, MADV_DONTNEED);
             if (ret) {
                 ret = -errno;
-                error_report("ram_block_discard_range: Failed to discard range "
-                             "%s:%" PRIx64 " +%zx (%d)",
+                error_report("__ram_block_discard_range: Failed to discard "
+                             "range %s:%" PRIx64 " +%zx (%d)",
                              rb->idstr, start, length, ret);
                 goto err;
             }
 #else
             ret = -ENOSYS;
-            error_report("ram_block_discard_range: MADVISE not available"
+            error_report("__ram_block_discard_range: MADVISE not available "
                          "%s:%" PRIx64 " +%zx (%d)",
                          rb->idstr, start, length, ret);
             goto err;
@@ -3926,7 +3934,7 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
         trace_ram_block_discard_range(rb->idstr, host_startaddr, length,
                                       need_madvise, need_fallocate, ret);
     } else {
-        error_report("ram_block_discard_range: Overrun block '%s' (%" PRIu64
+        error_report("__ram_block_discard_range: Overrun block '%s' (%" PRIu64
                      "/%zx/" RAM_ADDR_FMT")",
                      rb->idstr, start, length, rb->used_length);
     }
@@ -3935,6 +3943,11 @@ err:
     return ret;
 }
 
+int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
+{
+    return __ram_block_discard_range(rb, start, length, false);
+}
+
 bool ramblock_is_pmem(RAMBlock *rb)
 {
     return rb->flags & RAM_PMEM;
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index a4729f7..77c0c4b 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -81,7 +81,8 @@ static void balloon_inflate_page(VirtIOBalloon *balloon,
     if (rb_page_size == BALLOON_PAGE_SIZE) {
         /* Easy case */
 
-        ram_block_discard_range(rb, rb_offset, rb_page_size);
+        __ram_block_discard_range(rb, rb_offset, rb_page_size,
+                                  balloon->do_mprotect);
         /* We ignore errors from ram_block_discard_range(), because it
          * has already reported them, and failing to discard a balloon
          * page is not fatal */
@@ -120,8 +121,9 @@ static void balloon_inflate_page(VirtIOBalloon *balloon,
         /* We've accumulated a full host page, we can actually discard
          * it now */
 
-        ram_block_discard_range(rb, rb_aligned_offset, rb_page_size);
-        /* We ignore errors from ram_block_discard_range(), because it
+        __ram_block_discard_range(rb, rb_aligned_offset, rb_page_size,
+                                  balloon->do_mprotect);
+        /* We ignore errors from __ram_block_discard_range(), because it
          * has already reported them, and failing to discard a balloon
          * page is not fatal */
         virtio_balloon_pbp_free(pbp);
@@ -145,6 +147,9 @@ static void balloon_deflate_page(VirtIOBalloon *balloon,
 
     host_addr = (void *)((uintptr_t)addr & ~(rb_page_size - 1));
 
+    if (balloon->do_mprotect)
+        g_assert(qemu_mprotect_rw(host_addr, rb_page_size) == 0);
+
     /* When a page is deflated, we hint the whole host page it lives
      * on, since we can't do anything smaller */
     ret = qemu_madvise(host_addr, rb_page_size, QEMU_MADV_WILLNEED);
@@ -780,6 +785,14 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
     virtio_init(vdev, "virtio-balloon", VIRTIO_ID_BALLOON,
                 virtio_balloon_config_size(s));
 
+    if (s->do_mprotect
+        && virtio_has_feature(s->host_features,
+                              VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
+        error_setg(errp, "mprotect and free-page-hint cannot work together");
+        virtio_cleanup(vdev);
+        return;
+    }
+
     ret = qemu_add_balloon_handler(virtio_balloon_to_target,
                                    virtio_balloon_stat, s);
 
@@ -924,6 +937,7 @@ static Property virtio_balloon_properties[] = {
                      qemu_4_0_config_size, false),
     DEFINE_PROP_LINK("iothread", VirtIOBalloon, iothread, TYPE_IOTHREAD,
                      IOThread *),
+    DEFINE_PROP_BOOL("mprotect", VirtIOBalloon, do_mprotect, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index b47e563..ffeb4a6 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -104,6 +104,8 @@ typedef int (RAMBlockIterFunc)(RAMBlock *rb, void *opaque);
 
 int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque);
 int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length);
+int __ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length,
+                              bool do_mprotect);
 
 #endif
 
diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index d1c968d..6f15085 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -70,6 +70,8 @@ typedef struct VirtIOBalloon {
     uint32_t host_features;
 
     bool qemu_4_0_config_size;
+
+    bool do_mprotect;
 } VirtIOBalloon;
 
 #endif
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 9bd3dcf..1bcb4e4 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -458,6 +458,7 @@ void sigaction_invoke(struct sigaction *action,
 
 int qemu_madvise(void *addr, size_t len, int advice);
 int qemu_mprotect_rwx(void *addr, size_t size);
+int qemu_mprotect_rw(void *addr, size_t size);
 int qemu_mprotect_none(void *addr, size_t size);
 
 int qemu_open(const char *name, int flags, ...);
diff --git a/util/osdep.c b/util/osdep.c
index 4829c07..2aff13b 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -105,6 +105,15 @@ int qemu_mprotect_rwx(void *addr, size_t size)
 #endif
 }
 
+int qemu_mprotect_rw(void *addr, size_t size)
+{
+#ifdef _WIN32
+    return qemu_mprotect__osdep(addr, size, PAGE_EXECUTE_READWRITE);
+#else
+    return qemu_mprotect__osdep(addr, size, PROT_READ | PROT_WRITE);
+#endif
+}
+
 int qemu_mprotect_none(void *addr, size_t size)
 {
 #ifdef _WIN32
-- 
2.7.4


