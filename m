Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79720C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:53:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4496B20737
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L/M0zzxy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4496B20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOffH-0000Xn-Ex
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 06:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47061)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOfei-0008Ga-2E
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:52:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOfeg-0004o7-OV
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:52:31 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40141
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOfeg-0004na-LL
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586947950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mK08CPN7IHrzcQvykjcxyQ81hnxGB/iCSSS68h1aqXE=;
 b=L/M0zzxyED4Xoco8ILlP9Uh4uSAqw6qzePtiBpgmq3ZIY+Uuf/BBRJ/JPnhAwHc1fKtxFU
 GpVd0QnWOmacA9AW9Du9s9aPjdJyWpHzNTqB0gTAes+3ISDuu2TjbDLPpvbGqxnCTyvWBX
 DMxkBo/H1giH1zXmrYLq6LBn2VaNLgU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-ioXypyVVPaSez_jse41iIw-1; Wed, 15 Apr 2020 06:52:28 -0400
X-MC-Unique: ioXypyVVPaSez_jse41iIw-1
Received: by mail-ed1-f69.google.com with SMTP id i61so2585141edc.2
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 03:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NT/3XJjKl/vFM+tG5mU1zi30QhQybHMcw8eBken1LTk=;
 b=A1kcGN3cdf/SgpYQsfcbcepa8sFQdV4sRGvCbmAdvUa8OCVYnD1UaLkaAFicP8vO5F
 p6QRXG9suQTO32w7XmJ0CNLWRMOn6leX4L2NVhKkuN4ZPR9eauUjZgYDZz5sYIC0DS0J
 042i9/vL+2kL1j3gV25BeNWpMoEUnbTKOj1P29288pW94cDgx51TQcvEioGyBimTCovC
 ttrQEUT9p2oUg7hZC5OFEVbzIBPQwlY8sSgyQSuzdetCbfeXwtlG/CPxJKR++iRLKy5q
 FVpeMLkNXNAo39Dib9RlzMm9lw1wKOJsoiUegV0j8YxIDY/mUnkWwMctowUqvRoBUHvF
 Zh8g==
X-Gm-Message-State: AGi0PuZrLNIYZz2On8XTI/M+oB9qQOxons4ed1exSH4d+sL+hO1jj4jD
 oCpdgmriSwYDbqhAH+HEv5kdhzMgUUsHNWv94wq4W2Po3oiSlAC2vxYM/ACNOZFAhlJuheXTJ4X
 V2U5/Lh9iTVNrMuE=
X-Received: by 2002:a50:ee10:: with SMTP id g16mr17159236eds.111.1586947947312; 
 Wed, 15 Apr 2020 03:52:27 -0700 (PDT)
X-Google-Smtp-Source: APiQypL/C7MIJORARa6bEHapV1asqS3mSX+1R5u2Oh3nkiaRgokxVzmT9gUpyaol3GIP79BXtJeBzQ==
X-Received: by 2002:a50:ee10:: with SMTP id g16mr17159216eds.111.1586947947113; 
 Wed, 15 Apr 2020 03:52:27 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id l19sm2577117ejn.31.2020.04.15.03.52.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2020 03:52:26 -0700 (PDT)
Subject: Re: [PATCH 11/16] nvme: factor out block backend setup
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200415102445.564803-1-its@irrelevant.dk>
 <20200415102445.564803-12-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1557e920-2869-4e62-f996-30172ce82e0e@redhat.com>
Date: Wed, 15 Apr 2020 12:52:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415102445.564803-12-its@irrelevant.dk>
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
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>   hw/block/nvme.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index e67f578fbf79..f0989cbb4335 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1348,6 +1348,17 @@ static void nvme_init_state(NvmeCtrl *n)
>       n->cq =3D g_new0(NvmeCQueue *, n->params.max_ioqpairs + 1);
>   }
>  =20
> +static int nvme_init_blk(NvmeCtrl *n, Error **errp)
> +{
> +    blkconf_blocksizes(&n->conf);
> +    if (!blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->con=
f.blk),
> +                                       false, errp)) {
> +        return -1;
> +    }
> +
> +    return 0;

I'm not sure this is a correct usage of the 'propagating errors' API=20
(see CODING_STYLE.rst and include/qapi/error.h), I'd expect this=20
function to return void, and use a local_error & error_propagate() in=20
nvme_realize().

However this works, so:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +}
> +
>   static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>   {
>       NvmeCtrl *n =3D NVME(pci_dev);
> @@ -1369,9 +1380,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
>           return;
>       }
>  =20
> -    blkconf_blocksizes(&n->conf);
> -    if (!blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->con=
f.blk),
> -                                       false, errp)) {
> +    if (nvme_init_blk(n, errp)) {
>           return;
>       }
>  =20
>=20


