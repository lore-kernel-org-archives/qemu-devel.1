Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0433C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:26:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B93BB20714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="wp4wxLYw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B93BB20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEE7I-0008WM-QZ
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 11:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jEDxm-0002re-Jd
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:17:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jEDxl-0001kH-7J
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:17:02 -0400
Received: from mail-he1eur04on071f.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::71f]:1794
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jEDxk-0001d5-VG; Tue, 17 Mar 2020 11:17:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1JMRf8NFSt7038EyJXk5e5oYRrsQwn+XdpnYD/VUcePoqSJsgLpPDYvhh5p06NPGFaCRp6TH8Lvxby0B4UGlfqHHe8iNNSX0XgYUdrXEbs4tQJ3ZLJZIOzFEcQHeK8rGo9neNjDE0ygagx/OrgfRHBC9PnGO6lshzsqRffk7QO2i8mlvfluQvgWp9Muh1nJKooFxD40p8p2mGL0UqGfF3JznRAdcfDThmBWJeUL4ZJncTkZ2rXfhnlW0ezv/ExahiOK3OxU4yt5cQKCmCuRz68d50bn3z4d8ALO6QOzcgGmMcNfziTGJr+07MtazJiCgPIasV/J+FI28FXGJyNHUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7w+twQDNLE1kCUVOa9jGf4f3ophG/9OvFgfLmC2doU=;
 b=U90v9vAlDWH14JB5ryOMonfuiaWTl3UKHnp78DbQgwbsioUMt8X/pZQyluwtokh8jTGJqQ2QD7yhIYda7nC39o9Aw+SxGTtE1fDWdaeit483ygYavGXkWIKgAbzp50ICm1xg6wAMM1NlUOqP9OAsOqZdUNcHmrmLsGVyE0/3tf9toKgb1Kt/UdvkVTvRbrj3pNjO4er6OJxWGUrzn44kpxa2tEKiKUx7R+VLxNefh+Z4DU217jFTTI9y8qvTPFO/yBnP+iasP7uW+FaxDvR52oGYgXYus/sKyAQbMZSSi2knZBTzlMuBvmGsNbmS83xIE12UpHIqjd5mD6TXft5qSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7w+twQDNLE1kCUVOa9jGf4f3ophG/9OvFgfLmC2doU=;
 b=wp4wxLYwEzEirBSghWwMOrxhtTGRYhNaqno1O9VRfaMkHAwhl0lmYwwUTTG5eAp5PGKfP7AYvfAaah0I8gfskxziXoGutqxZ4MHMwR3wWJ1LpoNY8uDD2UoAq9WugmW+AeofE6tfwliBDzvfG1M7TDm9wh9GgGtzJHmN0qommwQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com (10.175.35.136) by
 HE1PR0802MB2620.eurprd08.prod.outlook.com (10.175.36.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.21; Tue, 17 Mar 2020 15:16:59 +0000
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f]) by HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f%12]) with mapi id 15.20.2814.021; Tue, 17 Mar
 2020 15:16:59 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 4/9] pflash: introduce ERRP_AUTO_PROPAGATE
Date: Tue, 17 Mar 2020 18:16:20 +0300
Message-ID: <20200317151625.20797-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200317151625.20797-1-vsementsov@virtuozzo.com>
References: <20200317151625.20797-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR10CA0005.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::15) To HE1PR0802MB2507.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.248) by
 AM0PR10CA0005.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15 via Frontend
 Transport; Tue, 17 Mar 2020 15:16:58 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.248]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43f7b024-b8cb-4a32-edff-08d7ca863ca5
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2620:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB26206518091F7ECDF6DCA12FC1F60@HE1PR0802MB2620.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(39850400004)(376002)(136003)(346002)(366004)(396003)(199004)(66946007)(6666004)(1076003)(66556008)(54906003)(66476007)(86362001)(6486002)(16526019)(5660300002)(6916009)(186003)(6506007)(52116002)(4326008)(81166006)(6512007)(81156014)(8676002)(8936002)(316002)(2906002)(26005)(478600001)(956004)(36756003)(2616005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:HE1PR0802MB2620;
 H:HE1PR0802MB2507.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nzA1i5VcnBCWQhgWSupf6GPew9O/SZB36dp+pk0r3QIwVgQTu72Cp2J6ENVKQTjc3d8LclQUBd8wF7Zi8pToJC+Kyavq69CYrK8bfJ7ehlLqfqdJ+V1qmlzZbXFXz5nBkBTOFNb4nupc+49mfsAr6wHIiXsVaZiiVm7bTQvFAeEnAQWxlkmE77mZ7ORa05CJkqGH5+fX8h0S7+SfbfNHcRCoOHLpULQWmQLjBaAvbmYPJg6i8oIi7AvRIY7eTKlDIrGXtFmdm+EjAVLwXqKn+mp6x7Qs87Ac2v8Vc7hyXzeS56yfjWjzP4feXQXes0dkr3oY2XbE5kZ11yy5lD11mzBjImjpOww8s1HlkK0XUZn5LPKkGJfiWQHU6ksO8NgC6Z6bDZGlY5ooT7VIFjZSU+MiyWmE3oIge3PD4yD0IMmJHay9WAQUmiTcXspc+Otj
X-MS-Exchange-AntiSpam-MessageData: WhOdvjgKABR9MasFU29xcpppQkO3lloO8QETDbqxwnpnU4EkYo+x7InSWlBiF/EiuyiutPtTb5vxVO6+W/w31qMD2yJkFhP8hc17Kmp1oD5nYYDx/llEFup0bob45Qof8PN4l/6C1NB6ETX9sQIP9Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f7b024-b8cb-4a32-edff-08d7ca863ca5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 15:16:59.0988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bc7zw5l6oPlngZ0ir0v5lgQ+5/yFDW4yEGBa0Dt3Yxl1YKPJqBFBsiuIZ3bgdOTAk3zlohHGT0sWcqqdmzmQoXnwMiIaIN78n790egS/8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2620
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0d::71f
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, armbru@redhat.com, Max Reitz <mreitz@redhat.com>,
 Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If we want to add some info to errp (by error_prepend() or
error_append_hint()), we must use the ERRP_AUTO_PROPAGATE macro.
Otherwise, this info will not be added when errp =3D=3D &error_fatal
(the program will exit prior to the error_append_hint() or
error_prepend() call).  Fix such cases.

If we want to check error after errp-function call, we need to
introduce local_err and then propagate it to errp. Instead, use
ERRP_AUTO_PROPAGATE macro, benefits are:
1. No need of explicit error_propagate call
2. No need of explicit local_err variable: use errp directly
3. ERRP_AUTO_PROPAGATE leaves errp as is if it's not NULL or
   &error_fatal, this means that we don't break error_abort
   (we'll abort on error_set, not on error_propagate)

This commit is generated by command

    sed -n '/^Parallel NOR Flash devices$/,/^$/{s/^F: //p}' \
        MAINTAINERS | \
    xargs git ls-files | grep '\.[hc]$' | \
    xargs spatch \
        --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
        --macro-file scripts/cocci-macro-file.h \
        --in-place --no-show-diff --max-width 80

Reported-by: Kevin Wolf <kwolf@redhat.com>
Reported-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/pflash_cfi01.c | 7 +++----
 hw/block/pflash_cfi02.c | 7 +++----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 24f3bce7ef..a5755e6119 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -700,12 +700,12 @@ static const MemoryRegionOps pflash_cfi01_ops =3D {
=20
 static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     PFlashCFI01 *pfl =3D PFLASH_CFI01(dev);
     uint64_t total_len;
     int ret;
     uint64_t blocks_per_device, sector_len_per_device, device_len;
     int num_devices;
-    Error *local_err =3D NULL;
=20
     if (pfl->sector_len =3D=3D 0) {
         error_setg(errp, "attribute \"sector-length\" not specified or zer=
o.");
@@ -739,9 +739,8 @@ static void pflash_cfi01_realize(DeviceState *dev, Erro=
r **errp)
         &pfl->mem, OBJECT(dev),
         &pflash_cfi01_ops,
         pfl,
-        pfl->name, total_len, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+        pfl->name, total_len, errp);
+    if (*errp) {
         return;
     }
=20
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 12f18d401a..3da9f56391 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -718,9 +718,9 @@ static const MemoryRegionOps pflash_cfi02_ops =3D {
=20
 static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     PFlashCFI02 *pfl =3D PFLASH_CFI02(dev);
     int ret;
-    Error *local_err =3D NULL;
=20
     if (pfl->uniform_sector_len =3D=3D 0 && pfl->sector_len[0] =3D=3D 0) {
         error_setg(errp, "attribute \"sector-length\" not specified or zer=
o.");
@@ -786,9 +786,8 @@ static void pflash_cfi02_realize(DeviceState *dev, Erro=
r **errp)
=20
     memory_region_init_rom_device(&pfl->orig_mem, OBJECT(pfl),
                                   &pflash_cfi02_ops, pfl, pfl->name,
-                                  pfl->chip_len, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+                                  pfl->chip_len, errp);
+    if (*errp) {
         return;
     }
=20
--=20
2.21.0


