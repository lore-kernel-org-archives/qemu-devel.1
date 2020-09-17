Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1162C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 09:36:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43AA42076D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 09:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJ6VASJ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43AA42076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIqKu-00043J-1J
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 05:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kIqJj-0003FI-59
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 05:35:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32370)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kIqJh-000728-NY
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 05:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600335300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2MYXUR9I6MV6uFzEDEiz8aG+hCoy/OoqhdzzXBtpbQw=;
 b=GJ6VASJ5sCzo2+Ibv+wFQjRTPYqPx6b/H0hdEJ8aQMckHWl8FwFhDBlhvTo7Ft2AuJy6ji
 NP2WXRd9TZ41fEA5TKB898nFhCLyJYEqwBgniS+y3eKqZPBEvG1JgdL922ncPF0tcGrZhZ
 56338z9A/2TgAMoCUFzZCxvaw1ROqJ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-IHOQw-W2OFq5CPfZdc83Gw-1; Thu, 17 Sep 2020 05:34:56 -0400
X-MC-Unique: IHOQw-W2OFq5CPfZdc83Gw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0F2D107465A;
 Thu, 17 Sep 2020 09:34:54 +0000 (UTC)
Received: from localhost (ovpn-114-232.ams2.redhat.com [10.36.114.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1468760FC2;
 Thu, 17 Sep 2020 09:34:50 +0000 (UTC)
Date: Thu, 17 Sep 2020 10:34:50 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Li Qiang <liq3ea@gmail.com>
Subject: Re: [PATCH 2/3] virtio-blk: undo destructive iov_discard_*()
 operations
Message-ID: <20200917093450.GA809514@stefanha-x1.localdomain>
References: <20200812104918.107116-1-stefanha@redhat.com>
 <20200812104918.107116-3-stefanha@redhat.com>
 <CAKXe6SJqS61dUaKjbXb4-TGMcDLCG-ss2Mo0WaHYa32bcgO0TQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKXe6SJqS61dUaKjbXb4-TGMcDLCG-ss2Mo0WaHYa32bcgO0TQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--gKMricLos+KVdGMg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2020 at 11:38:36PM +0800, Li Qiang wrote:
> Stefan Hajnoczi <stefanha@redhat.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8812=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=886:51=E5=86=99=E9=81=93=EF=BC=
=9A
> > @@ -644,7 +648,8 @@ static int virtio_blk_handle_request(VirtIOBlockReq=
 *req, MultiReqBuffer *mrb)
> >      req->in =3D (void *)in_iov[in_num - 1].iov_base
> >                + in_iov[in_num - 1].iov_len
> >                - sizeof(struct virtio_blk_inhdr);
> > -    iov_discard_back(in_iov, &in_num, sizeof(struct virtio_blk_inhdr))=
;
> > +    iov_discard_back_undoable(in_iov, &in_num, sizeof(struct virtio_bl=
k_inhdr),
> > +                              &req->inhdr_undo);
> >
> >      type =3D virtio_ldl_p(vdev, &req->out.type);
> >
>=20
> It seems there is another error path need to do the undo operations.
> case VIRTIO_BLK_T_WRITE_ZEROS & ~VIRTIO_BLK_T_OUT
> handler has an error path.

Yes, thank you! I'll fix it in the next revision.

Stefan

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9jLbkACgkQnKSrs4Gr
c8hHNgf/VSW+x1LLTHAwZfFXLBBBD4gzq0N8DATFSwxY+V1jzAcQx5uTKjfGHwwx
2+idy8NH1RE8uWtTY0BRdT9g+pes769icivhICzRArEIBK/w5lg7LG7wzmR3t0R3
1jGWveqnuHKDw6Z+RDfFfgrB/KpkEqwyAxWnImm2WDZgQhi1UHWRnOXs0mZLxqW0
SLI6I9y1XLzTugHuWm/kxU8EgiASA3HPZWJL+J/Ql1rqCj3vsKdj8PGW2TVw+nlG
bgT3bC7TfAxjtHFbyjrTmKgWyLSf616WH9ajxGYjwi53l5U26DgZmcWVjhnEjrzx
sKa4QYIlX1k56RzlJE9JIZRTMokCYQ==
=87cm
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--


