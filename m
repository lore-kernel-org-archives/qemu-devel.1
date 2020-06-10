Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5912C433E4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 12:23:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8006B20734
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 12:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="lFWvKAcx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8006B20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jizli-0007P5-Pq
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 08:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jizTL-00007T-Jm; Wed, 10 Jun 2020 08:04:47 -0400
Received: from mail-eopbgr150135.outbound.protection.outlook.com
 ([40.107.15.135]:4365 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jizTI-0004Tg-Jv; Wed, 10 Jun 2020 08:04:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUnSrccCRQorbZZkL0EjGK4imxhoXr87yJmrsx3dKBgV2a0o4PUHA/TwZDRE2lPihyg9cQ43lyWf9+J1QZLd9X0B0MSKAI4uvvupmAleWM2HSypk1rZS9X16pCHkE6RxdXWsk8HB27g90xYYLKW1y5unBNzR7o2L8XSUs/9rdsCPXdnh5we3nPiIu7EK/c0udcg/kf39qeUx0YqJR/SgeNtWt3SvSlLKiV58R+IwSVhnX+pmN421fJgUIRvp6zTsOA1F0b8JOndAVRrCB8rpjQuIOXt6L1Zv2xjFpfEQAxxJ+iG9JDoUc3reYbm6xKVBCbwnLO+G6wSJtq08JyTrQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hJZJo4pyq1uF/65B6/G3TBaxyvo62zB9s2QAVVNKvo=;
 b=cVKJ9dzkmeYvZWrdI+tYfHoS7DV4zHyR962Im6ZXrcwjoId4A+9G9raOPrvo0vAhiADsTsYQvjxdYZOrWpp/JN4lhwgWqZNq14rUv0VnWbFZcuU0SWaAjfH04Fn4pf/DD4HK8isoPhihaJGf5QB34R6oImkjMndGA3z8gnbStjCmZ0UoAoobyFEflZU0HwVVoM36ZKyC8eVtTCSqmIUhlO17cpJvsacDwADlzCrq6hG3PRUjc5DRv+++LoAGAjd1x+sb7UYLlH1Ft3CBfaNvH2kfvUscqBaFKPP/Opzhux/6M2dfm94XWhWV6LbXUiCK6H5EUpd7RvTOBIa8iIlMCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hJZJo4pyq1uF/65B6/G3TBaxyvo62zB9s2QAVVNKvo=;
 b=lFWvKAcxfHSMFcvBUe1pmOd5cvZj+dscBswHGy+IcA3CilQNJDoPQptdQY6XXmItHPHl9mlAJZP9O7ziayEZTUMf47bLw+aszeLnLxPftCsAmOi9xmi/iIAx8LGzZj/PjohJfai52kCb7HtDHDK4xi8GtgoY/g9OV6rAXneLN7Q=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5495.eurprd08.prod.outlook.com (2603:10a6:20b:104::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 10 Jun
 2020 12:04:41 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 12:04:41 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 0/5] fix & merge block_status_above and is_allocated_above
Date: Wed, 10 Jun 2020 15:04:21 +0300
Message-Id: <20200610120426.12826-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR05CA0104.eurprd05.prod.outlook.com
 (2603:10a6:207:1::30) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.166) by
 AM3PR05CA0104.eurprd05.prod.outlook.com (2603:10a6:207:1::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18 via Frontend Transport; Wed, 10 Jun 2020 12:04:40 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.166]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 164b4cd7-76e8-4b5e-e640-08d80d3674d0
X-MS-TrafficTypeDiagnostic: AM7PR08MB5495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54956110BA6D50675EB72D6FC1830@AM7PR08MB5495.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yWNIuLZCnMLpz1KvSiBckJiikSw3kxZsEQg4cgARkWPCnvBvC7b/hl0mjwsd9dTJMXko7LHJ3vkv9s0FjenynHrB7j8N6ykqvHvQIW5td2k+uF3R1m4iUcW7A/VdGKPyOtMucqwKR/KCscD6FQc3f/mfX+p+6ObM9a/cDyVL10OXuH+vOfrDkhyISUw28H7CZHrCrZofGgM2MgArYBPvLdlHWwATCQx28Y6CQRajKZE1JhQqHZenBOD+kKhoVtNFxqIuJ5Kp4auPca5LxDrFgkLZuQknPn3FaTj7oXHmS0B8ibYQiifBz58WTY2OE/gHwilGU8kWDVHXW68pQMwYa17E7P3NaixaPMYZGrevFOcdz86oy8bvqBz4B2U+belDEeHL7P5W2gzA+u6/TxtRuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(346002)(396003)(39840400004)(366004)(86362001)(8676002)(478600001)(2616005)(107886003)(8936002)(4326008)(956004)(52116002)(966005)(83380400001)(1076003)(36756003)(66476007)(5660300002)(6506007)(2906002)(316002)(26005)(6666004)(66946007)(16526019)(6486002)(66556008)(6512007)(6916009)(186003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: /A1xipzVU+Zlrx76oExoYb8+v8WrmDLqYPs+FAOR9p67QmzZKNEY2gfthM6vxqaOfnwJYmoU50An6wZRdZGljiRJbpmDEU+Kdk7ozBPp7tMjQwasZrZ30cMSbrBrHLwlneK/46sEUpZX/AaTrxY+t/d+JffbMo/+ufBkWbWtzFZm40/z2Uvm6J9ySRO5CBnOSay6AG0M89jSjKhir1TKYY5HWur74PsTlEgHFD3vYXYpxo2Nl966FcuRdzlSwqldL22o5XkaxSLVzvaorDeddPVQslD0jBN463kIXH4P/dh1+eDQ1GqBTT6pwxZRc8XfdWMbcx36XkcXyHwTHLrSaSkluXP/EFFZBvJiyso0vNT8Al1d4F+WeTlRAwH9en54QHfZXJVLXTD2nw0aVzPxSND0zSir4hkMjHLvNeAdU2QicZhZUi3Em+hmZ7mTmpwNvegasr1bA1PBfYJ7VPs4H5xy9f+plo9gwXEVQme8ZKqNt2UC000XNQ3G4bYNxOP2
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 164b4cd7-76e8-4b5e-e640-08d80d3674d0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 12:04:41.4248 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DBc4NVkzpi91N5KG9PtyAvQEr6d1W49nwns4rM5VA2rb77HR1Ubzjt1a+TXDitz0JmuAmsyJuvRFpCM7DuvILyiyC5jtrlX91UUJlbRb658=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5495
Received-SPF: pass client-ip=40.107.15.135;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 08:04:42
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v5: rebase on coroutine-wrappers series, 02 changed correspondingly

Based on series "[PATCH v7 0/7] coroutines: generate wrapper code", or
in other words:
Based-on: <20200610100336.23451-1-vsementsov@virtuozzo.com>

Hi all!

These series are here to address the following problem:
block-status-above functions may consider space after EOF of
intermediate backing files as unallocated, which is wrong, as these
backing files are the reason of producing zeroes, we never go further by
backing chain after a short backing file. So, if such short-backing file
is _inside_ requested sub-chain of the backing chain, we should never
report space after its EOF as unallocated.

See patches 01,04,05 for details.

Note, that this series leaves for another day the general problem
around block-status: misuse of BDRV_BLOCK_ALLOCATED as is-fs-allocated
vs go-to-backing.
Audit for this problem is done here:
"backing chain & block status & filters"
https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg04706.html
And I'm going to prepare series to address this problem.

Also, get_block_status func have same disease, but remains unfixed here:
I want to make separate series for it, as it need some more refactoring,
which should be based on series
"[PATCH v5 0/7] coroutines: generate wrapper code"

Vladimir Sementsov-Ogievskiy (5):
  block/io: fix bdrv_co_block_status_above
  block/io: bdrv_common_block_status_above: support include_base
  block/io: bdrv_common_block_status_above: support bs == base
  block/io: fix bdrv_is_allocated_above
  iotests: add commit top->base cases to 274

 block/coroutines.h         |   2 +
 block/io.c                 | 100 ++++++++++++++++++-------------------
 block/qcow2.c              |  16 +++++-
 tests/qemu-iotests/274     |  20 ++++++++
 tests/qemu-iotests/274.out |  65 ++++++++++++++++++++++++
 5 files changed, 150 insertions(+), 53 deletions(-)

-- 
2.21.0


