Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEE8C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 11:42:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B43E220738
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 11:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJwqx8lx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43E220738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juwqp-0005TS-Uu
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 07:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1juwpo-0003t6-4O
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 07:41:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41484
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1juwpl-0002cg-Jk
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 07:41:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594640480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q/tk5a2ScHOofryUGKJmm8jcBEdnko7wv9/JUCwf7ck=;
 b=dJwqx8lxlBu+YsAOB2eZw9UnM/8ltd/aRb/vyKILbqOh4iVdRbUdogQTDEm+JS83ZZu1aj
 LVaEEbzGxeTPFldt21B+7VcmVXTZFMfH8cS8Ts+xJPimG7eLnHHwsIdOuSJcGZL1LjbKqM
 4/O+nwqlZLQlVPbzpptEX36YRu7iq6I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-1HV5hjMKMcu60VbrUt7YvA-1; Mon, 13 Jul 2020 07:41:17 -0400
X-MC-Unique: 1HV5hjMKMcu60VbrUt7YvA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B42C31087;
 Mon, 13 Jul 2020 11:41:15 +0000 (UTC)
Received: from localhost (ovpn-114-66.ams2.redhat.com [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D15402DE6D;
 Mon, 13 Jul 2020 11:41:11 +0000 (UTC)
Date: Mon, 13 Jul 2020 12:41:10 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alexander Bulekov <alxndr@bu.edu>
Subject: Re: [RFC PATCH 3/3] fuzz: Add callbacks for dma-access functions
Message-ID: <20200713114110.GK28639@stefanha-x1.localdomain>
References: <20200611055651.13784-1-alxndr@bu.edu>
 <20200611055651.13784-4-alxndr@bu.edu>
 <20200623141456.GK36568@stefanha-x1.localdomain>
 <20200709234855.lpto2yc5fanzgzjs@mozz.bu.edu>
MIME-Version: 1.0
In-Reply-To: <20200709234855.lpto2yc5fanzgzjs@mozz.bu.edu>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hl1kWnBARzJiTscN"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 03:20:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 f4bug@amsat.org, darren.kenny@oracle.com, bsd@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--hl1kWnBARzJiTscN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 09, 2020 at 07:48:55PM -0400, Alexander Bulekov wrote:
> On 200623 1514, Stefan Hajnoczi wrote:
> > On Thu, Jun 11, 2020 at 01:56:51AM -0400, Alexander Bulekov wrote:
> > > Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> > > ---
> > >  exec.c                                | 17 ++++++++++++++++-
> > >  include/exec/memory.h                 |  8 ++++++++
> > >  include/exec/memory_ldst_cached.inc.h |  9 +++++++++
> > >  include/sysemu/dma.h                  |  5 ++++-
> > >  memory_ldst.inc.c                     | 12 ++++++++++++
> > >  5 files changed, 49 insertions(+), 2 deletions(-)
> >=20
> > Please rename dma_read_cb() to fuzz_dma_read_cb() so the purpose of the
> > function is clear.
> >=20
> > The ifdefs can be avoided by defining an empty function when CONFIG_FUZ=
Z
> > is undefined. In a header file:
> >=20
> >   #ifdef CONFIG_FUZZ
> >   void fuzz_dma_read_cb(size_t addr, size_t len);
> >   #else
> >   static inline void fuzz_dma_read_cb(size_t addr, size_t len)
> >   {
> >       /* Do nothing */
> >   }
> >   #endif
> >=20
>=20
> If I understand correctly, this still has the problem that normal
> qemu-system builds under --enable-fuzzing are broken. I'm not sure if
> there is some nice solution for this. For example, a sort-of ugly
> solution could add this to softmmu/main.c (ie something that is linked
> for the qemu-system build, but not for qemu-fuzz).
>=20
> #ifdef CONFIG_FUZZ
> #include "something.h"
> static void fuzz_dma_read_cb(size_t addr, size_t len)
> {
>     /* Do nothing */
> }
> #endif

Another ugly solution is using weak symbols in the main code and a
strong symbol in the fuzzer target:
https://en.wikipedia.org/wiki/Weak_symbol

Stefan

--hl1kWnBARzJiTscN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8MSFYACgkQnKSrs4Gr
c8i2Mwf6A9dHyzBUCro92L1+y138JhpRCrlMlAhUAP1uCMPaKQMZ/vvimbO2xszB
8BX0xdHyAxiFpcVfc0BaoYgtrWnfRVhxMqjhIh5DE08Sqm8LDLfRnqLipw5sWZlF
9ZWSP4SGr9ImlWgYYv1wnbTJE3w2LjHENhqNKUwl3glyedKwz9LX/EZcTR+vvdTS
Q8OHfZOfYYpiz2G6QvcJ4kgTwukdpiazWEmpSnH1JG22Ir5IpOgvpFpVIjsa3E1w
I0bAAeJO9p3TgtGikXSwQhF0oXm6Pja3ejZ0fc5Vgeqy64VHjc+R7FlKWtiPQi1g
7KOk/DPC4CqfY3RjnX08TgSbvi+8bg==
=Fo4O
-----END PGP SIGNATURE-----

--hl1kWnBARzJiTscN--


