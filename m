Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D9EC388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 14:26:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46EC924171
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 14:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e2/YIpDA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46EC924171
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVbYC-0005jx-8l
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 10:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVbV8-0001g2-9r
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 10:23:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51143)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVbUq-0002oj-W7
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 10:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603376596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qh+vKCR34qPHvXPmzhGKY2XAHf+1rZva6C+4W7B9lxM=;
 b=e2/YIpDANsMgsPDBZ4ioT/sXoJTEtroLqdRz0rn9/AtZee159QlG/Tolcap+MHckgdSdIv
 VuzOzPfBJu+6u+S/w9eGGsnEWLwgGV3kmBNh4NtaUMzCsfUcURVCGGCp5giTUy6yFKxycT
 5z6vsydTq54I0Yfy0C3sJpTnrbzE3ZE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-pkKm1KcQMbO7lB3bcF8qxQ-1; Thu, 22 Oct 2020 10:23:13 -0400
X-MC-Unique: pkKm1KcQMbO7lB3bcF8qxQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA91681C9BE;
 Thu, 22 Oct 2020 14:23:12 +0000 (UTC)
Received: from localhost (ovpn-114-229.ams2.redhat.com [10.36.114.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 211A61002388;
 Thu, 22 Oct 2020 14:23:08 +0000 (UTC)
Date: Thu, 22 Oct 2020 15:23:07 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 10/16] util/vfio-helpers: Let qemu_vfio_dma_map()
 propagate Error
Message-ID: <20201022142307.GJ761187@stefanha-x1.localdomain>
References: <20201020172428.2220726-1-philmd@redhat.com>
 <20201020172428.2220726-11-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201020172428.2220726-11-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="x0KprKst+ZOYEj2z"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 08:33:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--x0KprKst+ZOYEj2z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2020 at 07:24:22PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Currently qemu_vfio_dma_map() displays errors on stderr.
> When using management interface, this information is simply
> lost. Pass qemu_vfio_dma_map() an Error* argument so it can
> propagate the error to callers.
>=20
> Reviewed-by: Fam Zheng <fam@euphon.net>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  include/qemu/vfio-helpers.h |  2 +-
>  block/nvme.c                | 14 +++++++-------
>  util/vfio-helpers.c         | 12 +++++++-----
>  3 files changed, 15 insertions(+), 13 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--x0KprKst+ZOYEj2z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+RlcsACgkQnKSrs4Gr
c8jDhQgAhE3OA+runks/0CF0+L02L3l8DNefBorgYPlKjH809/igL7us7LCSQINe
Dk2UEOGroKcrWmCOawC21sqvcJfQ+JGcyQQZkDSw75FOPJVNgcEn+p5vCLJh9I0k
RqROULLRGBOwm/Kyr/wvxF4Z+dYl5bQeUBabxnfw1gcHGAqSQzo0m21xPl5HGkL+
nIqvBTkL4kMTfS1xuMzjX7b71nZaU7nDvq7BX6siByVn8auLr7FaoHZg+Ew+xSZg
sFltAdrDBranxdkkWjK1PZhhREL93Y/AYMjmMUhhpEhyYy5NEETts1kcRXBm2EwQ
qrxGo4ZULn4PT9Pds1BwJeJGlRTcvw==
=BNzI
-----END PGP SIGNATURE-----

--x0KprKst+ZOYEj2z--


