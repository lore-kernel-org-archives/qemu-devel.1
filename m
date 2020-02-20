Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB84C11D81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 07:27:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52A2024672
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 07:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="pknT+S78"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A2024672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4gEw-0000Ry-GV
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 02:27:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37505)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j4gEM-0008KB-78
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 02:26:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j4gEK-0005ap-RB
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 02:26:41 -0500
Received: from mail-eopbgr50104.outbound.protection.outlook.com
 ([40.107.5.104]:11590 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j4gEK-0005aI-Jn; Thu, 20 Feb 2020 02:26:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZjW5txNT3CXCT/K9MYXmyLAAXpF8nPvyLfDWCtOimMjMaH73ME+ceKv6anPxo1JMhLdvK4a5VSeIYXZWdxAX/QHjHF+XO7BwuDXEtmCo+VXaIz4t0deBO2V1obGDLHXDoF22/DYOcHYqzPcYhr4BlMdnqqg4mTLf1YltHLFtMuCYn40XkxoaNcr8W74ZjgNkSMGyJZyd6AHQ51Fjmz312vOGZzRij+3gQQjgFCogcYLy5O40KW2xt6AuF4D4P68fO+tnHCJDLgWRCRUvhEixFu0hdEuyKHHZYjYRurKEXMz7FswNF/g5jEXrRs9J8upL2qLeEfWa193MweLZEOwWDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOnlaj7jHiltM/dwAH4DoG0KVaGJx8GpQxYp4CabjiA=;
 b=Q/p9DpIOLYliwrKTenqTrXvJKFb5hPZaTiIU7SJQZNVhAtmjhU+8Dv6A/tIXYX9FyouJ0XZfl2B1eLX40xgN/sGZNs953aV77rE3aGFbFbk/+H6bGS5gY1cUBELaa1iy5XJgXohvW0NEAuXpL+gad7HAjpHvSYYKpPVWFaG9kNaXeA8tkWolma6cGUbNwyTZcDTd2+YmA5BsAl/mqy1Yvy74qVkDeBgWNi/Grp+8+auq/FgtB6ws2x+TMOIPsyGNHwYyPJEq/jlz9E8qJG3zqJqr+cydhIisyYXEV9VeubHZ0A4qPetiNYx4TjIckqCmKU1pCX6nQg7NxB/9nj084A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOnlaj7jHiltM/dwAH4DoG0KVaGJx8GpQxYp4CabjiA=;
 b=pknT+S78czr4SNHXd5FRZLYkR8E0ye8F5Vmtbp21UxtoAbI2amAAr0mnM+U+e/Qk7i2kTRRU+ILuqocyuprNomFFNmKFni95UVIJXBR7X/ZdSnYfimAKxOogJofaPmYUEOykyG4XBb4o9BwsxmRodbF50Adji3b31d+P+oKB62U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3928.eurprd08.prod.outlook.com (20.179.2.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Thu, 20 Feb 2020 07:26:38 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2750.016; Thu, 20 Feb 2020
 07:26:38 +0000
Subject: Re: [PATCH v2 7/7] block/block-copy: hide structure definitions
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20191127180840.11937-1-vsementsov@virtuozzo.com>
 <20191127180840.11937-8-vsementsov@virtuozzo.com>
 <ba8f31d5-d04f-2c8f-2afc-4c1ce2f5aa3c@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200220102636257
Message-ID: <0b0bc717-7f25-97cd-a732-5e2319843811@virtuozzo.com>
Date: Thu, 20 Feb 2020 10:26:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <ba8f31d5-d04f-2c8f-2afc-4c1ce2f5aa3c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR0701CA0083.eurprd07.prod.outlook.com
 (2603:10a6:3:64::27) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0701CA0083.eurprd07.prod.outlook.com (2603:10a6:3:64::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.9 via Frontend Transport; Thu, 20 Feb 2020 07:26:37 +0000
X-Tagtoolbar-Keys: D20200220102636257
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fefd4e5e-fa55-4a6c-8252-08d7b5d63911
X-MS-TrafficTypeDiagnostic: AM6PR08MB3928:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3928F6C4EB2D52266D547760C1130@AM6PR08MB3928.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 031996B7EF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(136003)(366004)(39830400003)(346002)(189003)(199004)(52116002)(478600001)(16526019)(26005)(66946007)(6486002)(5660300002)(31696002)(186003)(16576012)(53546011)(316002)(31686004)(86362001)(4326008)(66556008)(8936002)(66476007)(107886003)(8676002)(81156014)(81166006)(2906002)(2616005)(956004)(36756003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3928;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7pndqR3OImMZykzLHO8YEa+pcTMgshtg6CNrNopc8HgU6lCzajppTbQMIbpMUFn2ivqM++c1phR/Qb00GnfIYucYJ0IRvbr0T02lw5O62vq25ucAK4RTo78YUtYHSiewxBGIkf/ZV371vy7u2AofMnATTY/8WFjNAEC1RoW5BK9p0lnmOhIixkq9Eriadw8uEhSqZjetW+KJI33Wr+m2OzlstPUbUWs1lqbCVHPpk948x6ou5tkN7xp/mgC36MEf7ymO1zBeMRl1foKzGLf0j0KtW25RXTNpX0Vs71Bh3I/Hrg+GUzVP2ptVdJVn/yT7TAhI0391Gf6Q5Kkwz/KFHDJv8yv9j0CFFjeKgwsPknQt+dFPaCyDnhbLvw0fLRdWPNkfJeNDvjwSk3LrMYEXBPtZ2V32TW6RbNekawYZK7Y/OJ+3Ok7hnnzFD4+87Gco
X-MS-Exchange-AntiSpam-MessageData: U7bbAl8NChzQD2rZO0foKOfaEtOhur3IW1FonefrSRGNNN2E32QZagkEJyBqxCVp4wp11GPcVZDTzreICiuzYkYWp805Cor38L3fLT5G6CpM7OfLJ0ITxcNpN1wY26WBnGF857rqXpNfWXIXj4aoCw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fefd4e5e-fa55-4a6c-8252-08d7b5d63911
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 07:26:38.2551 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j/WD6eKuzLL18nJWbXIun4ytcyYs9Er+0RqWSazMSxoLEk59L+TPZGh7xW7JnbOm0FCY+FRvm5L1gWqcVV5C7jvnM32gLnX2xmmyHsvT810=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3928
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.104
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
Cc: kwolf@redhat.com, den@openvz.org, jsnow@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

17.02.2020 17:04, Max Reitz wrote:
> On 27.11.19 19:08, Vladimir Sementsov-Ogievskiy wrote:
>> Hide structure definitions and add explicit API instead, to keep an
>> eye on the scope of the shared fields.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   include/block/block-copy.h | 57 +++------------------------------
>>   block/backup-top.c         |  6 ++--
>>   block/backup.c             | 27 ++++++++--------
>>   block/block-copy.c         | 64 ++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 86 insertions(+), 68 deletions(-)
>=20
> [...]
>=20
>> diff --git a/block/backup.c b/block/backup.c
>> index cf62b1a38c..acab0d08da 100644
>> --- a/block/backup.c
>> +++ b/block/backup.c
>=20
> [...]
>=20
>> @@ -458,6 +458,7 @@ BlockJob *backup_job_create(const char *job_id, Bloc=
kDriverState *bs,
>>       job->sync_bitmap =3D sync_bitmap;
>>       job->bitmap_mode =3D bitmap_mode;
>>       job->bcs =3D bcs;
>> +    job->bcs_bitmap =3D block_copy_dirty_bitmap(bcs);
>=20
> It seems a bit weird to me to store a pointer to the BCS-owned bitmap
> here, because, well, it=E2=80=99s a BCS-owned object, and just calling
> block_copy_dirty_bitmap() every time wouldn=E2=80=99t be prohibitively ex=
pensive.
>=20
> I feel sufficiently bad about this to warrant not giving an R-b, but I
> know I shouldn=E2=80=99t withhold an R-b over this, so:
>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>

Hmm, actually, I tend to agree with you. Why did I write it so? I'll look a=
nd may be change it
to block_copy_dirty_bitmap() calls every time.

Thanks for reviewing!

>=20
>>       job->cluster_size =3D cluster_size;
>>       job->len =3D len;
>=20


--=20
Best regards,
Vladimir

