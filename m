Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D305C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 13:48:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4F2720663
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 13:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZeoELWbw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F2720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH6Oj-0004XJ-Ts
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 09:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jH6NM-0002O0-I9
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:47:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jH6NL-0005aV-7n
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:47:20 -0400
Received: from mail-eopbgr70094.outbound.protection.outlook.com
 ([40.107.7.94]:37990 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jH6NI-0005TM-D5; Wed, 25 Mar 2020 09:47:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzjA+GMiKQiHqHdGowq8/Vl8XBwPSXTa2AI9rL871BIWL5Bb0H1bMBkbmlBPPXcNxVWutHk/hXxHYWOhdb0sMqL5FePaqFYwGgNyyJCpokZfVjuFgA8uRuZmw6aZo3vRMGrYNrnMSdmy/byPquYktt2vWqPjXJnLqwHr0NkkdgDmGh0cybZnvipOl78NHUwpowdnYxnQBMaQI2LDGkyqQNJlZez5z54FKbCXhtgz4jNAh7GYTiDop0uEEMNt9de/SKdZv0HICtBAplqnhLoJsQVvAt4Ruf0u8cy+O/ZAUfz2Nu0YMrGGld4qR2B4+CTsvChvARcbPl99BVAQj0uH5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7V6Gne0dlW/oat5tDlErUlH9AJ+qNz5juiDf3a/HJo=;
 b=ivYwpE3fQEDdPTDXv9hooF0QzsIDVfjNB6ywKLNS5O/BykvMArgZ5+1GpoYTQh+h0uhuojnwVzjdRUzhxqonkx0j6qjwAy+Nd5dNcVH27ydhzvPhnwC5Qk+Ek6ZWJEQz8PIPkMqT9T0CWiQ2SwFVya0Y+2+Fbvba+RV6i+3QkavZORBMfpDr87flWLX1ZNY0NAz3SqQwT5DkqWKCiEWYWVjwVbcp/n2GEn2jCPZShk7YE/FGVKvqrVTQQynzfhb7hXJ1rKRkxk43L5GWWNdTM8Qph2HzniZ6BH/uzAKa6PxWzr2+3OVzTpvlF3gb73Qr0vSaS2R7NTGIIzs4T4gP8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7V6Gne0dlW/oat5tDlErUlH9AJ+qNz5juiDf3a/HJo=;
 b=ZeoELWbw1al/6dlqjqq1iUxv8qOPUQC0gLYMaZ10iL3IGI+8cjkDRYu3cDKKqOMDLUsG+mr4H0SykkL6rx+K2DNKF9B/ddkb3dIM98yFJT6ttnXnfhUWEv/oHfxPMrutGpimtUtSGghYE0esNLrsDK/6uAWHWG7S8Y0BwkCCW9w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5480.eurprd08.prod.outlook.com (10.141.175.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.23; Wed, 25 Mar 2020 13:47:12 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533%6]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 13:47:12 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 5/6] block/block-copy: move block_copy_task_create down
Date: Wed, 25 Mar 2020 16:46:38 +0300
Message-ID: <20200325134639.16337-6-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200325134639.16337-1-vsementsov@virtuozzo.com>
References: <20200325134639.16337-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0085.eurprd02.prod.outlook.com
 (2603:10a6:208:154::26) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.35) by
 AM0PR02CA0085.eurprd02.prod.outlook.com (2603:10a6:208:154::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend
 Transport; Wed, 25 Mar 2020 13:47:12 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.35]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ffa63a4-a646-41a1-4af1-08d7d0c30592
X-MS-TrafficTypeDiagnostic: AM7PR08MB5480:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB548026D122D4591CAC23FE3CC1CE0@AM7PR08MB5480.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:67;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(39850400004)(396003)(346002)(366004)(136003)(376002)(6512007)(478600001)(1076003)(69590400007)(6666004)(36756003)(2906002)(4326008)(6486002)(16526019)(81166006)(66556008)(6916009)(107886003)(66476007)(66946007)(26005)(86362001)(316002)(52116002)(186003)(956004)(2616005)(6506007)(8936002)(8676002)(81156014)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM7PR08MB5480;
 H:AM7PR08MB5494.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FwUpxILSyqIb3l8sifkKINCbpnYsEP3lyLkNrJpzv4Kxlyl7ABJRALub+Cn9uEycHsDMEwoQidNwc8JsQgE3l3uSWE8DAh89PaqNUOqNJFCBUYBBI9UZI0JelTr1u1oKbJ4bBGZZissUv6riNnPv33hBkAepXiqQCYrWwJIlld3B8LLqsWqIkPGsjJ2Cahx3kexglShcDKWQ6Pn9QWB0XXeYq4cMUMQ7PcmpOgwuCPExS6fexgZ6jINDYrj8vooOTGEl+r9jLBMGp7xzjqVJxNTn5JwSE+10DjjFP+XWvItq/3wQf6OhpxbT4EDAW6AM34THdLE1aqe5OObrB0fNWZoX8WobiSUGCmFBIRuUDVQskfUAozu46eU9p/2XQFg9opD2zknXOjDS1bk6gQsPb8Apd3/amnKC9ilLBlsKuCzEt7tABmhUPR+8GK0TbidzV7pZ5v1zrPFnUlbfqz7OycvKUHGQ4+CfA8obqAPwMYexbhHrQPsYFAzkKTeFgu43
X-MS-Exchange-AntiSpam-MessageData: m4OXgkbfz2wfh5/i7UsCldJ1QylizP5thm1adS8DOs/OJ7VkgTwPQWgenK7Qq9rvQjD4zH4lTGL4Azz7d144nau0t1AZcOe/ejG2TaU04TOIj4YOeW740AKj4QYldEzbL2rN6xIC9QzJizY4WQkx2Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ffa63a4-a646-41a1-4af1-08d7d0c30592
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 13:47:12.8152 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QChLtcIw5/n4dDZPyTc9onpKFGYPoKAGFpViODqBAK6cThieqgyy9k6FgcPu3hlHjHPWg8uspIuvWuYauj+I9jc4oUFNo7yfZHzeD2CaRwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5480
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.94
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Simple movement without any change. It's needed for the following
patch, as this function will need to use some staff which is currently
below it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/block-copy.c | 66 +++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index dd406eb4bb..910947cb43 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -106,39 +106,6 @@ static bool coroutine_fn block_copy_wait_one(BlockCopy=
State *s, int64_t offset,
     return true;
 }
=20
-static BlockCopyTask *block_copy_task_create(BlockCopyState *s,
-                                             int64_t offset, int64_t bytes=
)
-{
-    int64_t next_zero;
-    BlockCopyTask *task =3D g_new(BlockCopyTask, 1);
-
-    assert(bdrv_dirty_bitmap_get(s->copy_bitmap, offset));
-
-    bytes =3D MIN(bytes, s->copy_size);
-    next_zero =3D bdrv_dirty_bitmap_next_zero(s->copy_bitmap, offset, byte=
s);
-    if (next_zero >=3D 0) {
-        assert(next_zero > offset); /* offset is dirty */
-        assert(next_zero < offset + bytes); /* no need to do MIN() */
-        bytes =3D next_zero - offset;
-    }
-
-    /* region is dirty, so no existent tasks possible in it */
-    assert(!find_conflicting_task(s, offset, bytes));
-
-    bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, bytes);
-    s->in_flight_bytes +=3D bytes;
-
-    *task =3D (BlockCopyTask) {
-        .s =3D s,
-        .offset =3D offset,
-        .bytes =3D bytes,
-    };
-    qemu_co_queue_init(&task->wait_queue);
-    QLIST_INSERT_HEAD(&s->tasks, task, list);
-
-    return task;
-}
-
 /*
  * block_copy_task_shrink
  *
@@ -361,6 +328,39 @@ out:
     return ret;
 }
=20
+static BlockCopyTask *block_copy_task_create(BlockCopyState *s,
+                                             int64_t offset, int64_t bytes=
)
+{
+    int64_t next_zero;
+    BlockCopyTask *task =3D g_new(BlockCopyTask, 1);
+
+    assert(bdrv_dirty_bitmap_get(s->copy_bitmap, offset));
+
+    bytes =3D MIN(bytes, s->copy_size);
+    next_zero =3D bdrv_dirty_bitmap_next_zero(s->copy_bitmap, offset, byte=
s);
+    if (next_zero >=3D 0) {
+        assert(next_zero > offset); /* offset is dirty */
+        assert(next_zero < offset + bytes); /* no need to do MIN() */
+        bytes =3D next_zero - offset;
+    }
+
+    /* region is dirty, so no existent tasks possible in it */
+    assert(!find_conflicting_task(s, offset, bytes));
+
+    bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, bytes);
+    s->in_flight_bytes +=3D bytes;
+
+    *task =3D (BlockCopyTask) {
+        .s =3D s,
+        .offset =3D offset,
+        .bytes =3D bytes,
+    };
+    qemu_co_queue_init(&task->wait_queue);
+    QLIST_INSERT_HEAD(&s->tasks, task, list);
+
+    return task;
+}
+
 static int block_copy_block_status(BlockCopyState *s, int64_t offset,
                                    int64_t bytes, int64_t *pnum)
 {
--=20
2.21.0


