Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47374C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 16:01:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 117F62073E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 16:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HpSuMg0E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 117F62073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGm02-0000Je-2R
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 12:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43941)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGlxx-0006b1-7e
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 11:59:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGlxw-0004Vv-8E
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 11:59:45 -0400
Received: from mail-eopbgr60110.outbound.protection.outlook.com
 ([40.107.6.110]:7748 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jGlxp-0004Rc-F2; Tue, 24 Mar 2020 11:59:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vh4OnQI0jVnYYadsMGCgMCerch1TAnV0lkiadNo+9zCf/Gyqzs/NjwgH+4gGlaKOaAYxdC6snKqNj+6RTm6kCIuqmA7Xy/Oc9sizbWXB4TeIwN4ZYrrFTlfo3dOH/LmRW8xdHrR6X7t0o7Vc9IcF+uXheOWZKOQBUhSV7JfuLiMixH/boviTN11T43rPj79nitQDZE455p6Q+qQp5XrTT9fZlomrUoAwaU7+hwooVIMXSkKFpw7bOBDIIE8X7pAHM72LEgv2R5FUeBlXAzAQbF5Rd6p7UuJgOCQcNmO639xIOkPA6jVgEiXDKzM+2+ZTAO42ZPrYe2dQYK1tQFlXcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOANeOUvYyD30970B1U3nJXS8yC1oitZ8sMF7Ng+CGU=;
 b=aTZZuPKTy0XOLS/9Hjusx1TyTy4BwgWZr7pFF2cAvOvQ6WOT4zJip3+s4jKxsXh2Q7MbMcHjwhZNMk5EwXTIm24+yY6p2rx9U7U5+N2VVINpgXtPZvWPHNlm1YqOmxmHda7A31yEGQBhXsZ1VdN4Io2igWiF0j/8Sg090O3xjx47GBezFGBjJyII/GN1WncEISmt3sXTDwawPd5S+4U49dbhSa274i6vTmB5GWHcrXhFmnNEiu6HkN3n+G0qYiS4fQn54wNl+waG1thptvhhFJFVNT9c8oRgmwAqps5PitoNgFuoFQdzZLDEysUZj9P9AVfjk2Vymc6xYLtOCH8z3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOANeOUvYyD30970B1U3nJXS8yC1oitZ8sMF7Ng+CGU=;
 b=HpSuMg0E2L2GE6NDNU+5jehgcp3KEzMNtGsKQv29IGKxZ/MGc7Gwd99joe6eLPLMVfXPGPGutXHd62nIlpYDeg7fXeF7RhTVtjCDR0qW2CTOb3JeznPudkuwUuidNB4R5/E9GsuPQxRu7Q5k+1AGmpFkqdryr7+In8SdQI3u/Ns=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5383.eurprd08.prod.outlook.com (10.141.171.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Tue, 24 Mar 2020 15:59:33 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533%6]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 15:59:33 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH for 5.0] block: fix bdrv_root_attach_child forget to unref
 child_bs
Date: Tue, 24 Mar 2020 18:59:21 +0300
Message-ID: <20200324155921.23822-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HE1PR05CA0175.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.15) by
 HE1PR05CA0175.eurprd05.prod.outlook.com (2603:10a6:3:f8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18 via Frontend Transport; Tue, 24 Mar 2020 15:59:33 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0776a1e-13ba-4135-59fd-08d7d00c5852
X-MS-TrafficTypeDiagnostic: AM7PR08MB5383:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB538316917CE9E6F504F87070C1F10@AM7PR08MB5383.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-Forefront-PRVS: 03524FBD26
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(376002)(396003)(366004)(136003)(39850400004)(16526019)(2616005)(26005)(956004)(478600001)(186003)(6512007)(6486002)(316002)(4326008)(107886003)(52116002)(5660300002)(2906002)(1076003)(81156014)(66476007)(36756003)(6916009)(66556008)(81166006)(8676002)(86362001)(6666004)(6506007)(66946007)(8936002)(4744005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM7PR08MB5383;
 H:AM7PR08MB5494.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YfgKuDsa20u37qxlNaeJUZbJ/gDWfXMQNWpqTeVWIFYtPQshlrLAXJzqReFqGkqDXKK0cBJR5Rgt7+dv/plBReaWADsbJiGTp4P5tGsuvUxcMcUPpmuXdc+t607S4V1hv3EiaxC78FVddUKT4L/aHTVcCNy2JoT8MMGK0XUSV8AGwZ+7uw5vsn5G8ZWHYibwCBsAAAu5IST2PiIzxT3YmK9P29qdyKlGjYVmMrOiey2q4prRV6L69xzON6/JdZ+yPvEd2gr53/htELXOVvegRD8WiaLBrM+Ao3t7rJXTwnvH1/5rFSmknIPBHXbORmFlPbpYpvee6vSxksgPQmUin9GVx+gtqV03ihCogCyaIcP2bnwm3JoNZuxthFfBdftuPnUSQO3NEHPI8G6nWJZxrYDtiTj9Mrb8ChyzK5ioNGfCxl3Cu4A2BywSIfMsL2Cq
X-MS-Exchange-AntiSpam-MessageData: 710NhlkQVB1RFrAR/f/o9n9Njn0xFOTbwx1dSxsUYH3JFQgRU0OkEYIpflk/9SBnNOh8tLSAJP6S9m/PHmYA6/hxVBKlI/D4yQNYH39Thgc8wR1FKPYvjq0E50L4gXsaoGBd9K8/3b6qsWrrh6zWww==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0776a1e-13ba-4135-59fd-08d7d00c5852
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 15:59:33.8182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jAX4yCa6F8FKlKPKvmUW0GbpwizhNmE9DlqAIrmIyCx2oIKZBFgm1zkzk5qaBrTcUxLzJCjcuRCldh3uc2Sde4VDhKDV5M4UU9bXdlYAKRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5383
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.110
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

bdrv_root_attach_child promises to drop child_bs reference on failure.
It does it on first handled failure path, but not on the second. Fix
that.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block.c b/block.c
index a2542c977b..6713db773d 100644
--- a/block.c
+++ b/block.c
@@ -2612,6 +2612,7 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState *c=
hild_bs,
             error_propagate(errp, local_err);
             g_free(child);
             bdrv_abort_perm_update(child_bs);
+            bdrv_unref(child_bs);
             return NULL;
         }
     }
--=20
2.21.0


