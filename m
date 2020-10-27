Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7803C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 09:34:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2935F2224E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 09:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="asyKtitC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2935F2224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXLMn-0002h7-5S
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 05:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXLLI-00021C-OI
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:32:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37682)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXLLG-0007fN-FQ
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:32:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603791152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L4ZwX6X3rca5OxRZqv76z54dX8RADXL3JgbhPQOuS6o=;
 b=asyKtitCBcEoSmTVyuyfiP0+5wu0X3vJheEbgqWbc74312c4cWmAx5TsNLFA6Jo0jdTA6q
 x+txwrJMHGY4zjryl8rbLI0Afdf74B4WVT8Mdfd5QTSc1rP/T0NB/JhPTSe8fISGmH8fWP
 PsYdl/WhdMQJIP8p68hE3M6LzRNNBYQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-BNSX8si5MUCcxIGQ6RE9Vg-1; Tue, 27 Oct 2020 05:32:30 -0400
X-MC-Unique: BNSX8si5MUCcxIGQ6RE9Vg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A9141084C9C;
 Tue, 27 Oct 2020 09:32:29 +0000 (UTC)
Received: from localhost (ovpn-114-163.ams2.redhat.com [10.36.114.163])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B001D5C1BB;
 Tue, 27 Oct 2020 09:32:22 +0000 (UTC)
Date: Tue, 27 Oct 2020 09:32:21 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 03/19] block/nvme: Introduce device/iommu
 'page_size_min' variables
Message-ID: <20201027093221.GC79063@stefanha-x1.localdomain>
References: <20201026105504.4023620-1-philmd@redhat.com>
 <20201026105504.4023620-4-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201026105504.4023620-4-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/Uq4LBwYP4y1W6pO"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--/Uq4LBwYP4y1W6pO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2020 at 11:54:48AM +0100, Philippe Mathieu-Daud=E9 wrote:
> Introduce device/iommu 'page_size_min' variables to make
> the code clearer.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  block/nvme.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/nvme.c b/block/nvme.c
> index aa290996679..5abd7257cac 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -690,6 +690,8 @@ static int nvme_init(BlockDriverState *bs, const char=
 *device, int namespace,
>      uint64_t deadline, now;
>      Error *local_err =3D NULL;
>      volatile NvmeBar *regs =3D NULL;
> +    size_t device_page_size_min;
> +    size_t iommu_page_size_min =3D 4096;
> =20
>      qemu_co_mutex_init(&s->dma_map_lock);
>      qemu_co_queue_init(&s->dma_flush_queue);
> @@ -724,7 +726,8 @@ static int nvme_init(BlockDriverState *bs, const char=
 *device, int namespace,
>          goto out;
>      }
> =20
> -    s->page_size =3D MAX(4096, 1u << (12 + NVME_CAP_MPSMIN(cap)));
> +    device_page_size_min =3D 1u << (12 + NVME_CAP_MPSMIN(cap));
> +    s->page_size =3D MAX(iommu_page_size_min, device_page_size_min);

It's not clear to me that the 4096 value is related to the IOMMU page
size here. The MAX(4096) expression seems like a sanity-check to me. An
MPS value of 0 is a 4KB page size, so it's never possible to express a
smaller page size. I guess MAX() was used in case a device incorrectly
reports MPSMIN.

I think introducing the concept of IOMMU page size is premature and
maybe not the intention of the existing code, but the concept will be
needed soon, so this patch is okay:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--/Uq4LBwYP4y1W6pO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+X6SUACgkQnKSrs4Gr
c8j81wf9E7unSIlvVheq4PZaz/enZFGv52I18A0fI6lj8Cm+8fEFwTXGqqD9h/FK
4bGYdIAnIrvNdu8hOlIw6pjj8DRxFbULcnFnx59M4oH0isAeM1Em70c1hQIC5WSq
sPnkkKA5A+h2/RNB4vqaXbRp2GUkTHPmw9m496Gtp9C0vwE54JBSlMrwhOAPrc6M
U2PkXcCehX8LCZoCFb23ffzifljLOUMo6JvZwcVC1iBdBlu45xppDt/ZDQl6Sa36
n5piiwYAA+NJtlMJhgzDFggTlMeJL2gSKj33AvsqblkDwHeXLorzG+zeGqbrSMCL
hQEC21s8hWPKkZPODfHGw7fusFZwWA==
=TgIg
-----END PGP SIGNATURE-----

--/Uq4LBwYP4y1W6pO--


