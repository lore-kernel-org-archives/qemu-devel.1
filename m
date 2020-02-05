Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E21C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:21:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7649121741
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FzZfBvSd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7649121741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izLYS-0006oz-H9
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 09:21:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46473)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1izLVJ-0001Sj-BE
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:18:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1izLVH-0004XC-SV
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:18:09 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42153
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1izLVH-0004U0-Nb
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:18:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580912287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mRBblZHE0HNFkgTdufGMQbPMoE8LbUW6M6/u+V/IrNM=;
 b=FzZfBvSdDvzBa9GmytQR1V80Hi2cCCcAMfl5oYEBa1/I432ulaGhrlok78TRlv1AFxxGdB
 /01eHZLtDkvccI4l0e72GYIw+6BSWc9dd0khy5cgoAO297dMeJcIfn3ng+OWdMffUgzBuV
 xAPQdOEAmtn5JWq9NuynpTmo4djX/go=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-5Lh30yNVOZSmvoexAYJ14w-1; Wed, 05 Feb 2020 09:18:05 -0500
Received: by mail-qk1-f200.google.com with SMTP id z1so1349505qkl.15
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 06:18:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=glkVyCmPn2lU4x4NusHdwtelEkS4tZnSFXZS1Ih0SOQ=;
 b=tc5vmBvJ6pvj3oVfHpwIR/S/jG3ZzmqL9LXqvAz8cCwucOj1PPonQzqjOyvN6EjVg6
 zKvuDVbuAYRdjceTb+DItvH1jf3tqe4dGSqwGyhJBMujbVuHvlAE6brK+9/+jHdGQ756
 CDnl1T5FBhm6q4PcJr2P/x0BLoleyqrqC+Ry3/4knzf8+ZjmBFrCfULLmnap2eEt7dqz
 4rZaY1e67Xe8dy1g85pBMduWPij9V6wdym/7dRfMtedsJ/yngmbkFbZHqYhdft4fPkKi
 ZW5Pdj/PbhfcWp+jOclf2aLiHj33ScO08mZJtkQzjQLRdY9SEyfTwr5fPwKJ89zEO49g
 80Hw==
X-Gm-Message-State: APjAAAUO00OeNrZ+32jfEPzFYU5updqkJaGP1+FrWT4WFpw9/xvAxEIS
 OVGHJqCfwIbXzckJcb2OZ8ZC4SjtNdzZ2iq01TW9pYkgoolBY26d25FjdS737yi0FjQ6Ab/biGb
 Jhu+ndfx1xpgQdkc=
X-Received: by 2002:a05:6214:3aa:: with SMTP id
 m10mr32708727qvy.125.1580912284698; 
 Wed, 05 Feb 2020 06:18:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqwbucul0ut7yKSwQCUGPQ59+flo+W/439eC14lRi3Q1dcVcSYkAR4yU2Q9YFB62+X7yRKb4ZQ==
X-Received: by 2002:a05:6214:3aa:: with SMTP id
 m10mr32708712qvy.125.1580912284461; 
 Wed, 05 Feb 2020 06:18:04 -0800 (PST)
Received: from xz-x1.redhat.com ([2607:9880:19c8:32::2])
 by smtp.gmail.com with ESMTPSA id q5sm12833489qkf.14.2020.02.05.06.18.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 06:18:03 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 6/9] KVM: Provide helper to sync dirty bitmap from slot to
 ramblock
Date: Wed,  5 Feb 2020 09:17:46 -0500
Message-Id: <20200205141749.378044-7-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200205141749.378044-1-peterx@redhat.com>
References: <20200205141749.378044-1-peterx@redhat.com>
MIME-Version: 1.0
X-MC-Unique: 5Lh30yNVOZSmvoexAYJ14w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

kvm_physical_sync_dirty_bitmap() calculates the ramblock offset in an
awkward way from the MemoryRegionSection that passed in from the
caller.  The truth is for each KVMSlot the ramblock offset never
change for the lifecycle.  Cache the ramblock offset for each KVMSlot
into the structure when the KVMSlot is created.

With that, we can further simplify kvm_physical_sync_dirty_bitmap()
with a helper to sync KVMSlot dirty bitmap to the ramblock dirty
bitmap of a specific KVMSlot.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel/kvm/kvm-all.c      | 37 +++++++++++++++++--------------------
 include/sysemu/kvm_int.h |  2 ++
 2 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 608216fd53..f81e7a644b 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -515,15 +515,12 @@ static void kvm_log_stop(MemoryListener *listener,
 }
=20
 /* get kvm's dirty pages bitmap and update qemu's */
-static int kvm_get_dirty_pages_log_range(MemoryRegionSection *section,
-                                         unsigned long *bitmap)
+static void kvm_slot_sync_dirty_pages(KVMSlot *slot)
 {
-    ram_addr_t start =3D section->offset_within_region +
-                       memory_region_get_ram_addr(section->mr);
-    ram_addr_t pages =3D int128_get64(section->size) / qemu_real_host_page=
_size;
+    ram_addr_t start =3D slot->ram_start_offset;
+    ram_addr_t pages =3D slot->memory_size / qemu_real_host_page_size;
=20
-    cpu_physical_memory_set_dirty_lebitmap(bitmap, start, pages);
-    return 0;
+    cpu_physical_memory_set_dirty_lebitmap(slot->dirty_bmap, start, pages)=
;
 }
=20
 #define ALIGN(x, y)  (((x)+(y)-1) & ~((y)-1))
@@ -582,12 +579,10 @@ static void kvm_physical_sync_dirty_bitmap(KVMMemoryL=
istener *kml,
     KVMState *s =3D kvm_state;
     KVMSlot *mem;
     hwaddr start_addr, size;
-    hwaddr slot_size, slot_offset =3D 0;
+    hwaddr slot_size;
=20
     size =3D kvm_align_section(section, &start_addr);
     while (size) {
-        MemoryRegionSection subsection =3D *section;
-
         slot_size =3D MIN(kvm_max_slot_size, size);
         mem =3D kvm_lookup_matching_slot(kml, start_addr, slot_size);
         if (!mem) {
@@ -596,12 +591,7 @@ static void kvm_physical_sync_dirty_bitmap(KVMMemoryLi=
stener *kml,
         }
=20
         kvm_slot_get_dirty_log(s, mem);
-
-        subsection.offset_within_region +=3D slot_offset;
-        subsection.size =3D int128_make64(slot_size);
-        kvm_get_dirty_pages_log_range(&subsection, mem->dirty_bmap);
-
-        slot_offset +=3D slot_size;
+        kvm_slot_sync_dirty_pages(mem);
         start_addr +=3D slot_size;
         size -=3D slot_size;
     }
@@ -1023,7 +1013,8 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
     int err;
     MemoryRegion *mr =3D section->mr;
     bool writeable =3D !mr->readonly && !mr->rom_device;
-    hwaddr start_addr, size, slot_size;
+    hwaddr start_addr, size, slot_size, mr_offset;
+    ram_addr_t ram_start_offset;
     void *ram;
=20
     if (!memory_region_is_ram(mr)) {
@@ -1041,9 +1032,13 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
         return;
     }
=20
-    /* use aligned delta to align the ram address */
-    ram =3D memory_region_get_ram_ptr(mr) + section->offset_within_region =
+
-          (start_addr - section->offset_within_address_space);
+    /* The offset of the kvmslot within the memory region */
+    mr_offset =3D section->offset_within_region + start_addr -
+        section->offset_within_address_space;
+
+    /* use aligned delta to align the ram address and offset */
+    ram =3D memory_region_get_ram_ptr(mr) + mr_offset;
+    ram_start_offset =3D memory_region_get_ram_addr(mr) + mr_offset;
=20
     kvm_slots_lock(kml);
=20
@@ -1082,6 +1077,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
         mem->as_id =3D kml->as_id;
         mem->memory_size =3D slot_size;
         mem->start_addr =3D start_addr;
+        mem->ram_start_offset =3D ram_start_offset;
         mem->ram =3D ram;
         mem->flags =3D kvm_mem_flags(mr);
         kvm_slot_init_dirty_bitmap(mem);
@@ -1092,6 +1088,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
             abort();
         }
         start_addr +=3D slot_size;
+        ram_start_offset +=3D slot_size;
         ram +=3D slot_size;
         size -=3D slot_size;
     } while (size);
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 4434e15ec7..1a19bfef80 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -25,6 +25,8 @@ typedef struct KVMSlot
     unsigned long *dirty_bmap;
     /* Cache of the address space ID */
     int as_id;
+    /* Cache of the offset in ram address space */
+    ram_addr_t ram_start_offset;
 } KVMSlot;
=20
 typedef struct KVMMemoryListener {
--=20
2.24.1


