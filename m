Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C88CC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 13:17:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44FD820575
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 13:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GGm1RAAE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44FD820575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOhus-0006hN-BT
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 09:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35525)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOhr6-00017p-OA
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:13:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOhr5-0008IC-Bi
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:13:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20079
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOhr5-0008HQ-84
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586956404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ibZMHqY7VVBiqZ3mvLxLuhOSrAfgg+Nwx5HDJ6BVu6w=;
 b=GGm1RAAEyxU3/czSOjWUqW5kuXdDU1M4NX7BBBQ3TEF4A/WL54LTVeALyVMYjigHv9lUI2
 EIaee9KvPYw/b1uu9hVrA7zcVFMOf+pZryjo0M60TINhZEnhzcHIJLvVbRXqD34BQ2mMrV
 1iDiwqHI8CU8V57Tb4syABLtlJNsvaE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-3skNEV2xNpiiHZsgH8BzdQ-1; Wed, 15 Apr 2020 09:13:23 -0400
X-MC-Unique: 3skNEV2xNpiiHZsgH8BzdQ-1
Received: by mail-ed1-f71.google.com with SMTP id p6so2854731edy.22
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 06:13:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=flOMpVa4daOpn0Dp6rxvKpXSYnzVHtaMyo1ihfc8A34=;
 b=klPcV5UbPPGxo3xzcl7QJe2/J6XVpPKv7NnpyOa/cPJGrujIfykZpK9SLbRpxyFbKZ
 2u7EaaYLL4cp0Hrj6fRQe0YfUfGXcutNI5iPk3xYEueVA1N6xoFa4dpFcvC0S7/rftuq
 wo+XRBAN6S0eF6S1Xi3Ryk7ojsnRDkA9oeZDlZzs3t0VBfoDvmo79fuz99/2vLchi89a
 3hZmV64NPx66Kzcdib4AgxkMB2l/VPeu9FeFfb9dwNnBWulEP1LPoPFXvxqqfHJLlA0l
 cVhWYKwYaaNx0bAMn3iEFMf+FeNT7GlrmLlnsSXW80lgCteUGvz40DoU8L9/B1IRJjng
 2thg==
X-Gm-Message-State: AGi0Pubw5vboVUF0W2/XNtpJbKsQEW1PHKhArjAgTfC+JjFfAT/B+BEk
 KB1KuyzSf4ElovRmWamQPbfS7f13UjzVulhLj3pY5jVlJeGkZX0FhpcR834x7cM0FWOY8HZRCls
 C7/mWYr/Q5r/A8T0=
X-Received: by 2002:a05:6402:1684:: with SMTP id
 a4mr8998665edv.99.1586956402067; 
 Wed, 15 Apr 2020 06:13:22 -0700 (PDT)
X-Google-Smtp-Source: APiQypKIML9fYp8+IXuLxVl2y3qUOtdSHhoqUx+qn43p/FbymszvkrGx9J/lDkgxYlPD0m6b8yagHg==
X-Received: by 2002:a05:6402:1684:: with SMTP id
 a4mr8998637edv.99.1586956401884; 
 Wed, 15 Apr 2020 06:13:21 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id c4sm814455edw.47.2020.04.15.06.13.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2020 06:13:21 -0700 (PDT)
Subject: Re: [PATCH v2 01/16] nvme: fix pci doorbell size calculation
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200415130159.611361-1-its@irrelevant.dk>
 <20200415130159.611361-2-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6570b2a5-7173-38f9-725d-394c0e5dac8d@redhat.com>
Date: Wed, 15 Apr 2020 15:13:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415130159.611361-2-its@irrelevant.dk>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/15/20 3:01 PM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> The size of the BAR is 0x1000 (main registers) + 8 bytes for each
> queue. Currently, the size of the BAR is calculated like so:
>=20
>      n->reg_size =3D pow2ceil(0x1004 + 2 * (n->num_queues + 1) * 4);
>=20
> Since the 'num_queues' parameter already accounts for the admin queue,
> this should in any case not need to be incremented by one. Also, the
> size should be initialized to (0x1000).
>=20
>      n->reg_size =3D pow2ceil(0x1000 + 2 * n->num_queues * 4);
>=20
> This, with the default value of num_queues (64), we will set aside room
> for 1 admin queue and 63 I/O queues (4 bytes per doorbell, 2 doorbells
> per queue).
>=20
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   hw/block/nvme.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index d28335cbf377..5b5f75c9d29e 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -43,6 +43,9 @@
>   #include "trace.h"
>   #include "nvme.h"
>  =20
> +#define NVME_REG_SIZE 0x1000
> +#define NVME_DB_SIZE  4
> +
>   #define NVME_GUEST_ERR(trace, fmt, ...) \
>       do { \
>           (trace_##trace)(__VA_ARGS__); \
> @@ -1345,7 +1348,9 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
>       pcie_endpoint_cap_init(pci_dev, 0x80);
>  =20
>       n->num_namespaces =3D 1;
> -    n->reg_size =3D pow2ceil(0x1004 + 2 * (n->num_queues + 1) * 4);
> +
> +    /* num_queues is really number of pairs, so each has two doorbells *=
/
> +    n->reg_size =3D pow2ceil(NVME_REG_SIZE + 2 * n->num_queues * NVME_DB=
_SIZE);

Unrelated to this change, but it would be cleaner to initialize reg_size=20
using MAX_NUM_QUEUES, then in the I/O handler log GUEST_ERROR when=20
registers > n->num_queues accessed. This would model closer to the hardware=
.

>       n->ns_size =3D bs_size / (uint64_t)n->num_namespaces;
>  =20
>       n->namespaces =3D g_new0(NvmeNamespace, n->num_namespaces);
>=20


