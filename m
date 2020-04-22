Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F07BC55189
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 08:17:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07F192071E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 08:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X8JMum/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07F192071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRAZD-00011N-3f
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 04:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49710)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jRAYJ-0008N3-OT
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 04:16:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jRAYJ-0002SR-8d
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 04:16:15 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27768
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jRAYI-0002Rx-Qx
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 04:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587543373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=spJjt+qt6kJOitxKgKruy044ZKvNrkx+v0Wa246GT+8=;
 b=X8JMum/X6A/qBZkFXPujxjngx39doQbemYdD0pXT8ewYvoo45Igd2qFXvf2Plr5m/SuR4d
 A8M5btDpHubDmCJy3RK2l6xvUSDXaplUFzVpVbK/Zowl4BvWywrOKekdFbaIij7R93YJt2
 EHISMEjVMy0EFRhg9k7JMezYlLlJNPA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-dyCAEppzN9qVkX6RysGwdg-1; Wed, 22 Apr 2020 04:16:11 -0400
X-MC-Unique: dyCAEppzN9qVkX6RysGwdg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 924F185EE6A;
 Wed, 22 Apr 2020 08:16:10 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 988F876E68;
 Wed, 22 Apr 2020 08:16:07 +0000 (UTC)
Message-ID: <e37bbb5d37c51043d19cc65b6058f5b1db95666d.camel@redhat.com>
Subject: Re: [PATCH v3 12/16] nvme: add namespace helpers
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Wed, 22 Apr 2020 11:16:06 +0300
In-Reply-To: <20200422070927.373048-13-its@irrelevant.dk>
References: <20200422070927.373048-1-its@irrelevant.dk>
 <20200422070927.373048-13-its@irrelevant.dk>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:57:52
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

On Wed, 2020-04-22 at 09:09 +0200, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> Introduce some small helpers to make the next patches easier on the eye.
>=20
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> ---
>  hw/block/nvme.c |  3 +--
>  hw/block/nvme.h | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index a036cfed68e3..e3a08c6fb0d1 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1571,8 +1571,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
>          id_ns->dps =3D 0;
>          id_ns->lbaf[0].ds =3D BDRV_SECTOR_BITS;
>          id_ns->ncap  =3D id_ns->nuse =3D id_ns->nsze =3D
> -            cpu_to_le64(n->ns_size >>
> -                id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas)].ds)=
;
> +            cpu_to_le64(nvme_ns_nlbas(n, ns));
>      }
>  }
> =20
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index c1bb2a4994b6..f9f2b637bbd0 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -69,6 +69,17 @@ typedef struct NvmeNamespace {
>      NvmeIdNs        id_ns;
>  } NvmeNamespace;
> =20
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
>  #define TYPE_NVME "nvme"
>  #define NVME(obj) \
>          OBJECT_CHECK(NvmeCtrl, (obj), TYPE_NVME)
> @@ -105,4 +116,10 @@ typedef struct NvmeCtrl {
>      NvmeIdCtrl      id_ctrl;
>  } NvmeCtrl;
> =20
> +/* calculate the number of LBAs that the namespace can accomodate */
Thanks!
> +static inline uint64_t nvme_ns_nlbas(NvmeCtrl *n, NvmeNamespace *ns)
> +{
> +    return n->ns_size >> nvme_ns_lbads(ns);
> +}
> +
>  #endif /* HW_NVME_H */

Best regards,
=09Maxim Levitsky



