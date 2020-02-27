Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10FBC3F35D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:01:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E505246AC
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vukbVBaa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E505246AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7JjJ-0001w8-Mw
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 09:01:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40853)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7JhV-000051-4m
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:59:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7JhS-0007Yu-Uy
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:59:41 -0500
Received: from mail-am6eur05on20727.outbound.protection.outlook.com
 ([2a01:111:f400:7e1b::727]:21696
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j7JhN-0007W0-4x; Thu, 27 Feb 2020 08:59:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NR126Jj8lax17TE7d62gA+JpaZPn6dH8l20fJyf5vTpFn34PMXz8W7kWA7lDyamDMxJMC1LGa2/bAbRtzHcLDyEOzszxe5hCJc5eyFW8pQfBKZHy1LE8RMeWi//N2/eBYqXkFiYieqBxVBTicYqnUt990+7U/IZ0yfxW5LkYLlZo159ZRqr4A9zLHNT+BN6UV29K9y+A44C6nqDnT2vR2IjJj6n6OUhFgpnfw3k0Pu4p6rHJ9/fhp1023vWMm6SkhUeMzk69vUHqYrpJJ27Q+UzEUxqbqWRDJnr3rwJjpvupqtErq0bZ1ThUr21kaNjwZY8O1gpghePgGbtidjKYGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Tnq3OYw2V22K2JlyCVTMnfDxACOCIdw8lNEy33oWFY=;
 b=IVZvQZbejNY3Pclhq+68N6lMZnx6SmMCCzUnRwnOtphmPtcSXOJvzMgFww34MOWQGY79Z6/uiVyZ3ibRLUwRmpMLH7srfr7BnlDr3xriuQP5Fdila7Hf2gIGCVfWGlByKT4QapVomr8sOhKZdfqV4tQhML1t3iQXUr+TsT3OuXwWVC6cqwGnRtPtFznwPMDZmk3dLfIrHnDWTPV1mUG4eEzYos07AD/zHuRbakpMB32XofJ6Sjtz89l1wWnEB/PnVrP+Q+yKCmJ2M8CkUQcx2gevj4MFxa0n5zMjyzqdrqokZ4w/lvznP3oszKmzzKUih9ID9/ehyeqzDUA+TlkQww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Tnq3OYw2V22K2JlyCVTMnfDxACOCIdw8lNEy33oWFY=;
 b=vukbVBaaR7FdTQcAptSsNtNWLTgQ7G+ciSRQIx3T9A0N4oUzjLUbOnN7716K8a3R906Mplg3dBIOOmHT7l7ZiUvvWsxi2Iu64pV7mMNG4q6xE+8PeZW+JXcMfhC4vQ2GMzUbDj/vDgyW/nx9xCfTGvTQoVTRl32RpFdmiGZd/JE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com (20.179.28.138) by
 VI1PR08MB3823.eurprd08.prod.outlook.com (20.178.80.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Thu, 27 Feb 2020 13:59:27 +0000
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::91aa:2540:62c:aeda]) by VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::91aa:2540:62c:aeda%5]) with mapi id 15.20.2750.024; Thu, 27 Feb 2020
 13:59:27 +0000
Subject: Re: [PATCH v1 1/8] qcow2: introduce compression type feature
To: Eric Blake <eblake@redhat.com>, Denis Plotnikov
 <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200227072953.25445-1-dplotnikov@virtuozzo.com>
 <20200227072953.25445-2-dplotnikov@virtuozzo.com>
 <501fde69-f116-a3b9-0356-05708f0b78b7@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200227165924499
Message-ID: <78aa28c9-49a4-ac0a-51c5-e3587f46603d@virtuozzo.com>
Date: Thu, 27 Feb 2020 16:59:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <501fde69-f116-a3b9-0356-05708f0b78b7@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1P195CA0014.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::24)
 To VI1PR08MB4432.eurprd08.prod.outlook.com
 (2603:10a6:803:102::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1P195CA0014.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Thu, 27 Feb 2020 13:59:26 +0000
X-Tagtoolbar-Keys: D20200227165924499
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3db5e1c-79d8-450d-c3bd-08d7bb8d4259
X-MS-TrafficTypeDiagnostic: VI1PR08MB3823:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB3823D71D208ABFC0F09E981BC1EB0@VI1PR08MB3823.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(39850400004)(346002)(366004)(376002)(136003)(396003)(189003)(199004)(186003)(16526019)(4326008)(8936002)(66476007)(956004)(5660300002)(66556008)(31696002)(66946007)(86362001)(36756003)(966005)(6486002)(31686004)(8676002)(81166006)(2616005)(478600001)(26005)(316002)(110136005)(2906002)(30864003)(52116002)(81156014)(16576012)(53546011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3823;
 H:VI1PR08MB4432.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uxqFFZKPa8S+YsFe0vLmdTtETVKUIniP5+eHDIzNDK8yeM5kadj75T4HyUVeQlftpUU1auhDqsrnRnnzeRqG/DyTPmVm6lX9Zd1mDsrF8puM/vhu3K6yp3YyBsLkJa/nDY2Eu0t3sdnnvsobfP2XWPyAlKTJtTE5bAsJqCFdrR5qkvO8UUJ9299Fi/zL0eN51tFbE8u2MtK30gBUQetLFpF3cb2ZRu8Pg49bMSio9KrtExFdXCh2hS58Pp7tzEBjewbNueY2SDvbo9hP8kvSh6mKYswAilI+yjs/Ui2tmfhxzt9qdmjB5ozjfDBL+gBMZrYcOtWLGVtHOav2clb5av89z35U16m9yAFlnoN3d8jI1EbjxF0TcIZn3Mz3xZ7KNk0AV+TLuVZLQUQli3SgqojGOI35ESw4gj/BqVb4uNI6G1dVdWpVd63nNgtvIcNsnLhq4F/bYLHhgca6/Ud0e3EP3pa5nFBh47R2eU2j2wXDUATV+UYw0Y0Jc1cdwRi5UxdKzfNOISrdKtNcYEVyVQ==
X-MS-Exchange-AntiSpam-MessageData: fVu5ZLEIj5UkF2vtzmIB8idEJXnegYxe/fCDY7cW+FbSqHIo/2qiHniyIICidV42q389mpY1mD7l82ddHVLWCmAC3JzjDXnODfv+/RMlax/G1XuiqQChnsDSdxthHcwhin3VjFp0y1yCGEr9hMPmCg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3db5e1c-79d8-450d-c3bd-08d7bb8d4259
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 13:59:27.6445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YAgtlguS7hdjRVU6XKbnhSS71YXyp37i8P2QC83Sa8DrwXQ9jXfsEfTJHID0G6WAvkR93xCGi/qK2Scji80j1WUhC+s6hKywWoKCVXy8HqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3823
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:111:f400:7e1b::727
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
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

27.02.2020 16:48, Eric Blake wrote:
> On 2/27/20 1:29 AM, Denis Plotnikov wrote:
>> The patch adds some preparation parts for incompatible compression type
>> feature to Qcow2 that indicates which allow to use different compression
>=20
> to qcow2, allowing the use of different
>=20
>> methods for image clusters (de)compressing.
>>
>> It is implied that the compression type is set on the image creation and
>> can be changed only later by image conversion, thus compression type
>> defines the only compression algorithm used for the image, and thus,
>> for all image clusters.
>>
>> The goal of the feature is to add support of other compression methods
>> to qcow2. For example, ZSTD which is more effective on compression than =
ZLIB.
>>
>> The default compression is ZLIB. Images created with ZLIB compression ty=
pe
>> are backward compatible with older qemu versions.
>>
>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> ---
>> =A0 block/qcow2.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 105 ++++++++++++=
++++++++++++++++++++++++++
>> =A0 block/qcow2.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 31 ++++++++--=
-
>> =A0 include/block/block_int.h |=A0=A0 1 +
>> =A0 qapi/block-core.json=A0=A0=A0=A0=A0 |=A0 22 +++++++-
>> =A0 4 files changed, 150 insertions(+), 9 deletions(-)
>>
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index 3c754f616b..2ccb2cabd1 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -1242,6 +1242,50 @@ static int qcow2_update_options(BlockDriverState =
*bs, QDict *options,
>> =A0=A0=A0=A0=A0 return ret;
>> =A0 }
>> +static int validate_compression_type(BDRVQcow2State *s, Error **errp)
>> +{
>> +=A0=A0=A0 /*
>> +=A0=A0=A0=A0 * Sanity check
>> +=A0=A0=A0=A0 * according to qcow2 spec, the compression type is 1-byte =
field
>> +=A0=A0=A0=A0 * but in BDRVQcow2State the compression_type is enum sizeo=
f(int)
>> +=A0=A0=A0=A0 * so, the max compression_type value is 255.
>> +=A0=A0=A0=A0 */
>> +=A0=A0=A0 if (s->compression_type > 0xff) {
>> +=A0=A0=A0=A0=A0=A0=A0 error_setg(errp, "qcow2: compression type value i=
s too big");
>> +=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;
>> +=A0=A0=A0 }
>=20
> Hmm - I think it may be worth a tweak to qcow2.txt to call out:
>=20
> 104: compression_type
> 105 - 111: padding, must be 0
>=20
> or else call out:
>=20
> 104-111: compression type
>=20
> and just blindly use all 8 bytes for the value even though really only 1 =
or two values will ever be defined.=A0 Of course, that moves the byte in qu=
estion from 104 to 111, thanks to our big endian encoding, but as this seri=
es is the first one installing a non-zero value in those 8 bytes, and as we=
 just finished documenting that the header length must be a multiple of 8, =
there is no real impact - we can make such tweaks up until the 5.0 release.

But what is the benefit? We have already documented padding in the spec, an=
d discussed it so much time... What is the problem with padding? And why to=
 add 8 bytes for every new feature which needs only one byte?

>=20
>> +
>> +=A0=A0=A0 switch (s->compression_type) {
>> +=A0=A0=A0 case QCOW2_COMPRESSION_TYPE_ZLIB:
>> +=A0=A0=A0=A0=A0=A0=A0 break;
>> +
>> +=A0=A0=A0 default:
>> +=A0=A0=A0=A0=A0=A0=A0 error_setg(errp, "qcow2: unknown compression type=
: %u",
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 s->compression_t=
ype);
>> +=A0=A0=A0=A0=A0=A0=A0 return -ENOTSUP;
>> +=A0=A0=A0 }
>=20
> Having two checks feels redundant, compared to just letting the default c=
atch all unrecognized values in that field.
>=20
>> +
>> +=A0=A0=A0 /*
>> +=A0=A0=A0=A0 * if the compression type differs from QCOW2_COMPRESSION_T=
YPE_ZLIB
>> +=A0=A0=A0=A0 * the incompatible feature flag must be set
>> +=A0=A0=A0=A0 */
>> +=A0=A0=A0 if (s->compression_type =3D=3D QCOW2_COMPRESSION_TYPE_ZLIB) {
>> +=A0=A0=A0=A0=A0=A0=A0 if (s->incompatible_features & QCOW2_INCOMPAT_COM=
PRESSION_TYPE) {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 error_setg(errp, "qcow2: Compression =
type incompatible feature "
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 "bit must not be set");
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;
>> +=A0=A0=A0=A0=A0=A0=A0 }
>> +=A0=A0=A0 } else {
>> +=A0=A0=A0=A0=A0=A0=A0 if (!(s->incompatible_features & QCOW2_INCOMPAT_C=
OMPRESSION_TYPE)) {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 error_setg(errp, "qcow2: Compression =
type incompatible feature "
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 "bit must be set");
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;
>> +=A0=A0=A0=A0=A0=A0=A0 }
>> +=A0=A0=A0 }
>=20
> Matches what we documented in the spec.
>=20
>> +
>> +=A0=A0=A0 return 0;
>> +}
>> +
>> =A0 /* Called with s->lock held.=A0 */
>> =A0 static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *o=
ptions,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int flags, Error **errp)
>> @@ -1357,6 +1401,26 @@ static int coroutine_fn qcow2_do_open(BlockDriver=
State *bs, QDict *options,
>> =A0=A0=A0=A0=A0 s->compatible_features=A0=A0=A0=A0=A0 =3D header.compati=
ble_features;
>> =A0=A0=A0=A0=A0 s->autoclear_features=A0=A0=A0=A0=A0=A0 =3D header.autoc=
lear_features;
>> +=A0=A0=A0 /*
>> +=A0=A0=A0=A0 * Handle compression type
>> +=A0=A0=A0=A0 * Older qcow2 images don't contain the compression type he=
ader.
>> +=A0=A0=A0=A0 * Distinguish them by the header length and use
>> +=A0=A0=A0=A0 * the only valid (default) compression type in that case
>> +=A0=A0=A0=A0 */
>> +=A0=A0=A0 if (header.header_length > offsetof(QCowHeader, compression_t=
ype)) {
>> +=A0=A0=A0=A0=A0=A0=A0 /*
>> +=A0=A0=A0=A0=A0=A0=A0=A0 * don't deal with endians since compression_ty=
pe is 1 byte long
>> +=A0=A0=A0=A0=A0=A0=A0=A0 */
>> +=A0=A0=A0=A0=A0=A0=A0 s->compression_type =3D header.compression_type;
>=20
> Changes if you go with my suggestion of just making the compression_type =
field occupy 8 bytes in the qcow2 header.=A0 (And if you want to keep it 1 =
byte, I still think the spec should call out explicit padding bytes).
>=20
>> +=A0=A0=A0 } else {
>> +=A0=A0=A0=A0=A0=A0=A0 s->compression_type =3D QCOW2_COMPRESSION_TYPE_ZL=
IB;
>> +=A0=A0=A0 }
>> +
>> +=A0=A0=A0 ret =3D validate_compression_type(s, errp);
>> +=A0=A0=A0 if (ret) {
>> +=A0=A0=A0=A0=A0=A0=A0 goto fail;
>> +=A0=A0=A0 }
>> +
>> =A0=A0=A0=A0=A0 if (s->incompatible_features & ~QCOW2_INCOMPAT_MASK) {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 void *feature_table =3D NULL;
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 qcow2_read_extensions(bs, header.header_leng=
th, ext_end,
>> @@ -2720,6 +2784,12 @@ int qcow2_update_header(BlockDriverState *bs)
>> =A0=A0=A0=A0=A0 total_size =3D bs->total_sectors * BDRV_SECTOR_SIZE;
>> =A0=A0=A0=A0=A0 refcount_table_clusters =3D s->refcount_table_size >> (s=
->cluster_bits - 3);
>> +=A0=A0=A0 ret =3D validate_compression_type(s, NULL);
>> +
>> +=A0=A0=A0 if (ret) {
>> +=A0=A0=A0=A0=A0=A0=A0 goto fail;
>> +=A0=A0=A0 }
>> +
>> =A0=A0=A0=A0=A0 *header =3D (QCowHeader) {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Version 2 fields */
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 .magic=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =3D cpu_to_be32(QCOW_MAGIC),
>> @@ -2742,6 +2812,7 @@ int qcow2_update_header(BlockDriverState *bs)
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 .autoclear_features=A0=A0=A0=A0 =3D cpu_to_b=
e64(s->autoclear_features),
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 .refcount_order=A0=A0=A0=A0=A0=A0=A0=A0 =3D =
cpu_to_be32(s->refcount_order),
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 .header_length=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=3D cpu_to_be32(header_length),
>> +=A0=A0=A0=A0=A0=A0=A0 .compression_type=A0=A0=A0=A0=A0=A0 =3D (uint8_t)=
 s->compression_type,
>=20
> Is the cast necessary?
>=20
>> =A0=A0=A0=A0=A0 };
>> =A0=A0=A0=A0=A0 /* For older versions, write a shorter header */
>> @@ -2839,6 +2910,11 @@ int qcow2_update_header(BlockDriverState *bs)
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .bit=A0 =3D QCOW2_CO=
MPAT_LAZY_REFCOUNTS_BITNR,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .name =3D "lazy refc=
ounts",
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 },
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .type =3D QCOW2_FEAT_TYPE=
_INCOMPATIBLE,
>=20
> Ordering: please group all the incompatible bits side-by-side (this shoul=
d come before the lazy refcount bit).
>=20
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .bit=A0 =3D QCOW2_INCOMPA=
T_COMPRESSION_TYPE_BITNR,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .name =3D "compression ty=
pe",
>=20
> This change breaks iotests; at least 31, 36, and 61 need updates (I've go=
t a similar patch pending which fixes the fact that we forgot the autoclear=
 bit [1]).=A0 You'll need to squash in fixes for those at the same time.
>=20
> [1] https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg08069.html
>=20
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 },
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 };
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D header_ext_add(buf, QCOW2_EXT_MAGIC_=
FEATURE_TABLE,
>> @@ -3401,6 +3477,7 @@ qcow2_co_create(BlockdevCreateOptions *create_opti=
ons, Error **errp)
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 .refcount_table_offset=A0=A0=A0=A0=A0 =3D cp=
u_to_be64(cluster_size),
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 .refcount_table_clusters=A0=A0=A0 =3D cpu_to=
_be32(1),
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 .refcount_order=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 =3D cpu_to_be32(refcount_order),
>> +=A0=A0=A0=A0=A0=A0=A0 .compression_type=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=3D (uint8_t) QCOW2_COMPRESSION_TYPE_ZLIB,
>=20
> Is the cast necessary?
>=20
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 .header_length=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 =3D cpu_to_be32(sizeof(*header)),
>> =A0=A0=A0=A0=A0 };
>> @@ -3420,6 +3497,26 @@ qcow2_co_create(BlockdevCreateOptions *create_opt=
ions, Error **errp)
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cpu_to_be64(QCOW2_AUTOCLEAR_DATA=
_FILE_RAW);
>> =A0=A0=A0=A0=A0 }
>> +=A0=A0=A0 if (qcow2_opts->has_compression_type &&
>> +=A0=A0=A0=A0=A0=A0=A0 qcow2_opts->compression_type !=3D QCOW2_COMPRESSI=
ON_TYPE_ZLIB) {
>> +
>> +=A0=A0=A0=A0=A0=A0=A0 if (qcow2_opts->compression_type > 0xff) {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 error_setg_errno(errp, -EINVAL, "Too =
big compression type value");
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out;
>> +=A0=A0=A0=A0=A0=A0=A0 }
>> +
>> +=A0=A0=A0=A0=A0=A0=A0 switch (qcow2_opts->compression_type) {
>> +=A0=A0=A0=A0=A0=A0=A0 default:
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 error_setg_errno(errp, -EINVAL, "Unkn=
own compression type");
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out;
>> +=A0=A0=A0=A0=A0=A0=A0 }
>=20
> This should probably be an assert that qcow2_opts->compression_type is in=
 range, rather than a switch statement and error_setg.=A0 Callers of qcow2_=
co_create should not be handing us unknown values.
>=20
>> +
>> +=A0=A0=A0=A0=A0=A0=A0 header->compression_type =3D (uint8_t) qcow2_opts=
->compression_type;
>=20
> Why the cast?
>=20
>> +
>> +=A0=A0=A0=A0=A0=A0=A0 header->incompatible_features |=3D
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cpu_to_be64(QCOW2_INCOMPAT_COMPRESSIO=
N_TYPE);
>> +=A0=A0=A0 }
>> +
>> =A0=A0=A0=A0=A0 ret =3D blk_pwrite(blk, 0, header, cluster_size, 0);
>> =A0=A0=A0=A0=A0 g_free(header);
>> =A0=A0=A0=A0=A0 if (ret < 0) {
>> @@ -3602,6 +3699,7 @@ static int coroutine_fn qcow2_co_create_opts(const=
 char *filename, QemuOpts *opt
>=20
>> +++ b/block/qcow2.h
>> @@ -146,6 +146,12 @@ typedef struct QCowHeader {
>> =A0=A0=A0=A0=A0 uint32_t refcount_order;
>> =A0=A0=A0=A0=A0 uint32_t header_length;
>> +
>> +=A0=A0=A0 /* Additional fields */
>> +=A0=A0=A0 uint8_t=A0 compression_type;
>> +
>> +=A0=A0=A0 /* header must be a multiple of 8 */
>> +=A0=A0=A0 uint8_t=A0 padding[7];
>> =A0 } QEMU_PACKED QCowHeader;
>=20
> You're changing the size of this struct, which WILL break iotests (and ev=
en more than just the 3 I pointed out above for the feature name table).
>=20
> /me looks ahead
>=20
> Aha - you even noticed it: patch 7/8 fixes test 80.=A0 That fix needs to =
be squashed in here, where the change is made.
>=20
>> =A0 typedef struct QEMU_PACKED QCowSnapshotHeader {
>> @@ -213,16 +219,20 @@ enum {
>> =A0 /* Incompatible feature bits */
>> =A0 enum {
>> -=A0=A0=A0 QCOW2_INCOMPAT_DIRTY_BITNR=A0=A0=A0=A0=A0 =3D 0,
>> -=A0=A0=A0 QCOW2_INCOMPAT_CORRUPT_BITNR=A0=A0=A0 =3D 1,
>> -=A0=A0=A0 QCOW2_INCOMPAT_DATA_FILE_BITNR=A0 =3D 2,
>> -=A0=A0=A0 QCOW2_INCOMPAT_DIRTY=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 1 <=
< QCOW2_INCOMPAT_DIRTY_BITNR,
>> -=A0=A0=A0 QCOW2_INCOMPAT_CORRUPT=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 1 << QC=
OW2_INCOMPAT_CORRUPT_BITNR,
>> -=A0=A0=A0 QCOW2_INCOMPAT_DATA_FILE=A0=A0=A0=A0=A0=A0=A0 =3D 1 << QCOW2_=
INCOMPAT_DATA_FILE_BITNR,
>> +=A0=A0=A0 QCOW2_INCOMPAT_DIRTY_BITNR=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=3D 0,
>> +=A0=A0=A0 QCOW2_INCOMPAT_CORRUPT_BITNR=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 1=
,
>> +=A0=A0=A0 QCOW2_INCOMPAT_DATA_FILE_BITNR=A0=A0=A0=A0=A0=A0=A0 =3D 2,
>> +=A0=A0=A0 QCOW2_INCOMPAT_COMPRESSION_TYPE_BITNR =3D 3,
>> +=A0=A0=A0 QCOW2_INCOMPAT_DIRTY=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 =3D 1 << QCOW2_INCOMPAT_DIRTY_BITNR,
>> +=A0=A0=A0 QCOW2_INCOMPAT_CORRUPT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 =3D 1 << QCOW2_INCOMPAT_CORRUPT_BITNR,
>> +=A0=A0=A0 QCOW2_INCOMPAT_DATA_FILE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 =3D 1 << QCOW2_INCOMPAT_DATA_FILE_BITNR,
>> +=A0=A0=A0 QCOW2_INCOMPAT_COMPRESSION_TYPE=A0=A0=A0=A0=A0=A0 =3D
>> +=A0=A0=A0=A0=A0=A0=A0 1 << QCOW2_INCOMPAT_COMPRESSION_TYPE_BITNR,
>=20
> Uggh. I hate realigning =3D just because we added a longer name, especial=
ly when you then can't even keep things on one line because of length.=A0 I=
f it were me, I'd leave the existing lines alone, and/or switch everything =
to just use 'BITNR =3D ' rather than trying to align =3D.
>=20
> Bikeshedding - since the new name is so long, can you get by with the sho=
rter QCOW2_INCOMPAT_COMPRESSION_BITNR (drop the _TYPE)?
>=20


--=20
Best regards,
Vladimir

