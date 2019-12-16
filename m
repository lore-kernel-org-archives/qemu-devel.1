Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984D2C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:30:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 619CD2067C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ciGukR7K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 619CD2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtGh-0006XQ-RU
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 11:30:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56284)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtEq-0004a2-C7
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:28:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtEo-0006lL-Ue
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:28:52 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:37492)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtEo-0006in-Nw
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:28:50 -0500
Received: by mail-wr1-x42f.google.com with SMTP id w15so8062844wru.4
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=gryOh3U23b2tAbBDpurdFE7ycHJ1ns2a5UODB6airmA=;
 b=ciGukR7KZKCJBP7t7MpWoD/LvjNKB3nWmUKvDCvDyuO58qmrELjFJt0MrtO1Xwt/1V
 BcDFKPnD7+txSh+BpUNRFNVFE0xM1fPieYC2u2wii1AQIaMUuPfl2am3yJR6USaGvFL8
 v43VjgtB+RYpgvnolVkR4vAQ2eDD0NPN5EjUwcuf4gY+27FNzpgmRRtOiUeQ/xyEez2N
 fLesBSUVVCnJwj/qDfE0xp1ovoGcazcuyG2fTOMB/3p1SrfvaIZBuBSpHA+X+YIhfeYT
 QENr8sv8WtA5jpy/kjIvJpI0WriSXQSucTjMxhoQcqibyrtC0B0qId1shXyLkvtzON8I
 O6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=gryOh3U23b2tAbBDpurdFE7ycHJ1ns2a5UODB6airmA=;
 b=clAk9tPt8fCIioKRcGdAG6MsdtsFLkOyqqKgO+sLyzcOSZBCyJPBJfXDsOTyoi3try
 Oe/Od9PxxeqNXMq21XqHM7+Hi1dLbXZ1ceVdOhHxyAk+bWYgRmE2O3uWk1/wpAOzJt0z
 uFhSSMucocedpWJQxWhZtMLvbNDzcOgT76HK6zI3CRztjOHwUL2B6xEtldfuBwsFq8Bu
 vp10CLfPw19cgpH54MHOTzO+CbJ+SRuD/lJop/CWdW+hNjfjhjKCLegX8EDiSuEMB4zJ
 Nwybdd+FdfL4ypnPmQm5SYHwBU4RZZ+4kYVyKjPzYdoFnzd5FVSaZWGzmXPOVzGUEPwl
 gC/w==
X-Gm-Message-State: APjAAAUrDVOJF8pMZTfH81PeyT3ZKY0RmWoSZMVqHUiVO/L0nNmEUVur
 kbSwbUp7k+yEWI9xnqI67wRfgTIc
X-Google-Smtp-Source: APXvYqwADZoImuP09enL61ZoqiePx+MBEJZamoAoMogjK8GZhBReCSWxl3NDG7L/3nBHnnOMOnwEqA==
X-Received: by 2002:adf:f885:: with SMTP id u5mr31956437wrp.359.1576513729319; 
 Mon, 16 Dec 2019 08:28:49 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.28.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:28:48 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/62] kvm: Reallocate dirty_bmap when we change a slot
Date: Mon, 16 Dec 2019 17:27:45 +0100
Message-Id: <1576513726-53700-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

kvm_set_phys_mem can be called to reallocate a slot by something the
guest does (e.g. writing to PAM and other chipset registers).
This can happen in the middle of a migration, and if we're unlucky
it can now happen between the split 'sync' and 'clear'; the clear
asserts if there's no bmap to clear.   Recreate the bmap whenever
we change the slot, keeping the clear path happy.

Typically this is triggered by the guest rebooting during a migrate.

Corresponds to:
https://bugzilla.redhat.com/show_bug.cgi?id=1772774
https://bugzilla.redhat.com/show_bug.cgi?id=1771032

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 accel/kvm/kvm-all.c | 44 +++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index ca00daa..7b9f92d 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -518,6 +518,27 @@ static int kvm_get_dirty_pages_log_range(MemoryRegionSection *section,
 
 #define ALIGN(x, y)  (((x)+(y)-1) & ~((y)-1))
 
+/* Allocate the dirty bitmap for a slot  */
+static void kvm_memslot_init_dirty_bitmap(KVMSlot *mem)
+{
+    /*
+     * XXX bad kernel interface alert
+     * For dirty bitmap, kernel allocates array of size aligned to
+     * bits-per-long.  But for case when the kernel is 64bits and
+     * the userspace is 32bits, userspace can't align to the same
+     * bits-per-long, since sizeof(long) is different between kernel
+     * and user space.  This way, userspace will provide buffer which
+     * may be 4 bytes less than the kernel will use, resulting in
+     * userspace memory corruption (which is not detectable by valgrind
+     * too, in most cases).
+     * So for now, let's align to 64 instead of HOST_LONG_BITS here, in
+     * a hope that sizeof(long) won't become >8 any time soon.
+     */
+    hwaddr bitmap_size = ALIGN(((mem->memory_size) >> TARGET_PAGE_BITS),
+                                        /*HOST_LONG_BITS*/ 64) / 8;
+    mem->dirty_bmap = g_malloc0(bitmap_size);
+}
+
 /**
  * kvm_physical_sync_dirty_bitmap - Sync dirty bitmap from kernel space
  *
@@ -550,23 +571,9 @@ static int kvm_physical_sync_dirty_bitmap(KVMMemoryListener *kml,
             goto out;
         }
 
-        /* XXX bad kernel interface alert
-         * For dirty bitmap, kernel allocates array of size aligned to
-         * bits-per-long.  But for case when the kernel is 64bits and
-         * the userspace is 32bits, userspace can't align to the same
-         * bits-per-long, since sizeof(long) is different between kernel
-         * and user space.  This way, userspace will provide buffer which
-         * may be 4 bytes less than the kernel will use, resulting in
-         * userspace memory corruption (which is not detectable by valgrind
-         * too, in most cases).
-         * So for now, let's align to 64 instead of HOST_LONG_BITS here, in
-         * a hope that sizeof(long) won't become >8 any time soon.
-         */
         if (!mem->dirty_bmap) {
-            hwaddr bitmap_size = ALIGN(((mem->memory_size) >> TARGET_PAGE_BITS),
-                                        /*HOST_LONG_BITS*/ 64) / 8;
             /* Allocate on the first log_sync, once and for all */
-            mem->dirty_bmap = g_malloc0(bitmap_size);
+            kvm_memslot_init_dirty_bitmap(mem);
         }
 
         d.dirty_bitmap = mem->dirty_bmap;
@@ -1067,6 +1074,13 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
         mem->ram = ram;
         mem->flags = kvm_mem_flags(mr);
 
+        if (mem->flags & KVM_MEM_LOG_DIRTY_PAGES) {
+            /*
+             * Reallocate the bmap; it means it doesn't disappear in
+             * middle of a migrate.
+             */
+            kvm_memslot_init_dirty_bitmap(mem);
+        }
         err = kvm_set_user_memory_region(kml, mem, true);
         if (err) {
             fprintf(stderr, "%s: error registering slot: %s\n", __func__,
-- 
1.8.3.1



