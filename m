Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92965C47E48
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 11:18:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CFDB222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 11:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CFDB222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34103 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDRnH-0003ig-IY
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 07:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52164)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iDRmJ-0002tz-JW
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 07:17:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iDRmI-0002DY-EA
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 07:17:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37260)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iDRmF-0002BH-N7; Thu, 26 Sep 2019 07:17:39 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D70ED5AFE3;
 Thu, 26 Sep 2019 11:17:38 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.151])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E90160126;
 Thu, 26 Sep 2019 11:17:37 +0000 (UTC)
Subject: Re: [PATCH 10/22] quorum: Implement .bdrv_recurse_can_replace()
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190920152804.12875-1-mreitz@redhat.com>
 <20190920152804.12875-11-mreitz@redhat.com>
 <78926514-59db-f108-1ace-356a0bca8097@virtuozzo.com>
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
Message-ID: <702eee8e-80d9-2f6b-2a92-435cdcb48b68@redhat.com>
Date: Thu, 26 Sep 2019 13:17:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <78926514-59db-f108-1ace-356a0bca8097@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GhqZWih3nIkrfekjaaIJ93rBua1PXrB7D"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Thu, 26 Sep 2019 11:17:38 +0000 (UTC)
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
--GhqZWih3nIkrfekjaaIJ93rBua1PXrB7D
Content-Type: multipart/mixed; boundary="G7EvafvFXtAaf7z8Q7VeJuFUAnFSgibSV"

--G7EvafvFXtAaf7z8Q7VeJuFUAnFSgibSV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.09.19 16:12, Vladimir Sementsov-Ogievskiy wrote:
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
>> +         * children's chains may change visible data somewhere in
>> +         * there.  We therefore cannot recurse down those chains with=

>> +         * bdrv_recurse_can_replace().
>> +         * (More formally, bdrv_recurse_can_replace() requires that
>> +         * @to_replace will be replaced by something matching the @bs=

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
>> +            bdrv_child_refresh_perms(bs, s->children[i].child, &local=
_err);
>> +
>=20
> So we are trying to answer on a question "is it ok to replace" it, by c=
heating on
> permission system... Possibly, it's a problem of general design, and in=
stead of
>   examining one subtree, we should ask all parents of to_replace node, =
are they
> OK with such replacement..

I=E2=80=99m not sure whether it=E2=80=99s cheating.

We want to replace some node.  A parent should be A-OK with that as long
as it hasn=E2=80=99t frozen its child link, and as long as it doesn=E2=80=
=99t care about
data changes (it should not have taken CONSISTENT_READ, and it must have
shared WRITE).

The only actual problem we have is that currently basically everything
takes CONSISTENT_READ (which is completely fine), but the only thing
that doesn=E2=80=99t is the mirror_top_bs, and that has exactly the probl=
em of
=E2=80=9CI can only get away without CONSISTENT_READ if it was me who uns=
hared it=E2=80=9D.

But that=E2=80=99s a different problem.  I don=E2=80=99t think this is ch=
eating.

> Another idea is that it's strange to check permissions somewhere else t=
han in generic
> permission check functions. But I've no idea how to handle it in permis=
sion system.

I don=E2=80=99t check the permissions, though.  I let quorum take what it=
 needs
to allow changing one of its children.

What is a problem is that I should keep the permissions tightened until
the node is actually replaced and only then release them.  But that
turned out to be a huge mess so I resorted to just double-checking
before mirror actually completes.

Max


--G7EvafvFXtAaf7z8Q7VeJuFUAnFSgibSV--

--GhqZWih3nIkrfekjaaIJ93rBua1PXrB7D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2Mnk8ACgkQ9AfbAGHV
z0Bn0gf9ExMMmK4ism69UmNmZcj2VDtGGSId0oumZ0hi0GhSzhswZdOzGQmT27UB
3/3dWngLw2Aeo2Celz/kUw+C3lhZ1qKOrHw8WXCsXpDMj4jqLs0O4z3gKA1DvDuM
oY1mtDLGgadyiEzU901pu0/WU6BiV8QMll39Y39SFqorOGO7X7MSr/W+SDxfyAu2
Lq36C/9tuBzQTBU2ex+FY8LuL7Kg0SAxZ2AAIn0w4PWGoYu82qPzbKMqve/DHbyJ
SGlgWShHD8GIQYI2uYaA7Y/3IhOMd5UHdsr1/Ub2I5+2vOyGokWb3gxE5jpzo8jP
x9HN3oMShU0npfpZMYow96X7uZGuEQ==
=hbJh
-----END PGP SIGNATURE-----

--GhqZWih3nIkrfekjaaIJ93rBua1PXrB7D--

