Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0007C38A2C
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 11:35:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE48C208FE
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 11:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WnuTRMOZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE48C208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOgJq-0000vY-Vu
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 07:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOgJF-0000SL-Kj
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 07:34:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOgJD-00068E-NV
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 07:34:24 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51799
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOgJD-00067u-85
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 07:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586950462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2BYACKgQbA2aB41XonzcK8WGmovDA0I43ortBqGlWTY=;
 b=WnuTRMOZmiDuRmac/Uc06sgkodlWTJGoqnPqY1xup3U/S8/XO8qPXKfr36rLqCeDKy77PY
 v0A8M4BNd1mes9rK6US2aemTVli7M9t2/hj1885Htnrzb9GDXAUQEd+vMMZ11WcUsEOMoS
 v4O+CjR7ZUsz6pWcdDa4QBRD5Yxqd1k=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-K-qxegN8NTKblJVToQGmag-1; Wed, 15 Apr 2020 07:34:20 -0400
X-MC-Unique: K-qxegN8NTKblJVToQGmag-1
Received: by mail-ed1-f72.google.com with SMTP id f11so2674330edc.4
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 04:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ku5k91aAs6qhCvO6FVUpSGuQNUhTpIgfzSK5wI7/zW0=;
 b=VHP95LxE3gelmima3hu1BRMrIXHuQvJAv9BYerYSeyakrWHcUbi+Fb2sf8qS/zCv5A
 wX0XrbJZB/vzXwrVcGnq23aC+VCgbgIAwjAM6Zfz3HPLnpwoHs9ROlQLV9t3isw+r+OO
 W5xzQI9WM2bjMUHSWDUty9EbHZZ/yPlVgFZwkQXQFx4VuRLifLHk+E62a+sj+XdHyLxF
 HNPYhmtMXB9W3FUGLkq4iR2l9+MjJXk6SsS1AnyGvXmpdqmyW/Ju4CEqpabm1p8Nqf7W
 pIkcSZhe6qi7bgDC3TyACX9Jlgq5BrOp74VmlGP6NCQlc7nBTab6Wtdm6AXGr4ws8kwN
 DKmQ==
X-Gm-Message-State: AGi0PuaJozswCJe/gLzmDACDFyMlUXutZuky/fstfJmRC9fua047DX+c
 QkTFNYIkzPKzE0FA4Hg3xf4OMHsnBWs2spgK/Fs1auXYw9Jw4D3FsmXjwyCoVRQYa6GcN2W/yPk
 HpPrs3WxHtcraJmA=
X-Received: by 2002:a05:6402:543:: with SMTP id
 i3mr7994207edx.255.1586950459395; 
 Wed, 15 Apr 2020 04:34:19 -0700 (PDT)
X-Google-Smtp-Source: APiQypKtwKuv2/sAKk+NC5om4z2FWOK9uiBKpBJfuh9hBH2BbiToUKeKDcZkB7NBNraqWxWyNeH8Vg==
X-Received: by 2002:a05:6402:543:: with SMTP id
 i3mr7994185edx.255.1586950459153; 
 Wed, 15 Apr 2020 04:34:19 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id u7sm1753038edy.25.2020.04.15.04.34.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2020 04:34:18 -0700 (PDT)
Subject: Re: [PATCH 01/16] nvme: fix pci doorbell size calculation
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200415102445.564803-1-its@irrelevant.dk>
 <20200415102445.564803-2-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6c2f8cf6-efb0-89e2-8a67-4b752d85c0a1@redhat.com>
Date: Wed, 15 Apr 2020 13:34:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415102445.564803-2-its@irrelevant.dk>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/15/20 12:24 PM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> The size of the BAR is 0x1000 (main registers) + 8 bytes for each
> queue. Currently, the size of the BAR is calculated like so:
>=20
>      n->reg_size =3D pow2ceil(0x1004 + 2 * (n->params.num_queues + 1) * 4=
);
>=20
> Since the 'num_queues' parameter already accounts for the admin queue,
> this should in any case not need to be incremented by one. Also, the
> size should be initialized to (0x1000).
>=20
>      n->reg_size =3D pow2ceil(0x1000 + 2 * n->params.num_queues * 4);
>=20
> This, with the default value of num_queues (64), we will set aside room
> for 1 admin queue and 63 I/O queues (4 bytes per doorbell, 2 doorbells
> per queue).

It seems you are right, but I'd feel safer with a Ack-by from Keith.

Do you mind adding definitions such:

#define NVME_IO_SIZE (4 * KiB)
#define DOORBELL_SIZE 4
#define DOORBELL_COUNT 2

Looking at nvme_set_feature() I see better why you introduce=20
max_ioqpairs in patch #7:

     case NVME_NUMBER_OF_QUEUES:
         trace_nvme_setfeat_numq((dw11 & 0xFFFF) + 1,
                                 ((dw11 >> 16) & 0xFFFF) + 1,
                                 n->num_queues - 1, n->num_queues - 1);
         req->cqe.result =3D
             cpu_to_le32((n->num_queues - 2) | ((n->num_queues - 2) << 16))=
;
         break;

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>=20
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>   hw/block/nvme.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index d28335cbf377..77f9c151a665 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1345,7 +1345,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
>       pcie_endpoint_cap_init(pci_dev, 0x80);
>  =20
>       n->num_namespaces =3D 1;
> -    n->reg_size =3D pow2ceil(0x1004 + 2 * (n->num_queues + 1) * 4);
> +    n->reg_size =3D pow2ceil(0x1000 + 2 * n->num_queues * 4);
>       n->ns_size =3D bs_size / (uint64_t)n->num_namespaces;
>  =20
>       n->namespaces =3D g_new0(NvmeNamespace, n->num_namespaces);
>=20


