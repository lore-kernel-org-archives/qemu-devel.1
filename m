Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8838FC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:35:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9115206E5
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VV3O0WM8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9115206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYVUm-0003Zw-Ki
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 10:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kYVM5-0002ab-CN
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:26:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55687)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kYVLz-0000Y6-Gv
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604067962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lqh44MrA5Rfar2u9l6tgxk6+3BSJOz/wh2SATDpq49Q=;
 b=VV3O0WM8wIuA4OYhWQ5ZVQEIQo9YYWxJ4CrAjWILRqNaC7JCptpoBtRd9P7X1KTxB8uH4O
 L2E+yXADb+AK+HcRpbzcnF+jDGGP8vEl/p3Z8QKjf2w3pJ+ONKHOLdCFPHBmDWCaYtv639
 yEfTFqMKwaG+BKYAAwciklq7OIijFP4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-S_gn6I2cPjmeIcd62b4nKQ-1; Fri, 30 Oct 2020 10:25:58 -0400
X-MC-Unique: S_gn6I2cPjmeIcd62b4nKQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F740879512;
 Fri, 30 Oct 2020 14:25:57 +0000 (UTC)
Received: from localhost (ovpn-113-41.ams2.redhat.com [10.36.113.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E095C19C71;
 Fri, 30 Oct 2020 14:25:52 +0000 (UTC)
Date: Fri, 30 Oct 2020 14:25:51 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.2 v2 16/25] block/nvme: Simplify nvme_cmd_sync()
Message-ID: <20201030142551.GE330921@stefanha-x1.localdomain>
References: <20201029093306.1063879-1-philmd@redhat.com>
 <20201029093306.1063879-17-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201029093306.1063879-17-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2qXFWqzzG3v1+95a"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 02:24:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Eric Auger <eric.auger@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--2qXFWqzzG3v1+95a
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2020 at 10:32:57AM +0100, Philippe Mathieu-Daud=E9 wrote:
> As all commands use the ADMIN queue, it is pointless to pass
> it as argument each time. Remove the argument, and rename the
> function as nvme_admin_cmd_sync() to make this new behavior
> clearer.
>=20
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  block/nvme.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--2qXFWqzzG3v1+95a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+cIm8ACgkQnKSrs4Gr
c8ii1AgAiB9+JLCfz8qCEuPgv0zfB6nI3UOZkvOJufw3nB/4Z1NUoyPkvHIitgcK
s6QxZNSsA9eOO2/VHinL+ICYO79zBxrGb6Zr3myyEZa7doqRfhTO7dbo+vFzHxjB
Ox1otpkRz1cWfo8e/oqnfcZBiZvMQcvqU/GpIgF94fo1j5X/33SeITQ502jlpY+S
TuOJAKdIq/Dt2KD0ItGTr24OcoExngwslaKKL1bG5skNUWqOGP4EKa7r0qTAryFD
LXk20w3sIg5J7sOdrg8uyp/nMlk5U6LLDeFphAyO7pFFbKk5hBn+mWNyVDpj5p8G
glxaOModvEqxFQgnoHhpOM4PUr8rpg==
=4b3E
-----END PGP SIGNATURE-----

--2qXFWqzzG3v1+95a--


