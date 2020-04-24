Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB03C2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 10:51:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECDB920776
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 10:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqkIpCMw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECDB920776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRvw2-0007Hi-05
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 06:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jRvuv-0006iE-HD
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 06:50:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jRvur-0000QK-Ng
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 06:50:45 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33653)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jRvur-0000Mv-9w
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 06:50:41 -0400
Received: by mail-wm1-x344.google.com with SMTP id v8so9696601wma.0
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2020 03:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=S4xBylA9oq753w7Z75CYrLZ5MHiyjHcGivxYn9X+LLU=;
 b=hqkIpCMwN4+4ETO4tQv00fAMkTRcjjsYgcnnAGhVryv1nYMLcVddYeGeN4O4dr3T3n
 rtx1lCMkxzztXYAuPsDxXWQJG1pWBOyddqpfiR7DXVi3yb6r2oKPah1X1VObjXJ/MrA+
 7y7siQ5jJUmkb6m7BN6Jc/HpvjkntVYP3eDeDMmHUXwzzHhjkQTuBpuUX0rRF/EVosoA
 SQAhSfEcI0wNffL839emAnLD+Y83+MpLHicMuEC7cV7HtePfC0S3YTfoP8ulcxQYAaro
 rSoSVpDPKrOM41yexjbtwbGqv+crsKuU0SJpH3uuMFqoFuGX/1wm3mRhufvPAUPrJz1r
 c2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=S4xBylA9oq753w7Z75CYrLZ5MHiyjHcGivxYn9X+LLU=;
 b=DtrdFQU45IHmM6pq3F4IuEk6jqSkXDhGAIFeVOlixQAyXV6Hpy5CM2KlNK7oRwcgL1
 wRuERygaHeVKMR9BKDSeP1WPOUMRBZzFbnOiCgqyf5l3KjOSjxID53si/H0bBO71XWZf
 l1J4PQEI1AnNdbzN62F9sH1Az3/GMuU3sIHUB1jvf934CKMEk8jad7/0M1CooXjYiH1z
 wrUEIrZc19A08Hxlo/DEZ+awc7oFt1AI5wRXBrpnlOlAWB1i6Fyx+TkpHxfy+rsFDvmD
 Wy1pjCFB3rb0YBj9DlywH9LwVw/mKxWSHcR7Ezjm36LMGU2zRUqGBZrt+dyg9mEdT+ud
 3QBQ==
X-Gm-Message-State: AGi0PuacbI+C+8M7CppUSV3F4S+wI4P7Dcu61pl6ImMr/p9GFANfQ6Ak
 bPQWNBDSy8BavW953a1KOFw=
X-Google-Smtp-Source: APiQypIK+5nC6yEMGjcUH3KdSVIn1lTbUmHvTDAtPn1mtFt6EVHfNpn0rvdcafJqyn11poOMTgyRFQ==
X-Received: by 2002:a1c:f012:: with SMTP id a18mr9142222wmb.41.1587725439542; 
 Fri, 24 Apr 2020 03:50:39 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id j4sm7531620wrm.85.2020.04.24.03.50.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2020 03:50:38 -0700 (PDT)
Date: Fri, 24 Apr 2020 11:50:37 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: dnbrdsky@gmail.com
Subject: Re: [PATCH v5 0/2] Replaced locks with lock guard macros
Message-ID: <20200424105037.GC174193@stefanha-x1.localdomain>
References: <20200404042108.389635-1-dnbrdsky@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
Content-Disposition: inline
In-Reply-To: <20200404042108.389635-1-dnbrdsky@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 03, 2020 at 09:21:06PM -0700, dnbrdsky@gmail.com wrote:
> From: Daniel Brodsky <dnbrdsky@gmail.com>
>=20
> This patch set adds:
> - a fix for lock guard macros so they can be used multiple times in
> the same function
> - replacement of locks with lock guards where appropriate
>=20
> v4 -> v5:
> - added G_GNUC_UNUSED to lock guard macro to supress unused var warning
>=20
> v3 -> v4:
> - removed unneeded unlocks from areas where lock guards are now used
> - dropped change to lock guard in iscsi.c as it changed old functionality
>=20
> v2 -> v3:
> - added __COUNTER__ fix for additional lock guard macro
> - added missing include header in platform.c
>=20
> v1 -> v2:
> - fixed whitespace churn
> - added cover letter so patch set referenced correctly
>=20
> Daniel Brodsky (2):
>   lockable: fix __COUNTER__ macro to be referenced properly
>   lockable: replaced locks with lock guard macros where appropriate
>=20
>  block/iscsi.c           |  7 ++----
>  block/nfs.c             | 51 +++++++++++++++++++----------------------
>  cpus-common.c           | 14 ++++-------
>  hw/display/qxl.c        | 43 ++++++++++++++++------------------
>  hw/vfio/platform.c      |  5 ++--
>  include/qemu/lockable.h |  7 +++---
>  include/qemu/rcu.h      |  2 +-
>  migration/migration.c   |  3 +--
>  migration/multifd.c     |  8 +++----
>  migration/ram.c         |  3 +--
>  monitor/misc.c          |  4 +---
>  ui/spice-display.c      | 14 +++++------
>  util/log.c              |  4 ++--
>  util/qemu-timer.c       | 17 +++++++-------
>  util/rcu.c              |  8 +++----
>  util/thread-pool.c      |  3 +--
>  util/vfio-helpers.c     |  5 ++--
>  17 files changed, 88 insertions(+), 110 deletions(-)

Paolo, hope you don't mind if I use the block-next branch to merge this
and Simran's patch that depends on it.

Thanks, applied to my block-next tree:
https://github.com/stefanha/qemu/commits/block-next

Stefan

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6ixH0ACgkQnKSrs4Gr
c8isRQf6AxigFrpXLHOrHbSSKBMUVAum5dMlnKkiuaDn+/45OB1G9XAS6r8s0INf
cH3zXrXfr2qm5/pwazqBl+y0/oznDq7Q7qVzpB3K1PSKLAnDN1NwK4LHj7Majmjc
anpRDjLODuAZRf6S7AMPccaK5S93vSEOfgZEZ6WKTrMMCtPzTp51oK1oQAboQPEl
t218eJ6+6PpJ1aVxFg6Uhnqq39CPmVzz7v7Lf3VzUGZJuI0Dnj6lJ1MvUjGMazZv
ayCyaURro4y1iZIjo7NoidLuhuOL+Y1kfK5gfUHaPD/tYFJZuHgzX1KjiBjvUoUV
fUNjslTS4bINPsRLAKKQPKjaTiG2wQ==
=DE/g
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--

