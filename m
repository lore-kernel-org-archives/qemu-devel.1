Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F103C3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 11:28:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB46E20848
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 11:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="C63UGKmk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB46E20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9SCb-00034U-0w
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 06:28:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j9SBw-0002YZ-Ql
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 06:27:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j9SBv-0006YQ-O9
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 06:27:56 -0500
Received: from mail-vi1eur05on2126.outbound.protection.outlook.com
 ([40.107.21.126]:7521 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j9SBs-0006VN-C1; Wed, 04 Mar 2020 06:27:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jh+mZwVqlJoIt2K1o7bshcucLAKSrdtbX9XiKzuNAo03aDBF8d8eLxetDAidP5mI8UntSw7oL8ToVskd3wYVx0eNoaaTLsiqH7IP2c+1W0zImXKYS9kM9PwmbwFea8acqhthUPs2Nl8gYt6EtY0rq9el+qRFdPlaW3NbZlg41une8GYv7D72b+GIZlvPuV+n1FtchAW9eYksze6IYDTplNH/rNSeNTMrDAvQ09DVvPEjHJNX8hBK359gosVGPNwuNOCpfhwia3fVKXhoXc9qsxOwYsjcVJNbFxGY6q75BYEjqArmE7WpEcqpiF06DY7sKq2My9h0HTs4cz1f8FagBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEZlUnXhlxs//xUaHZD1yZ3iLbwhbfH/o4xp8tkUMrI=;
 b=YGsvu0LQ8P5mAcOOALXyM+58LLhBMgb1l2/ZhrJswrlAGtTxJaDCz/dNdSFZqjhP8y+R4eAYeDyuUx+vUUSGDzKtGPOjGsFR7kXwlz4zb068HKx8a68oOUX4Sxa3KsGRZ2/nWnDkmNPChLUovT1znXNsqOOvcW0Xw6V5hQi+Sax98BeH3d7dPGHldC++Q2WPVbM28sd5Mx4nS6Ptgc45DMo5X2YGygbROTjLIQ1aNcxotsGT5rSiKAs8/j2aNjkkTCB681bcjKgATD3yXVXP9NjN4PuBa+YZ2lYH4RV5t6sKKCTwnl9+MIftmAqkkmjw6mqAvu2Ui3w2WcIuu6sguA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEZlUnXhlxs//xUaHZD1yZ3iLbwhbfH/o4xp8tkUMrI=;
 b=C63UGKmkaNsp/03q9mbDSGrblS7NHdRx6wz5igkFASzEJMaXbe+xLEJc/TrOYwht98oaIHxcqOG+DKSySxx6TVKmuHqlEyV6WaLrethp048oh60rIbEtbWgdeJc3x6YPO7L3RzgRvKmYCbgaF1qsE2SbWnesjU712DUOPbdooVg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4867.eurprd08.prod.outlook.com (10.255.99.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.19; Wed, 4 Mar 2020 11:27:49 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2793.013; Wed, 4 Mar 2020
 11:27:49 +0000
Subject: Re: [PATCH v4 5/5] iotests: 287: add qcow2 compression type test
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200303133425.24471-1-dplotnikov@virtuozzo.com>
 <20200303133425.24471-6-dplotnikov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200304142746818
Message-ID: <3d79452c-a2e9-06f5-ebf1-5edb3ac24108@virtuozzo.com>
Date: Wed, 4 Mar 2020 14:27:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200303133425.24471-6-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0102CA0042.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::19) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0102CA0042.eurprd01.prod.exchangelabs.com (2603:10a6:7:7d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.11 via Frontend
 Transport; Wed, 4 Mar 2020 11:27:48 +0000
X-Tagtoolbar-Keys: D20200304142746818
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a95f0042-ce7e-4d9e-273f-08d7c02f11a7
X-MS-TrafficTypeDiagnostic: AM6PR08MB4867:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4867E586AAB04D4DA4466F7FC1E50@AM6PR08MB4867.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(346002)(136003)(39850400004)(376002)(199004)(189003)(66556008)(478600001)(8676002)(4326008)(31686004)(52116002)(81156014)(81166006)(66476007)(16576012)(316002)(16526019)(36756003)(186003)(956004)(66946007)(2616005)(31696002)(26005)(5660300002)(86362001)(2906002)(6486002)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4867;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VmppiQqtN5ITh5VHLLecrYvV7sa97dR3nI3EH6KQHqqgiLaSW4Tej03GppERTAHaRL0a/yWy8RBIOknkQqy2sJ/zFQ2o1ZytnQ3JnjmEHASX/crI+erDSJNVzr/emuxDY/o3ROODBWfYtAR6nnucKIlnuHBcr+Die7N8q5bHHGTKmiq7Eyrrd+eE5GoI/38eQTH1Sz2n8VcYBr/YpnBsa+LlEe0T9YnwQwBqZQJzA3+/RMy+WqxHV3Dcgha8qgSP5zCfyyBkUaDe0Gf6aIDeUec+GYEHbCDwi1v+xH/EEs24qRD0oVOR0Omc4RxQc7L3Ebq12PIbQhtnBVEAgll6daoLpCbSnAHiODb0oFDeds0Fnb/9VsUDhiGnngVjP2tqrNs+iLdSd3ol/kMrkSQFtCQMvKq4F8SUXjS8smMM+UmTRdOFfTxrM7wOsHl3qpXD
X-MS-Exchange-AntiSpam-MessageData: HRoa0YFL44xdgLDNTMhfTC70sZRovCFqEzqlbMvrt7V6FqqmhPYlnTnQVg6m6HEZZAcuUOv5/lOErALfth5PHo4Et3h39OLU5RwwUWct+YX7UJHECwn2adK9xmEJ7hSrGwS9FYdID8GNPkkb9to0gw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a95f0042-ce7e-4d9e-273f-08d7c02f11a7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 11:27:48.9696 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: acO74GKEzHlmJ80x+SyVulAqe7MbhQNzrZDYZF0ywLbu4eghRuNJf3Rz6QUUfhxuv57CuvpjkcJGE5GSYRQV8Ph2DJBA+KMyDH8H634Cky8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4867
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.21.126
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
Cc: kwolf@redhat.com, berto@igalia.com, qemu-block@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

03.03.2020 16:34, Denis Plotnikov wrote:
> The test checks fulfilling qcow2 requiriements for the compression
> type feature and zstd compression type operability.
> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>   tests/qemu-iotests/287     | 127 +++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/287.out |  43 +++++++++++++
>   tests/qemu-iotests/group   |   1 +
>   3 files changed, 171 insertions(+)
>   create mode 100755 tests/qemu-iotests/287
>   create mode 100644 tests/qemu-iotests/287.out
> 
> diff --git a/tests/qemu-iotests/287 b/tests/qemu-iotests/287
> new file mode 100755
> index 0000000000..39cb665c85
> --- /dev/null
> +++ b/tests/qemu-iotests/287

[..]

> +# Test: using zstd compression, write to and read from an image
> +echo
> +echo "=== Testing reading and writing with zstd ==="
> +echo
> +
> +CLUSTER_SIZE=65536
> +IMGOPTS='compression_type=zstd' _make_test_img 64M

As I understand, you should define env variable assignments on the same line
with _make_test_img so that they be passed to it, like
CLUSTER_SIZE=65536 IMGOPTS='compression_type=zstd' _make_test_img 64M

with this:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> +$QEMU_IO -c "write -c -P 0xAC 65536 64k " "$TEST_IMG" | _filter_qemu_io

you may s/65536/64k/

> +$QEMU_IO -c "read -P 0xAC 65536 65536 " "$TEST_IMG" | _filter_qemu_io
> +$QEMU_IO -c "read -v 131070 8 " "$TEST_IMG" | _filter_qemu_io
> +$QEMU_IO -c "read -v 65534 8" "$TEST_IMG" | _filter_qemu_io
> +


[..]


-- 
Best regards,
Vladimir

