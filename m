Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB0AC54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 10:37:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5E4720663
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 10:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pk+3E3zX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5E4720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQqH7-0003eB-Vr
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 06:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46118)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jQqGI-0002lp-Lp
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 06:36:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jQqG3-0004Zv-KA
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 06:36:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29693
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jQqG3-0004YK-8N
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 06:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587465362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MszpWOKEk8wwkPNPLSP88+n5co/NKsoBQSqzypn3SuA=;
 b=Pk+3E3zXfD7d1Z5sFSZUo/pV54I9kJUmyULbutkiq4lrcyNhd9WB0nblVa2NyUC9goHF/B
 8jmzMm1JPgq8h5CxTFDn1+rR56ZTFvOU9jd6nHKeBdZsVjyYFseQV0+FxTJ9+AI8Xx1UQO
 zlHkHeCLJKm6ZVzuiqTWo15gBAotDXw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-9zVOCOYYM9q5k9d7HP7vKg-1; Tue, 21 Apr 2020 06:35:58 -0400
X-MC-Unique: 9zVOCOYYM9q5k9d7HP7vKg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C82B8017FC;
 Tue, 21 Apr 2020 10:35:57 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA7BC9DD8A;
 Tue, 21 Apr 2020 10:35:54 +0000 (UTC)
Message-ID: <ba7b701f8cb35265400451480e1e2485886c7d99.camel@redhat.com>
Subject: Re: [PATCH v2 06/16] nvme: refactor nvme_addr_read
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Tue, 21 Apr 2020 13:35:53 +0300
In-Reply-To: <20200415130159.611361-7-its@irrelevant.dk>
References: <20200415130159.611361-1-its@irrelevant.dk>
 <20200415130159.611361-7-its@irrelevant.dk>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 04:54:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2020-04-15 at 15:01 +0200, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> Pull the controller memory buffer check to its own function. The check
> will be used on its own in later patches.
>=20
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Acked-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/block/nvme.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 563cccae6795..d026985f62d0 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -55,14 +55,22 @@
> =20
>  static void nvme_process_sq(void *opaque);
> =20
> +static bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
> +{
> +    hwaddr low =3D n->ctrl_mem.addr;
> +    hwaddr hi  =3D n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size);
> +
> +    return addr >=3D low && addr < hi;
> +}
> +
>  static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size=
)
>  {
> -    if (n->cmbsz && addr >=3D n->ctrl_mem.addr &&
> -                addr < (n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size=
))) {
> +    if (n->cmbsz && nvme_addr_is_cmb(n, addr)) {
>          memcpy(buf, (void *)&n->cmbuf[addr - n->ctrl_mem.addr], size);
> -    } else {
> -        pci_dma_read(&n->parent_obj, addr, buf, size);
> +        return;
>      }
> +
> +    pci_dma_read(&n->parent_obj, addr, buf, size);
>  }
> =20
>  static int nvme_check_sqid(NvmeCtrl *n, uint16_t sqid)

Looks like I forgot to add reviewed-by to the patch from V6,
but it looks all right after our discussion so,


Reviewed-by: Maxim Levitsky <mlevitsky@redhat.com>

Best regards,
=09Maxim Levitsky


