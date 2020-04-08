Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7A6C2BA1A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 09:33:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46A76206F5
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 09:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UEqW3CIP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46A76206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM75l-0001EZ-A2
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 05:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jM73G-0007kG-EX
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 05:31:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jM73E-0005xG-P7
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 05:31:18 -0400
Received: from mail-ve1eur01on0705.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::705]:64128
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jM739-0005tu-Qz; Wed, 08 Apr 2020 05:31:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5Nxpv6Q+iCNN4Z71llxLJv2zMeWU5jLpj3cV8OfTV5CRxLIryd5Gm69h1T0aAUPzebto+QQ5aofNMJFZ+76HEyiUh7zSZuxyyCA8tDpO4svu3SFYJSPgT7CYpHXDeJeyMhU4+QL1pH/aq7AMUY1eu4HrkfIh9Qr6gQp198pSMmcpzEqsDv03hQdHOi2Uhup2sCcfRAcb1zP2Ca51/6oXAJcruqM173b0M88Rj9ShkXGRM5T6zDN0vCPKkbf5628QjSPvdmMAltcmOt8IceXLu7FjZbiARgMvc737MecSZk/F4rHT59MbY/Z31DXFKGNrA2JELKSaFCUSyIPTMykyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xRroGXi48EF1CjEFO5AZmDXmUHSxujtVJh2Wh8ot/M=;
 b=mRKpj66utrXf85odtdR7qER2Ru4vMhrX/geS9tZ947jeziVZy+wkEK1gnQUDZb+MDwjqdpTYMu1Fk0/jYE/GKq1M0j6dCHqQN02EyJtD5UtL7h12b5C/mzp/+pWMN8avLjdUIuPavparAikCJMwh+GVAt0lywB4yMZnpnQb4GHktUoBxjs5lxSSudtgXnBhYSDlB1ddWE5N7/51tYFunT5n/9zEpYaN3ivRCbedKYu7mpgFQY2rxg2qsWaqNRJJ8B1roWBLIBotp7QIjaRM1vvyt8O10S+UZAo2lLsedrRO6KMsZc6Ktpj1VKu9mGlUqUqlVNZBQ+/vXe1KJcvVWjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xRroGXi48EF1CjEFO5AZmDXmUHSxujtVJh2Wh8ot/M=;
 b=UEqW3CIPqUNW2ULNY2q5hnw86XuYgjX2G7UTwJ17r22s9hn4Jd56ln0N8bbpZ8IYVbq+QNC0/fBwogTrO0HZQD9WjwUaALjEEIE/P048R8CECK6d6/NC6MpLLCkPBLiIQ6rC3ZzPyWCmKhXkZxhLXWGXN/nBOWpBnYMFYNsuwoQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5365.eurprd08.prod.outlook.com (10.141.173.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.16; Wed, 8 Apr 2020 09:31:07 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.021; Wed, 8 Apr 2020
 09:31:07 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 1/9] block/io: refactor bdrv_is_allocated_above to run only
 one coroutine
Date: Wed,  8 Apr 2020 12:30:43 +0300
Message-ID: <20200408093051.9893-2-vsementsov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: b1f80073-1ac4-44c7-344a-08d7db9f90fa
X-MS-TrafficTypeDiagnostic: AM7PR08MB5365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5365E2D0881169332316783FC1C00@AM7PR08MB5365.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
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
X-Microsoft-Antispam-Message-Info: YnxsP9Q0ptnNvwx0DTGzP5cQ125DvjFTaMvZsjzOY3WNyIGMUcG3XHx2y/g95ZTSxaMFpuO+GmSfO2ShZ3BG0SriBGzjvi4GZBGwFcR2vexk9SConyUlq0AlWDG3WsyUUqpyKrqO1yrq+19JKLrQY6qyugCXSbrxSQ7N2oasDEWXF+SjsYMSNI0vkEybJs4JMYiSq8aJ+x14XiCq7YTBEOR7QQiDGGRXCjMWxxIStw7tSsU+ky8RbdUFRzaLGu+w2uwLLkcxB9c31Q7Ufq0RF54zWwuPr83BQsQVsqWSJG81YDlLkR6vl7weOCQhypa3pqkLOYphcWGpP1McEWhPXHNQrnTuB25oC5U3e3lUvAR8UWPYrG2Lq1EdoamkEAlcb5jOVg+Zek5J+PCSZfATeyMY145dY7JIFBJ6iSXMuLeRxJDw8dj6jtBIkzrazFoH
X-MS-Exchange-AntiSpam-MessageData: MGRbPfAKRhloLtRw3xm6mo4UgiFJq/t1ksyKbuxMoncdz+oAi5tE3Tvl42bD7QxaRU0WPudBibG4L3Qaw2eW+PO75BILOZeIvJUUaQEQUkAz/xCSDg7rTxBbGOsjl90dLtfAbSc4j9SSiovtriqtgQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f80073-1ac4-44c7-344a-08d7db9f90fa
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2020 09:31:07.6805 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EBJQH6WbRohbbHdh9ZfTfg1G72g05zKZ0UQQgnwF6dp4Sbix5Wcelw52v3gmFjY+e66aoNlhBGWp4TgXpr7sAb44iDgcYGK2os/wYcbjPF8=
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

bdrv_is_allocated_above creates new coroutine on each iteration if
called from non-coroutine context. To simplify expansion of in_flight
inc/dec sections in further patch let's refactor it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 72 insertions(+), 5 deletions(-)

diff --git a/block/io.c b/block/io.c
index aba67f66b9..a9f1a3e93e 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2482,6 +2482,22 @@ static int coroutine_fn bdrv_co_block_status_above(B=
lockDriverState *bs,
     return ret;
 }
=20
+static int coroutine_fn bdrv_co_is_allocated(BlockDriverState *bs,
+                                             int64_t offset, int64_t bytes=
,
+                                             int64_t *pnum)
+{
+    int ret;
+    int64_t dummy;
+
+    ret =3D bdrv_co_block_status_above(bs, backing_bs(bs), false, offset,
+                                     bytes, pnum ? pnum : &dummy, NULL,
+                                     NULL);
+    if (ret < 0) {
+        return ret;
+    }
+    return !!(ret & BDRV_BLOCK_ALLOCATED);
+}
+
 /* Coroutine wrapper for bdrv_block_status_above() */
 static void coroutine_fn bdrv_block_status_above_co_entry(void *opaque)
 {
@@ -2578,10 +2594,10 @@ int coroutine_fn bdrv_is_allocated(BlockDriverState=
 *bs, int64_t offset,
  * but 'pnum' will only be 0 when end of file is reached.
  *
  */
-int bdrv_is_allocated_above(BlockDriverState *top,
-                            BlockDriverState *base,
-                            bool include_base, int64_t offset,
-                            int64_t bytes, int64_t *pnum)
+static int coroutine_fn
+bdrv_co_is_allocated_above(BlockDriverState *top, BlockDriverState *base,
+                           bool include_base, int64_t offset, int64_t byte=
s,
+                           int64_t *pnum)
 {
     BlockDriverState *intermediate;
     int ret;
@@ -2595,7 +2611,7 @@ int bdrv_is_allocated_above(BlockDriverState *top,
         int64_t size_inter;
=20
         assert(intermediate);
-        ret =3D bdrv_is_allocated(intermediate, offset, bytes, &pnum_inter=
);
+        ret =3D bdrv_co_is_allocated(intermediate, offset, bytes, &pnum_in=
ter);
         if (ret < 0) {
             return ret;
         }
@@ -2624,6 +2640,57 @@ int bdrv_is_allocated_above(BlockDriverState *top,
     return 0;
 }
=20
+typedef struct BdrvCoIsAllocatedAboveData {
+    BlockDriverState *top;
+    BlockDriverState *base;
+    bool include_base;
+    int64_t offset;
+    int64_t bytes;
+    int64_t *pnum;
+    int ret;
+    bool done;
+} BdrvCoIsAllocatedAboveData;
+
+static void coroutine_fn bdrv_is_allocated_above_co_entry(void *opaque)
+{
+    BdrvCoIsAllocatedAboveData *data =3D opaque;
+
+    data->ret =3D bdrv_co_is_allocated_above(data->top, data->base,
+                                           data->include_base,
+                                           data->offset, data->bytes,
+                                           data->pnum);
+    data->done =3D true;
+    aio_wait_kick();
+}
+
+int coroutine_fn
+bdrv_is_allocated_above(BlockDriverState *top, BlockDriverState *base,
+                        bool include_base, int64_t offset, int64_t bytes,
+                        int64_t *pnum)
+{
+    Coroutine *co;
+    BdrvCoIsAllocatedAboveData data =3D {
+        .top =3D top,
+        .base =3D base,
+        .include_base =3D include_base,
+        .offset =3D offset,
+        .bytes =3D bytes,
+        .pnum =3D pnum,
+        .done =3D false,
+    };
+
+    if (qemu_in_coroutine()) {
+        /* Fast-path if already in coroutine context */
+        bdrv_is_allocated_above_co_entry(&data);
+    } else {
+        co =3D qemu_coroutine_create(bdrv_is_allocated_above_co_entry, &da=
ta);
+        bdrv_coroutine_enter(top, co);
+        BDRV_POLL_WHILE(top, !data.done);
+    }
+
+    return data.ret;
+}
+
 typedef struct BdrvVmstateCo {
     BlockDriverState    *bs;
     QEMUIOVector        *qiov;
--=20
2.21.0


