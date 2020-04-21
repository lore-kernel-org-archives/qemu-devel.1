Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76217C54FCC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 16:11:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BD072068F
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 16:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gviLagxQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BD072068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQvV0-0002h9-OH
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 12:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52102)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jQvUD-00021H-JA
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 12:11:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jQvUC-0003Ms-Tt
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 12:11:01 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23354
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jQvUC-0003Lr-FL
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 12:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587485459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WTlSwMR2/VXxlsS6kTQmrLZJXkoGEE1hbCYUv9Foq7E=;
 b=gviLagxQsmn2KIOgleCiUOlmkUk1KRgIwPJ9bFJl9Kl8WmrGdUmz4wpEt+L4Lo6rdSEdZj
 eCrxh0qdEI13GAzqzGhBpqvMaa4+ja/YEevkoN7AswpxMMd1c14+F4PawpvcgJw21j873r
 JqwWG1PQfZFqwqDAgAXzumKhVEUy2Ko=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25--95zV-cMOper4PYxFcRRkg-1; Tue, 21 Apr 2020 12:10:55 -0400
X-MC-Unique: -95zV-cMOper4PYxFcRRkg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF7B1DB2A;
 Tue, 21 Apr 2020 16:10:53 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BF0C5A18BB;
 Tue, 21 Apr 2020 16:10:50 +0000 (UTC)
Message-ID: <0a690b61abc81d68c4986f6840f5b21abb40a199.camel@redhat.com>
Subject: Re: [PATCH v2 15/16] nvme: factor out cmb setup
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Tue, 21 Apr 2020 19:10:49 +0300
In-Reply-To: <20200415130159.611361-16-its@irrelevant.dk>
References: <20200415130159.611361-1-its@irrelevant.dk>
 <20200415130159.611361-16-its@irrelevant.dk>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 01:28:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2020-04-15 at 15:01 +0200, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/block/nvme.c | 49 +++++++++++++++++++++++++++----------------------
>  1 file changed, 27 insertions(+), 22 deletions(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 906ae595025a..4c28d75e0fc8 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -46,6 +46,7 @@
> =20
>  #define NVME_REG_SIZE 0x1000
>  #define NVME_DB_SIZE  4
> +#define NVME_CMB_BIR 2
> =20
>  #define NVME_GUEST_ERR(trace, fmt, ...) \
>      do { \
> @@ -1379,6 +1380,28 @@ static void nvme_init_namespace(NvmeCtrl *n, NvmeN=
amespace *ns, Error **errp)
>      id_ns->nuse =3D id_ns->ncap;
>  }
> =20
> +static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
> +{
> +    NVME_CMBLOC_SET_BIR(n->bar.cmbloc, NVME_CMB_BIR);
> +    NVME_CMBLOC_SET_OFST(n->bar.cmbloc, 0);
> +
> +    NVME_CMBSZ_SET_SQS(n->bar.cmbsz, 1);
> +    NVME_CMBSZ_SET_CQS(n->bar.cmbsz, 0);
> +    NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 0);
> +    NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
> +    NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
> +    NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2); /* MBs */
> +    NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->params.cmb_size_mb);
> +
> +    n->cmbuf =3D g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
> +    memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n,
> +                          "nvme-cmb", NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
> +    pci_register_bar(pci_dev, NVME_CMBLOC_BIR(n->bar.cmbloc),
> +                     PCI_BASE_ADDRESS_SPACE_MEMORY |
> +                     PCI_BASE_ADDRESS_MEM_TYPE_64 |
> +                     PCI_BASE_ADDRESS_MEM_PREFETCH, &n->ctrl_mem);
> +}
> +
>  static void nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev)
>  {
>      uint8_t *pci_conf =3D pci_dev->config;
> @@ -1393,6 +1416,10 @@ static void nvme_init_pci(NvmeCtrl *n, PCIDevice *=
pci_dev)
>      pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
>                       PCI_BASE_ADDRESS_MEM_TYPE_64, &n->iomem);
>      msix_init_exclusive_bar(pci_dev, n->params.max_ioqpairs + 1, 4, NULL=
);
> +
> +    if (n->params.cmb_size_mb) {
> +        nvme_init_cmb(n, pci_dev);
> +    }
>  }
> =20
>  static void nvme_realize(PCIDevice *pci_dev, Error **errp)
> @@ -1454,28 +1481,6 @@ static void nvme_realize(PCIDevice *pci_dev, Error=
 **errp)
>      n->bar.vs =3D 0x00010200;
>      n->bar.intmc =3D n->bar.intms =3D 0;
> =20
> -    if (n->params.cmb_size_mb) {
> -
> -        NVME_CMBLOC_SET_BIR(n->bar.cmbloc, 2);
> -        NVME_CMBLOC_SET_OFST(n->bar.cmbloc, 0);
> -
> -        NVME_CMBSZ_SET_SQS(n->bar.cmbsz, 1);
> -        NVME_CMBSZ_SET_CQS(n->bar.cmbsz, 0);
> -        NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 0);
> -        NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
> -        NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
> -        NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2); /* MBs */
> -        NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->params.cmb_size_mb);
> -
> -        n->cmbuf =3D g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
> -        memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n,
> -                              "nvme-cmb", NVME_CMBSZ_GETSIZE(n->bar.cmbs=
z));
> -        pci_register_bar(pci_dev, NVME_CMBLOC_BIR(n->bar.cmbloc),
> -            PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64=
 |
> -            PCI_BASE_ADDRESS_MEM_PREFETCH, &n->ctrl_mem);
> -
> -    }
> -
>      for (i =3D 0; i < n->num_namespaces; i++) {
>          nvme_init_namespace(n, &n->namespaces[i], &err);
>          if (err) {

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
=09Maxim Levitsky


