Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51766C2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 09:33:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17E2D206F5
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 09:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Hv9n/doA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E2D206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM75X-00015W-6y
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 05:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39463)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jM73G-0007kF-EP
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 05:31:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jM73E-0005x4-Oh
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 05:31:18 -0400
Received: from mail-ve1eur01on0705.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::705]:64128
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jM73B-0005tu-9j; Wed, 08 Apr 2020 05:31:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4ChCJ4+tmnM6TaC+XtL/oVleFlzSPslvOwMk8Z/FmBposX3LxF7zXV161ndmTb0I2PszSbakcVsb3T6zah3vA7OS/5SU8h4kzjK/cI38fZId9rqAtT6EKFQaEdu2rLKe4c+K4EhN9+mM3wX3426TO1nTQXBf1HKSuXuY+RDVqLZypJCd3N8D6wLhvG7ts2fDCxz2uup9mQqac3oCtF2ZgSKH5DMhuvvF58HCqB+0x/LFkvrljvzPSddPtzF/OL3Fq/Ui98PoTvdxeanogY1oimFtPfz73k4j9S7UYQ2TcOtjdehvmdPSJWJkIAZfuqTaxLYGPjrbTjsRlBl+fFZ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2vpKMkvqCGmyV0Ot0mi3MdQNqcNS7JwiUqCB9yJwJ0=;
 b=n15FjFTn43TpK1SU26xfi7v7CnkfUdRhIK0yLIvU5ncnuSAMxLeVQUxZaNOs1+OoIh3/WEHWlFIwfBOnnXHeNgYuB8lx/xgsJVfw8czFFfaoVEl87VdBQiUjjVOFcZenOILC3C2ERGlV9TGAwvBmncg/wXq8N4F5NodS/Gdfpv4NzaR+lShDnI0bNWDxgWlXN7ZUvJAzDuEI8Gm6zBbHCNu4hRBjzir2skiKEU6veJ3mTTlSrP0qlGzrjab0wHOuL+kQ0Z3LbSId/rFq2V5flPh+/dO4vPvGgV0guBjgO8Q//0jXjdUpSX327PJ+ByNjHDaaaIfiWD7xptczCJJPBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2vpKMkvqCGmyV0Ot0mi3MdQNqcNS7JwiUqCB9yJwJ0=;
 b=Hv9n/doAzrZLDte+yl4VasVi4H46Pj+WJAITVCHfO0XOmaJ3ad+kkWgGvWehon9B/BSgyCKej+xu1Z1BsW4yXIk/xRBzgfulqW7HYVplWVYZ1WjaQLmjv/QMbUrj0b8wUv05TcYAwPalJrWqh6vozXcszyCfGXPlFv3Rmf9Anpo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5365.eurprd08.prod.outlook.com (10.141.173.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.16; Wed, 8 Apr 2020 09:31:08 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.021; Wed, 8 Apr 2020
 09:31:08 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 2/9] block/io: refactor bdrv_co_ioctl: move aio stuff to
 corresponding block
Date: Wed,  8 Apr 2020 12:30:44 +0300
Message-ID: <20200408093051.9893-3-vsementsov@virtuozzo.com>
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
 Transport; Wed, 8 Apr 2020 09:31:07 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.139]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a34666be-72f8-4f32-c73f-08d7db9f9176
X-MS-TrafficTypeDiagnostic: AM7PR08MB5365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB536569AC5BD1883BFCA8F67CC1C00@AM7PR08MB5365.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
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
X-Microsoft-Antispam-Message-Info: fadoDl+H3cEAKQhyqczt87zWfMdykea82fYhyP0pHqr8SE5OF5k3E6rWSk8SzQRGAm+oHJKu/i/Q5NnAksCytCfgg/1rxrPFV7JwbXOVtn0j1AmKSOdLxqGxNLXoEgBTNN/4H/ObDgGPLlPOZmx1c8J6oYUhDStmVFfg2gTsFwutO/8I+qJugdsph27TO9b2efC5c30mGmfnc6eWQ/tO3TUqs51aasuTQmTOvzBQHus0O2AfixvLpiBDJRN9OJa2agGwZyWNToGk5kTQFlnTxF7mgOLZFNqiMZ/KsqBldbr6bdZ0HkTMkUroOxyjaZXW60BvsakPlSckUfFkR/hCXVa+ijkyhx3cwJkBWJ09tL7D4GwGHKTbnAGCT9kfe//6755HgBA1DTNV0ng2l1GxVD22lw4c+rn0s242bx5i7vPXyDq18uL+QwX7jr4rf0Y6
X-MS-Exchange-AntiSpam-MessageData: h1kkIpSOKnDLoEVDnQPw4whJwybr7erMk1I/6tV+rbkP8/PFlpbYGO0MX0rqe8YAVo+LSmPXZchHWjUCztmkORTAkQTshPCZSYpN8bH0iR4AQvLMOww90y7amfymcyQZC6yX/DU3R6jY/rwripCs8w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a34666be-72f8-4f32-c73f-08d7db9f9176
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2020 09:31:08.4581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VxTYnnky8e8e78DtcmbIvdcIuXLgqbnO8TqQYERraXWzPIMqnmvFjDZFodjUFdWaN0Z7ppYii9Fzaq1OUqk8M0Corp0wlK/Jfy2ypC3jhho=
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/block/io.c b/block/io.c
index a9f1a3e93e..29e53271b6 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3126,31 +3126,38 @@ int bdrv_pdiscard(BdrvChild *child, int64_t offset,=
 int64_t bytes)
=20
 int bdrv_co_ioctl(BlockDriverState *bs, int req, void *buf)
 {
+    int ret;
     BlockDriver *drv =3D bs->drv;
-    CoroutineIOCompletion co =3D {
-        .coroutine =3D qemu_coroutine_self(),
-    };
-    BlockAIOCB *acb;
=20
     bdrv_inc_in_flight(bs);
+
     if (!drv || (!drv->bdrv_aio_ioctl && !drv->bdrv_co_ioctl)) {
-        co.ret =3D -ENOTSUP;
+        ret =3D -ENOTSUP;
         goto out;
     }
=20
     if (drv->bdrv_co_ioctl) {
-        co.ret =3D drv->bdrv_co_ioctl(bs, req, buf);
+        ret =3D drv->bdrv_co_ioctl(bs, req, buf);
     } else {
+        CoroutineIOCompletion co =3D {
+            .coroutine =3D qemu_coroutine_self(),
+        };
+        BlockAIOCB *acb;
+
         acb =3D drv->bdrv_aio_ioctl(bs, req, buf, bdrv_co_io_em_complete, =
&co);
         if (!acb) {
-            co.ret =3D -ENOTSUP;
+            ret =3D -ENOTSUP;
             goto out;
         }
+
         qemu_coroutine_yield();
+        ret =3D co.ret;
     }
+
 out:
     bdrv_dec_in_flight(bs);
-    return co.ret;
+
+    return ret;
 }
=20
 void *qemu_blockalign(BlockDriverState *bs, size_t size)
--=20
2.21.0


