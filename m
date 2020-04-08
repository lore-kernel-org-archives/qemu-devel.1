Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DFBC2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 09:37:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 633F92051A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 09:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="mAcfMQJz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 633F92051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM79e-0006Ah-Id
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 05:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39562)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jM73K-0007ov-Du
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 05:31:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jM73I-0005zj-RA
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 05:31:22 -0400
Received: from mail-ve1eur01on0705.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::705]:64128
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jM73E-0005tu-O5; Wed, 08 Apr 2020 05:31:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6zyWLh2wbjjB7m+gwS5BoukskwX3/6dc0aSzmBeAmAcOUrPj78QsoDD/Q5ZdPkJ8ATJzMcyu7K+020smMFxQdWHCvfYbk9BF0R9OMGhOZYVdxA3ayFUDUI3QS4nNHl5he1UgVYFXoRtLmV9SK/0lzFpRYFY2bPFx8y190w6J9Cv2F/IOM4d6ebM2Ip/GYKMZSrWjbORS+dsd4rEi/tCZg/u0suROB37Q+gbp3bege77aK3WmKoMgb1LFZEhZT63AM3Quf4zZfs921Hw7vGrT8YU6G8T52lpaZCB23/DskbCDT2ryI3/03+Py9nx8ixDaNUcw+JCkRctSvdnf2e6gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1H6pHZ5MlNjEidQ6XK14YXzURJC3WSagDRIKLy4f38=;
 b=deM97R+ewQP38IZv8tv9Vn/gyU9/k7WtcwtNK1rwRx5HCzSvoxyFrZj1nTYeaf5CIcNUFNN7/OGUPUtcbiHdxTC2pJfg32RVVz5zLGZuoI6rucfdbcZpttMaA7lxFFqjK3sNvPMu4Gr0ULJ2Uuk1s4lsQN0SU2HRofp9gMoOvqjgC8zwJhUraTG+3/rAthLmkdBcje3dlWKJpbDmbW4MfK/sIFdhqBbvlnT1iOBiu5KKR24wR+PuX0sFFFUeX9CfQfJ/5W1mFRetcH0ytG/rCX1mns7rQ2ufIYBS8q7wTt75+QhCAaW6zl5Bf15IJVHxj1b7Disa147KwAsjprxZUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1H6pHZ5MlNjEidQ6XK14YXzURJC3WSagDRIKLy4f38=;
 b=mAcfMQJzo0iu92k25nbL1R1Hap3lIkJI7Pk14Yi8R7unrYbTAwMOHlERIglmtRLCE3TAt6F1uE7XTdJOoP5Wqat0GMgU2OHfvQGSbS1duAIOLThhzguA8wPzitS50wfa025kmF02tTBOb0uyfKdBB8cl4m/kM9289sdDUkKt62o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5365.eurprd08.prod.outlook.com (10.141.173.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.16; Wed, 8 Apr 2020 09:31:11 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.021; Wed, 8 Apr 2020
 09:31:11 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 6/9] block/io: expand in_flight inc/dec section: block-status
Date: Wed,  8 Apr 2020 12:30:48 +0300
Message-ID: <20200408093051.9893-7-vsementsov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: f7731202-1c94-40e9-ba61-08d7db9f9341
X-MS-TrafficTypeDiagnostic: AM7PR08MB5365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB536558808CAE226C0F906050C1C00@AM7PR08MB5365.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0367A50BB1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(396003)(346002)(136003)(39840400004)(366004)(376002)(52116002)(6506007)(5660300002)(2906002)(6916009)(2616005)(956004)(478600001)(16526019)(186003)(26005)(86362001)(66946007)(66556008)(66476007)(1076003)(6512007)(6486002)(107886003)(4326008)(6666004)(36756003)(8676002)(316002)(8936002)(81156014)(81166007);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7IesvwQC6KydwE7aGvo9UL501ILrZeGfLgVKYqBQGRcsqH2bLeavoaEDDPCLZcvQ5MUBFObfplbw0fnFolsqzPuSUXEWpd1J176xTPUItvokKSENjDCqQKAkDKYpfpXxumwOJWJNk70ljKw+pBhXzMO8l6p0ljfiZe1mUAmDhuxyjHNegctLR1rlxbu7jZWuiHiI3ivVCi6LXmzZt+bknn66VQ/nwdhl0ymouCzH8Yxr50EPLZTm9/wIDDHsOUSbMey2mzxSfs8WxW08oY++bJTSylspJxKaQZOfM26ogHCov/pMMZ8sj1NLsoPPBzSU015voZFb5IjV8De8TuBRIuuu/l9uTi6gSRd8lPYuGAqlcTWUAsUbVG9ze0KtNNjwj+VH+L97ILDL5a3R2XUMqE//MlwvAw1yZt1oQZ63/x7YfFpoyMA9vgw6+bNFdu2O
X-MS-Exchange-AntiSpam-MessageData: NU4Iht1w80Lc5h3ffaBPpSNOG/RcIpmkyLYKj53+Dh20X0VMGlHOBq3aUKhDOjjuVzY4bts2yLWBZEz9qdN31Ll8gWGC0NlBJo/SdSOru41nRfX+oywPea13TRGWTaFn2lOgnJqmiaZcRWD0pSENzg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7731202-1c94-40e9-ba61-08d7db9f9341
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2020 09:31:11.4897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L+h2AKPcFab9+m+v2fqpiMDynQkooKaVhTyMVjHtcsb1zn8+mEldg8oB3mw5+ZpMC6QicFxUw1t0jekeY5DhI3L6HkQPM0umm8/yOGghsZo=
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

block-status requests are complex, they involve querying different
block driver states across backing chain. Let's expand only in_flight
section for the top bs, keeping other sections as is.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c | 60 +++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 46 insertions(+), 14 deletions(-)

diff --git a/block/io.c b/block/io.c
index 9b57c7e422..760170731f 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2302,6 +2302,10 @@ int coroutine_fn bdrv_co_block_status_from_backing(B=
lockDriverState *bs,
  * _ZERO where possible; otherwise, the result favors larger 'pnum',
  * with a focus on accurate BDRV_BLOCK_ALLOCATED.
  *
+ * If 'inc_in_flight' is true, in_flight counter will be increased for bs =
during
+ * the operation. All nested block_status calls will increase the counter =
for
+ * corresponding bs anyway.
+ *
  * If 'offset' is beyond the end of the disk image the return value is
  * BDRV_BLOCK_EOF and 'pnum' is set to 0.
  *
@@ -2320,7 +2324,7 @@ int coroutine_fn bdrv_co_block_status_from_backing(Bl=
ockDriverState *bs,
  * set to the host mapping and BDS corresponding to the guest offset.
  */
 static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
-                                             bool want_zero,
+                                             bool want_zero, bool inc_in_f=
light,
                                              int64_t offset, int64_t bytes=
,
                                              int64_t *pnum, int64_t *map,
                                              BlockDriverState **file)
@@ -2371,7 +2375,9 @@ static int coroutine_fn bdrv_co_block_status(BlockDri=
verState *bs,
         goto early_out;
     }
=20
-    bdrv_inc_in_flight(bs);
+    if (inc_in_flight) {
+        bdrv_inc_in_flight(bs);
+    }
=20
     /* Round out to request_alignment boundaries */
     align =3D bs->bl.request_alignment;
@@ -2408,7 +2414,7 @@ static int coroutine_fn bdrv_co_block_status(BlockDri=
verState *bs,
=20
     if (ret & BDRV_BLOCK_RAW) {
         assert(ret & BDRV_BLOCK_OFFSET_VALID && local_file);
-        ret =3D bdrv_co_block_status(local_file, want_zero, local_map,
+        ret =3D bdrv_co_block_status(local_file, want_zero, true, local_ma=
p,
                                    *pnum, pnum, &local_map, &local_file);
         goto out;
     }
@@ -2435,7 +2441,7 @@ static int coroutine_fn bdrv_co_block_status(BlockDri=
verState *bs,
         int64_t file_pnum;
         int ret2;
=20
-        ret2 =3D bdrv_co_block_status(local_file, want_zero, local_map,
+        ret2 =3D bdrv_co_block_status(local_file, want_zero, true, local_m=
ap,
                                     *pnum, &file_pnum, NULL, NULL);
         if (ret2 >=3D 0) {
             /* Ignore errors.  This is just providing extra information, i=
t
@@ -2458,7 +2464,9 @@ static int coroutine_fn bdrv_co_block_status(BlockDri=
verState *bs,
     }
=20
 out:
-    bdrv_dec_in_flight(bs);
+    if (inc_in_flight) {
+        bdrv_dec_in_flight(bs);
+    }
     if (ret >=3D 0 && offset + *pnum =3D=3D total_size) {
         ret |=3D BDRV_BLOCK_EOF;
     }
@@ -2472,9 +2480,15 @@ early_out:
     return ret;
 }
=20
+/*
+ * If 'inc_in_flight' is true, in_flight counter will be increased for bs =
during
+ * the operation. All block_status calls to the backing chain of bs will
+ * increase the counter for corresponding bs anyway.
+ */
 static int coroutine_fn bdrv_co_block_status_above(BlockDriverState *bs,
                                                    BlockDriverState *base,
                                                    bool want_zero,
+                                                   bool inc_in_flight,
                                                    int64_t offset,
                                                    int64_t bytes,
                                                    int64_t *pnum,
@@ -2487,11 +2501,13 @@ static int coroutine_fn bdrv_co_block_status_above(=
BlockDriverState *bs,
=20
     assert(bs !=3D base);
     for (p =3D bs; p !=3D base; p =3D backing_bs(p)) {
-        ret =3D bdrv_co_block_status(p, want_zero, offset, bytes, pnum, ma=
p,
-                                   file);
+        ret =3D bdrv_co_block_status(p, want_zero, inc_in_flight,
+                                   offset, bytes, pnum, map, file);
         if (ret < 0) {
             break;
         }
+        inc_in_flight =3D true;
+
         if (ret & BDRV_BLOCK_ZERO && ret & BDRV_BLOCK_EOF && !first) {
             /*
              * Reading beyond the end of the file continues to read
@@ -2513,15 +2529,16 @@ static int coroutine_fn bdrv_co_block_status_above(=
BlockDriverState *bs,
 }
=20
 static int coroutine_fn bdrv_co_is_allocated(BlockDriverState *bs,
+                                             bool inc_in_flight,
                                              int64_t offset, int64_t bytes=
,
                                              int64_t *pnum)
 {
     int ret;
     int64_t dummy;
=20
-    ret =3D bdrv_co_block_status_above(bs, backing_bs(bs), false, offset,
-                                     bytes, pnum ? pnum : &dummy, NULL,
-                                     NULL);
+    ret =3D bdrv_co_block_status_above(bs, backing_bs(bs), false, inc_in_f=
light,
+                                     offset, bytes, pnum ? pnum : &dummy,
+                                     NULL, NULL);
     if (ret < 0) {
         return ret;
     }
@@ -2534,7 +2551,7 @@ static void coroutine_fn bdrv_block_status_above_co_e=
ntry(void *opaque)
     BdrvCoBlockStatusData *data =3D opaque;
=20
     data->ret =3D bdrv_co_block_status_above(data->bs, data->base,
-                                           data->want_zero,
+                                           data->want_zero, false,
                                            data->offset, data->bytes,
                                            data->pnum, data->map, data->fi=
le);
     data->done =3D true;
@@ -2566,6 +2583,8 @@ static int bdrv_common_block_status_above(BlockDriver=
State *bs,
         .done =3D false,
     };
=20
+    bdrv_inc_in_flight(bs);
+
     if (qemu_in_coroutine()) {
         /* Fast-path if already in coroutine context */
         bdrv_block_status_above_co_entry(&data);
@@ -2574,6 +2593,9 @@ static int bdrv_common_block_status_above(BlockDriver=
State *bs,
         bdrv_coroutine_enter(bs, co);
         BDRV_POLL_WHILE(bs, !data.done);
     }
+
+    bdrv_dec_in_flight(bs);
+
     return data.ret;
 }
=20
@@ -2623,15 +2645,19 @@ int coroutine_fn bdrv_is_allocated(BlockDriverState=
 *bs, int64_t offset,
  * words, the result is not necessarily the maximum possible range);
  * but 'pnum' will only be 0 when end of file is reached.
  *
+ * To be called between exactly one pair of bdrv_inc/dec_in_flight() for t=
op bs.
+ * bdrv_do_is_allocated_above takes care of increasing in_fligth for other=
 block
+ * driver states from bs backing chain.
  */
 static int coroutine_fn
-bdrv_co_is_allocated_above(BlockDriverState *top, BlockDriverState *base,
+bdrv_do_is_allocated_above(BlockDriverState *top, BlockDriverState *base,
                            bool include_base, int64_t offset, int64_t byte=
s,
                            int64_t *pnum)
 {
     BlockDriverState *intermediate;
     int ret;
     int64_t n =3D bytes;
+    bool inc_in_flight =3D false;
=20
     assert(base || !include_base);
=20
@@ -2641,10 +2667,12 @@ bdrv_co_is_allocated_above(BlockDriverState *top, B=
lockDriverState *base,
         int64_t size_inter;
=20
         assert(intermediate);
-        ret =3D bdrv_co_is_allocated(intermediate, offset, bytes, &pnum_in=
ter);
+        ret =3D bdrv_co_is_allocated(intermediate, inc_in_flight, offset, =
bytes,
+                                   &pnum_inter);
         if (ret < 0) {
             return ret;
         }
+        inc_in_flight =3D true;
         if (ret) {
             *pnum =3D pnum_inter;
             return 1;
@@ -2685,7 +2713,7 @@ static void coroutine_fn bdrv_is_allocated_above_co_e=
ntry(void *opaque)
 {
     BdrvCoIsAllocatedAboveData *data =3D opaque;
=20
-    data->ret =3D bdrv_co_is_allocated_above(data->top, data->base,
+    data->ret =3D bdrv_do_is_allocated_above(data->top, data->base,
                                            data->include_base,
                                            data->offset, data->bytes,
                                            data->pnum);
@@ -2709,6 +2737,8 @@ bdrv_is_allocated_above(BlockDriverState *top, BlockD=
riverState *base,
         .done =3D false,
     };
=20
+    bdrv_inc_in_flight(top);
+
     if (qemu_in_coroutine()) {
         /* Fast-path if already in coroutine context */
         bdrv_is_allocated_above_co_entry(&data);
@@ -2718,6 +2748,8 @@ bdrv_is_allocated_above(BlockDriverState *top, BlockD=
riverState *base,
         BDRV_POLL_WHILE(top, !data.done);
     }
=20
+    bdrv_inc_in_flight(top);
+
     return data.ret;
 }
=20
--=20
2.21.0


