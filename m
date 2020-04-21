Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FC9C54FCC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 15:42:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCA06206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 15:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YPeUY97T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA06206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQv2Y-00068H-HI
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 11:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47184)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jQv1Z-0005VZ-Qi
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 11:41:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jQv1V-0002N6-H9
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 11:41:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30522
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jQv1V-0002Lw-4h
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 11:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587483679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SvAeCD+BDLaH5bPQLVyfAHB5w0BVLirCoEvVA9ioX14=;
 b=YPeUY97TanirnrmhbUiv469W4lWgBDbPQJ9xnnYQ6NmZ4RGyqIt4cWpwEIwDS4UCyBMbxf
 vIsQs3ZgmVgyKIBtiUDplOfvh6BHF5r6DeGSeNml2toSbVYbpfUVilyap/9lL+jhRQklxD
 Z29DoaTALBqKmqP67XROwUsw25UqDF8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-X6cXRkisPRWf0RNRRRaOaw-1; Tue, 21 Apr 2020 11:41:18 -0400
X-MC-Unique: X6cXRkisPRWf0RNRRRaOaw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B78B18010CA;
 Tue, 21 Apr 2020 15:41:16 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F19BD5C1B2;
 Tue, 21 Apr 2020 15:41:11 +0000 (UTC)
Message-ID: <ee8ad286b9d4a7079210914291098eab2016e8b0.camel@redhat.com>
Subject: Re: [PATCH v2 12/16] nvme: add namespace helpers
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Tue, 21 Apr 2020 18:41:10 +0300
In-Reply-To: <20200415130159.611361-13-its@irrelevant.dk>
References: <20200415130159.611361-1-its@irrelevant.dk>
 <20200415130159.611361-13-its@irrelevant.dk>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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
> 
> Introduce some small helpers to make the next patches easier on the eye.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme.c |  3 +--
>  hw/block/nvme.h | 16 ++++++++++++++++
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 80da0825d295..d5244102252c 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1469,8 +1469,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>          id_ns->dps = 0;
>          id_ns->lbaf[0].ds = BDRV_SECTOR_BITS;
>          id_ns->ncap  = id_ns->nuse = id_ns->nsze =
> -            cpu_to_le64(n->ns_size >>
> -                id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas)].ds);
> +            cpu_to_le64(nvme_ns_nlbas(n, ns));
>      }
>  }
>  
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index 7eecfd3a50f6..dd932a9e7ebc 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -67,6 +67,17 @@ typedef struct NvmeNamespace {
>      NvmeIdNs        id_ns;
>  } NvmeNamespace;
>  
> +static inline NvmeLBAF *nvme_ns_lbaf(NvmeNamespace *ns)
> +{
> +    NvmeIdNs *id_ns = &ns->id_ns;
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
> @@ -101,4 +112,9 @@ typedef struct NvmeCtrl {
>      NvmeIdCtrl      id_ctrl;
>  } NvmeCtrl;
>  
> +static inline uint64_t nvme_ns_nlbas(NvmeCtrl *n, NvmeNamespace *ns)
> +{
> +    return n->ns_size >> nvme_ns_lbads(ns);
> +}
> +
>  #endif /* HW_NVME_H */

Nitpick: On second thought, these function names do sound quite cryptic, so maybe
at least for nvme_ns_nlbas pick something more readable? maybe nvme_ns_number_of_lbas
or something.
Or add a comment - comment always fixes these kind of issues.

But that doesn't matter much IMHO, so
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


