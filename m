Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F3CC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 10:13:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35A17208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 10:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SvtaPVk8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35A17208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIUR3-0003hD-7Q
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 06:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kIUQG-0003Cs-FM
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 06:12:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41834
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kIUQE-0003II-8V
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 06:12:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600251137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=210BddsFxddOLjaO0t430DwryKuf0tHVFGarIM7Kx0M=;
 b=SvtaPVk8UUmKxnY7hZBMvmbT5p84uBM1QtDghiQCRA4R7EwNbn5E1IIxxwezLgBDZ/fSrq
 v+VTlD/rfyZxxGC3sXHdgmqKze68+YddgGCctRfRDJQOT4HMCEjlGFrLbwiRffg7WnccA3
 vDAmweXNM6C/P2WcaU4lzzrlQkcX4tA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-hbcfDC0wMvu_CfucerM4Xg-1; Wed, 16 Sep 2020 06:12:14 -0400
X-MC-Unique: hbcfDC0wMvu_CfucerM4Xg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BDCC8027E2;
 Wed, 16 Sep 2020 10:12:13 +0000 (UTC)
Received: from localhost (ovpn-115-47.ams2.redhat.com [10.36.115.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2E136100164C;
 Wed, 16 Sep 2020 10:12:09 +0000 (UTC)
Date: Wed, 16 Sep 2020 11:12:07 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Li Qiang <liq3ea@gmail.com>
Subject: Re: [PATCH 3/3] virtio-crypto: don't modify elem->in/out_sg
Message-ID: <20200916101207.GB756046@stefanha-x1.localdomain>
References: <20200812104918.107116-1-stefanha@redhat.com>
 <20200812104918.107116-4-stefanha@redhat.com>
 <CAKXe6SKE+Zmyethcb6KUWxnr6FpieWe=o3O-cupyxreQObVLWA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKXe6SKE+Zmyethcb6KUWxnr6FpieWe=o3O-cupyxreQObVLWA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 03:05:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 16, 2020 at 04:32:06PM +0800, Li Qiang wrote:
> Stefan Hajnoczi <stefanha@redhat.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8812=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=886:51=E5=86=99=E9=81=93=EF=BC=
=9A
>=20
> > A number of iov_discard_front/back() operations are made by
> > virtio-crypto. The elem->in/out_sg iovec arrays are modified by these
> > operations, resulting virtqueue_unmap_sg() calls on different addresses
> > than were originally mapped.
> >
> > This is problematic because dirty memory may not be logged correctly,
> > MemoryRegion refcounts may be leaked, and the non-RAM bounce buffer can
> > be leaked.
> >
> > Take a copy of the elem->in/out_sg arrays so that the originals are
> > preserved. The iov_discard_undo() API could be used instead (with bette=
r
> > performance) but requires careful auditing of the code, so do the simpl=
e
> > thing instead.
> >
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> >
>=20
> virtio-net also uses this method.

virtio-net operates on a copy of the iovecs (g_memdup()) so no changes
are necessary.

--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9h5PcACgkQnKSrs4Gr
c8h5wAgAwaBdd/0E7BbNypOOrt/kvvuOh195kXIqavFz259qFoOxF98O02yTqDSC
2XRkgHgWbLIIjcGESr5J3wWCPj+LY8f/WFeEZCq8gesgPvPMM1nk46Mu64O1dScH
Lf3+ZMgdWVwk6QrzAwpy/PamCrFAijhG14OcdVqQZEn9sWOTflu7oGxRFcuP8Y9r
GnpyWBMdMkKUmCsona5ZKr7aFDGTki4iIdG9lQJK/gvTPQUsEzZ5YwQudV6JnjKu
llFRd4vcLBpaX/1n+fPOO9rohCq5niI3qz55m64fSCABeDVQFjgJlRWZJ1KuAPbD
7Atg3TfQbErCL51yI88A6Z93qyQuuQ==
=D5fz
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--


