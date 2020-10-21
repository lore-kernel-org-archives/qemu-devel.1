Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439D5C55178
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:11:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A1FB2224E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="s+PmGkkl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A1FB2224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVFmH-0003e1-7z
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 11:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFaR-0006E2-Bg; Wed, 21 Oct 2020 10:59:35 -0400
Received: from mail-db8eur05on2117.outbound.protection.outlook.com
 ([40.107.20.117]:60672 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFaO-00086M-Lh; Wed, 21 Oct 2020 10:59:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npqAiHkuEH85VpFIJMV+9n13eHLMVFoMEpiCQsowvOzOZod0pmW4VrWK8sEsIZH1hvX1mWY1vCUNX1Ze9FUretQYhyjDQNHWTS4ZEPW4j/H/ff1hFPXnU6MhTPwW9qdP8EWTSZa2S9J221ol3gsbsB3QPZNl2jw3HOOB1DNxgzEjEaBxLyIQX7KCtOi9eOJwuavWjFB6IjiGaGI1Ha+7biW1QXDU9oBo7DTXF8ab2izwY8PHQ7lpdggglYFXhZlOFl6MWidBd0DqXW80WoCVcPq4W7E3U4hC1T0R18IM+ykn/xwdtglMIYuzXYDkigl/MPEMkFYPR8tOitMDJ+tbEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Rw2wlyYIzYr8C8keOmOJrvsrrg+g73sKNyB+liX08M=;
 b=K20AKxFtRmHPcbh3bg/yuywj5cf/L/VADI6WfCbbX2gkfITSuxzIdVsW99YIeq87FrDyoZLVBff7Dc9fvIOyxBHkJVkp1MCnhb8p6H8xrO7cliuWNQ9zYeQAnsUB9s43nl2uW8QBA9rWBKiZ33+oKoKj0z3iXi6PmXnBr+vCSnynugppF/gLZw3yBQgnWuzVaMz1qgOF3iuAQkuUpDdXzWd27aTB28vHARYicIMHOFC+uUJcPaL/J5JVEynRLgR1LTnunIU8gllarrR6ikAZnytpKwWIzhCI0sH90vg8gXYDZa0wSSpM20pTXHudHkkQ3icMw0L2yhGvjSpAauJ07w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Rw2wlyYIzYr8C8keOmOJrvsrrg+g73sKNyB+liX08M=;
 b=s+PmGkklaeBuakxmynu9HgyvTy4Yf7WQhse65vM0q6JA8/47V08WxRgAwHbeP9X2IA5iU0qYvBK3stV1iYw2pF2r8J45PwWzttss26k8p+9B3q4C3ViJ+ZpWokjshAKDwTfMnFixZtcVwWCsAYdR2fKXzP9qCdeKJeqtx1ARZOs=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4472.eurprd08.prod.outlook.com (2603:10a6:20b:bf::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 21 Oct
 2020 14:59:21 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Wed, 21 Oct 2020
 14:59:21 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@virtuozzo.com
Subject: [PATCH v7 10/21] iotests: qemu_io_silent: support --image-opts
Date: Wed, 21 Oct 2020 17:58:48 +0300
Message-Id: <20201021145859.11201-11-vsementsov@virtuozzo.com>
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
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:59:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4a57862-af3e-48e9-3993-08d875d1e469
X-MS-TrafficTypeDiagnostic: AM6PR08MB4472:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4472F2516047D87512BC66AAC11C0@AM6PR08MB4472.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WrnA/N/jUUFmVFjEPHzIrfFQwVARmUCYELE/TzgN2LVpfUuZid5M09fEYCgd8RjxrT1ohP3CaexxGxk2me2OFmOICg2L200asv8+2o2it7wvtbpQ2otznozJD3gMFNbxyfg2TyqRQ4vqNyqQpk77OJwkSkfA6OY3B9byqGXMf6dphyJ4/9s4QO7+AeMBMwblWY7YTkZEUltsCK6OH1XkcG/x44t5Y3qjNncIqglZrr0u6wWAysUa9/OR0rr26fkfbgemw2rJQQe3vCxCT2c+12A6E6PZ11KZ2/naBpN2Y7uoUc/CKoLKF9YW2fwCDtfDa2kvQbXMf8tIQbZVeh7u5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39840400004)(66556008)(16526019)(66476007)(83380400001)(6512007)(26005)(478600001)(66946007)(186003)(6506007)(6916009)(86362001)(1076003)(6486002)(4744005)(8936002)(2906002)(5660300002)(52116002)(8676002)(2616005)(6666004)(316002)(956004)(107886003)(4326008)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: UsXcauNcIpnheQIuHoVNJicpO5U7zJjmURCWwmzMpp8GlLpeJCRm7vowsEIYbY4WfvbeYVMor7X6rBndahKo2pY7sBfp4JXf3wPRSkpYsiIR7tz7OrP9WaH/1l5GCNVtANflsdQOan2A16HXNRzcTStLPDoaSyeUDY6hmTjAMDVqfcJRaPY1f24+YPsOSiaKRtTIdsTQjyispFtJ+gxBgP55dJxXfBn6vzkAGNsvNT01FezPmQdIiHPobytVaAK6VHfdeaU4aSO3dQTGyiq1gAkavFym7QvLA95KIPu022m9FvGFwkAvQgZorpRtAqWhXiZTGsgXeSloRfw9ec5tIpcaez3Gn2KBCCOWCGSMb8Lx5AGhqalZZnJdmrxyHYLfLdN3mh4sfS3O6HmEz3c0BzygYjHlPGeftI7TR6KwLQE6um7KpDL770RQwRIJ1esmUX/Kw2icq7PvFhWWUgXOvERnijcTuRcNNWoHW5hVe5GRt3aH8GHwPvw6/7TTFfTlZe0pW/IQIVHAgQRvZismXs8rfdTz7QiV4ii4S2lSOm5UhYP7Zl8aD6aCSsRbSM4wDU8LLrlHIyhgCaqqLGuBac+wVUQ8j5Ir5Dqxhm3yTwXrL3Nf3xjlTMs92pki0ii0WXp9Mjhpf3EIUCY4pVWvJQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a57862-af3e-48e9-3993-08d875d1e469
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:59:21.4825 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XeqKvNLZm6+xOpQsmIhQ/VQmIMnUMtX08LeXYFiTiIKRFZtpsVhhWyW9Z9MJXlxJdykWv235N3wK8209DYGCgvrKVowBIseJ8j+9xr2qvUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4472
Received-SPF: pass client-ip=40.107.20.117;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 10:59:20
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index f212cec446..0e3d1d0ba3 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -205,7 +205,12 @@ def qemu_io_log(*args):
 
 def qemu_io_silent(*args):
     '''Run qemu-io and return the exit code, suppressing stdout'''
-    args = qemu_io_args + list(args)
+    if '-f' in args or '--image-opts' in args:
+        default_args = qemu_io_args_no_fmt
+    else:
+        default_args = qemu_io_args
+
+    args = default_args + list(args)
     exitcode = subprocess.call(args, stdout=open('/dev/null', 'w'))
     if exitcode < 0:
         sys.stderr.write('qemu-io received signal %i: %s\n' %
-- 
2.21.3


