Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19938C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:49:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D737A2072B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cMwcT89U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D737A2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is6SG-0004U7-VT
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 09:49:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55038)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1is6Qy-00030y-4g
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:47:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1is6Qu-0000QQ-84
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:47:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55002
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1is6Qu-0000Pj-38
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:47:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579186059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+sbap7uzNKwHw3psXwrbw0KjGUoSDex6BWh/f8d7uMg=;
 b=cMwcT89UIV35Ll82divc/H34BGKbetxaR4gn/n/nIe76GTeaGIdVLxgWpPkq2479ue+xq5
 P5ENPv4hyyEMmFUMYA5Mwn3h6obz7fmuZYJyrulWj0kUFEe1rA9kDyW4/AevR3UODq9O63
 1Jsmet9sjSFTW7feF0BJpRIPwCAqP80=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-G-WN01UrOsGjgyuIP1PVXQ-1; Thu, 16 Jan 2020 09:47:36 -0500
X-MC-Unique: G-WN01UrOsGjgyuIP1PVXQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA3768010DA;
 Thu, 16 Jan 2020 14:47:35 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-185.ams2.redhat.com
 [10.36.117.185])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 19F425DA7C;
 Thu, 16 Jan 2020 14:47:31 +0000 (UTC)
Subject: Re: Bug? qemu-img convert to preallocated image makes it sparse
To: "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mlevitsk@redhat.com, sgarzare@redhat.com
References: <20200116141352.GA32053@redhat.com>
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
Message-ID: <962aa54b-f6e5-bb43-50a0-c4cad59cd22e@redhat.com>
Date: Thu, 16 Jan 2020 15:47:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200116141352.GA32053@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qu1NtHseABfrY1CyfLI9RPA1Aw8AR3R4f"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qu1NtHseABfrY1CyfLI9RPA1Aw8AR3R4f
Content-Type: multipart/mixed; boundary="5Iz2mnu05TXpl71brMTcx8pAdNHKvyqQm"

--5Iz2mnu05TXpl71brMTcx8pAdNHKvyqQm
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 16.01.20 15:13, Richard W.M. Jones wrote:
> I'm not necessarily saying this is a bug, but a change in behaviour in
> qemu has caused virt-v2v to fail.  The reproducer is quite simple.
>=20
> Create sparse and preallocated qcow2 files of the same size:
>=20
>   $ qemu-img create -f qcow2 sparse.qcow2 50M
>   Formatting 'sparse.qcow2', fmt=3Dqcow2 size=3D52428800 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16
>=20
>   $ qemu-img create -f qcow2 prealloc.qcow2 50M -o preallocation=3Dfalloc=
,compat=3D1.1
>   Formatting 'prealloc.qcow2', fmt=3Dqcow2 size=3D52428800 compat=3D1.1 c=
luster_size=3D65536 preallocation=3Dfalloc lazy_refcounts=3Doff refcount_bi=
ts=3D16
>=20
>   $ du -m sparse.qcow2 prealloc.qcow2=20
>   1 sparse.qcow2
>   51=09prealloc.qcow2
>=20
> Now copy the sparse file into the preallocated file using the -n
> option so qemu-img doesn't create the target:
>=20
>   $ qemu-img convert -p -n -f qcow2 -O qcow2 sparse.qcow2 prealloc.qcow2
>       (100.00/100%)
>=20
> In new qemu that makes the target file sparse:
>=20
>   $ du -m sparse.qcow2 prealloc.qcow2=20
>   1 sparse.qcow2
>   1 prealloc.qcow2         <-- should still be 51
>=20
> In old qemu the target file remained preallocated, which is what
> I and virt-v2v are expecting.
>=20
> I bisected this to the following commit:
>=20
> 4d7c487eac1652dfe4498fe84f32900ad461d61b is the first bad commit
> commit 4d7c487eac1652dfe4498fe84f32900ad461d61b
> Author: Max Reitz <mreitz@redhat.com>
> Date:   Wed Jul 24 19:12:29 2019 +0200
>=20
>     qemu-img: Fix bdrv_has_zero_init() use in convert
>    =20
>     bdrv_has_zero_init() only has meaning for newly created images or ima=
ge
>     areas.  If qemu-img convert did not create the image itself, it canno=
t
>     rely on bdrv_has_zero_init()'s result to carry any meaning.
>    =20
>     Signed-off-by: Max Reitz <mreitz@redhat.com>
>     Message-id: 20190724171239.8764-2-mreitz@redhat.com
>     Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
>     Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>     Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
>  qemu-img.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> Reverting this commit on the current master branch restores the
> expected behaviour.

So what this commit changed was that when you take an existing image as
the destination, you can=E2=80=99t assume anything about its contents.  Bef=
ore
this commit, we assumed it=E2=80=99s zero.  That=E2=80=99s clearly wrong, b=
ecause it can
be anything.

So when you convert to the target image, you have to make sure all areas
that are zero in the source are zero in the target, too.  The way we do
that is to write zeroes to the target.  The problem is that this
operation disregards the previous preallocation and discards the
preallocated space.

As for fixing the bug...  Can we fix it in qemu(-img)?

We could try to detect whether areas that are zero in the source are
zero in the (preallocated) target image, too.  But doing so what require
reading the data from those areas and comparing it to zero.  That would
take time and it isn=E2=80=99t trivial.  So that=E2=80=99s something I=E2=
=80=99d rather avoid.

Off the top of my head, the only thing that comes to my mind would be to
add a flag to qemu-img convert with which you can let it know that you
guarantee the target image is zero.  I suppose we could document it also
to imply that given this flag, areas that are zero in the source will
then not be changed in the target image; i.e. that preallocation stays
intact in those areas.


OTOH, can it be fixed in virt-v2v?  Is there already a safe way to call
qemu-img convert -n and keeping the target=E2=80=99s preallocation intact?
Unfortunately, I don=E2=80=99t think so.  I don=E2=80=99t think we ever gua=
ranteed it
would, and well, now it broke.


So would you be OK with a --target-is-zero flag?  (I think we could let
this flag guarantee that your use case works, so it should be future-safe.)

Max


--5Iz2mnu05TXpl71brMTcx8pAdNHKvyqQm--

--qu1NtHseABfrY1CyfLI9RPA1Aw8AR3R4f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl4gd4IACgkQ9AfbAGHV
z0A9Nwf5AYBgBxHpE0HgVIejtBipRPW4oDZudc/RxNjNxznWR3yQM+2+mi8846tT
fNbD4EUsY/28P82ih+XmTaqc7wFzMjpHyNj31u6Cu8Rhb0rFATtD1oS4QMPhQYJL
q+OXaRxBSD6Az158LJ2HPJbTslhcvmEBOX8+wMJw1UUyp9HPQwykXTaZPOPAkGG0
o3rqR74Ly4NGuRsumepKqQe4Iz7qJbvHttE+fUz35VNshWI+0g1Ic7KXKe9PL2N+
aP+4ojSX0xy12nujbT4pv88b3X56AbxPOakqYMQWtu421ryLvPJq///9enH2GYc8
5Ej4Z8UnGDHiPQWiea/tCWbiOb1aGQ==
=M78W
-----END PGP SIGNATURE-----

--qu1NtHseABfrY1CyfLI9RPA1Aw8AR3R4f--


