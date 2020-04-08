Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D770C2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 09:38:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6709A2051A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 09:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="URRDv+g9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6709A2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM7A4-000719-Jp
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 05:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jM73J-0007nK-LO
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 05:31:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jM73I-0005zX-Ki
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 05:31:21 -0400
Received: from mail-ve1eur01on0705.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::705]:64128
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jM73F-0005tu-Gz; Wed, 08 Apr 2020 05:31:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzP7OEDT68wXyQpCcCXxh3qwvRwF3EErjY+vLkwyGbxOAXlefjqtozvYX8jXLu0mLVYy3o3fEz99YQZu16qJYH3Ji4N39BL8FiyQwnMqiXNt4YTVtN+o2R+5PYhx/wf+Smi+m5qm0zDgUp47bGCUvJ+Z63d+LA/tSkJF9mUA52foz4xHKT5BW+OfLfuApdWIARmVWNhOnUdNwHJU2X4R6W5gJnun/MWzFgP/TR5lNNFsbb5nb6M1IYB/o1/4/3zx5gjQdSkuWyxOKIxKPbNoC+s1ooDeaQylytG/aqjV7Qw+Upn80kyyqu0NftMvaWcXf7sJB7KPrpSVqUHOSvnW3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYinioNaMeufgX2ki6tcSyOUPiJ1eHXtHyHcL+Oq8Yo=;
 b=N3hB46fEXadS6zhD7mwDND4adEqNZj46fYh2d/ZDuZTjNqeaJU3t1cncvrKzJGIxA1OwcFlO8jRf3d3w+DyNAQpBqD1A3bFyGoZLiN7bXk2GNBDwgiBbLTWjcl5CFrZYU+NjCK25+U6GYdW0Jb2ijKRrut/Dzl1IbU0MZW7IAyES3+MlepdG8forejm4NzO9hAT52G0jKd5r8PdvpLnNsQbdUbTAVGB7hBG3Nci0T1YCfh1Ybo8ZgUUWVbSu1Zq8ivR61BsTXeA36VdavaiSiG7xHLq349Xftp2qjh9ksTT5eRJ1JRrYh/o3SvKJYYf2csv6J9XXMC865giIUAQQQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYinioNaMeufgX2ki6tcSyOUPiJ1eHXtHyHcL+Oq8Yo=;
 b=URRDv+g9qPHIVIvjeRpCs6rriduc0BACnsutU3U25lrjp1MsxLCUxwUOt3DY2BdIkIc6RJ8+VUC/APQpq3FdVZHwvnouIjvn6SkeTeyuGiKbAAQ/Q6Yah+FbwYCV3PJqQnTf+p5jNXMgFaZJlnPjnCq1nwr79QmbxlI/eruM9uU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5365.eurprd08.prod.outlook.com (10.141.173.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.16; Wed, 8 Apr 2020 09:31:12 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.021; Wed, 8 Apr 2020
 09:31:12 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 7/9] block/io: add bdrv_do_pwrite_zeroes
Date: Wed,  8 Apr 2020 12:30:49 +0300
Message-ID: <20200408093051.9893-8-vsementsov@virtuozzo.com>
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
 Transport; Wed, 8 Apr 2020 09:31:11 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.139]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1548b69-30a3-4ed6-231c-08d7db9f93b9
X-MS-TrafficTypeDiagnostic: AM7PR08MB5365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB536574491B3937D4E81403AFC1C00@AM7PR08MB5365.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
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
X-Microsoft-Antispam-Message-Info: oyTQiQRTEhATKC7WRoTqCTQgkCfGtQFc45XFH4fAKL8z5XPBIgqkGboGfDEmiTkIl7oUWsbVlnoBPPxJwEyAqgthtmRRH7fkRw27ddwckn9ThhWz+Cc65TF3tPVHcfhVyq/d500dhHCJZu5NQfI5ox+3G4rZYJdaEKI5W1TigfBsoxx28shgR6l4A6SZM6gPaO9rck8nx7N151ptHBpR3npjRlN8KEXVaNQ8QJgUdgZA2C3pGBDNsVC46RoHjSBsZ2CWI6iQAK262cwHZsT/uDwcY1e6EnIDWx6kgVkkn4v4bAjlr6lWUm52VhEVacr7Hs7Ob8HjIzXd8jNoWzuhvxU//jRPFXekFZUzRVql1UIpyNsijW5ytAnoILn0JFH0jTpnE7h0FcJ+Z0OM+mbBm1IKOZ5dODD/nZgOe0qgtw2hMRFSwl5G+BqXgkj714kN
X-MS-Exchange-AntiSpam-MessageData: jg3j9F6tBIyusp9HCDi+Sg3UCugAlm7szIISeozlkk3TNp8YUQpSymx8awkTAquDhQOWvRJRYHoMm3Or7luKYU8KApfRXv49w1cU+oFkNeb9xiYDogUNymnGzWx1YIg5t1uiGjs64oxu+U2bC/F7uQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1548b69-30a3-4ed6-231c-08d7db9f93b9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2020 09:31:12.2245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m3BWYnvm0JKNi8MiLTVdQ2R+h0MYuVNxoPViz5qOzSb2APl2M9LyyHl1MTMwtiGrJeGFXf/4WwrrBUWs0kNLujYPbcF/aTXVWk972Lnam7w=
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

We'll need a bdrv_co_pwrite_zeroes version without inc/dec in_flight to
be used in further implementation of bdrv_make_zero.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/block/io.c b/block/io.c
index 760170731f..b1fc8b2367 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2016,8 +2016,10 @@ int coroutine_fn bdrv_co_pwritev_part(BdrvChild *chi=
ld,
     return ret;
 }
=20
-int coroutine_fn bdrv_co_pwrite_zeroes(BdrvChild *child, int64_t offset,
-                                       int bytes, BdrvRequestFlags flags)
+/* To be called between exactly one pair of bdrv_inc/dec_in_flight() */
+static int coroutine_fn
+bdrv_do_pwrite_zeroes(BdrvChild *child, int64_t offset, int bytes,
+                      BdrvRequestFlags flags)
 {
     trace_bdrv_co_pwrite_zeroes(child->bs, offset, bytes, flags);
=20
@@ -2025,8 +2027,21 @@ int coroutine_fn bdrv_co_pwrite_zeroes(BdrvChild *ch=
ild, int64_t offset,
         flags &=3D ~BDRV_REQ_MAY_UNMAP;
     }
=20
-    return bdrv_co_pwritev(child, offset, bytes, NULL,
-                           BDRV_REQ_ZERO_WRITE | flags);
+    return bdrv_do_pwritev_part(child, offset, bytes, NULL, 0,
+                                BDRV_REQ_ZERO_WRITE | flags);
+}
+
+int coroutine_fn
+bdrv_co_pwrite_zeroes(BdrvChild *child, int64_t offset, int bytes,
+                      BdrvRequestFlags flags)
+{
+    int ret;
+
+    bdrv_inc_in_flight(child->bs);
+    ret =3D bdrv_do_pwrite_zeroes(child, offset, bytes, flags);
+    bdrv_dec_in_flight(child->bs);
+
+    return ret;
 }
=20
 typedef struct RwCo {
--=20
2.21.0


