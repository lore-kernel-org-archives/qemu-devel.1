Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7D3C4346D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 13:46:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6903220888
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 13:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OSnqj9nR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6903220888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKM9S-0002F7-Dp
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 09:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kKM7R-00019i-Pi
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 09:44:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34846)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kKM7N-00052S-QC
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 09:44:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600695872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KnLSNWCj8sjfCzBPIMr1zWc/9cYHSOtQOc/EPfUv0O0=;
 b=OSnqj9nRMqucTjUH7Lw0/YvHblfFHVzrpYgrHnXLu7bWwVA4Ch0yH3wr0AEVLh68Ioye0s
 hy0YIHr9wYhePcZmpnuaphPtdI8qA3S59yvHD3K6plin4xQfO7Ee6MprtfEjmlogsFeeQo
 S2BbmuI4fB5hkXB3YxfFWCW5+ohY4k4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-aUyEqxGaMs-AJTUe1UYmBQ-1; Mon, 21 Sep 2020 09:44:26 -0400
X-MC-Unique: aUyEqxGaMs-AJTUe1UYmBQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1CCA18B9EC1;
 Mon, 21 Sep 2020 13:44:24 +0000 (UTC)
Received: from localhost (ovpn-112-39.ams2.redhat.com [10.36.112.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 82E6A5577D;
 Mon, 21 Sep 2020 13:44:24 +0000 (UTC)
Date: Mon, 21 Sep 2020 14:44:23 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC] Move to C11 Atomics
Message-ID: <20200921134423.GA156064@stefanha-x1.localdomain>
References: <20200921104107.134323-1-stefanha@redhat.com>
 <b32450b7-13e4-9968-cd99-fe8210040d3b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <b32450b7-13e4-9968-cd99-fe8210040d3b@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:43:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Daniel Berrange <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2020 at 01:15:30PM +0200, Paolo Bonzini wrote:
> On 21/09/20 12:41, Stefan Hajnoczi wrote:
> > The upshot is that all atomic variables in QEMU need to use C11 Atomic
> > atomic_* types. This is a big change!
>=20
> The main issue with this is that C11 atomic types do too much magic,
> including defaulting to seq-cst operations for loads and stores. As
> documented in docs/devel/atomics.rst, seq-cst loads and stores are
> almost never what you want (they're only a little below volatile :)):

I can't find where atomics.rst says seq-cst operations are almost never
what you want?

I'm surprised that this isn't documented more prominently. Seq-cst
operations are the first type of atomic operation documented. It would
help to move them to the end of the document if they shouldn't be used.

> 1) in almost all cases where we do message passing between threads, we
> can use store-release/load-acquire

They don't provide atomic arithmetic/logic operations. The only
non-seq-cst ALU operation I see in atomic.h is
atomic_fetch_inc_nonzero(), and it's a cmpxchg() loop (ugly compared to
an atomic ALU instruction).

> 2) when we want a full memory barrier, it's usually better to write the
> whole construct by hand, to avoid issues like the ones we had with
> ->notify_me.
>=20
> In addition, atomics are complicated enough that you almost always want
> a sign that you are using them, even at the cost of heavier-looking
> code.  For example "atomic_read" straight ahead tells you "this is
> complicated but somebody has thought about it", while a naked access to
> a global variable or a struct field tells you "check which mutex is held
> when this function is called".  By allowing shortcuts for seq-cst loads
> and stores, C11 atomics fool you into thinking that seq-cst accesses are
> all you need, while in reality they create more problems than they solve.=
 :(

Good point. But it's easy to error out on 'atomic_fetch_add()' and
insist on 'atomic_fetch_add_explicit()' (where the user specifies the
memory order) in checkpatch.pl.

atomic_load_explicit()/atomic_store_explicit() can be used instead of
bare variable accesses. Although here I don't know how to enforce that
except via typedef struct { atomic_int i; } AtomicInt.

Thanks for suggesting the namespace cleanup I'll give that a try.

> > 1. Reimplement everything in terms of atomic_fetch_*() and other C11
> >    Atomic APIs. For example atomic_fetch_inc() becomes
> >    atomic_fetch_add(ptr, 1).
> >=20
> > 2. atomic_*_fetch() is not available in C11 Atomics so emulate it by
> >    performing the operation twice (once atomic, then again non-atomic
> >    using the fetched old atomic value). Yuck!
>=20
> They're hidden in plain sight if you are okay with seq-cst operations
> (which we almost always are for RMW operations, unlike loads and
> stores): "x +=3D 3" is an atomic_add_fetch(&x, 3).  However, they share
> with loads and stores the problem of being too magic; if you see "x +=3D
> 3" you don't think of it as something that's thread safe.

Ah, I see!

Stefan

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9orjcACgkQnKSrs4Gr
c8h97wf+M2tJbmRfdYlTuIdqlXydjEDTmxvS094gJ4Q3wIaH/zYpbyzgH3c8UK3t
cKIJPGHzuveEiya6E6r3+cHPt1k/6SIrSTAdSyV1ylhVBu6JYNmixbYv77vVkBBK
WCZQfMejDr36bMqqqyEoHtJy3qGjnrrghKa4l4BZ4jLH7stR3mtY0PNW5d/qvR2H
R14TUHowXPAbAMCUNcT08CD3W/5kKv34sTDTYL8uBg4eiFamq45VKZSxLkgMG48B
2shL3K7CiwOckQSfvKEWMw9XzcjWjpR+qDirtoMWSH8xyVIdh41/FrOxb8qppZbn
UFcBfbGgoyDJhXgC7boq+EdfHSNTSA==
=2Kna
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--


