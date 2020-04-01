Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E517EC43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 15:06:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3B1720776
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 15:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SZk+bAff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3B1720776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJewx-0004Li-UW
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 11:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJes4-0006RD-VJ
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 11:01:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJes0-0004Bp-2x
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 11:01:36 -0400
Received: from mail-eopbgr10093.outbound.protection.outlook.com
 ([40.107.1.93]:29790 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jJerx-000494-IE; Wed, 01 Apr 2020 11:01:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCKsS3xQ6vtQ9XH7xDo7C8Gznr9a1l076spbKUiIr1eyU0P3U2ObduRTRvhbGT/NnuncoJPOkIuQk63k2YnmsYEkeAOVc7/3jja4omGpaHWGFdEvBwS02s70+YMasl2YSitEtUfyK9Sjyqe4l/+fxtvCFEMgTuvaAvg13hOXYlGmB+O5lLEN3TwGzlq1o+vDKwRs1BIloZQ/HQvXa3o11lS6PwJR80R9Njya9iYw76SRJzFgRqDqVfl8/eKD/fzlXKUp3KkV5RwHfxkMBY+sKRA8F2yGtKubtVExRF1pfn8BmFvKkRymlEweWvkZVcpJLMCfz3b046BnLe8QM5CX6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sprp88RYjDByino1ILE6cOMplx/yinMuFwvuYp/nAu8=;
 b=hjAvAVAndbHwNWTLLRrWG2SnEcMnVUuYNHy9k58gOAjSznSr9Pff1FepzPsxGyC7jxMCCMJ2rPBHFrfkBKNOhYrVFgQWypim6to7wrnTfFjGG2WN9nP0ya0X8vRjfKiyE4Hl9Ro8Y1WzT+naqYAPfZBe5p78j0Tr3bDcwijygvfTfAQTSzCbC/JE9FgBGbQHDmlSDYKM4fCnqny/AYLvZOt3KL1p0IIZlYy2g/lkAH9LBfmx38Us9Zq7b5Z7/G4IJrwLyjAbqmVIU4OPZ6SROoR/LzPPqXy4YuakAKVeJgGTuN5KW5m7wxE21jWuT5tgZBDaKO/E/p8+jNmfX+vLmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sprp88RYjDByino1ILE6cOMplx/yinMuFwvuYp/nAu8=;
 b=SZk+bAffZxkVlkAyoxYPTw2tzntX8DXOOkxJ8NcKwuGqD7iBDxnR9vWWvrO2yNRdGezL5Q8HFOsxVUYumYpDMWAG0QGe7gLmhrMur5OoRDicgYSN2wQxIsc65brC8NPK9HZ7dyGr4EpW/NXBE44efU1leDOos/PezThcqRLMN10=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15; Wed, 1 Apr 2020 15:01:27 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.014; Wed, 1 Apr 2020
 15:01:27 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 2/6] block/nbd-client: drop max_block restriction from
 discard
Date: Wed,  1 Apr 2020 18:01:08 +0300
Message-ID: <20200401150112.9557-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200401150112.9557-1-vsementsov@virtuozzo.com>
References: <20200401150112.9557-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM4P190CA0012.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::22) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.23) by
 AM4P190CA0012.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20 via Frontend Transport; Wed, 1 Apr 2020 15:01:26 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.23]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a91d175-7147-45d9-2c26-08d7d64d8db0
X-MS-TrafficTypeDiagnostic: AM7PR08MB5494:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54949C4FC443E366FD971048C1C90@AM7PR08MB5494.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:309;
X-Forefront-PRVS: 03607C04F0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(376002)(136003)(346002)(396003)(39840400004)(366004)(66946007)(66556008)(52116002)(6486002)(86362001)(186003)(107886003)(478600001)(6506007)(4326008)(2906002)(6916009)(16526019)(26005)(5660300002)(6666004)(316002)(66476007)(1076003)(81166006)(36756003)(4744005)(2616005)(81156014)(8676002)(8936002)(956004)(6512007);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WaddosziBLbV4scSHxjenu4UhAuTKln4rZkOsIBhvYCfKBIc4YB7iZl9OAkfPjDD0slbrsqBJthuvlPk3XDkGgeI8/cc4J8TRKTW1MYMVgShHfVA1GrlGYcy7lmIOWIXRVH2ni1mSargiLXGLt1NGJG7NMc63S21RRIHwat0Qz/L0rwPAzbQDWdIg1Ks69oJKUXiy8ya/sM03sIY7qK/2XV7Xx8QaevPFJPF9wsOVk0SSTL57QXTJt1qnN1uquEDpyGLS4m4jbQq1owkrJmhtm5ZS2BQUrgpoi5HLn16hNzYYiI7Qd5cslQvInYlIpBZu0rCbB8cbfDa5EfTQxHl2lNM8nCk8dkNnhoVbF6LnRHNU1TF4828sN0RjCxeqx7xDFJNjH0V7BC/ixy11962WcHJKDZzzeQmeWHA7Rc2MPNHYi/nCbiar9/pZ8t78SmZ
X-MS-Exchange-AntiSpam-MessageData: 0L26QLe5L76Ow/xQe409Ap2rguK0T8aKtDKHSt0thnCLhzgegn7XI56aU6MSmyIlfWu7SOCt4W6tpK/i3LM8pBb7pjHdjXB7DuVZ0ZYjg33LjkBtcQLUq8do5yAMFRGWDYZAhBKJr7Z9ZEvMhdaL7w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a91d175-7147-45d9-2c26-08d7d64d8db0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 15:01:27.5955 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vn0bCVG78kd2iu/bREvC0d7/mrS6nSrySK6XW56FTihHqAYUOvswa/EsOyPkLx6hsPZAYIGG7yAUKGVb22A4XxPNBQID+OuKjybFTuEaosI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5494
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.1.93
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

NBD spec is updated, so that max_block doesn't relate to
NBD_CMD_TRIM. So, drop the restriction.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/nbd.c b/block/nbd.c
index d4d518a780..4ac23c8f62 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1955,7 +1955,7 @@ static void nbd_refresh_limits(BlockDriverState *bs, =
Error **errp)
     }
=20
     bs->bl.request_alignment =3D min;
-    bs->bl.max_pdiscard =3D max;
+    bs->bl.max_pdiscard =3D QEMU_ALIGN_DOWN(INT_MAX, min);
     bs->bl.max_pwrite_zeroes =3D max;
     bs->bl.max_transfer =3D max;
=20
--=20
2.21.0


