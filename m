Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B13BC54FCC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 16:19:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DC5D206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 16:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MzLR6Dwj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DC5D206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQvcC-0007jv-1p
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 12:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53420)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jQvb2-0006yD-Ph
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 12:18:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jQvb1-00027M-3R
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 12:18:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57416
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jQvb0-000245-JI
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 12:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587485880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s9RUa2+/PnIlhp2nZsCbYs49UgwZWbk4dDDEzyLojno=;
 b=MzLR6DwjDmwSSjBi8Dw0E9+p6T9Hde9N68Qfhrz1ixczmKbrJZ/qy0q80W2JEZTrLL/Ftx
 yO/brdxIHP7BjCnOa9CE9Sa3b5B+qMYIvYdhWWez3Y7No4eFjBKsJPDl9KNhmozA/OHOJS
 VhW6HX2+025TKRE6+kcnY+42idbo2nc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-Zm8i_iK6OcS_vimrTrt8Gw-1; Tue, 21 Apr 2020 12:17:58 -0400
X-MC-Unique: Zm8i_iK6OcS_vimrTrt8Gw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D7C58017F3;
 Tue, 21 Apr 2020 16:17:57 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5FC61B3A70;
 Tue, 21 Apr 2020 16:17:54 +0000 (UTC)
Message-ID: <35f02c3252a0db2292344f7a3946aca606d9af5f.camel@redhat.com>
Subject: Re: [PATCH v2 16/16] nvme: factor out controller identify setup
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Tue, 21 Apr 2020 19:17:53 +0300
In-Reply-To: <20200415130159.611361-17-its@irrelevant.dk>
References: <20200415130159.611361-1-its@irrelevant.dk>
 <20200415130159.611361-17-its@irrelevant.dk>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
>  hw/block/nvme.c | 52 +++++++++++++++++++++++++++----------------------
>  1 file changed, 29 insertions(+), 23 deletions(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 4c28d75e0fc8..804f24719dce 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1422,32 +1422,11 @@ static void nvme_init_pci(NvmeCtrl *n, PCIDevice =
*pci_dev)
>      }
>  }
> =20
> -static void nvme_realize(PCIDevice *pci_dev, Error **errp)
> +static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
>  {
> -    NvmeCtrl *n =3D NVME(pci_dev);
>      NvmeIdCtrl *id =3D &n->id_ctrl;
> -    Error *err =3D NULL;
> +    uint8_t *pci_conf =3D pci_dev->config;
> =20
> -    int i;
> -    uint8_t *pci_conf;
> -
> -    nvme_check_constraints(n, &err);
> -    if (err) {
> -        error_propagate(errp, err);
> -        return;
> -    }
> -
> -    nvme_init_state(n);
> -
> -    nvme_init_blk(n, &err);
> -    if (err) {
> -        error_propagate(errp, err);
> -        return;
> -    }
> -
> -    nvme_init_pci(n, pci_dev);
> -
> -    pci_conf =3D pci_dev->config;
>      id->vid =3D cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
>      id->ssvid =3D cpu_to_le16(pci_get_word(pci_conf + PCI_SUBSYSTEM_VEND=
OR_ID));
>      strpadcpy((char *)id->mn, sizeof(id->mn), "QEMU NVMe Ctrl", ' ');
> @@ -1481,6 +1460,33 @@ static void nvme_realize(PCIDevice *pci_dev, Error=
 **errp)
>      n->bar.vs =3D 0x00010200;
>      n->bar.intmc =3D n->bar.intms =3D 0;
> =20
> +
> +}
> +
> +static void nvme_realize(PCIDevice *pci_dev, Error **errp)
> +{
> +    NvmeCtrl *n =3D NVME(pci_dev);
> +    Error *err =3D NULL;
> +
> +    int i;
> +
> +    nvme_check_constraints(n, &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
> +
> +    nvme_init_state(n);
> +    nvme_init_blk(n, &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
> +    nvme_init_pci(n, pci_dev);
> +    nvme_init_ctrl(n, pci_dev);
> +
>      for (i =3D 0; i < n->num_namespaces; i++) {
>          nvme_init_namespace(n, &n->namespaces[i], &err);
>          if (err) {
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
=09Maxim Levitsky


