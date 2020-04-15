Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D614C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 11:04:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC39C20737
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 11:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="faXqH4wz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC39C20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOfpt-0000tJ-5r
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 07:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48453)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOfoj-0008PN-5y
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 07:02:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOfoh-0001fP-JL
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 07:02:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22655
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOfoh-0001eC-FV
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 07:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586948570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n9FoaaSs05INvUYWxcU/ZGnRrQ73/jnNFQ0MPEYRKPw=;
 b=faXqH4wzKVoc7g45r/WWANt3y7D6GHReU20zMgLO6JnrLgTcNX5GaEwhb1JrocwR1NDSyi
 Wdmsr2zWZvpMlRF8+91dtWBTEQBlX8Hr+lkG6emttm3hoTJLGVabnEXpulmXhxDDPqCZv3
 /sKTntQtPlxvKvLB8wq/DxvGRxOPF5k=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-Lq9uYC0APuudQZNTvfYb2w-1; Wed, 15 Apr 2020 07:02:49 -0400
X-MC-Unique: Lq9uYC0APuudQZNTvfYb2w-1
Received: by mail-ed1-f71.google.com with SMTP id c2so2562654edx.16
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 04:02:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=i2zptACXUBoC9HGGTTwkpghIWPRJa0Q3WXGyQescI8A=;
 b=Wc8v3OhkSdQOr9yJ14JCbx1tMn8bbFpECnhUF37OgOGL0qx/cPx2rcziiAapVJIkEK
 YSW1UQIwVqX2H4l0A04D7zc/GpcJQ2RjKOmoHFCUaDUpdUFcwkOLVAzawxv04TGsXRn6
 lWuFcLGCuzUDQ0xZNco2JNpkjXXdcFOVv4EXoOGATkFUuUlZb1MP/KsqJrP/lbDgZ4x6
 CAID/M43a5RJNbj9n8az/UYtYY9c+/DoVsGdjv08WnDqSJE5Q061TdiHvKYlTSBNefGT
 P2rpgNQJ1JxIRQ3lPC8nWoWqQYctnGF5dX2h1ZIoBJ4mjr25DIdh1pgkDe2dBjMqHo09
 wIJg==
X-Gm-Message-State: AGi0PuavhGeFvMuJfQka2zCggdTIsZRAhuc2OiwimgEiZixN/tigfMsx
 mu14dGFiYEok69DpgWMdEQOOkkw5k3kGF4xl+2ze2Ogpq5/gbR+wa/ZxRk72L2OyNzCw5+nZ3Nk
 4GK4G7hPtnj67a1A=
X-Received: by 2002:a17:907:20b5:: with SMTP id
 pw21mr4199358ejb.227.1586948568028; 
 Wed, 15 Apr 2020 04:02:48 -0700 (PDT)
X-Google-Smtp-Source: APiQypIvXZw+XCPlFZp1n1TQzKI6HhHVRI9vX3Ol2VXeuvAAkBU9Czi+N9B07oFfqVtMDQtRwlNOUw==
X-Received: by 2002:a17:907:20b5:: with SMTP id
 pw21mr4199304ejb.227.1586948567613; 
 Wed, 15 Apr 2020 04:02:47 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id t12sm2107915edy.57.2020.04.15.04.02.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2020 04:02:47 -0700 (PDT)
Subject: Re: [PATCH 07/16] nvme: add max_ioqpairs device parameter
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200415102445.564803-1-its@irrelevant.dk>
 <20200415102445.564803-8-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7a7e84ad-0f1d-2b56-6001-daa3403ec674@redhat.com>
Date: Wed, 15 Apr 2020 13:02:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415102445.564803-8-its@irrelevant.dk>
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
> The num_queues device paramater has a slightly confusing meaning because
> it accounts for the admin queue pair which is not really optional.
> Secondly, it is really a maximum value of queues allowed.
>=20
> Add a new max_ioqpairs parameter that only accounts for I/O queue pairs,
> but keep num_queues for compatibility.
>=20
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>   hw/block/nvme.c | 46 ++++++++++++++++++++++++++++------------------
>   hw/block/nvme.h |  4 +++-
>   2 files changed, 31 insertions(+), 19 deletions(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 287e1e49c0bf..9383d2cb0b38 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -19,7 +19,7 @@
>    *      -drive file=3D<file>,if=3Dnone,id=3D<drive_id>
>    *      -device nvme,drive=3D<drive_id>,serial=3D<serial>,id=3D<id[opti=
onal]>, \
>    *              cmb_size_mb=3D<cmb_size_mb[optional]>, \
> - *              num_queues=3D<N[optional]>
> + *              max_ioqpairs=3D<N[optional]>
>    *
>    * Note cmb_size_mb denotes size of CMB in MB. CMB is assumed to be at
>    * offset 0 in BAR2 and supports only WDS, RDS and SQS for now.
> @@ -27,6 +27,7 @@
>  =20
>   #include "qemu/osdep.h"
>   #include "qemu/units.h"
> +#include "qemu/error-report.h"
>   #include "hw/block/block.h"
>   #include "hw/pci/msix.h"
>   #include "hw/pci/pci.h"
> @@ -72,12 +73,12 @@ static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, =
void *buf, int size)
>  =20
>   static int nvme_check_sqid(NvmeCtrl *n, uint16_t sqid)
>   {
> -    return sqid < n->params.num_queues && n->sq[sqid] !=3D NULL ? 0 : -1=
;
> +    return sqid < n->params.max_ioqpairs + 1 && n->sq[sqid] !=3D NULL ? =
0 : -1;
>   }
>  =20
>   static int nvme_check_cqid(NvmeCtrl *n, uint16_t cqid)
>   {
> -    return cqid < n->params.num_queues && n->cq[cqid] !=3D NULL ? 0 : -1=
;
> +    return cqid < n->params.max_ioqpairs + 1 && n->cq[cqid] !=3D NULL ? =
0 : -1;
>   }
>  =20
>   static void nvme_inc_cq_tail(NvmeCQueue *cq)
> @@ -639,7 +640,7 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *=
cmd)
>           trace_nvme_dev_err_invalid_create_cq_addr(prp1);
>           return NVME_INVALID_FIELD | NVME_DNR;
>       }
> -    if (unlikely(vector > n->params.num_queues)) {
> +    if (unlikely(vector > n->params.max_ioqpairs + 1)) {
>           trace_nvme_dev_err_invalid_create_cq_vector(vector);
>           return NVME_INVALID_IRQ_VECTOR | NVME_DNR;
>       }
> @@ -791,8 +792,8 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd=
 *cmd, NvmeRequest *req)
>           trace_nvme_dev_getfeat_vwcache(result ? "enabled" : "disabled")=
;
>           break;
>       case NVME_NUMBER_OF_QUEUES:
> -        result =3D cpu_to_le32((n->params.num_queues - 2) |
> -                             ((n->params.num_queues - 2) << 16));
> +        result =3D cpu_to_le32((n->params.max_ioqpairs - 1) |
> +                             ((n->params.max_ioqpairs - 1) << 16));
>           trace_nvme_dev_getfeat_numq(result);
>           break;
>       case NVME_TIMESTAMP:
> @@ -836,10 +837,10 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
>       case NVME_NUMBER_OF_QUEUES:
>           trace_nvme_dev_setfeat_numq((dw11 & 0xFFFF) + 1,
>                                       ((dw11 >> 16) & 0xFFFF) + 1,
> -                                    n->params.num_queues - 1,
> -                                    n->params.num_queues - 1);
> -        req->cqe.result =3D cpu_to_le32((n->params.num_queues - 2) |
> -                                      ((n->params.num_queues - 2) << 16)=
);
> +                                    n->params.max_ioqpairs,
> +                                    n->params.max_ioqpairs);
> +        req->cqe.result =3D cpu_to_le32((n->params.max_ioqpairs - 1) |
> +                                      ((n->params.max_ioqpairs - 1) << 1=
6));
>           break;
>       case NVME_TIMESTAMP:
>           return nvme_set_feature_timestamp(n, cmd);
> @@ -910,12 +911,12 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
>  =20
>       blk_drain(n->conf.blk);
>  =20
> -    for (i =3D 0; i < n->params.num_queues; i++) {
> +    for (i =3D 0; i < n->params.max_ioqpairs + 1; i++) {
>           if (n->sq[i] !=3D NULL) {
>               nvme_free_sq(n->sq[i], n);
>           }
>       }
> -    for (i =3D 0; i < n->params.num_queues; i++) {
> +    for (i =3D 0; i < n->params.max_ioqpairs + 1; i++) {
>           if (n->cq[i] !=3D NULL) {
>               nvme_free_cq(n->cq[i], n);
>           }
> @@ -1316,8 +1317,17 @@ static void nvme_realize(PCIDevice *pci_dev, Error=
 **errp)
>       int64_t bs_size;
>       uint8_t *pci_conf;
>  =20
> -    if (!n->params.num_queues) {
> -        error_setg(errp, "num_queues can't be zero");
> +    if (n->params.num_queues) {
> +        warn_report("num_queues is deprecated; please use max_ioqpairs "
> +                    "instead");
> +
> +        n->params.max_ioqpairs =3D n->params.num_queues - 1;
> +    }
> +
> +    if (n->params.max_ioqpairs < 1 ||
> +        n->params.max_ioqpairs > PCI_MSIX_FLAGS_QSIZE) {
> +        error_setg(errp, "max_ioqpairs must be between 1 and %d",
> +                   PCI_MSIX_FLAGS_QSIZE);
>           return;
>       }
>  =20
> @@ -1349,19 +1359,19 @@ static void nvme_realize(PCIDevice *pci_dev, Erro=
r **errp)
>       pcie_endpoint_cap_init(pci_dev, 0x80);
>  =20
>       n->num_namespaces =3D 1;
> -    n->reg_size =3D pow2ceil(0x1000 + 2 * n->params.num_queues * 4);
> +    n->reg_size =3D pow2ceil(0x1008 + 2 * (n->params.max_ioqpairs) * 4);
>       n->ns_size =3D bs_size / (uint64_t)n->num_namespaces;
>  =20
>       n->namespaces =3D g_new0(NvmeNamespace, n->num_namespaces);
> -    n->sq =3D g_new0(NvmeSQueue *, n->params.num_queues);
> -    n->cq =3D g_new0(NvmeCQueue *, n->params.num_queues);
> +    n->sq =3D g_new0(NvmeSQueue *, n->params.max_ioqpairs + 1);
> +    n->cq =3D g_new0(NvmeCQueue *, n->params.max_ioqpairs + 1);
>  =20
>       memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n,
>                             "nvme", n->reg_size);
>       pci_register_bar(pci_dev, 0,
>           PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64,
>           &n->iomem);
> -    msix_init_exclusive_bar(pci_dev, n->params.num_queues, 4, NULL);
> +    msix_init_exclusive_bar(pci_dev, n->params.max_ioqpairs + 1, 4, NULL=
);
>  =20
>       id->vid =3D cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
>       id->ssvid =3D cpu_to_le16(pci_get_word(pci_conf + PCI_SUBSYSTEM_VEN=
DOR_ID));
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index 9957c4a200e2..98f5b9479244 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -6,11 +6,13 @@
>   #define DEFINE_NVME_PROPERTIES(_state, _props) \
>       DEFINE_PROP_STRING("serial", _state, _props.serial), \
>       DEFINE_PROP_UINT32("cmb_size_mb", _state, _props.cmb_size_mb, 0), \
> -    DEFINE_PROP_UINT32("num_queues", _state, _props.num_queues, 64)
> +    DEFINE_PROP_UINT32("num_queues", _state, _props.num_queues, 0), \
> +    DEFINE_PROP_UINT32("max_ioqpairs", _state, _props.max_ioqpairs, 64)
>  =20
>   typedef struct NvmeParams {
>       char     *serial;
>       uint32_t num_queues;

I'm tempted to rename it 'deprecated_num_queues' ... Can you add a=20
comment such /* deprecated since 5.0 */?

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +    uint32_t max_ioqpairs;
>       uint32_t cmb_size_mb;
>   } NvmeParams;
>  =20
>=20


