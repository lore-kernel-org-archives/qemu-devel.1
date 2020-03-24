Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B45AC4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 08:34:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7A3520724
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 08:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EMa9ly2H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A3520724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGf10-00054v-3g
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 04:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGezL-0004XC-MA
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 04:32:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGezJ-0001bR-ND
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 04:32:43 -0400
Received: from mail-eopbgr10129.outbound.protection.outlook.com
 ([40.107.1.129]:38409 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jGezI-0001aM-M4; Tue, 24 Mar 2020 04:32:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPLdZeCOCmnYK5OsXAyATwItsHVnjlZV0ZFVF7VtXUq7eiHq2u0gMLUqaC/QRVEnHc/lrywqFBw1y68ikIRq8uZA3+zYqBQm2k8epFP28FAyG6bCUmKWt+gOLj4YwyjJJb4DAKFGp3yZ27MxrBa6cXT98lCkeyPQtz9ZudrgzIuSImvulnUGCjV1VL5+pDwpfMYLhhVtfk/a7QmyD5OLBtW/sF1OXuJYyeYRFRJT87/6or0eRq7BUAQq3JhbLoULvxlfmpf4yss/s9JDyuHLky/uC7wmHKNEOOfMJJVCpW6hir6YVf2VorZwzR6P9FMQ5t3OB5/0DmT8IOZfNgddiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LBdra7kGjvJo90Y9SKanBUmaw7CEZ41fNRk1MpkEfE=;
 b=iGZepvjK/DuRgs6P3I8oSxccs38yHaQUZnVtOCthlpqbmzdXV51/4R12TEytgCCskd6qp1jTvZ9cN4bCzwFJTC7lT5RGwlw4eSfH5saZKXamkUkpKHnzacIXuaLoLV12Cs0Qwkkw8+1CB3HznBQljjrGnyDoUEcNGPZTAbSE9a2NnnR38NLxL4sKMrEo8poNThFsnFgMC4acHgkTMphBfg6UkOeyf0qRk370ykRIhoj/Ly+VI9fSYS+SLNE2kzAv/2Zv3j++pMoyj+bWTgxT6szAU+4lF4mTUDsQkDDwMzh/GbefR3WvoGAAiO+KLy3HP2zy4In7LSKa4Fd45gwaFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LBdra7kGjvJo90Y9SKanBUmaw7CEZ41fNRk1MpkEfE=;
 b=EMa9ly2Hpm41fnWCvhdVarQHJsv/yPz71EbX2MOmshxzUSkLz0gvuHnqbJNV5eZGMeQwKWkqMH7m8ApSI+WL/W4gtyFYYROgc/NMVvnUMjiqN/Oqzs+t2k34KH17vstRuD7LzGjIAD/8DdsTDmPperFCFb42zsxvRQY7+Sad2bc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5383.eurprd08.prod.outlook.com (10.141.171.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Tue, 24 Mar 2020 08:32:38 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533%6]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 08:32:38 +0000
Subject: Re: [PATCH 3/5] block: add max_pwrite_zeroes_no_fallback to
 BlockLimits
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200302100537.29058-1-vsementsov@virtuozzo.com>
 <20200302100537.29058-4-vsementsov@virtuozzo.com>
 <422e0c60-4423-b474-0836-3ea8997c90da@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200324113233310
Message-ID: <7c2161f9-d902-97dc-cb43-d6a10f573996@virtuozzo.com>
Date: Tue, 24 Mar 2020 11:32:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <422e0c60-4423-b474-0836-3ea8997c90da@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR0902CA0058.eurprd09.prod.outlook.com
 (2603:10a6:7:15::47) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.15) by
 HE1PR0902CA0058.eurprd09.prod.outlook.com (2603:10a6:7:15::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18 via Frontend Transport; Tue, 24 Mar 2020 08:32:35 +0000
X-Tagtoolbar-Keys: D20200324113233310
X-Originating-IP: [185.215.60.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f183c24-d3e2-4658-48d9-08d7cfcde7fe
X-MS-TrafficTypeDiagnostic: AM7PR08MB5383:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5383AB2BFFD06686363F76FBC1F10@AM7PR08MB5383.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 03524FBD26
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(39850400004)(366004)(346002)(396003)(376002)(136003)(16526019)(186003)(26005)(478600001)(2616005)(956004)(16576012)(6486002)(4326008)(316002)(53546011)(52116002)(5660300002)(107886003)(2906002)(31686004)(81156014)(66476007)(36756003)(31696002)(81166006)(8936002)(66556008)(86362001)(66946007)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM7PR08MB5383;
 H:AM7PR08MB5494.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gwWhYW902dUirD5DZ6C7J6IjBpCdlZBq5j72YQHqYzveG2YEAf4XVZhKaxBn/39U1lmUfGgY1/vPXBGKy81Fc1T9ov5SHs3w1RAEBMe+Md+nO56KvYrL3Gge8s8m0DD7BlNTwHgfqS9OjxCTieeBxEOHLU1Ax930dzlov4qXzLPE+RF/eYrVZlZOBbteSuxl0nDmwYFNqpzhgetKrmayCaxDBBzDs0OULGDuEXHAg/ntFjK2tpi6iqQx5eLqpYKwzimhsfPtmk23H7s7mMP6etCjXdPKFeHofr/leNr1qXe9pB1t6FUYMRWO0t2ArgjVNAVbgSV9xy03+sZvIQwq+hikf5OK58m/Xjl/DroIrAfqRgV8J1gdBFiEyybaK+5d8Ju1Iy/+OaMGdGhcfE+AYaKA0vZvN9LzOgxujXdTLcuNzIBifZfFqp0x8PgDgwM0
X-MS-Exchange-AntiSpam-MessageData: zcLP1gHoV+Jw5f2ZawV8e2gUucl4/GH0k3QUnzgL64xSliR3G0v5NUy0HcX1csN2INNMUdbt9TFh1rfxaXh8zhp4MtPnPphrjyCkx1gZhG4T6JIzWyVyhANsWoGmbBH7TucmR6jOOmYUT4bzSqXG+w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f183c24-d3e2-4658-48d9-08d7cfcde7fe
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 08:32:38.4828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJ0ZaPEihQmcWjHX/Xnzyt6f3gt4tZHrle4xgmdn+f52M7KBEhmSVmzZkTtvwJerpinC20dahtbDgjzW+jyqf8voFBVkNPdJEJ2cFVla1IA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5383
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.129
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

14.03.2020 0:07, Eric Blake wrote:
> On 3/2/20 4:05 AM, Vladimir Sementsov-Ogievskiy wrote:
>> NBD spec is updated, so that max_block doesn't relate to
>=20
> Maybe: The NBD spec was recently updated to clarify that max_block...
>=20
>> NBD_CMD_WRITE_ZEROES with NBD_CMD_FLAG_FAST_ZERO (which mirrors Qemu
>> flag BDRV_REQ_NO_FALLBACK). To drop the restriction we need new
>> max_pwrite_zeroes_no_fallback.
>=20
> It feels odd to have two different pwrite_zeroes limits in the block laye=
r, but I can live with it if other block layer gurus are also okay with it.
>=20
>>
>> Default value of new max_pwrite_zeroes_no_fallback is zero and it means
>> no-restriction, so we are automatically done by this commit. Note that
>=20
> Why not have the default value be set to the existing value of the normal=
 pwrite_zeroes limit, rather than 0?
>=20
>> nbd and blkdebug are the only drivers which in the same time define
>> max_pwrite_zeroes limit and support BDRV_REQ_NO_FALLBACK, so we need to
>> update only blkdebug.
>=20
> Grammar:
>=20
> The default value for the new max_pwrite_zeroes_no_fallback is zero, mean=
ing no restriction, which covers all drivers not touched by this commit.=A0=
 Note that nbd and blkdebug are the only drivers which have a max_pwrite_ze=
roes limit while supporting BDRV_REQ_NO_FALLBACK, so we only need to update=
 blkdebug.
>=20
> Except that I think there IS still a limit in current NBD: you can't requ=
est anything larger than 32 bits (whereas some other drivers may allow a fu=
ll 63-bit request, as well as future NBD usage when we finally add 64-bit e=
xtensions to the protocol).=A0 So I think this patch is incomplete; it shou=
ld be updating the nbd code to set the proper limit.
>=20
> (I still need to post v2 of my patches for bdrv_co_make_zero support, whi=
ch is a case where knowing if there is a 32-bit limit when using BDRV_REQ_N=
O_FALLBACK for fast zeroing is important).
>=20
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =A0 include/block/block_int.h | 8 ++++++++
>> =A0 block/blkdebug.c=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 7 ++++++-
>> =A0 block/io.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 4 +++-
>> =A0 3 files changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>> index 6f9fd5e20e..c167e887c6 100644
>> --- a/include/block/block_int.h
>> +++ b/include/block/block_int.h
>> @@ -618,6 +618,14 @@ typedef struct BlockLimits {
>> =A0=A0=A0=A0=A0=A0 * pwrite_zeroes_alignment. May be 0 if no inherent 32=
-bit limit */
>> =A0=A0=A0=A0=A0 int32_t max_pwrite_zeroes;
>> +=A0=A0=A0 /*
>> +=A0=A0=A0=A0 * Maximum number of bytes that can zeroized at once if fla=
g
>=20
> zeroed
>=20
>> +=A0=A0=A0=A0 * BDRV_REQ_NO_FALLBACK specified (since it is signed, it m=
ust be < 2G, if
>> +=A0=A0=A0=A0 * set).
>=20
> Why must it be a signed 32-bit number?=A0 Why not let it be a 64-bit numb=
er?
>=20
>> Must be multiple of pwrite_zeroes_alignment. May be 0 if no
>> +=A0=A0=A0=A0 * inherent 32-bit limit.
>> +=A0=A0=A0=A0 */
>> +=A0=A0=A0 int32_t max_pwrite_zeroes_no_fallback;
>> +
>> =A0=A0=A0=A0=A0 /* Optimal alignment for write zeroes requests in bytes.=
 A power
>> =A0=A0=A0=A0=A0=A0 * of 2 is best but not mandatory.=A0 Must be a multip=
le of
>> =A0=A0=A0=A0=A0=A0 * bl.request_alignment, and must be less than max_pwr=
ite_zeroes
>> diff --git a/block/blkdebug.c b/block/blkdebug.c
>> index af44aa973f..7627fbcb3b 100644
>> --- a/block/blkdebug.c
>> +++ b/block/blkdebug.c
>> @@ -692,7 +692,11 @@ static int coroutine_fn blkdebug_co_pwrite_zeroes(B=
lockDriverState *bs,
>> =A0=A0=A0=A0=A0 }
>> =A0=A0=A0=A0=A0 assert(QEMU_IS_ALIGNED(offset, align));
>> =A0=A0=A0=A0=A0 assert(QEMU_IS_ALIGNED(bytes, align));
>> -=A0=A0=A0 if (bs->bl.max_pwrite_zeroes) {
>> +=A0=A0=A0 if ((flags & BDRV_REQ_NO_FALLBACK) &&
>> +=A0=A0=A0=A0=A0=A0=A0 bs->bl.max_pwrite_zeroes_no_fallback)
>> +=A0=A0=A0 {
>> +=A0=A0=A0=A0=A0=A0=A0 assert(bytes <=3D bs->bl.max_pwrite_zeroes_no_fal=
lback);
>> +=A0=A0=A0 } else if (bs->bl.max_pwrite_zeroes) {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 assert(bytes <=3D bs->bl.max_pwrite_zeroes);
>> =A0=A0=A0=A0=A0 }
>> @@ -977,6 +981,7 @@ static void blkdebug_refresh_limits(BlockDriverState=
 *bs, Error **errp)
>> =A0=A0=A0=A0=A0 }
>> =A0=A0=A0=A0=A0 if (s->max_write_zero) {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 bs->bl.max_pwrite_zeroes =3D s->max_write_ze=
ro;
>> +=A0=A0=A0=A0=A0=A0=A0 bs->bl.max_pwrite_zeroes_no_fallback =3D s->max_w=
rite_zero;
>=20
> Ah, so you DO default it to max_pwwrite_zeroes instead of to 0; the commi=
t message does not quite match the code.
>=20
>> =A0=A0=A0=A0=A0 }
>> =A0=A0=A0=A0=A0 if (s->opt_discard) {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 bs->bl.pdiscard_alignment =3D s->opt_discard=
;
>> diff --git a/block/io.c b/block/io.c
>> index 7e4cb74cf4..75fd5600c2 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -1752,7 +1752,9 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(B=
lockDriverState *bs,
>> =A0=A0=A0=A0=A0 int head =3D 0;
>> =A0=A0=A0=A0=A0 int tail =3D 0;
>> -=A0=A0=A0 int max_write_zeroes =3D MIN_NON_ZERO(bs->bl.max_pwrite_zeroe=
s, INT_MAX);
>> +=A0=A0=A0 int max_write_zeroes =3D MIN_NON_ZERO((flags & BDRV_REQ_NO_FA=
LLBACK) ?
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bs->bl.max_pwrite_zeroes_n=
o_fallback :
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bs->bl.max_pwrite_zeroes, =
INT_MAX);
>=20
> I'd still like to get rid of this INT_MAX clamping.=A0 If we can blank th=
e entire image in one call, even when it is larger than 4G, then it is wort=
h making that exposed to the user.=A0 (Even in NBD, we might decide to add =
an extension that allows NBD_CMD_WRITE_ZEROES with a new flag and with offs=
et/length =3D=3D 0/0, as an official way to make the entire image zero, whe=
reas it is now currently unspecified to pass a length of 0).
>=20

Hmm. This series is kind of hacking. Now, 5.0 is missed anyway, I think, I'=
ll prepare something more complete. It would be good to prepare generic blo=
ck layer for 64bit commands.

>> =A0=A0=A0=A0=A0 int alignment =3D MAX(bs->bl.pwrite_zeroes_alignment,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 bs->bl.request_alignment);
>> =A0=A0=A0=A0=A0 int max_transfer =3D MIN_NON_ZERO(bs->bl.max_transfer, M=
AX_BOUNCE_BUFFER);
>>
>=20


--=20
Best regards,
Vladimir

