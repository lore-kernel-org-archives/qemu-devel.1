Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDDCC33CB8
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:42:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 093CF20684
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pv6t+AwX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 093CF20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is6ME-0007cr-58
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 09:42:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53369)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1is6HP-0000bG-4m
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:37:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1is6HL-0003Ck-6M
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:37:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39750
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1is6HL-0003CF-1c
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:37:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579185466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=K5MWjzoVsjqeDl2caKNfxPW9mC6LyxlVStu/ygCGCqU=;
 b=Pv6t+AwXdWzXEsOcyPIeC5i/Im6q1kgq4nSu0PAoMLI59ldOuxLcfPFck5NfuwZg2ww7jK
 DTHMEZwPnz/OYewgZZFLUf7W+sroBQUW4znl21I6HPnQgltHh39ig38Xz7zjIV3BPBu+ly
 8INuDQ7/gOC76SiLbr0HP6k/T89OIPo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-Og4AZ9LsMZy7-IiFCVM2-w-1; Thu, 16 Jan 2020 09:37:44 -0500
X-MC-Unique: Og4AZ9LsMZy7-IiFCVM2-w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F5DE8F802B;
 Thu, 16 Jan 2020 14:37:43 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-185.ams2.redhat.com
 [10.36.117.185])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5291E61069;
 Thu, 16 Jan 2020 14:37:39 +0000 (UTC)
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
Message-ID: <7586b832-ecd2-e766-6781-3a25f382c9ed@redhat.com>
Date: Thu, 16 Jan 2020 15:37:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200116141352.GA32053@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yYkd6eRpVHB0Lwjk98UHPMHu7ZUEkcRKr"
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
--yYkd6eRpVHB0Lwjk98UHPMHu7ZUEkcRKr
Content-Type: multipart/mixed; boundary="XoLD4rKeJuZ4WIQZkJmyzjCLdg5wOFr7M"

--XoLD4rKeJuZ4WIQZkJmyzjCLdg5wOFr7M
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

The commit changed the behavior because now qemu-img realizes that it
cannot skip writing to areas that are supposed to be zero when it
converts to an existing image (because we have no idea what data that
existing image contains).  So that=E2=80=99s a bug fix, and I don=E2=80=99t=
 think we can
undo it without being wrong.

The problem is that qemu-img will try to be quickthat about making these
areas zero, and so it does zero writes (actually, it even zeroes the
whole image) and in the process it will of course discard all preallocation=
.

Now, about fixing the problem I=E2=80=99m not so sure.

The problem is that it isn=E2=80=99t easy for qemu-img or the qcow2 driver =
to
determine whether a preallocated area is zero.  It needs to read the
data from disk and compare it to zero.  That would be slow and not trivial.

So off top of my head, the only thing that comes to my mind would be a
new flag for convert that lets you guarantee the image is zero and qemu
doesn=E2=80=99t need to zero it.

The problem with this is that I don=E2=80=99t think we ever guaranteed that
preallocated images stay preallocated when written to, and so even if we
assume the image is fully zero and thus restore the old behavior for
your case, we might break it in the future again.


So are there any ways to safely convert an image to an existing one and
keeping the destinations preallocation intact?  Sadly, I don=E2=80=99t thin=
k
there is.  Well, you can always use -S 0, but that will change your
falloc preallocation into a full one.

So I suppose the best idea I can come up with is indeed a
--target-is-zero flag for qemu-img convert -n.  Would that work for you?

Max


--XoLD4rKeJuZ4WIQZkJmyzjCLdg5wOFr7M--

--yYkd6eRpVHB0Lwjk98UHPMHu7ZUEkcRKr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl4gdSIACgkQ9AfbAGHV
z0D0sQgAsYuuo3MjKtFkuPK1pD4YnFBW1fJLwHtEuBjAm0xQdRwnm9pFAsD6B9YL
/aoTorFjsgArI75YqrieRLgB6KXNV9PInZy2/kVNKpYUEvRJ3mfCyBNr5Km6+HyD
+rzpha9Ly7YpKJguC9Z2qOu05ssartZAiuubmrd+nYgR8qCv8/UBLAsoFRP87d+W
VdzFIYMv/k82X5RHj49n3ptcuEADQ00bEHwcN6D4g3dPmmPbyByfJpR9uP/b/ZLP
RNGyeEyzf4RIoWqeIDOVMcr60cgfz4Wle66N82D60bC4X2G87+2QYO0ghj8Uyhhl
ZCcfUE/4ufl6hiiBTUx0cWlK5+mfRw==
=G7Pj
-----END PGP SIGNATURE-----

--yYkd6eRpVHB0Lwjk98UHPMHu7ZUEkcRKr--


