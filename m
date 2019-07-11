Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBF1C74A4B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 11:03:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9F8E208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 11:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9F8E208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlWrG-0006nO-5D
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 07:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47747)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1hlWij-0002jb-51
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 06:54:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hlWii-00076N-3S
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 06:54:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40312)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hlWih-00075v-TO
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 06:54:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6163430820C9;
 Thu, 11 Jul 2019 10:45:05 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.36.118.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3DC0760600;
 Thu, 11 Jul 2019 10:44:59 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Jul 2019 12:44:08 +0200
Message-Id: <20190711104412.31233-16-quintela@redhat.com>
In-Reply-To: <20190711104412.31233-1-quintela@redhat.com>
References: <20190711104412.31233-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Thu, 11 Jul 2019 10:45:05 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 15/19] kvm: Persistent per kvmslot dirty bitmap
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 kvm@vger.kernel.org, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Xu <peterx@redhat.com>

When synchronizing dirty bitmap from kernel KVM we do it in a
per-kvmslot fashion and we allocate the userspace bitmap for each of
the ioctl.  This patch instead make the bitmap cache be persistent
then we don't need to g_malloc0() every time.

More importantly, the cached per-kvmslot dirty bitmap will be further
used when we want to add support for the KVM_CLEAR_DIRTY_LOG and this
cached bitmap will be used to guarantee we won't clear any unknown
dirty bits otherwise that can be a severe data loss issue for
migration code.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20190603065056.25211-9-peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 accel/kvm/kvm-all.c      | 10 +++++++---
 include/sysemu/kvm_int.h |  2 ++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index a3df19da56..23ace52b9e 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -516,17 +516,19 @@ static int kvm_physical_sync_dirty_bitmap(KVMMemory=
Listener *kml,
          */
         size =3D ALIGN(((mem->memory_size) >> TARGET_PAGE_BITS),
                      /*HOST_LONG_BITS*/ 64) / 8;
-        d.dirty_bitmap =3D g_malloc0(size);
+        if (!mem->dirty_bmap) {
+            /* Allocate on the first log_sync, once and for all */
+            mem->dirty_bmap =3D g_malloc0(size);
+        }
=20
+        d.dirty_bitmap =3D mem->dirty_bmap;
         d.slot =3D mem->slot | (kml->as_id << 16);
         if (kvm_vm_ioctl(s, KVM_GET_DIRTY_LOG, &d) =3D=3D -1) {
             DPRINTF("ioctl failed %d\n", errno);
-            g_free(d.dirty_bitmap);
             return -1;
         }
=20
         kvm_get_dirty_pages_log_range(section, d.dirty_bitmap);
-        g_free(d.dirty_bitmap);
     }
=20
     return 0;
@@ -801,6 +803,8 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
         }
=20
         /* unregister the slot */
+        g_free(mem->dirty_bmap);
+        mem->dirty_bmap =3D NULL;
         mem->memory_size =3D 0;
         mem->flags =3D 0;
         err =3D kvm_set_user_memory_region(kml, mem, false);
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index f838412491..687a2ee423 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -21,6 +21,8 @@ typedef struct KVMSlot
     int slot;
     int flags;
     int old_flags;
+    /* Dirty bitmap cache for the slot */
+    unsigned long *dirty_bmap;
 } KVMSlot;
=20
 typedef struct KVMMemoryListener {
--=20
2.21.0


