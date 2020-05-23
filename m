Return-Path: <SRS0=y3lU=7F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D75AC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 23:23:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0B0D20735
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 23:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="at+ZL/yh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0B0D20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcdUG-0003t8-0m
	for qemu-devel@archiver.kernel.org; Sat, 23 May 2020 19:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jcdRj-000718-Dq
 for qemu-devel@nongnu.org; Sat, 23 May 2020 19:20:51 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46757
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jcdRi-0000PS-DF
 for qemu-devel@nongnu.org; Sat, 23 May 2020 19:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590276049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fyC6BJYd3YQUjPLW81KbGf3YMkvz3sGMDhhWO/zcegg=;
 b=at+ZL/yhzcGjSn70b2hJskK93+CvTC2A9XN1179hyEL8k2vK6eqITJumBhLu9+u6WnUCH+
 6sY5tVL2DegEalhTWwc2aiol7bI7l+i62m9YFiTDA25rD4L4Tp40uVfCBUd3ZzvNfD2kn9
 WinZ0TkKhWvlj9T68rmqTnsW1wKn5XY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-i8QvEX1CPk-6oCdXZ520Qg-1; Sat, 23 May 2020 19:20:47 -0400
X-MC-Unique: i8QvEX1CPk-6oCdXZ520Qg-1
Received: by mail-qv1-f72.google.com with SMTP id q10so14159293qvs.16
 for <qemu-devel@nongnu.org>; Sat, 23 May 2020 16:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fyC6BJYd3YQUjPLW81KbGf3YMkvz3sGMDhhWO/zcegg=;
 b=E1INS17fWv5crmx6ZAxKJQunYJND11/RuYCZJqh6ylNjNThRf+t8uYJc2ZO7go+wSD
 jR+zd4tCmmqt9WihC/QCdkItwOmQ07B6MYZkobMja2lPt6rCWbdhIE7t1q+AjE6JZbRr
 tgcRYE+A2Lu5icrUc5DZIneala92sL4/sFbVX73sd74gaw0JpBTt7+8AzphzRJ/RoHMI
 PXFnrlUj0Lq35/HnDCpPgOcyvTG0PCET2TA1L1+y2NDbPH/tlolJGXjU+1EIn4E4/BDH
 OH65VfHEfLrR5HtYxcLBwQk5egKYMW3FLEOeZLziGRTkrORg97SVe83TrRm7eiMUC9ju
 XPWA==
X-Gm-Message-State: AOAM531UDUoYU2aqnWCPiM+gBcoMNwmx97iiQJHE95TC0Xms69JajgQU
 5o+C38BPPbrxsymYKxOrsLHMRt1mKLih3KBYJVu+zCyQj7XbCmo3WfQjyf3WkQeTMNI/VMrNE11
 ZJK7bzC3basNkI0w=
X-Received: by 2002:ac8:6b8a:: with SMTP id z10mr21500111qts.373.1590276046730; 
 Sat, 23 May 2020 16:20:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBytkOqZEShEDNildFKH8HUTD2KeQo+90MvCIPY7BzU0aoDmVWNquq9bzERsE56bkeg6a9nw==
X-Received: by 2002:ac8:6b8a:: with SMTP id z10mr21500100qts.373.1590276046483; 
 Sat, 23 May 2020 16:20:46 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id m33sm11974235qtb.88.2020.05.23.16.20.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2020 16:20:45 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC v3 05/11] KVM: Create the KVMSlot dirty bitmap on flag
 changes
Date: Sat, 23 May 2020 19:20:29 -0400
Message-Id: <20200523232035.1029349-6-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523232035.1029349-1-peterx@redhat.com>
References: <20200523232035.1029349-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/23 19:20:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Previously we have two places that will create the per KVMSlot dirty
bitmap:

  1. When a newly created KVMSlot has dirty logging enabled,
  2. When the first log_sync() happens for a memory slot.

The 2nd case is lazy-init, while the 1st case is not (which is a fix
of what the 2nd case missed).

To do explicit initialization of dirty bitmaps, what we're missing is
to create the dirty bitmap when the slot changed from not-dirty-track
to dirty-track.  Do that in kvm_slot_update_flags().

With that, we can safely remove the 2nd lazy-init.

This change will be needed for kvm dirty ring because kvm dirty ring
does not use the log_sync() interface at all.

Also move all the pre-checks into kvm_slot_init_dirty_bitmap().

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel/kvm/kvm-all.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 6bdb7909cc..5b626af2a7 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -165,6 +165,8 @@ static QemuMutex kml_slots_lock;
 #define kvm_slots_lock()  qemu_mutex_lock(&kml_slots_lock)
 #define kvm_slots_unlock()  qemu_mutex_unlock(&kml_slots_lock)
 
+static void kvm_slot_init_dirty_bitmap(KVMSlot *mem);
+
 int kvm_get_max_memslots(void)
 {
     KVMState *s = KVM_STATE(current_accel());
@@ -455,6 +457,7 @@ static int kvm_slot_update_flags(KVMMemoryListener *kml, KVMSlot *mem,
         return 0;
     }
 
+    kvm_slot_init_dirty_bitmap(mem);
     return kvm_set_user_memory_region(kml, mem, false);
 }
 
@@ -539,8 +542,12 @@ static int kvm_get_dirty_pages_log_range(MemoryRegionSection *section,
 #define ALIGN(x, y)  (((x)+(y)-1) & ~((y)-1))
 
 /* Allocate the dirty bitmap for a slot  */
-static void kvm_memslot_init_dirty_bitmap(KVMSlot *mem)
+static void kvm_slot_init_dirty_bitmap(KVMSlot *mem)
 {
+    if (!(mem->flags & KVM_MEM_LOG_DIRTY_PAGES) || mem->dirty_bmap) {
+        return;
+    }
+
     /*
      * XXX bad kernel interface alert
      * For dirty bitmap, kernel allocates array of size aligned to
@@ -591,11 +598,6 @@ static int kvm_physical_sync_dirty_bitmap(KVMMemoryListener *kml,
             goto out;
         }
 
-        if (!mem->dirty_bmap) {
-            /* Allocate on the first log_sync, once and for all */
-            kvm_memslot_init_dirty_bitmap(mem);
-        }
-
         d.dirty_bitmap = mem->dirty_bmap;
         d.slot = mem->slot | (kml->as_id << 16);
         if (kvm_vm_ioctl(s, KVM_GET_DIRTY_LOG, &d) == -1) {
@@ -1125,14 +1127,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
         mem->start_addr = start_addr;
         mem->ram = ram;
         mem->flags = kvm_mem_flags(mr);
-
-        if (mem->flags & KVM_MEM_LOG_DIRTY_PAGES) {
-            /*
-             * Reallocate the bmap; it means it doesn't disappear in
-             * middle of a migrate.
-             */
-            kvm_memslot_init_dirty_bitmap(mem);
-        }
+        kvm_slot_init_dirty_bitmap(mem);
         err = kvm_set_user_memory_region(kml, mem, true);
         if (err) {
             fprintf(stderr, "%s: error registering slot: %s\n", __func__,
-- 
2.26.2


