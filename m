Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D76C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:48:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CD40208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfOdJ1af"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CD40208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58fh-0004vR-SF
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:48:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36673)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1j58eh-0003Wy-Im
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:47:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1j58eg-0007Gc-As
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:47:47 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36630)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1j58eg-0007Fl-3W; Fri, 21 Feb 2020 08:47:46 -0500
Received: by mail-wr1-x441.google.com with SMTP id z3so2154608wru.3;
 Fri, 21 Feb 2020 05:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=P9WasghGLWWauHRKa3UlefUSD1zQH2L0lhaHMGy+fSs=;
 b=dfOdJ1afzUOJlnkKSN2AD1yYBjxL/+MgBNrSS01pXxswxZTkQ3hRQNl4emMLlT6rOm
 jf+yQXAa76YxEVvi1BpiKIpkldnAAcNap2w0bwMDcg2DABWjV1OsZHKcTCsZgrOJ5eJm
 OIclEqJjK0/ZvqYZko3gEC1AXQeCx8Q5S5MQ48n/RwU9VJKrgmwRFOEfSi6WaYeLMIuU
 5DXpQpVjW4BpT+9F+Jh+TKCiJfBNn7aVQHAM8H/p3gbF+cCYEV2WzXsceTfve2CJNJsd
 PWGdCYKxvN2QRZjo6lqTOS2PjPPq1y3ZfffolJsm4SDXD71k2cFhn4nk9udzgK66I+yn
 024Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=P9WasghGLWWauHRKa3UlefUSD1zQH2L0lhaHMGy+fSs=;
 b=N9TbwOSHM/FJ3cAWrastKW6uYfyNEhjfFxu8n9KL1td+foLCaur0PU5cvWz5Ffx7zU
 GvrYdf6c/HozNq45WB0J5l/8z58ZPkGfGFKHkREzQXJ0j8p0izCML405G3x4GlGfI09j
 DlDYo4eK4JcE3PhUu199pqEV2MLUbqwkrw5odB0j6cuCUgf63r2aGe8rddCdnyBFsNZK
 6qAlKXs6fSMbqvGzWzHNA5rqO6vz8KbYuhiTHdQ/alV5AAI4eRQVP5R2OEcmzy0i8c+D
 gP4l+092QJ6Zo9oEP1FRWqmXZ5Kvo2u0EZF8ZaNYMZR3CbjMlqwe4RQr09dzdRX5I0a+
 Xg9g==
X-Gm-Message-State: APjAAAW/LuBhj8bmI57HNFo/tTqAd6QkqGpCGp7gMHwLijv4DAG/IS43
 anL+Wmi0P8st8JSpSF71szABhF/benZ8jA==
X-Google-Smtp-Source: APXvYqzh0ec5XRsnwfYRPHrrumxVGe9ghpOO+jS6NZdpHX0/BSgqzsaepfYmgIlL32/LPHbenP7x2Q==
X-Received: by 2002:adf:806c:: with SMTP id 99mr46846747wrk.328.1582292864889; 
 Fri, 21 Feb 2020 05:47:44 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id k7sm3905879wmi.19.2020.02.21.05.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:47:44 -0800 (PST)
Date: Fri, 21 Feb 2020 13:47:42 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] util/async: make bh_aio_poll() O(1)
Message-ID: <20200221134742.GL1484511@stefanha-x1.localdomain>
References: <20200219100045.1074381-1-stefanha@redhat.com>
 <ad80faf5-7e77-739e-36d7-8d88101b9d59@redhat.com>
 <20200219165425.GB1089598@stefanha-x1.localdomain>
 <CABgObfYY+tr3xuoBFF3Q3zn2khrZCSfGK-P63NYJ_phS1vCp5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7vAdt9JsdkkzRPKN"
Content-Disposition: inline
In-Reply-To: <CABgObfYY+tr3xuoBFF3Q3zn2khrZCSfGK-P63NYJ_phS1vCp5w@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--7vAdt9JsdkkzRPKN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2020 at 08:05:12PM +0100, Paolo Bonzini wrote:
> Il mer 19 feb 2020, 18:58 Stefan Hajnoczi <stefanha@redhat.com> ha scritt=
o:
>=20
> > On Wed, Feb 19, 2020 at 12:09:48PM +0100, Paolo Bonzini wrote:
> > > Really a great idea, though I have some remarks on the implementation
> > below.
> > >
> > > On 19/02/20 11:00, Stefan Hajnoczi wrote:
> > > > + * Each aio_bh_poll() call carves off a slice of the BH list.  This
> > way newly
> > > > + * scheduled BHs are not processed until the next aio_bh_poll()
> > call.  This
> > > > + * concept extends to nested aio_bh_poll() calls because slices are
> > chained
> > > > + * together.
> > >
> > > This is the tricky part so I would expand a bit on why it's needed:
> > >
> > > /*
> > >  * Each aio_bh_poll() call carves off a slice of the BH list, so that
> > >  * newly scheduled BHs are not processed until the next aio_bh_poll()
> > >  * call.  All active aio_bh_poll() calls chained their slices together
> > >  * in a list, so that nested aio_bh_poll() calls process all scheduled
> > >  * bottom halves.
> > >  */
> >
> > Thanks, will fix in v2.
> >
> > > > +struct BHListSlice {
> > > > +    QEMUBH *first_bh;
> > > > +    BHListSlice *next;
> > > > +};
> > > > +
> > >
> > > Using QLIST and QSLIST removes the need to create your own lists, sin=
ce
> > > you can use QSLIST_MOVE_ATOMIC and QSLIST_INSERT_HEAD_ATOMIC.  For
> > example:
> > >
> > > struct BHListSlice {
> > >     QSLIST_HEAD(, QEMUBH) first_bh;
> > >     QLIST_ENTRY(BHListSlice) next;
> > > };
> > >
> > > ...
> > >
> > >     QSLIST_HEAD(, QEMUBH) active_bh;
> > >     QLIST_HEAD(, BHListSlice) bh_list;
> >
> > I thought about this but chose the explicit tail pointer approach
> > because it lets aio_compute_timeout() and aio_ctx_check() iterate over
> > both the active BH list and slices in a single for loop :).  But
> > thinking about it more, maybe it can still be done by replacing
> > active_bh with a permanently present first BHListSlice element.
> >
>=20
> Probably not so easy since the idea was to empty the slices list entirely
> via the FIFO order.
>=20
> But since you are rewriting everything anyway, can you add a flag for
> whether there are any non-idle bottom halves anywhere in the list? It need
> not be computed perfectly, because any non-idle bh will cause the idle
> bottom halves to be triggered as well; you can just set in qemu_bh_schedu=
le
> and clear it at the end of aio_bh_poll.
>=20
> Then if there is any active bh or slice you consult the flag and use it to
> return the timeout, which will be either 0 or 10ms depending on the flag.
> That's truly O(1). (More precisely, this patch goes from O(#created-bh) to
> O(#scheduled-bh), which of course is optimal for aio_bh_poll but not for
> aio_compute_timeout; making timeout computation O(1) can lower latency a
> bit by decreasing the constant factor).

Yes, good idea.  I'll send a follow-up patch.

Stefan

--7vAdt9JsdkkzRPKN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5P334ACgkQnKSrs4Gr
c8jCqwgAwEVTogXmSzT58uy/oMxaKjJyMBm18dCHRr2GNtt1T7oTf9BuK9lmolHk
TKYBAy46YwB0Bk3FA13t1v3cZqR3RGhq98tCtCm1jig6Ak5enYlqhNlUQTBKj841
FVe4CKcHCuALCQI87dUw/ZXmyc56JrU9c9veycwSjEQ7t20+Loc64mq9oJXqZU/I
QtGYlGVHKefW2Np0qIy2A6LI7iScbisrhir8AAdSCU1yb65JnDTeX+EkzF5qft8T
CsKoDsBwoSYdOwl4VVpGQxuI7LM/xp7zlbiGvLPhPDQNOdu/kSQhbGG/IGlAT28I
PHDPFhDZVabtb7nCUp1upAFzEgMQDA==
=yiaI
-----END PGP SIGNATURE-----

--7vAdt9JsdkkzRPKN--

