Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE99C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 10:49:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3277520730
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 10:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HPCv7SHY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3277520730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izej2-0006i8-DQ
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 05:49:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45714)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1izehd-00059j-QV
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:48:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1izehb-0007jr-F8
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:48:08 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32742
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1izehb-0007ZM-8j
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:48:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580986084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4PSrguA9b8KE5/MQA+cnDZiRM+O1pzO26q6kNPK+XVU=;
 b=HPCv7SHYFWcNbbKPoZJVu+qy7av2bLk/7BuUg0Hg9uywLN+q3ToceF0r0SqTCaAdSCbmp/
 GLZIltXksSs292rxehyPfpbUQNvHsCwW2Fcc/78wOOmB1M33oqDBTiFDh8CXkZUtv4Theg
 VDAhyf87QsXspWFooYhxjnPfe7xHkN0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-npmt2iSvNZCixS8Pik2tqQ-1; Thu, 06 Feb 2020 05:48:00 -0500
X-MC-Unique: npmt2iSvNZCixS8Pik2tqQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36E00107B299;
 Thu,  6 Feb 2020 10:47:59 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EAEF55C1D8;
 Thu,  6 Feb 2020 10:47:57 +0000 (UTC)
Subject: Re: [PATCH v2 03/33] block: Add BdrvChildRole
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200204170848.614480-1-mreitz@redhat.com>
 <20200204170848.614480-4-mreitz@redhat.com>
 <ab321260-f03c-2540-e443-9b1f066f819f@redhat.com>
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
Message-ID: <f566b3d0-fe94-3e83-1d96-8d90324d5317@redhat.com>
Date: Thu, 6 Feb 2020 11:47:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ab321260-f03c-2540-e443-9b1f066f819f@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="n9pWlqmQxSgWbjZjTsJmJUmG551nSSfAa"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n9pWlqmQxSgWbjZjTsJmJUmG551nSSfAa
Content-Type: multipart/mixed; boundary="V2SuEHWHobheV4i9kcaFeP3MSiqoIbKK4"

--V2SuEHWHobheV4i9kcaFeP3MSiqoIbKK4
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05.02.20 16:24, Eric Blake wrote:
> On 2/4/20 11:08 AM, Max Reitz wrote:
>> This enum will supplement BdrvChildClass when it comes to what role (or
>> combination of roles) a child takes for its parent.
>>
>> Because empty enums are not allowed, let us just start with it filled.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 include/block/block.h | 27 +++++++++++++++++++++++++++
>> =C2=A0 1 file changed, 27 insertions(+)
>>
>> diff --git a/include/block/block.h b/include/block/block.h
>> index 38963ef203..0f7e8caa5b 100644
>> --- a/include/block/block.h
>> +++ b/include/block/block.h
>> @@ -279,6 +279,33 @@ enum {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DEFAULT_PERM_UNCHANGED=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =3D BLK_PERM_ALL &
>> ~DEFAULT_PERM_PASSTHROUGH,
>> =C2=A0 };
>> =C2=A0 +typedef enum BdrvChildRole {
>> +=C2=A0=C2=A0=C2=A0 /* Child stores data */
>> +=C2=A0=C2=A0=C2=A0 BDRV_CHILD_DATA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =3D (1 << 0),
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Child stores metadata */
>> +=C2=A0=C2=A0=C2=A0 BDRV_CHILD_METADATA=C2=A0=C2=A0=C2=A0=C2=A0 =3D (1 <=
< 1),
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Filtered child */
>> +=C2=A0=C2=A0=C2=A0 BDRV_CHILD_FILTERED=C2=A0=C2=A0=C2=A0=C2=A0 =3D (1 <=
< 2),
>=20
> I'm not sure this comment does justice for what the flag represents, but
> am not sure of what longer comment to put in its place.

You=E2=80=99re right.  I thought I could just rely on our .is_filter
documentation (at least after
https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg01721.html),
but that doesn=E2=80=99t really apply here.

For example, this series makes raw (without further parameters) have a
CHILD_FILTERED child, without raw being a filter itself.

So there should indeed be some definition here.

Maybe:

A child to which the parent forwards all reads and writes.  Therefore,
this child presents exactly the same visible data as the parent.

Would that work?

Max


--V2SuEHWHobheV4i9kcaFeP3MSiqoIbKK4--

--n9pWlqmQxSgWbjZjTsJmJUmG551nSSfAa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl477twACgkQ9AfbAGHV
z0A8KQgAnYRUvOE7f8dgruN6KIX2eVfsepPGzQqDsTFOJf86daKI3tRmxF6gxe2S
DJdKyOaQ8u96rY8o2wp/Pni8A9EtawSNat/MCQXNfxz1UKq9rPJ3LRA4MpNNPOch
oUl4VCc+MK9Iy1SXrYmfLihfwRPWKUP948teiE/xW5WxM7b3uUTK+MrzzEWVkh/3
Hpw2zS0ByxUTe7HiIo7SFhuioYydK6zCwlx4ueekJt+28yDhmqclIL672jw3kRmg
CxBsMmPnyf/L3dVEXKgVRm5TxvcuUfO22fr+MP9Fej/G6R4joQJGpY2smj0OgPiz
DoBS0bahHX6GymU4L7fL3kfSf5JXqg==
=NhbF
-----END PGP SIGNATURE-----

--n9pWlqmQxSgWbjZjTsJmJUmG551nSSfAa--


