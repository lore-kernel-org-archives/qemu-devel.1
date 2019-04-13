Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F73C10F11
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 16:55:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5E95218C3
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 16:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E95218C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53847 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFLwT-0008MU-Or
	for qemu-devel@archiver.kernel.org; Sat, 13 Apr 2019 12:55:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hFLug-00079U-U5
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 12:54:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hFLuf-0002kS-J2
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 12:53:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hFLuc-0002hc-CH; Sat, 13 Apr 2019 12:53:54 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A48197E9C1;
	Sat, 13 Apr 2019 16:53:53 +0000 (UTC)
Received: from localhost (ovpn-204-66.brq.redhat.com [10.40.204.66])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0268B600C8;
	Sat, 13 Apr 2019 16:53:52 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Sat, 13 Apr 2019 18:53:39 +0200
Message-Id: <20190413165343.9018-4-mreitz@redhat.com>
In-Reply-To: <20190413165343.9018-1-mreitz@redhat.com>
References: <20190413165343.9018-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Sat, 13 Apr 2019 16:53:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 3/7] blkdebug: Add @iotype error option
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
Cc: Kevin Wolf <kwolf@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
	"Denis V . Lunev" <den@openvz.org>,
	Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190413165339.cRw76HhvW0rwyCfSkQSx9yZssu7auDH-Ue7EFkgfR9E@z>

This new error option allows users of blkdebug to inject errors only on
certain kinds of I/O operations.  Users usually want to make a very
specific operation fail, not just any; but right now they simply hope
that the event that triggers the error injection is followed up with
that very operation.  That may not be true, however, because the block
layer is changing (including blkdebug, which may increase the number of
types of I/O operations on which to inject errors).

The new option's default has been chosen to keep backwards
compatibility.

Note that similar to the internal representation, we could choose to
expose this option as a list of I/O types.  But there is no practical
use for this, because as described above, users usually know exactly
which kind of operation they want to make fail, so there is no need to
specify multiple I/O types at once.  In addition, exposing this option
as a list would require non-trivial changes to qemu_opts_absorb_qdict().

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json | 26 +++++++++++++++++++++++
 block/blkdebug.c     | 50 ++++++++++++++++++++++++++++++++++++--------
 2 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 7ccbfff9d0..5141e91172 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3235,6 +3235,26 @@
             'l1_shrink_write_table', 'l1_shrink_free_l2_clusters',
             'cor_write'] }
=20
+##
+# @BlkdebugIOType:
+#
+# Kinds of I/O that blkdebug can inject errors in.
+#
+# @read: .bdrv_co_preadv()
+#
+# @write: .bdrv_co_pwritev()
+#
+# @write-zeroes: .bdrv_co_pwrite_zeroes()
+#
+# @discard: .bdrv_co_pdiscard()
+#
+# @flush: .bdrv_co_flush_to_disk()
+#
+# Since: 4.1
+##
+{ 'enum': 'BlkdebugIOType',
+  'data': [ 'read', 'write', 'write-zeroes', 'discard', 'flush' ] }
+
 ##
 # @BlkdebugInjectErrorOptions:
 #
@@ -3245,6 +3265,11 @@
 # @state:       the state identifier blkdebug needs to be in to
 #               actually trigger the event; defaults to "any"
 #
+# @iotype:      the type of I/O operations on which this error should
+#               be injected; defaults to "all read, write,
+#               write-zeroes, discard, and flush operations"
+#               (since: 4.1)
+#
 # @errno:       error identifier (errno) to be returned; defaults to
 #               EIO
 #
@@ -3262,6 +3287,7 @@
 { 'struct': 'BlkdebugInjectErrorOptions',
   'data': { 'event': 'BlkdebugEvent',
             '*state': 'int',
+            '*iotype': 'BlkdebugIOType',
             '*errno': 'int',
             '*sector': 'int',
             '*once': 'bool',
diff --git a/block/blkdebug.c b/block/blkdebug.c
index efd9441625..ca84b12e32 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -75,6 +75,7 @@ typedef struct BlkdebugRule {
     int state;
     union {
         struct {
+            uint64_t iotype_mask;
             int error;
             int immediately;
             int once;
@@ -91,6 +92,9 @@ typedef struct BlkdebugRule {
     QSIMPLEQ_ENTRY(BlkdebugRule) active_next;
 } BlkdebugRule;
=20
+QEMU_BUILD_BUG_MSG(BLKDEBUGIO_TYPE__MAX > 64,
+                   "BlkdebugIOType mask does not fit into an uint64_t");
+
 static QemuOptsList inject_error_opts =3D {
     .name =3D "inject-error",
     .head =3D QTAILQ_HEAD_INITIALIZER(inject_error_opts.head),
@@ -103,6 +107,10 @@ static QemuOptsList inject_error_opts =3D {
             .name =3D "state",
             .type =3D QEMU_OPT_NUMBER,
         },
+        {
+            .name =3D "iotype",
+            .type =3D QEMU_OPT_STRING,
+        },
         {
             .name =3D "errno",
             .type =3D QEMU_OPT_NUMBER,
@@ -162,6 +170,8 @@ static int add_rule(void *opaque, QemuOpts *opts, Err=
or **errp)
     int event;
     struct BlkdebugRule *rule;
     int64_t sector;
+    BlkdebugIOType iotype;
+    Error *local_error =3D NULL;
=20
     /* Find the right event for the rule */
     event_name =3D qemu_opt_get(opts, "event");
@@ -192,6 +202,26 @@ static int add_rule(void *opaque, QemuOpts *opts, Er=
ror **errp)
         sector =3D qemu_opt_get_number(opts, "sector", -1);
         rule->options.inject.offset =3D
             sector =3D=3D -1 ? -1 : sector * BDRV_SECTOR_SIZE;
+
+        iotype =3D qapi_enum_parse(&BlkdebugIOType_lookup,
+                                 qemu_opt_get(opts, "iotype"),
+                                 BLKDEBUGIO_TYPE__MAX, &local_error);
+        if (local_error) {
+            error_propagate(errp, local_error);
+            return -1;
+        }
+        if (iotype !=3D BLKDEBUGIO_TYPE__MAX) {
+            rule->options.inject.iotype_mask =3D (1ull << iotype);
+        } else {
+            /* Apply the default */
+            rule->options.inject.iotype_mask =3D
+                (1ull << BLKDEBUGIO_TYPE_READ)
+                | (1ull << BLKDEBUGIO_TYPE_WRITE)
+                | (1ull << BLKDEBUGIO_TYPE_WRITE_ZEROES)
+                | (1ull << BLKDEBUGIO_TYPE_DISCARD)
+                | (1ull << BLKDEBUGIO_TYPE_FLUSH);
+        }
+
         break;
=20
     case ACTION_SET_STATE:
@@ -470,7 +500,8 @@ out:
     return ret;
 }
=20
-static int rule_check(BlockDriverState *bs, uint64_t offset, uint64_t by=
tes)
+static int rule_check(BlockDriverState *bs, uint64_t offset, uint64_t by=
tes,
+                      BlkdebugIOType iotype)
 {
     BDRVBlkdebugState *s =3D bs->opaque;
     BlkdebugRule *rule =3D NULL;
@@ -480,9 +511,10 @@ static int rule_check(BlockDriverState *bs, uint64_t=
 offset, uint64_t bytes)
     QSIMPLEQ_FOREACH(rule, &s->active_rules, active_next) {
         uint64_t inject_offset =3D rule->options.inject.offset;
=20
-        if (inject_offset =3D=3D -1 ||
-            (bytes && inject_offset >=3D offset &&
-             inject_offset < offset + bytes))
+        if ((inject_offset =3D=3D -1 ||
+             (bytes && inject_offset >=3D offset &&
+              inject_offset < offset + bytes)) &&
+            (rule->options.inject.iotype_mask & (1ull << iotype)))
         {
             break;
         }
@@ -521,7 +553,7 @@ blkdebug_co_preadv(BlockDriverState *bs, uint64_t off=
set, uint64_t bytes,
         assert(bytes <=3D bs->bl.max_transfer);
     }
=20
-    err =3D rule_check(bs, offset, bytes);
+    err =3D rule_check(bs, offset, bytes, BLKDEBUGIO_TYPE_READ);
     if (err) {
         return err;
     }
@@ -542,7 +574,7 @@ blkdebug_co_pwritev(BlockDriverState *bs, uint64_t of=
fset, uint64_t bytes,
         assert(bytes <=3D bs->bl.max_transfer);
     }
=20
-    err =3D rule_check(bs, offset, bytes);
+    err =3D rule_check(bs, offset, bytes, BLKDEBUGIO_TYPE_WRITE);
     if (err) {
         return err;
     }
@@ -552,7 +584,7 @@ blkdebug_co_pwritev(BlockDriverState *bs, uint64_t of=
fset, uint64_t bytes,
=20
 static int blkdebug_co_flush(BlockDriverState *bs)
 {
-    int err =3D rule_check(bs, 0, 0);
+    int err =3D rule_check(bs, 0, 0, BLKDEBUGIO_TYPE_FLUSH);
=20
     if (err) {
         return err;
@@ -586,7 +618,7 @@ static int coroutine_fn blkdebug_co_pwrite_zeroes(Blo=
ckDriverState *bs,
         assert(bytes <=3D bs->bl.max_pwrite_zeroes);
     }
=20
-    err =3D rule_check(bs, offset, bytes);
+    err =3D rule_check(bs, offset, bytes, BLKDEBUGIO_TYPE_WRITE_ZEROES);
     if (err) {
         return err;
     }
@@ -620,7 +652,7 @@ static int coroutine_fn blkdebug_co_pdiscard(BlockDri=
verState *bs,
         assert(bytes <=3D bs->bl.max_pdiscard);
     }
=20
-    err =3D rule_check(bs, offset, bytes);
+    err =3D rule_check(bs, offset, bytes, BLKDEBUGIO_TYPE_DISCARD);
     if (err) {
         return err;
     }
--=20
2.20.1


