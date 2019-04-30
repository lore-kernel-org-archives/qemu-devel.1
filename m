Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC96C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:12:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B074E20835
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B074E20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49258 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLVMe-0006nE-SW
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 12:12:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUv8-0008Ms-Vg
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUv7-0002Is-Ep
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hLUv4-0002Gs-2y; Tue, 30 Apr 2019 11:43:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5B812307EA83;
	Tue, 30 Apr 2019 15:43:45 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DFBCF4D5;
	Tue, 30 Apr 2019 15:43:42 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 30 Apr 2019 17:42:44 +0200
Message-Id: <20190430154244.30083-28-kwolf@redhat.com>
In-Reply-To: <20190430154244.30083-1-kwolf@redhat.com>
References: <20190430154244.30083-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Tue, 30 Apr 2019 15:43:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 27/27] block/qed: add missed coroutine_fn markers
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190430154244.Wd1JHplDLXHEool2jetUQ5nDkGdn0K3LzMErEo3tGB8@z>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

qed_read_table and qed_write_table use coroutine-only interfaces but
are not marked coroutine_fn. Happily, they are called only from
coroutine context, so we only need to add missed markers.

Reported-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qed.h       | 28 ++++++++++++++++------------
 block/qed-check.c |  4 ++--
 block/qed-table.c | 33 ++++++++++++++++++++-------------
 block/qed.c       |  5 +++--
 4 files changed, 41 insertions(+), 29 deletions(-)

diff --git a/block/qed.h b/block/qed.h
index f35341f134..42c115d822 100644
--- a/block/qed.h
+++ b/block/qed.h
@@ -201,17 +201,21 @@ void qed_commit_l2_cache_entry(L2TableCache *l2_cac=
he, CachedL2Table *l2_table);
 /**
  * Table I/O functions
  */
-int qed_read_l1_table_sync(BDRVQEDState *s);
-int qed_write_l1_table(BDRVQEDState *s, unsigned int index, unsigned int=
 n);
-int qed_write_l1_table_sync(BDRVQEDState *s, unsigned int index,
-                            unsigned int n);
-int qed_read_l2_table_sync(BDRVQEDState *s, QEDRequest *request,
-                           uint64_t offset);
-int qed_read_l2_table(BDRVQEDState *s, QEDRequest *request, uint64_t off=
set);
-int qed_write_l2_table(BDRVQEDState *s, QEDRequest *request,
-                       unsigned int index, unsigned int n, bool flush);
-int qed_write_l2_table_sync(BDRVQEDState *s, QEDRequest *request,
-                            unsigned int index, unsigned int n, bool flu=
sh);
+int coroutine_fn qed_read_l1_table_sync(BDRVQEDState *s);
+int coroutine_fn qed_write_l1_table(BDRVQEDState *s, unsigned int index,
+                                    unsigned int n);
+int coroutine_fn qed_write_l1_table_sync(BDRVQEDState *s, unsigned int i=
ndex,
+                                         unsigned int n);
+int coroutine_fn qed_read_l2_table_sync(BDRVQEDState *s, QEDRequest *req=
uest,
+                                        uint64_t offset);
+int coroutine_fn qed_read_l2_table(BDRVQEDState *s, QEDRequest *request,
+                                   uint64_t offset);
+int coroutine_fn qed_write_l2_table(BDRVQEDState *s, QEDRequest *request=
,
+                                    unsigned int index, unsigned int n,
+                                    bool flush);
+int coroutine_fn qed_write_l2_table_sync(BDRVQEDState *s, QEDRequest *re=
quest,
+                                         unsigned int index, unsigned in=
t n,
+                                         bool flush);
=20
 /**
  * Cluster functions
@@ -223,7 +227,7 @@ int coroutine_fn qed_find_cluster(BDRVQEDState *s, QE=
DRequest *request,
 /**
  * Consistency check
  */
-int qed_check(BDRVQEDState *s, BdrvCheckResult *result, bool fix);
+int coroutine_fn qed_check(BDRVQEDState *s, BdrvCheckResult *result, boo=
l fix);
=20
 QEDTable *qed_alloc_table(BDRVQEDState *s);
=20
diff --git a/block/qed-check.c b/block/qed-check.c
index 0edac03159..418033ee24 100644
--- a/block/qed-check.c
+++ b/block/qed-check.c
@@ -106,7 +106,7 @@ static unsigned int qed_check_l2_table(QEDCheck *chec=
k, QEDTable *table)
 /**
  * Descend tables and check each cluster is referenced once only
  */
-static int qed_check_l1_table(QEDCheck *check, QEDTable *table)
+static int coroutine_fn qed_check_l1_table(QEDCheck *check, QEDTable *ta=
ble)
 {
     BDRVQEDState *s =3D check->s;
     unsigned int i, num_invalid_l1 =3D 0;
@@ -218,7 +218,7 @@ static void qed_check_mark_clean(BDRVQEDState *s, Bdr=
vCheckResult *result)
 }
=20
 /* Called with table_lock held.  */
-int qed_check(BDRVQEDState *s, BdrvCheckResult *result, bool fix)
+int coroutine_fn qed_check(BDRVQEDState *s, BdrvCheckResult *result, boo=
l fix)
 {
     QEDCheck check =3D {
         .s =3D s,
diff --git a/block/qed-table.c b/block/qed-table.c
index cf30edd977..405d446cbe 100644
--- a/block/qed-table.c
+++ b/block/qed-table.c
@@ -19,7 +19,8 @@
 #include "qemu/bswap.h"
=20
 /* Called with table_lock held.  */
-static int qed_read_table(BDRVQEDState *s, uint64_t offset, QEDTable *ta=
ble)
+static int coroutine_fn qed_read_table(BDRVQEDState *s, uint64_t offset,
+                                       QEDTable *table)
 {
     unsigned int bytes =3D s->header.cluster_size * s->header.table_size=
;
=20
@@ -60,8 +61,9 @@ out:
  *
  * Called with table_lock held.
  */
-static int qed_write_table(BDRVQEDState *s, uint64_t offset, QEDTable *t=
able,
-                           unsigned int index, unsigned int n, bool flus=
h)
+static int coroutine_fn qed_write_table(BDRVQEDState *s, uint64_t offset=
,
+                                        QEDTable *table, unsigned int in=
dex,
+                                        unsigned int n, bool flush)
 {
     unsigned int sector_mask =3D BDRV_SECTOR_SIZE / sizeof(uint64_t) - 1=
;
     unsigned int start, end, i;
@@ -109,27 +111,29 @@ out:
     return ret;
 }
=20
-int qed_read_l1_table_sync(BDRVQEDState *s)
+int coroutine_fn qed_read_l1_table_sync(BDRVQEDState *s)
 {
     return qed_read_table(s, s->header.l1_table_offset, s->l1_table);
 }
=20
 /* Called with table_lock held.  */
-int qed_write_l1_table(BDRVQEDState *s, unsigned int index, unsigned int=
 n)
+int coroutine_fn qed_write_l1_table(BDRVQEDState *s, unsigned int index,
+                                    unsigned int n)
 {
     BLKDBG_EVENT(s->bs->file, BLKDBG_L1_UPDATE);
     return qed_write_table(s, s->header.l1_table_offset,
                            s->l1_table, index, n, false);
 }
=20
-int qed_write_l1_table_sync(BDRVQEDState *s, unsigned int index,
-                            unsigned int n)
+int coroutine_fn qed_write_l1_table_sync(BDRVQEDState *s, unsigned int i=
ndex,
+                                         unsigned int n)
 {
     return qed_write_l1_table(s, index, n);
 }
=20
 /* Called with table_lock held.  */
-int qed_read_l2_table(BDRVQEDState *s, QEDRequest *request, uint64_t off=
set)
+int coroutine_fn qed_read_l2_table(BDRVQEDState *s, QEDRequest *request,
+                                   uint64_t offset)
 {
     int ret;
=20
@@ -166,22 +170,25 @@ int qed_read_l2_table(BDRVQEDState *s, QEDRequest *=
request, uint64_t offset)
     return ret;
 }
=20
-int qed_read_l2_table_sync(BDRVQEDState *s, QEDRequest *request, uint64_=
t offset)
+int coroutine_fn qed_read_l2_table_sync(BDRVQEDState *s, QEDRequest *req=
uest,
+                                        uint64_t offset)
 {
     return qed_read_l2_table(s, request, offset);
 }
=20
 /* Called with table_lock held.  */
-int qed_write_l2_table(BDRVQEDState *s, QEDRequest *request,
-                       unsigned int index, unsigned int n, bool flush)
+int coroutine_fn qed_write_l2_table(BDRVQEDState *s, QEDRequest *request=
,
+                                    unsigned int index, unsigned int n,
+                                    bool flush)
 {
     BLKDBG_EVENT(s->bs->file, BLKDBG_L2_UPDATE);
     return qed_write_table(s, request->l2_table->offset,
                            request->l2_table->table, index, n, flush);
 }
=20
-int qed_write_l2_table_sync(BDRVQEDState *s, QEDRequest *request,
-                            unsigned int index, unsigned int n, bool flu=
sh)
+int coroutine_fn qed_write_l2_table_sync(BDRVQEDState *s, QEDRequest *re=
quest,
+                                         unsigned int index, unsigned in=
t n,
+                                         bool flush)
 {
     return qed_write_l2_table(s, request, index, n, flush);
 }
diff --git a/block/qed.c b/block/qed.c
index 912edaf56a..dcdcd62b4a 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -1604,8 +1604,9 @@ static void coroutine_fn bdrv_qed_co_invalidate_cac=
he(BlockDriverState *bs,
     }
 }
=20
-static int bdrv_qed_co_check(BlockDriverState *bs, BdrvCheckResult *resu=
lt,
-                             BdrvCheckMode fix)
+static int coroutine_fn bdrv_qed_co_check(BlockDriverState *bs,
+                                          BdrvCheckResult *result,
+                                          BdrvCheckMode fix)
 {
     BDRVQEDState *s =3D bs->opaque;
     int ret;
--=20
2.20.1


