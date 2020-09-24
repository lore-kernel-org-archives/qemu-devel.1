Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC72C4727D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:26:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95EE7239A1
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jW0oPgGl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95EE7239A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLPOU-0007GX-4j
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 07:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kLPHF-0005NN-FJ
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 07:19:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46677)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kLPHD-00040T-1G
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 07:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600946340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=CP8pe471sadaujYtQ42toBoLM0kH56szOsJNj0ieRxI=;
 b=jW0oPgGlgp0QM2rD/FpoRnvEABfwEySCpptkWjnBhjNEKjNu9P5SJZD6BGKLqDtPjTEzwN
 B45vSkYMFcwn6Q5rzHC64Ug9pbryyG2UyoF5/V303IesY9Y0gwZ50bH6kBy7ncwNA0pZMq
 EuDTJ+BCqhPB8urAcuEiS+NJdpmFPM4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-nVLxuL2FOk2FqrDT8lblVQ-1; Thu, 24 Sep 2020 07:18:56 -0400
X-MC-Unique: nVLxuL2FOk2FqrDT8lblVQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1329100746C;
 Thu, 24 Sep 2020 11:18:54 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-153.ams2.redhat.com
 [10.36.114.153])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B300C34800;
 Thu, 24 Sep 2020 11:18:52 +0000 (UTC)
Subject: Re: [PATCH v8 5/7] copy-on-read: limit guest writes to base in COR
 driver
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <1598633579-221780-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1598633579-221780-6-git-send-email-andrey.shinkevich@virtuozzo.com>
 <667dbbb4-b4b3-1e18-6c9b-466b75cbd00c@redhat.com>
 <716e4f2e-b15b-6094-badc-84d3daf9f8ab@virtuozzo.com>
 <c8e0ab87-b5e9-7b4b-6cc1-db404cbd4c80@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <037bc8a7-1e47-8599-a51f-4a884e5b348b@redhat.com>
Date: Thu, 24 Sep 2020 13:18:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <c8e0ab87-b5e9-7b4b-6cc1-db404cbd4c80@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1CqS3I0Zkupm3O2r6RHHRkK4HPazh2NR9"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1CqS3I0Zkupm3O2r6RHHRkK4HPazh2NR9
Content-Type: multipart/mixed; boundary="yPP6hWH5Jp7o6GjLmEH1Rjjhm7rzxQKiS"

--yPP6hWH5Jp7o6GjLmEH1Rjjhm7rzxQKiS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.09.20 15:13, Andrey Shinkevich wrote:
> On 04.09.2020 16:59, Vladimir Sementsov-Ogievskiy wrote:
>> 04.09.2020 15:50, Max Reitz wrote:
>>> On 28.08.20 18:52, Andrey Shinkevich wrote:
>>>> Limit the guest's COR operations by the base node in the backing chain
>>>> during a stream job.
>>>
>>> I don=E2=80=99t understand.=C2=A0=C2=A0 Shouldn=E2=80=99t we limit the =
areas where we set the COR
>>> flag?
>>>
>>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>>> ---
>>>> =C2=A0 block/copy-on-read.c | 49
>>>> +++++++++++++++++++++++++++++++++++++++++++++++++
>>>> =C2=A0 1 file changed, 49 insertions(+)
>>>>
>>>> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
>>>> index 1f858bb..ecbd1f8 100644
>>>> --- a/block/copy-on-read.c
>>>> +++ b/block/copy-on-read.c
>>>> @@ -57,6 +57,37 @@ static BlockDriverState
>>>> *get_base_by_name(BlockDriverState *bs,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return base_bs;
>>>> =C2=A0 }
>>>> =C2=A0 +/*
>>>> + * Returns 1 if the block is allocated in a node between
>>>> cor_filter_bs->file->bs
>>>> + * and the base_bs in the backing chain. Otherwise, returns 0.
>>>> + * The COR operation is allowed if the base_bs is not specified -
>>>> return 1.
>>>> + * Returns negative errno on failure.
>>>> + */
>>>> +static int node_above_base(BlockDriverState *cor_filter_bs,
>>>> uint64_t offset,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 uint64_t bytes)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 int ret;
>>>> +=C2=A0=C2=A0=C2=A0 int64_t dummy;
>>>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *file =3D NULL;
>>>> +=C2=A0=C2=A0=C2=A0 BDRVStateCOR *state =3D cor_filter_bs->opaque;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 if (!state->base_bs) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 ret =3D bdrv_block_status_above(cor_filter_bs->fil=
e->bs,
>>>> state->base_bs,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offset, bytes, &dumm=
y, NULL, &file);
>>>> +=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 if (file) {
>>>
>>> Why check file and not the return value?
>>>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>>
>>> =E2=80=9Cdummy=E2=80=9D should really not be called that way, it should=
 be evaluated
>>> whether it=E2=80=99s smaller than bytes.
>>>
>>> First, [offset, offset + dummy) may not be allocated above the base =E2=
=80=93
>>> but [offset + dummy, offset + bytes) may be.=C2=A0 Then this function r=
eturns
>>> 0 here, even though there is something in that range that=E2=80=99s all=
ocated.
>>>
>>> Second, in that case we still shouldn=E2=80=99t return 1, but return th=
e
>>> shrunken offset instead.=C2=A0 Or, if there are multiple distinct alloc=
ated
>>> areas, they should probably even all be copied separately.
>>>
>>>
>>> (But all of that of course only if this function is intended to be used
>>> to limit where we set the COR flag, because I don=E2=80=99t understand =
why we=E2=80=99d
>>> want to limit where something can be written.)
>>>
>>
>> Agree to all.
>>
>> 1. Write path shouldn't be changed: it's a copy-on-read filter.
>>
>> 2. On read we need is_allocated_above-driven loop, to insert the flag
>> only to regions allocated above base
>> =C2=A0(and other regions we read just without the flag, don't skip them)=
.
>> qiov_offset will help very well.
>>
>> 3. Like in many other places, let's ignore=C2=A0 errors (and just add th=
e
>> flag if block_status fails)
>=20
>=20
> If "block_status" fails, the stream job does not copy. Shall we keep the
> same behavior in the cor_co_preadv_part()?

I think copying can=E2=80=99t really hurt, so I think it would be better to=
 copy
if we aren=E2=80=99t sure (because block_status failed).  The difference to
streaming could well be considered a bug fix.

Max


--yPP6hWH5Jp7o6GjLmEH1Rjjhm7rzxQKiS--

--1CqS3I0Zkupm3O2r6RHHRkK4HPazh2NR9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9sgJoACgkQ9AfbAGHV
z0B3UAf+MIwSdv4BHfaNtI3EdMS05ehyEiynT55GoQmVLO2vOx9sp+rNJBfMz62R
YKkBxxfXtmDLlBZAlMWmXNK5WshsD4uqhqkl32MnAveiI421st8E2x0SLvfMid9g
JWD7S4eXodNyWlrKKtHdCUBc+798Q9kpi+mAEdUUJZuetnFHJETf6vz9otOLh+rO
Cf7gzD22fuoB0rFbsnfucj8Hgdi/t9cGzez0geLdpBi3W2KX+PHoGz7Dc7Jfu2LE
4BBJ11vBh2e6ppU8ZrnKPDbj3AkyILf8D899yOo5IqHDsYATB6sxO+tesTEKaH8N
Yv0KfqAKoTDOsvjpj2GFcI36jjYkDw==
=3JYe
-----END PGP SIGNATURE-----

--1CqS3I0Zkupm3O2r6RHHRkK4HPazh2NR9--


