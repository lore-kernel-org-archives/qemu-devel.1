Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6583C43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 08:55:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2248B20739
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 08:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PTK82fXo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2248B20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKHbh-0004dn-Au
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 04:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kKHaw-0003yc-5Z
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 04:54:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24457)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kKHau-0005N4-BA
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 04:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600678483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9TtunwzKRMWTlLklouBFrhatD+OCCzjYbwmhjiQqC6E=;
 b=PTK82fXohLD91SfYXOU2YBYTR2JrxSI0LhWRAdTsuTshcuCe5KzdBRmxHDRFaJL9ok9m8a
 5L3IvbcrbqajjxP47C4/D0MRApplTcodLnjxVojJnjan8pX2JgftwBw9G1wAH5DxGrYD9H
 7SbzBV3/MeAZqWwPhjAzXlGCeuw3qMM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-lXfqiDvaOtyAd4MzKnuojQ-1; Mon, 21 Sep 2020 04:54:40 -0400
X-MC-Unique: lXfqiDvaOtyAd4MzKnuojQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CB7F801A9E;
 Mon, 21 Sep 2020 08:54:39 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-169.ams2.redhat.com
 [10.36.113.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 04CD470105;
 Mon, 21 Sep 2020 08:54:35 +0000 (UTC)
Subject: Re: [PATCH v2 04/20] block/block-copy: More explicit call_state
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200601181118.579-1-vsementsov@virtuozzo.com>
 <20200601181118.579-5-vsementsov@virtuozzo.com>
 <e0e8a810-814d-eb1c-21a7-4469451311e2@redhat.com>
 <7f34130d-d627-59ce-b814-790fb560eb2f@virtuozzo.com>
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
Message-ID: <2118ed26-b985-4726-c473-84afd2027c79@redhat.com>
Date: Mon, 21 Sep 2020 10:54:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <7f34130d-d627-59ce-b814-790fb560eb2f@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IVIbclqRi5xm7aX7vxEmwbI6fewHwrzIJ"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:44:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.501,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, wencongyang2@huawei.com, xiechanglong.d@gmail.com,
 armbru@redhat.com, qemu-devel@nongnu.org, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IVIbclqRi5xm7aX7vxEmwbI6fewHwrzIJ
Content-Type: multipart/mixed; boundary="8TkOqKNld7eJQR5paIFToBoh6m6LPhTpg"

--8TkOqKNld7eJQR5paIFToBoh6m6LPhTpg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18.09.20 22:11, Vladimir Sementsov-Ogievskiy wrote:
> 17.07.2020 16:45, Max Reitz wrote:
>> On 01.06.20 20:11, Vladimir Sementsov-Ogievskiy wrote:
>>> Refactor common path to use BlockCopyCallState pointer as parameter, to
>>> prepare it for use in asynchronous block-copy (at least, we'll need to
>>> run block-copy in a coroutine, passing the whole parameters as one
>>> pointer).
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>> =C2=A0 block/block-copy.c | 51 ++++++++++++++++++++++++++++++++++------=
------
>>> =C2=A0 1 file changed, 38 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/block/block-copy.c b/block/block-copy.c
>>> index 43a018d190..75882a094c 100644
>>> --- a/block/block-copy.c
>>> +++ b/block/block-copy.c
>>
>> [...]
>>
>>> @@ -646,16 +653,16 @@ out:
>>> =C2=A0=C2=A0 * it means that some I/O operation failed in context of _t=
his_
>>> block_copy call,
>>> =C2=A0=C2=A0 * not some parallel operation.
>>> =C2=A0=C2=A0 */
>>> -int coroutine_fn block_copy(BlockCopyState *s, int64_t offset,
>>> int64_t bytes,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bool *error_is_read)
>>> +static int coroutine_fn block_copy_common(BlockCopyCallState
>>> *call_state)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D block_copy_dirty_cl=
usters(s, offset, bytes,
>>> error_is_read);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D block_copy_dirty_cl=
usters(call_state);
>>
>> It=E2=80=99s possible that much of this code will change in a future pat=
ch of
>> this series, but as it is, it might be nice to make
>> block_copy_dirty_clusters=E2=80=99s argument a const pointer so it=E2=80=
=99s clear that
>> the call to block_copy_wait_one() below will use the original @offset
>> and @bytes values.
>=20
> Hm. I'm trying this, and it doesn't work:
>=20
> block_copy_task_entry() wants to change call_state:
>=20
> =C2=A0=C2=A0 t->call_state->failed =3D true;

Too bad :)

>> *shrug*
>>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>>
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret =
=3D=3D 0) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
 =3D block_copy_wait_one(s, offset, bytes);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
 =3D block_copy_wait_one(call_state->s,
>>> call_state->offset,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 call_state->bytes);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>
>=20
>=20



--8TkOqKNld7eJQR5paIFToBoh6m6LPhTpg--

--IVIbclqRi5xm7aX7vxEmwbI6fewHwrzIJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9oakkACgkQ9AfbAGHV
z0BTdQgAu+cyOrZUWQZ2uX3/jk/H1z4d3aODU8EmBSoxOulZ76ANBY098hiNho4n
u6ub4Du3XCTI+G/DudzXgKQnspjIWlA627AaWscjOPHGN4sIWd7jES5ibk2rk7qc
84ktXyw10cTyO5s84/OdhfD72/dPHSFO4UVwmZ6SWdeJElMvqF0fqpv3dMms6gQA
aforZ/XXc5bu6+8gOW/Aq2XXjvb+Pm7qnGHztiTEjhgG9G0fGDKaJrLojO+aSLGa
XWRvPq94KwBwDuiRTyNN2nwUKxF+8+Ikfeg+nHpm3N9F7wZR6Zt6w1Cr1F/m6oow
M0bGPeaeggpz9y5fWnvwe3Fa5JcR5w==
=EpWZ
-----END PGP SIGNATURE-----

--IVIbclqRi5xm7aX7vxEmwbI6fewHwrzIJ--


