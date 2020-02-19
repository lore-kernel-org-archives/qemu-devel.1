Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95278C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 17:11:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6193D2465D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 17:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="s0LL5AYs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6193D2465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4St7-0006FI-Jq
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 12:11:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43515)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j4SYU-0001gt-Sw
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:50:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j4SYT-0006ik-Pb
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:50:34 -0500
Received: from mail-am6eur05on2103.outbound.protection.outlook.com
 ([40.107.22.103]:32352 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1j4SYR-0006i3-4q; Wed, 19 Feb 2020 11:50:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6qpWbPKVES4T5oiaYKDrCMzRheZ5skB5a4d5Kln8AvQFL5U3ZvyGw7XY3MP45ZFjAW03HzQA6XM7bp3gQoe/89KJcGz54vQQ7iJLMpca65qJGHH3L7zqoKHbZ9rXvF2UuJURSbgk10sWtlbapQ6DkeJLnFrVBOTPi8JAVKfjrPrzysesW18WRG8OMJ1ItyY2r61H0LqDcDPppE4Qqo6o+ZH6kn1i1Mpyt7l5ZXC86PyO8HEb2fjHfQrx/Jtna/U9VYWphsRGvS0saP97kgd94o+Xc6gKlQKIusbZYimfctfpKmOJ3dywEAgYrs/I+tDygLcdv3wzf8ztaa56nopGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERK4Fd3qI6o9bSVHTqdr7bhejlPyZ7cwRULsAF56H4U=;
 b=eIorLNQlx+jh7mO3rAOLjECIU4x4vo08hnAwpyeT1Q7pBlXnW+jOqG/wWNhwtRHs/lq20AMxddQzvrwMmCLUmJSSFSHjfPkh+yc9/8VZVOitRBrEihZWhiFB5cmIc+7HBja2SNRHulbuVleuMlPrqb9RCxSGqSP7MZ/KHyZw3coJn42NThvLrf8wQySL5opC0HIdy4AxabssYGryPpc8KLpf6NKmWg5RfIPY2CSam8mYvEgjiIQNB97lX9hi/8QEl0ZameF5osUP9T5RJ2ElZhtKdX14ciZejYB+J8rGBp79hj28tWh4DfGVxi5lHmzTHNVjUnqrxgvLzAB97Yq88Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERK4Fd3qI6o9bSVHTqdr7bhejlPyZ7cwRULsAF56H4U=;
 b=s0LL5AYsyVkEk8nEwBtStaYQX2eCmYo9at+hClJLxuYTNnBggmD7H4d7H2giVqXc7ghIqWZ9hDekdDQwCna3Ycj9gAA95ZfeE1uBTme0v7mvJZaukyCGc3/sWpCt3YN3M52gFg7a1sGZEeojsv3d2gb+LXrwdJFENfP6ITTDiOU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB5128.eurprd08.prod.outlook.com (10.255.120.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 19 Feb 2020 16:50:29 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d%5]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 16:50:29 +0000
Subject: Re: [PATCH v2 21/22] qemu-iotests/199: add early shutdown case to
 bitmaps postcopy
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <20200217150246.29180-22-vsementsov@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Organization: Virtuozzo
Message-ID: <1b224949-18dd-12f8-599f-d5af0116cb65@virtuozzo.com>
Date: Wed, 19 Feb 2020 19:50:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200217150246.29180-22-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0802CA0007.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::17) To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
MIME-Version: 1.0
Received: from [172.16.24.225] (185.231.240.5) by
 HE1PR0802CA0007.eurprd08.prod.outlook.com (2603:10a6:3:bd::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17 via Frontend Transport; Wed, 19 Feb 2020 16:50:28 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2a7f8de-5b0a-4647-6a49-08d7b55bd3a2
X-MS-TrafficTypeDiagnostic: AM6PR08MB5128:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5128E140D8FD5DD0719AA213F4100@AM6PR08MB5128.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(39850400004)(346002)(396003)(136003)(189003)(199004)(31696002)(6486002)(52116002)(36756003)(2906002)(478600001)(36916002)(86362001)(16526019)(66556008)(54906003)(4326008)(31686004)(8676002)(956004)(66476007)(8936002)(44832011)(16576012)(2616005)(186003)(66946007)(26005)(81166006)(316002)(81156014)(53546011)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5128;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r/wNMQGMzlW4mOfUKXNh8fNkHylAOMYOzhJTF4L7izSrqpxMFePdXLVcHqBweh1PBHX3E7pI2dHnh1AtP0btgwlxBuExkYGL67ZSVVPYdZ+ezrKDzd4krzFprAJ5zwDKSBcXyLXas3wkXON4EWSvrTnprsJKDBeXZWj6fUV35C0ZgGLQ5uzBN+gSbwu/WqzFwqSZ5sna+wFQ0SkdxIOMdOsV0jGSM/cK+p8QEYzG/3f1AlZkzHGEHqt29e+cXZXCy5M2urBm6Wjp3Y6fJpAvfJgpA4RaD/Ed50mIi/wxZ0WoA/9sQvk5ywzeiID26c0tS/ijcyC5try1gg+JSYhvUCI0ttDUY7GdbtvRKGDR4MH7ubsRVYDgF6oy84w5tp1R5bC6VoYLPikJQcJTRH5GcHOBnT2I/MjAzBm4q41Q7RKrwYVlXACrfnwBnI/wqs0Z
X-MS-Exchange-AntiSpam-MessageData: XYmVTlKlG5icIPyvrCO+fXpd75wAo/Uq+0DQ2HexOddRcwBpwvpQhXLxGFNewmBSyKYKClwwi1MUQz4b9xP6u48cKqSE+Rfpx9GlVVyeJzARow9f8N5rZr2/pS/7smeSA99sCVrKJQhz5Bsyndq2Dg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a7f8de-5b0a-4647-6a49-08d7b55bd3a2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 16:50:29.4691 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uulr+n3wDO42Bo3Fn2wArsYGGwxvbQrgH/Vj6ApRBzo/mpRgnfuQY8VEhE7Bma0KDXvt1U9mrde4xSLlZ6nI7VNd9xOek00PYLOeeLgAW1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5128
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.22.103
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 dgilbert@redhat.com, qemu-block@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 17/02/2020 18:02, Vladimir Sementsov-Ogievskiy wrote:
> Previous patches fixed two crashes which may occur on shutdown prior to
> bitmaps postcopy finished. Check that it works now.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   tests/qemu-iotests/199     | 18 ++++++++++++++++++
>   tests/qemu-iotests/199.out |  4 ++--
>   2 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/199
> index 8baa078151..0d12e6b1ae 100755
> --- a/tests/qemu-iotests/199
> +++ b/tests/qemu-iotests/199
> @@ -217,6 +217,24 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>               sha = self.discards1_sha256 if i % 2 else self.all_discards_sha256
>               self.assert_qmp(result, 'return/sha256', sha)
>   
> +    def test_early_shutdown_destination(self):
> +        self.start_postcopy()
> +
> +        self.vm_b_events += self.vm_b.get_qmp_events()
> +        self.vm_b.shutdown()
> +        # recreate vm_b, so there is no incoming option, which prevents
> +        # loading bitmaps from disk
> +        self.vm_b = iotests.VM(path_suffix='b').add_drive(disk_b)
> +        self.vm_b.launch()
> +        check_bitmaps(self.vm_b, 0)
> +

Comments would help to understand the idea behind

> +        result = self.vm_a.qmp('query-status')
> +        assert not result['return']['running']
> +        self.vm_a_events += self.vm_a.get_qmp_events()
> +        self.vm_a.shutdown()
> +        self.vm_a.launch()
> +        check_bitmaps(self.vm_a, 0)
> +
>   
>   if __name__ == '__main__':
>       iotests.main(supported_fmts=['qcow2'])
> diff --git a/tests/qemu-iotests/199.out b/tests/qemu-iotests/199.out
> index ae1213e6f8..fbc63e62f8 100644
> --- a/tests/qemu-iotests/199.out
> +++ b/tests/qemu-iotests/199.out
> @@ -1,5 +1,5 @@
> -.
> +..
>   ----------------------------------------------------------------------
> -Ran 1 tests
> +Ran 2 tests
>   
>   OK
> 

-- 
With the best regards,
Andrey Shinkevich

