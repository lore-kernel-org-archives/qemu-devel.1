Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB6CC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 10:22:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B905B206CC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 10:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fcwgWiTH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B905B206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izeIn-0005IW-Sp
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 05:22:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1izeI7-0004Nw-CA
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:21:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1izeI6-00010q-1V
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:21:47 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35530
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1izeI5-0000ue-Tq
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:21:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580984505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1gIU0WL6W79YVsDUgByUrmH7nduTsCpnvIrhFT/uuTo=;
 b=fcwgWiTHuZi8myguWtykdDhZOfgbPri+XRJ+EFEMNiotZdhIu0VUpsreh1IAm8PZ8Vl+l2
 e0X/Y14Xp1ZaR+l6y2uSwGrhY0NrdrcXktxvkcD2xRpaqgpVdUjBAK8G6rSK0voqXB/yqi
 fqtXk9fMBXXnZvXhmjXzBcIydx4jN2Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-HyqTD_lGMpu9RORLMaUP3w-1; Thu, 06 Feb 2020 05:21:32 -0500
X-MC-Unique: HyqTD_lGMpu9RORLMaUP3w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CB7B8024CD;
 Thu,  6 Feb 2020 10:21:31 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B999C84DB4;
 Thu,  6 Feb 2020 10:21:28 +0000 (UTC)
Subject: Re: [PATCH for-5.0 v2 10/23] quorum: Implement
 .bdrv_recurse_can_replace()
To: Kevin Wolf <kwolf@redhat.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
 <20191111160216.197086-11-mreitz@redhat.com>
 <20200205155511.GF5768@dhcp-200-226.str.redhat.com>
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
Message-ID: <7429d107-63c0-b6e4-5047-d17e9d510efc@redhat.com>
Date: Thu, 6 Feb 2020 11:21:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200205155511.GF5768@dhcp-200-226.str.redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="84v9Kna2tlvZrqsVBfz373BrBHLD0JYnc"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--84v9Kna2tlvZrqsVBfz373BrBHLD0JYnc
Content-Type: multipart/mixed; boundary="CTaP46j2RRJ7kQRcJafmcCghw2newmjdD"

--CTaP46j2RRJ7kQRcJafmcCghw2newmjdD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05.02.20 16:55, Kevin Wolf wrote:
> Am 11.11.2019 um 17:02 hat Max Reitz geschrieben:
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/quorum.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 62 insertions(+)
>>
>> diff --git a/block/quorum.c b/block/quorum.c
>> index 3a824e77e3..8ee03e9baf 100644
>> --- a/block/quorum.c
>> +++ b/block/quorum.c
>> @@ -825,6 +825,67 @@ static bool quorum_recurse_is_first_non_filter(Bloc=
kDriverState *bs,
>>      return false;
>>  }
>> =20
>> +static bool quorum_recurse_can_replace(BlockDriverState *bs,
>> +                                       BlockDriverState *to_replace)
>> +{
>> +    BDRVQuorumState *s =3D bs->opaque;
>> +    int i;
>> +
>> +    for (i =3D 0; i < s->num_children; i++) {
>> +        /*
>> +         * We have no idea whether our children show the same data as
>> +         * this node (@bs).  It is actually highly likely that
>> +         * @to_replace does not, because replacing a broken child is
>> +         * one of the main use cases here.
>> +         *
>> +         * We do know that the new BDS will match @bs, so replacing
>> +         * any of our children by it will be safe.  It cannot change
>> +         * the data this quorum node presents to its parents.
>> +         *
>> +         * However, replacing @to_replace by @bs in any of our
>> +         * children's chains may change visible data somewhere in
>> +         * there.  We therefore cannot recurse down those chains with
>> +         * bdrv_recurse_can_replace().
>> +         * (More formally, bdrv_recurse_can_replace() requires that
>> +         * @to_replace will be replaced by something matching the @bs
>> +         * passed to it.  We cannot guarantee that.)
>> +         *
>> +         * Thus, we can only check whether any of our immediate
>> +         * children matches @to_replace.
>> +         *
>> +         * (In the future, we might add a function to recurse down a
>> +         * chain that checks that nothing there cares about a change
>> +         * in data from the respective child in question.  For
>> +         * example, most filters do not care when their child's data
>> +         * suddenly changes, as long as their parents do not care.)
>> +         */
>> +        if (s->children[i].child->bs =3D=3D to_replace) {
>> +            Error *local_err =3D NULL;
>> +
>> +            /*
>> +             * We now have to ensure that there is no other parent
>> +             * that cares about replacing this child by a node with
>> +             * potentially different data.
>> +             */
>> +            s->children[i].to_be_replaced =3D true;
>> +            bdrv_child_refresh_perms(bs, s->children[i].child, &local_e=
rr);
>> +
>> +            /* Revert permissions */
>> +            s->children[i].to_be_replaced =3D false;
>> +            bdrv_child_refresh_perms(bs, s->children[i].child, &error_a=
bort);
>=20
> Quite a hack. The two obvious problems are:
>=20
> 1. We can't guarantee that we can actually revert the permissions. I
>    think we ignore failure to loosen permissions meanwhile so that at
>    least the &error_abort doesn't trigger, but bs could still be in the
>    wrong state afterwards.

I thought we guaranteed that loosening permissions never fails.

(Well, you know.  It may =E2=80=9Cleak=E2=80=9D permissions, but we=E2=80=
=99d never get an error
here so there=E2=80=99s nothing to handle anyway.)

>    It would be cleaner to use check+abort instead of actually setting
>    the new permission.

Oh.  Yes.  Maybe.  It does require more code, though, because I=E2=80=99d r=
ather
not use bdrv_check_update_perm() from here as-is.

> 2. As aborting the permission change makes more obvious, we're checking
>    something that might not be true any more when we actually make the
>    change.

True.  I tried to do it right by having a post-replace cleanup function,
but after a while that was just going nowhere, really.  So I just went
with what=E2=80=99s patch 13 here.

But isn=E2=80=99t 13 enough, actually?  It check can_replace right before
replacing in a drained section.  I can=E2=80=99t imagine the permissions to
change there.

Max

> Pragmatically, a hack might be good enough here, but it should be
> documented as such (with a short explanation of its shortcomings) at
> least.


--CTaP46j2RRJ7kQRcJafmcCghw2newmjdD--

--84v9Kna2tlvZrqsVBfz373BrBHLD0JYnc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl476KcACgkQ9AfbAGHV
z0BeQggApJyGJo41cWb66xfhBHfQAN+RN/39QP3psS/vOnMyqgJXTfvj3TNy6QmY
2jZhIdd0Y+yurs8vtPQA0PhJbkWin9Jtoph8ZZzVpfb7+AmxEYWGY45VAsYtP6yg
BcHXpyIWV4so0XNCCFVkSjHwWmi73R1COnrIvl/XfibPzOY15+hzkUdZmvCn/dZV
pZS81PWWPHFcx27xktsgL/88kYU/oK4zUbCZxmQReCsGZ/ssh2bhStwVjOlI/HWv
QNMeW3b/oEKWtVChvTvpOJU1gZWWyrBACtU6UgtfbjcBDd7U3kkviqutUpl6W1pj
vYkW/iyUjJe5aJsEEFlAgauZO+i3pw==
=e76L
-----END PGP SIGNATURE-----

--84v9Kna2tlvZrqsVBfz373BrBHLD0JYnc--


