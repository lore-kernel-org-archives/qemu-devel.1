Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A915EC54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 14:56:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E8AE206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 14:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RSqbnSzw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E8AE206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQuJa-0006yc-Pc
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 10:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39482)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jQuIs-0006Oh-Uq
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 10:55:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jQuIs-0003h7-Cv
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 10:55:14 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25408
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jQuIs-0003gE-0o
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 10:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587480913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3c9X9Lie0Os1deBdEguvPrAmP9B6q6G/8Qi3ekbHtOY=;
 b=RSqbnSzw2CMWiwVsmGOzIjGScJpepLQIRs1S67SBIM1sM4zxgsxAaGKiOzfT9SiXRwcfjM
 7mf1DoFp2MGRMBxxUZnThFfpU2Hl22LnBMOXmOLgQvwysdJNr3a8Cy4H8b/gsqyuDjVtzT
 nGWaTBC1mze6eqYFG2vNLbaZwCKehQs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-Gk7ylJgSPoSUTcFWWsfgCg-1; Tue, 21 Apr 2020 10:55:11 -0400
X-MC-Unique: Gk7ylJgSPoSUTcFWWsfgCg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48DBF107ACCA;
 Tue, 21 Apr 2020 14:55:10 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B454B19C70;
 Tue, 21 Apr 2020 14:55:07 +0000 (UTC)
Message-ID: <bc10b4b9c194fa2430405e2311a5572d6b696d1e.camel@redhat.com>
Subject: Re: [PATCH v2 10/16] nvme: factor out device state setup
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Tue, 21 Apr 2020 17:55:06 +0300
In-Reply-To: <20200415130159.611361-11-its@irrelevant.dk>
References: <20200415130159.611361-1-its@irrelevant.dk>
 <20200415130159.611361-11-its@irrelevant.dk>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 03:31:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
>  hw/block/nvme.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 5f9ebbd6a1d5..45a352b63d89 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1340,6 +1340,17 @@ static void nvme_check_constraints(NvmeCtrl *n, Er=
ror **errp)
>      }
>  }
> =20
> +static void nvme_init_state(NvmeCtrl *n)
> +{
> +    n->num_namespaces =3D 1;
> +    /* add one to max_ioqpairs to account for the admin queue pair */
> +    n->reg_size =3D pow2ceil(NVME_REG_SIZE +
> +                           2 * (n->params.max_ioqpairs + 1) * NVME_DB_SI=
ZE);
> +    n->namespaces =3D g_new0(NvmeNamespace, n->num_namespaces);
> +    n->sq =3D g_new0(NvmeSQueue *, n->params.max_ioqpairs + 1);
> +    n->cq =3D g_new0(NvmeCQueue *, n->params.max_ioqpairs + 1);
> +}
> +
>  static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>  {
>      NvmeCtrl *n =3D NVME(pci_dev);
> @@ -1356,6 +1367,8 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
>          return;
>      }
> =20
> +    nvme_init_state(n);
> +
>      bs_size =3D blk_getlength(n->conf.blk);
>      if (bs_size < 0) {
>          error_setg(errp, "could not get backing file size");
> @@ -1374,17 +1387,8 @@ static void nvme_realize(PCIDevice *pci_dev, Error=
 **errp)
>      pci_config_set_class(pci_dev->config, PCI_CLASS_STORAGE_EXPRESS);
>      pcie_endpoint_cap_init(pci_dev, 0x80);
> =20
> -    n->num_namespaces =3D 1;
> -
> -    /* add one to max_ioqpairs to account for the admin queue pair */
> -    n->reg_size =3D pow2ceil(NVME_REG_SIZE +
> -                           2 * (n->params.max_ioqpairs + 1) * NVME_DB_SI=
ZE);
>      n->ns_size =3D bs_size / (uint64_t)n->num_namespaces;
> =20
> -    n->namespaces =3D g_new0(NvmeNamespace, n->num_namespaces);
> -    n->sq =3D g_new0(NvmeSQueue *, n->params.max_ioqpairs + 1);
> -    n->cq =3D g_new0(NvmeCQueue *, n->params.max_ioqpairs + 1);
> -
>      memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n,
>                            "nvme", n->reg_size);
>      pci_register_bar(pci_dev, 0,

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
=09Maxim Levitsky


