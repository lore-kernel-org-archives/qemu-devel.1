Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA299C432C0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 03:29:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AACA4206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 03:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AACA4206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icLLr-0004lN-S0
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 22:29:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1icLDn-0002sG-Vn
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 22:21:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1icLDg-0000NC-SP
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 22:20:55 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2272 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1icLDa-00007t-PP; Tue, 03 Dec 2019 22:20:47 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 916236F200898A4A6201;
 Wed,  4 Dec 2019 11:20:38 +0800 (CST)
Received: from [127.0.0.1] (10.120.177.99) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Dec 2019
 11:20:28 +0800
Subject: Re: [PATCH V3 1/2] block/nbd: extract the common cleanup code
To: Eric Blake <eblake@redhat.com>, <kwolf@redhat.com>, <mreitz@redhat.com>,
 <sgarzare@redhat.com>
References: <1575012326-51324-1-git-send-email-pannengyuan@huawei.com>
 <c700a37d-d31d-f0e7-4edb-4872c4f0e5c2@redhat.com>
From: pannengyuan <pannengyuan@huawei.com>
Message-ID: <1368fe73-82e3-c296-d556-83f146de0072@huawei.com>
Date: Wed, 4 Dec 2019 11:20:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <c700a37d-d31d-f0e7-4edb-4872c4f0e5c2@redhat.com>
Content-Type: text/plain; charset="utf-8"
X-Originating-IP: [10.120.177.99]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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
Cc: liyiting@huawei.com, kuhn.chenqun@huawei.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2019/12/4 3:00, Eric Blake wrote:
> On 11/29/19 1:25 AM, pannengyuan@huawei.com wrote:
>> From: PanNengyuan <pannengyuan@huawei.com>
>>
>> The BDRVNBDState cleanup code is common in two places, add
>> nbd_free_bdrvstate_prop() function to do these cleanups (suggested by
>> Stefano Garzarella).
>>
>> Signed-off-by: PanNengyuan <pannengyuan@huawei.com>
>> ---
>> =C2=A0 block/nbd.c | 23 +++++++++++++----------
>> =C2=A0 1 file changed, 13 insertions(+), 10 deletions(-)
>>
>> diff --git a/block/nbd.c b/block/nbd.c
>> index 1239761..5805979 100644
>> --- a/block/nbd.c
>> +++ b/block/nbd.c
>> @@ -94,6 +94,8 @@ typedef struct BDRVNBDState {
>> =C2=A0 =C2=A0 static int nbd_client_connect(BlockDriverState *bs, Erro=
r **errp);
>> =C2=A0 +static void nbd_free_bdrvstate_prop(BDRVNBDState *s);
>> +
>=20
> Why do you need a static function prototype?=C2=A0 Just implement the
> function prior to its first use, then you won't need a forward declarat=
ion.

Yes, It's not necessary. I will change it.

>=20
>> =C2=A0 static void nbd_channel_error(BDRVNBDState *s, int ret)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret =3D=3D -EIO) {
>> @@ -1486,6 +1488,15 @@ static int nbd_client_connect(BlockDriverState
>> *bs, Error **errp)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
>> =C2=A0 +static void nbd_free_bdrvstate_prop(BDRVNBDState *s)
>> +{
>> +=C2=A0=C2=A0=C2=A0 object_unref(OBJECT(s->tlscreds));
>> +=C2=A0=C2=A0=C2=A0 qapi_free_SocketAddress(s->saddr);
>> +=C2=A0=C2=A0=C2=A0 g_free(s->export);
>> +=C2=A0=C2=A0=C2=A0 g_free(s->tlscredsid);
>> +=C2=A0=C2=A0=C2=A0 g_free(s->x_dirty_bitmap);
>> +}
>=20
> In fact, it appears that you did just that, as the first use...
>=20
> Bike-shedding: the name 'nbd_free_bdrvstate_prop' doesn't seem right to
> me - when I see a function with 'free' in the name taking a single
> pointer, I assume that the given pointer (here, BDRVNBDState *s) is
> freed - but your function does NOT free then incoming pointer.=C2=A0 Ra=
ther,
> you are clearing out the contents within a pre-allocated object which
> remains allocated.=C2=A0 What's more, since the object remains allocate=
d, I'm
> surprised that you are not setting fields to NULL to prevent
> use-after-free bugs.
>=20
> Either this function should also free s (in which case naming it merely
> 'nbd_free_bdrvstate' might be better), or you should consider naming it
> 'nbd_clear_bdrvstate' and assigning cleared fields to NULL.
>=20

thanks, 'nbd_clear_bdrvstate' seems nice. I will replace the name and
set fields to NULL in next version.

>> +
>> =C2=A0 /*
>> =C2=A0=C2=A0 * Parse nbd_open options
>> =C2=A0=C2=A0 */
>> @@ -1855,10 +1866,7 @@ static int nbd_process_options(BlockDriverState
>> *bs, QDict *options,
>> =C2=A0 =C2=A0=C2=A0 error:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 object_unref(OBJECT(s->tls=
creds));
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qapi_free_SocketAddress(s-=
>saddr);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(s->export);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(s->tlscredsid);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nbd_free_bdrvstate_prop(s)=
;
>=20
> ...is here.
>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_opts_del(opts);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> @@ -1937,12 +1945,7 @@ static void nbd_close(BlockDriverState *bs)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRVNBDState *s =3D bs->opaque;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nbd_client_close(bs);
>> -
>> -=C2=A0=C2=A0=C2=A0 object_unref(OBJECT(s->tlscreds));
>> -=C2=A0=C2=A0=C2=A0 qapi_free_SocketAddress(s->saddr);
>> -=C2=A0=C2=A0=C2=A0 g_free(s->export);
>> -=C2=A0=C2=A0=C2=A0 g_free(s->tlscredsid);
>> -=C2=A0=C2=A0=C2=A0 g_free(s->x_dirty_bitmap);
>> +=C2=A0=C2=A0=C2=A0 nbd_free_bdrvstate_prop(s);
>> =C2=A0 }
>> =C2=A0 =C2=A0 static int64_t nbd_getlength(BlockDriverState *bs)
>>
>=20


