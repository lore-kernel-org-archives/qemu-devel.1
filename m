Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF07BC433F2
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:51:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77AD0207BC
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T2RO3KW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77AD0207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw5Ei-0003rB-Oe
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 10:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jw5Dz-0002wE-CP
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:51:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32483
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jw5Dx-0001MB-Jz
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594911060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AB2m6N17qDXynqvxaV8zqr6FyQgfO6tVbtRLo81jn2k=;
 b=T2RO3KW2myzUb74YX+8AhVU0O1FnEZbNcl0NunCs1fChlDybOGwH324zKmfEMr6ItDuacO
 wodqgVlstEdvBMvxWiHd55yfSvB42Q3+Q34NGTQtlHDEmpWfuo6tVyaGt1h8NeIBGYpB0K
 /+2ZWx5Bun7uBXCFkEeUgzhTR2nstrE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-3IqO3KLfNMu7WwPlY3A-Dg-1; Thu, 16 Jul 2020 10:50:57 -0400
X-MC-Unique: 3IqO3KLfNMu7WwPlY3A-Dg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6A0C100AA22;
 Thu, 16 Jul 2020 14:50:56 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-160.ams2.redhat.com
 [10.36.112.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B82AB19C4F;
 Thu, 16 Jul 2020 14:50:55 +0000 (UTC)
Subject: Re: [PATCH v7 02/47] block: Add chain helper functions
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-3-mreitz@redhat.com>
 <697fa19f-b68f-f45d-7fab-a0d746c44557@virtuozzo.com>
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
Message-ID: <b058f66a-41ba-e560-dd2e-292b79359b9c@redhat.com>
Date: Thu, 16 Jul 2020 16:50:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <697fa19f-b68f-f45d-7fab-a0d746c44557@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mLzvLipRwVmryBgtVxlM4zJH4VvgPoDIO"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 04:25:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mLzvLipRwVmryBgtVxlM4zJH4VvgPoDIO
Content-Type: multipart/mixed; boundary="epJ82nuw8UnAxgR9QopP0hVXRQi4wJ01l"

--epJ82nuw8UnAxgR9QopP0hVXRQi4wJ01l
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.07.20 12:18, Vladimir Sementsov-Ogievskiy wrote:
> 25.06.2020 18:21, Max Reitz wrote:
>> Add some helper functions for skipping filters in a chain of block
>> nodes.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 include/block/block_int.h |=C2=A0 3 +++
>> =C2=A0 block.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 55 ++++++++++++++++++=
+++++++++++++++++++++
>> =C2=A0 2 files changed, 58 insertions(+)
>>
>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>> index bb3457c5e8..5da793bfc3 100644
>=20
>=20
> This patch raises two questions:
>=20
> 1. How to treat filters at the end of the backing chain?

It was my understanding that this configuration would be impossible.

> - child-access function will return no filter child for such nodes, it's
> correct of course
> - filer skipping functions will return this filter.. How much is it
> correct - I don't know.
>=20
>=20
> Consider a chain
>=20
> top --- backing ---> filter-with-no-child

How would it be possible to have filter without a child?

> if bdrv_backing_chain_next(top) returns NULL, it's incorrect, because
> top actually have backing, and on read it will read from it for
> unallocated clusters (and this should crash). So, probably, returning
> filter as a backing-chain-next is a valid thing to do. Or we should
> assert that we are not in such situation (which may crash more often
> than trying to really read from nonexistent child).
>=20
> so, returning NULL, may even less correct than returning a filter..
>=20
>=20
> 2. How to tread nodes with drv=3DNULL, but with filter child (with
> BDRV_CHILD_FILTERED role).

drv=3DNULL is a bug on its own that should be fixed...  (The idea we had
at some point was to introduce a special driver that just always returns
-EIO on everything, and to replace corrupt qcow2 nodes by that.  Or,
well, we might just return -EIO from the qcow2 driver, actually, if we
never use drv=3DNULL anywhere else.)

In any case, drv=3DNULL is an edge case that I think never has anything to
do with filters.

> - child-access functions returns no filtered child for such nodes
> - filter skipping functions will stop on it..
>=20
> =3D=3D=3D=3D=3D=3D=3D
>=20
> Isn't it better to drop drv->is_filter at all? And call filter nodes
> with a bs->file or bs->backing
> child in BDRV_CHILD_FILTERED role? This automatically closes the two
> questions:
>=20
> - node without a child in BDRV_CHILD_FILTERED is automatically
> non-filter. So, filter driver is responsible for having such child.
> - node without a drv may still be a filter if it have
> BDRV_CHILD_FILTERED.. Still, not very useful.
>=20
> Anyway, is_filter and BDRV_CHILD_FILTERED are in contradiction, and it
> seems good to get rid of is_filter. But I may miss something.
>=20
> [..]
>=20
>> +
>> +static BlockDriverState *bdrv_do_skip_filters(BlockDriverState *bs,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool
>> stop_on_explicit_filter)
>> +{
>> +=C2=A0=C2=A0=C2=A0 BdrvChild *c;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!bs) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 while (!(stop_on_explicit_filter && !bs->implicit)) =
{
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c =3D bdrv_filter_child(bs);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!c) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brea=
k;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bs =3D c->bs;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Note that this treats nodes with bs->drv =3D=
=3D NULL as not being
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * filters (bs->drv =3D=3D NULL should be repla=
ced by something else
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * anyway).
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * The advantage of this behavior is that this =
function will thus
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * always return a non-NULL value (given a non-=
NULL @bs).
>=20
> I don't see, how it is follows from first sentence? We can skip nodes
> with a child of BDRV_CHILD_FILTERED and drv=3DNULL as well, and still ret=
urn
> non-NULL bs at the end...

My idea was that nodes with bs->drv =3D=3D NULL might not even have
children.  If we treated them like filters and skipped through them, we
would have to return NULL if there is no child.

> Didn't you mean "treat nodes without filter child as not being filters,
> even if they have drv->is_filter =3D=3D true"? This is a real reason for =
the
> second sentence.

Hm.  I implicitly always assume that filters always have a filter child,
so I tend to not even question that part.

Max


--epJ82nuw8UnAxgR9QopP0hVXRQi4wJ01l--

--mLzvLipRwVmryBgtVxlM4zJH4VvgPoDIO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8QaUsACgkQ9AfbAGHV
z0CUmAf/bhBFQjns4pIZJfM3zuXE+gRP5DEGhKKjixi2EEPvd4Bb1GLWnoJgbSyK
5ibwewZC7YOdll9xbu/tjIe54qTnTN9FveBaokQT4k/ARVaNqNgfSTi9Ioes9SO/
2xN+tzvv0kMLM55j3gvBxQz9bBfdGlRpxun+nwHiAqSC1haGuck3T8mHQuGxF2W+
4T7NXHOc2jhTmH/OgHhvIkZ76F6Ka6kbPX3q6GRp4XBkqkMajJNg+VUB4us1I39a
9Y5PMUt7h7s/7tK39XjgJE5VySBHV/W85DCD9G0pUIYc8iyplvYzM62U1jcYXS1H
g43HnhIxhNuiPjKyB8qSSKtUhJe4Mg==
=IJWW
-----END PGP SIGNATURE-----

--mLzvLipRwVmryBgtVxlM4zJH4VvgPoDIO--


