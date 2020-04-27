Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C936CC55199
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:26:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9796420661
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uD2RCjD+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9796420661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSz6F-00088X-MG
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 04:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jSz3d-0002Uj-6u
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:24:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jSz3c-0007iS-N2
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:24:04 -0400
Received: from mail-eopbgr70127.outbound.protection.outlook.com
 ([40.107.7.127]:7750 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jSz3a-0007bA-VE; Mon, 27 Apr 2020 04:24:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsHfCyVAprPJRfu3J/GhA6V1HYVeq7c9K4wRVA4uaMVpzK0M8L2aQkqTJis57XqhDaSmvIBlUxC2eK4FOcdZdekf837gBRF+9+EJt+L7rZy+oPOUy0uMXuCs2bLWDGCPZLp2Nvdb60Dhx9hiQUIX3k+WmvTsYHqGk+Wo7wU5EeAZIT8h2EHDvXka1qq8UgTjmLZknHlz+t7fvFeWcOAlr3P2V6qKJjsh6Tg7Mz54IhKtQtV7lHcRE+LUSA2rJWru+LtDxMkpW6Oqj0w3MeelbA58VuMOeMYF3vKRTZLJ0v0C4dQExWMB/LOR3DWvIfXn8WTskLAGxNmg3VYNQJRnYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMEqiVwxRfBqFh+w1IAw8dH8l7dISyve6Of3WjcX83g=;
 b=jyGofwNN6ok/luaZolDqWjAQW4xR0rrR3jwMunu1F3mx5kY1YPHCoGET04fDSlQZdgfc/vIuoY8WKn+ubkfZj10gC9glxVBSfyfc2S8sabCvpt+1eH2R3k7fjozs0mCbo/8jf2adkH1/XUSnBkFuUf4tfdGGL/YZ4NfddvGl4HZgK+9gGCwZH07xPKSjgBQgtUx2WAseHOLSX8S+b2FLOEGNAibw9Xen8DuXjGoEB+uT6294vR5o+gPaK3NoPSSx6/3HwHwIxgNaB1haExh88Q9YJk7ygTr72o+TDp2bgOhEbA43UiJjwLiuwXqI9mLkajXJDjDyuJUlI9xvrcF3mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMEqiVwxRfBqFh+w1IAw8dH8l7dISyve6Of3WjcX83g=;
 b=uD2RCjD+U7uUVGzbNPJVspg5iyGGVubUuBrxgecIV/kAdubnaEKyJttc2vcXmEyUAE2pi+Sjk1wHQUpSlAjFgn4UPLBrQuJwImpV1CdyXKEdSVuwiVKrxiOaFHRpB4rvi/QMlJ/qtnDltWVuWQ9HU/ocxM6CSfFijHGgZloyuoo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5463.eurprd08.prod.outlook.com (2603:10a6:20b:106::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 08:24:00 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 08:24:00 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 06/17] block/io: support int64_t bytes in
 bdrv_aligned_pwritev()
Date: Mon, 27 Apr 2020 11:23:14 +0300
Message-Id: <20200427082325.10414-7-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200427082325.10414-1-vsementsov@virtuozzo.com>
References: <20200427082325.10414-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.182) by
 FR2P281CA0004.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 08:23:58 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83c51d1d-88dc-46cf-4274-08d7ea845636
X-MS-TrafficTypeDiagnostic: AM7PR08MB5463:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB546395C75AFD807EE25C36BFC1AF0@AM7PR08MB5463.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:608;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(396003)(376002)(346002)(39840400004)(2906002)(81156014)(6486002)(26005)(8676002)(8936002)(4326008)(6916009)(478600001)(66556008)(7416002)(66946007)(66476007)(6666004)(16526019)(316002)(2616005)(1076003)(186003)(5660300002)(52116002)(6506007)(956004)(36756003)(107886003)(6512007)(69590400007)(86362001);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NMiB+fcGoSZPgybHXnqgchzHtVGJ80xK/Q4JWo2n1wa1EanqT166UqOFrplQfgBztTQ6xiR7vGMQoqGX4DJ7pkfza/XSjO1wL60xe1AA3H6lCbTut3Cf9xV7LKLCKSi4DLfBbtzRoXC81aDrZ7tU/VopItnatNXLz0eFCpvz25t2sk8I6PyhQzW/iZuzxXtk7Qb2vtcV89SBL9Fzs1rGVdybVHxpIcBaQlQjGiop2TKYmLOlupkrKdDjkycI6ZasmuZ0xYlTl40pk8ECMMxJgaMyj8CdPlfbbKTJQ7NJ1xrgJxPFScGlkNqsQwuJ6GP8ylzsug98KJNWMIFDSd5CoZylk3c5NNW3/ewbW3Lp6qBNhuyu/zQ7xhPznBstT5QphzClPpadabPHnFk0NGeIxOdUtEFSC7hu71qNzQpOICmR6xfQZ3uemXhSOJtPOzRTN0tu9zk+PWqbFp8CWJxsDMuW9c672FYFoN27kEyh/dTfNfzHClTfqbhnQxiBK0bc
X-MS-Exchange-AntiSpam-MessageData: gmaXe2dr2p6QHxcI7sT16wBJhEBtcmoI4qYWT+2zKTyiW7ndWYdCgjjvBV/vsdqEDxHgP1BybLE/214s+pkQQZfdSYkS+lwJ0tyB6LCKIKXuZy2jB3YZ+budmwUuhP7Bnu5PWte9D3DzRDtrhWryKE3T23A6boXE55uG6iXef4BfWsL5UOeqhQLraQoC9cqnaBtIf2/ZSRCLpX1kFJ8Rxj7c4JoSdyPZkd/Iq+XgRl3/UUtElfjn6Imfnt9QGKj8VoMVD6uGgRavCthw6QpE07TqC6q6NtgqK/0AHihuUUCu/rRqOR6g4zhSLBx4qWMzfpGi+CtkAKZcO9aE4nbHPpzMtL4irEPAx/zvZbu333W9cpcOqdW3xyayLSOtGiPmyLhDWiqhuo8vKP3CvVo0YZXq5UbQBQOOyGqjL7UogTK23hOcJKcBguNw++PAiCwRyWdX3lRjwJPupwK2G/LaeGZhCv9hStmzQItBCexz5CcLOtOhUIxffY3UYnHUZQjZvM9m+V2pnBq9GeE+a5sZEaD0uqccpIBt/Uf4ntUyH1/mQn83HTqxh3i074L8VdB1crYmC5JSZhY0+Lj42fwfln3E3mHCskS0HT4b5QnWf6kS2qpcBqoJ3lIbzJV9GvdDSkGu4iffyYqECiXANq9WEBR4CHYHEU9YWX18vcMd16PDr3YIh2If0KY5RfksXoTR/Ktlai+7cVbAfXHSVnPpcSjVpfASacsqhnWVTeOADnAWfURCJXMLjwbJT7LeCCLmnIBzhRonvdt+iEwrL8tyB7hvdF8brn2jmqgSMQYuRX8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c51d1d-88dc-46cf-4274-08d7ea845636
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 08:24:00.1075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dsHRB2IM0oLofYL7OWuTjp0Nd9/7MdnwlXLx5ZO821rufk9g6oJZdqhXBW+ueX6MPCSSS17HsDFSxxwXxNfFbncFXDIDpjDZF52gyYmP3fY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5463
Received-SPF: pass client-ip=40.107.7.127;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 04:24:00
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.7.127
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
Cc: kwolf@redhat.com, fam@euphon.net, integration@gluster.org, berto@igalia.com,
 pavel.dovgaluk@ispras.ru, dillaman@redhat.com, qemu-devel@nongnu.org,
 pl@kamp.de, ronniesahlberg@gmail.com, mreitz@redhat.com, den@openvz.org,
 sheepdog@lists.wpkg.org, vsementsov@virtuozzo.com, stefanha@redhat.com,
 namei.unix@gmail.com, pbonzini@redhat.com, sw@weilnetz.de, jsnow@redhat.com,
 ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are generally moving to int64_t for both offset and bytes parameters
on all io paths. Prepare bdrv_aligned_pwritev() now (and convert the
dependencies: bdrv_co_write_req_prepare() and
bdrv_co_write_req_finish() to signed type bytes)

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/io.c b/block/io.c
index c8c30e3699..fe19e09034 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1854,7 +1854,7 @@ fail:
 }
 
 static inline int coroutine_fn
-bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, uint64_t bytes,
+bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, int64_t bytes,
                           BdrvTrackedRequest *req, int flags)
 {
     BlockDriverState *bs = child->bs;
@@ -1906,7 +1906,7 @@ bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, uint64_t bytes,
 }
 
 static inline void coroutine_fn
-bdrv_co_write_req_finish(BdrvChild *child, int64_t offset, uint64_t bytes,
+bdrv_co_write_req_finish(BdrvChild *child, int64_t offset, int64_t bytes,
                          BdrvTrackedRequest *req, int ret)
 {
     int64_t end_sector = DIV_ROUND_UP(offset + bytes, BDRV_SECTOR_SIZE);
@@ -1948,14 +1948,14 @@ bdrv_co_write_req_finish(BdrvChild *child, int64_t offset, uint64_t bytes,
  * after possibly fragmenting it.
  */
 static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
-    BdrvTrackedRequest *req, int64_t offset, unsigned int bytes,
+    BdrvTrackedRequest *req, int64_t offset, int64_t bytes,
     int64_t align, QEMUIOVector *qiov, size_t qiov_offset, int flags)
 {
     BlockDriverState *bs = child->bs;
     BlockDriver *drv = bs->drv;
     int ret;
 
-    uint64_t bytes_remaining = bytes;
+    int64_t bytes_remaining = bytes;
     int max_transfer;
 
     if (!drv) {
@@ -1967,6 +1967,8 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
     }
 
     assert(is_power_of_2(align));
+    assert(offset >= 0);
+    assert(bytes >= 0);
     assert((offset & (align - 1)) == 0);
     assert((bytes & (align - 1)) == 0);
     assert(!qiov || qiov_offset + bytes <= qiov->size);
@@ -2067,7 +2069,7 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(BdrvChild *child,
     assert(!bytes || (offset & (align - 1)) == 0);
     if (bytes >= align) {
         /* Write the aligned part in the middle. */
-        uint64_t aligned_bytes = bytes & ~(align - 1);
+        int64_t aligned_bytes = bytes & ~(align - 1);
         ret = bdrv_aligned_pwritev(child, req, offset, aligned_bytes, align,
                                    NULL, 0, flags);
         if (ret < 0) {
-- 
2.21.0


