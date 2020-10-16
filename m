Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1D5C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:21:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DF4920704
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="jIOveKDp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DF4920704
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTTQ5-0003sH-IL
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 13:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kTTGK-00032N-MW; Fri, 16 Oct 2020 13:11:28 -0400
Received: from mail-am6eur05on2128.outbound.protection.outlook.com
 ([40.107.22.128]:42592 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kTTGG-0007NG-L9; Fri, 16 Oct 2020 13:11:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Px+7bgyKBjCMkO35kWsNbZ6MmoBm6Vv/TRaGdW/zFrQ+8yohlqKqLjHMMPkld+P7R77lq8f++S0E7XGR5uKWHglEAXxF0aeObxefYjOIAkH4salUbuysrRRiXMXxOgmL4iUhsyg09VzjLlc4UUQ6A67YJlUxBAFLp0l9U1sPo07CdT6InrixhghmHKMd9LQPJZ4Fj2ehI1cxXZEpLh0PcLhrSb/TM6loqyR83+qIXKzi/pl6DT9gX63UGfGoCnZh6LHp8YGjJei2PXMwwOZHZQSYWsvevKer7f02Aa2v7BLDG5w4YylMlVbxKNXkFyLylNw9+Gqv9SvZt9PJQfSf2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y45ldB0gbI0IsAcoQrIfrf/YCHSOO5VpBSOBOIeWdX8=;
 b=hxF1GWdjTiHdMts/SyZ4VMmbHNlD+6iecAiUpyRGtlsIB+B03X+au1rUaorlJ4RfEFhtFu9aWbq0IakAFT7WGcKbo2NRlskJg/adausdlVvFZMB8W+3ebqmGx8fBd93zSRuXN0guAPruYopSr3km/Wr1v2OKTvFAuz9JsGLkh0K1y4LYlfZgIwAd5A1YArgpeKqkskXnyz2oUw8KC0kMt2IUixEDOs3ahwDV2mw7cmaS5B/3WpiuxU5uoMjS8tw8Z7f8CXp2rAFq4U+aXHQzyM+BRbhiP1B7iB+uMea6wihoNxppTeiSsBIeuFJ2lsD3/5nY2LZXqszZYYHifMzYLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y45ldB0gbI0IsAcoQrIfrf/YCHSOO5VpBSOBOIeWdX8=;
 b=jIOveKDpY3/Qn0TVPqdNnyMmlConmHCWYbLz+o6LezJnL6HpiSftS8FlOl05x3elUrmDCOlBm2ekw9oqL3ojWSfXzkuLv8Jx3m4DMmH09xW2++1/CCSH5PKkCFhOjQK3r6rmBFsEYQ0IlOndJIWmgmteuPhfqHJbQ+oBoz3Yo+E=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5495.eurprd08.prod.outlook.com (2603:10a6:20b:104::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Fri, 16 Oct
 2020 17:11:17 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3455.031; Fri, 16 Oct 2020
 17:11:16 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org,
 Greg Kurz <groug@kaod.org>
Subject: [PATCH v3 05/13] block: drop extra error propagation for
 bdrv_set_backing_hd
Date: Fri, 16 Oct 2020 20:10:49 +0300
Message-Id: <20201016171057.6182-6-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201016171057.6182-1-vsementsov@virtuozzo.com>
References: <20201016171057.6182-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.69]
X-ClientProxiedBy: FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::13) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.69) by
 FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.9 via Frontend Transport; Fri, 16 Oct 2020 17:11:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d38a6707-cf75-4334-0b04-08d871f67e4e
X-MS-TrafficTypeDiagnostic: AM7PR08MB5495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB549574295FA05D4D8A0E6D94C1030@AM7PR08MB5495.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:765;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n5xH8s/PwbR2sjcbFKhtKSK/btUKBwgvlYHTVOXdnolkeiHdGC+POte+yhMlKRqp8r5kklNH7cktCQOkP+TxmEzcRMw1JGM3+jlz2YurGB9zN8vmzUbrA3xWE4d9Wwylin3QWWLVgkVLIQu8slm9aO/0Y+kWwhaicKp5Ll3WufS7uaZ8Ne6vPmziIFs8JCGHQSorZc4l4IP21y6cNVYVS6Rj5iwHZUsBzXqowdqaIub0o2zHbinWs5Phh4KqxGBbHq68BpNilnh3ikLBH7j5mdVH0jh2dlai9EOPhd8K9Qdzmm1TGDMVOz/4OJMi9a9TrY8oi6IKX/l5K2gt+xjbi3Q8y21WgqPsq18PEBOzwZakLbPRlEXW16A4HOyWlkAj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39840400004)(376002)(346002)(136003)(66556008)(316002)(8936002)(36756003)(26005)(5660300002)(2616005)(6506007)(66946007)(86362001)(4744005)(16526019)(7416002)(6916009)(66476007)(478600001)(34490700002)(6666004)(186003)(6486002)(2906002)(52116002)(956004)(83380400001)(1076003)(4326008)(8676002)(6512007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: +/q5zwLz2qUIHNjMt5/PPt3rSK5KJEnukPJXw5kD+7QpWL/x9UJFVTdlvuc9u1mdnBg1ZF8v46XO6azVBB9pGiTytGUKDx+ZVswwsV/NV04n3KgY6fNrYI5MjxVNZtAnoBUJ7XK9UBJZyqzi9AHBMWLWsKvQwRoHSFaDOo47TOptnwgshgaJw6F1+yZOIlh8xsMXB7XGSkLYy+ZRVNAg8SEFKRWsoGzw8M+PP8TyRO88gpfVqj8RqygdnGfVkODRFPbpYU/qtkIW/lDTzdM3pCEE6ZGdqU5zApjqUc7ys56tzKOeZLu1SAhLOFazxjs3PZPThJ/7YP74xKnQPTQOS0JDNvnAGD/xLO35OGoqOkhWEF+yR40u18bOFVIyHCPyvKK6vde7lJIOlD9/L/jlBVaCzx385B8340H6B3IXlSJc4eQGhKNMcPed206zi8KLXsf4DaJ+u7hOOgasFEcFOcNUJeLbNKEond1H1dW70qE+/YUqEdJ6RKKeKLFNhYR/bCJavDfPWkWl0Spkb1Z0ylXPWWchhSh/eLzt6opScrDbobBp6hxhDLRid+B0xndfVzFt6qWuYn7M4WBMRpCvaXS4TReVlfOxcubng/qU2GePcXBwqevzyopm/DcXKGAlFHK795CYE8Hvt/P5mTQKxQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d38a6707-cf75-4334-0b04-08d871f67e4e
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 17:11:16.9226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSaPAG1+e12zvAbvjs5bgrB00Fgu2Ukcoon+ak96MgMZv8sYKY0QwYCt+rvC8GNAFwLoDnWwNnF+VFLgXQz0QquHto/MYDaDQpl4ap777Y8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5495
Received-SPF: pass client-ip=40.107.22.128;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 13:11:16
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

bdrv_set_backing_hd now returns status, let's use it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block.c b/block.c
index 7b6818c681..a35dc80dd4 100644
--- a/block.c
+++ b/block.c
@@ -3016,11 +3016,9 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
 
     /* Hook up the backing file link; drop our reference, bs owns the
      * backing_hd reference now */
-    bdrv_set_backing_hd(bs, backing_hd, &local_err);
+    ret = bdrv_set_backing_hd(bs, backing_hd, errp);
     bdrv_unref(backing_hd);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        ret = -EINVAL;
+    if (ret < 0) {
         goto free_exit;
     }
 
-- 
2.21.3


