Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613F2C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:52:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 342F3206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FvFM1duM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 342F3206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqf2S-0001xz-EY
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 11:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqf1Y-0000aZ-Ls
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:51:48 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47948
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqf1X-0001kO-8I
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:51:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593618706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wc8LNqtAUumxszmyRPO6oz14eb5DpQckn5jm2wR3ybE=;
 b=FvFM1duMB4KrNa7NNwLBVUXAv1siEro2gW6z3wVYARUxjl6UCXijigHaC2/DOXtvlOTiuJ
 65q2Ha8HQw6wtufgjXthdwSODQDtDMsSgHPqdWsoqmud9G+TTIJd1mq9CcZKDHWjKNPek3
 srmseUWKHwUFnk5s6nti6RDE8KR96Bw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-tCkEYBicN_ehJ1bx2aoadA-1; Wed, 01 Jul 2020 11:51:41 -0400
X-MC-Unique: tCkEYBicN_ehJ1bx2aoadA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A6A48015CE;
 Wed,  1 Jul 2020 15:51:40 +0000 (UTC)
Received: from localhost (ovpn-113-121.ams2.redhat.com [10.36.113.121])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B0DFF71662;
 Wed,  1 Jul 2020 15:51:39 +0000 (UTC)
Date: Wed, 1 Jul 2020 16:51:38 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 08/12] block/nvme: Replace qemu_try_blockalign(bs) by
 qemu_try_memalign(pg_sz)
Message-ID: <20200701155138.GR126613@stefanha-x1.localdomain>
References: <20200630191318.30021-1-philmd@redhat.com>
 <20200630191318.30021-9-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200630191318.30021-9-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="teKjxxMjPsACTz/N"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 00:56:58
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--teKjxxMjPsACTz/N
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2020 at 09:13:14PM +0200, Philippe Mathieu-Daud=E9 wrote:
> qemu_try_blockalign() is a generic API that call back to the
> block driver to return its page alignment. As we call from
> within the very same driver, we already know to page alignment
> stored in our state. Remove indirections and use the value from
> BDRVNVMeState.
> This change is required to later remove the BlockDriverState
> argument, to make nvme_init_queue() per hardware, and not per
> block driver.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  block/nvme.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--teKjxxMjPsACTz/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl78sQoACgkQnKSrs4Gr
c8iyRwgArQ637WVcJvvGsDfQFBx84WajJLEWRp8GQuA7h97B/XdrKoMb0/DA6kiC
gRVLfzmyNZk6rxmxIwbjrisOB1slPVntMJmCDBMIkiG19zsajKLkvIeH6lS1FwH0
VLwukE173bsdhPsz1U+OuOcstJlPW1KsNIN+A1V5sLPjbHmgqsIeXM+stStIysF3
TuZft7ro8Z/HWMkJxf/2DA1A7VsZuosYoTsHMA8adkuZ2bn+KLTTTtFUiCjJ5b71
kGdjZ4bUwe6BiWXboxSpQI8/sG6Kdw4GNVXApvjjiDedUdZoc6VGNc5GSHDS4S/x
sXBkK++C+OYrmjEw051DTn2LQVg4IQ==
=4hs6
-----END PGP SIGNATURE-----

--teKjxxMjPsACTz/N--


