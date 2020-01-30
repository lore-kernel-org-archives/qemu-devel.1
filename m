Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABD2C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 14:43:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85530206D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 14:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HlB0jgQr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85530206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixB2W-0001nU-Nu
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 09:43:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40077)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ixB1i-0001Nh-Ta
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:42:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ixB1h-0007zG-WD
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:42:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25178
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ixB1g-0007vP-LM
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:42:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580395355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8vA4bOqP2MerbeI1vDgcmWmNJzP9TnYr+Z3bzipkZfE=;
 b=HlB0jgQreccDoW43f7mKL5AtCw/c6zTRHPbWU8kkvYZWBmCCG8EbrjQHo/e8AdPQUH+DDC
 gu8DOrrU46HgOBa42radNrAOmF6zSMlfDW+yDcMr5Mg1ASE44BTtGtn89LGE4W4s5F4nyv
 zwR7RpwI7uvUMRj8rPWUanJHM+Az2wQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-ZjxSY-lmN-WC_XomHbqz8g-1; Thu, 30 Jan 2020 09:42:32 -0500
X-MC-Unique: ZjxSY-lmN-WC_XomHbqz8g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 688198010EA;
 Thu, 30 Jan 2020 14:42:29 +0000 (UTC)
Received: from localhost (unknown [10.36.118.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 86F121001B23;
 Thu, 30 Jan 2020 14:42:25 +0000 (UTC)
Date: Thu, 30 Jan 2020 14:42:24 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Bulekov, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v8 13/21] main: keep rcu_atfork callback enabled for qtest
Message-ID: <20200130144224.GC180311@stefanha-x1.localdomain>
References: <20200129053357.27454-1-alxndr@bu.edu>
 <20200129053357.27454-14-alxndr@bu.edu>
MIME-Version: 1.0
In-Reply-To: <20200129053357.27454-14-alxndr@bu.edu>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4ZLFUWh1odzi/v6L"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2020 at 05:34:22AM +0000, Bulekov, Alexander wrote:
> The qtest-based fuzzer makes use of forking to reset-state between
> tests. Keep the callback enabled, so the call_rcu thread gets created
> within the child process.
>=20
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  vl.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/vl.c b/vl.c
> index bb77935f04..cf8e2d3ebb 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3794,7 +3794,14 @@ void qemu_init(int argc, char **argv, char **envp)
>      set_memory_options(&ram_slots, &maxram_size, machine_class);
> =20
>      os_daemonize();
> -    rcu_disable_atfork();
> +
> +    /*
> +     * If QTest is enabled, keep the rcu_atfork enabled, since system pr=
ocesses
> +     * may be forked testing purposes (e.g. fork-server based fuzzing)
> +     */
> +    if (!qtest_enabled()) {
> +        rcu_disable_atfork();
> +    }

I haven't reviewed the details of whether resources are leaked across
fork but in general it makes sense that we want an RCU thread in the
fork child:

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

--4ZLFUWh1odzi/v6L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4y61AACgkQnKSrs4Gr
c8hP8AgAglIAV16dtYR5qwiMDkHv83oLFj1QjGV4Vxye+dS7FgHu5/wIMVNCqfk+
RcCTZc35qafTuGa3tTo7Z7iuikoQyWiZD4ybDEz39BQ9xeowq0xEROGiJvwx/Py/
XItlFQDN9e8ucxRUA7kaQ1Kb607PQpOnEVNofdcvlmzIZgrbtOFpkyBaBmVeIuuz
ApfvjPq1+eoaSxuZ77My+x69O9XLCZ2o8r/7p6jYXkbftwTNdgTyBEnfV7T3Jl93
SaOOdVRs0EQu/a9iBqPmaGqtGAIH/ZK3beEs8o6FuF4O6RsX+9dDJ/SniA7J0pKg
Lp+PsQgl5t2O6/JQS11qtrMrQz475A==
=9Pyo
-----END PGP SIGNATURE-----

--4ZLFUWh1odzi/v6L--


