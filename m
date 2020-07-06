Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F7DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 11:42:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE83E206E9
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 11:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MENl3G5H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE83E206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsPVz-0003Kc-2v
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 07:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jsPV3-00023Z-HK
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 07:41:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54656
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jsPUz-00039Z-O1
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 07:41:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594035684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3vlvSjU3kVrfPCwcy5ICc5nQuvYGB5Ri5hfYp2L+ms4=;
 b=MENl3G5HSIK2uaotD9SpxseAEXn9oA+i0jdb5NDf9zV6Jw8wbIku00RKUeYUK/foZhc1Cs
 NVgIvzkLiB0LV472FsrVCASzlG3EHuMSXg7OK3jqzgQJXyLSveDEzPwTut9dlRHZXKTIrN
 v+G8WG8fVHiOVfms+5lix8TNwwBtbOc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-Ya3l99kAN7aiRB4zhGIaGQ-1; Mon, 06 Jul 2020 07:41:21 -0400
X-MC-Unique: Ya3l99kAN7aiRB4zhGIaGQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C6AA18FE861;
 Mon,  6 Jul 2020 11:41:20 +0000 (UTC)
Received: from localhost (ovpn-114-217.ams2.redhat.com [10.36.114.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 030977B400;
 Mon,  6 Jul 2020 11:41:19 +0000 (UTC)
Date: Mon, 6 Jul 2020 12:41:18 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v3 15/16] block/nvme: Move nvme_poll_cb() earlier
Message-ID: <20200706114118.GD342708@stefanha-x1.localdomain>
References: <20200704213051.19749-1-philmd@redhat.com>
 <20200704213051.19749-16-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200704213051.19749-16-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/3yNEOqWowh/8j+e"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:22:37
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

--/3yNEOqWowh/8j+e
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 04, 2020 at 11:30:50PM +0200, Philippe Mathieu-Daud=E9 wrote:
> We are going to use this callback in nvme_add_io_queue()
> in the next commit. To avoid forward-declaring it, move
> it before. No logical change.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  block/nvme.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--/3yNEOqWowh/8j+e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8DDd4ACgkQnKSrs4Gr
c8gv4wf9GUvd7maNLAHkmAOUy9enNWRuopfecNB5hI/gKCaV+MZSJuV806UxTaEM
1v4HvmTa7qHgV3IVsCbekOIt/+YjUV84r+fei0UTD/RdWn3rDBWvp2RZaNwph7Lm
8ilG8Lt+nror8AcLS1I7tsLz7LZzZQIqdePvzC+TMsQ0cYVWaUpRbVQDVFNaCt5i
rfmryv4G2NiXpZkKxfM/Cj8vsmDwCai5b60p9KvlEXmFey2AIGIwue62x7AQ9++2
E/aK9F7EBiFim1mDmIUUHpFALBfy0CaLcjY7MYDtMQdD0XVXPG9dw3OxMQlyaxKa
GXX3SUyU5mygw3Cgjrws/h9Lig+C4A==
=8tLJ
-----END PGP SIGNATURE-----

--/3yNEOqWowh/8j+e--


