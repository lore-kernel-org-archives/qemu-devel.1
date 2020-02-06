Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2326AC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:17:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0EE9206CC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XGxkc2sr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0EE9206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izfA0-0002c9-0U
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 06:17:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54834)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1izezd-00084O-Ku
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:06:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1izezc-0006m8-ES
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:06:45 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48984
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1izezc-0006k0-8B
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:06:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580987203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1zwTJRWFNb9ADB703QfOwV9z+7tO144BelML2fvqzyw=;
 b=XGxkc2sr0EBpS8Nz8dKvpcdzrEFQRAVMxNt/Ke5g8eGNrKibEWMF7UEQr/s2yCxMyLX5Ok
 30pnd6sIBdaKPctbUfTzKbWvVms4iIL1blFHcFPzqWvSBBm4IIhQ+5Bsl6E7zJVRZXpm7N
 Zfe4Vz0KOCtx3L+rr8IjMtmH79CJcZ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-Tml3FjtROD6Zxjazcm2OkA-1; Thu, 06 Feb 2020 06:06:38 -0500
X-MC-Unique: Tml3FjtROD6Zxjazcm2OkA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD82D1835A13;
 Thu,  6 Feb 2020 11:06:37 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 54B358885D;
 Thu,  6 Feb 2020 11:06:36 +0000 (UTC)
Subject: Re: [PATCH v2 09/33] block: Add generic bdrv_inherited_options()
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200204170848.614480-1-mreitz@redhat.com>
 <20200204170848.614480-10-mreitz@redhat.com>
 <87197a53-64e5-ec56-acff-13288256dee0@redhat.com>
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
Message-ID: <9e93e4ef-5e20-6b7b-971b-3a3541c6cf31@redhat.com>
Date: Thu, 6 Feb 2020 12:06:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87197a53-64e5-ec56-acff-13288256dee0@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ulKRRD1IDcEJC4gbtDg1dk6J23snjamas"
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
--ulKRRD1IDcEJC4gbtDg1dk6J23snjamas
Content-Type: multipart/mixed; boundary="sl6hxqi4bcyV10hYxEcYmFjfB33PxDA5O"

--sl6hxqi4bcyV10hYxEcYmFjfB33PxDA5O
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05.02.20 17:48, Eric Blake wrote:
> On 2/4/20 11:08 AM, Max Reitz wrote:
>> After the series this patch belongs to, we want to have a common
>> BdrvChildClass that encompasses all of child_file, child_format, and
>> child_backing.=C2=A0 Such a single class needs a single .inherit_options=
()
>> implementation, and this patch introduces it.
>>
>> The next patch will show how the existing implementations can fall back
>> to it just by passing appropriate BdrvChildRole and parent_is_format
>> values.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 block.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++
>> =C2=A0 1 file changed, 84 insertions(+)
>>
>=20
> No impact until the next patch, but the division of patches was wise.
>=20
>=20
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * First, decide whether to set, clear, or leav=
e BDRV_O_PROTOCOL.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Generally, the question to answer is: Should=
 this child be
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * format-probed by default?
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Pure and non-filtered data children of non-f=
ormat nodes should
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * be probed by default (even when the node its=
elf has
>> BDRV_O_PROTOCOL
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * set).=C2=A0 This only affects a very limited=
 set of drivers (namely
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * quorum and blkverify when this comment was w=
ritten).
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Force-clear BDRV_O_PROTOCOL then.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (!parent_is_format &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (role & (BDRV_CHILD_DATA | B=
DRV_CHILD_METADATA |
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRV_CHILD_FILTERED)) =3D=3D
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRV=
_CHILD_DATA)
>> +=C2=A0=C2=A0=C2=A0 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags &=3D ~BDRV_O_PROTOCOL;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * All children of format nodes (except for COW=
 children) and all
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * metadata children in general should never be=
 format-probed.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Force-set BDRV_O_PROTOCOL then.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if ((parent_is_format && !(role & BDRV_CHILD_COW)) |=
|
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (role & BDRV_CHILD_METADATA)=
)
>=20
> Should this use 'else if', to make it obvious that we never have a path
> that both force-clears and force-sets BDRV_O_PROTOCOL?=C2=A0 But a carefu=
l
> reading shows that the two 'if' are mutually exclusive, even without the
> second using 'else if'.

It could or maybe even should, but that would make the comments more
awkward to place.

Locally, at some point I had two bools that were just set to the result
of the conditions, and then I used them in an if/else if tree, but that
wasn=E2=80=99t any less awkward.

>> +=C2=A0=C2=A0=C2=A0 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags |=3D BDRV_O_PROTOCOL;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>=20
> Looks good!=C2=A0 Lots of decision trees, but also lots of good comments
> backing up that complexity.

OK :-)

Max


--sl6hxqi4bcyV10hYxEcYmFjfB33PxDA5O--

--ulKRRD1IDcEJC4gbtDg1dk6J23snjamas
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl478zoACgkQ9AfbAGHV
z0C/lwgAw/S/DuWcehbIcX0MqWX44af3kqJ0+GgN9Wg+ztvDuvzwmHDZjssRTTMv
C7KZxJzHLkvDfwJxhUwbyfPxDOaKaA3OKG1GfGoCWTLCVzFfTLZwSdQrXDpROj4W
eLu8J0/EpeDOSohB7anhCVUVcsQ4C9BBuhKtgB0vbpXIULmsvfjj79Yx9CcnfHyr
kw31p1KrRW9hj/4XT9KPKg+V0YzsFc7txuF6L/0MJ8o0HO74zqXPWNd3NS575Tj9
2utY6m3OZVnx++h6SPDwT6XqUiYgz4o/Lmuqe0AdI4SG07AYtKkmn7URzpy0pi2y
Nv5TRYRlH7knTLrRL+IpViKepwjymA==
=JQyp
-----END PGP SIGNATURE-----

--ulKRRD1IDcEJC4gbtDg1dk6J23snjamas--


