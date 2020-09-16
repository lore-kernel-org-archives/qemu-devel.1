Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5308C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 10:10:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2F5420795
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 10:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iN5QxYzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2F5420795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIUON-0002aR-4S
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 06:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kIUNL-00023X-Uf
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 06:09:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39404)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kIUNJ-0002qr-ED
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 06:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600250956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ak7jzWSXiAVceJ8UKOsGDGjc6IdRK7bMWFGcyYhdK8E=;
 b=iN5QxYzSocrTUIwPCwi93jdIPLtDTvAYlb7WCayZ7kCMc4Pw8MS67yZOH1pmB+jn/nvE7n
 LW9xUVudxMKtUudvEMfMpeG8KsLusmKIIIcpvQbE4HxquAkJL+c3tBvwDDikwbxAO0FYC+
 ITG3kWOW5H6lE/h60lfq3GYFxzawdn4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-79EJlYvLNMWRCWkXYlX3qg-1; Wed, 16 Sep 2020 06:09:12 -0400
X-MC-Unique: 79EJlYvLNMWRCWkXYlX3qg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A02158015A3;
 Wed, 16 Sep 2020 10:09:10 +0000 (UTC)
Received: from localhost (ovpn-115-47.ams2.redhat.com [10.36.115.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B85E060BFA;
 Wed, 16 Sep 2020 10:09:06 +0000 (UTC)
Date: Wed, 16 Sep 2020 11:09:05 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Li Qiang <liq3ea@gmail.com>
Subject: Re: [PATCH 1/3] util/iov: add iov_discard_undo()
Message-ID: <20200916100905.GA756046@stefanha-x1.localdomain>
References: <20200812104918.107116-1-stefanha@redhat.com>
 <20200812104918.107116-2-stefanha@redhat.com>
 <CAKXe6S+nUWQGFDKRu8mBBOTKc1kWc7YfO=p+F7+ObnmW017atg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKXe6S+nUWQGFDKRu8mBBOTKc1kWc7YfO=p+F7+ObnmW017atg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SHORT_URL=1.21, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 16, 2020 at 04:26:45PM +0800, Li Qiang wrote:
> Stefan Hajnoczi <stefanha@redhat.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8812=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=886:52=E5=86=99=E9=81=93=EF=BC=
=9A

Thanks for your review!

> > +    /* Discard more bytes than vector size */
> > +    iov_random(&iov, &iov_cnt);
> > +    iov_orig =3D g_memdup(iov, sizeof(iov[0]) * iov_cnt);
> > +    iov_tmp =3D iov;
> > +    iov_cnt_tmp =3D iov_cnt;
> > +    size =3D iov_size(iov, iov_cnt);
> > +    iov_discard_front_undoable(&iov_tmp, &iov_cnt_tmp, size + 1, &undo=
);
> > +    iov_discard_undo(&undo);
> > +    assert(iov_equals(iov, iov_orig, iov_cnt));
> >
>=20
> The 'iov_discard_front_undoable' will change the 'iov_tmp' it will not
> touch 'iov_orig'.
> So the test will be always passed. The actually function will not be test=
ed.

The test verifies that the iovec elements are restored to their previous
state by iov_discard_undo().

I think you are saying you'd like iov_discard_undo() to reset the
iov_tmp pointer? Currently that is not how the API works. The caller is
assumed to have the original pointer (e.g. virtio-blk has
req->elem.in/out_sg) and therefore it is not necessary to reset iov_tmp.

> Also, maybe we could abstract a function to do these discard test?

The structure of the test cases is similar but they vary in different
places. I'm not sure if this can be abstracted nicely.

> > diff --git a/util/iov.c b/util/iov.c
> > index 45ef3043ee..efcf04b445 100644
> > --- a/util/iov.c
> > +++ b/util/iov.c
> > @@ -636,14 +636,33 @@ void qemu_iovec_clone(QEMUIOVector *dest, const
> > QEMUIOVector *src, void *buf)
> >      }
> >  }
> >
> > -size_t iov_discard_front(struct iovec **iov, unsigned int *iov_cnt,
> > -                         size_t bytes)
> > +void iov_discard_undo(IOVDiscardUndo *undo)
> > +{
> > +    /* Restore original iovec if it was modified */
> > +    if (undo->modified_iov) {
> > +        *undo->modified_iov =3D undo->orig;
> > +    }
> > +}
> > +
> > +size_t iov_discard_front_undoable(struct iovec **iov,
> > +                                  unsigned int *iov_cnt,
> > +                                  size_t bytes,
> > +                                  IOVDiscardUndo *undo)
> >  {
> >      size_t total =3D 0;
> >      struct iovec *cur;
> >
> > +    if (undo) {
> > +        undo->modified_iov =3D NULL;
> > +    }
> > +
> >      for (cur =3D *iov; *iov_cnt > 0; cur++) {
> >          if (cur->iov_len > bytes) {
> > +            if (undo) {
> > +                undo->modified_iov =3D cur;
> > +                undo->orig =3D *cur;
> > +            }
> > +
> >
>=20
> Why here we remember the 'cur'? 'cur' is the some of the 'iov'.
> Maybe we remember the 'iov'. I think we need the undo structure like this=
:
>=20
> struct IOVUndo {
>     iov **modified_iov;
>     iov *orig;
> };
>=20
> Then we can remeber the origin 'iov'.

Yes, this could be done but it's not needed (yet?). VirtQueueElement has
the original struct iovec pointers so adding this would be redundant.

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9h5EEACgkQnKSrs4Gr
c8i8VAf+NO6YhS/MV51d0fXVv6sVAHNFRrAqAIBJE4+AlbW6o4TKEUI9QQriSduk
IYwVMd1mdrKmCm1iJHNGVV0I1EfmosI3yCtapb1tF2MF3Z2+cwYnGQorpej8l51B
Zz4zPPaRPYcPHg42IOjT7tTMZW+WyGwZcQsqkR+DTH+dK+Ccbl1rDoXdYwOTgAFk
vQB4wqoOSjbL4LDCr9hq1qK1LbIAq74AxzlVIEfroSO9ERIb4NEV9yW78+p/MhZN
bo/tm0ufibbhz6bMJC0R+Lfo+zFP+1jpbmg4DlNBvKmQsbR5zGjF9REnA8+FD94O
uWGVfJ18Y4K9eq1FMrN5R9Az88vnhg==
=elyP
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--


