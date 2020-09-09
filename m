Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF0DC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 19:06:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A09E20C09
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 19:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RGsUoxRM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A09E20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG5Q0-0002lP-G7
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 15:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kG5KG-0007FO-5z; Wed, 09 Sep 2020 15:00:12 -0400
Received: from mail-eopbgr00097.outbound.protection.outlook.com
 ([40.107.0.97]:61422 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kG5KD-0001PE-I0; Wed, 09 Sep 2020 15:00:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XP0hsDMGg1Mr0HjDdr6uA9VvXQNnp6CMEH6sBkJixd44vWkwmHaP0NrpQzsKOiagXGtR7kSNhjJ+kh2QcoFTsODe5fg74TZr9Y2oe+NJZZVVjDaPmL9442x2rUOjl/ekFJKKJixw3BwFQGh29upKTeDCD21ABdO1IG1Ij4OOy148Zy8rMCT2bp8B87gnH5GbdTkWUwfTAHSZe6EDfB+3swjlgHD7pdR/MO+FScUq3IGxw9cS09YiUrdsFx5w19sMkOcAnF+853Bm+ucMyhaN9hHN8qvLsE+Mq1cJFzk8/+A1W2HvQVpjPdKgFDieRBplF5oDW27fbw2PxTRtlZirTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdBUOLaQB3AwDPKkKcHD/5O3ANeXGiyanXVGLdzmImA=;
 b=XVaK/DNYdEIyZYPzv2JwSu2grZHf1yonIpXFM6FzfzzuOjpBhAW3UFqQmXzZ/6y97OII6XcWaZNrf22nRpQvHIYBUlyAqFIzhTw9IuK+bfy3nuQUrgp9aYE6dZc5hDg6yJdrefeqSY/9PIxuT2xFAoC3weRQ5EsT+YwJJBeDmjoRx3O7ubVCRiErCxvcpC6DNJ7onUdmcwNL2okp5aFLwZd4iBlAamlug/qNiQWXR7Erv6RY2b4BdQ70rGFQXyKr8r/gZfeYDwgeLj1Eg0nBSOzOZ5Hqw0vTLh8P2/aASbB9T9oYt/YWnnXjgq0ICgoiDnLl+m85ltrMprJBZXLDNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdBUOLaQB3AwDPKkKcHD/5O3ANeXGiyanXVGLdzmImA=;
 b=RGsUoxRMQby7a64ESR9+GMh4sO7fDlXDpelpSFC20YujlCzQfAAIUcMv5yJIQDd6ieero7FF8En8rBuExbeueevU3bdki+spu+dWGmmPu3oLDyWlFZAl1RTY1mSbHElQfqFKDf5pplp47bzHypR2y5uT0Ww8znVdxGEMA7tlDqQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Wed, 9 Sep
 2020 19:00:03 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%7]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 19:00:03 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com, groug@kaod.org
Subject: [PATCH 11/14] block/qcow2-bitmap: return startus from
 qcow2_store_persistent_dirty_bitmaps
Date: Wed,  9 Sep 2020 21:59:27 +0300
Message-Id: <20200909185930.26524-12-vsementsov@virtuozzo.com>
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
 15.20.3391.5 via Frontend Transport; Wed, 9 Sep 2020 19:00:01 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.136]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49d1aa73-b8fc-41f4-8649-08d854f28eac
X-MS-TrafficTypeDiagnostic: AM6PR08MB4070:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4070185A43FB64A7667C063DC1260@AM6PR08MB4070.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:57;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HZ9FwQEYGHZFrXw4HDqyQIRBVUwoa5jH+NOk0+wfNBUjeTmAvmr49uGTwCeEomiRUa4V1x5lTgocP8FqbouT2ecaFvP7D479V4UMwS5sJE4qsjoa9x6v8qLX5eRXst785WsKnjy+9maNJok8W7Q/H59oEofrnKhg6zZCFR+1641ngqjl43nfolqyHKpiDuFwX6wmkH66/bKRidtbpfm+MELM2wL17jzF7waVWwBavgwHS4IeHhTyEzRf95Mrop8KNUGebyj3v0kFACnqTGUgDCWz2ECJfGT7nDU8CtrArjAUiNFS7ga0bft85OBbvpcK0qTTn2K2llQYA4HHKuoIuDBJt4+FGSn8wiAFekvVBDQVr4bnvoTR+1bDxJBuB2Zk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39840400004)(396003)(136003)(376002)(346002)(26005)(316002)(8936002)(19627235002)(8676002)(16526019)(186003)(478600001)(5660300002)(6506007)(7416002)(6512007)(83380400001)(6666004)(4326008)(36756003)(52116002)(2906002)(6486002)(66556008)(66476007)(956004)(6916009)(2616005)(86362001)(1076003)(66946007)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: iYslXK2Fo5cFBRwDB1pVNhlAcaR0ESk6WpR2Z3gncB/UzuJBndszOkX+J4M8e7cTkV0O2ZuL/aIaAGd7iiwHTHHOTWtfNd1gsi5zsjzLZQDgX5iVNlWW6LEwbrXCzCz+jRa1L25B+k6/VWpU7cTMl6OHxCuultaCwtmCA6wOHbiuHC1iX7zOxK0X+9PqG3360Ny28SoTkqar7rfZ4fRQXdQN7/PwFB/NrLDRhTsxSBuuW5NVfLA+WlhNIMM206Q8e0W6MxNb4IorkdP6cqb3AhPTmF9uYFRKTf5TX039xU2pPTr9FQFHcEozUHWHmZayGauSgnK49YDi2idQQTQxy0k+fP/PK7hItsHF+SbGCSA6uhwzlVbVPMEOkuQiVmMVRRg/In5tky6KMAcACSN1CEfuu1fK4OV8nT5T2tQukCyQGyufzGAB6vBHGWNMWikHKvlXE15cu/a10v0OWp/ukvRqQiU1D1cMqQxu46lgdzV9Wh4934uEjqgxLn6PhWhpyTZpgep8kobgKIT8DTz9b3su6bnfGrvOC28KsroFEfqNEeCKIBFEH5duA38F1vRIepbBSW/7a05FzYexCkcgzpLxG9t5Vfu9AQ8weq39v2nBJd+8k7pfrZIdWIU+yrdDmQp4PEYvekVgdtWsu3RMYQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d1aa73-b8fc-41f4-8649-08d854f28eac
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 19:00:02.7018 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w3DYoSiEIZolPaQxjSdIRADa+i/ZMwVlqvc6g5oGCTKTXQ6IbHnWUZCKNtQgRdpeO5yHhVCYXQZOk+aGwBMeuZho3JYTip9/sgL2jmKlQu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4070
Received-SPF: pass client-ip=40.107.0.97;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 15:00:04
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

It's better to return status together with setting errp. It makes
possible to avoid error propagation.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.h        |  2 +-
 block/qcow2-bitmap.c | 13 ++++++-------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index e7e662533b..49824be5c6 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -972,7 +972,7 @@ bool qcow2_get_bitmap_info_list(BlockDriverState *bs,
                                 Qcow2BitmapInfoList **info_list, Error **errp);
 int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
 int qcow2_truncate_bitmaps_check(BlockDriverState *bs, Error **errp);
-void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
+bool qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
                                           bool release_stored, Error **errp);
 int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp);
 bool qcow2_co_can_store_new_dirty_bitmap(BlockDriverState *bs,
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index f58923fce3..5eeff1cb1c 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1524,9 +1524,10 @@ out:
  * readonly to begin with, and whether we opened directly or reopened to that
  * state shouldn't matter for the state we get afterward.
  */
-void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
+bool qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
                                           bool release_stored, Error **errp)
 {
+    ERRP_GUARD();
     BdrvDirtyBitmap *bitmap;
     BDRVQcow2State *s = bs->opaque;
     uint32_t new_nb_bitmaps = s->nb_bitmaps;
@@ -1546,7 +1547,7 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
         bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
                                    s->bitmap_directory_size, errp);
         if (bm_list == NULL) {
-            return;
+            return false;
         }
     }
 
@@ -1661,7 +1662,7 @@ success:
     }
 
     bitmap_list_free(bm_list);
-    return;
+    return true;
 
 fail:
     QSIMPLEQ_FOREACH(bm, bm_list, entry) {
@@ -1679,16 +1680,14 @@ fail:
     }
 
     bitmap_list_free(bm_list);
+    return false;
 }
 
 int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp)
 {
     BdrvDirtyBitmap *bitmap;
-    Error *local_err = NULL;
 
-    qcow2_store_persistent_dirty_bitmaps(bs, false, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    if (!qcow2_store_persistent_dirty_bitmaps(bs, false, errp)) {
         return -EINVAL;
     }
 
-- 
2.21.3


