Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URG_BIZ autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11396C5ACAE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 19:11:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEB2F2075C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 19:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB2F2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i881I-0000Hq-0e
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 15:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54091)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i87wk-0003yy-Pq
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 15:06:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i87wj-0006bH-Kz
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 15:06:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35462)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i87wj-0006an-C9
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 15:06:29 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B3A015AFE3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 19:06:28 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-243.ams2.redhat.com
 [10.36.117.243])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 874F860167;
 Wed, 11 Sep 2019 19:06:27 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, ehabkost@redhat.com,
 berrange@redhat.com, quintela@redhat.com
Date: Wed, 11 Sep 2019 20:06:19 +0100
Message-Id: <20190911190622.7629-3-dgilbert@redhat.com>
In-Reply-To: <20190911190622.7629-1-dgilbert@redhat.com>
References: <20190911190622.7629-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Wed, 11 Sep 2019 19:06:28 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 2/5] migration: Use automatic rcu_read
 unlock in ram.c
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

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Use the automatic read unlocker in migration/ram.c;
only for the cases where the unlock is at the end of the function.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index b2bd618a89..1bb82acfe0 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -181,14 +181,14 @@ int foreach_not_ignored_block(RAMBlockIterFunc func=
, void *opaque)
     RAMBlock *block;
     int ret =3D 0;
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_AUTO;
+
     RAMBLOCK_FOREACH_NOT_IGNORED(block) {
         ret =3D func(block, opaque);
         if (ret) {
             break;
         }
     }
-    rcu_read_unlock();
     return ret;
 }
=20
@@ -2398,13 +2398,12 @@ static void migration_page_queue_free(RAMState *r=
s)
     /* This queue generally should be empty - but in the case of a faile=
d
      * migration might have some droppings in.
      */
-    rcu_read_lock();
+    RCU_READ_LOCK_AUTO;
     QSIMPLEQ_FOREACH_SAFE(mspr, &rs->src_page_requests, next_req, next_m=
spr) {
         memory_region_unref(mspr->rb->mr);
         QSIMPLEQ_REMOVE_HEAD(&rs->src_page_requests, next_req);
         g_free(mspr);
     }
-    rcu_read_unlock();
 }
=20
 /**
@@ -2425,7 +2424,8 @@ int ram_save_queue_pages(const char *rbname, ram_ad=
dr_t start, ram_addr_t len)
     RAMState *rs =3D ram_state;
=20
     ram_counters.postcopy_requests++;
-    rcu_read_lock();
+    RCU_READ_LOCK_AUTO;
+
     if (!rbname) {
         /* Reuse last RAMBlock */
         ramblock =3D rs->last_req_rb;
@@ -2467,12 +2467,10 @@ int ram_save_queue_pages(const char *rbname, ram_=
addr_t start, ram_addr_t len)
     QSIMPLEQ_INSERT_TAIL(&rs->src_page_requests, new_entry, next_req);
     migration_make_urgent_request();
     qemu_mutex_unlock(&rs->src_page_req_mutex);
-    rcu_read_unlock();
=20
     return 0;
=20
 err:
-    rcu_read_unlock();
     return -1;
 }
=20
@@ -2712,7 +2710,8 @@ static uint64_t ram_bytes_total_common(bool count_i=
gnored)
     RAMBlock *block;
     uint64_t total =3D 0;
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_AUTO;
+
     if (count_ignored) {
         RAMBLOCK_FOREACH_MIGRATABLE(block) {
             total +=3D block->used_length;
@@ -2722,7 +2721,6 @@ static uint64_t ram_bytes_total_common(bool count_i=
gnored)
             total +=3D block->used_length;
         }
     }
-    rcu_read_unlock();
     return total;
 }
=20
@@ -3086,7 +3084,7 @@ int ram_postcopy_send_discard_bitmap(MigrationState=
 *ms)
     RAMBlock *block;
     int ret;
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_AUTO;
=20
     /* This should be our last sync, the src is now paused */
     migration_bitmap_sync(rs);
@@ -3107,13 +3105,11 @@ int ram_postcopy_send_discard_bitmap(MigrationSta=
te *ms)
              * point.
              */
             error_report("migration ram resized during precopy phase");
-            rcu_read_unlock();
             return -EINVAL;
         }
         /* Deal with TPS !=3D HPS and huge pages */
         ret =3D postcopy_chunk_hostpages(ms, block);
         if (ret) {
-            rcu_read_unlock();
             return ret;
         }
=20
@@ -3128,7 +3124,6 @@ int ram_postcopy_send_discard_bitmap(MigrationState=
 *ms)
     trace_ram_postcopy_send_discard_bitmap();
=20
     ret =3D postcopy_each_ram_send_discard(ms);
-    rcu_read_unlock();
=20
     return ret;
 }
@@ -3149,7 +3144,7 @@ int ram_discard_range(const char *rbname, uint64_t =
start, size_t length)
=20
     trace_ram_discard_range(rbname, start, length);
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_AUTO;
     RAMBlock *rb =3D qemu_ram_block_by_name(rbname);
=20
     if (!rb) {
@@ -3169,8 +3164,6 @@ int ram_discard_range(const char *rbname, uint64_t =
start, size_t length)
     ret =3D ram_block_discard_range(rb, start, length);
=20
 err:
-    rcu_read_unlock();
-
     return ret;
 }
=20
--=20
2.21.0


