Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD45C433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:24:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4DCB204FD
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJedPtDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4DCB204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3e79-0003pH-Rd
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k3dVy-0001r5-Pf
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:52:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47339
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k3dVx-000078-0k
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596711168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X9RzPaxnRJzpU4jyAEBv4ovkhnjF/0CGzpCT/YB8Uc0=;
 b=dJedPtDCyepaRSnIsU64reBL9mZ6Z22+K9D5f8YLz3wB3/hz5TNF8Dm4gFELWNLQD4xzNc
 ctZWMDpz+PJo83MMOm7Y4jGAJRllOssVM3hq2y/zvJLPd88husFqO+zlr67CoQQ7viPVjK
 2BPruev3XRUy1kjB14oIc/f36kM5EAY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-ArfAj5R_OZijEH2zvTHANg-1; Thu, 06 Aug 2020 06:52:44 -0400
X-MC-Unique: ArfAj5R_OZijEH2zvTHANg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15A5B8015F0;
 Thu,  6 Aug 2020 10:52:43 +0000 (UTC)
Received: from localhost (ovpn-114-7.ams2.redhat.com [10.36.114.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E98D60C47;
 Thu,  6 Aug 2020 10:52:42 +0000 (UTC)
Date: Thu, 6 Aug 2020 11:52:41 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 3/3] aio-posix: keep aio_notify_me disabled during
 polling
Message-ID: <20200806105241.GA379937@stefanha-x1.localdomain>
References: <20200805100051.361547-1-stefanha@redhat.com>
 <20200805100051.361547-4-stefanha@redhat.com>
 <8e066cf0-e5f9-283c-eedd-47974bf4bbac@redhat.com>
MIME-Version: 1.0
In-Reply-To: <8e066cf0-e5f9-283c-eedd-47974bf4bbac@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 03:10:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 05, 2020 at 06:37:45PM +0200, Paolo Bonzini wrote:
> On 05/08/20 12:00, Stefan Hajnoczi wrote:
> > +
> > +        /*
> > +         * aio_notify can avoid the expensive event_notifier_set if
> > +         * everything (file descriptors, bottom halves, timers) will
> > +         * be re-evaluated before the next blocking poll().  This is
> > +         * already true when aio_poll is called with blocking =3D=3D f=
alse;
> > +         * if blocking =3D=3D true, it is only true after poll() retur=
ns,
> > +         * so disable the optimization now.
> > +         */
> > +        if (use_notify_me) {
> > +            atomic_set(&ctx->notify_me, atomic_read(&ctx->notify_me) +=
 2);
> > +            /*
> > +             * Write ctx->notify_me before reading ctx->notified.  Pai=
rs with
> > +             * smp_mb in aio_notify().
> > +             */
> > +            smp_mb();
> > +
> > +            /* Don't block if aio_notify() was called */
> > +            if (atomic_read(&ctx->notified)) {
> > +                timeout =3D 0;
> > +            }
>=20
> Aha, this is the trick: "timeout =3D 0" also applies if a timer was moved=
=20
> early.  In this case you uselessly keep notify_me set for a bit, but=20
> it's okay. Nice!
>=20
> The code can be simplified a bit more, since the use_notify_me variable=
=20
> is just "timeout":

Good point. I'll send another revision.

Stefan

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8r4PgACgkQnKSrs4Gr
c8jzowf/W9SXMevLAUhOTEubZ8vtANwRdpwPkRTL1i582gQzBeJMffId4ouY2rN+
tfh86e+hzY0VqEPfsOAA9DvLUwvUbwINhSzcqWuDDaCjkhN1fgYhyH+iw+2EK7Bw
Af8xuzoCqZLoXblcT9HZzD0SykLJ8Iq6xcUf+I8VTp1741kh/daDJX8D1BQGCkb+
npDhU96i1yXd8OIPysddQ+9NWe5IQvGYcNDRq4vS7Mv99jGtDB0qwpVu7+NjMMAA
he6Sbw82hj9tym99XfaUUS2sL5NIgQL+c2H4x9agIycF3OvZFM/tJm9PeC5isz6S
brmnoTPLsC4sEcd3np1TnUuDCSdo7A==
=rIhj
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--


