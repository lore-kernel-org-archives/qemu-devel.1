Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B7BC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:46:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BD8A20706
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i0NsNSoY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BD8A20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joqYO-0007DQ-9V
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1joqX7-0005hD-M4
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:44:53 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36191
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1joqX5-0005R6-Uv
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593186290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ApeWwpVLFNQe8Iic/qyyIhLUyYMG+sllIleIM1iPLQw=;
 b=i0NsNSoY0Qmq6Pa4DKa5cD47BCpu37sobc5ZJTD2LtbLxOZb2+j8HW3YOE3G+hwu5X23qM
 VNfwT/aWd7mhhC/DlgwWgmyf9h4bBs2ThAbqbSDE3eAz0LUYnVVXP96TDFoSy4uSwue632
 HslafrpW+En7DR3YYvvTGJWg7hIa/HA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-FMoU3uCpN8uDOeFBUo2Ghw-1; Fri, 26 Jun 2020 11:44:47 -0400
X-MC-Unique: FMoU3uCpN8uDOeFBUo2Ghw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72B10100A624;
 Fri, 26 Jun 2020 15:44:46 +0000 (UTC)
Received: from localhost (ovpn-114-181.ams2.redhat.com [10.36.114.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3940660CD1;
 Fri, 26 Jun 2020 15:44:42 +0000 (UTC)
Date: Fri, 26 Jun 2020 16:44:41 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alexander Bulekov <alxndr@bu.edu>
Subject: Re: [RFC PATCH 3/3] fuzz: Add callbacks for dma-access functions
Message-ID: <20200626154441.GB316372@stefanha-x1.localdomain>
References: <20200611055651.13784-1-alxndr@bu.edu>
 <20200611055651.13784-4-alxndr@bu.edu>
 <20200623141456.GK36568@stefanha-x1.localdomain>
 <20200623145500.jtdb5skwj5htgfcz@mozz.bu.edu>
MIME-Version: 1.0
In-Reply-To: <20200623145500.jtdb5skwj5htgfcz@mozz.bu.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 02:19:36
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 f4bug@amsat.org, darren.kenny@oracle.com, bsd@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2020 at 10:55:00AM -0400, Alexander Bulekov wrote:
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
> > Now the compiler should eliminate the deadcode:
> >=20
> >   #ifdef CONFIG_FUZZ
> >   if (as->root =3D=3D get_system_memory()) {
> >       dma_read_cb(addr, len);
> >   }
> >   #endif
> >=20
> > becomes:
> >=20
> >   if (as->root =3D=3D get_system_memory()) {
> >       fuzz_dma_read_cb(addr, len);
> >   }
> >=20
> > Hopefully gcc and clang will eliminate this and emit no instructions
> > when CONFIG_FUZZ is undefined. If not, you can simply pass in 'as' and
> > 'is_write' too:
> >=20
> >   void fuzz_dma_read_cb(AddressSpace *as, bool is_write, size_t addr, s=
ize_t len)
> >=20
> > This way the conditional is moved inside fuzz_dma_read_cb() and deadcod=
e
> > elimination becomes trivial for the compiler:
> >=20
> >   fuzz_read_cb(as, is_write, addr, len);
>=20
> Do you think it would be better to have a "trace_dma_read" or
> "trace_device_read_from_guest_memory"? I haven't looked under the hood
> too much for the tracepoint api, but these would just be standard
> tracepoints(disabled for the majority of builds). When we build the
> fuzzer, we could compile with --wrap=3D"trace_dma_read" and implement
> a __wrap_trace_dma_read in the generic fuzzer. I looked at the symbols
> for a qemu build and it looks like trace_* are actual functions, rather
> than preprocessor magic, so maybe this could work?

I think plain old functions are fine for what you are doing.

QEMU's tracing does not provide callbacks that are invoked when a trace
event is emitted. The fuzzing code wouldn't be able to hook
trace_device_read_from_guest_memory, you could only analyze a trace
after the fact.

Stefan

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl72F+kACgkQnKSrs4Gr
c8jXmQf/VyMnAsIWlN7URKEJuILuHA6ZVPnHahzSM7ZFOw3dDDfc7CYYDrjkh8+2
1UpXMRMlzKa8wS9HgaNJQi3MpHmMmzRPiV+RAogyTiLL0jph0/eVHt4cGORIUq2+
/wmWGx9QcQkcBGbEE4eaKaWH9oj3uqCUf0OjAe4JIh6sjLC2Ib1DYB3/wlhzQ9FB
iUzdL2mDrRXms9r6iTlDlr/TnvHQFUFStASxiqARg+xrZ2+HhyJGHPgyncq6dZUJ
lRVOALtFdBHTHxCuoKV099eUtXH5PZPskfV0v7sVgBjpNTjZGser7dVhZNC8nKcE
ztxdETCIpfiD0Hyn6ADeE/gAYZRPmA==
=48ik
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--


