Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3876C2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 09:40:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67E4D2051A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 09:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="MRI02oN7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E4D2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM7CS-0002R8-Kj
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 05:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39659)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jM73Q-0007x2-Cj
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 05:31:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jM73O-00063n-Ed
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 05:31:28 -0400
Received: from mail-ve1eur01on0705.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::705]:64128
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jM73D-0005tu-40; Wed, 08 Apr 2020 05:31:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ld7aSy3Ir/irOgG7HJwHVno76mBvKtWM+v3thmuuBV112rmt5YmTDVTBO+Z8pVadou1v8zZrMIOF29BtAvymWQSh7U/MMCMFnAMK1fZNSBM2jCvHFgaS3jivn0oCwV8TIlz/4TOgIBo4/QPdDyNX+TUJrHsP0QKj7zwx1NVsmsi3dRfIJiSYYulKO/IaEg+Pp8v5ByWPnKQAPWa0owg0fbhzttVxOY/mwAXx/MzqcMPpYUXGtY0wAq5tmJG4FTrYx0Uv8NmvR3byYOyerVp2YTwRvOvwnIawxrTCk/uftfBdihGDxJiiU2L3vhRbjBdmDOyOVH1blg7/7TpRtSGC7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87vgTIBvLlPypl3q1WI4LHsEyMyb+g1xZpy6wBDLnHA=;
 b=Dw8720slMQD8MxJj0A1ujwL8wVuE5doySZgmpZpXudnQDzVqvEXRU488d07GCtHPzbfZJoPsii3mv6TGHB5rxlopAw0gfgsfNAW5GaNG70q4LPHQvKaXXDQ2Qgk3RZMg0v2/lhVP8b+ZydNC+fXP/WypOIm8FmQIP3/tIfzpIaOsEnn3+BIizgHB3nwujHhIhT6c0OsILxKEQtFVuIPARkG7SLK94XLUn1REyeENrl6G7UTD8ELJDeGc6eYRxhnEmGNUEkxjhKpXYPAnt5y8BFASNulrB/yxlE2hTMtVSMYUc7bVwATQgFdm4rRss5X0p3qofkgKbe+tjH6eAsPZCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87vgTIBvLlPypl3q1WI4LHsEyMyb+g1xZpy6wBDLnHA=;
 b=MRI02oN76c0sQCFQsATAk7lKQULVCDZXlQoIPHKhQwKUNdapJ2JSSMVKn6Rv8YVx7iYrUC5MS4qIw6pwTxkCwGT+EBiGRD2suTyuQhm7W14OJNbhfyny5XrgOU5WCDdrPPvKrSles7M26uXXN2h1Zmtcif4QvFXQkzJiEmW259k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5365.eurprd08.prod.outlook.com (10.141.173.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.16; Wed, 8 Apr 2020 09:31:10 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.021; Wed, 8 Apr 2020
 09:31:10 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 5/9] block/io: expand in_flight inc/dec section: simple cases
Date: Wed,  8 Apr 2020 12:30:47 +0300
Message-ID: <20200408093051.9893-6-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200408093051.9893-1-vsementsov@virtuozzo.com>
References: <20200408093051.9893-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM6PR01CA0041.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::18) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.139) by
 AM6PR01CA0041.eurprd01.prod.exchangelabs.com (2603:10a6:20b:e0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend
 Transport; Wed, 8 Apr 2020 09:31:10 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.139]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5da3fb8d-e2fa-4fa1-1dfb-08d7db9f92ce
X-MS-TrafficTypeDiagnostic: AM7PR08MB5365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53654FED31216A1CB137E49FC1C00@AM7PR08MB5365.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0367A50BB1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(396003)(346002)(136003)(39840400004)(366004)(376002)(52116002)(6506007)(5660300002)(2906002)(6916009)(2616005)(956004)(478600001)(16526019)(186003)(26005)(86362001)(66946007)(66556008)(66476007)(1076003)(6512007)(6486002)(107886003)(30864003)(4326008)(6666004)(36756003)(8676002)(316002)(8936002)(81156014)(81166007);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GhP91Yely4Sl2uV+WHuoCVUFJfMud20Qupt1vI4mYNiJS39CctmnhVrWvGlxI8FBO+kO5/XCeNuBFE4fSw45+fJp2vpaFNXBtNAENrnW22ilHsTYqs50KAgO3eINqIoO3RcJQJILTBToKQS7SlY1DTcrkozqR/dNEILWwGrj3jy5sjAk01PtcbF1GUTuU2eYep4TlXuI++j37hmWE7BenIyMY6obbBhpy59EYZCruDlcIkXNC7tkOeu150Aa4XYVhlPYLAhGjFA90qg6/kvHajlGbAgbjZxy36Pi7/GkjmPT91oedslylJgifFvCTHxvPNmP97RnXipfmaqDRnKGJa/tGw2kk6DhwEcs3L3uNT7RtSfW6GIeQihmiypSb9AjVAXCyh89RFVviTBCwiRBuDhwXjGgMKJQSNxBnJkH433Kg5CFXz7tTOsEdjU4vZAx
X-MS-Exchange-AntiSpam-MessageData: PZ88VNTa6nzdufFOKvPWwmYQEJUcZ7wLuyOVJLgchm5NeFnm7pyezyvnyg2myUzYM2VCCRehmze2qtTROef/JHOiVzs8GSdsfR+AR3gc0PZ75B/6cetTahJIuk6dFFXoNjfngH+ANFyAzi2KjS7cQg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da3fb8d-e2fa-4fa1-1dfb-08d7db9f92ce
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2020 09:31:10.7281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anjz09E3Uz5OmbEnCcEIbNuo7cAh713MGtK9f42HHMXT+Mzw6tpxfwRhhmIk/NHVxO5Q1ahepDup6NLhwa1BkYMniTCCujuWfcGbTic2oF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5365
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:111:f400:fe1f::705
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's safer to expand in_flight request to start before enter to
coroutine in synchronous wrappers and end after BDRV_POLL_WHILE loop.
Note that qemu_coroutine_enter may only schedule the coroutine in some
circumstances.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c | 155 ++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 119 insertions(+), 36 deletions(-)

diff --git a/block/io.c b/block/io.c
index dfbe68f428..9b57c7e422 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1511,7 +1511,8 @@ int coroutine_fn bdrv_co_preadv(BdrvChild *child,
     return bdrv_co_preadv_part(child, offset, bytes, qiov, 0, flags);
 }
=20
-int coroutine_fn bdrv_co_preadv_part(BdrvChild *child,
+/* To be called between exactly one pair of bdrv_inc/dec_in_flight() */
+static int coroutine_fn bdrv_do_preadv_part(BdrvChild *child,
     int64_t offset, unsigned int bytes,
     QEMUIOVector *qiov, size_t qiov_offset,
     BdrvRequestFlags flags)
@@ -1540,8 +1541,6 @@ int coroutine_fn bdrv_co_preadv_part(BdrvChild *child=
,
         return 0;
     }
=20
-    bdrv_inc_in_flight(bs);
-
     /* Don't do copy-on-read if we read data before write operation */
     if (atomic_read(&bs->copy_on_read)) {
         flags |=3D BDRV_REQ_COPY_ON_READ;
@@ -1554,13 +1553,26 @@ int coroutine_fn bdrv_co_preadv_part(BdrvChild *chi=
ld,
                               bs->bl.request_alignment,
                               qiov, qiov_offset, flags);
     tracked_request_end(&req);
-    bdrv_dec_in_flight(bs);
=20
     bdrv_padding_destroy(&pad);
=20
     return ret;
 }
=20
+int coroutine_fn bdrv_co_preadv_part(BdrvChild *child,
+    int64_t offset, unsigned int bytes,
+    QEMUIOVector *qiov, size_t qiov_offset,
+    BdrvRequestFlags flags)
+{
+    int ret;
+
+    bdrv_inc_in_flight(child->bs);
+    ret =3D bdrv_do_preadv_part(child, offset, bytes, qiov, qiov_offset, f=
lags);
+    bdrv_dec_in_flight(child->bs);
+
+    return ret;
+}
+
 static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
     int64_t offset, int bytes, BdrvRequestFlags flags)
 {
@@ -1922,7 +1934,8 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
     return bdrv_co_pwritev_part(child, offset, bytes, qiov, 0, flags);
 }
=20
-int coroutine_fn bdrv_co_pwritev_part(BdrvChild *child,
+/* To be called between exactly one pair of bdrv_inc/dec_in_flight() */
+static int coroutine_fn bdrv_do_pwritev_part(BdrvChild *child,
     int64_t offset, unsigned int bytes, QEMUIOVector *qiov, size_t qiov_of=
fset,
     BdrvRequestFlags flags)
 {
@@ -1962,7 +1975,6 @@ int coroutine_fn bdrv_co_pwritev_part(BdrvChild *chil=
d,
         return 0;
     }
=20
-    bdrv_inc_in_flight(bs);
     /*
      * Align write if necessary by performing a read-modify-write cycle.
      * Pad qiov with the read parts and be sure to have a tracked request =
not
@@ -1987,7 +1999,19 @@ int coroutine_fn bdrv_co_pwritev_part(BdrvChild *chi=
ld,
=20
 out:
     tracked_request_end(&req);
-    bdrv_dec_in_flight(bs);
+
+    return ret;
+}
+
+int coroutine_fn bdrv_co_pwritev_part(BdrvChild *child,
+    int64_t offset, unsigned int bytes, QEMUIOVector *qiov, size_t qiov_of=
fset,
+    BdrvRequestFlags flags)
+{
+    int ret;
+
+    bdrv_inc_in_flight(child->bs);
+    ret =3D bdrv_do_pwritev_part(child, offset, bytes, qiov, qiov_offset, =
flags);
+    bdrv_dec_in_flight(child->bs);
=20
     return ret;
 }
@@ -2019,12 +2043,12 @@ static void coroutine_fn bdrv_rw_co_entry(void *opa=
que)
     RwCo *rwco =3D opaque;
=20
     if (!rwco->is_write) {
-        rwco->ret =3D bdrv_co_preadv(rwco->child, rwco->offset,
-                                   rwco->qiov->size, rwco->qiov,
+        rwco->ret =3D bdrv_do_preadv_part(rwco->child, rwco->offset,
+                                   rwco->qiov->size, rwco->qiov, 0,
                                    rwco->flags);
     } else {
-        rwco->ret =3D bdrv_co_pwritev(rwco->child, rwco->offset,
-                                    rwco->qiov->size, rwco->qiov,
+        rwco->ret =3D bdrv_do_pwritev_part(rwco->child, rwco->offset,
+                                    rwco->qiov->size, rwco->qiov, 0,
                                     rwco->flags);
     }
     aio_wait_kick();
@@ -2047,6 +2071,8 @@ static int bdrv_prwv_co(BdrvChild *child, int64_t off=
set,
         .flags =3D flags,
     };
=20
+    bdrv_inc_in_flight(child->bs);
+
     if (qemu_in_coroutine()) {
         /* Fast-path if already in coroutine context */
         bdrv_rw_co_entry(&rwco);
@@ -2055,6 +2081,9 @@ static int bdrv_prwv_co(BdrvChild *child, int64_t off=
set,
         bdrv_coroutine_enter(child->bs, co);
         BDRV_POLL_WHILE(child->bs, rwco.ret =3D=3D NOT_DONE);
     }
+
+    bdrv_dec_in_flight(child->bs);
+
     return rwco.ret;
 }
=20
@@ -2700,15 +2729,14 @@ typedef struct BdrvVmstateCo {
     int                 ret;
 } BdrvVmstateCo;
=20
+/* To be called between exactly one pair of bdrv_inc/dec_in_flight() */
 static int coroutine_fn
-bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
+bdrv_do_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
                    bool is_read)
 {
     BlockDriver *drv =3D bs->drv;
     int ret =3D -ENOTSUP;
=20
-    bdrv_inc_in_flight(bs);
-
     if (!drv) {
         ret =3D -ENOMEDIUM;
     } else if (drv->bdrv_load_vmstate) {
@@ -2718,17 +2746,18 @@ bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVect=
or *qiov, int64_t pos,
             ret =3D drv->bdrv_save_vmstate(bs, qiov, pos);
         }
     } else if (bs->file) {
-        ret =3D bdrv_co_rw_vmstate(bs->file->bs, qiov, pos, is_read);
+        bdrv_inc_in_flight(bs->file->bs);
+        ret =3D bdrv_do_rw_vmstate(bs->file->bs, qiov, pos, is_read);
+        bdrv_dec_in_flight(bs->file->bs);
     }
=20
-    bdrv_dec_in_flight(bs);
     return ret;
 }
=20
 static void coroutine_fn bdrv_co_rw_vmstate_entry(void *opaque)
 {
     BdrvVmstateCo *co =3D opaque;
-    co->ret =3D bdrv_co_rw_vmstate(co->bs, co->qiov, co->pos, co->is_read)=
;
+    co->ret =3D bdrv_do_rw_vmstate(co->bs, co->qiov, co->pos, co->is_read)=
;
     aio_wait_kick();
 }
=20
@@ -2736,8 +2765,12 @@ static inline int
 bdrv_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
                 bool is_read)
 {
+    int ret;
+
+    bdrv_inc_in_flight(bs);
+
     if (qemu_in_coroutine()) {
-        return bdrv_co_rw_vmstate(bs, qiov, pos, is_read);
+        ret =3D bdrv_do_rw_vmstate(bs, qiov, pos, is_read);
     } else {
         BdrvVmstateCo data =3D {
             .bs         =3D bs,
@@ -2750,8 +2783,12 @@ bdrv_rw_vmstate(BlockDriverState *bs, QEMUIOVector *=
qiov, int64_t pos,
=20
         bdrv_coroutine_enter(bs, co);
         BDRV_POLL_WHILE(bs, data.ret =3D=3D -EINPROGRESS);
-        return data.ret;
+        ret =3D data.ret;
     }
+
+    bdrv_dec_in_flight(bs);
+
+    return ret;
 }
=20
 int bdrv_save_vmstate(BlockDriverState *bs, const uint8_t *buf,
@@ -2829,16 +2866,14 @@ void bdrv_aio_cancel_async(BlockAIOCB *acb)
 /**************************************************************/
 /* Coroutine block device emulation */
=20
-int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
+/* To be called between exactly one pair of bdrv_inc/dec_in_flight() */
+static int coroutine_fn bdrv_do_flush(BlockDriverState *bs)
 {
     int current_gen;
-    int ret =3D 0;
-
-    bdrv_inc_in_flight(bs);
+    int ret;
=20
-    if (!bdrv_is_inserted(bs) || bdrv_is_read_only(bs) ||
-        bdrv_is_sg(bs)) {
-        goto early_exit;
+    if (!bdrv_is_inserted(bs) || bdrv_is_read_only(bs) || bdrv_is_sg(bs)) =
{
+        return 0;
     }
=20
     qemu_co_mutex_lock(&bs->reqs_lock);
@@ -2936,8 +2971,17 @@ out:
     qemu_co_queue_next(&bs->flush_queue);
     qemu_co_mutex_unlock(&bs->reqs_lock);
=20
-early_exit:
+    return ret;
+}
+
+int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
+{
+    int ret;
+
+    bdrv_inc_in_flight(bs);
+    ret =3D bdrv_do_flush(bs);
     bdrv_dec_in_flight(bs);
+
     return ret;
 }
=20
@@ -2950,7 +2994,7 @@ static void coroutine_fn bdrv_flush_co_entry(void *op=
aque)
 {
     FlushCo *rwco =3D opaque;
=20
-    rwco->ret =3D bdrv_co_flush(rwco->bs);
+    rwco->ret =3D bdrv_do_flush(rwco->bs);
     aio_wait_kick();
 }
=20
@@ -2962,6 +3006,8 @@ int bdrv_flush(BlockDriverState *bs)
         .ret =3D NOT_DONE,
     };
=20
+    bdrv_inc_in_flight(bs);
+
     if (qemu_in_coroutine()) {
         /* Fast-path if already in coroutine context */
         bdrv_flush_co_entry(&flush_co);
@@ -2971,11 +3017,14 @@ int bdrv_flush(BlockDriverState *bs)
         BDRV_POLL_WHILE(bs, flush_co.ret =3D=3D NOT_DONE);
     }
=20
+    bdrv_dec_in_flight(bs);
+
     return flush_co.ret;
 }
=20
-int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset,
-                                  int64_t bytes)
+/* To be called between exactly one pair of bdrv_inc/dec_in_flight() */
+static int coroutine_fn bdrv_do_pdiscahd(BdrvChild *child, int64_t offset,
+                                         int64_t bytes)
 {
     BdrvTrackedRequest req;
     int max_pdiscard, ret;
@@ -3013,7 +3062,6 @@ int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, i=
nt64_t offset,
     head =3D offset % align;
     tail =3D (offset + bytes) % align;
=20
-    bdrv_inc_in_flight(bs);
     tracked_request_begin(&req, bs, offset, bytes, BDRV_TRACKED_DISCARD);
=20
     ret =3D bdrv_co_write_req_prepare(child, offset, bytes, &req, 0);
@@ -3084,7 +3132,19 @@ int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, =
int64_t offset,
 out:
     bdrv_co_write_req_finish(child, req.offset, req.bytes, &req, ret);
     tracked_request_end(&req);
-    bdrv_dec_in_flight(bs);
+    return ret;
+}
+
+int coroutine_fn bdrv_co_pdiscard(BdrvChild *child,
+                                  int64_t offset, int64_t bytes)
+{
+    int ret;
+    BlockDriverState *bs =3D child->bs;
+
+    bdrv_inc_in_flight(child->bs);
+    ret =3D bdrv_do_pdiscahd(child, offset, bytes);
+    bdrv_dec_in_flight(child->bs);
+
     return ret;
 }
=20
@@ -3113,6 +3173,8 @@ int bdrv_pdiscard(BdrvChild *child, int64_t offset, i=
nt64_t bytes)
         .ret =3D NOT_DONE,
     };
=20
+    bdrv_inc_in_flight(child->bs);
+
     if (qemu_in_coroutine()) {
         /* Fast-path if already in coroutine context */
         bdrv_pdiscard_co_entry(&rwco);
@@ -3122,6 +3184,8 @@ int bdrv_pdiscard(BdrvChild *child, int64_t offset, i=
nt64_t bytes)
         BDRV_POLL_WHILE(child->bs, rwco.ret =3D=3D NOT_DONE);
     }
=20
+    bdrv_dec_in_flight(child->bs);
+
     return rwco.ret;
 }
=20
@@ -3412,9 +3476,12 @@ static void bdrv_parent_cb_resize(BlockDriverState *=
bs)
  * If 'exact' is true, the file must be resized to exactly the given
  * 'offset'.  Otherwise, it is sufficient for the node to be at least
  * 'offset' bytes in length.
+ *
+ * To be called between exactly one pair of bdrv_inc/dec_in_flight()
  */
-int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset, bool e=
xact,
-                                  PreallocMode prealloc, Error **errp)
+static int coroutine_fn bdrv_do_truncate(BdrvChild *child,
+                                         int64_t offset, bool exact,
+                                         PreallocMode prealloc, Error **er=
rp)
 {
     BlockDriverState *bs =3D child->bs;
     BlockDriver *drv =3D bs->drv;
@@ -3445,7 +3512,6 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, i=
nt64_t offset, bool exact,
         new_bytes =3D 0;
     }
=20
-    bdrv_inc_in_flight(bs);
     tracked_request_begin(&req, bs, offset - new_bytes, new_bytes,
                           BDRV_TRACKED_TRUNCATE);
=20
@@ -3494,6 +3560,19 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, =
int64_t offset, bool exact,
=20
 out:
     tracked_request_end(&req);
+
+    return ret;
+}
+
+int coroutine_fn bdrv_co_truncate(BdrvChild *child,
+                                  int64_t offset, bool exact,
+                                  PreallocMode prealloc, Error **errp)
+{
+    int ret;
+    BlockDriverState *bs =3D child->bs;
+
+    bdrv_inc_in_flight(bs);
+    ret =3D bdrv_do_truncate(child, offset, exact, prealloc, errp);
     bdrv_dec_in_flight(bs);
=20
     return ret;
@@ -3511,7 +3590,7 @@ typedef struct TruncateCo {
 static void coroutine_fn bdrv_truncate_co_entry(void *opaque)
 {
     TruncateCo *tco =3D opaque;
-    tco->ret =3D bdrv_co_truncate(tco->child, tco->offset, tco->exact,
+    tco->ret =3D bdrv_do_truncate(tco->child, tco->offset, tco->exact,
                                 tco->prealloc, tco->errp);
     aio_wait_kick();
 }
@@ -3529,6 +3608,8 @@ int bdrv_truncate(BdrvChild *child, int64_t offset, b=
ool exact,
         .ret        =3D NOT_DONE,
     };
=20
+    bdrv_inc_in_flight(child->bs);
+
     if (qemu_in_coroutine()) {
         /* Fast-path if already in coroutine context */
         bdrv_truncate_co_entry(&tco);
@@ -3538,5 +3619,7 @@ int bdrv_truncate(BdrvChild *child, int64_t offset, b=
ool exact,
         BDRV_POLL_WHILE(child->bs, tco.ret =3D=3D NOT_DONE);
     }
=20
+    bdrv_dec_in_flight(child->bs);
+
     return tco.ret;
 }
--=20
2.21.0


