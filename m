Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE49C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:21:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDDED21741
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G3XqW3nn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDDED21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izLYQ-0006id-0G
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 09:21:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46559)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1izLVL-0001W8-2l
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:18:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1izLVJ-0004cw-Ka
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:18:11 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39579
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1izLVJ-0004X9-Eq
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:18:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580912287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SDqF6ADXTmGX6aI+C0w8LxHxtAanmII+L5XlPUFEpeE=;
 b=G3XqW3nnYwOznqk12GZkd8tMeOEA1rmy2+bj+z2tGArpoB07TDJ8pOuDJu6c8j961LeGL2
 3DIF7hwMGVLDaVqHl3NTToSIo5erY6rHrT17txj+3VKraGdnFZ6qywNjjQKNOsqRbwtGZ2
 pVt/N5wE0OoJFcndoa2MxKFLEydKut8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-q0a-nXkZPxCQ5uvwHiZXpQ-1; Wed, 05 Feb 2020 09:18:03 -0500
Received: by mail-qk1-f199.google.com with SMTP id p3so1362463qkd.11
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 06:18:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=suTJCLiAp4aNTkjDp91lv6dxS1uEjlqRGFRV/Jyu20w=;
 b=Lt936RrpY8fGTYVgzOuZV0+eyVAkOrqttQCx/FPcVN2oJec/412M5YP8By3LgkywJR
 AJO57iW+FPjzBE6VVQsIo2eT8Mj2KzNPcZXI3pqB6M8pRs/sAcRjw/tNc5P50QlQjJ8H
 Pe1G+OGxIcSyExzUO6DdYDx361m6Uafp+3MpFeIOOOmL+/nGtotkJ3+o9E3kFao/d5zv
 Wt/uzMZor6b2aFfghseCRGhisw5AzJEf3nCtp9gN95TH/Q8Get6rYd4ZVOQJAaL9Mrfg
 p2X/RqBm2AAK8FfwG4D81ISDyxY1SszyoDMSlepmFvXI96XGA4lTB190HD8og5PgZ/26
 XaJA==
X-Gm-Message-State: APjAAAVpRWRpz+JCvDzHOmZ6pjlTxO5tKphKIxgP8XL6XCPAIUlB6Uu0
 nDsnq6ReOmBRq5+G74AeWK7FNW0nS3syTbwMwgfNAdZzrxkLHE1CMsE+CPPJycgZ3XXU9xQI2vz
 Q+lIgJH2AQoaZeH8=
X-Received: by 2002:ac8:33f8:: with SMTP id d53mr33253067qtb.86.1580912283004; 
 Wed, 05 Feb 2020 06:18:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqzcbm8HkUJDeCCw26VzHR2l/nqbL93dUcIf5feYF8YCoB9201RCglEcEzYwHHxGqIzo9d1l5g==
X-Received: by 2002:ac8:33f8:: with SMTP id d53mr33253047qtb.86.1580912282723; 
 Wed, 05 Feb 2020 06:18:02 -0800 (PST)
Received: from xz-x1.redhat.com ([2607:9880:19c8:32::2])
 by smtp.gmail.com with ESMTPSA id q5sm12833489qkf.14.2020.02.05.06.18.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 06:18:02 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 5/9] KVM: Provide helper to get kvm dirty log
Date: Wed,  5 Feb 2020 09:17:45 -0500
Message-Id: <20200205141749.378044-6-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200205141749.378044-1-peterx@redhat.com>
References: <20200205141749.378044-1-peterx@redhat.com>
MIME-Version: 1.0
X-MC-Unique: q0a-nXkZPxCQ5uvwHiZXpQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Provide a helper kvm_slot_get_dirty_log() to make the function
kvm_physical_sync_dirty_bitmap() clearer.  We can even cache the as_id
into KVMSlot when it is created, so that we don't even need to pass it
down every time.

Since at it, remove return value of kvm_physical_sync_dirty_bitmap()
because it should never fail.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel/kvm/kvm-all.c      | 39 +++++++++++++++++++--------------------
 include/sysemu/kvm_int.h |  2 ++
 2 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index bb635c775f..608216fd53 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -553,6 +553,18 @@ static void kvm_slot_init_dirty_bitmap(KVMSlot *mem)
     mem->dirty_bmap =3D g_malloc0(bitmap_size);
 }
=20
+/* Sync dirty bitmap from kernel to KVMSlot.dirty_bmap */
+static void kvm_slot_get_dirty_log(KVMState *s, KVMSlot *slot)
+{
+    struct kvm_dirty_log d =3D {};
+    int ret;
+
+    d.dirty_bitmap =3D slot->dirty_bmap;
+    d.slot =3D slot->slot | (slot->as_id << 16);
+    ret =3D kvm_vm_ioctl(s, KVM_GET_DIRTY_LOG, &d);
+    assert(ret !=3D -1);
+}
+
 /**
  * kvm_physical_sync_dirty_bitmap - Sync dirty bitmap from kernel space
  *
@@ -564,15 +576,13 @@ static void kvm_slot_init_dirty_bitmap(KVMSlot *mem)
  * @kml: the KVM memory listener object
  * @section: the memory section to sync the dirty bitmap with
  */
-static int kvm_physical_sync_dirty_bitmap(KVMMemoryListener *kml,
-                                          MemoryRegionSection *section)
+static void kvm_physical_sync_dirty_bitmap(KVMMemoryListener *kml,
+                                           MemoryRegionSection *section)
 {
     KVMState *s =3D kvm_state;
-    struct kvm_dirty_log d =3D {};
     KVMSlot *mem;
     hwaddr start_addr, size;
     hwaddr slot_size, slot_offset =3D 0;
-    int ret =3D 0;
=20
     size =3D kvm_align_section(section, &start_addr);
     while (size) {
@@ -582,27 +592,19 @@ static int kvm_physical_sync_dirty_bitmap(KVMMemoryLi=
stener *kml,
         mem =3D kvm_lookup_matching_slot(kml, start_addr, slot_size);
         if (!mem) {
             /* We don't have a slot if we want to trap every access. */
-            goto out;
+            return;
         }
=20
-        d.dirty_bitmap =3D mem->dirty_bmap;
-        d.slot =3D mem->slot | (kml->as_id << 16);
-        if (kvm_vm_ioctl(s, KVM_GET_DIRTY_LOG, &d) =3D=3D -1) {
-            DPRINTF("ioctl failed %d\n", errno);
-            ret =3D -1;
-            goto out;
-        }
+        kvm_slot_get_dirty_log(s, mem);
=20
         subsection.offset_within_region +=3D slot_offset;
         subsection.size =3D int128_make64(slot_size);
-        kvm_get_dirty_pages_log_range(&subsection, d.dirty_bitmap);
+        kvm_get_dirty_pages_log_range(&subsection, mem->dirty_bmap);
=20
         slot_offset +=3D slot_size;
         start_addr +=3D slot_size;
         size -=3D slot_size;
     }
-out:
-    return ret;
 }
=20
 /* Alignment requirement for KVM_CLEAR_DIRTY_LOG - 64 pages */
@@ -1077,6 +1079,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
     do {
         slot_size =3D MIN(kvm_max_slot_size, size);
         mem =3D kvm_alloc_slot(kml);
+        mem->as_id =3D kml->as_id;
         mem->memory_size =3D slot_size;
         mem->start_addr =3D start_addr;
         mem->ram =3D ram;
@@ -1119,14 +1122,10 @@ static void kvm_log_sync(MemoryListener *listener,
                          MemoryRegionSection *section)
 {
     KVMMemoryListener *kml =3D container_of(listener, KVMMemoryListener, l=
istener);
-    int r;
=20
     kvm_slots_lock(kml);
-    r =3D kvm_physical_sync_dirty_bitmap(kml, section);
+    kvm_physical_sync_dirty_bitmap(kml, section);
     kvm_slots_unlock(kml);
-    if (r < 0) {
-        abort();
-    }
 }
=20
 static void kvm_log_clear(MemoryListener *listener,
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index ac2d1f8b56..4434e15ec7 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -23,6 +23,8 @@ typedef struct KVMSlot
     int old_flags;
     /* Dirty bitmap cache for the slot */
     unsigned long *dirty_bmap;
+    /* Cache of the address space ID */
+    int as_id;
 } KVMSlot;
=20
 typedef struct KVMMemoryListener {
--=20
2.24.1


