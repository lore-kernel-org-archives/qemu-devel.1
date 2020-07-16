Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D40C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 15:15:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D0E4207CB
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 15:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e8V0vtKl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D0E4207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw5bD-0005vf-FU
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 11:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jw5aU-0005Mv-03
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 11:14:18 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46203
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jw5aR-0000MI-C3
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 11:14:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594912454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6I1IyeVDOWdDeZD12NwBksdoXOFxlsNnlEVWLdmyLmk=;
 b=e8V0vtKlJOqLRhCMhskD3YpAjG6LCG+o9168qUG+EvZT6ESKdfvS1wTLoafAThKYIh5+BA
 rCf6A6LXz7nHrvDdNy/382wBGx8ofsXWZdLJ2eBla+QIT1TeVzdt9SYyoATzPoWwLMS31X
 Ycer+m+xJcer4lcZuqeFYqWhemn+2to=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-yD3w4ev3Pnyq7C3LuIvViw-1; Thu, 16 Jul 2020 11:14:12 -0400
X-MC-Unique: yD3w4ev3Pnyq7C3LuIvViw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 040B518C63C2;
 Thu, 16 Jul 2020 15:14:11 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-160.ams2.redhat.com
 [10.36.112.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 97D765C1C3;
 Thu, 16 Jul 2020 15:14:09 +0000 (UTC)
Subject: Re: [PATCH v7 20/47] block: Iterate over children in refresh_limits
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-21-mreitz@redhat.com>
 <9e4dc3da-2c5c-8da5-2d03-c144b9d8b4fd@virtuozzo.com>
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
Message-ID: <724d8c58-7a7b-d1ab-4a76-2d79e50fe34f@redhat.com>
Date: Thu, 16 Jul 2020 17:14:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9e4dc3da-2c5c-8da5-2d03-c144b9d8b4fd@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cG7hBTpKeUZUOMw38tsj2PjcaYhMJaKa8"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 09:29:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cG7hBTpKeUZUOMw38tsj2PjcaYhMJaKa8
Content-Type: multipart/mixed; boundary="3IEiToJUkp5HxLGo139F8irZUS56u7MLA"

--3IEiToJUkp5HxLGo139F8irZUS56u7MLA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.07.20 20:37, Andrey Shinkevich wrote:
> On 25.06.2020 18:21, Max Reitz wrote:
>> Instead of looking at just bs->file and bs->backing, we should look at
>> all children that could end up receiving forwarded requests.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 block/io.c | 32 ++++++++++++++++----------------
>> =C2=A0 1 file changed, 16 insertions(+), 16 deletions(-)
>>
>> diff --git a/block/io.c b/block/io.c
>> index c2af7711d6..37057f13e0 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -135,6 +135,8 @@ static void bdrv_merge_limits(BlockLimits *dst,
>> const BlockLimits *src)
>> =C2=A0 void bdrv_refresh_limits(BlockDriverState *bs, Error **errp)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockDriver *drv =3D bs->drv;
>> +=C2=A0=C2=A0=C2=A0 BdrvChild *c;
>> +=C2=A0=C2=A0=C2=A0 bool have_limits;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(&bs->bl, 0, sizeof(bs->bl))=
;
>> @@ -149,14 +151,21 @@ void bdrv_refresh_limits(BlockDriverState *bs,
>> Error **errp)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drv->bdrv_co_preadv_par=
t) ? 1 : 512;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Take some limits from the child=
ren as a default */
>> -=C2=A0=C2=A0=C2=A0 if (bs->file) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_refresh_limits(bs->file=
->bs, &local_err);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (local_err) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 erro=
r_propagate(errp, local_err);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn;
>> +=C2=A0=C2=A0=C2=A0 have_limits =3D false;
>> +=C2=A0=C2=A0=C2=A0 QLIST_FOREACH(c, &bs->children, next) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (c->role & (BDRV_CHILD_DA=
TA | BDRV_CHILD_FILTERED |
>> BDRV_CHILD_COW))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv=
_refresh_limits(c->bs, &local_err);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
local_err) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 error_propagate(errp, local_err);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv=
_merge_limits(&bs->bl, &c->bs->bl);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 have=
_limits =3D true;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_merge_limits(&bs->bl, &=
bs->file->bs->bl);
>> -=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!have_limits) {
>=20
>=20
> This conditioned piece of code worked with (bs->file =3D=3D NULL) only.
>=20
> Now, it works only if there are neither bs->file, nor bs->backing, nor
> else filtered children.
>=20
> Is it OK and doesn't break the logic for all cases?

Hm.  Good question.

I think the answer is it=E2=80=99s OK.

For DATA and FILTERED, it makes absolute sense to just use their
alignments.  For COW, maybe not so much?  But if there=E2=80=99s a COW chil=
d,
there has to be a DATA child as well (in practice).  So we=E2=80=99ll alway=
s
consider its alignment, too.

(And hypothetically speaking, if there was a COW child but no DATA
child, then the only alignment we need to observe is in fact the one of
the COW child.)

Max


--3IEiToJUkp5HxLGo139F8irZUS56u7MLA--

--cG7hBTpKeUZUOMw38tsj2PjcaYhMJaKa8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8Qbr8ACgkQ9AfbAGHV
z0A0kAf/UYudbfO3cqcdXelYq3vuv6U+YRNa8YcO0iofS4eAPQ3j84rZ7jkaNxR5
F9zAVFqx1zUgkJ0Sv3O0a+Q4YYSXVdFWxHZ6NN++dhT5BwquxVPxXXprVpJOlBie
Ql+BzZ0VK6XwPlq7pCxBqGmPwB0vwTtbEWmUWIdNus9maMPRka/9g6uTDwdvM9MP
0MrT13IatHISp70+EyB6K6xsu+JkecwwMVDoo9QFeyk+k0IhcnGUEZeMCIIAKrAS
EZmSSjLncxkM0P6TiZQdD5cl++jqbi1MnSIRa/lkm3ApOs0uzgcyidhq8zqlcFhr
W25dhjA7uiz1IwpRRri//SUBstDGoQ==
=vv4I
-----END PGP SIGNATURE-----

--cG7hBTpKeUZUOMw38tsj2PjcaYhMJaKa8--


