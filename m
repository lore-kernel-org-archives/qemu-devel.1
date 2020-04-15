Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F5FC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 13:14:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B78792074F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 13:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hkxQbBEY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B78792074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOhrj-0001qD-Ox
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 09:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOhmq-0001gN-HE
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:09:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOhmp-0006da-GU
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:09:04 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33398
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOhmp-0006dK-Cr
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586956142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QiDBNnQG1uzK2Vm9GELAOknE819NdQfSTdybdbZmQ3U=;
 b=hkxQbBEY4OZgtbnGTM9jMXhrAVZ4Et53bf9PbpdTQ0GyCutAu99EKGl8qTVV3878GdFngJ
 KQgwwPCM4/3/RHQ2DizZzFBsyeuUACsndzH315y8C5cT7f8zRORChJJBe9kQtW5Q1wnwtv
 EVJ+msrTopkW3Jb8IdEpreGkjefAvGs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-8RX4rtX3OX6fwMFSLI5cMg-1; Wed, 15 Apr 2020 09:09:01 -0400
X-MC-Unique: 8RX4rtX3OX6fwMFSLI5cMg-1
Received: by mail-wr1-f72.google.com with SMTP id v14so10556438wrq.13
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 06:09:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DJcgCPWagtcPKFcXYDUtCdAw0ueYLMcAFCJqfQ5kJn0=;
 b=lvbg73QYiaM9d4ykaCKE6U/IFkl1yVcWHmCmq6oKknCz/wcRQP8Ev25DahY36+iYGF
 tRFXpx7h9fm6V/iIbkWdkoEITX561Lui/C7xdGPUV5oVE5LqvpFvD9/UJaf+4nFqSrwM
 4VvjHI7PnD8ifPtWdheZawNynbRpo5IJUKaSXfXZ+IMGF8wcSAhmXvFKsaX3f9FXG1em
 OsXL8zG0xvTkB8O7d9sOIf9y6WyCukokvcL7WpDV5e78Ir4GpK6fqJX8eoxjB2paa8Gb
 nu/wCihoUzdKvQAYQ9n5eBES/LZkHnGHoBZprYm3+Fsthtusq+kcXyhFnYL3BEKN8Zdr
 Lbew==
X-Gm-Message-State: AGi0PuZD4ZJYYV4I/u/LzJlNhORXZ3ASFGSigmWW7W33ChZWZGF9TGcQ
 mq92j/MViC32uzoEk/BCoVJmz8ZrVtgtThXZ9keRXrYRTWB1FNgjWZhM5Te6u7cjJmRbXM6/BeQ
 oAsghIRjQL393DTs=
X-Received: by 2002:a1c:9aca:: with SMTP id c193mr5013523wme.38.1586956140345; 
 Wed, 15 Apr 2020 06:09:00 -0700 (PDT)
X-Google-Smtp-Source: APiQypJBGohX3CjtvOj9c4vcr7D2Pv4Bn/u5Fb1C36PhlmxXy1r0eiEB5WRKwh5vENfhFaYFvi4Agw==
X-Received: by 2002:a1c:9aca:: with SMTP id c193mr5013509wme.38.1586956140147; 
 Wed, 15 Apr 2020 06:09:00 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id z10sm21258313wrg.69.2020.04.15.06.08.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2020 06:08:59 -0700 (PDT)
Subject: Re: [PATCH v2 11/16] nvme: factor out block backend setup
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200415130159.611361-1-its@irrelevant.dk>
 <20200415130159.611361-12-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b8eff0ea-485f-1f07-a0d0-3bba1ca2e526@redhat.com>
Date: Wed, 15 Apr 2020 15:08:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415130159.611361-12-its@irrelevant.dk>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>   hw/block/nvme.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 45a352b63d89..80da0825d295 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1351,6 +1351,13 @@ static void nvme_init_state(NvmeCtrl *n)
>       n->cq =3D g_new0(NvmeCQueue *, n->params.max_ioqpairs + 1);
>   }
>  =20
> +static void nvme_init_blk(NvmeCtrl *n, Error **errp)
> +{
> +    blkconf_blocksizes(&n->conf);
> +    blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->conf.blk=
),
> +                                  false, errp);

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +}
> +
>   static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>   {
>       NvmeCtrl *n =3D NVME(pci_dev);
> @@ -1375,9 +1382,9 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
>           return;
>       }
>  =20
> -    blkconf_blocksizes(&n->conf);
> -    if (!blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->con=
f.blk),
> -                                       false, errp)) {
> +    nvme_init_blk(n, &err);
> +    if (err) {
> +        error_propagate(errp, err);
>           return;
>       }
>  =20
>=20


