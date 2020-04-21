Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883F8C54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:07:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56729206D4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a8R88zAn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56729206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQrgX-0000kk-Fv
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 08:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57526)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jQrfW-0007gF-BX
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:06:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jQrfV-0005nZ-0O
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:06:25 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60258
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jQrfU-0005m5-IS
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:06:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587470782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xGdKmMwLA1XBI5PuOMpr6AMjsM/hYtTXOtm/F7sS1HU=;
 b=a8R88zAnUgD0di7UEvvzpzYd9fX4xJ5tHz0/wzBTAXgqBU9V8/1r0LgwfkrJnncqSNoPtG
 J+wARHWUdBeuta08o5L2nZUvkiB0h9aEWK70qxzdd89zDj7j7WpABnRf1GpXPr8F8K4OrS
 jTqBGunY66DDzkdruUpRk1TjROTw8OQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-uPtT7ulEM1G-7vvoicUmvw-1; Tue, 21 Apr 2020 08:06:20 -0400
X-MC-Unique: uPtT7ulEM1G-7vvoicUmvw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FDD2801A27;
 Tue, 21 Apr 2020 12:06:19 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6B8587F0A0;
 Tue, 21 Apr 2020 12:05:44 +0000 (UTC)
Message-ID: <50b6efe6ff8c9f3a6939992e23c4cf21065f7ad1.camel@redhat.com>
Subject: Re: [PATCH v2 08/16] nvme: remove redundant cmbloc/cmbsz members
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Tue, 21 Apr 2020 15:05:38 +0300
In-Reply-To: <20200415130159.611361-9-its@irrelevant.dk>
References: <20200415130159.611361-1-its@irrelevant.dk>
 <20200415130159.611361-9-its@irrelevant.dk>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
>  hw/block/nvme.c | 7 ++-----
>  hw/block/nvme.h | 2 --
>  2 files changed, 2 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 8092c1b46eb1..44856e873fd1 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -66,7 +66,7 @@ static bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
> =20
>  static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size=
)
>  {
> -    if (n->cmbsz && nvme_addr_is_cmb(n, addr)) {
> +    if (n->bar.cmbsz && nvme_addr_is_cmb(n, addr)) {
>          memcpy(buf, (void *)&n->cmbuf[addr - n->ctrl_mem.addr], size);
>          return;
>      }
> @@ -160,7 +160,7 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOV=
ector *iov, uint64_t prp1,
>      if (unlikely(!prp1)) {
>          trace_pci_nvme_err_invalid_prp();
>          return NVME_INVALID_FIELD | NVME_DNR;
> -    } else if (n->cmbsz && prp1 >=3D n->ctrl_mem.addr &&
> +    } else if (n->bar.cmbsz && prp1 >=3D n->ctrl_mem.addr &&
>                 prp1 < n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size))=
 {
>          qsg->nsg =3D 0;
>          qemu_iovec_init(iov, num_prps);
> @@ -1425,9 +1425,6 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
>          NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2); /* MBs */
>          NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->params.cmb_size_mb);
> =20
> -        n->cmbloc =3D n->bar.cmbloc;
> -        n->cmbsz =3D n->bar.cmbsz;
> -
>          n->cmbuf =3D g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
>          memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n,
>                                "nvme-cmb", NVME_CMBSZ_GETSIZE(n->bar.cmbs=
z));
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index 1617787af2e9..7eecfd3a50f6 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -88,8 +88,6 @@ typedef struct NvmeCtrl {
>      uint32_t    num_namespaces;
>      uint32_t    max_q_ents;
>      uint64_t    ns_size;
> -    uint32_t    cmbsz;
> -    uint32_t    cmbloc;
>      uint8_t     *cmbuf;
>      uint64_t    irq_status;
>      uint64_t    host_timestamp;                 /* Timestamp sent by the=
 host */

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
=09Maxim levitsky


