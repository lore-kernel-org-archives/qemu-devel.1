Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2EBC433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 11:09:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69ADD22205
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 11:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqoPggCH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69ADD22205
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvIoS-0002Uv-NZ
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 07:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jvInl-0001eh-DX
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 07:08:45 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56914
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jvInj-00065w-N8
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 07:08:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594724922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=os6rJIit1S3gdVf7Wihy1bFiw6XE3thx31V+wPR8wok=;
 b=JqoPggCHRFv7wGvF07WhxKQ4couU/ah12qpO/UQTtKNk+qUnzb3ACd0WToPfmYm59bXxgU
 3IxmweypfagvgTQLmyIkapczFewTVcDKx4k0wSQnRb5FQhH4YWLlC8X4fwHHypgwq7Apwh
 gu8yvuk65Mo/mG1PZSFIWehBmPGf2D8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-YBdzXI2MMnyEA0MHyHY9jQ-1; Tue, 14 Jul 2020 07:08:40 -0400
X-MC-Unique: YBdzXI2MMnyEA0MHyHY9jQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B813B1800D42;
 Tue, 14 Jul 2020 11:08:39 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-8.ams2.redhat.com [10.36.114.8])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C13EA710A0;
 Tue, 14 Jul 2020 11:08:38 +0000 (UTC)
Date: Tue, 14 Jul 2020 13:08:37 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH for-5.1 1/2] block: Require aligned image size to avoid
 assertion failure
Message-ID: <20200714110837.GB5120@linux.fritz.box>
References: <20200710142149.40962-1-kwolf@redhat.com>
 <20200710142149.40962-2-kwolf@redhat.com>
 <e608699f-b2c2-d7a0-cb59-703832ae732a@redhat.com>
 <20200713142949.GD10318@linux.fritz.box>
 <b91329db-303f-41ab-5638-3ec7543b55ac@redhat.com>
MIME-Version: 1.0
In-Reply-To: <b91329db-303f-41ab-5638-3ec7543b55ac@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 03:57:32
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
Cc: nsoffer@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--gKMricLos+KVdGMg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 14.07.2020 um 11:56 hat Max Reitz geschrieben:
> On 13.07.20 16:29, Kevin Wolf wrote:
> > Am 13.07.2020 um 13:19 hat Max Reitz geschrieben:
> >> On 10.07.20 16:21, Kevin Wolf wrote:
> >>> Unaligned requests will automatically be aligned to bl.request_alignm=
ent
> >>> and we don't want to extend requests to access space beyond the end o=
f
> >>> the image, so it's required that the image size is aligned.
> >>>
> >>> With write requests, this could cause assertion failures like this if
> >>> RESIZE permissions weren't requested:
> >>>
> >>> qemu-img: block/io.c:1910: bdrv_co_write_req_prepare: Assertion `end_=
sector <=3D bs->total_sectors || child->perm & BLK_PERM_RESIZE' failed.
> >>>
> >>> This was e.g. triggered by qemu-img converting to a target image with=
 4k
> >>> request alignment when the image was only aligned to 512 bytes, but n=
ot
> >>> to 4k.
> >>>
> >>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> >>> ---
> >>>  block.c | 10 ++++++++++
> >>>  1 file changed, 10 insertions(+)
> >>
> >> (I think we had some proposal like this before, but I can=E2=80=99t fi=
nd it,
> >> unfortunately...)
> >>
> >> I can=E2=80=99t see how with this patch you could create qcow2 images =
and then
> >> use them with direct I/O, because AFAICS, qemu-img create doesn=E2=80=
=99t allow
> >> specifying caching options, so AFAIU you=E2=80=99re stuck with:
> >>
> >> $ ./qemu-img create -f qcow2 /mnt/tmp/foo.qcow2 1M
> >> Formatting '/mnt/tmp/foo.qcow2', fmt=3Dqcow2 cluster_size=3D65536
> >> compression_type=3Dzlib size=3D1048576 lazy_refcounts=3Doff refcount_b=
its=3D16
> >>
> >> $ sudo ./qemu-io -t none /mnt/tmp/foo.qcow2
> >> qemu-io: can't open device /mnt/tmp/foo.qcow2: Image size is not a
> >> multiple of request alignment
> >>
> >> (/mnt/tmp is a filesystem on a =E2=80=9Closetup -b 4096=E2=80=9D devic=
e.)
> >=20
> > Hm, that looks like some regrettable collateral damage...
> >=20
> > Well, you could argue that we should be writing full L1 tables with zer=
o
> > padding instead of just the used part. I thought we had fixed this long
> > ago. But looks like we haven't.
>=20
> That would help for the standard case.  It wouldn=E2=80=99t when the clus=
ter
> size is smaller than the request alignment, which, while maybe not
> important, would still be a shame.

I don't think it would be unreasonable to require a cluster size that is
a multiple of the logical block size of your host storage if you want to
use O_DIRECT.

But we have unaligned images in practice, so this is pure theory anyway.

> > But we should still avoid crashing in other cases, so what is the
> > difference between both? Is it just that qcow2 has the RESIZE permissio=
n
> > anyway so it doesn't matter?
>=20
> I assume so.
>=20
> > If so, maybe attaching to a block node with WRITE, but not RESIZE is
> > what needs to fail when the image size is unaligned?
>=20
> That sounds reasonable.
>=20
> The obvious question is what happens when the RESIZE capability is
> removed.  Dropping capabilities may never fail =E2=80=93 I suppose we cou=
ld
> force-keep the RESIZE capability for such nodes?

It's not nice, but I think we already have this kind of behaviour for
unlocking failures. So yes, that sounds like an option.

> Or we could immediately align such files to the block size once they
> are opened (with the RESIZE capability).

Automatically resizing the image file is obviously harmless for qcow2
images, but it would be a guest-visible change for raw images. It might
be better to avoid this.

Kevin

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl8NkjUACgkQfwmycsiP
L9ZMrw/9ELDQuUZJhuzeWyaUPMLbGD52Z8CZUXyRs+BosfZLeMnuOcnhTJkJSSpD
aU3/eoqa7HsYVLpBreXojaTOE/wc+asBJ3Ql60BSIEbnxHr5gJJZj8Xoy99/oYRv
XCmPpHUOz37Q10V1M2hdvHat4Ind5YpIFbwUisAMmU6Iv+6tTNfoE7JC8QZ0zjuo
VVc3LV+XJMad3yYWzdF3VFQDVq5iOrOaYkN82tAWzHBkqd9fzXTQeQ+6j8+nEQ6O
8zbL6FuV4N+rm0qbDgh/wtchnd+D2i2bbGp3wMuS4H12t8BvSNEU06ONSFEpe/Z0
3Yro/Ygn3ys5CvUcewRR3d06sc98495k6Sqg3p37vz63ow++HIrnGuSHK3fdghbE
P3YIQW8HX3eEkzdbqdDuRaOnw1OB2GXscYi9NF3op8RWXPtzufQ5FoIx+7M4chSe
sDoQw/fDffX3QrzTRNBuWbZU836TYpFd0Ce1Er4EksM/gcCYrCwYgt1k2Aj7rX40
IAeqJt5W3J8ZmwXkYfwcQi04FXO7waqK2Ve62+CBDZmRa778eacCrH8rkXujefFd
64p+3HB90C1g8+DbDvP02N0NW0WS8RTqekXo0Y2VplEe4ZqzB2Pd2GmOjbFU4Ibm
7viG4fQmenyawZ0Fa+7SqKJfNxP33+MCNBhpk3NpMRtiDaXvRsg=
=SlF2
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--


