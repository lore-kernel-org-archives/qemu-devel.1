Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537A8C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 11:13:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29B7C21A4A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 11:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B7C21A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDRiV-0007bm-8g
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 07:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51259)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iDRhI-0006vl-4c
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 07:12:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iDRhH-0006q6-0H
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 07:12:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58996)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iDRhB-0006nx-HG; Thu, 26 Sep 2019 07:12:25 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 83CF0308427D;
 Thu, 26 Sep 2019 11:12:24 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.151])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2EF2660BE0;
 Thu, 26 Sep 2019 11:12:23 +0000 (UTC)
Subject: Re: [PATCH 10/22] quorum: Implement .bdrv_recurse_can_replace()
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190920152804.12875-1-mreitz@redhat.com>
 <20190920152804.12875-11-mreitz@redhat.com>
 <b8e5c18a-67a7-aa9c-e1c7-7aca1408926a@virtuozzo.com>
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
Message-ID: <15df3ba1-5800-2768-69e5-5ebbf03f617d@redhat.com>
Date: Thu, 26 Sep 2019 13:12:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <b8e5c18a-67a7-aa9c-e1c7-7aca1408926a@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tohLLtyXSM7vAn7PmkC9KHSKiATS7QBns"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 26 Sep 2019 11:12:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tohLLtyXSM7vAn7PmkC9KHSKiATS7QBns
Content-Type: multipart/mixed; boundary="85Y1aGN29RgD85SGillupDK7i22Kvtztn"

--85Y1aGN29RgD85SGillupDK7i22Kvtztn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.09.19 15:39, Vladimir Sementsov-Ogievskiy wrote:
> 20.09.2019 18:27, Max Reitz wrote:
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   block/quorum.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++=
++
>>   1 file changed, 62 insertions(+)
>>
>> diff --git a/block/quorum.c b/block/quorum.c
>> index 207054a64e..81b57dbae2 100644
>> --- a/block/quorum.c
>> +++ b/block/quorum.c
>> @@ -825,6 +825,67 @@ static bool quorum_recurse_is_first_non_filter(Bl=
ockDriverState *bs,
>>       return false;
>>   }
>>  =20
>> +static bool quorum_recurse_can_replace(BlockDriverState *bs,
>> +                                       BlockDriverState *to_replace)
>> +{
>> +    BDRVQuorumState *s =3D bs->opaque;
>> +    int i;
>> +
>> +    for (i =3D 0; i < s->num_children; i++) {
>> +        /*
>> +         * We have no idea whether our children show the same data as=

>> +         * this node (@bs).  It is actually highly likely that
>> +         * @to_replace does not, because replacing a broken child is
>> +         * one of the main use cases here.
>> +         *
>> +         * We do know that the new BDS will match @bs, so replacing
>> +         * any of our children by it will be safe.  It cannot change
>> +         * the data this quorum node presents to its parents.
>> +         *
>> +         * However, replacing @to_replace by @bs in any of our
>=20
> I'm a bit misleaded: by @bs, or by node equal to @bs (accordingly to
> bdrv_recurse_can_replace spec)?
>=20
>> +         * children's chains may change visible data somewhere in
>> +         * there.  We therefore cannot recurse down those chains with=

>> +         * bdrv_recurse_can_replace().
>> +         * (More formally, bdrv_recurse_can_replace() requires that
>> +         * @to_replace will be replaced by something matching the @bs=

>> +         * passed to it.  We cannot guarantee that.)
>=20
> Aha, and you answered already :) OK.
>=20
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
>=20
> Hmm, still, what is wrong if we just put bdrv_recurse_can_replace(s->ch=
ildren[i].child->bs, to_replace) into this if condition?
> (or may be more correct to call it after taking permissions)

It=E2=80=99s wrong because:

bs=3Dquorum -> child=3Dfilter -> to_replace <- other_parent

Quorum now takes WRITE on the child and unshares CONSISTENT_READ.  That
doesn=E2=80=99t concern the @other_parent at all, however, it only concer=
ns
parents immediately on its child (the filter node).

bdrv_recurse_can_replace() will happily acknowledge you replacing
@to_replace by something equal to @filter, because that shouldn=E2=80=99t=

concern @other_parent.

The problem of course is that we don=E2=80=99t want to replace @to_replac=
e by
something equal to @filter, but by something equal to @quorum.  And that
may be different from @to_replace, so @other_parent should have a say in =
it.

What we=E2=80=99d need to do is have a function that recurses down and ch=
ecks
whether there are any parents that care; which is exactly what I=E2=80=99=
ve
described in the last paragraph of the long comment above.


For now, I think it=E2=80=99s fine to just ignore such cases and forbid t=
hem.

Max


--85Y1aGN29RgD85SGillupDK7i22Kvtztn--

--tohLLtyXSM7vAn7PmkC9KHSKiATS7QBns
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2MnRUACgkQ9AfbAGHV
z0AYWQgAjtqHjNsOG/80QVMV7c83t0LCo34uEhP7T3+41f5tBj4mno+P16jIuE4h
wOQdhdJxsTchDFrc1YknXb465znOXjOOTTEf9L5gqbrRZ2M6pBX42gV4xeXygLyF
S8gO+PFE1sj9mPbXPixnxTilSf+ZE2vsjYAbDskE/E4YIzBbBMXyHOZRD4qKc6uM
bpZI0U63/TqVo6+iR+iRnWjLEn5qxQyOsclBB0rFIf/vCwJRI10nPneIX1TxDhUZ
Iu5WKIdVlRu7sb3X1eXe6KpcpV81DPpwh4DUc/DmzapsX1ChII0AfEnuYIhcB0vW
8kYc9V3oOeLRqJ4HuQeR63fDedjgCQ==
=0gOm
-----END PGP SIGNATURE-----

--tohLLtyXSM7vAn7PmkC9KHSKiATS7QBns--

