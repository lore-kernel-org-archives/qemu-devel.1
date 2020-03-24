Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA06DC2BAEE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 15:39:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 881652073E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 15:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="IQelt1ZX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 881652073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGleH-0006ML-MY
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 11:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39597)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGlbp-0000al-VY
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 11:36:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGlbo-0005hO-V2
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 11:36:53 -0400
Received: from mail-eopbgr70132.outbound.protection.outlook.com
 ([40.107.7.132]:20336 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jGlbo-0005fj-NH; Tue, 24 Mar 2020 11:36:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSeEyjfOgejIpQOiQPregCNT6mxJXeM5yjmjJghP8dl/OcpakGc4yzr6KKrWkWZAw19NXdg28TCnzF0bGfAmcwxzehYA6o06g1JITkXgOrQpmUDnlrqdYiBMUGG776lw2qIn63+d9BmEb7ZD/kjBJzfHNFUu0KEhLYPK65S7i2sKho38bqNE5DRaLbKnasEbjX+IN7/ySPTgX7wMKWhHk9LAkfMMQsoz/gvuBEo0nCddfVk/kfnAfuknd+7nGYwwotSbsHIVrimAeOPg/8RWN4dbvWvAq55Qe6p9zseKspekymBCZmUPBn18ZbUhXkQsEX5BQ4SBGa6Qez0Ut0IHIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSNK1zzcI2VQA2U36YyqYry2DuMuGlpopiutGskWWrY=;
 b=Fhz1LLG3Phy0967Beieu/cIBvNq6FjZQm0MC5k91pvs3yhgqW0eDF/U3UlwZHGSb5+Dvu4OCXOYXkwRKs1flkG9VwfGyDm5YFN3FCczappChccj7P3kczJUodn5WnXoMzRHjpz8P4KZOJsR6IPZC5ygRHMT9To+8FRjAlEQFMWhZeVEAiyneMhfPKW4+qprSJVZfIz/CPwF1fuJvg/7zQKxAnAOAL0pexiYfg1RESflod1FltcXuLTP9sgdRh+RBhY5kVrNDCuFFC+WHUrPeW3XjLh/tBGJYsDCRCSxQVt6rPzFy1+eJkLFpp7ciGecHxxQ1SFQN49bdiKeM/tbedA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSNK1zzcI2VQA2U36YyqYry2DuMuGlpopiutGskWWrY=;
 b=IQelt1ZX+d6zG64F9eSDREr94mLcqq/hI9uUmm/fmGmPFUB1RigQp/idvWldXD14F3x7zc8xP7PwIlV/1xmGJgit70+o1cgauOVP20Dz7gb6C1ET7OMATMfnYw/kypZxl45Lv3lIvAKCL6n6HuRcdy2mwOhRICKV78CvFQ2XthE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5336.eurprd08.prod.outlook.com (10.141.172.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Tue, 24 Mar 2020 15:36:50 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533%6]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 15:36:50 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/6] dump/win_dump: fix use after free of err
Date: Tue, 24 Mar 2020 18:36:27 +0300
Message-ID: <20200324153630.11882-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200324153630.11882-1-vsementsov@virtuozzo.com>
References: <20200324153630.11882-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0401CA0062.eurprd04.prod.outlook.com
 (2603:10a6:3:19::30) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.15) by
 HE1PR0401CA0062.eurprd04.prod.outlook.com (2603:10a6:3:19::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20 via Frontend Transport; Tue, 24 Mar 2020 15:36:49 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6813d97e-3600-45b5-4ddc-08d7d0092bc9
X-MS-TrafficTypeDiagnostic: AM7PR08MB5336:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5336BEAAECF7A5617E74398CC1F10@AM7PR08MB5336.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 03524FBD26
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(136003)(366004)(376002)(39850400004)(396003)(66946007)(81166006)(66556008)(5660300002)(4326008)(66476007)(2906002)(81156014)(8676002)(16526019)(6666004)(4744005)(107886003)(26005)(8936002)(186003)(316002)(6512007)(6486002)(52116002)(36756003)(6506007)(1076003)(478600001)(956004)(86362001)(6916009)(2616005)(7416002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM7PR08MB5336;
 H:AM7PR08MB5494.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zRqdxtmOQOHWrbq+UsYbXKDl128xShdi3LQDh+NH5MAQGLTKVKRM5gUwGEyDwXSU8H99cJnVq8o17bAFrMDw8/XghOgR1sr+hbeMJTD92d3xfmLjj6n/hDEeG2bNPOJyx3cjJPArYguloQZ3n08u09TZI6VlC2qgnL04zz+zpl1CDsen/gZ0ZsMqsYzyAnbCosAHMHeX4MOUOId3t/YQvRQc4TaHkke9yrVc2E5QtPwlXS0vbUtonNLHWe57EJ9xGQQ6prviDLVHHFWTFSVNqxldsZwcKTD8qLLXfF/JlcyKp1yqhKhsLho2OTpm5qfOsvlVAmxu4ZOZRiFu3ck45QImddTqtZEFqagm5TiihqL02USDE97LqqYlBs17jll1y35lA4de55lEEPA9TnvzkseMO+Knp1F5O6dsJdCqqocR48QPK1dwxNm7nPco4pB5
X-MS-Exchange-AntiSpam-MessageData: KFpwuVJkhpcGNvGWTdolQaAeVDiCngBNdezh1WUu1++igtdFlh6SWyBVKzBJch6SBTpr4lgNXk5Oce+Q/jrF9wyhnnU1/4BXBhfcnCz0+9ajBbdQv5vK9SU+4PDu8FFUY2F79wyUuFkl7P3r1EW4Hg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6813d97e-3600-45b5-4ddc-08d7d0092bc9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 15:36:50.5912 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tTtOlsA3XuTUZVpKJ35ILkfMnA+yj4/akgQCfDLMfdS3aPa6vJ5o6voSEi2EEGN5Yz4rK64VoQN8NcyrhGRz6cH4CrCTwQFtn+L7712z6IA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5336
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.132
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, zhang.zhanghailiang@huawei.com,
 qemu-block@nongnu.org, quintela@redhat.com, armbru@redhat.com,
 dgilbert@redhat.com, mreitz@redhat.com, den@openvz.org,
 marcandre.lureau@redhat.com, jsnow@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's possible that we'll try to set err twice (or more). It's bad, it
will crash.

Instead, use warn_report().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 dump/win_dump.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/dump/win_dump.c b/dump/win_dump.c
index eda2a48974..652c7bad99 100644
--- a/dump/win_dump.c
+++ b/dump/win_dump.c
@@ -304,13 +304,11 @@ static void restore_context(WinDumpHeader64 *h,
                             struct saved_context *saved_ctx)
 {
     int i;
-    Error *err =3D NULL;
=20
     for (i =3D 0; i < h->NumberProcessors; i++) {
         if (cpu_memory_rw_debug(first_cpu, saved_ctx[i].addr,
                 (uint8_t *)&saved_ctx[i].ctx, sizeof(WinContext), 1)) {
-            error_setg(&err, "win-dump: failed to restore CPU #%d context"=
, i);
-            warn_report_err(err);
+            warn_report("win-dump: failed to restore CPU #%d context", i);
         }
     }
 }
--=20
2.21.0


