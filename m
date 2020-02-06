Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987F6C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:48:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6599C20720
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EfhzVcfX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6599C20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izkKP-0006Xf-JU
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 11:48:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55703)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1izkJ2-0005WS-T7
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:47:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1izkJ0-00057v-Qf
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:47:08 -0500
Received: from mail-eopbgr80114.outbound.protection.outlook.com
 ([40.107.8.114]:42981 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1izkIv-0004OF-3X; Thu, 06 Feb 2020 11:47:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwJQyLlqRX+qLHNQIYpjTChRZcamfPdhQdzojrljga4gR7MiX6upODucskPzDKTZ8Wqi2wPwxMemYb514zDssrQBITHANAmFfWjB7QSnK8Exd/11nCMwa8ZVYYz46zvwZpBhjeYM5pN4iH5Oi/1IUZ3MuQXzWBBvs++BKGFgDTeLeLla2+BLRXElOx6fHF8tFUvcW9Z4sYB3OS9FAxby0pQyfFTbuxqSrzSn6euPWgRjIH+9X00FW0Shse1T4jGxFZOJ9Yy1+Bmnqrm3+tszd3qM0CPz/2Xf1FDl1h6+tzRjQftYQWuxQZsFtsMJfzm2G1FHbraDk0awu/SDlooVIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUOXIrvMlMTyIFFt+seSc9yU50gSOZVTEyZAeWw88vQ=;
 b=VmM/YE7vI+G44E6z+GQIJCoFz5kqj9jiMD0oaSRFXYxvGfoYbUF/D5yxCRuo6eBJ0Q2G5y+ZuyTmvmSSNkKj+FTZUg9wD9Pc36VTp3tDr9+6Q1VxRFdcqSt4SHkcHbfMM42XlBg7nGCD4JkQaK6tM2GGKQUMWa3wBhMIsaR/mLnmttTz20R85WiAX3jZN0ogh/m4sDvxRQ7ZmxTIJbIs5VSXdLGvDRm36hvsOAx2Z9aY67Pi4hrcc9N3SEgKVyrvSG21QvhOotYq2p7g10Y411t4Yyh1UUHNjKs1lSSHdm14+ynJVwsihPKdUmrWJ2os14w/vNH93bP6oYiXrmtV9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUOXIrvMlMTyIFFt+seSc9yU50gSOZVTEyZAeWw88vQ=;
 b=EfhzVcfXIwVpKEJfXv4NuTZ4lUEihUBi55rn4MLV4iCKQX0k0AmCtztrCYQn+tkG2w59QYhbyfnT910Z2nXDfK9UKXCsWYEkkvtnbXr1zbzP7nvSM/qgAEEUfi7B5tuwBaFTRxEFvrNwgdqJZkCYG5FSZejpnmubVXAJqrrjCpQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3271.eurprd08.prod.outlook.com (52.135.164.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Thu, 6 Feb 2020 16:46:57 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2707.023; Thu, 6 Feb 2020
 16:46:57 +0000
Subject: Re: [PATCH v2] block/backup-top: fix flags handling
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200203134213.2173-1-vsementsov@virtuozzo.com>
 <05f70af6-83f9-c51f-74f3-bbbe4675e411@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200206194655045
Message-ID: <19ba1ec7-a865-a1cb-b46c-96c15c2ddf40@virtuozzo.com>
Date: Thu, 6 Feb 2020 19:46:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <05f70af6-83f9-c51f-74f3-bbbe4675e411@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR05CA0286.eurprd05.prod.outlook.com
 (2603:10a6:7:93::17) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR05CA0286.eurprd05.prod.outlook.com (2603:10a6:7:93::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Thu, 6 Feb 2020 16:46:56 +0000
X-Tagtoolbar-Keys: D20200206194655045
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3081ab7d-6e15-4fdb-9a22-08d7ab242da1
X-MS-TrafficTypeDiagnostic: AM6PR08MB3271:
X-Microsoft-Antispam-PRVS: <AM6PR08MB32717AB1372ADE2E0044ED59C11D0@AM6PR08MB3271.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0305463112
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(396003)(366004)(136003)(39850400004)(189003)(199004)(6486002)(316002)(36756003)(16576012)(52116002)(66946007)(2616005)(66476007)(66556008)(956004)(26005)(186003)(16526019)(5660300002)(86362001)(4326008)(478600001)(2906002)(53546011)(31686004)(8936002)(31696002)(8676002)(81156014)(81166006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3271;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q4ArivpFFc3jqQw5uVay6Z1Jjk5bjrJizOADHZMU7nHWZ95MWh1/TieJlmPN7D7q8FfNShFtC4+QkRtro6ID02J1nIBaZMgCYBY9Cqixtv9Fm8B6DsbLy8V9AzGKlsQjLfTYg0Zw7DoJBMGaF0WYt3oYrwUYdP+Wd3ZOIa4S3I0TpSIv+U7zJs5NWjioQU42oqmrCAu/HUNQofTBa8EPCUmYLkmJ+B08sKU+Gu6Bt99dtN7woXcDutd4bOfLLYs0fW4nsQ13b8cND+N2BTK0hl5IuubBsz04AN6neoSBbWOs8wKXU44Rc/zVDzEKhwezCXMa8ytIhWQ1K0uL9hBMn9SZuwSguivTWve1eeYJ7TqjuZdLOU4ot382M7dYIknaJpGZ/xn5Hi9PJBmVVZg3R1XYeAZVa1ZGxusXHiXKEepugrgvgYX4GV581UsiY2rm
X-MS-Exchange-AntiSpam-MessageData: J0A4kEGmbu0Bt7m2LmIsdAlgtcbkTwprMVPk+pDOJu0GMGy50u8neY2/g0b6+RiPel9quZUo3UNWWFj1FFtMO6FrwTFsU0xyOGriu7a09NTps0kjnqe4pjXZRr6sPwlms0kDKrMdi0877ZsGgoK1+g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3081ab7d-6e15-4fdb-9a22-08d7ab242da1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 16:46:57.0861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a/Rasa/hB9OQoBQ6otWJGtbrMcId/lT/NWBUK1gpzlQ32VnCdSflY74ausLrSy4MFhG/uLjQlWwBToCeq1msFT0lPeKTW66zv4Ox7YKLWZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3271
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.114
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

06.02.2020 19:31, Max Reitz wrote:
> On 03.02.20 14:42, Vladimir Sementsov-Ogievskiy wrote:
>> backup-top "supports" write-unchanged, by skipping CBW operation in
>> backup_top_co_pwritev. But it forgets to do the same in
>> backup_top_co_pwrite_zeroes, as well as declare support for
>> BDRV_REQ_WRITE_UNCHANGED.
>>
>> Fix this, and, while being here, declare also support for flags
>> supported by source child.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>
>> v2: restrict flags propagation like it is done in other filters [Eric]
>>      move state variable initialization to the top
>>
>>   block/backup-top.c | 32 ++++++++++++++++++++------------
>>   1 file changed, 20 insertions(+), 12 deletions(-)
>>
>> diff --git a/block/backup-top.c b/block/backup-top.c
>> index 9aed2eb4c0..a4cec60859 100644
>> --- a/block/backup-top.c
>> +++ b/block/backup-top.c
>=20
>=20
> [...]
>=20
>> @@ -186,17 +190,21 @@ BlockDriverState *bdrv_backup_top_append(BlockDriv=
erState *source,
>>                                            Error **errp)
>>   {
>>       Error *local_err =3D NULL;
>> -    BDRVBackupTopState *state;
>>       BlockDriverState *top =3D bdrv_new_open_driver(&bdrv_backup_top_fi=
lter,
>>                                                    filter_node_name,
>>                                                    BDRV_O_RDWR, errp);
>> +    BDRVBackupTopState *state =3D top->opaque;
>>  =20
>>       if (!top) {
>>           return NULL;
>>       }
>=20
> If top can be NULL, then we shouldn=92t dereference it before (with
> state =3D top->opaque).

Oh yes.

>=20
> (Pulling up the initialization of @state is also unrelated to this
> patch, I don=92t exactly know why you=92re doing it here.)
>=20

I just though, that it is small good style enhancement, but it isn't :)

Let's keep state variable handling as it was.

--=20
Best regards,
Vladimir

