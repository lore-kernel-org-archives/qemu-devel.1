Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BEBC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 15:20:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AF8920838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 15:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SZHYS9u5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF8920838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iziwn-00013y-Qf
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 10:20:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56169)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iziw3-0000a2-Mn
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:19:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iziw2-0008Hi-8P
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:19:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39917
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iziw2-0008Fh-38
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:19:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581002356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GGJ0epERoFUhi04VzHJP54cONgzxGidcQOeqv5KobQQ=;
 b=SZHYS9u5N1HvOFqhrfMv0R5uSh4N0JO2UYuMq8AQHld0lJdtv57bHdr3VfMqqEvkbGhdgG
 oCs43tgdlo/5C5nPWQLYDbRp1SlJpUeckl8brACTtSgXww9EDwXB6d6yeThQkBnj6+zD2a
 zfw1FZoy3ZsXrTFn2OCKLo750T5NIAQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-bRQNew8jPeSJVXGkrVNQsw-1; Thu, 06 Feb 2020 10:19:13 -0500
X-MC-Unique: bRQNew8jPeSJVXGkrVNQsw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 186D81137841;
 Thu,  6 Feb 2020 15:19:12 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 209DD60BEC;
 Thu,  6 Feb 2020 15:19:09 +0000 (UTC)
Subject: Re: [PATCH for-5.0 v2 10/23] quorum: Implement
 .bdrv_recurse_can_replace()
To: Kevin Wolf <kwolf@redhat.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
 <20191111160216.197086-11-mreitz@redhat.com>
 <20200205155511.GF5768@dhcp-200-226.str.redhat.com>
 <7429d107-63c0-b6e4-5047-d17e9d510efc@redhat.com>
 <20200206144207.GC4926@linux.fritz.box>
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
Message-ID: <1bb2e344-e66d-de37-0d49-f4a8a5a6eb40@redhat.com>
Date: Thu, 6 Feb 2020 16:19:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200206144207.GC4926@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yQo3G31cFpZb2PuWO5mc5AnlP9Pg5wLXi"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
--yQo3G31cFpZb2PuWO5mc5AnlP9Pg5wLXi
Content-Type: multipart/mixed; boundary="ovArt0iCIj8ZlAVgjkmHRmtS6wlYPpY1l"

--ovArt0iCIj8ZlAVgjkmHRmtS6wlYPpY1l
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.02.20 15:42, Kevin Wolf wrote:
> Am 06.02.2020 um 11:21 hat Max Reitz geschrieben:
>> On 05.02.20 16:55, Kevin Wolf wrote:
>>> Am 11.11.2019 um 17:02 hat Max Reitz geschrieben:
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>> ---
>>>>  block/quorum.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++=
+
>>>>  1 file changed, 62 insertions(+)
>>>>
>>>> diff --git a/block/quorum.c b/block/quorum.c
>>>> index 3a824e77e3..8ee03e9baf 100644
>>>> --- a/block/quorum.c
>>>> +++ b/block/quorum.c
>>>> @@ -825,6 +825,67 @@ static bool quorum_recurse_is_first_non_filter(Bl=
ockDriverState *bs,
>>>>      return false;
>>>>  }
>>>> =20
>>>> +static bool quorum_recurse_can_replace(BlockDriverState *bs,
>>>> +                                       BlockDriverState *to_replace)
>>>> +{
>>>> +    BDRVQuorumState *s =3D bs->opaque;
>>>> +    int i;
>>>> +
>>>> +    for (i =3D 0; i < s->num_children; i++) {
>>>> +        /*
>>>> +         * We have no idea whether our children show the same data as
>>>> +         * this node (@bs).  It is actually highly likely that
>>>> +         * @to_replace does not, because replacing a broken child is
>>>> +         * one of the main use cases here.
>>>> +         *
>>>> +         * We do know that the new BDS will match @bs, so replacing
>>>> +         * any of our children by it will be safe.  It cannot change
>>>> +         * the data this quorum node presents to its parents.
>>>> +         *
>>>> +         * However, replacing @to_replace by @bs in any of our
>>>> +         * children's chains may change visible data somewhere in
>>>> +         * there.  We therefore cannot recurse down those chains with
>>>> +         * bdrv_recurse_can_replace().
>>>> +         * (More formally, bdrv_recurse_can_replace() requires that
>>>> +         * @to_replace will be replaced by something matching the @bs
>>>> +         * passed to it.  We cannot guarantee that.)
>>>> +         *
>>>> +         * Thus, we can only check whether any of our immediate
>>>> +         * children matches @to_replace.
>>>> +         *
>>>> +         * (In the future, we might add a function to recurse down a
>>>> +         * chain that checks that nothing there cares about a change
>>>> +         * in data from the respective child in question.  For
>>>> +         * example, most filters do not care when their child's data
>>>> +         * suddenly changes, as long as their parents do not care.)
>>>> +         */
>>>> +        if (s->children[i].child->bs =3D=3D to_replace) {
>>>> +            Error *local_err =3D NULL;
>>>> +
>>>> +            /*
>>>> +             * We now have to ensure that there is no other parent
>>>> +             * that cares about replacing this child by a node with
>>>> +             * potentially different data.
>>>> +             */
>>>> +            s->children[i].to_be_replaced =3D true;
>>>> +            bdrv_child_refresh_perms(bs, s->children[i].child, &local=
_err);
>>>> +
>>>> +            /* Revert permissions */
>>>> +            s->children[i].to_be_replaced =3D false;
>>>> +            bdrv_child_refresh_perms(bs, s->children[i].child, &error=
_abort);
>>>
>>> Quite a hack. The two obvious problems are:
>>>
>>> 1. We can't guarantee that we can actually revert the permissions. I
>>>    think we ignore failure to loosen permissions meanwhile so that at
>>>    least the &error_abort doesn't trigger, but bs could still be in the
>>>    wrong state afterwards.
>>
>> I thought we guaranteed that loosening permissions never fails.
>>
>> (Well, you know.  It may =E2=80=9Cleak=E2=80=9D permissions, but we=E2=
=80=99d never get an error
>> here so there=E2=80=99s nothing to handle anyway.)
>=20
> This is what I meant. We ignore the failure (i.e. don't return an error),
> but the result still isn't completely correct ("leaked" permissions).
>=20
>>>    It would be cleaner to use check+abort instead of actually setting
>>>    the new permission.
>>
>> Oh.  Yes.  Maybe.  It does require more code, though, because I=E2=80=99=
d rather
>> not use bdrv_check_update_perm() from here as-is.
>=20
> I'm not saying you need to do it, just that it would be cleaner. :-)

It would.  Thanks for the suggestion, I obviously didn=E2=80=99t think of i=
t.
(Or there=E2=80=99d be a comment on how this is not the best way in theory,=
 but
in practice it=E2=80=99s good enough.)  I suppose I=E2=80=99ll see how what=
 I can do.

>>> 2. As aborting the permission change makes more obvious, we're checking
>>>    something that might not be true any more when we actually make the
>>>    change.
>>
>> True.  I tried to do it right by having a post-replace cleanup function,
>> but after a while that was just going nowhere, really.  So I just went
>> with what=E2=80=99s patch 13 here.
>>
>> But isn=E2=80=99t 13 enough, actually?  It check can_replace right befor=
e
>> replacing in a drained section.  I can=E2=80=99t imagine the permissions=
 to
>> change there.
>=20
> Permissions are tied to file locks, so an external process can just grab
> the locks in between.

Ah, right, I didn=E2=80=99t think of that.

> But if I understand correctly, all we try here is
> to have an additional safeguard to prevent the user from doing stupid
> things. So I guess not being 100% is fine as long as it's documented in
> the code.

Yes.  I just think it actually would be 100 % in practice, so I wondered
whether it would need to be documented.

You=E2=80=99re right, though, it isn=E2=80=99t 100 %, so it should definite=
ly be
documented.  Maybe something like

In theory, we would have to keep the permissions tightened until the
node is replaced.  In practice, that would require post-replacement
cleanup infrastructure, which we do not have, and which would be
unreasonably complex to implement.  Therefore, all we can do is require
anyone who wants to replace one node by some potentially unrelated other
node (i.e., the mirror job on completion) to invoke
bdrv_recurse_can_replace() immediately before and thus minimize the time
during which some condition may arise that might forbid the swap.

?

Max


--ovArt0iCIj8ZlAVgjkmHRmtS6wlYPpY1l--

--yQo3G31cFpZb2PuWO5mc5AnlP9Pg5wLXi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl48LmsACgkQ9AfbAGHV
z0AXVQgAwnk8Ytn6T8SCs9Ey6Ig3lDu4ww/3Do+AODP+gDf9PA1+Euh2Xsnta4fH
iLLyy3yBZEFkm6wam7pBeNik3tIwmvFc2tUGpPeKB4HyNeWRsrXvs/6wSARfNCrS
jMTZtv0IHsb9nEHzKOUktoL+MmSmNANxR5UiEr/01jWCqrFliDmptCz/pTeTHRBd
tOltFVm/YIQEgMm/gXt2DXteX6y9Z5tuZnkQtbPIQ4fxBXi/I35JGEIQMKYHWPlT
enUb4HjMsqTpWaaGRVTy9hMHZEkD6g1uEtAjWhUMcnw2RDnQfi2F3el9qaEl0hSq
wwKBvBtKiQaoe5Z7xKhP2bJ1t3A3mQ==
=CpWm
-----END PGP SIGNATURE-----

--yQo3G31cFpZb2PuWO5mc5AnlP9Pg5wLXi--


