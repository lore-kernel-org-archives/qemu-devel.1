Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FC2C2BABC
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:11:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2118206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cIUSwbic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2118206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLkG4-0006gX-3y
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 05:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58385)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jLkFA-0005vY-It
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:10:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jLkF9-0004xA-G0
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:10:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20125
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jLkF9-0004wm-Bj
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:10:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586250603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jqNlTEiKupzwd/AdNrwWgYT4fMD9VHxeJbx1FLIG9MM=;
 b=cIUSwbicnbXvBna6Xd2EhXZe73qQYswGPPM31zQCai3IXgG7fHQC3+ORibIPXKJ6ZoJyLV
 pe5wcE++I1wY7fHeLGCVuoLj/f6eCdy7K8m3gKZy0miGoNodJERqjVaLtV4E42Asd3uXV5
 Zz4gtvvSnac4m//RdP1iw6uUN0GwpLM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-dN4767_IPjmApadN4gJPLQ-1; Tue, 07 Apr 2020 05:09:57 -0400
X-MC-Unique: dN4767_IPjmApadN4gJPLQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8780D1922021;
 Tue,  7 Apr 2020 09:09:56 +0000 (UTC)
Received: from localhost (ovpn-113-168.ams2.redhat.com [10.36.113.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1DAE55DA7B;
 Tue,  7 Apr 2020 09:09:55 +0000 (UTC)
Date: Tue, 7 Apr 2020 10:09:54 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 4/4] async: use explicit memory barriers and relaxed
 accesses
Message-ID: <20200407090954.GC247777@stefanha-x1.localdomain>
References: <20200406191320.13371-1-pbonzini@redhat.com>
 <20200406191320.13371-5-pbonzini@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200406191320.13371-5-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="f0KYrhQ4vYSV2aJu"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Ying Fang <fangying1@huawei.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--f0KYrhQ4vYSV2aJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 06, 2020 at 03:13:20PM -0400, Paolo Bonzini wrote:
> When using C11 atomics, non-seqcst reads and writes do not participate
> in the total order of seqcst operations.  In util/async.c and util/aio-po=
six.c,
> in particular, the pattern that we use
>=20
>           write ctx->notify_me                 write bh->scheduled
>           read bh->scheduled                   read ctx->notify_me
>           if !bh->scheduled, sleep             if ctx->notify_me, notify
>=20
> needs to use seqcst operations for both the write and the read.  In
> general this is something that we do not want, because there can be
> many sources that are polled in addition to bottom halves.  The
> alternative is to place a seqcst memory barrier between the write
> and the read.  This also comes with a disadvantage, in that the
> memory barrier is implicit on strongly-ordered architectures and
> it wastes a few dozen clock cycles.
>=20
> Fortunately, ctx->notify_me is never written concurrently by two
> threads, so we can instead relax the writes to ctx->notify_me.
> [This part of the commit message is still to be written more
> in detail and is what I am not sure about.]
>=20
> Analyzed-by: Ying Fang <fangying1@huawei.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  util/aio-posix.c |  9 ++++++++-
>  util/aio-win32.c |  8 +++++++-
>  util/async.c     | 12 ++++++++++--
>  3 files changed, 25 insertions(+), 4 deletions(-)
>=20
> diff --git a/util/aio-posix.c b/util/aio-posix.c
> index cd6cf0a4a9..37afec726f 100644
> --- a/util/aio-posix.c
> +++ b/util/aio-posix.c
> @@ -569,7 +569,13 @@ bool aio_poll(AioContext *ctx, bool blocking)
>       * so disable the optimization now.
>       */
>      if (blocking) {
> -        atomic_add(&ctx->notify_me, 2);
> +        atomic_set(&ctx->notify_me, atomic_read(&ctx->notify_me) + 2);

Non-atomic "atomic" code looks suspicious and warrants a comment
mentioning that this is only executed from one thread.  This applies to
the other instances in this patch too.

--f0KYrhQ4vYSV2aJu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6MQ2IACgkQnKSrs4Gr
c8irTAgAhT/wa9N9TY+tJ92FEtjJX+INrAJuDhDE6mhg7VSYL6fusBxO3bMJleFl
lLteyt+ikhhASHbQdhfc9FZ7Bcei5ZiQ5DdlNkJLEKVmOwuEPcou+pyHUVmCZKjR
hg8aPrt5ZmT/T3y5bZPVYQ995XYi7kgsnkPdZsf4YoO9Do5NDQMHCmN2ZDxLTetp
/v1H1z7+qpgzK4mNqxjV9hwEadyQ23SqtRdy6ast1ybgFpxCmRLEfB0lECTk4daU
5nqQ4n3FZIyB+ptxaMB6icMzM2UBO5U85qIIVAGlACqSlZcVU3R3ffCmdIWPUO/K
YSq+j8ieiyJxTmygLVluEEabp6xXmg==
=eGiK
-----END PGP SIGNATURE-----

--f0KYrhQ4vYSV2aJu--


