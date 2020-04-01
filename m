Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C07DC43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 15:05:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E898620714
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 15:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JHpoP/LX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E898620714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJevZ-0002fQ-1b
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 11:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38968)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJes4-0006R6-Sz
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 11:01:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJes3-0004EG-ON
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 11:01:36 -0400
Received: from mail-eopbgr70115.outbound.protection.outlook.com
 ([40.107.7.115]:27679 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jJes0-0004BA-Mm; Wed, 01 Apr 2020 11:01:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3iyAaV+d00aknbvJ227mUbuK2/mjHhqdWTEE4kdYoXaEd0Yopq7zz180DNyWdQDuoiI9casLjbLlN2SI8Qa5MHtXdQEfaWll1omRBE5P9BDqfx9P7/9f7c5BXaXcxKsR5PKA3tlJi8zUkL0nIzdP+joKTvx6fGfAaA0UegzmnMfNUjVhPMNJVsoYtRLQGBHQKzE1epxEbFspHEk6Z8MMWKfk/zwU8vogrze3736H3VSHr2i5xv16gnPaZq9jtPUucHYUcfsWRh3t7tRt2C9zsvTzsPBTrZ1TsdmetPpkELXCF9hD0lI5+jnC3d/tga5nFjJMbaWIAWCMopztsnc4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oI8YcHYTFbOh/wdeoiu6XxoyqQlvAWJAPWDyr2+uGwo=;
 b=V5qc+n+vSSCMwJdJTTh8IEJHFeWoPtQISwotO3yGfgxLoylGgon6NcFztoEbv+aSGvArbV2dg+ScppCSThJuqAdorLDGiAeaIFIpOn6PJbIayB/2MfbX200SsE1kT1WrwNB+Ri4KrN2O5OiakgGL/IaozYxsOKrG3quKWk9Jg4ePbSwZ6d9uwF++qMSqGqggS7FrjUbrpniPyd8eXlhXOMi1T7V0vCD21Jd+N/TfVrl1zDpVsrdaqt/aK65tyfd3UhRCP+Uhi7W0tsx/aa3djpFA6hTsISb8YIVigCKIO5jZJjIDhqfk3AziEzHu+Xw2b+A12lzIDNKm1djrDtxXgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oI8YcHYTFbOh/wdeoiu6XxoyqQlvAWJAPWDyr2+uGwo=;
 b=JHpoP/LXeq4hAuUBPwGtjAY9ord/XLiSDxLnaCs984t/HZx0uV5vXxM0jmwgFvHz+f+h1tR/lZx8S+77bSM5Lw867QMObVID4Ew1tsi6xMZOuxge2tMO/oHY8/LfBgjh0+NJHsZxdN54QeeaaMSIy3ekY99d9wRyDm33/oKWsl8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5397.eurprd08.prod.outlook.com (10.141.175.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.18; Wed, 1 Apr 2020 15:01:30 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.014; Wed, 1 Apr 2020
 15:01:30 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 5/6] block/io: refactor bdrv_co_do_pwrite_zeroes head
 calculation
Date: Wed,  1 Apr 2020 18:01:11 +0300
Message-ID: <20200401150112.9557-6-vsementsov@virtuozzo.com>
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
 15.20.2856.20 via Frontend Transport; Wed, 1 Apr 2020 15:01:29 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.23]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb5bc4cd-c6a1-4508-d5e2-08d7d64d8f1d
X-MS-TrafficTypeDiagnostic: AM7PR08MB5397:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB539715E62435C2315A5B6BD2C1C90@AM7PR08MB5397.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03607C04F0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(396003)(366004)(136003)(39840400004)(346002)(376002)(956004)(2616005)(81156014)(6916009)(6666004)(478600001)(5660300002)(86362001)(66946007)(186003)(4326008)(6512007)(16526019)(6486002)(66556008)(6506007)(81166006)(26005)(36756003)(52116002)(66476007)(2906002)(8676002)(8936002)(1076003)(107886003)(316002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FtnNMc+UKyz0q/NtFgLs1SwCuQmM/HaO7YaHiYq2tIe076lury+/8UwFA1Lt5YD2BGz9l7OANHD+CW1aveBv3dtPhXd35XDbJER/Qqg9pLaI5gyu9Rw5nx0EuS/fOrN4GZJ1QjLCfVofb5Ey7W3fy70Znf9G8n40m7LtvDGFBqhYYWLEVtLSw2foi9MG6AyN2FA57Ojwk8QyW6yJrK6Xmqu9/i06AWTBNQA1vPzGZBfvOvDEQ7gPY46IaJ9R/TxDppnngs36lu4WliLzePA0KCVJxdL1voOXHo0ys0WPpBx15Adn3qfYbyMiYQpPt+EA2UeS8DG09C/x1rjjAsweViulpAfHzm0yxdJj+OY6SpM81oNzTBNB+6Jj4qpZIiPcWxTqfq7oVwQPya81th6BI2VD1k+7/OFujJgL4PulSIkwVlMp9yThXoL7rDEddRzb
X-MS-Exchange-AntiSpam-MessageData: AsgShFutaPdff6rokjz3LDY8xOnIAu1k9KtXA0hJrK05PIOWevs1SotnYrt1odBocHuslF+gzwNWjcds4Z9IOyctZI1knJetnNGFurDAlVeS1+IzE0+T4pcePVrvQXDOq6Lx6/++Iq+Dz/0X6sRBAA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5bc4cd-c6a1-4508-d5e2-08d7d64d8f1d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 15:01:29.9949 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GQnoih7ctVH72aUtuYqUwYA4/qYH1SWr9JzzDW85ljbCttbxapc+4VGqc/67XkSXLyqrEWhzzH9VQjwInNv3/QjpzjzObJIJH8yHT4Daydg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5397
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.115
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

It's wrong to update head using num in this place, as num may be
reduced during the iteration (seems it doesn't, but it's not obvious),
and we'll have wrong head value on next iteration.

Instead update head at iteration end.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/io.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index 07270524a9..f8335e7212 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1790,7 +1790,6 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(Bloc=
kDriverState *bs,
              * convenience, limit this request to max_transfer even if
              * we don't need to fall back to writes.  */
             num =3D MIN(MIN(bytes, max_transfer), alignment - head);
-            head =3D (head + num) % alignment;
             assert(num < max_write_zeroes);
         } else if (tail && num > alignment) {
             /* Shorten the request to the last aligned sector.  */
@@ -1849,6 +1848,9 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(Bloc=
kDriverState *bs,
=20
         offset +=3D num;
         bytes -=3D num;
+        if (head) {
+            head =3D offset % alignment;
+        }
     }
=20
 fail:
--=20
2.21.0


