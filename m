Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EBBC388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:12:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F1D921741
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LuLWCZQJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F1D921741
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVFn4-0004RA-Tz
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 11:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFaD-0005Y0-Tp; Wed, 21 Oct 2020 10:59:21 -0400
Received: from mail-eopbgr70109.outbound.protection.outlook.com
 ([40.107.7.109]:36743 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFaA-00085a-5M; Wed, 21 Oct 2020 10:59:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMmh1M8VRq9dGPHrneK/y9tfICXjdhmlNMvphiqNxPhxmaXfVHpVxgucIvsXnMllvxxKbFX6PeG2UaCpX7YF2nBc0UeSpM5T41/LjVIGgf91WD+ES5z/60GKPry+8ms8fqglYHA8PAIbEQ9iWyQusTqzATCq5divSRFbQx+KArDigkkov5axtCk+SrkSKm2K+dxXXT/ll4nz8WeDUdkgGYfZtnLo/1zSThkJwOwyBaSO0sXOWF+0hjObnL0zp4mMRQPl5hb8fmR3ZY6e0GGgrbS61gR+zadovHe1yHBvg+KO5YF+5aJRLXqRAGSJtganQK5qHQBvLhqxGJXSDUDI5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jGNUcLocWKe/OL1DUBR+lIeuAKrxBmAvNKomdyRZGQ=;
 b=emh4ahYWE9/loG6hzXY3Lcu7hgj27h+PzhgKITk1fMJrt9pKVNBp49h1QeE/1YlEET9YUjbJwtn9WOwX5MI8Z7d01/v3SnOdHrFLF7psEjyctfWmNGCbZZHw0jj/Bkn9R1u3FnT+hMEwE0SJRdhSFpH9S18klU6WvwNiCQWK6iyKkNWGm1iWxM6RbyanRYooU4mmSTwLXEh1GLLOp2YQIqJmQPz+YnLCoFPcXCvanMF440shVT/1Y+xc7J9J57nlGsY7QJ7Lv/XY00abRO6lTgHrttXlOXjuYLynV3edVuhYAxBGcj++Sg9ZUD/AqmOh7VpgeX7Yrl6wXHgQbGLgeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jGNUcLocWKe/OL1DUBR+lIeuAKrxBmAvNKomdyRZGQ=;
 b=LuLWCZQJJeFubs7Vwb4h/eL6Bgg/vIh9DqPUgJQ3IV/ZgFaeRTsmm4blnGBa1LWR3DflGYXeq9s5ViNI3Qch9uIf95aw6aA3Viu+8terSpNm/vo8jha7614nkLELJSjBnPFClDxlpKXtTncy8ulz/7E8/gXP09vxMJw00AGsyH8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4472.eurprd08.prod.outlook.com (2603:10a6:20b:bf::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 21 Oct
 2020 14:59:15 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Wed, 21 Oct 2020
 14:59:15 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@virtuozzo.com, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v7 02/21] block/io.c: drop assertion on double waiting for
 request serialisation
Date: Wed, 21 Oct 2020 17:58:40 +0300
Message-Id: <20201021145859.11201-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201021145859.11201-1-vsementsov@virtuozzo.com>
References: <20201021145859.11201-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.82]
X-ClientProxiedBy: AM0PR03CA0091.eurprd03.prod.outlook.com
 (2603:10a6:208:69::32) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.82) by
 AM0PR03CA0091.eurprd03.prod.outlook.com (2603:10a6:208:69::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:59:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 155551bd-3a84-467d-bcca-08d875d1e075
X-MS-TrafficTypeDiagnostic: AM6PR08MB4472:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB447213BC2F17A411EE2F6AD4C11C0@AM6PR08MB4472.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b6J6RikdZMB8uV19GKvUNi8uHRgtLqRsPaEkIVSzG50EIRBNsuR32nsbgjCqcJdxo1cMp2QIBZcoLN2hjnsUZYEOqOXRvKcRp2AI8z/1lbt+uLVZEjJKgq/4f+ObsVZOPZy0KDdkRu5e36LXbV3vZlePh/UXx6dbKgbOAS9O33N7rbI38C+C7ee5VY9rke67QKSDuqOOls/3Sw0vEU8GhHqKfZw7qSgOsFimwWMbX6BWGahMHLGlc41/zJxFBj25a6SMkB7B7c17cjvKDKG5gpc9KG0/3yMOZ/YFeltykUEfBWPvxSReCBRFubYu8YFBPs6v/tI6ydNcjoVuygw48A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39840400004)(66556008)(16526019)(66476007)(83380400001)(6512007)(26005)(478600001)(66946007)(186003)(6506007)(6916009)(86362001)(1076003)(6486002)(8936002)(2906002)(5660300002)(52116002)(8676002)(2616005)(6666004)(316002)(956004)(4326008)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 8kpStbEuf+H6Oj1hgao8nSE8SpQl5eppWIcBRk0IZ8Iffk4PppryJEHWMMWa1g6+sHL8SIDN52I8u6dcfby0KvBYdcKpu+oDdHaGXulAm/dqE6FfTzTzNoph2l+Nt6HXJz0l+EHcbkOV1bFwuxcNwbe7l0qZdkDS7PLlhynR0JdNGsBH1z65wRVa748cbmMeoSxIHalp0dLdvoIPcnDi+qlxeJZtc9p51HiYuYToTLCtNXjgbkzPCP+AKMwq/X6REWT90rcYnDnXot7RbEoHzvWQXNe9QulB1i9k4gLF4w0QCxHvlkmFmDv3WwEjsWOhF6js2nmLHhu6DnzKloWTWSlrDoX1QGjpy6fTq7OQmYrr02mnQLrHN1XlRd2LbnNwNeQ4zBdnsjnK4l/k00Bi0zPVUDb04z7SgoSVGOupO1MvOf2WskvBwMk6A/dCIXXmQPo5ecByAhuz+3JK2e5Q6RYFnJoF5umwdUSThgLYGJ6F2e6xFgKdDG5prH1ICfVnN9mBRcnpteb6NU3xWN1oyxuk2+ExGr4n3WuiyDgzWQpC4CHor1R79TlygFqv4ktMs42nxr2JMAPPTHcgpqdULVfsibNZRvK0Sv8llKcgIchHf+UhmqXMxh/ViPaUVGZj1y9VxEwYw1KcteIheYIrEg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 155551bd-3a84-467d-bcca-08d875d1e075
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:59:14.9572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DHG4IW0lHOAPSIKrl6i7ak2tvX4ut3m9e+z/PCtg6vShivNF9FaVZpuvopI050j30Orxqo+7mCREEsvbXe9OxLdbNJqleRuEWse699mLj9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4472
Received-SPF: pass client-ip=40.107.7.109;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 10:59:15
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The comments states, that on misaligned request we should have already
been waiting. But for bdrv_padding_rmw_read, we called
bdrv_mark_request_serialising with align = request_alignment, and now
we serialise with align = cluster_size. So we may have to wait again
with larger alignment.

Note, that the only user of BDRV_REQ_SERIALISING is backup which issues
cluster-aligned requests, so seems the assertion should not fire for
now. But it's wrong anyway.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/io.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/block/io.c b/block/io.c
index 54f0968aee..bf6d4d5e77 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1784,7 +1784,6 @@ bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, uint64_t bytes,
                           BdrvTrackedRequest *req, int flags)
 {
     BlockDriverState *bs = child->bs;
-    bool waited;
     int64_t end_sector = DIV_ROUND_UP(offset + bytes, BDRV_SECTOR_SIZE);
 
     if (bs->read_only) {
@@ -1796,15 +1795,7 @@ bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, uint64_t bytes,
     assert(!(flags & ~BDRV_REQ_MASK));
 
     if (flags & BDRV_REQ_SERIALISING) {
-        waited = bdrv_mark_request_serialising(req, bdrv_get_cluster_size(bs));
-        /*
-         * For a misaligned request we should have already waited earlier,
-         * because we come after bdrv_padding_rmw_read which must be called
-         * with the request already marked as serialising.
-         */
-        assert(!waited ||
-               (req->offset == req->overlap_offset &&
-                req->bytes == req->overlap_bytes));
+        bdrv_mark_request_serialising(req, bdrv_get_cluster_size(bs));
     } else {
         bdrv_wait_serialising_requests(req);
     }
-- 
2.21.3


