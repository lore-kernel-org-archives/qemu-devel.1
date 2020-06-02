Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2689C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 19:27:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 908E7206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 19:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="aBGfPQqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908E7206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgCZ1-0002mT-NP
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 15:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgCY2-0001dR-2j; Tue, 02 Jun 2020 15:26:06 -0400
Received: from mail-eopbgr130137.outbound.protection.outlook.com
 ([40.107.13.137]:21663 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgCXy-0004jn-Hl; Tue, 02 Jun 2020 15:26:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVgx8xT7/iupSMceioOieootSCLRuegN2cI6uG/W06KSLXfCuNBPu/dRguC/pliG8SJZ+joaKxNkt/mYQbjwjTNI73Tbod9cBCco+IriYEAOtsAzQpO7Av8x7CviLP577DCdg7zA+VUtVqTgRnb+4JRY42aXV/QGbvA0tDMxNzufjaOK7V/Xl1U0shClW/1w+LnN+I44IwEauI4tLNu5Gem0QS0P+Qkne/9/xDxbPUAUV5lsE0mmeDFFAtIFYRrn4DMCDT5lUgBtQkCOips2+jgf4LmyLIzUUUO+yrrc9nqo0Plji1HQO7hKigrgXdN7wmdn9dM6MKFNRclYfiSaHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZeBI73HyJKKUYZfMELE4IHGkMR77Euc3gQUGE/roiJ8=;
 b=TPbLrOXeUj2XtLeb+BwRZDamHriM5Mt/GnEK9MJz/SncdFy8tbFpiJaZ3BxYQJ897Uu9si/5CQYNDd0T1TNmy562Z6XB5Icb4Pob6sXoA2tMELqARJhkw+WMatBrXPOEHVxHJvWqzQWGAE4ujxBf3l2VrSph6Jqpk3af+9+ssCBXiZufJPnzbmU2hn9kstPBBWJ+F2VerBc3gkeJ+SAdeV3+7DX78Wf7VKP01T/PYg2gZcbk+++paipLbuGJBIqZAy0+C1zq9r6C5YXy+OEWxKGKko3E1h3GgwcvWdpuuBEdNlW8mhyt3z5eeeEOLnH9I6LsZrGoZ7uoOohhNGpnGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZeBI73HyJKKUYZfMELE4IHGkMR77Euc3gQUGE/roiJ8=;
 b=aBGfPQqTbgX1pdaNCOZM8+xwRvUWO6x6zefwsOXEeRxqy4fZrOne8dtdROctN4TtVL2skaKXoKNRRoz5hNPVWMQVVp2p8kYQUcyKQ5u3C2b7mu9SWkVsnMYy7S2q/jzRiAczsITNa53svoDdYgX12q/1SK6eqvpDL21zMaMxjAI=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5349.eurprd08.prod.outlook.com (2603:10a6:20b:107::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Tue, 2 Jun
 2020 19:25:57 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 19:25:57 +0000
Subject: Re: [PATCH v3 1/6] iotests: Add extension names to qcow2.py dump
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1591019293-211155-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1591019293-211155-2-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <7e9e706b-06ff-b444-1c1a-b7873a13f4c7@virtuozzo.com>
Date: Tue, 2 Jun 2020 22:25:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <1591019293-211155-2-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0006.eurprd04.prod.outlook.com
 (2603:10a6:208:122::19) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.153) by
 AM0PR04CA0006.eurprd04.prod.outlook.com (2603:10a6:208:122::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Tue, 2 Jun 2020 19:25:56 +0000
X-Originating-IP: [185.215.60.153]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3190200a-be3a-4643-c747-08d8072ac67c
X-MS-TrafficTypeDiagnostic: AM7PR08MB5349:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5349D72E58621C9D6FED52C3C18B0@AM7PR08MB5349.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-Forefront-PRVS: 0422860ED4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fzvchUMHjyraEfQ2zJ1kQbkdsKjeVCCSZCvUoMAIDUfj2dgPYZRBdmB36G7crxTnhhiUcJglFeQsOYOSRIYCR2HOqfdWuaK0mRV51h4Fb4tsG+jbge0P/IOIreEsE1A76Eph/wLZ2aJL0shBnYm/W6uCg5b7nRJajgd9b52YQLfxoCLayYk+NIr940qrg1J/aeeCTCuG1i2fnssrmpyGuFQkaW/rYM2jwLnW/VySw//WKKIT/xc3LVT/kOiSsUmRDVBestTELEjoKX+WzVd7caybGqvb6B44IfdKiuh0AoPAG5ayJsC5N+bfrHEkLn7skO0BVs8tBHh8kqE+HAiLYVLAXIi7suwyV6DmcmQMtBAnnpop6uv8q1TkptvA6Jl2f61hDmgmQsUiL69+MuXa4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(346002)(366004)(396003)(376002)(136003)(5660300002)(36756003)(52116002)(8936002)(86362001)(16526019)(66476007)(186003)(26005)(956004)(66946007)(66556008)(31696002)(8676002)(2616005)(31686004)(478600001)(2906002)(83380400001)(316002)(6486002)(4326008)(107886003)(16576012)(21314003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: I80EwCrfmvfYDlspUdVPbI/rd6VhPgaPRH6GCJ0l8k9QiRgPW51ku5c/eWL8v9rUPs88MNOm2r/DpWc8ccmpT9JZ5vw4ga/vPu0A1/G/uW7L9NKZTLoUplwZF/a6DAUNkeAQ2brNDUIuHTTmDvE6kGwu++5IxcTE7YZRABU4gcGvLffboYQ6qSPv9yUAjTE98wgQUrlhJYjxzNH1o6xXxQJ1mRvNDKUruyTEtUAaqDn2n1T2i2KWvZOkqxcphuU4HJ/jPrLqShOUYhaN0SYgqMvqabzOWgxyArJE16ILbgUjJdiTgoNMHU6MN/jfHF0G99EsLqb5FgoJ+rTTxP33GozpdoFngnxAIu9bx4ONELPLuUjYtZU90YexGHbmvHP+oBpJn7AO9HDP6Bzzu+pMpZpUBhLCcCnriJEqaiKch/hTReAVMBeG80D+aFKcPGDGN9+WIYQ5/0IjsS8/7S5fb7+c8ekU3DuSTsIITP0xyPQJ44VbxnxxvM6OxLA/hRgC
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3190200a-be3a-4643-c747-08d8072ac67c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2020 19:25:57.5128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2GCEwFBxLdtnqm1pz/0A5WaiIpRFgnqVfWNbCfNSp0OWVxjcSEBYqezTiCFuhznQNshl/LlP5M8PO5Hte3xT+HwkU5JM9YB5Dlvvspd5r2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5349
Received-SPF: pass client-ip=40.107.13.137;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 15:25:58
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

01.06.2020 16:48, Andrey Shinkevich wrote:
> Header extension:         Feature table
> magic                     0x6803f857
> length                    192
> data                      <binary>
> 
> The change incurs modification of the output in 031, 036 and 061 test
> cases.
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   tests/qemu-iotests/031.out  | 22 +++++++++++-----------
>   tests/qemu-iotests/036.out  |  4 ++--
>   tests/qemu-iotests/061.out  | 18 +++++++++---------
>   tests/qemu-iotests/qcow2.py | 23 ++++++++++++++++++++---
>   4 files changed, 42 insertions(+), 25 deletions(-)
> 
> diff --git a/tests/qemu-iotests/031.out b/tests/qemu-iotests/031.out
> index 5a4beda..966c8d9 100644
> --- a/tests/qemu-iotests/031.out
> +++ b/tests/qemu-iotests/031.out
> @@ -24,7 +24,7 @@ autoclear_features        []
>   refcount_order            4
>   header_length             72
>   
> -Header extension:
> +Header extension:         Unknown
>   magic                     0x12345678
>   length                    31
>   data                      'This is a test header extension'
> @@ -52,7 +52,7 @@ autoclear_features        []
>   refcount_order            4
>   header_length             72
>   
> -Header extension:
> +Header extension:         Unknown
>   magic                     0x12345678
>   length                    31
>   data                      'This is a test header extension'
> @@ -80,12 +80,12 @@ autoclear_features        []
>   refcount_order            4
>   header_length             72
>   
> -Header extension:
> +Header extension:         Backing format
>   magic                     0xe2792aca
>   length                    11
>   data                      'host_device'
>   
> -Header extension:
> +Header extension:         Unknown
>   magic                     0x12345678
>   length                    31
>   data                      'This is a test header extension'
> @@ -115,12 +115,12 @@ autoclear_features        []
>   refcount_order            4
>   header_length             112
>   
> -Header extension:
> +Header extension:         Feature table
>   magic                     0x6803f857
>   length                    336
>   data                      <binary>
>   
> -Header extension:
> +Header extension:         Unknown
>   magic                     0x12345678
>   length                    31
>   data                      'This is a test header extension'
> @@ -148,12 +148,12 @@ autoclear_features        []
>   refcount_order            4
>   header_length             112
>   
> -Header extension:
> +Header extension:         Feature table
>   magic                     0x6803f857
>   length                    336
>   data                      <binary>
>   
> -Header extension:
> +Header extension:         Unknown
>   magic                     0x12345678
>   length                    31
>   data                      'This is a test header extension'
> @@ -181,17 +181,17 @@ autoclear_features        []
>   refcount_order            4
>   header_length             112
>   
> -Header extension:
> +Header extension:         Backing format
>   magic                     0xe2792aca
>   length                    11
>   data                      'host_device'
>   
> -Header extension:
> +Header extension:         Feature table
>   magic                     0x6803f857
>   length                    336
>   data                      <binary>
>   
> -Header extension:
> +Header extension:         Unknown
>   magic                     0x12345678
>   length                    31
>   data                      'This is a test header extension'
> diff --git a/tests/qemu-iotests/036.out b/tests/qemu-iotests/036.out
> index e409acf..81a7366 100644
> --- a/tests/qemu-iotests/036.out
> +++ b/tests/qemu-iotests/036.out
> @@ -24,7 +24,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
>   incompatible_features     []
>   compatible_features       []
>   autoclear_features        [63]
> -Header extension:
> +Header extension:         Feature table
>   magic                     0x6803f857
>   length                    336
>   data                      <binary>
> @@ -36,7 +36,7 @@ No errors were found on the image.
>   incompatible_features     []
>   compatible_features       []
>   autoclear_features        []
> -Header extension:
> +Header extension:         Feature table
>   magic                     0x6803f857
>   length                    336
>   data                      <binary>
> diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
> index a51ad1b..7821b7f 100644
> --- a/tests/qemu-iotests/061.out
> +++ b/tests/qemu-iotests/061.out
> @@ -24,7 +24,7 @@ autoclear_features        []
>   refcount_order            4
>   header_length             112
>   
> -Header extension:
> +Header extension:         Feature table
>   magic                     0x6803f857
>   length                    336
>   data                      <binary>
> @@ -82,7 +82,7 @@ autoclear_features        []
>   refcount_order            4
>   header_length             112
>   
> -Header extension:
> +Header extension:         Feature table
>   magic                     0x6803f857
>   length                    336
>   data                      <binary>
> @@ -138,7 +138,7 @@ autoclear_features        []
>   refcount_order            4
>   header_length             112
>   
> -Header extension:
> +Header extension:         Feature table
>   magic                     0x6803f857
>   length                    336
>   data                      <binary>
> @@ -193,7 +193,7 @@ autoclear_features        [42]
>   refcount_order            4
>   header_length             112
>   
> -Header extension:
> +Header extension:         Feature table
>   magic                     0x6803f857
>   length                    336
>   data                      <binary>
> @@ -262,7 +262,7 @@ autoclear_features        []
>   refcount_order            4
>   header_length             112
>   
> -Header extension:
> +Header extension:         Feature table
>   magic                     0x6803f857
>   length                    336
>   data                      <binary>
> @@ -324,7 +324,7 @@ autoclear_features        []
>   refcount_order            4
>   header_length             112
>   
> -Header extension:
> +Header extension:         Feature table
>   magic                     0x6803f857
>   length                    336
>   data                      <binary>
> @@ -353,7 +353,7 @@ autoclear_features        []
>   refcount_order            4
>   header_length             112
>   
> -Header extension:
> +Header extension:         Feature table
>   magic                     0x6803f857
>   length                    336
>   data                      <binary>
> @@ -491,7 +491,7 @@ wrote 65536/65536 bytes at offset 2147483648
>   64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   wrote 65536/65536 bytes at offset 3221225472
>   64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -    (0.00/100%)
>      (12.50/100%)
>      (25.00/100%)
>      (37.50/100%)
>      (50.00/100%)
>      (62.50/100%)
>      (75.00/100%)
>      (87.50/100%)
>      (100.00/100%)
>      (100.00/100%)
> +    (0.00/100%)    (12.50/100%)    (25.00/100%)    (37.50/100%)    (50.00/100%)    (62.50/100%)    (75.00/100%)    (87.50/100%)    (100.00/100%)    (100.00/100%)
>   No errors were found on the image.
>   
>   === Testing progress report with snapshot ===
> @@ -506,7 +506,7 @@ wrote 65536/65536 bytes at offset 2147483648
>   64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   wrote 65536/65536 bytes at offset 3221225472
>   64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -    (0.00/100%)
>      (6.25/100%)
>      (12.50/100%)
>      (18.75/100%)
>      (25.00/100%)
>      (31.25/100%)
>      (37.50/100%)
>      (43.75/100%)
>      (50.00/100%)
>      (56.25/100%)
>      (62.50/100%)
>      (68.75/100%)
>      (75.00/100%)
>      (81.25/100%)
>      (87.50/100%)
>      (93.75/100%)
>      (100.00/100%)
>      (100.00/100%)
> +    (0.00/100%)    (6.25/100%)    (12.50/100%)    (18.75/100%)    (25.00/100%)    (31.25/100%)    (37.50/100%)    (43.75/100%)    (50.00/100%)    (56.25/100%)    (62.50/100%)    (68.75/100%)    (75.00/100%)    (81.25/100%)    (87.50/100%)    (93.75/100%)    (100.00/100%)    (100.00/100%)
>   No errors were found on the image.
>   
>   === Testing version downgrade with external data file ===

^^^ these two chunks are some mistake, I even can't apply the patch with them. And with them dropped, tests pass for me. [*]

> diff --git a/tests/qemu-iotests/qcow2.py b/tests/qemu-iotests/qcow2.py
> index 94a07b2..e824b09 100755
> --- a/tests/qemu-iotests/qcow2.py
> +++ b/tests/qemu-iotests/qcow2.py
> @@ -6,19 +6,36 @@ import string
>   

while being here, may add one more newline for PEP8

>   class QcowHeaderExtension:
>   
> +    QCOW2_EXT_MAGIC_BACKING_FORMAT = 0xE2792ACA
> +    QCOW2_EXT_MAGIC_FEATURE_TABLE = 0x6803f857
> +    QCOW2_EXT_MAGIC_CRYPTO_HEADER = 0x0537be77
> +    QCOW2_EXT_MAGIC_BITMAPS = 0x23852875
> +    QCOW2_EXT_MAGIC_DATA_FILE = 0x44415441
> +
>       def __init__(self, magic, length, data):
>           if length % 8 != 0:
>               padding = 8 - (length % 8)
>               data += b"\0" * padding
>   
> -        self.magic  = magic
> +        self.magic = magic
>           self.length = length
> -        self.data   = data
> +        self.data = data
> +        self.name = self.extension_name(magic)
>   
>       @classmethod
>       def create(cls, magic, data):
>           return QcowHeaderExtension(magic, len(data), data)
>   
> +    def extension_name(self, magic):

let this be classmethod

> +        return {
> +            self.QCOW2_EXT_MAGIC_BACKING_FORMAT: 'Backing format',
> +            self.QCOW2_EXT_MAGIC_FEATURE_TABLE: 'Feature table',
> +            self.QCOW2_EXT_MAGIC_CRYPTO_HEADER: 'Crypto header',
> +            self.QCOW2_EXT_MAGIC_BITMAPS: 'Bitmaps',
> +            self.QCOW2_EXT_MAGIC_DATA_FILE: 'Data file',
> +        }.get(magic, 'Unknown')
> +
> +
>   class QcowHeader:
>   
>       uint32_t = 'I'
> @@ -151,7 +168,7 @@ class QcowHeader:
>               else:
>                   data = "<binary>"
>   
> -            print("Header extension:")
> +            print("%-25s %s" % ("Header extension:", ex.name))
>               print("%-25s %#x" % ("magic", ex.magic))
>               print("%-25s %d" % ("length", ex.length))
>               print("%-25s %s" % ("data", data))
> 


With dropped two strange [*] hunks, and with (or without) the following diff additionally applied:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Tested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


recommended additional change:

--- a/tests/qemu-iotests/qcow2.py
+++ b/tests/qemu-iotests/qcow2.py
@@ -4,6 +4,7 @@ import sys
  import struct
  import string
  
+
  class QcowHeaderExtension:
  
      QCOW2_EXT_MAGIC_BACKING_FORMAT = 0xE2792ACA
@@ -26,13 +27,14 @@ class QcowHeaderExtension:
      def create(cls, magic, data):
          return QcowHeaderExtension(magic, len(data), data)
  
-    def extension_name(self, magic):
+    @classmethod
+    def extension_name(cls, magic):
          return {
-            self.QCOW2_EXT_MAGIC_BACKING_FORMAT: 'Backing format',
-            self.QCOW2_EXT_MAGIC_FEATURE_TABLE: 'Feature table',
-            self.QCOW2_EXT_MAGIC_CRYPTO_HEADER: 'Crypto header',
-            self.QCOW2_EXT_MAGIC_BITMAPS: 'Bitmaps',
-            self.QCOW2_EXT_MAGIC_DATA_FILE: 'Data file',
+            cls.QCOW2_EXT_MAGIC_BACKING_FORMAT: 'Backing format',
+            cls.QCOW2_EXT_MAGIC_FEATURE_TABLE: 'Feature table',
+            cls.QCOW2_EXT_MAGIC_CRYPTO_HEADER: 'Crypto header',
+            cls.QCOW2_EXT_MAGIC_BITMAPS: 'Bitmaps',
+            cls.QCOW2_EXT_MAGIC_DATA_FILE: 'Data file',
          }.get(magic, 'Unknown')
  
  




-- 
Best regards,
Vladimir

