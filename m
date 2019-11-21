Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8836C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 13:52:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7397920679
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 13:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IykNunYb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7397920679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXmsp-0003DP-4H
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 08:52:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34023)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iXmrb-0001t0-F7
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:51:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iXmra-0003DR-0t
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:51:15 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:56000)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iXmrZ-0003Bn-QD
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:51:13 -0500
Received: by mail-wm1-x343.google.com with SMTP id b11so3780173wmb.5
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 05:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=KaerfimaGLiAfJXhZnCR1Lc2dMjYR45xPb2iWPC4faE=;
 b=IykNunYbUUg/02YQDZiviDqdmEO5B3RicRcWm7XRnRXWY9dxNnFtDx1MFzNwRI5v7t
 gCjhMlzsffFJtI89z/D2kM9Xj5ho0tQMysK91432zYt2B4GO6sm/JV/45CA/ur6LBd+c
 LLo7hYB25uOFAUJ1oNldFMIL5c8wiUOqb8LkNRJ4WDn0Zcmwb6sy8LHR27HSu9guVCJ7
 gMXtCrDVeuj5tY5L4Drf2JH56rMg5a057NsdbfO5PmrWyh+mgT+MjLq+l8rBF50vFOUa
 w8olUluDcRU9aUEHu3KU1YhP00cXU9ogK9fUZVh7S33Mh4/8eitnCaYbSbNOgP2EBSbg
 TdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=KaerfimaGLiAfJXhZnCR1Lc2dMjYR45xPb2iWPC4faE=;
 b=SP1AixIgI3aAx4ZaS9j6Ix/ZaToW0PEuC0s7jb61YvOJqI1rTOWTWs1GHwGi0pt4k4
 UAOfTfvAkoaZcZeOinXud4gorgk25gsnYS79WVmjXwOdQU0y4LCmTya9JLGNL8K9WrkU
 ERk+vjHksrJe0jcvN0gJvl8e5RU7NEc37txFaXbRF/Cy9nMvh4MKzY4Qr2tmIAthf5hF
 tnCpKX0B+FWOqbKjzBo47prAwFNYfxbRe17E2WiqLR+gLUkDgwgNdWgC79m1W8zu+8N+
 c9l48Pbfnf/DKEZ4s6mx2Lp2eDILIuyTL+zADrCJ8tNNFCXDF6MoHFiecPIu+rSCeldh
 RScg==
X-Gm-Message-State: APjAAAXadm+87qWteSb38jrMDiyvKoHmWtBw5jNMonFNgmgCJM67kQPB
 Ux873G6c+GVM5wMsN5MGIls=
X-Google-Smtp-Source: APXvYqynesBaN8v5Y403+D1Hu+lBrEbr9NINY2qZXJ2cxYotNJ82pYKz3eA3wQkVcufMu/Z3bRMEBA==
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr10296891wmj.84.1574344272142; 
 Thu, 21 Nov 2019 05:51:12 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id c15sm3633656wrx.78.2019.11.21.05.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2019 05:51:10 -0800 (PST)
Date: Thu, 21 Nov 2019 13:51:09 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH] vhost-user-input: use free(elem) instead of g_free(elem)
Message-ID: <20191121135109.GW439743@stefanha-x1.localdomain>
References: <20191119111626.112206-1-stefanha@redhat.com>
 <20191120114856.GG2785116@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HACzHn9G0kmbdSJa"
Content-Disposition: inline
In-Reply-To: <20191120114856.GG2785116@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--HACzHn9G0kmbdSJa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2019 at 11:48:56AM +0000, Daniel P. Berrang=E9 wrote:
> On Tue, Nov 19, 2019 at 11:16:26AM +0000, Stefan Hajnoczi wrote:
> > The virtqueue element returned by vu_queue_pop() is allocated using
> > malloc(3) by virtqueue_alloc_element().  Use the matching free(3)
> > function instead of glib's g_free().
>=20
> Just as an FYI, since glib 2.46  g_malloc is hardcoded to use the
> system allocator, so it is now guaranteed that g_malloc/malloc
> and g_free/free are safely interchangable. I recently got this
> clarified in the glib docs:
>=20
>   https://gitlab.gnome.org/GNOME/glib/merge_requests/1099//diffs
>=20
> QEMU mandates 2.48 so we are now safe in that regard
>=20
> For readability/sanity sake I'd still suggest matching functions
> but it is not a functional danger any more. Even when it was a
> risk, that risk only arose if you called GLib's API for installing
> a custom allocator callback which QEMU never did, so it was always
> a non-issue.

You are right, although QEMU did use g_mem_set_vtable().  The custom
functions still used malloc() underneath though so it would be safe
anyway:

  commit 98cf48f60aa4999f5b2808569a193a401a390e6a
  Author: Paolo Bonzini <pbonzini@redhat.com>
  Date:   Wed Sep 16 17:38:44 2015 +0200

      trace: remove malloc tracing

--HACzHn9G0kmbdSJa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3Wlk0ACgkQnKSrs4Gr
c8jruAf+IuZwBb3rykhFL8wlFVdMbgMyksJXqQ+nGdRPjePaFMb2P/j2iSzEO5DR
1Mc68R8g/Xqj/36SDE57hQyaaXAmEnrfsSeze+97SdrNBiUhnpKIS5X597XWEX0h
ZYe2XIbPipKdAZ+DCRJlGiRV2vDQJBq6aUMPuiedVfURr0V70fuYHthS9+8gUmry
ng/vHpPyyaGTdRRmfj4tHaXNQX9uv7kIGPqxRLxdCpq2gTAmwcwNnrE2ya6tj12r
UJhSRjb4UC/gNPqEmkHyWOJKWsUimqpEjOAyhBs1D6Kyg3UIy8oq1mrCF0zcHypb
OFHS3RbnkZRbrP7g5QKupLqY5f9gFA==
=DOro
-----END PGP SIGNATURE-----

--HACzHn9G0kmbdSJa--

