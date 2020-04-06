Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35A9C2BA18
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 07:25:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAD4A20719
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 07:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QjtIs6Ry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD4A20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLM8H-00036w-T4
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 03:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jLM71-0002Kl-K9
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 03:24:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jLM70-0003sW-J5
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 03:24:03 -0400
Received: from mail-eopbgr140124.outbound.protection.outlook.com
 ([40.107.14.124]:2167 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jLM6v-0003p7-UU; Mon, 06 Apr 2020 03:23:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izogPr5uxukBFIk9XC56r2FR7PWTBz9oOQgZcLVpyE9Xkn3BN7EJr5NHU2jyDRUN26RNlU+jnlbiy5z6p1bateXVRY1yP49yg1E1O6I83D+fN3949i0AxHl+tkXs7nzXnbtPWzWyuwVEgdycuqS11s71X6oJ2fvac/2lJ+Nsj7/J60WZz4P0pMoNXQbmXADtMRtsiZQc9zmrwL/2kI/PYw18CNJpGJMULBW+iWpGlrySnYxk2Ri6a3rUtG5dGE6rfXW1MjrMq5OAzrspKHIpdZ8bsRzVoh3NpUtRgH2XVtbyoA9PpWwN4CXwxP3irq0gax4ImGi1aywCHGAIuNdHSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wRTWtT5qFgNk+63P00nHkovLb0wdNhQpjxNweIgtZA=;
 b=O9e3smmRvlP0ofFYMlJRrBiCz9LfwuQSsCA2+IV5xDnYpR9tmW0obYeoRdAn9ySZ3SwSbB04veQ/FMEJ9enmn1CQinHSHT6/J/6vFx5iOaUAQ2aKmrkcNWHPDmOshrxs2ws8h2uJvRHKF+Lkevb5sLmdZsRvwRGOplCl6+KJiL8dBn2hhzqSBR7bDJOp5h/z0LXeyl1QxMoMfvnmXTPsztdAivOn8Tl+kSc9siJZTyV5iR+hipb7Bz63cyKwJAtt/HdOZhFC1Ka5p6f4Q2qIwmWJwCuBuWpKaXY9NRrsU3JZc0w+ceExQrCy8p1DBu2i0Q/hk5G++8ch7r4El5NrgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wRTWtT5qFgNk+63P00nHkovLb0wdNhQpjxNweIgtZA=;
 b=QjtIs6RyYmTn9DlPztnqUX+dS/rAU2bcE9b/IvUjnahe0MPpG+Dq3VnxlaJrymqZmT8GdIKw9MuzKY3gVRQcIC2r8kXkTmJwbwrKIWu/CStSCCW3/jHZH2grcALPkv+th6MyFMyukRh0LTUTdXKfTQ29sxmTMfGndeQhzHCvMiA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5366.eurprd08.prod.outlook.com (10.141.173.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.16; Mon, 6 Apr 2020 07:23:53 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.021; Mon, 6 Apr 2020
 07:23:53 +0000
Subject: Re: [PATCH for-5.0] qcow2: Check request size in
 qcow2_co_pwritev_compressed_part()
To: Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org
References: <20200403165752.18009-1-berto@igalia.com>
 <a8434c66-7c80-2632-b8fd-404e7a0e6c69@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200406102351297
Message-ID: <6c3bf09f-35c2-0550-ff19-af91d875db21@virtuozzo.com>
Date: Mon, 6 Apr 2020 10:23:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <a8434c66-7c80-2632-b8fd-404e7a0e6c69@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0017.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::27) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.216) by
 FR2P281CA0017.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15 via Frontend Transport; Mon, 6 Apr 2020 07:23:52 +0000
X-Tagtoolbar-Keys: D20200406102351297
X-Originating-IP: [185.215.60.216]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9cd1c488-cbd5-46d3-af5b-08d7d9fb75f9
X-MS-TrafficTypeDiagnostic: AM7PR08MB5366:
X-LD-Processed: 0bc7f26d-0264-416e-a6fc-8352af79c58f,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5366B573CA7E38F42651E05BC1C20@AM7PR08MB5366.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:142;
X-Forefront-PRVS: 0365C0E14B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(346002)(376002)(366004)(396003)(136003)(39830400003)(5660300002)(2906002)(86362001)(16526019)(8676002)(31696002)(186003)(110136005)(478600001)(81156014)(16576012)(81166006)(31686004)(956004)(6486002)(66556008)(2616005)(66476007)(26005)(316002)(36756003)(53546011)(52116002)(54906003)(66946007)(4326008)(107886003)(8936002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HxTAcL0mxTkABnJvNwgz2HA5P00DtVOMi4Thsa3wav7J3d5114HJDPoMoxtKNdRHlKIj7N7VefraDZaUINRD16zBRHRHumyAdT6Pv9vYbOdfT7HFDC39w2v/7td6ieOAYNO+RVn+XbDfjupT5Iy+FIbdo02rRYBt5L6EPFWFlC2+R2MXwXC1BxxqIpW7G5IJe1dvPJvGNYdfrpKq3PrTAox3+h2LKOpSkH5dKy0BUObghqsV+BxXAOtULAkN1eR6oryOxYsmoZmYgPmtA2BwoEy3iHU4tkFAVJ7tEkDSWvWv6IBJbxxrFIYwqT6FaFuAILqmPS2c5UyyJobx5lps62QreZE5CzJvLmOsSD2QinEg2hqyOa+oVNoX4AvuMW96vHc+eh/YsqhOpfllJ6GMuEMux+HWdOYPRVzq5k2F5QzH4oHVjTNDK0hPyVH30UXL
X-MS-Exchange-AntiSpam-MessageData: 1aMMCtHslQXggpJHaXnuD2upML79jiDMM4il3gQVRJ+XIPxBrLduOzH10GTzJnqUzXNiNIvq3oAJEo7dbsKBdVrmOlNJY7LJgG0Zkd1vstohMSHxuyP9QCa0TLrDGxkiTDn/LNKnYK9xp6jzzgnDjQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd1c488-cbd5-46d3-af5b-08d7d9fb75f9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2020 07:23:53.6635 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCAbvNfVi4vIG3wsclp5ZCKfbSHIqyp7tAPKcNvQIEJcAPFrsDR02/q2XaHJ4PySQfzNAadkqGUvuxn8/fmZWt3jT3sGkO0gt16HCBdVCMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5366
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.14.124
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org,
 Pavel Butsykin <pbutsykin@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

03.04.2020 20:40, Eric Blake wrote:
> On 4/3/20 11:57 AM, Alberto Garcia wrote:
>> When issuing a compressed write request the number of bytes must be a
>> multiple of the cluster size.
>>
>> With the current code such requests are allowed and we hit an
>> assertion:
>>
>> =C2=A0=C2=A0=C2=A0 $ qemu-img create -f qcow2 img.qcow2 1M
>> =C2=A0=C2=A0=C2=A0 $ qemu-io -c 'write -c 0 32k' img.qcow2
>>
>> =C2=A0=C2=A0=C2=A0 qemu-io: block/qcow2.c:4257: qcow2_co_pwritev_compres=
sed_task:
>> =C2=A0=C2=A0=C2=A0 Assertion `bytes =3D=3D s->cluster_size || (bytes < s=
->cluster_size &&
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 (offset + bytes =3D=3D bs->total_sectors << BDRV_SECTOR_BITS))=
' failed.
>> =C2=A0=C2=A0=C2=A0 Aborted
>>
>> This patch fixes a regression introduced in 0d483dce38
>>
>> Signed-off-by: Alberto Garcia <berto@igalia.com>
>> ---
>> =C2=A0 block/qcow2.c | 2 +-
>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
>>
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index 2bb536b014..923ad428f0 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -4345,7 +4345,7 @@ qcow2_co_pwritev_compressed_part(BlockDriverState =
*bs,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return bdrv_co_tr=
uncate(bs->file, len, false, PREALLOC_MODE_OFF, NULL);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 if (offset_into_cluster(s, offset)) {
>> +=C2=A0=C2=A0=C2=A0 if (offset_into_cluster(s, offset | bytes)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>=20

This will break compressed write to the tail of unaligned to cluster_size i=
mage, which is possible as I understand.

Check should make an exception for this case, like the assertion does:

len =3D bdrv_getlength(bs);
if (offset_into_cluster(s, offset) || (offset_into_cluster(bytes) && offset=
 + bytes !=3D len)) {
   return -EINVAL;
}


--=20
Best regards,
Vladimir

