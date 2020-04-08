Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AC7C2BA2B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 09:35:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70F5F2051A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 09:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SKL9395a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70F5F2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM76s-0002Ak-PW
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 05:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39597)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jM73L-0007rX-SO
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 05:31:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jM73J-00060d-Q8
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 05:31:23 -0400
Received: from mail-ve1eur01on0705.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::705]:64128
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jM73B-0005tu-T1; Wed, 08 Apr 2020 05:31:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/lGPPLzoeWjJ5P8W8agZ0JiNumSMYiNqZpCFbJuFRqkFAB3BEHx5zqs3SOoG7plKvj9wTN8Cc0LoKjsY4kguU54i8sUn/wDVEhp7TUSud79vLdJKgiD10XC4PCqoju8jDbOjOdEMAns08lNwQdXAYIdkU0lDb0ABd21SGkDvgGomyvADCkgf3OGNMEMJriD+b06dxoLjQbMvOJ7RUk+BBmgbiwfMhdn7noC30h039hV03MTgadgAy2UoYCLNQQtgEtVTvPI8AOL0IJ2gZ9QnExch+FPtN95qFcW0SjjJBE59ebJNpIBdCeCQyADFYsRu8dFnksj0SdVI/TgpY1ZmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrAH8EEhLtVHUQRBFGNVfpBItKpUZosAMQDUUy1jX+c=;
 b=MwRTfJEa7WqYyqqjQdywQgEZwhlcv4coqQtcdoF1rIoznfDKfcfg7khVevkZbGBJsL4ZXpssG5AAWRBG2CroTSjEn701yNAQOw2/DCIEqYWR1Y9QV3j9ZLTc7rw+u9DIjzPLP4rYhvMfN7lWvtNZK0WkqB+RkvUSnj8geZjZejsihbw0gM0PNdqqi8hb7rT8hrWWKE99R+vBEC39Qd3vH8sYMboHwKmPARsZsKdTJaNRtSLTzS4oEOkW+GspA3/ukt2/t7+4QlIGrhYVeJbu7rEm0rSMXrQD68ZlBQHc0cM8rygMZqeNDXflFOmKy5q5KuETM3LxsmBjNWD5rtfEFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrAH8EEhLtVHUQRBFGNVfpBItKpUZosAMQDUUy1jX+c=;
 b=SKL9395ac+OG0A/MeuxHtvlWFpMc8iduXleD3Bnu3w/aHXL7ONQB4ayoNC/fOTZ+W7n1nEDm3dKWgoyFigDVgNN+bgIN7B2Ofgw2zR0APyFWbd2+RZf/RqhWb6hr8FQsg0gkt9KTT9ol68y0ObyZnBRWdtM9qzf66D3dFv47rew=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5365.eurprd08.prod.outlook.com (10.141.173.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.16; Wed, 8 Apr 2020 09:31:09 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.021; Wed, 8 Apr 2020
 09:31:09 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 3/9] block/io: move flush and pdiscard stuff down
Date: Wed,  8 Apr 2020 12:30:45 +0300
Message-ID: <20200408093051.9893-4-vsementsov@virtuozzo.com>
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
 Transport; Wed, 8 Apr 2020 09:31:08 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.139]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cce24c8-2224-4130-05a7-08d7db9f91e9
X-MS-TrafficTypeDiagnostic: AM7PR08MB5365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53656E82E974D760D8BE120EC1C00@AM7PR08MB5365.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:248;
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
X-Microsoft-Antispam-Message-Info: WqgJfMEQ7HSMbe6Ua1jAosCl2mb3M9VMtWOsnsbpzwEC76wZy2edSZUWzZ1Vhc6BihPIux7fd4JNHodIrlHr+Cnh0ud3p/DL1UFDHHz+T92x3SH7p4xkzdNDmfhHz6blhT/hnXhksoWbvqdDbW/DxsUoHLKPx27iU1nz1cN4FOUnA40tgrj9HOx54eRMTB3/iLQ+NN4h1feDjgf326rA/bDF4qKwo7g8mly6YLyBX4yoaPVYVOHwsyW/oC7zr+b/R4DJlc1S0FkUIRN5d9m8yyocRe+Hp+19vScX1bjS+EmPaRx3z3qW4uGUWN2T2Et4uyDa1uNTJcOlYni7UsWuUlOlBq7UouAAyNhGIOyIH2fRCis00edLxEYR4g8o4pxXmFRiOT2bmzF7uikAaAjOtC5wg7rAPvnAlzWZeaGilhPuNyY+UjJgdVR5mU/+HTpM
X-MS-Exchange-AntiSpam-MessageData: EHikI95LdSzDvcZtYxXkCh5VvgL+ptzf9dutaTf8C/su7uUbIweTQdvGuZ1iRHR89mKZwZyvt2doUnFzOrYGxAmTU+KCHDrYHAbORF/7vyJeYIwaKUDWKw9lOhePjI664OpFB5HQWi1FUb9sGEmVEg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cce24c8-2224-4130-05a7-08d7db9f91e9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2020 09:31:09.1819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a457FYzwJ6wVHwZ5+yBdH0ULoJrUUmRPztS8oHTqEydFj2ha2AcdjJnov1eT362sCAD38VuAO6JISduBwSUZjS/fau4ztnCtJtQIaAbGf6w=
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

bdrv_co_flush and bdrv_co_pdiscard will become static in further patch,
move their usage down.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c | 56 +++++++++++++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/block/io.c b/block/io.c
index 29e53271b6..379e86eeb5 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2828,20 +2828,6 @@ void bdrv_aio_cancel_async(BlockAIOCB *acb)
 /**************************************************************/
 /* Coroutine block device emulation */
=20
-typedef struct FlushCo {
-    BlockDriverState *bs;
-    int ret;
-} FlushCo;
-
-
-static void coroutine_fn bdrv_flush_co_entry(void *opaque)
-{
-    FlushCo *rwco =3D opaque;
-
-    rwco->ret =3D bdrv_co_flush(rwco->bs);
-    aio_wait_kick();
-}
-
 int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
 {
     int current_gen;
@@ -2954,6 +2940,19 @@ early_exit:
     return ret;
 }
=20
+typedef struct FlushCo {
+    BlockDriverState *bs;
+    int ret;
+} FlushCo;
+
+static void coroutine_fn bdrv_flush_co_entry(void *opaque)
+{
+    FlushCo *rwco =3D opaque;
+
+    rwco->ret =3D bdrv_co_flush(rwco->bs);
+    aio_wait_kick();
+}
+
 int bdrv_flush(BlockDriverState *bs)
 {
     Coroutine *co;
@@ -2974,20 +2973,6 @@ int bdrv_flush(BlockDriverState *bs)
     return flush_co.ret;
 }
=20
-typedef struct DiscardCo {
-    BdrvChild *child;
-    int64_t offset;
-    int64_t bytes;
-    int ret;
-} DiscardCo;
-static void coroutine_fn bdrv_pdiscard_co_entry(void *opaque)
-{
-    DiscardCo *rwco =3D opaque;
-
-    rwco->ret =3D bdrv_co_pdiscard(rwco->child, rwco->offset, rwco->bytes)=
;
-    aio_wait_kick();
-}
-
 int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset,
                                   int64_t bytes)
 {
@@ -3102,6 +3087,21 @@ out:
     return ret;
 }
=20
+typedef struct DiscardCo {
+    BdrvChild *child;
+    int64_t offset;
+    int64_t bytes;
+    int ret;
+} DiscardCo;
+
+static void coroutine_fn bdrv_pdiscard_co_entry(void *opaque)
+{
+    DiscardCo *rwco =3D opaque;
+
+    rwco->ret =3D bdrv_co_pdiscard(rwco->child, rwco->offset, rwco->bytes)=
;
+    aio_wait_kick();
+}
+
 int bdrv_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes)
 {
     Coroutine *co;
--=20
2.21.0


