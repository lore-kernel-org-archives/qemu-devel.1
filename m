Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61E7C2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 09:39:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AEEA2051A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 09:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hm6uot3d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AEEA2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM7B7-0000Ov-Mq
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 05:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39641)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jM73O-0007ub-43
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 05:31:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jM73K-00060y-B4
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 05:31:26 -0400
Received: from mail-ve1eur01on0705.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::705]:64128
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jM73C-0005tu-KT; Wed, 08 Apr 2020 05:31:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VaJxYwI/uY9YAuRM6/ZxBdw3hqlYA8kJqmuYxbbCUU2Ed5dnvx1Xy4Y+dva9ppApJ+NnN5J/wXFdzeTLKwcj51mluRKvQt/edD6Dq2J7gLoQ/VG09DSPuIrLwEgwWi0UChtgfZ5MnZFKmar6t4m8YipJAUXypeXP03g7RqMau8XTVlW/PxtMIQISpzIPXE0uBsxBcNPJBgEdZ2pSK1v1wUsXiKcKGsCk1VvQSRfns+RaqKDkZaB2YB30PFY8b+Ieizj1INJ25tYrzY/IQJiY2EGj+ODuU8htbmOl1DFrM4LZKotqASnDAQE/Rs2wFdjkDwjqYa9FTYSuB5r2zP9pGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VJnpE2mGEmt4jgF3NuA9S0FsQu40HYxfAMv1qFVuGg=;
 b=agmIpBLdRSEqGT4LnubWURTHGq+Go/xNwhiaVRJ0oIqqC2GCDs166W2lD5hg/xdzj17k2J+VJl+d7J14mnVNxwDKdFJNHjKRyc1ffcJi+87ha7idiF6oubQrGBpzuI364NjSUWP1+HWzvz6K36RnMHoVniSxUIHcWOmEi4F5WzY2WkrMzpG1q3rBzvZmhXFJxZbU51HsGc9TKvQ1IbOTBY/ny1iYFWdh1QGp+AqLO+YsDrpAKnrWXBRhta4MmNNt3r56vfgA8XjKVT9y8S/QWx8Z8JPzCCfsgXya0LXkjCAv0ak2h5Rs6G/rddDAXGQrk5LjmHFX2w3DSa4BoRdiLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VJnpE2mGEmt4jgF3NuA9S0FsQu40HYxfAMv1qFVuGg=;
 b=hm6uot3dxIP1G2Ndz3b/mS9XNiqbejjHSlITOwRa+vCjESWQdtR83FhWf4r+IsygDcHQePbuAsUDWFilbfPxUY9Xw8spgbOOeH/8BfOBDlvAFdmKJAkJY2yFZfYiEXzdbW5TxYb/ZbKNSBeYcExcqU2JUCnU+vF/47LILP3r/xQ=
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
Subject: [PATCH 4/9] block/io: move bdrv_rw_co_entry and friends down
Date: Wed,  8 Apr 2020 12:30:46 +0300
Message-ID: <20200408093051.9893-5-vsementsov@virtuozzo.com>
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
 Transport; Wed, 8 Apr 2020 09:31:09 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.139]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d187f82-67ba-4471-40a1-08d7db9f9256
X-MS-TrafficTypeDiagnostic: AM7PR08MB5365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5365A0D2D6282FEF5744D76EC1C00@AM7PR08MB5365.eurprd08.prod.outlook.com>
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
X-Microsoft-Antispam-Message-Info: szGXB4b+Bgz8FzMI2Np+RIMlLS3Ifesth9UM6Rdeuz01Z7eWrrCwMr5kUOZS7EszjKLxj3Ixxt/xgRFyjLg/aHnOcoPsVgpPxoMtZoJEmRYoWi/7TqBcVoIcnWghvGKuKv5bSxu2oGCi77Xco2/zIs+UVqkkik79OXVgGEfdD1UppC7FnOcIKdxrK2UV7cLmLgEcp6y9mNxFaD7GaNnjCSoF9ZplFewFa5aKV5O5aiFqwvd/n6sM8tWvqh5luysTu9Dg4m9OPx/u5Wy3PwCFQsF4M31AGz49W4L/5odFvOmQIPOccsRBZ+DrVl3lKAaRy3yudIl9SAolFEj2dmk05Olg51vJGiRte1ohS32PWG25UYZ6QLdR8PSO9xgg1Dfmd1NQJhdUIQekwj8jDyb63lwv2lYTnuZ3+C/zXtvnbsKH1JMf0wTyZfmaEl7lbe55
X-MS-Exchange-AntiSpam-MessageData: SpTk35Rrb2dYStfo985ZIunglyobTTkiTvpMbasQmDVkwP/Jijrgz31IVvnXXdAtgFNngji+EIXzP4g6ffEnpXuX0qC6J0DdTsLX/iIBmjnxf4eJtM+QR94rI0jp6zKkvTNqRYctUpjF+pYm/PTn4w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d187f82-67ba-4471-40a1-08d7db9f9256
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2020 09:31:09.9525 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TBoX4afQkL/t8CVEyNz632udhyxHphnSXOwAWrxTJKFaWmOQNvl71n7HVXseJ18au0RDIAzZqQdGcxzSw0oGx/3IKhkr06Ok8myDOGohL+c=
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

We are going to use bdrv_co_pwritev_part and bdrv_co_preadv_part in
bdrv_rw_co_entry, so move it down.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c | 361 +++++++++++++++++++++++++++--------------------------
 1 file changed, 181 insertions(+), 180 deletions(-)

diff --git a/block/io.c b/block/io.c
index 379e86eeb5..dfbe68f428 100644
--- a/block/io.c
+++ b/block/io.c
@@ -891,186 +891,6 @@ static int bdrv_check_byte_request(BlockDriverState *=
bs, int64_t offset,
     return 0;
 }
=20
-typedef struct RwCo {
-    BdrvChild *child;
-    int64_t offset;
-    QEMUIOVector *qiov;
-    bool is_write;
-    int ret;
-    BdrvRequestFlags flags;
-} RwCo;
-
-static void coroutine_fn bdrv_rw_co_entry(void *opaque)
-{
-    RwCo *rwco =3D opaque;
-
-    if (!rwco->is_write) {
-        rwco->ret =3D bdrv_co_preadv(rwco->child, rwco->offset,
-                                   rwco->qiov->size, rwco->qiov,
-                                   rwco->flags);
-    } else {
-        rwco->ret =3D bdrv_co_pwritev(rwco->child, rwco->offset,
-                                    rwco->qiov->size, rwco->qiov,
-                                    rwco->flags);
-    }
-    aio_wait_kick();
-}
-
-/*
- * Process a vectored synchronous request using coroutines
- */
-static int bdrv_prwv_co(BdrvChild *child, int64_t offset,
-                        QEMUIOVector *qiov, bool is_write,
-                        BdrvRequestFlags flags)
-{
-    Coroutine *co;
-    RwCo rwco =3D {
-        .child =3D child,
-        .offset =3D offset,
-        .qiov =3D qiov,
-        .is_write =3D is_write,
-        .ret =3D NOT_DONE,
-        .flags =3D flags,
-    };
-
-    if (qemu_in_coroutine()) {
-        /* Fast-path if already in coroutine context */
-        bdrv_rw_co_entry(&rwco);
-    } else {
-        co =3D qemu_coroutine_create(bdrv_rw_co_entry, &rwco);
-        bdrv_coroutine_enter(child->bs, co);
-        BDRV_POLL_WHILE(child->bs, rwco.ret =3D=3D NOT_DONE);
-    }
-    return rwco.ret;
-}
-
-int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
-                       int bytes, BdrvRequestFlags flags)
-{
-    QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(qiov, NULL, bytes);
-
-    return bdrv_prwv_co(child, offset, &qiov, true,
-                        BDRV_REQ_ZERO_WRITE | flags);
-}
-
-/*
- * Completely zero out a block device with the help of bdrv_pwrite_zeroes.
- * The operation is sped up by checking the block status and only writing
- * zeroes to the device if they currently do not return zeroes. Optional
- * flags are passed through to bdrv_pwrite_zeroes (e.g. BDRV_REQ_MAY_UNMAP=
,
- * BDRV_REQ_FUA).
- *
- * Returns < 0 on error, 0 on success. For error codes see bdrv_write().
- */
-int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags)
-{
-    int ret;
-    int64_t target_size, bytes, offset =3D 0;
-    BlockDriverState *bs =3D child->bs;
-
-    target_size =3D bdrv_getlength(bs);
-    if (target_size < 0) {
-        return target_size;
-    }
-
-    for (;;) {
-        bytes =3D MIN(target_size - offset, BDRV_REQUEST_MAX_BYTES);
-        if (bytes <=3D 0) {
-            return 0;
-        }
-        ret =3D bdrv_block_status(bs, offset, bytes, &bytes, NULL, NULL);
-        if (ret < 0) {
-            return ret;
-        }
-        if (ret & BDRV_BLOCK_ZERO) {
-            offset +=3D bytes;
-            continue;
-        }
-        ret =3D bdrv_pwrite_zeroes(child, offset, bytes, flags);
-        if (ret < 0) {
-            return ret;
-        }
-        offset +=3D bytes;
-    }
-}
-
-int bdrv_preadv(BdrvChild *child, int64_t offset, QEMUIOVector *qiov)
-{
-    int ret;
-
-    ret =3D bdrv_prwv_co(child, offset, qiov, false, 0);
-    if (ret < 0) {
-        return ret;
-    }
-
-    return qiov->size;
-}
-
-/* See bdrv_pwrite() for the return codes */
-int bdrv_pread(BdrvChild *child, int64_t offset, void *buf, int bytes)
-{
-    QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
-
-    if (bytes < 0) {
-        return -EINVAL;
-    }
-
-    return bdrv_preadv(child, offset, &qiov);
-}
-
-int bdrv_pwritev(BdrvChild *child, int64_t offset, QEMUIOVector *qiov)
-{
-    int ret;
-
-    ret =3D bdrv_prwv_co(child, offset, qiov, true, 0);
-    if (ret < 0) {
-        return ret;
-    }
-
-    return qiov->size;
-}
-
-/* Return no. of bytes on success or < 0 on error. Important errors are:
-  -EIO         generic I/O error (may happen for all errors)
-  -ENOMEDIUM   No media inserted.
-  -EINVAL      Invalid offset or number of bytes
-  -EACCES      Trying to write a read-only device
-*/
-int bdrv_pwrite(BdrvChild *child, int64_t offset, const void *buf, int byt=
es)
-{
-    QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
-
-    if (bytes < 0) {
-        return -EINVAL;
-    }
-
-    return bdrv_pwritev(child, offset, &qiov);
-}
-
-/*
- * Writes to the file and ensures that no writes are reordered across this
- * request (acts as a barrier)
- *
- * Returns 0 on success, -errno in error cases.
- */
-int bdrv_pwrite_sync(BdrvChild *child, int64_t offset,
-                     const void *buf, int count)
-{
-    int ret;
-
-    ret =3D bdrv_pwrite(child, offset, buf, count);
-    if (ret < 0) {
-        return ret;
-    }
-
-    ret =3D bdrv_flush(child->bs);
-    if (ret < 0) {
-        return ret;
-    }
-
-    return 0;
-}
-
 typedef struct CoroutineIOCompletion {
     Coroutine *coroutine;
     int ret;
@@ -2185,6 +2005,187 @@ int coroutine_fn bdrv_co_pwrite_zeroes(BdrvChild *c=
hild, int64_t offset,
                            BDRV_REQ_ZERO_WRITE | flags);
 }
=20
+typedef struct RwCo {
+    BdrvChild *child;
+    int64_t offset;
+    QEMUIOVector *qiov;
+    bool is_write;
+    int ret;
+    BdrvRequestFlags flags;
+} RwCo;
+
+static void coroutine_fn bdrv_rw_co_entry(void *opaque)
+{
+    RwCo *rwco =3D opaque;
+
+    if (!rwco->is_write) {
+        rwco->ret =3D bdrv_co_preadv(rwco->child, rwco->offset,
+                                   rwco->qiov->size, rwco->qiov,
+                                   rwco->flags);
+    } else {
+        rwco->ret =3D bdrv_co_pwritev(rwco->child, rwco->offset,
+                                    rwco->qiov->size, rwco->qiov,
+                                    rwco->flags);
+    }
+    aio_wait_kick();
+}
+
+/*
+ * Process a vectored synchronous request using coroutines
+ */
+static int bdrv_prwv_co(BdrvChild *child, int64_t offset,
+                        QEMUIOVector *qiov, bool is_write,
+                        BdrvRequestFlags flags)
+{
+    Coroutine *co;
+    RwCo rwco =3D {
+        .child =3D child,
+        .offset =3D offset,
+        .qiov =3D qiov,
+        .is_write =3D is_write,
+        .ret =3D NOT_DONE,
+        .flags =3D flags,
+    };
+
+    if (qemu_in_coroutine()) {
+        /* Fast-path if already in coroutine context */
+        bdrv_rw_co_entry(&rwco);
+    } else {
+        co =3D qemu_coroutine_create(bdrv_rw_co_entry, &rwco);
+        bdrv_coroutine_enter(child->bs, co);
+        BDRV_POLL_WHILE(child->bs, rwco.ret =3D=3D NOT_DONE);
+    }
+    return rwco.ret;
+}
+
+int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
+                       int bytes, BdrvRequestFlags flags)
+{
+    QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(qiov, NULL, bytes);
+
+    return bdrv_prwv_co(child, offset, &qiov, true,
+                        BDRV_REQ_ZERO_WRITE | flags);
+}
+
+/* See bdrv_pwrite() for the return codes */
+int bdrv_pread(BdrvChild *child, int64_t offset, void *buf, int bytes)
+{
+    QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
+
+    if (bytes < 0) {
+        return -EINVAL;
+    }
+
+    return bdrv_preadv(child, offset, &qiov);
+}
+
+int bdrv_pwritev(BdrvChild *child, int64_t offset, QEMUIOVector *qiov)
+{
+    int ret;
+
+    ret =3D bdrv_prwv_co(child, offset, qiov, true, 0);
+    if (ret < 0) {
+        return ret;
+    }
+
+    return qiov->size;
+}
+
+/*
+ * Return no. of bytes on success or < 0 on error. Important errors are:
+ * -EIO         generic I/O error (may happen for all errors)
+ * -ENOMEDIUM   No media inserted.
+ * -EINVAL      Invalid offset or number of bytes
+ * -EACCES      Trying to write a read-only device
+ */
+int bdrv_pwrite(BdrvChild *child, int64_t offset, const void *buf, int byt=
es)
+{
+    QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
+
+    if (bytes < 0) {
+        return -EINVAL;
+    }
+
+    return bdrv_pwritev(child, offset, &qiov);
+}
+
+/*
+ * Writes to the file and ensures that no writes are reordered across this
+ * request (acts as a barrier)
+ *
+ * Returns 0 on success, -errno in error cases.
+ */
+int bdrv_pwrite_sync(BdrvChild *child, int64_t offset,
+                     const void *buf, int count)
+{
+    int ret;
+
+    ret =3D bdrv_pwrite(child, offset, buf, count);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret =3D bdrv_flush(child->bs);
+    if (ret < 0) {
+        return ret;
+    }
+
+    return 0;
+}
+
+/*
+ * Completely zero out a block device with the help of bdrv_pwrite_zeroes.
+ * The operation is sped up by checking the block status and only writing
+ * zeroes to the device if they currently do not return zeroes. Optional
+ * flags are passed through to bdrv_pwrite_zeroes (e.g. BDRV_REQ_MAY_UNMAP=
,
+ * BDRV_REQ_FUA).
+ *
+ * Returns < 0 on error, 0 on success. For error codes see bdrv_write().
+ */
+int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags)
+{
+    int ret;
+    int64_t target_size, bytes, offset =3D 0;
+    BlockDriverState *bs =3D child->bs;
+
+    target_size =3D bdrv_getlength(bs);
+    if (target_size < 0) {
+        return target_size;
+    }
+
+    for (;;) {
+        bytes =3D MIN(target_size - offset, BDRV_REQUEST_MAX_BYTES);
+        if (bytes <=3D 0) {
+            return 0;
+        }
+        ret =3D bdrv_block_status(bs, offset, bytes, &bytes, NULL, NULL);
+        if (ret < 0) {
+            return ret;
+        }
+        if (ret & BDRV_BLOCK_ZERO) {
+            offset +=3D bytes;
+            continue;
+        }
+        ret =3D bdrv_pwrite_zeroes(child, offset, bytes, flags);
+        if (ret < 0) {
+            return ret;
+        }
+        offset +=3D bytes;
+    }
+}
+
+int bdrv_preadv(BdrvChild *child, int64_t offset, QEMUIOVector *qiov)
+{
+    int ret;
+
+    ret =3D bdrv_prwv_co(child, offset, qiov, false, 0);
+    if (ret < 0) {
+        return ret;
+    }
+
+    return qiov->size;
+}
+
 /*
  * Flush ALL BDSes regardless of if they are reachable via a BlkBackend or=
 not.
  */
--=20
2.21.0


