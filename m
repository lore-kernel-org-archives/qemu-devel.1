Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B194FC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:41:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B4652146E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uBFEGF9c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4652146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYdl-0000nh-3S
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:41:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57069)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3w-0007Ol-1h
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3s-0003XM-IG
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:19 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:42346)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY3s-0003Sd-91
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:16 -0500
Received: by mail-wr1-x433.google.com with SMTP id q6so1982349wro.9
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=wKT5fGLcBjweK2g0j9x3iDEnS480C/vWZj9Pg704MW0=;
 b=uBFEGF9cpKGqQQW24pCETvFvKQe01KIQ50Ckw6KE2SiW5QFuItoyeNHQwLgz6riuLL
 MwKZZaw2f/UHk1JQC+L/iFzB0P11KDEkxRsP3VM9z+X/kY1QP6dImo3d0cmXr3p2dKWN
 eN9DhiHEF/GUWvyWGMuJCzbVjvVd8pZvQj6/jnFIbrRS7itTO0MwEk5Ycg43QCfFKgsb
 Od4CPz8HhB0QsfeRjzbt4798usSPNJ1QpYET2fu+TTRa5M1QrCvGuX8pzOW1tr6AyoHD
 ZjGpKf5A8lbj598Xm/ac1WIANB5D2BuZem6JBaumyUeEstZQ/PKrtnnFd+8ltLIgsZFi
 MGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=wKT5fGLcBjweK2g0j9x3iDEnS480C/vWZj9Pg704MW0=;
 b=gLmKPxB5foap3hlQQfYDbmonmmuhODxph5UAkX+KszIjmqtHVHzkMKGluRoXJl1W+U
 +xeNUx3JIvb99rrXQtfG/s6hX1toh+jv2WDPcGoOi7xHBXVBOqvnentiyjfesbhU8JvW
 9oaPItMYbpPQ5BDxud+eV27L8H20ivOtALDtVrUSdOsrTQsIrmRekNm9scazMDpQPieQ
 8ImTwNJy0pkLWLJgmwmnTqUnrg4FFB4WpPQIA26y4IG3uoE5WNUfQF40JdQ4FH+zQ+EF
 LwqaKS0YpV4VBXASjQSahRxB1yNsiHOEpTJU5xYV4TnPbQzLXpNRP+PLfrSg8T3IQw4e
 lMHg==
X-Gm-Message-State: APjAAAUmGmahhjFNRdr9T4klME8NZcVfjffFDh7O3vSjSbmFXssEhU5G
 ITCfuGtriWrmJR860Vm3P8W90dCq
X-Google-Smtp-Source: APXvYqyPnT4GBD2x23hiCCRvwgJzih3+z8nN6BygoY6e2h9shmBuQ8Fkrb9CL7f5ApMV8VA2VgCOgQ==
X-Received: by 2002:a5d:6901:: with SMTP id t1mr2334165wru.94.1576670654720;
 Wed, 18 Dec 2019 04:04:14 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.04.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:04:14 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 72/87] memory: include MemoryListener documentation and some
 missing function parameters
Date: Wed, 18 Dec 2019 13:02:38 +0100
Message-Id: <1576670573-48048-73-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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

These cover the remaining warnings from kernel-doc.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20191029162248.13383-7-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/memory.h | 218 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 214 insertions(+), 4 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 4754749..e85b7de 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -423,30 +423,232 @@ struct IOMMUMemoryRegion {
  * Use with memory_listener_register() and memory_listener_unregister().
  */
 struct MemoryListener {
+    /**
+     * @begin:
+     *
+     * Called at the beginning of an address space update transaction.
+     * Followed by calls to #MemoryListener.region_add(),
+     * #MemoryListener.region_del(), #MemoryListener.region_nop(),
+     * #MemoryListener.log_start() and #MemoryListener.log_stop() in
+     * increasing address order.
+     *
+     * @listener: The #MemoryListener.
+     */
     void (*begin)(MemoryListener *listener);
+
+    /**
+     * @commit:
+     *
+     * Called at the end of an address space update transaction,
+     * after the last call to #MemoryListener.region_add(),
+     * #MemoryListener.region_del() or #MemoryListener.region_nop(),
+     * #MemoryListener.log_start() and #MemoryListener.log_stop().
+     *
+     * @listener: The #MemoryListener.
+     */
     void (*commit)(MemoryListener *listener);
+
+    /**
+     * @region_add:
+     *
+     * Called during an address space update transaction,
+     * for a section of the address space that is new in this address space
+     * space since the last transaction.
+     *
+     * @listener: The #MemoryListener.
+     * @section: The new #MemoryRegionSection.
+     */
     void (*region_add)(MemoryListener *listener, MemoryRegionSection *section);
+
+    /**
+     * @region_del:
+     *
+     * Called during an address space update transaction,
+     * for a section of the address space that has disappeared in the address
+     * space since the last transaction.
+     *
+     * @listener: The #MemoryListener.
+     * @section: The old #MemoryRegionSection.
+     */
     void (*region_del)(MemoryListener *listener, MemoryRegionSection *section);
+
+    /**
+     * @region_nop:
+     *
+     * Called during an address space update transaction,
+     * for a section of the address space that is in the same place in the address
+     * space as in the last transaction.
+     *
+     * @listener: The #MemoryListener.
+     * @section: The #MemoryRegionSection.
+     */
     void (*region_nop)(MemoryListener *listener, MemoryRegionSection *section);
+
+    /**
+     * @log_start:
+     *
+     * Called during an address space update transaction, after
+     * one of #MemoryListener.region_add(),#MemoryListener.region_del() or
+     * #MemoryListener.region_nop(), if dirty memory logging clients have
+     * become active since the last transaction.
+     *
+     * @listener: The #MemoryListener.
+     * @section: The #MemoryRegionSection.
+     * @old: A bitmap of dirty memory logging clients that were active in
+     * the previous transaction.
+     * @new: A bitmap of dirty memory logging clients that are active in
+     * the current transaction.
+     */
     void (*log_start)(MemoryListener *listener, MemoryRegionSection *section,
                       int old, int new);
+
+    /**
+     * @log_stop:
+     *
+     * Called during an address space update transaction, after
+     * one of #MemoryListener.region_add(), #MemoryListener.region_del() or
+     * #MemoryListener.region_nop() and possibly after
+     * #MemoryListener.log_start(), if dirty memory logging clients have
+     * become inactive since the last transaction.
+     *
+     * @listener: The #MemoryListener.
+     * @section: The #MemoryRegionSection.
+     * @old: A bitmap of dirty memory logging clients that were active in
+     * the previous transaction.
+     * @new: A bitmap of dirty memory logging clients that are active in
+     * the current transaction.
+     */
     void (*log_stop)(MemoryListener *listener, MemoryRegionSection *section,
                      int old, int new);
+
+    /**
+     * @log_sync:
+     *
+     * Called by memory_region_snapshot_and_clear_dirty() and
+     * memory_global_dirty_log_sync(), before accessing QEMU's "official"
+     * copy of the dirty memory bitmap for a #MemoryRegionSection.
+     *
+     * @listener: The #MemoryListener.
+     * @section: The #MemoryRegionSection.
+     */
     void (*log_sync)(MemoryListener *listener, MemoryRegionSection *section);
+
+    /**
+     * @log_clear:
+     *
+     * Called before reading the dirty memory bitmap for a
+     * #MemoryRegionSection.
+     *
+     * @listener: The #MemoryListener.
+     * @section: The #MemoryRegionSection.
+     */
     void (*log_clear)(MemoryListener *listener, MemoryRegionSection *section);
+
+    /**
+     * @log_global_start:
+     *
+     * Called by memory_global_dirty_log_start(), which
+     * enables the %DIRTY_LOG_MIGRATION client on all memory regions in
+     * the address space.  #MemoryListener.log_global_start() is also
+     * called when a #MemoryListener is added, if global dirty logging is
+     * active at that time.
+     *
+     * @listener: The #MemoryListener.
+     */
     void (*log_global_start)(MemoryListener *listener);
+
+    /**
+     * @log_global_stop:
+     *
+     * Called by memory_global_dirty_log_stop(), which
+     * disables the %DIRTY_LOG_MIGRATION client on all memory regions in
+     * the address space.
+     *
+     * @listener: The #MemoryListener.
+     */
     void (*log_global_stop)(MemoryListener *listener);
+
+    /**
+     * @log_global_after_sync:
+     *
+     * Called after reading the dirty memory bitmap
+     * for any #MemoryRegionSection.
+     *
+     * @listener: The #MemoryListener.
+     */
     void (*log_global_after_sync)(MemoryListener *listener);
+
+    /**
+     * @eventfd_add:
+     *
+     * Called during an address space update transaction,
+     * for a section of the address space that has had a new ioeventfd
+     * registration since the last transaction.
+     *
+     * @listener: The #MemoryListener.
+     * @section: The new #MemoryRegionSection.
+     * @match_data: The @match_data parameter for the new ioeventfd.
+     * @data: The @data parameter for the new ioeventfd.
+     * @e: The #EventNotifier parameter for the new ioeventfd.
+     */
     void (*eventfd_add)(MemoryListener *listener, MemoryRegionSection *section,
                         bool match_data, uint64_t data, EventNotifier *e);
+
+    /**
+     * @eventfd_del:
+     *
+     * Called during an address space update transaction,
+     * for a section of the address space that has dropped an ioeventfd
+     * registration since the last transaction.
+     *
+     * @listener: The #MemoryListener.
+     * @section: The new #MemoryRegionSection.
+     * @match_data: The @match_data parameter for the dropped ioeventfd.
+     * @data: The @data parameter for the dropped ioeventfd.
+     * @e: The #EventNotifier parameter for the dropped ioeventfd.
+     */
     void (*eventfd_del)(MemoryListener *listener, MemoryRegionSection *section,
                         bool match_data, uint64_t data, EventNotifier *e);
+
+    /**
+     * @coalesced_io_add:
+     *
+     * Called during an address space update transaction,
+     * for a section of the address space that has had a new coalesced
+     * MMIO range registration since the last transaction.
+     *
+     * @listener: The #MemoryListener.
+     * @section: The new #MemoryRegionSection.
+     * @addr: The starting address for the coalesced MMIO range.
+     * @len: The length of the coalesced MMIO range.
+     */
     void (*coalesced_io_add)(MemoryListener *listener, MemoryRegionSection *section,
                                hwaddr addr, hwaddr len);
+
+    /**
+     * @coalesced_io_del:
+     *
+     * Called during an address space update transaction,
+     * for a section of the address space that has dropped a coalesced
+     * MMIO range since the last transaction.
+     *
+     * @listener: The #MemoryListener.
+     * @section: The new #MemoryRegionSection.
+     * @addr: The starting address for the coalesced MMIO range.
+     * @len: The length of the coalesced MMIO range.
+     */
     void (*coalesced_io_del)(MemoryListener *listener, MemoryRegionSection *section,
                                hwaddr addr, hwaddr len);
-    /* Lower = earlier (during add), later (during del) */
+    /**
+     * @priority:
+     *
+     * Govern the order in which memory listeners are invoked. Lower priorities
+     * are invoked earlier for "add" or "start" callbacks, and later for "delete"
+     * or "stop" callbacks.
+     */
     unsigned priority;
+
+    /* private: */
     AddressSpace *address_space;
     QTAILQ_ENTRY(MemoryListener) link;
     QTAILQ_ENTRY(MemoryListener) link_as;
@@ -940,6 +1142,7 @@ void memory_region_init_rom(MemoryRegion *mr,
  * @mr: the #MemoryRegion to be initialized.
  * @owner: the object that tracks the region's reference count
  * @ops: callbacks for write access handling (must not be NULL).
+ * @opaque: passed to the read and write callbacks of the @ops structure.
  * @name: Region name, becomes part of RAMBlock name used in migration stream
  *        must be unique within any device
  * @size: size of the region.
@@ -1028,7 +1231,7 @@ static inline IOMMUMemoryRegion *memory_region_get_iommu(MemoryRegion *mr)
  * Returns pointer to IOMMUMemoryRegionClass if a memory region is an iommu,
  * otherwise NULL. This is fast path avoiding QOM checking, use with caution.
  *
- * @mr: the memory region being queried
+ * @iommu_mr: the memory region being queried
  */
 static inline IOMMUMemoryRegionClass *memory_region_get_iommu_class_nocheck(
         IOMMUMemoryRegion *iommu_mr)
@@ -1098,6 +1301,7 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
  * @n: the IOMMUNotifier to be added; the notify callback receives a
  *     pointer to an #IOMMUTLBEntry as the opaque value; the pointer
  *     ceases to be valid on exit from the notifier.
+ * @errp: pointer to Error*, to store an error if it happens.
  */
 int memory_region_register_iommu_notifier(MemoryRegion *mr,
                                           IOMMUNotifier *n, Error **errp);
@@ -1270,9 +1474,12 @@ void *memory_region_get_ram_ptr(MemoryRegion *mr);
 void memory_region_ram_resize(MemoryRegion *mr, ram_addr_t newsize,
                               Error **errp);
 /**
- * memory_region_do_writeback: Trigger writeback for selected address range
- * [addr, addr + size]
+ * memory_region_do_writeback: Trigger cache writeback or msync for
+ * selected address range
  *
+ * @mr: the memory region to be updated
+ * @addr: the initial address of the range to be written back
+ * @size: the size of the range to be written back
  */
 void memory_region_do_writeback(MemoryRegion *mr, hwaddr addr, hwaddr size);
 
@@ -1591,6 +1798,8 @@ void memory_region_add_subregion_overlap(MemoryRegion *mr,
 /**
  * memory_region_get_ram_addr: Get the ram address associated with a memory
  *                             region
+ *
+ * @mr: the region to be queried
  */
 ram_addr_t memory_region_get_ram_addr(MemoryRegion *mr);
 
@@ -2161,6 +2370,7 @@ static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
  * @addr: address within that address space
  * @attrs: memory transaction attributes
  * @buf: buffer with the data transferred
+ * @len: length of the data transferred
  */
 static inline __attribute__((__always_inline__))
 MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
-- 
1.8.3.1



