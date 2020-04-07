Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E64C2BABC
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:12:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 254A2206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZuqDcovt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 254A2206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLkH1-0007z6-Af
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 05:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58427)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jLkFU-0006Sj-Q4
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:10:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jLkFT-0005Iu-Sy
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:10:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36618
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jLkFT-0005IA-OV
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:10:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586250623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GFLMtEby526XwM+KZFxCy1SC8KWxDQ3asUq7H9NWTlc=;
 b=ZuqDcovtJck3efQp0q/XHzu3QF7RqXXm23+s9Y3mLxi7YJm8tNr8Jh0pgQkfjwoynmR5Lq
 B54rjXPlv6L8rxb4+G45XKE/88rSH15t6v8oGKuKsrT3V2MqFCXsHyu5kMUKMJcEoJm/VZ
 CKe1IWbMZJb7Qc9EK4OGH4fM0RJ9fh8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-WmcSVNzMNZOQGReMF2iR_A-1; Tue, 07 Apr 2020 05:10:19 -0400
X-MC-Unique: WmcSVNzMNZOQGReMF2iR_A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C09F1922023;
 Tue,  7 Apr 2020 09:10:18 +0000 (UTC)
Received: from localhost (ovpn-113-168.ams2.redhat.com [10.36.113.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CAC1210002BC;
 Tue,  7 Apr 2020 09:10:17 +0000 (UTC)
Date: Tue, 7 Apr 2020 10:10:16 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 0/4] async: fix hangs on weakly-ordered architectures
Message-ID: <20200407091016.GD247777@stefanha-x1.localdomain>
References: <20200406191320.13371-1-pbonzini@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200406191320.13371-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/3yNEOqWowh/8j+e"
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
Cc: Ying Fang <fangying1@huawei.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--/3yNEOqWowh/8j+e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 06, 2020 at 03:13:16PM -0400, Paolo Bonzini wrote:
> Patch 4 fixes qemu-img and qemu-io hangs on weakly-ordered architectures.
> Patch 1-3 are related docs fixes and improvements.
>=20
> This is RFC because it relies on the iothread being locked during aio_pol=
l
> on the main AioContext.  If I add assertions for this however I see a
> failure for test 267, so I am posting it as a preview before I debug that=
.
> The doc patches can also go in independently of course.
>=20
> Paolo
>=20
> Paolo Bonzini (4):
>   atomics: convert to reStructuredText
>   atomics: update documentation for C11
>   rcu: do not mention atomic_mb_read/set in documentation
>   async: use explicit memory barriers
>=20
>  docs/devel/atomics.rst | 385 +++++++++++++++++++++++++++++++++++++++
>  docs/devel/atomics.txt | 403 -----------------------------------------
>  docs/devel/index.rst   |   1 +
>  docs/devel/rcu.txt     |   4 +-
>  util/aio-posix.c       |   9 +-
>  util/aio-win32.c       |   8 +-
>  util/async.c           |  12 +-
>  7 files changed, 413 insertions(+), 409 deletions(-)
>  create mode 100644 docs/devel/atomics.rst
>  delete mode 100644 docs/devel/atomics.txt

I have left comments requesting clarifications, but the code change
looks fine:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--/3yNEOqWowh/8j+e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6MQ3gACgkQnKSrs4Gr
c8hFeAf+MML8QwSVnrPlfjhTtkHNvn8JTzv0uqh4m79SIQgbnoZUgD86pejouTBH
NnBmd7qSVmTShWb6HTMxPOaDKBIKLNlfKK+nWmPDkyEPqb3Aovt7KqVnk8L+lk6y
evuD/17SQBk1+vfOH8i6//XzZ8Bd6I5K3IlPHv30HqeWa5x6kweeQbiBS41PpE17
ebprm4Dd3oD63znjFC/vGLaE8x7O85qGea6bhWFnnRpSTzACQs4hJ7lMeMBS7Fuo
0TUyo+Y7g9wMBOlzhsU1r+HYU4kWF2AxQBA/ny5DM5IIKpK/0SYrsw8/CX2olNSA
l2w51q6KJSurQv6mQ7j5nAzqO0CRdA==
=DTjI
-----END PGP SIGNATURE-----

--/3yNEOqWowh/8j+e--


