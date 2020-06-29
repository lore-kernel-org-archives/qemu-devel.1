Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97378C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 13:57:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DF2D23D51
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 13:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X/tPlhg8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF2D23D51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpuHl-0006i6-ME
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 09:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jpuH1-0005iw-Aw
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 09:56:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23398
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jpuGz-0002RR-4C
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 09:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593438995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zs1Q917Nlbf713gmx8ibbR6c33QHtcOA7fez2uyaoOg=;
 b=X/tPlhg8b7NgF2v00qW81GxbjCD4a0juqLtvjN5qW+eonve2BkjNvs6aVTJfSFU05ckio/
 gC+5hUa3eT/cbYSJ0gWQdMJ0+f/xRfxll7r/VLi6e63gNQ1ACRgq6VcFJ92ua51Lb6Eu5p
 6B+/fua1h/K7vOwWA5pz87GO7AZUhCI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-3Sz0qSJaNBCrsC9YkKTmWQ-1; Mon, 29 Jun 2020 09:56:20 -0400
X-MC-Unique: 3Sz0qSJaNBCrsC9YkKTmWQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 865BF1005512;
 Mon, 29 Jun 2020 13:56:18 +0000 (UTC)
Received: from localhost (ovpn-115-85.ams2.redhat.com [10.36.115.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DE59F71665;
 Mon, 29 Jun 2020 13:56:17 +0000 (UTC)
Date: Mon, 29 Jun 2020 14:56:16 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 3/4] nbd: make client_close synchronous
Message-ID: <20200629135616.GR31392@stefanha-x1.localdomain>
References: <20200625142540.24589-1-vsementsov@virtuozzo.com>
 <20200625142540.24589-4-vsementsov@virtuozzo.com>
 <6f10f2d1-49f3-edff-eff6-0a2f97c07ebc@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <6f10f2d1-49f3-edff-eff6-0a2f97c07ebc@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ivHc2SZskddb40s2"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:10:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--ivHc2SZskddb40s2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2020 at 10:55:06AM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Also, why in block/io.c we kick the main context, but not bs->aio_context=
?

From AIO_WAIT_WHILE():

 * The caller's thread must be the IOThread that owns @ctx or the main loop
 * thread (with @ctx acquired exactly once).  This function cannot be used =
to
 * wait on conditions between two IOThreads since that could lead to deadlo=
ck,
 * go via the main loop instead.

Case 1: IOThread

  while ((cond)) {                                           \
      aio_poll(ctx_, true);                                  \
      waited_ =3D true;                                        \
  }                                                          \

In this case aio_poll() returns after every event loop iteration and we
will re-evaluate cond. Therefore we don't need to be kicked.

Case 2: Main loop thread

In this case we need the kick since we're waiting on the main loop
AioContext, not the IOThread AioContext that is doing the actual work.
aio_wait_kick() schedules a dummy BH to wake up the main loop thread.

There is no harm in scheduling the dummy BH in the main loop thread when
AIO_WAIT_WHILE() is called from an IOThread.

Hope this helps,
Stefan

--ivHc2SZskddb40s2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl758wAACgkQnKSrs4Gr
c8gTCggAn5V9Rf2aMfSWzCihwUQSVP/+9bg6g20nznWma3bVvQ/3ALjCH0BDm8iJ
q+5WieeYc/l2TZ4ln83vGpYLweBp9eSVo2cVyYZP+I16Qxc1pnakBWvGxFPyP208
q5c5ii4vX/PZbK7vaUIDDcKnJg3lL68/RjwRy+/mkU83pKra7WBYgWkHB+r+PFkP
CzM4gAUhJoAseKmVRaUhULswZZlYCrD2pTBEptbomoXhdZvjKKuTDMo+lIk1wt+1
AMPQNiHsEPSPuTNR83YZXgOsITFjRxIxMzCZWmxMAOgaBLwZaXM1w8KeZrtlHh/f
UllD0MnHy2GUeNrddRbNi/R6495pRA==
=tMj8
-----END PGP SIGNATURE-----

--ivHc2SZskddb40s2--


