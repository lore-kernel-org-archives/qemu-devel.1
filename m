Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49ED9C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 11:11:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F266920661
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 11:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bd9WXq7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F266920661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTO8l-00008m-3T
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 07:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48072)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTO6i-0006RO-AL
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 07:09:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTO67-00030O-9j
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 07:08:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47027
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jTO66-00030E-RR
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 07:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588072098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=01R+5Y8HbBivhoGrvrE7kUMhcAswwjErtnjAxJ9Aidg=;
 b=bd9WXq7eIsO0gz+c7S5VDr2TZ6F1YPUhTtBs4MiB/my9quYOoRrriZDjvHscf/0Iv2nGiT
 oscYdzUhjPN3adzUgA+QQprv4ZuW5AGvPMJuEApKIjI0bmnXfbGWo1OGAZJukuleNI/w9h
 47z1GXDbvz0KhPiFM0qAt/Dfe//8Imo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-LteqpjLbP6KC61XfKxizyQ-1; Tue, 28 Apr 2020 07:08:15 -0400
X-MC-Unique: LteqpjLbP6KC61XfKxizyQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEDE31005510;
 Tue, 28 Apr 2020 11:08:14 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 32EF15D9E4;
 Tue, 28 Apr 2020 11:08:13 +0000 (UTC)
Subject: Re: backing chain & block status & filters
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu block <qemu-block@nongnu.org>
References: <a1c1b734-34dc-f8d3-b6a0-43b136e237e2@virtuozzo.com>
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
Message-ID: <20e6c43f-c1a7-57db-58b9-3cb70f0e637f@redhat.com>
Date: Tue, 28 Apr 2020 13:08:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <a1c1b734-34dc-f8d3-b6a0-43b136e237e2@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OmeyYdW8ozdxvl2vgskwXX4yWlas163Ez"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:15:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OmeyYdW8ozdxvl2vgskwXX4yWlas163Ez
Content-Type: multipart/mixed; boundary="2X2f56jw2vbYqW7GQhPZ3QeTXGrfhJCml"

--2X2f56jw2vbYqW7GQhPZ3QeTXGrfhJCml
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.04.20 10:55, Vladimir Sementsov-Ogievskiy wrote:
> Hi!
>=20
> I wanted to resend my "[PATCH 0/4] fix & merge block_status_above and
> is_allocated_above", and returned to all the inconsistencies about
> block-status. I keep in mind Max's series about child-access functions,
> and Andrey's work about using COR filter in block-stream, which depends
> on Max's series (because, without them COR fitler with file child breaks
> backing chains).. And, it seems that it's better to discuss some
> questions before resending.
>=20
> First, problems about block-status:
>=20
> 1. We consider ALLOCATED =3D ZERO | DATA, and documented as follows:
>=20
> =C2=A0=C2=A0 * BDRV_BLOCK_DATA: allocation for data at offset is tied to =
this layer
> =C2=A0=C2=A0 * BDRV_BLOCK_ZERO: offset reads as zero
> =C2=A0=C2=A0 * BDRV_BLOCK_OFFSET_VALID: an associated offset exists for a=
ccessing
> raw data
> =C2=A0=C2=A0 * BDRV_BLOCK_ALLOCATED: the content of the block is determin=
ed by this
> =C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 layer rather than any backing, set by block
> layer
>=20
> This actually means, that we should always have BDRV_BLOCK_ALLOCATED for
> formats which doesn't support backing. So, all such format drivers must
> return ZERO or DATA (or both?), yes?. Seems file-posix does so, but, for
> example, iscsi - doesn't.

Hm.  I could imagine that there are formats that have non-zero holes
(e.g. 0xff or just garbage).  It would be a bit wrong for them to return
ZERO or DATA then.

But OTOH we don=E2=80=99t care about such cases, do we?  We need to know wh=
ether
ranges are zero, data, or unallocated.  If they aren=E2=80=99t zero, we onl=
y
care about whether reading from it will return data from this layer or not.

So I suppose that anything that doesn=E2=80=99t support backing files (or
filtered children) should always return ZERO and/or DATA.

> 2. ZERO. The meaning differs a bit for generic block_status and for
> drivers.. I think, we at least should document it like this:
>=20
> BDRV_BLOCK_DATA: allocation for data at offset is tied to this layer
> BDRV_BLOCK_ZERO: if driver return ZERO, than the region is allocated at
> this layer and read as ZERO. If generic block_status returns ZERO, it
> only mean that it reads as zero, but the region may be allocated on
> underlying level.

Hm.  What does that mean?

One of the problems is that =E2=80=9Callocated=E2=80=9D has two meanings:
(1) reading data returns data defined at this backing layer,
(2) actually allocated, i.e. takes up space on the file represented by
this BDS.

As far as I understand, we actually don=E2=80=99t care about (2) in the con=
text
of block_status, but just about (1).

So if a layer returns ZERO, it is by definition (1)-allocated.  (It
isn=E2=80=99t necessarily (2)-allocated.)

> 3. bdi.unallocated_blocks_are_zero
>=20
> I think it's very bad, that we have formats, that supports backing, but
> doesn't report bdi.unallocated_blocks_are_zero as true. It means that
> UNALLOCATED region reads as zero if we have short backing file, and not
> as zero if we remove this short backing file.

What do you mean by =E2=80=9Cremove this short backing file=E2=80=9D?  Beca=
use generally
one can=E2=80=99t just drop a backing file.

So maybe a case like block-stream?  Wouldn=E2=80=99t that be a bug in
block-stream them, i.e. shouldn=E2=80=99t it stream zeros after the end of =
the
backing file?

> I can live with it but
> this is weird logic. These bad drivers are qcow (not qcow2), parallels
> and vmdk. I hope, they actually just forget to set
> unallocated_blocks_are_zero to true.

qcow definitely sounds like it.

> Next. But what about drivers which doesn't support backing? As we
> considered above, they should always return ZERO or DATA, as everything
> is allocated in this backing-chain level (last level, of course).. So
> again unallocated_blocks_are_zero is meaningless. So, I think, that
> driver which doesn't support backings, should be fixed to return always
> ZERO or DATA, than we don't need this unallocated_blocks_are_zero at all.

Agreed.

> 3.

The second 3.? :)

> Short backing files in allocated_above: we must consider space after
> EOF as ALLOCATED, if short backing file is inside requested
> backing-chain part, as it produced exactly because of this short file
> (and we never go to backing).

Sounds correct.

> (current realization of allocated_above is
> buggy, see my outdated series "[PATCH 0/4] fix & merge
> block_status_above and is_allocated_above")
>=20
> 4. Long ago we've discussed problems about BDRV_BLOCK_RAW, when we have
> a backing chain of non-backing child.. I just remember that we didn't
> reach the consensus.

Possible? :)

> 5. Filters.. OK we have two functions for them:
> bdrv_co_block_status_from_file and bdrv_co_block_status_from_backing. I
> think both are wrong:
>=20
> bdrv_co_block_status_from_file leads to problem [4], when we can report
> UNALLOCATED, which refers not to the current backing chain, but to sub
> backing chain of file child, which is inconsistent with
> block_status_above and is_allocated_above iteration.
>=20
> bdrv_co_block_status_from_backing is also is not consistent with
> block_status_above iteration.. At least at leads to querying the same
> node twice.

Well, yes.

> So, about filters and backing chains. Keeping (OK, just, trying to keep)
> all these things in mind, I think that it's better to keep backing
> chains exactly *backing* chains, so that "backing" child is the only
> "not own" child of the node. So, its close to current behavior and we
> don't need child-access functions. Then how filters should work:
>=20
> Filter with backing child, should always return UNALLOCATED (i.e. no
> DATA, no ZERO), it is honest: everything is on the other level of
> backing chain.

I disagree, because filters with or without backing children should work
exactly the same way and just not appear in the backing chain.

> Filter with file child should always return BDRV_BLOCK_DATA |
> BDRV_BLOCK_RECURSE, to show that:
> 1. everything is allocated in *this* level of backing chain
> 2. filter is too lazy to dig in it's file child (and, maybe the whole
> sub-tree of it) and asks generic layer to do it by itself, if it wants
> zeroes.
>=20
> Then, of course, if we want some filter to be inside backing chain, it
> should have not "file" child but "backing". For this, we may support in
> current public filter both variants: backing or file, as user prefer.
> I.e., filter is opened either with file option or with backing and
> operate correspondingly. And newer filters (like backup-top) may support
> only backing variants.

I disagree again for the same reason.

Max


--2X2f56jw2vbYqW7GQhPZ3QeTXGrfhJCml--

--OmeyYdW8ozdxvl2vgskwXX4yWlas163Ez
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6oDpsACgkQ9AfbAGHV
z0AIaAgAvUA183fVppYp909lk8/VfanFkxIPuvyc4nMZUBSemvyEh4f4pqMcYrJ3
NkvViZ1pkKJRmBn71z0eTq/vLWiocYlB9/FZRSCrvWdBdxAUMLuC8SaB7asTntfe
kshvc2/37laucom5uM8eBiGfrtccW9LxcorXQ1otcXTsC6Vqs4f8XUVIDzg+Iw8N
5q/BHJYZODKNeJeYNuocwc2cAwixQubQ+hC1eHAetjNnurlgBm5w1+x7fHdBQlir
pmyCieNUxSu9MyDeP9MFMOySmHV69htfwZY2qP5LiPk1Z7yPWFkXQg8WZr6tU/T4
AcbSlgVnV/Oh1TJPjdb3SoFxgsAT5Q==
=bjFd
-----END PGP SIGNATURE-----

--OmeyYdW8ozdxvl2vgskwXX4yWlas163Ez--


