Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA86C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:56:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 795832464E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uRXksHMl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 795832464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4SeE-0005jS-Jd
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 11:56:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43141)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j4SWW-0004kJ-CW
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:48:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j4SWV-0005rx-7s
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:48:32 -0500
Received: from mail-am6eur05on2093.outbound.protection.outlook.com
 ([40.107.22.93]:57825 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1j4SWR-0005nD-TA; Wed, 19 Feb 2020 11:48:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5rJOseiwV2FfTXeBFCC9Vv6mOk4VW/y/xFXn63rYM1XSwCvt4/+T/vshFenCippXvyiXjH8/f0nh7MiJMM1zd72HAAAouOPZaT/21ZE7vXFlkqfEmTh40IuA7IDRU87hbEVYZiUl4LncUpDa+YpNiyIzWMDR1QLU1zBCD3quNDOxsu1jyaokODx4ybgZeXkA7ydKVBjp3fPqwiNrIqjhIVdy6rKjlJNUm5ul9OMRpwmQXsApjOYkVRLBVgUmqDkS7vQLb+Axf7tJmjLVmAC9saQaPyuJDCXbr2X4EcLsjhSZr1olGxfIINQzYDwI1YjQjfim0zoy6GxJmTC7//YCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5R6El8z85CKpe0ftvZOz3v9TAv6GuInOVRy2GBe+UUA=;
 b=e4CC+xSmo/7bf7pgbjIUMUgMaKv0QfmmRp3/C2/9bGq45IsJ8AfoX1B6Z4YiamjHrImfRWzxNKIZ8mZG+JwACvxd/T9tp6ETr+m6UPto2I8oSgSjKSg/ye1OdsWLbmmE4WwIois8y0TdRCgOkOTz/sLRat+KZ46FlNEPKOXdzZdp6TvhFA2hWF48UvZ9zCIDGOvcI9sfNlwsOwytqXSdiG4C3C4BYDE1lfO8bl2YsKOdulgLXrxCadMkehaBZuuh5TjbAxd81ln97L2QXEjA8XfktZMDhFlx0dOUChxC87w+7jduxpqcrmuFyGNyl5aPhJMNnL7lJlS5JXUhu0FcZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5R6El8z85CKpe0ftvZOz3v9TAv6GuInOVRy2GBe+UUA=;
 b=uRXksHMlWKC/U1XTF2Yr6OZmwEIADjxCpPutyfCVzNkvO6TBVtNEr8Dgd8Z66Rs/ZfM3EyOi7B+xX7G7TvmIzrScyuSlmrizZ1OZoXhDI8UH5CU1vsQp3cBnWzea4b+Ti4ou6DkZu4LZo80G/GSPJd1Kh0nb6lmCzdtl36BsKKo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB5128.eurprd08.prod.outlook.com (10.255.120.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 19 Feb 2020 16:48:25 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d%5]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 16:48:25 +0000
Subject: Re: [PATCH v2 21/22] qemu-iotests/199: add early shutdown case to
 bitmaps postcopy
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <20200217150246.29180-22-vsementsov@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Organization: Virtuozzo
Message-ID: <9e2f41dd-2ef9-262c-117b-9a63169f0304@virtuozzo.com>
Date: Wed, 19 Feb 2020 19:48:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200217150246.29180-22-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P192CA0014.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::24)
 To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
MIME-Version: 1.0
Received: from [172.16.24.225] (185.231.240.5) by
 HE1P192CA0014.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.24 via Frontend Transport; Wed, 19 Feb 2020 16:48:24 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3759927e-43f2-4575-6d86-08d7b55b8996
X-MS-TrafficTypeDiagnostic: AM6PR08MB5128:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB51289D49A5CC7FE25DB50EEBF4100@AM6PR08MB5128.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
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
X-Microsoft-Antispam-Message-Info: os2CxvsJObRK6CkCezF8BQ5Nfl5DG5Qq36jSEwDIzQP3LGzXrmIdSf2m2hfzUwdu5/50aCER7ky3oVG9nDJjIoBmgM9CLmnEq3TSOBC748lCKXZWBQyjcDo5a584cBxHRYg/EH/PdARrgBlwxSCNmzOs4FvmASoN5m+56oRs0skW4bKGF3M+hE53J+q7qqcDQIDkV+/IhsHbBIEWtxqiaaLZ9OhcVfpDh2OSWjJJdCeOn6eWHdUwlr7XW9hE6LfLSWRmdA13WYX6liylG6/IhAv/cietqAAyvztCztGA8jSZw/1epZp7t9xf6THtMYRnUbFUxp9/XVUhza4ygbK4FwykI7fA6Z7fGNyNsA5IVE8YGaViUb6QSeFpb0RlMoBh7EbpvX9Il26ri+f9+8Ozxby8+5KTbS3dRhN/tbD/t7GJ4axBMF1o31igKS//Pek/
X-MS-Exchange-AntiSpam-MessageData: dhWtGLw4OKsRBLoCgNq/5cKlYK/6/+DXmPFkuaDbopx800D3QXzVh7QBSeU20tzyPVmh2vZ/VMC8gpyZSOiw4GHWAihOfYy4v7xomJmF74hjZU45YShqefO2hsnPdpsi0Gm1yRxWGK0jBJgRIlHLJQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3759927e-43f2-4575-6d86-08d7b55b8996
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 16:48:25.2682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iue/uATOA92OU0bTgtQobEgFmChXKmjGw2SaejkRije7rQqvdd6MgVyqAk9mwWjhHJOOj8QSJP3nyCOVcyN4oGNZnxufEDBJblYg3FmazTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5128
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.22.93
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

The updated test passed.

Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
-- 
With the best regards,
Andrey Shinkevich

