Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E770DC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 07:06:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2D04206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 07:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBDVm62e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D04206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsMDi-00051m-Rf
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 03:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37644)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hsMDJ-0004ak-M3
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 03:06:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hsMDI-0004V5-QZ
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 03:06:25 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:34454)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hsMDI-0004U9-IG
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 03:06:24 -0400
Received: by mail-wr1-x436.google.com with SMTP id 31so64503407wrm.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 00:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=9qY8gImTNt7sSddmhFbE0s4R398yKi7Sk8wSsEEEQ/Y=;
 b=nBDVm62e9/JXm9zdghlTj/2Npoim7Io6j+2p8FFg8dKTj33MPLQf+eYKbPGfekLFIk
 YuQvgNTftV+eCFXpom4vBDLyQmBkYDejewtG6w5osvcPf0aQUMcTtRazq56s1EByTlUD
 50N8T28nHd10Iu3G4AUWLyu0uYcTAKFH9Vj9Mo/qfPY8frPk4ZWXAeS1ePsBZoqSdqwE
 iz43Yxgf4IsJSgWrXhi6g7NJ/e5AcMhUVL/Tbho4sZK9d0uJEQ8lvpi6YsPI5TFuxxLs
 qc6nQuDx0K+d0DU0FG1KssTB8ZxrzlDRiUjQOdz/vjn/gRq3AuRGeah1FXYLlkJaOxQx
 mUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=9qY8gImTNt7sSddmhFbE0s4R398yKi7Sk8wSsEEEQ/Y=;
 b=jm76h+4Fanu/ptvYbUOJe7ImS5YlWhdgb2YkqFY6vUAsEgrAG40P0Em+VeMiYQGA7M
 HLWsNysc9y2j52vanoTritaMUaZS9QbFg76xmIzSqHJ/LxFpFh+DVQ+H8Vjo7ArGJCyN
 UOTYgf6rYTEc7/gdO48EB5rhxQj2AioNLa+1SXTSuj2pbefdXRvqvIh6KOORRbuRMa/5
 vb4f/Tmz73kZ/JR/Xbl/ukHgrZCvHK2lh2DEL6Cr0WEf6+BjFuDGjg8BTcet4ZjWxUge
 +xCWhpmN448Fj1VH2CgqQwK+X+s+HCyUXeB/BuQMBVMWtj0cBBymTh0xkRXqxjgjV1KJ
 xZGw==
X-Gm-Message-State: APjAAAUiQEhGEBdxJQg6BTMYg+Z7RfrLBAzFi7BZrFPYhQCDLowrtI4u
 e+zuQcQdBM6i53vEmm0/22E=
X-Google-Smtp-Source: APXvYqwWo+qwg2qDHXXcVmpz71kDnQUjrqtOFwnkPCJfu/vCQCQP5yW5Ddt3j/6YETepp+RThWe0Nw==
X-Received: by 2002:adf:fb8e:: with SMTP id a14mr30743050wrr.263.1564470383057; 
 Tue, 30 Jul 2019 00:06:23 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id f7sm62597345wrv.38.2019.07.30.00.06.21
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 30 Jul 2019 00:06:22 -0700 (PDT)
Date: Tue, 30 Jul 2019 08:06:20 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Sergio Lopez <slp@redhat.com>
Message-ID: <20190730070620.GA30213@stefanha-x1.localdomain>
References: <20190729125755.45008-1-slp@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
In-Reply-To: <20190729125755.45008-1-slp@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
Subject: Re: [Qemu-devel] [RFC] virtio-mmio: implement modern (v2)
 personality (virtio-1)
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 29, 2019 at 02:57:55PM +0200, Sergio Lopez wrote:
> @@ -162,12 +183,34 @@ static uint64_t virtio_mmio_read(void *opaque, hwaddr offset, unsigned size)
>          }
>          return VIRTQUEUE_MAX_SIZE;
>      case VIRTIO_MMIO_QUEUE_PFN:
> +        if (proxy->modern) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: read from legacy register in modern mode\n",
> +                          __func__);

If you respin this series it would be nice to indicate which register
was accessed since these error messages are identical for the other
modern registers and there is no way to distinguish for troubleshooting.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0/7GwACgkQnKSrs4Gr
c8iSKgf/QupzS80vKHFMJH3l8Z2AQ6NxRKWI9VFVCsOyzPIgBAKuRBWrA3n5yJFs
CDRKQOSBFGYnankisWSe7u3mv4HsPlw3FNp/DtKTjorZNsjAPgsaPr83kgKd/9rD
bj8ExcwOUBVOBJTZSytNS9Ej5zzaiB39YX8E6TiZdUNMzKnQoK1YpZ92eHHlHXUR
IVUL0MdAJWA2H9e502gsED3QIFynAVjqZ5l8gEN+qv8RIOQlU4bOQpuPF37skcHr
+b5Ni5xbv5+JeMr8NuphPT7t7J/p6bbXQSfZRNYb2IkJI1yaW5tRseB2ckeWzonP
tDGwBHoLSwv5aTIvGCrzNhEJc7yL9g==
=EhCb
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--

