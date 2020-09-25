Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11970C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 08:34:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDFEE20888
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 08:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="q/FPXJNs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDFEE20888
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLjBM-0005Rh-QN
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 04:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLjA2-0004dF-QF; Fri, 25 Sep 2020 04:32:58 -0400
Received: from mail-eopbgr80104.outbound.protection.outlook.com
 ([40.107.8.104]:27495 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLj9z-0002uh-Rc; Fri, 25 Sep 2020 04:32:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQ6UrwJkuY/zHsXoZPn+iieYE7Bund4PQdT7W/asElPmjY+3z4I+TeGGzAnrpOh2b9ZXVI7VUN1mcJxX2o4G4VX7DlsQemZyX7lVVXWh8tIkNsXDVEvJAtHmu7C1VgdLeWrC/7CZBosQichevm0RfnI6fQgcyTApoomCZc1CvH7xDAIK+HhJV+i03e62xZz/g1Jq9CsubR8hF2Yu0DTAOCzXJaPsc0Q6XpyFC322jpzg6ZSftyywsREjCKRiNVXPn69VioXey4jas04DBPqjSBBe+cnANNjye1CJ2V9B8g0895thVxBsyhqeRuX4ICazkT/DxGe0qA7IbUOYx7To3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jX4eQbe6FiREfNGi2H2IkuREZNQofxAklPBL+H87kKs=;
 b=O/uyYnUilRZgFbyzGZckhdq7hkJWTu5FDaQyCJaH0/a6z0CSKjH+w5Ez74Q7d8WbmKAaatzzSS6R1Zpni10kDKfwvpIko+faaQhbpqOS6/NKD9clvUdgBu5KE8gGDJkOn4NkDvRY1+QcrNGFRIEFlf7oQa1nY73uvj6ZtZ73q/Zdb+pFvj2BwU0sSEws1JWeH8Ey8Xd7Q4UNzAKTrQqfddGZdmx5ytS24DIMECR9DCHar1QPEWLnxVC80f2IzxgMbb+pM5I5YJqmfIg5N65GRl192KOCkueYq9r9eymKaYR97li0TCM4GCT7bLGZRDf5+AwcUsBICqjkn/I6leoDSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jX4eQbe6FiREfNGi2H2IkuREZNQofxAklPBL+H87kKs=;
 b=q/FPXJNsIqoKDn2oIKlnGn8cI3ynilkLeRvZUcRC7OEJaBNAa2+M5zzL+5pwYsK6oVHUvBOzD63JfS4dXjFDrpZVT/4lP47TsMWGmeG6eopx6tqG4WU8wen1eMmaweGfZfqvh06f0ba7hWbU+4dGYoF/8hOr1llbH4AQSBqmpgQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5493.eurprd08.prod.outlook.com (2603:10a6:20b:102::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Fri, 25 Sep
 2020 08:32:51 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.033; Fri, 25 Sep 2020
 08:32:51 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, crosa@redhat.com, ehabkost@redhat.com,
 fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com,
 den@openvz.org, vsementsov@virtuozzo.com, eblake@redhat.com
Subject: [PATCH 0.5/7] include/block/block.h: drop non-ascii quotation mark
Date: Fri, 25 Sep 2020 11:32:29 +0300
Message-Id: <20200925083229.2528-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200924185414.28642-1-vsementsov@virtuozzo.com>
References: <20200924185414.28642-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.94) by
 FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.13 via Frontend Transport; Fri, 25 Sep 2020 08:32:50 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.94]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43ffdd21-35fc-4040-c0bd-08d8612d96fb
X-MS-TrafficTypeDiagnostic: AM7PR08MB5493:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54939BE513F3EA67C88D0567C1360@AM7PR08MB5493.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R7LV3x0/GkbZcdUAtoQwMRbp7X0BJzRtW1IbTNjsUtkL3z/VnIXIFa4ToY2BgnIWOcIZKMxBjb85yX2zdz9F5NG+oZyMIz5CgLCAb/xBnZg7oE9p0GdxruLqwyXhK5Zbm2h6hw3rIMtUG3XR3iCsSBfFOSTHf0mLDEDJ7y3+RsGXzyrCLFlfxWqHhgUJDz9+4xAYKOwY+sVbjD2m93q/Zckq+49xY2LeS3oD+RoOrutCXePf3rGtduawyFz4URZz9xPxjjkA76fjqXYwZq9VQshPw49Q8sUtPjdtwCLaPnv23QxritLUOM32C/lkbXaXWJMk5aF8twJ6iyMSXCyL4WJZla1nBJxgXuQhUzWyKG84sNKfum7advuhWHXHh/9m
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(366004)(136003)(346002)(396003)(376002)(16526019)(26005)(6666004)(6512007)(1076003)(4326008)(6486002)(2906002)(66476007)(66556008)(478600001)(4744005)(83380400001)(36756003)(66946007)(2616005)(86362001)(8936002)(52116002)(316002)(8676002)(5660300002)(6506007)(6916009)(956004)(186003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: MMXpDwa65pLmi1z1VrGEQu42a3/x/1Jek33PDEEqPw9YkHDbbFQ2ErDUeIWfAO6lMP9S8ahrGuRLtSFaTUBskv9co0k5ztAJSmQlCx0KH0p8xEQjoXpP7/5iYxarQrAU4utzHN8jX0iftnCYN+xy0kMlWXy7Ok/o2jk4I4614kfJ0/J96ZuNZJ1mypSW3R2+WpeO4P6oWG8cYAJjNxxiTqp2s9NgyH+kcsWcHVFkmpkfG61xBw9FSqpXADfUGS0Aff4vwFXNAhYNiDeic6siq9zkzldiH2snBi9X8JwNU/aJg/Ebk5cDL0QvXcBOGOuyQXSGEe/BhX9IQlLbTMVNaHUnlhhQZofux2LBdRRZeITolt86riU7zqb40SoKylxOWwRGleezkDZwIIG8nT8eGQz8/t+O97zKwGrF02OHzL/SHClrSNUk8z/N2FGd+zqhwtVrRLDAgL/ovwS2XbhehT/Zq8s8AY+ZjvmGAkopQckswr1J5ihVIQ/07pN7jar6F/UfsN3LhKg91pTAjOsiXk8RLrk/PICnPShAr9GvxN6TAmpKStLbhrsqsysJikS1juMEx8UL+bvKS73O6oi87Yo/+OqznoKXvi8stJpgOOg9AH30tJNG9hPRyKXRE+zuat08dcMy36wOg3OR3ufdEQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ffdd21-35fc-4040-c0bd-08d8612d96fb
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 08:32:50.9181 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qpOASVNRh4i8P2R1arnf8okoghRqHochWe+dvwu6f75fIpuazZjN1uZiqleWqCsQxj2Ew4SMZlWuNqvYLHHaquEJOphg4swh7Y24iICVn7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5493
Received-SPF: pass client-ip=40.107.8.104;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 04:32:52
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

This is the only non-ascii character in the file and it doesn't really
needed here. Let's use normal "'" symbol for consistency with the rest
11 occurrences of "'" in the file.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/block/block.h b/include/block/block.h
index 8b87df69a1..ce2ac39299 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -304,7 +304,7 @@ enum BdrvChildRoleBits {
     BDRV_CHILD_FILTERED     = (1 << 2),
 
     /*
-     * Child from which to read all data that isn’t allocated in the
+     * Child from which to read all data that isn't allocated in the
      * parent (i.e., the backing child); such data is copied to the
      * parent through COW (and optionally COR).
      * This field is mutually exclusive with DATA, METADATA, and
-- 
2.21.3


