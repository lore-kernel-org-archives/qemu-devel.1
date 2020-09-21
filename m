Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB19C43465
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 16:50:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67AB82076E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 16:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ds/GMd5w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67AB82076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKP1J-0004Ir-9M
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 12:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kKP0K-0003cp-Ls
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 12:49:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45433)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kKP0I-00029U-FN
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 12:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600706963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uJlutJ2mv4LYv1X7KoEq0Owjc5xF611pMaUPvl0EUNw=;
 b=ds/GMd5waQHQOw7elHFk1JFeQXsPWW4r9AorFgNTeLW1m7Uc9hrZXBQ9fTKGtufRRFyaUR
 FGvbGyAKCp1QmI7gkbgd/EvNRlTuF69RjCBHh5/HhOtXCHoqXL33xQnqM4+KIuNFygwFgC
 ml8Fo0jZQMz3oLP0u3kuMbwUT90A0R8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-F9hgecmYNHmwkDxxDWCEWQ-1; Mon, 21 Sep 2020 12:49:19 -0400
X-MC-Unique: F9hgecmYNHmwkDxxDWCEWQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 434246409F;
 Mon, 21 Sep 2020 16:49:18 +0000 (UTC)
Received: from localhost (ovpn-112-39.ams2.redhat.com [10.36.112.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D8ADD55769;
 Mon, 21 Sep 2020 16:49:17 +0000 (UTC)
Date: Mon, 21 Sep 2020 17:49:16 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC] Move to C11 Atomics
Message-ID: <20200921164916.GA189659@stefanha-x1.localdomain>
References: <20200921104107.134323-1-stefanha@redhat.com>
 <b32450b7-13e4-9968-cd99-fe8210040d3b@redhat.com>
 <20200921134423.GA156064@stefanha-x1.localdomain>
 <439bbea5-60d7-aa9c-e693-3a3b1143154c@redhat.com>
MIME-Version: 1.0
In-Reply-To: <439bbea5-60d7-aa9c-e693-3a3b1143154c@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:44:53
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

--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2020 at 04:16:07PM +0200, Paolo Bonzini wrote:
> On 21/09/20 15:44, Stefan Hajnoczi wrote:
> > On Mon, Sep 21, 2020 at 01:15:30PM +0200, Paolo Bonzini wrote:
> >> On 21/09/20 12:41, Stefan Hajnoczi wrote:
> > They don't provide atomic arithmetic/logic operations. The only
> > non-seq-cst ALU operation I see in atomic.h is
> > atomic_fetch_inc_nonzero(), and it's a cmpxchg() loop (ugly compared to
> > an atomic ALU instruction).
>=20
> Seq-cst is fine for RMW operations (arithmetic/logic, xchg, cmpxchg),
> also because they're usually less performance critical than loads and
> stores.  It's only loads and stores that give a false sense of
> correctness as in the above commit.

Okay. I've sent a patch to simply prefix atomic.h atomic_*() functions
with qemu_. That way they don't conflict with <stdatomic.h>.

Stefan

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9o2YwACgkQnKSrs4Gr
c8iPAgf+KnbXRJ/H0LiQCrquEWKju2zkppf0/q+Tib0V0NTXkEO578WRQYpOrDAr
80aFmWuA+zemLkCVM36rW0kdbQAh/BaG480FdbQZshGNeqFwmprM446WzGfViFHp
ix7nAQIeJawhkayyIfYE0WvTD30Gfk4ibk7JtOPPf+Mp/SV7yaEV6ls506JDa8Pe
s4uQq7XXviUa3SjRcc8oYUQnkH+t/3MNMy6Vor5w4SiYAVWnOt7aCpSJngHJ2FvV
/fZ5fc3wOWGzPrLdLs27Q416vDHM3XYOL1VxnLDhYrXeYD9sV5e1Rbcqe9XDM+rU
0uvMabxjxh7WyD40U6hYEhTw3/pxVA==
=vUjB
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--


