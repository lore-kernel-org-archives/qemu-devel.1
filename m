Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0A5C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 20:15:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11AAE206D6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 20:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IgWjmsAV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11AAE206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTWde-0005h8-7H
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 16:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36914)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jTWXQ-0007yV-JZ
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:11:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jTWTo-0003fi-Ah
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:09:04 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46138
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jTWTn-0003VC-Rn
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588104317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=04gRe5DLBW+JWNwIhVkwArLik0uFBumT+QJZO+wbfoQ=;
 b=IgWjmsAVksLGEU4TcA3M/hM0V4hifRFSDuX9dGyWUJ7xBCod+zDYsI/PVGaiQ7lN3A0oQ+
 UoxfNnhRGP838oILsL1uWrL7SYqgdIxEVmCwvatjKnjhbht8A+IFRucdN3jaCwT6mkR0Yq
 9rm3VmRgnMQIYADiCfRgakKZTt1VrKE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-o-3p2kdPMamzOw-c-l5aiA-1; Tue, 28 Apr 2020 16:05:15 -0400
X-MC-Unique: o-3p2kdPMamzOw-c-l5aiA-1
Received: by mail-qv1-f69.google.com with SMTP id p12so23808950qvm.21
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 13:05:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0a4eA5xrmcCDRW1gYzwxtJlgh+ORMhw9LKHwNYYprls=;
 b=Ynx5NeknxNLKrBehpy08vYmea1cCltfFXHbub/UTm6EtL1poV/YY/GVogEN2Y0gAAE
 TnCfFc77XbP1oQuk8EabArx5PnEnx9yLxpBpnT8reMwsavwULCQUcidclVG0dWkZAGIP
 9PrmWOR50ra6M1DjxfkQPxYrqS1nX4CLwmnLz29mrRcJlc8YjzPNJ6/HDUYrTEmsLsHv
 jlAQmhNU8Ocit8r4ommcy6SFzYFxe1tUnjEcEwAKSTU6TOrf3qZkOD7hBqTlIiay5G5C
 B9hf2lvgP/jhaBT0q82bBYt2tjmV5GvRXBGekTOlPEBstJsUZ0TELdscutWJVamfVfWK
 Qjcw==
X-Gm-Message-State: AGi0PuYVAptlqxJpOhMn9SalC6rH3U83DMHPKLLuMHNXAmUjXiaJ+5Hb
 35pypfSlOLYb8jo617LsEePnlyRsz1R31K5zh6gQ9qxXf+0FdNkZ/F4ZapdSQKAHUATrZZI/bC6
 Ks2F+xLUrlpDbCvg=
X-Received: by 2002:ad4:5592:: with SMTP id e18mr30040998qvx.13.1588104315084; 
 Tue, 28 Apr 2020 13:05:15 -0700 (PDT)
X-Google-Smtp-Source: APiQypJbQW8ae8kQDH9I0xdvA4qnsiXtWwPMpl4RnzcC898+xznsfExz4H3a40/zvbYdnfHyq4pFqw==
X-Received: by 2002:ad4:5592:: with SMTP id e18mr30040973qvx.13.1588104314781; 
 Tue, 28 Apr 2020 13:05:14 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id k127sm14106585qkb.35.2020.04.28.13.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 13:05:13 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC v2 5/9] KVM: Provide helper to get kvm dirty log
Date: Tue, 28 Apr 2020 16:05:05 -0400
Message-Id: <20200428200509.13150-3-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200428195707.11980-1-peterx@redhat.com>
References: <20200428195707.11980-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:11:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: pbonzini@redhat.com, dgilbert@redhat.com, Peter Xu <peterx@redhat.com>
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
 accel/kvm/kvm-all.c      | 42 +++++++++++++++++++++-------------------
 include/sysemu/kvm_int.h |  2 ++
 2 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index dc6371b8b2..436b8fd899 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -563,6 +563,21 @@ static void kvm_slot_init_dirty_bitmap(KVMSlot *mem)
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
+    if (ret) {
+        error_report_once("%s: KVM_GET_DIRTY_LOG failed with %d",
+                          __func__, ret);
+    }
+}
+
 /**
  * kvm_physical_sync_dirty_bitmap - Sync dirty bitmap from kernel space
  *
@@ -574,15 +589,13 @@ static void kvm_slot_init_dirty_bitmap(KVMSlot *mem)
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
@@ -592,27 +605,19 @@ static int kvm_physical_sync_dirty_bitmap(KVMMemoryLi=
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
@@ -1084,6 +1089,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
     do {
         slot_size =3D MIN(kvm_max_slot_size, size);
         mem =3D kvm_alloc_slot(kml);
+        mem->as_id =3D kml->as_id;
         mem->memory_size =3D slot_size;
         mem->start_addr =3D start_addr;
         mem->ram =3D ram;
@@ -1126,14 +1132,10 @@ static void kvm_log_sync(MemoryListener *listener,
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


