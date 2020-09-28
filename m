Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0ECC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:07:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3372F21D7F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WF8FCAil"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3372F21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMp7h-000189-0n
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 05:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kMp65-0008Rz-Al
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 05:05:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60011)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kMp62-000173-NA
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 05:05:24 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601283920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E+qPHymmZZgak8j6DknFIgLQvvcB1g1s01Pzx3xn78c=;
 b=WF8FCAilb44Q2pZUxN0KHkJ53CeQ2qD7Jw9ejMX/FkZT2upsCggo/3dSpbYRZZvDZlfdGi
 lS7QWl185kjdpAv+zWLPTpFs0F0gwD5z64JSbnf2oNFlUJybcYa2Ox9DT7FxvU10fFBiuu
 KAXki2Y0PZMmy/dZ1nFyay5yXsA/oD0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-IWRxUbjYMim9GrotE4T_Gg-1; Mon, 28 Sep 2020 05:05:17 -0400
X-MC-Unique: IWRxUbjYMim9GrotE4T_Gg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2437064080;
 Mon, 28 Sep 2020 09:05:16 +0000 (UTC)
Received: from localhost (ovpn-114-195.ams2.redhat.com [10.36.114.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9FB2C27BDD;
 Mon, 28 Sep 2020 09:05:15 +0000 (UTC)
Date: Mon, 28 Sep 2020 10:05:14 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v7 13/13] block: Convert 'block_resize' to coroutine
Message-ID: <20200928090514.GE43571@stefanha-x1.localdomain>
References: <20200909151149.490589-1-kwolf@redhat.com>
 <20200909151149.490589-14-kwolf@redhat.com>
 <20200915145733.GF629589@stefanha-x1.localdomain>
 <20200925160750.GJ5731@linux.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20200925160750.GJ5731@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jKBxcB1XkHIR0Eqt"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:47:08
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

--jKBxcB1XkHIR0Eqt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2020 at 06:07:50PM +0200, Kevin Wolf wrote:
> Am 15.09.2020 um 16:57 hat Stefan Hajnoczi geschrieben:
> > On Wed, Sep 09, 2020 at 05:11:49PM +0200, Kevin Wolf wrote:
> > > @@ -2456,8 +2456,7 @@ void qmp_block_resize(bool has_device, const ch=
ar *device,
> > >          return;
> > >      }
> > > =20
> > > -    aio_context =3D bdrv_get_aio_context(bs);
> > > -    aio_context_acquire(aio_context);
> > > +    old_ctx =3D bdrv_co_move_to_aio_context(bs);
> > > =20
> > >      if (size < 0) {
> > >          error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "size", "a >0=
 size");
> >=20
> > Is it safe to call blk_new() outside the BQL since it mutates global st=
ate?
> >=20
> > In other words, could another thread race with us?
>=20
> Hm, probably not.
>=20
> Would it be safer to have the bdrv_co_move_to_aio_context() call only
> immediately before the drain?

Yes, sounds good.

> > > @@ -2479,8 +2478,8 @@ void qmp_block_resize(bool has_device, const ch=
ar *device,
> > >      bdrv_drained_end(bs);
> > > =20
> > >  out:
> > > +    aio_co_reschedule_self(old_ctx);
> > >      blk_unref(blk);
> > > -    aio_context_release(aio_context);
> >=20
> > The following precondition is violated by the blk_unref -> bdrv_drain -=
>
> > AIO_WAIT_WHILE() call if blk->refcnt is 1 here:
> >=20
> >  * The caller's thread must be the IOThread that owns @ctx or the main =
loop
> >  * thread (with @ctx acquired exactly once).
> >=20
> > blk_unref() is called from the main loop thread without having acquired
> > blk's AioContext.
> >=20
> > Normally blk->refcnt will be > 1 so bdrv_drain() won't be called, but
> > I'm not sure if that can be guaranteed.
> >=20
> > The following seems safer although it's uglier:
> >=20
> >   aio_context =3D bdrv_get_aio_context(bs);
> >   aio_context_acquire(aio_context);
> >   blk_unref(blk);
> >   aio_context_release(aio_context);
>=20
> May we actually acquire aio_context if blk is in the main thread? I
> think we must only do this if it's in a different iothread because we'd
> end up with a recursive lock and drain would hang.

Right :). Maybe an aio_context_acquire_once() API would help.

Stefan

--jKBxcB1XkHIR0Eqt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9xp0oACgkQnKSrs4Gr
c8jswggAgh6+YUld//Dtk1c5XMd2IQ/W0QkOBEzD9WNkhJzLJCv8DDnykmQhK7BY
uD3vWsVpIFUe8mjI3QdfCytj+RkLmYRJLK3lV4swQJrYxRtSNZy8r6NG61CYPQn4
OnZYMA0351uXfx0lg/MDEViJ65rbbREvFZutII+pcZ96xsMrfbRZ/paalkkM/fiu
x/6WCmqZh24xMQ8Y46IcqxE7A8VXQXC7BlvTe1/+xuiEbWg4yQ9RK7efg6qQCk/E
scTZio6nJUnCeUwyk8EuA3RJlWS8+BWhBVA7WpZ/L77d9flpzPetU4jcH0G/LdDe
njqYnY9e+HLTa2KYXBDwOoERVX6EOQ==
=ogav
-----END PGP SIGNATURE-----

--jKBxcB1XkHIR0Eqt--


