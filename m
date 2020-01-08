Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FB0C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 17:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A36EF2067D
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 17:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTnQ/PZ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A36EF2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipEpV-0007uN-6N
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 12:09:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53819)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1ipEk3-0001W5-8w
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 12:03:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1ipEk1-0007NT-E2
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 12:03:35 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36151)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ipEk0-0007MQ-Tn
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 12:03:33 -0500
Received: by mail-wm1-x342.google.com with SMTP id p17so3299296wma.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 09:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=lg9PwxG0WHlA67baDX/lcRy6wsfV3A83QjuJ0K6QUsE=;
 b=cTnQ/PZ0Vkerl86IteKB3UoR7eVoct6T4bjCXqWWplxYzy40KnNl0geTi9mrbxMmWm
 km3F+alMFxDSgVghX5VEhlcqSgGDMVBBh9zG4yQAV4K/t2EjdplM/upjNr5iUfO5vg0Q
 q8jRHXh69jWpdmBf1TAwuhcee5EmZclbGI33pH0EpMjhIsfqG2cIE//bHWTIeYE5GVoZ
 OeAAR/rjPVdjWGn/qjgQ7zBd7nKzv49APu2vPsCpx0N4REVoS39+rLu0REfD4N+WUVh0
 wUb5j+4UXFEH3FiLZASJjIy5OZZ35orvLbdvhLOMPkVf/LESpeU2TMl1u5YfJITtFXwX
 cPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lg9PwxG0WHlA67baDX/lcRy6wsfV3A83QjuJ0K6QUsE=;
 b=R6dxgpyMzEVvwjALTuynKASl3cNEx8+rVdWVUIZfYE9uxAp1f78fz1IjpQvbHBq+XV
 EuEZh0LF+7H7fTt9nATMLBH3AFyVY8IOZEFXQwy6JHEULNrQhHoJR1/vURJQQYLByVLA
 3cnSQwYFoOTPjnPuxtAy8Nj2HODimDNccrfzm2XbdpzbkYzO7Ak1EenFN8bLhB36jPqo
 PJrLu/hLVx+ZxTacIHvtQ6p0agN2nA/TU7ONqfGMBPk2LAzqXXk9W4oqyCo4kgpm6GEq
 vumHuqx/MJt+vCerM0sGGRTK5x+EGCrWmWbxrPOfr5Hse2Z2YFyyKLoN5NfbLlYkVGoy
 ziHw==
X-Gm-Message-State: APjAAAX8UyflUibVemD9de4OE/l+ccK7UggGjk9LGZuXakr4+t/aY0I2
 TFyc9FJXSA2UNF/kbVbsRpA=
X-Google-Smtp-Source: APXvYqxR63T/PzTbXK/tsM4A/UNi2QwHHc5uyeobXEUtrzheU0Hp2nZZEhEPJihQPP+M5Zsak225jw==
X-Received: by 2002:a7b:cc6a:: with SMTP id n10mr5295770wmj.170.1578503011727; 
 Wed, 08 Jan 2020 09:03:31 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id u13sm4653477wmd.36.2020.01.08.09.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 09:03:30 -0800 (PST)
Date: Wed, 8 Jan 2020 17:03:29 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Alexander Bulekov <alxndr@bu.edu>
Subject: Re: [PATCH v6 12/21] libqtest: add in-process qtest.c tx/rx handlers
Message-ID: <20200108170329.GD501521@stefanha-x1.localdomain>
References: <20191129213424.6290-1-alxndr@bu.edu>
 <20191129213424.6290-13-alxndr@bu.edu>
 <20200103111518.GG130240@stefanha-x1.localdomain>
 <20200105195544.rysht5cz43fzppwz@mozz.bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Q0rSlbzrZN6k9QnT"
Content-Disposition: inline
In-Reply-To: <20200105195544.rysht5cz43fzppwz@mozz.bu.edu>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "bsd@redhat.com" <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Q0rSlbzrZN6k9QnT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 05, 2020 at 02:55:44PM -0500, Alexander Bulekov wrote:
> On 200103 1115, Stefan Hajnoczi wrote:
> > On Fri, Nov 29, 2019 at 09:34:47PM +0000, Oleinik, Alexander wrote:
> > > +QTestState *qtest_inproc_init(QTestState **s, bool log, const char* =
arch,
> > > +                    void (*send)(void*, const char*))
> > > +{
> > > +    QTestState *qts;
> > > +    qts =3D g_new0(QTestState, 1);
> > > +    *s =3D qts; /* Expose qts early on, since the query endianness r=
elies on it */
> > > +    qts->wstatus =3D 0;
> > > +    for (int i =3D 0; i < MAX_IRQ; i++) {
> > > +        qts->irq_level[i] =3D false;
> > > +    }
> > > +
> > > +    qtest_client_set_rx_handler(qts, qtest_client_inproc_recv_line);
> > > +
> > > +    /* send() may not have a matching protoype, so use a type-safe w=
rapper */
> > > +    qts->ops.external_send =3D send;
> > > +    qtest_client_set_tx_handler(qts, send_wrapper);
> > > +
> > > +    qts->big_endian =3D qtest_query_target_endianness(qts);
> > > +    gchar *bin_path =3D g_strconcat("/qemu-system-", arch, NULL);
> > > +    setenv("QTEST_QEMU_BINARY", bin_path, 0);
> > > +    g_free(bin_path);
> >=20
> > Is this a dummy path that is needed to make other code happy?  Or does
> > the user need to have an actual file at /qemu-system-ARCH?
>=20
> Yes - with the inproc mode this is only needed to make qtest_get_arch
> happy, which simply returns the suffix of the env variable. Standard
> qtest initialization relies on it in qtest_init_without_qmp_handshake,
> but that function is not used by the fuzzer.

Cool, please add a comment to the code.

--Q0rSlbzrZN6k9QnT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4WC2AACgkQnKSrs4Gr
c8htIggApVBjXVTTBHuWXoh4o8wXvsghJYTGQB+fKf/FZSM7PrPgHLDIG8Tjh2WT
1EZXa+IjxI96wQYHdcOZ7KlTAKv2mNyK9dFxL7ZO0tFwuYH5MzRouYdyzug55jbx
N/2aewsYjFrURuA9eN9ibeG1uNTE6ECNOM4dPCou9gmrN9qAPjrFiTUvSX1DQi3N
1O3hXtCBZB+H4JdcGTRmpLFBNX25xa/3ylqsUNFQElPO5vJpI3TEgvPFbHqqn+r1
NPcBcUXyDvu8UsJKQwt4yuHjjZVEQf/STFZkvrFychg73vBt0BINOvWnjhVw27QW
mf3mB6iaaMoQsVlLuMqVAKV8PIYjXg==
=Du+v
-----END PGP SIGNATURE-----

--Q0rSlbzrZN6k9QnT--

