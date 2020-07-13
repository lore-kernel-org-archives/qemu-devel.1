Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAE8C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:35:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 682C4206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OACaDYs4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 682C4206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzYe-0003yC-NB
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1juzT1-0004dW-1m
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:30:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21736
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1juzSz-0000bd-0g
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594650600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KuHx74efvx+8eNrpepbY3i+FWMPE4SOSEswgndMVdNg=;
 b=OACaDYs4cgPgGLFz36cPaXuS4/pr4cgCMMsf8AQ0hPTNw0wpua97GV8L+9czK+KCaOMrY2
 k6ssT1k5hJand12763hVyvTANaLRiPpIS8/BIX1C+G+WR5lqQYRE6rf1omNSt5yed17/sX
 mPJh+LYM7P3QIwt/vPHcg80X6e1daXo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-Era4eKxeOXGTv_pHLdoozQ-1; Mon, 13 Jul 2020 10:29:57 -0400
X-MC-Unique: Era4eKxeOXGTv_pHLdoozQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EACB855A5A;
 Mon, 13 Jul 2020 14:29:52 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-91.ams2.redhat.com [10.36.114.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 57FC510013C0;
 Mon, 13 Jul 2020 14:29:51 +0000 (UTC)
Date: Mon, 13 Jul 2020 16:29:49 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH for-5.1 1/2] block: Require aligned image size to avoid
 assertion failure
Message-ID: <20200713142949.GD10318@linux.fritz.box>
References: <20200710142149.40962-1-kwolf@redhat.com>
 <20200710142149.40962-2-kwolf@redhat.com>
 <e608699f-b2c2-d7a0-cb59-703832ae732a@redhat.com>
MIME-Version: 1.0
In-Reply-To: <e608699f-b2c2-d7a0-cb59-703832ae732a@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JWEK1jqKZ6MHAcjA"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
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
Cc: nsoffer@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--JWEK1jqKZ6MHAcjA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 13.07.2020 um 13:19 hat Max Reitz geschrieben:
> On 10.07.20 16:21, Kevin Wolf wrote:
> > Unaligned requests will automatically be aligned to bl.request_alignmen=
t
> > and we don't want to extend requests to access space beyond the end of
> > the image, so it's required that the image size is aligned.
> >=20
> > With write requests, this could cause assertion failures like this if
> > RESIZE permissions weren't requested:
> >=20
> > qemu-img: block/io.c:1910: bdrv_co_write_req_prepare: Assertion `end_se=
ctor <=3D bs->total_sectors || child->perm & BLK_PERM_RESIZE' failed.
> >=20
> > This was e.g. triggered by qemu-img converting to a target image with 4=
k
> > request alignment when the image was only aligned to 512 bytes, but not
> > to 4k.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  block.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
>=20
> (I think we had some proposal like this before, but I can=E2=80=99t find =
it,
> unfortunately...)
>=20
> I can=E2=80=99t see how with this patch you could create qcow2 images and=
 then
> use them with direct I/O, because AFAICS, qemu-img create doesn=E2=80=99t=
 allow
> specifying caching options, so AFAIU you=E2=80=99re stuck with:
>=20
> $ ./qemu-img create -f qcow2 /mnt/tmp/foo.qcow2 1M
> Formatting '/mnt/tmp/foo.qcow2', fmt=3Dqcow2 cluster_size=3D65536
> compression_type=3Dzlib size=3D1048576 lazy_refcounts=3Doff refcount_bits=
=3D16
>=20
> $ sudo ./qemu-io -t none /mnt/tmp/foo.qcow2
> qemu-io: can't open device /mnt/tmp/foo.qcow2: Image size is not a
> multiple of request alignment
>=20
> (/mnt/tmp is a filesystem on a =E2=80=9Closetup -b 4096=E2=80=9D device.)

Hm, that looks like some regrettable collateral damage...

Well, you could argue that we should be writing full L1 tables with zero
padding instead of just the used part. I thought we had fixed this long
ago. But looks like we haven't.

But we should still avoid crashing in other cases, so what is the
difference between both? Is it just that qcow2 has the RESIZE permission
anyway so it doesn't matter?

If so, maybe attaching to a block node with WRITE, but not RESIZE is
what needs to fail when the image size is unaligned?

> Or you use blockdev-create, that seems to work (because of course you
> can set the cache mode on the protocol node when you open it for
> formatting).  But, well, I think there should be a working qemu-img
> create case.
>=20
> Also, I=E2=80=99m afraid of breaking existing use cases with this patch (=
just
> qemu-img create + using the image with cache=3Dnone).

I think for raw images, failure on start is better than crashing when
the VM is running. The qcow2 case needs to be fixed, of course.

Either case, I guess patch 2 can already be merged and would solve at
least the immediate bug report.

Kevin

--JWEK1jqKZ6MHAcjA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl8Mb90ACgkQfwmycsiP
L9acAQ//c8YJ4rXVGHr91REeL157dH+mW5C9dy+amEM7q/NwOAJhMWKIdIc1gCYR
MrAQML+QouZ3CvU1tVgtRYWuVgreHYAt/AYyjGRaetLVUjMAYoUhNmPuQw/NBLpl
zIGYsGv4cXIoMz4PLQne8Ufcpzf8F7f+ePDdZr5I0CWxz952MtRG4yr62PYlfzPx
86LE/tR/y8C5qcwkhUtVFUPDtiyq4lDVuoO8idfPGCehK/NxQuwKLJOUGTqFYY5j
Da9HSRRWGd7VUNOX9H0jRRPbQCcdCVTTutYWZAh72QCHY24vDee45x5RxTWpLSJl
2PF6p0jh1ECGOma87a0Ae8Zsg9aK7mM+nKuLkfKZpJyqf3opLJvnNnKWUrlRb0BI
FYOAXLLBQr+Ix+olXi1PerxWu37Ft8qH2UlDQQMLiu4zMuk6MmLPACHG0+1Z9QTu
TKOpgnpzAFo3hiBWP15S3F5EB2e1o273gE9sq7bHu4dOxKQSnJT2DWTrFw8robpe
4tJGOdfAzXV/SOP6A4Ya5pwtmsLBO03BGFOpo0U9+TIJ5ELNiMVELkPU0dVDokDV
fseiAtXv/7k/YES3l9+JpealqRWMDM6zI3AnQ+VMCA1epQcZAdxdfLNOuKG5ggMM
4B9oNx2FRt/Dj1TlqZd6VT3KeNTFbWwIl38df+sNC2aWuLVCNIo=
=96NO
-----END PGP SIGNATURE-----

--JWEK1jqKZ6MHAcjA--


