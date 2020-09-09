Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5FAC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 19:03:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A0D820C09
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 19:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SvHkezl7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A0D820C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG5NA-00048m-9o
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 15:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kG5K7-0006vr-Aj; Wed, 09 Sep 2020 15:00:03 -0400
Received: from mail-eopbgr70118.outbound.protection.outlook.com
 ([40.107.7.118]:32002 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kG5K4-0001MM-TP; Wed, 09 Sep 2020 15:00:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhPJaislsk0HAKyx5IqI4wYOhlBCDiKuwaboh2qlq04o7KueBn8pnucYWBfx1GaeXR4t2I4BzCEYOxCczHCxp4dmBcjBC6EH/SUZBtK++A2TCJVgJeYEp+vT8jD1iTocUqU17uV7JlRClZ9YHJPuRwZSxgiwhzbq30iuHOjflVrw2O3fu+tkKmH4YgTWa8eDzVGzHL30M88WYgy8H9aZaVLduRnn/YVuAWJ+sqOJJ4r5liKAPsC4ZnFKu72Y7A46elFUbhDXiFQoCDRb1yXhRut20J3DdOwuJCHyYWxshKk/TGP3FNJ21axzzcVuB7j9G6DEQH3m3CEdULan/GGRFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XCMwsSm4hdRQ4AZi/PiKaS9CLggDjvU2q6h2Thwz0I=;
 b=fsyXdTK8SWecWsdryWSCWBO07h8NxU/vS+DRM+dX8Wf7AKDIEMiwzBM9kY7MNxyM/hhX74vdaXzr1+NSrGuC03uUvAUHz3DIubUEYXLMpadmRwFLrOUDc7FwUXtzKuaJSQI3kBCX5zxTqHdyBYZQ1O8PfIhAW2jo+TMpNujmCNTOk08dsT1OxQba+N+1QBurLpKJbHAwjVv96YKBaCZ+eTW+ghEuejtU1Xr+UG7W+IqCVjtvma/kvGdGIcSE6tq69ON7GpGigc4o9rF1I+RXribeFdeluVCmXhIChpz8RKtBI7BJrooVfE+kH+AvCZ+GsSLLHAOIiTl8Xjo4C3V/Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XCMwsSm4hdRQ4AZi/PiKaS9CLggDjvU2q6h2Thwz0I=;
 b=SvHkezl7Y1+PiJj914dPcTlox4A6/D6GlVThgcKHOHpiQr3trNNVz+T1s2j5kieLJJti3Tj6YryQcuD2EJ7l9+/Jr4+CrZUemJHDGqVyR6GuSDTsqHBao+Bvs2J6tm0bg92SdvLyg9OguQHTriF76C2t8yhhBc/TuDsRrQ4mgoc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3445.eurprd08.prod.outlook.com (2603:10a6:20b:43::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 18:59:51 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%7]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 18:59:51 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com, groug@kaod.org
Subject: [PATCH 01/14] block: return status from bdrv_append and friends
Date: Wed,  9 Sep 2020 21:59:17 +0300
Message-Id: <20200909185930.26524-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200909185930.26524-1-vsementsov@virtuozzo.com>
References: <20200909185930.26524-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0054.eurprd07.prod.outlook.com
 (2603:10a6:207:4::12) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.136) by
 AM3PR07CA0054.eurprd07.prod.outlook.com (2603:10a6:207:4::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.5 via Frontend Transport; Wed, 9 Sep 2020 18:59:50 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.136]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fe1c2ad-2769-450e-a221-08d854f28818
X-MS-TrafficTypeDiagnostic: AM6PR08MB3445:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB34454B510EEBEC7FDEDD435CC1260@AM6PR08MB3445.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:343;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mPTuvLuiV0YHL38UWbbQTfNlP23Ybn9gt+8QFxNoW82PYzi4hb6UfcGuBcEqvm+DgnhhxVha4qdp1uUHLI5Mfysn8tPNEc4GvrRwvqeNT8EX+t4e3lycVfQPaVdb1be2prIPj9LaACzTAmqyazVgokzEB4dJRILZXqButO6fF3O757Tnd59p2F9bOS9YWTPtKL7KhVSMxXJVkJg1er3gAzBCff9/qxD8vFvi73G/W88jgaLZf+v13ATk+Buisrnlwym1ph6kzu+ng629C1cb4vDYq1AAuNN2tJbpZjcUBiIJtY8HQ7rK07JbWCzs3ZppKZ6gAnBpNuBEanAGsSzeJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(39840400004)(376002)(346002)(66946007)(52116002)(83380400001)(2616005)(956004)(2906002)(6666004)(8676002)(6512007)(1076003)(86362001)(5660300002)(26005)(36756003)(6916009)(478600001)(6506007)(8936002)(316002)(16526019)(66556008)(186003)(66476007)(7416002)(6486002)(4326008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: r75AGyvIyU+VxA6MFBe5GDozmUThFUekhGbQHULO00L655nZ3M/wxdPDVrAPENIEd/l9TRwKdnF21NTRFyx6TIn+VwUeEm2PlxZ14NvR8DrKhdHO7zvANEvzDxxtMfR4BMxBUqZk4VJzFZUTzMqIuNGeHMkMjHBSj7kh9XgYEj2yA42lYYM6X1Nfk4px6y9RTNyIt6Uz7In/8Lv6tTfcBRq6D1ZmlM1jxnFmFi/6mHHlio7C2rSewsq4FPs+e3NnBYuV1cmHznXV7qVX19olZql1xiUYZce0O8WuowfSLZa8ysIZ+UJ+COkEVVAOyajS+qVGsqqYVQ5uhdKLz3kYhhHd1aX8kga+pLErgUJqn2COPwr/aTaon6FDsftCIBe0YcH6lgZuNTN0hdmDa2KMOk5xirNG0j++eoUzTk5DN7/BlQjNOvogieZtTThXlxZ8RUdknAglAvULRn+MzoClcnxwuo2ltgq4Ajdntql/p2PrB+9fXukGYoiefzXjeE+lwmrfXQwmxpw41HBbvBooHNF0pvYO/oEfCs6L3DY7hKTEh4Kvs2MuIWClFpMRBQdqbydrg/g5k0KQWbIqQlctb73fDh9tnNlJP1OOPVUnK23dyV/+ZtYILaHxOufsoSPdmbcOFMQrWlE0jYqor6hSyg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe1c2ad-2769-450e-a221-08d854f28818
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 18:59:51.7538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rVVxn3nNGfc7RtoT8NSM0/KdWwUXsIf1blDxmzC0zm0R5CVp4JlyDqt2487+2L4AU/bPiDDtqmu2qFMo/Jvo/WIEYqJCCBGNkMlFrlCjJ2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3445
Received-SPF: pass client-ip=40.107.7.118;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 14:59:58
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

The recommended use of qemu error api assumes returning status together
with setting errp and avoid void functions with errp parameter. Let's
improve bdrv_append and some friends to reduce error-propagation
overhead in further patches.

Choose int return status, because bdrv_replace_node() has call to
bdrv_check_update_perm(), which reports int status, which seems correct
to propagate.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block.h | 12 ++++++------
 block.c               | 39 ++++++++++++++++++++++++---------------
 2 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 6e36154061..03b3cee8f8 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -336,10 +336,10 @@ int bdrv_create(BlockDriver *drv, const char* filename,
 int bdrv_create_file(const char *filename, QemuOpts *opts, Error **errp);
 
 BlockDriverState *bdrv_new(void);
-void bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
-                 Error **errp);
-void bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
-                       Error **errp);
+int bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
+                Error **errp);
+int bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
+                      Error **errp);
 
 int bdrv_parse_aio(const char *mode, int *flags);
 int bdrv_parse_cache_mode(const char *mode, int *flags, bool *writethrough);
@@ -351,8 +351,8 @@ BdrvChild *bdrv_open_child(const char *filename,
                            BdrvChildRole child_role,
                            bool allow_none, Error **errp);
 BlockDriverState *bdrv_open_blockdev_ref(BlockdevRef *ref, Error **errp);
-void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
-                         Error **errp);
+int bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
+                        Error **errp);
 int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
                            const char *bdref_key, Error **errp);
 BlockDriverState *bdrv_open(const char *filename, const char *reference,
diff --git a/block.c b/block.c
index 2ba76b2c36..6d35449027 100644
--- a/block.c
+++ b/block.c
@@ -2866,14 +2866,15 @@ static BdrvChildRole bdrv_backing_role(BlockDriverState *bs)
  * Sets the backing file link of a BDS. A new reference is created; callers
  * which don't need their own reference any more must call bdrv_unref().
  */
-void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
+int bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
                          Error **errp)
 {
+    int ret = 0;
     bool update_inherits_from = bdrv_chain_contains(bs, backing_hd) &&
         bdrv_inherits_from_recursive(backing_hd, bs);
 
     if (bdrv_is_backing_chain_frozen(bs, backing_bs(bs), errp)) {
-        return;
+        return -EPERM;
     }
 
     if (backing_hd) {
@@ -2891,15 +2892,22 @@ void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
 
     bs->backing = bdrv_attach_child(bs, backing_hd, "backing", &child_of_bds,
                                     bdrv_backing_role(bs), errp);
+    if (!bs->backing) {
+        ret = -EINVAL;
+        goto out;
+    }
+
     /* If backing_hd was already part of bs's backing chain, and
      * inherits_from pointed recursively to bs then let's update it to
      * point directly to bs (else it will become NULL). */
-    if (bs->backing && update_inherits_from) {
+    if (update_inherits_from) {
         backing_hd->inherits_from = bs;
     }
 
 out:
     bdrv_refresh_limits(bs, NULL);
+
+    return ret;
 }
 
 /*
@@ -4517,8 +4525,8 @@ static bool should_update_child(BdrvChild *c, BlockDriverState *to)
     return ret;
 }
 
-void bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
-                       Error **errp)
+int bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
+                      Error **errp)
 {
     BdrvChild *c, *next;
     GSList *list = NULL, *p;
@@ -4540,6 +4548,7 @@ void bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
             continue;
         }
         if (c->frozen) {
+            ret = -EPERM;
             error_setg(errp, "Cannot change '%s' link to '%s'",
                        c->name, from->node_name);
             goto out;
@@ -4575,6 +4584,8 @@ out:
     g_slist_free(list);
     bdrv_drained_end(from);
     bdrv_unref(from);
+
+    return ret;
 }
 
 /*
@@ -4593,20 +4604,16 @@ out:
  * parents of bs_top after bdrv_append() returns. If the caller needs to keep a
  * reference of its own, it must call bdrv_ref().
  */
-void bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
-                 Error **errp)
+int bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
+                Error **errp)
 {
-    Error *local_err = NULL;
-
-    bdrv_set_backing_hd(bs_new, bs_top, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    int ret = bdrv_set_backing_hd(bs_new, bs_top, errp);
+    if (ret < 0) {
         goto out;
     }
 
-    bdrv_replace_node(bs_top, bs_new, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    ret = bdrv_replace_node(bs_top, bs_new, errp);
+    if (ret < 0) {
         bdrv_set_backing_hd(bs_new, NULL, &error_abort);
         goto out;
     }
@@ -4615,6 +4622,8 @@ void bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
      * additional reference any more. */
 out:
     bdrv_unref(bs_new);
+
+    return ret;
 }
 
 static void bdrv_delete(BlockDriverState *bs)
-- 
2.21.3


