Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E43C4741F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 10:34:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6859206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 10:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZyM4Pn6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6859206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMqUR-0004RW-KE
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 06:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kMqT9-0003oz-H1
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 06:33:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59131)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kMqT6-00053Z-NN
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 06:33:18 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601289195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bN615i3zu81+vwrS9a/pI/VYHcUKTa+nYYBRhglc5KQ=;
 b=XZyM4Pn6YmYW2NlSkMdbr+twfr58u13fmMYMG+daVlZEM1Dwe54+y6qpFlSULZ2adqUvTU
 L6VDGY3MFze26dNCgguuTb+4BrRnp9xrO80/vTGYOOcINjOHArX9pQaD+RI9lUVjQaIZMc
 rXOFvPblaG+WuyKu3LOrf/7DfnfG8jc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-ejHA1FmHPtWqdjQZbCSoEA-1; Mon, 28 Sep 2020 06:33:12 -0400
X-MC-Unique: ejHA1FmHPtWqdjQZbCSoEA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 208ED802B4B;
 Mon, 28 Sep 2020 10:33:11 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-193.ams2.redhat.com [10.36.114.193])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A28A978437;
 Mon, 28 Sep 2020 10:33:06 +0000 (UTC)
Date: Mon, 28 Sep 2020 12:33:05 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v7 13/13] block: Convert 'block_resize' to coroutine
Message-ID: <20200928103305.GD5451@linux.fritz.box>
References: <20200909151149.490589-1-kwolf@redhat.com>
 <20200909151149.490589-14-kwolf@redhat.com>
 <20200915145733.GF629589@stefanha-x1.localdomain>
 <20200925160750.GJ5731@linux.fritz.box>
 <20200928090514.GE43571@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200928090514.GE43571@stefanha-x1.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WplhKdTI2c8ulnbP"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.576,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com, armbru@redhat.com,
 qemu-block@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--WplhKdTI2c8ulnbP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 28.09.2020 um 11:05 hat Stefan Hajnoczi geschrieben:
> On Fri, Sep 25, 2020 at 06:07:50PM +0200, Kevin Wolf wrote:
> > Am 15.09.2020 um 16:57 hat Stefan Hajnoczi geschrieben:
> > > On Wed, Sep 09, 2020 at 05:11:49PM +0200, Kevin Wolf wrote:
> > > > @@ -2456,8 +2456,7 @@ void qmp_block_resize(bool has_device, const =
char *device,
> > > >          return;
> > > >      }
> > > > =20
> > > > -    aio_context =3D bdrv_get_aio_context(bs);
> > > > -    aio_context_acquire(aio_context);
> > > > +    old_ctx =3D bdrv_co_move_to_aio_context(bs);
> > > > =20
> > > >      if (size < 0) {
> > > >          error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "size", "a =
>0 size");
> > >=20
> > > Is it safe to call blk_new() outside the BQL since it mutates global =
state?
> > >=20
> > > In other words, could another thread race with us?
> >=20
> > Hm, probably not.
> >=20
> > Would it be safer to have the bdrv_co_move_to_aio_context() call only
> > immediately before the drain?
>=20
> Yes, sounds good.
>=20
> > > > @@ -2479,8 +2478,8 @@ void qmp_block_resize(bool has_device, const =
char *device,
> > > >      bdrv_drained_end(bs);
> > > > =20
> > > >  out:
> > > > +    aio_co_reschedule_self(old_ctx);
> > > >      blk_unref(blk);
> > > > -    aio_context_release(aio_context);
> > >=20
> > > The following precondition is violated by the blk_unref -> bdrv_drain=
 ->
> > > AIO_WAIT_WHILE() call if blk->refcnt is 1 here:
> > >=20
> > >  * The caller's thread must be the IOThread that owns @ctx or the mai=
n loop
> > >  * thread (with @ctx acquired exactly once).
> > >=20
> > > blk_unref() is called from the main loop thread without having acquir=
ed
> > > blk's AioContext.
> > >=20
> > > Normally blk->refcnt will be > 1 so bdrv_drain() won't be called, but
> > > I'm not sure if that can be guaranteed.
> > >=20
> > > The following seems safer although it's uglier:
> > >=20
> > >   aio_context =3D bdrv_get_aio_context(bs);
> > >   aio_context_acquire(aio_context);
> > >   blk_unref(blk);
> > >   aio_context_release(aio_context);
> >=20
> > May we actually acquire aio_context if blk is in the main thread? I
> > think we must only do this if it's in a different iothread because we'd
> > end up with a recursive lock and drain would hang.
>=20
> Right :). Maybe an aio_context_acquire_once() API would help.

If you want it to work in the general case, how would you implement
this? As far as I know there is no way to tell whether we already own
the lock or not.

Something like aio_context_acquire_unless_self() might be easier to
implement.

Kevin

--WplhKdTI2c8ulnbP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl9xu+EACgkQfwmycsiP
L9azsxAAlWWHg2VIS9dsexFuM47u5FJSpZNhW0HrF8ztjWHJFgW4L5RjaIzGB8e+
oFdaQuEyvrI364VYErHyhI1s+dXgvo6hLe9dm5erONv/RXI6OqNa++cfdPC5zI8s
m6EZwDcGYSVe4yUZp9RBuOc8JbJwEQ04fadHQSDydQPILJmAiyRtcnRDY8dMQ/mm
3HgWEnXPKPbj88GkyTZysi5G/zyuimHwzSC49F5iPjY4pRA7hII5jdVXrWUh8zpv
HbkZqIKc/lCSRvH7MW42FO0Dj0yebfMvJEQQ+RBjH3Wv+psixQ5m/dQdCEeBvg9R
hmcM69x2h45RH8fQSRYrg13E6mZvfPFQsoyd1sd3m3fS2YOr0cqc1P0cq9tLsFXI
6YhABFxZl4WbTUhuHrja36huhBtMncZKHk/XHgcRZnomYVepOeq9REJwanSoJaHw
QYRRq2oMS1gv6wbXrw2s0K1hH8frHYXHGDTYhtNPXOSZrZ0K8//HXSBE0NwtIgzw
+DiU+WO+gjKAQYTBAfigKmzI/YcyUumfBKvgu0fvZtLSPBJdI4kg5SK+CMEB7PQc
uhf8UC1qk1pGkJJ9zlWvS7m1MfhmWr1SNSB+fpZPRYO4B7+Khm+22tivcG1rZxIb
ymvTkXVYSH+cMozycH92L9Q2/vdpeheMFNtivNsUCkw7dS6ZEG4=
=buy7
-----END PGP SIGNATURE-----

--WplhKdTI2c8ulnbP--


