Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B156C2BB55
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 13:15:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D2F620575
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 13:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bktu4vg8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D2F620575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOhtU-0004j9-I9
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 09:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34973)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOhnU-0003II-BE
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:09:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOhnT-0006oa-8a
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:09:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26468
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOhnT-0006oQ-5C
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586956182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fLMPmt7njuanWRNTWhXP+9mSBXTYEydgmqKlTxHXCfU=;
 b=bktu4vg8+i0+bVfN66+Ub0M5w4DDvG4CFaG1+WFEHEp6k20I8RcQE33FLQapPsWMCZbvTk
 qD4Q8kOzXEjqraAwBdG657UDZpME0u5RZFxGmMTI4i5EHHmxyqY9zVjShQrWTvs0tltpuw
 HSyswq6xD2xL4jjy1SFL39ON7erA6os=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-qJyNVDgrN3qyq0WCLHJ1xA-1; Wed, 15 Apr 2020 09:09:41 -0400
X-MC-Unique: qJyNVDgrN3qyq0WCLHJ1xA-1
Received: by mail-wr1-f69.google.com with SMTP id h95so10504134wrh.11
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 06:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nycj3YGPL3m8ifd7HKptJxrhLfJPaviIpGNpnjlOEvw=;
 b=EQvahnobh4ONWQqVaLrRkGTAB0fYo0bCaH3EGmksAIbKJ9ajt33vieP70VoRi0Liv/
 sfbQG4QkF173EH7P/1UEWvjWevY4BZFqiE6BJDQerquVAiqVnC/biTrJ0id1zuvXCDlZ
 q+ION1R9oJJts3w2mdL9qK/3JQUWF+2W/PXSNi8ooKwMHhXnD96cd2I/05AhC7nnAsZP
 yuBds6E7NrztcMVtzYFva8tCec0QITzbSTTxblQ79E6iyrxy38WPbHNQYssepaN+ShcC
 eOEP6Lmi2IbtJ4cExIBX4ZhkJuCBJu6uxLjP3/VjKTnXd3rbGP5UlJ8cmQ3ZpAqovhXk
 +4Rg==
X-Gm-Message-State: AGi0PuZfb+72Mond6NCA9xHiIFFtRU0WGTVZ8fvOD0tYWjMFfgxYf/ge
 4ka0RLJ8YHAGQbnkb+dEYK8FxKiydGuFiZcpFDmdwMQHG80Bj5LjaR0tH/0eYn9UZGtUy/VUFe9
 EPUidFY8EI51DYfA=
X-Received: by 2002:a1c:2e07:: with SMTP id u7mr5169954wmu.74.1586956179424;
 Wed, 15 Apr 2020 06:09:39 -0700 (PDT)
X-Google-Smtp-Source: APiQypK+nTdxUkBt/LiO8WQqdPX/zXZILBMjvCcghJDCFm5YDJZoAwwIu2kJb5CwBdbzfyAVdj/wsg==
X-Received: by 2002:a1c:2e07:: with SMTP id u7mr5169933wmu.74.1586956179214;
 Wed, 15 Apr 2020 06:09:39 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id p10sm22623316wrm.6.2020.04.15.06.09.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2020 06:09:38 -0700 (PDT)
Subject: Re: [PATCH v2 12/16] nvme: add namespace helpers
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200415130159.611361-1-its@irrelevant.dk>
 <20200415130159.611361-13-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <61bb042c-6e4d-8038-acb8-2be364d00367@redhat.com>
Date: Wed, 15 Apr 2020 15:09:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415130159.611361-13-its@irrelevant.dk>
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
> Introduce some small helpers to make the next patches easier on the eye.
>=20
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>   hw/block/nvme.c |  3 +--
>   hw/block/nvme.h | 16 ++++++++++++++++
>   2 files changed, 17 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 80da0825d295..d5244102252c 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1469,8 +1469,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
>           id_ns->dps =3D 0;
>           id_ns->lbaf[0].ds =3D BDRV_SECTOR_BITS;
>           id_ns->ncap  =3D id_ns->nuse =3D id_ns->nsze =3D
> -            cpu_to_le64(n->ns_size >>
> -                id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas)].ds)=
;
> +            cpu_to_le64(nvme_ns_nlbas(n, ns));

Thanks :)

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>       }
>   }
>  =20
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index 7eecfd3a50f6..dd932a9e7ebc 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -67,6 +67,17 @@ typedef struct NvmeNamespace {
>       NvmeIdNs        id_ns;
>   } NvmeNamespace;
>  =20
> +static inline NvmeLBAF *nvme_ns_lbaf(NvmeNamespace *ns)
> +{
> +    NvmeIdNs *id_ns =3D &ns->id_ns;
> +    return &id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(id_ns->flbas)];
> +}
> +
> +static inline uint8_t nvme_ns_lbads(NvmeNamespace *ns)
> +{
> +    return nvme_ns_lbaf(ns)->ds;
> +}
> +
>   #define TYPE_NVME "nvme"
>   #define NVME(obj) \
>           OBJECT_CHECK(NvmeCtrl, (obj), TYPE_NVME)
> @@ -101,4 +112,9 @@ typedef struct NvmeCtrl {
>       NvmeIdCtrl      id_ctrl;
>   } NvmeCtrl;
>  =20
> +static inline uint64_t nvme_ns_nlbas(NvmeCtrl *n, NvmeNamespace *ns)
> +{
> +    return n->ns_size >> nvme_ns_lbads(ns);
> +}
> +
>   #endif /* HW_NVME_H */
>=20


