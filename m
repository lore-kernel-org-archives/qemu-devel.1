Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FEEC433E1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:16:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 071FB2068D
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="c0hOJmHq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 071FB2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfozW-00039P-9M
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 14:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jfoub-0005Ch-UA; Mon, 01 Jun 2020 14:11:49 -0400
Received: from mail-eopbgr70117.outbound.protection.outlook.com
 ([40.107.7.117]:10211 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jfoua-00027N-Vj; Mon, 01 Jun 2020 14:11:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HtF02i3DTLkYhaqC4/mlY5xoctweB4sluvZzjP6lZbw6kv2L1OXa2T2mr5DQuiOUEMIgOnJ6DmhtADVUT2zaxjqatJ9grqhvkMsufmm9+0pYiGYulzqZHUFG5i85ikyuRV7xTbzPgteLxXbz0QnpJ7Qoy4d5i9DnIlma1pVB0UmoTMky02QB2moLxE7864cgMZXO/ckx6TQede12Fv/YKcS9bYzZo44by3axml5e7MuR0Ph88itVdVqkcRy/EGqL6knwcJ7eoqNG8KndnwLY2G60aWLNSMsEwMaIucSQ1goLq4TK7eiupGWRIkglefoMtRzfhQQg0GTCD5p+zpNquA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBfmbhmk/W92+2NFh6AEO3VnEZYVU6jp2wHuwN3JFeQ=;
 b=EnwnPjlGRoJdtLyLbtOPZFt19nogGYL+kJ2pVX3hJmPkpl786SV7KKKis4DAVIRQUOWS/HzL56BxtoYjfh8nTRiclG7wwidHvGUUeOkg17GneZLQGF5tiWhVd+9zgLKzV5XkLEV8xoN1hkTVbEl5/FiYGcEyZ5UPmL3WiTI6nFllLwHCVRwH860vLagVX9SdgBco/+JE8ifg1LFyNSpst0OnN7YE4JmTxHJczo/htw+ssEph/edQCZ/edlJxVpUWW/ME6+V+0zokeVTJNGeKBcUSyT+6RNHn4Mhs4+eNt07DtgRy92TdgIB+LtfjIYMgrcsQqKwcD4aJd97mSPLB6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBfmbhmk/W92+2NFh6AEO3VnEZYVU6jp2wHuwN3JFeQ=;
 b=c0hOJmHqQz5Beek7fPoZrSn82q8knIknPVqexMmOsI/4C6BL5xG6mgy+MrvMucX4WzNmYXUcx8NBxbTzarKfXu4aGGyHw6REIEAgn32LIRntkbLxKZ3JFFPx6fL8r/IP9pkWRQlXK3hn8EJK+QP/pTV8kLBq8ifjZ4knCV8pb0E=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5317.eurprd08.prod.outlook.com (2603:10a6:20b:101::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Mon, 1 Jun
 2020 18:11:41 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 18:11:41 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 12/20] iotests: 56: prepare for backup over block-copy
Date: Mon,  1 Jun 2020 21:11:10 +0300
Message-Id: <20200601181118.579-13-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200601181118.579-1-vsementsov@virtuozzo.com>
References: <20200601181118.579-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::38) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.170) by
 AM0P190CA0028.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.18 via Frontend Transport; Mon, 1 Jun 2020 18:11:41 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.170]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0d08185-a529-4c15-19dc-08d806573c59
X-MS-TrafficTypeDiagnostic: AM7PR08MB5317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5317F3483F5A4CEBFF708E01C18A0@AM7PR08MB5317.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NtbfqwliqLp8+2z5ac5ppInbXmM14Cs5gyPZPLn8TL1q+zg25mVZs4GGwsb7ZuHO5+U0s3fZme6D1R81nAHKLR7aE/TS0BlZFrlzT+exPGq84s12862QaoVuo2bpFEZDEIqWcYgnYOshcCAhcZ+1hBxMOE025qcozcQG0XC82WUNDzsteGvCrOnSi9v1RDFVKBTgDxBu93Xrf5EbVpd8+gtSXl+BRoaMT/TdciCAVdSqewtB9+Manwduj+rI+jbVxHdS9nwUiFDw1kADenbgkq2MRxDX+c8/vh6JO995OJrZ27Ns293JosYbVSjP9i9K1nup3RiHuD5H5KDjzgZevG9/NYaB+fuey3fYmhbwr0Xpake5Is9G7bLyTYmrGzfg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(39840400004)(346002)(366004)(186003)(16526019)(8936002)(2906002)(8676002)(26005)(107886003)(36756003)(316002)(6916009)(52116002)(2616005)(956004)(478600001)(4326008)(86362001)(6486002)(66946007)(66476007)(66556008)(6512007)(6666004)(1076003)(69590400007)(5660300002)(83380400001)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: /QGWQ4bRFzDgcp/iTLWpmssjk2brAMxMgJgFaw9aynWn9MGfsPJtkuHIACFdimF5Oy43NCaqm0ulaeMboEmENRSTYIBTf/QwyasvPDyHsakWVMk64JELHD1yogdHPf6FFKIyX3C8BnMYzByP1cElh/6O4QiS4u/9Z4OQw2zV8LB98GvWO1smizZN0OXWroaBeg1vuPlYgCXRDsKMsfShyBQYzj5LJ5Tc/mIOuQzVvK5FrIIUCTCsz/tVwN+dV9ZPky8lR7qsZKIf2SAXvyMwhW9Stw4a6g6IR4bvjcSPo1h3RcT+r6d+zE412vpdfCx0tCwzdtwcdN89LfGE/wLqOzEWoJskmgwGULO/JF6A8YR5XuVr+Oy0JQmLp/AaG7EQTKdkOdI7OTgDH+33gyjQTkUySieA/Ajj7xl/Btx2HdgXbNaGDyACxhsc3tV/Fu/uKev6zf3x1SAb6h9AqaduCewQDqCKqpDyQY+bWY01WRo=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d08185-a529-4c15-19dc-08d806573c59
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 18:11:41.8384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hbze60JTLb5HpZH3G+xcRHhmL5RiHTtiQYF8DRsyMCwj331L3eNTlqdqeiJ9mVDzJ3KgHSCMjTMVql0KcswAMbz8WwfKVPkpdEOhOcT8fe4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5317
Received-SPF: pass client-ip=40.107.7.117;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 14:11:40
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 wencongyang2@huawei.com, xiechanglong.d@gmail.com, armbru@redhat.com,
 mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After introducing parallel async copy requests instead of plain
cluster-by-cluster copying loop, we'll have to wait for paused status,
as we need to wait for several parallel request. So, let's gently wait
instead of just asserting that job already paused.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/056 | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/056 b/tests/qemu-iotests/056
index f73fc74457..2ced356a43 100755
--- a/tests/qemu-iotests/056
+++ b/tests/qemu-iotests/056
@@ -306,8 +306,12 @@ class BackupTest(iotests.QMPTestCase):
         event = self.vm.event_wait(name="BLOCK_JOB_ERROR",
                                    match={'data': {'device': 'drive0'}})
         self.assertNotEqual(event, None)
-        # OK, job should be wedged
-        res = self.vm.qmp('query-block-jobs')
+        # OK, job should pause, but it can't do it immediately, as it can't
+        # cancel other parallel requests (which didn't fail)
+        while True:
+            res = self.vm.qmp('query-block-jobs')
+            if res['return'][0]['status'] == 'paused':
+                break
         self.assert_qmp(res, 'return[0]/status', 'paused')
         res = self.vm.qmp('block-job-dismiss', id='drive0')
         self.assert_qmp(res, 'error/desc',
-- 
2.21.0


