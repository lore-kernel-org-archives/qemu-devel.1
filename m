Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39C3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:03:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92A2620838
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GoKq3Iiy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A2620838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1A5v-0006xy-Qi
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 11:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k1A5A-0006Vi-B4
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:02:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29053
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k1A58-0003Xo-Iy
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596121372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uErVxLdXZGHGHXkHEW4xIq6noalrIYM8gz1cQWmnoC8=;
 b=GoKq3Iiy4/2yZ6tN+74aqiVFZfE2gxj5tiKFatOMtr7iHx6hvg/jPgY13tG7aTI1+M5s3t
 3hzMimUJaDV5cdAJojghP7XiKpb9Z7UY/ogu9Ih4JrBoPHF7+M8WcMoiYywVCkK6dlYmSw
 yEpiPFneVjqrVAMIf4xI3N7o1qYMB9U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-4fn9__E7MPW5wah6l6gufQ-1; Thu, 30 Jul 2020 11:02:35 -0400
X-MC-Unique: 4fn9__E7MPW5wah6l6gufQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1809319200C0
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 15:02:34 +0000 (UTC)
Received: from localhost (ovpn-114-112.ams2.redhat.com [10.36.114.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B599F1C6
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 15:02:33 +0000 (UTC)
Date: Thu, 30 Jul 2020 16:02:32 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH for-5.1] tracetool: carefully define SDT_USE_VARIADIC
Message-ID: <20200730150232.GA147672@stefanha-x1.localdomain>
References: <20200729153926.127083-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200729153926.127083-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 23:51:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2020 at 04:39:26PM +0100, Stefan Hajnoczi wrote:
> The dtrace backend defines SDT_USE_VARIADIC as a workaround for a
> conflict with a LTTng UST header file, which requires SDT_USE_VARIADIC
> to be defined.
>=20
> LTTng UST <lttng/tracepoint.h> breaks if included after generated dtrace
> headers because SDT_USE_VARIADIC will already be defined:
>=20
>   #ifdef LTTNG_UST_HAVE_SDT_INTEGRATION
>   #define SDT_USE_VARIADIC <-- error, it's already defined
>   #include <sys/sdt.h>
>=20
> Be more careful when defining SDT_USE_VARIADIC. This fixes the build
> when both the dtrace and ust tracers are enabled at the same time.
>=20
> Fixes: 27e08bab94f7c6ebe0b75938c98c394c969e3fd8 ("tracetool: work around =
ust <sys/sdt.h> include conflict")
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  scripts/tracetool/backend/dtrace.py | 4 ++++
>  1 file changed, 4 insertions(+)

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8i4QgACgkQnKSrs4Gr
c8ihqAf+NzEfSaDLn69Cchbs+MNYraChEMPlU4da5YUj90nDAgf+CtuncDwVUB5d
fbmMK8EzhMfDgqNLbq5rEDXQ0jypOoAtoso+59qLPOmU9ZIV7dRUUWpl33vOnfgK
RPhU1Z6rmzuRhFKj3LY0ejKhylpAsGx8t98jxy9L+tvlOknpCj1AGTtojlw67Ftu
XWEssf28p0WCCiZV9Pu4NqixmrXiZ9AcjJRg7tC1f7DIYsn+Q9CCYQdhjm/RbxH+
yjP3NfeLXDyC6xh5hcZDBwlPl2vrwbVsgRU/HMVYI8DRAYLdKA+DRUZjCS1cFWxi
0iAyVuJcl37tPgTBo/krsd6a6Jov/w==
=/p/9
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--


