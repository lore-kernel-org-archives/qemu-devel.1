Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD622C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:57:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9786120737
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QFzzY7v+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9786120737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOfjU-0004FJ-PF
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 06:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOfid-000355-Pe
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:56:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOfic-00021a-Ku
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:56:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39203
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOfic-000210-Hu
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586948194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aWLqunhliYycN+b/k7XTOIb3oxzGjKxAaoIPQlN+1Zo=;
 b=QFzzY7v+/utzTQWG1QTeIXfLei6Zq7vorTccvOIVD6pVTa3ByaKSbo5q0QbUZNM3YBIKWg
 2s5F+IhVXYxOBF6qVfSj/v3Flk8papJSyVJ0jCGc0FUQI3Ql9gOk7a6zo82lvEPFxZiy1m
 rh8k7Vsj0s9C4MC6SzcenLBQxKRS7Zc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-XxkKHm6FPtiFz5JQjMl8TA-1; Wed, 15 Apr 2020 06:56:31 -0400
X-MC-Unique: XxkKHm6FPtiFz5JQjMl8TA-1
Received: by mail-ed1-f71.google.com with SMTP id l25so2613683edt.1
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 03:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=R/RAtG79RvZSv4hzNcH30eK0xKw1T49UmiKRn/hsZwA=;
 b=PhDuiTXMvAq+C0xzxJzMNsNqaeBWXU+4yrcJBE3iga8SmKZnLdafZASXR5HB3e7TP0
 pYGf5Mdv5GKGXWQwTso6q0iO4yZmJqq52SioMeV97JT2kxHJeR2rePlW7wbFta8wTBqL
 wUmXvsKUJXsnqbmZwNMisal3IquTakTCWLvvVDxc2/TkrQ7ByzLiKr8pB63qCucoj7QO
 ZyZ3YWQrJjpRpA0kfR2E1MJdpkv/YZSkj7oCQllNjSj/MfAehmX0ZS/E6/RBkMdUCclg
 eCVRlmbTE74fG9U8o9NjhBJV2xMYLuFNwpQtnsj35FagfJn6A4EWGwMJ/EmJhLlFEwDs
 giCA==
X-Gm-Message-State: AGi0PuZqKQjtBedwgFDH412e2dW1vDxZHMUHii1LSQ5UyBa46/b9+Jjl
 VzH3kObIlsmzLyLBFPAiR0Z5pG7DHiCt+bDeq+xOQ/sOtELWZJUw7B6Apsj9xQg4SJ9tgE8xk5t
 xtoQ4FU6jRDDZgOw=
X-Received: by 2002:a17:906:2418:: with SMTP id
 z24mr4387782eja.42.1586948190301; 
 Wed, 15 Apr 2020 03:56:30 -0700 (PDT)
X-Google-Smtp-Source: APiQypIwGdlynmyXYaWh4ZWjJv6dR61T48ZWbrU/ixs9ENrGjew+59fz1z4B+lydifV4N0cMw3ah4Q==
X-Received: by 2002:a17:906:2418:: with SMTP id
 z24mr4387765eja.42.1586948190014; 
 Wed, 15 Apr 2020 03:56:30 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id k24sm2535197ejv.15.2020.04.15.03.56.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2020 03:56:29 -0700 (PDT)
Subject: Re: [PATCH 09/16] nvme: factor out property/constraint checks
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200415102445.564803-1-its@irrelevant.dk>
 <20200415102445.564803-10-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9f6d453c-b74e-15fd-54c0-87eaf52520fe@redhat.com>
Date: Wed, 15 Apr 2020 12:56:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415102445.564803-10-its@irrelevant.dk>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
>   hw/block/nvme.c | 52 ++++++++++++++++++++++++++++++-------------------
>   1 file changed, 32 insertions(+), 20 deletions(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index ea613213bd57..635292d6fac4 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1308,6 +1308,37 @@ static const MemoryRegionOps nvme_cmb_ops =3D {
>       },
>   };
>  =20
> +static int nvme_check_constraints(NvmeCtrl *n, Error **errp)
> +{
> +    NvmeParams *params =3D &n->params;
> +
> +    if (params->num_queues) {
> +        warn_report("num_queues is deprecated; please use max_ioqpairs "
> +                    "instead");
> +
> +        params->max_ioqpairs =3D params->num_queues - 1;
> +    }
> +
> +    if (params->max_ioqpairs < 1 ||
> +        params->max_ioqpairs > PCI_MSIX_FLAGS_QSIZE) {
> +        error_setg(errp, "max_ioqpairs must be between 1 and %d",
> +                   PCI_MSIX_FLAGS_QSIZE);
> +        return -1;
> +    }
> +
> +    if (!n->conf.blk) {
> +        error_setg(errp, "drive property not set");
> +        return -1;
> +    }
> +
> +    if (!params->serial) {
> +        error_setg(errp, "serial property not set");
> +        return -1;
> +    }
> +
> +    return 0;

Similar comment than nvme_init_blk(), I'd expect this
function to return void, and use a local_error & error_propagate() in
nvme_realize().

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +}
> +
>   static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>   {
>       NvmeCtrl *n =3D NVME(pci_dev);
> @@ -1317,22 +1348,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error=
 **errp)
>       int64_t bs_size;
>       uint8_t *pci_conf;
>  =20
> -    if (n->params.num_queues) {
> -        warn_report("num_queues is deprecated; please use max_ioqpairs "
> -                    "instead");
> -
> -        n->params.max_ioqpairs =3D n->params.num_queues - 1;
> -    }
> -
> -    if (n->params.max_ioqpairs < 1 ||
> -        n->params.max_ioqpairs > PCI_MSIX_FLAGS_QSIZE) {
> -        error_setg(errp, "max_ioqpairs must be between 1 and %d",
> -                   PCI_MSIX_FLAGS_QSIZE);
> -        return;
> -    }
> -
> -    if (!n->conf.blk) {
> -        error_setg(errp, "drive property not set");
> +    if (nvme_check_constraints(n, errp)) {
>           return;
>       }
>  =20
> @@ -1342,10 +1358,6 @@ static void nvme_realize(PCIDevice *pci_dev, Error=
 **errp)
>           return;
>       }
>  =20
> -    if (!n->params.serial) {
> -        error_setg(errp, "serial property not set");
> -        return;
> -    }
>       blkconf_blocksizes(&n->conf);
>       if (!blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->co=
nf.blk),
>                                          false, errp)) {
>=20


