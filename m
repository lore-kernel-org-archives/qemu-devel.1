Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F02C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:42:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F1C620658
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Keg1hgtZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F1C620658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4MoU-0000Gx-CN
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 05:42:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1j4Mnm-0008Cg-Gl
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:41:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1j4Mnl-0008HV-JM
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:41:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42461
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1j4Mnl-0008H7-Eg
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:41:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582108916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nhnv2gpRpnGSf+2Gn8odCLtegPPMBSk9BMQBW3yMcFc=;
 b=Keg1hgtZBgOMw3FpCqXPKNSZJiP2ah6cXcjFsK2L1F+j51mg0jloR3I7sU7bu2rtS1RprL
 IOvzC9rHiWP1BSPPMVUXBMIJF7+QA4JxEdlABr/nyiMFysv5cKCF2cXbutT3Nr5H4eML2A
 YyZcXwyiOwNnCSPoluLQmqWrR0fCpck=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-bFYAkmmEMTat9bPhQvIbUw-1; Wed, 19 Feb 2020 05:41:53 -0500
X-MC-Unique: bFYAkmmEMTat9bPhQvIbUw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD80B13E2;
 Wed, 19 Feb 2020 10:41:51 +0000 (UTC)
Received: from localhost (unknown [10.33.36.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A52E19757;
 Wed, 19 Feb 2020 10:41:46 +0000 (UTC)
Date: Wed, 19 Feb 2020 11:41:45 +0100
From: Sergio Lopez <slp@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 4/5] aio-posix: make AioHandler deletion O(1)
Message-ID: <20200219104145.qmxofusnwb3tsxsc@dritchie>
References: <20200214171712.541358-1-stefanha@redhat.com>
 <20200214171712.541358-5-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200214171712.541358-5-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="th7mdn5ic232bb3t"
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--th7mdn5ic232bb3t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2020 at 05:17:11PM +0000, Stefan Hajnoczi wrote:
> It is not necessary to scan all AioHandlers for deletion.  Keep a list
> of deleted handlers instead of scanning the full list of all handlers.
>=20
> The AioHandler->deleted field can be dropped.  Let's check if the
> handler has been inserted into the deleted list instead.  Add a new
> QLIST_IS_INSERTED() API for this check.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/block/aio.h  |  6 ++++-
>  include/qemu/queue.h |  3 +++
>  util/aio-posix.c     | 53 +++++++++++++++++++++++++++++---------------
>  3 files changed, 43 insertions(+), 19 deletions(-)

Reviewed-by: Sergio Lopez <slp@redhat.com>

--th7mdn5ic232bb3t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl5NEOgACgkQ9GknjS8M
AjX14Q/+OImUU9tcBKQqtpE3eV/W/tyI3LAHLXe44454TB8dyKYjXa8/52gdv32k
M9f680NqYXRq/Oo1rxXEjGGBGTNBcAZRbhMWCadArXH2ub6QLFMvdxH4wlZ5MHdM
aHMy0r4QjMkCwIwu/5dQvZRbrLM2eVCfdY3j7v8Xjb50mkjHCjhEQcJZtTR+1w56
cCnhBGcB6Qpn7aoMRvMzpzlZKPFrEjPo6YvjKKil4H/oeg0qUJclmBDQ9u+TuT+5
dliUWwULb1HzIPaJo0tLmp6LGmSend6sPiarSh78dgZU2ApkgEh+Q/MhUVL0NHSH
qaTBoRw6Z/4S52E/1ct6eg0bPzU+7EMzR5u84hnuKVbvBZLnXZPAma4k3N1289Aj
p4Sx1c2P5ldyqImLInUNS7hGGk3vcgZogVqP8MUDSwQPAxYQQiZ8+swbxx5CleM4
iQV4ndkU5IJK48woxmMPeQKaaYVzKhw/beFKmY7yLN5nDpLuGqvqgNTCeghRsZBt
iHGyfo9CMsWvBO03g9hkluw4FBeIb2EWGvjOF2QkT+XeK2KUsikMo1J5cNhhwoVI
lgUbZXynC+iH410BNTPyC3/NSudKUE27iva7FjrwhZyqxgRlJArOBaYreqYh9C+w
Eh7PG8yr3nFXU29WMgYJzIgAfwdNVXkMMBFU1bd/FkeCzkar2pw=
=EFcg
-----END PGP SIGNATURE-----

--th7mdn5ic232bb3t--


