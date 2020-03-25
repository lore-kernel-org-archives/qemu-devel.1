Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE62AC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:57:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 676B6206F6
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LmjG5TZ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 676B6206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3jK-0006Y7-DD
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 06:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37487)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3iA-0004yN-Ix
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:56:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3i9-00018j-4D
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:56:38 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:47282)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jH3i9-00018Q-05
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585133796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A8z/q2u2Z/Whrr4ulRGRiL3k3gIy/ezdLB2LW90jl2E=;
 b=LmjG5TZ7NPDaotkDq2vj81OHZKoRKTFviBOZy8CZuppV2yoYpJpkIjVmejDLzh8lQ8c97S
 wPoQQMj7XderdTipHoPiU9ns+qn9AbXjafxVQWx96W5neXjCeBtQokd96oOKmJZO0rBowY
 RHcjIWAqlXOIyNwkLFRHR8LBQhmplBs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-fikWqlanOhOBtB_gP6KVUg-1; Wed, 25 Mar 2020 06:56:35 -0400
X-MC-Unique: fikWqlanOhOBtB_gP6KVUg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A23A4189D6C7;
 Wed, 25 Mar 2020 10:56:33 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CBFCB94B43;
 Wed, 25 Mar 2020 10:56:30 +0000 (UTC)
Message-ID: <87f22f31c3f90293850f106f72eb12a118701355.camel@redhat.com>
Subject: Re: [PATCH v6 28/42] nvme: verify validity of prp lists in the cmb
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Wed, 25 Mar 2020 12:56:29 +0200
In-Reply-To: <20200316142928.153431-29-its@irrelevant.dk>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-29-its@irrelevant.dk>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-03-16 at 07:29 -0700, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Before this patch the device already supported this, but it did not
> check for the validity of it nor announced the support in the LISTS
> field.
> 
> If some of the PRPs in a PRP list are in the CMB, then ALL entries must
> be there. This patch makes sure that is verified as well as properly
> announcing support for PRP lists in the CMB.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 850087aac967..eecfad694bf8 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -210,6 +210,7 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
>      trans_len = MIN(len, trans_len);
>      int num_prps = (len >> n->page_bits) + 1;
>      uint16_t status;
> +    bool prp_list_in_cmb = false;
>  
>      trace_nvme_dev_map_prp(nvme_cid(req), trans_len, len, prp1, prp2,
>                             num_prps);
> @@ -237,11 +238,16 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
>              status = NVME_INVALID_FIELD | NVME_DNR;
>              goto unmap;
>          }
> +
>          if (len > n->page_size) {
>              uint64_t prp_list[n->max_prp_ents];
>              uint32_t nents, prp_trans;
>              int i = 0;
>  
> +            if (nvme_addr_is_cmb(n, prp2)) {
> +                prp_list_in_cmb = true;
> +            }
> +
>              nents = (len + n->page_size - 1) >> n->page_bits;
>              prp_trans = MIN(n->max_prp_ents, nents) * sizeof(uint64_t);
>              nvme_addr_read(n, prp2, (void *)prp_list, prp_trans);
> @@ -255,6 +261,11 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
>                          goto unmap;
>                      }
>  
> +                    if (prp_list_in_cmb != nvme_addr_is_cmb(n, prp_ent)) {
> +                        status = NVME_INVALID_USE_OF_CMB | NVME_DNR;
> +                        goto unmap;
> +                    }
> +
>                      i = 0;
>                      nents = (len + n->page_size - 1) >> n->page_bits;
>                      prp_trans = MIN(n->max_prp_ents, nents) * sizeof(uint64_t);
> @@ -274,6 +285,7 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
>                  if (status) {
>                      goto unmap;
>                  }
> +
>                  len -= trans_len;
>                  i++;
>              }
> @@ -1931,7 +1943,7 @@ static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
>  
>      NVME_CMBSZ_SET_SQS(n->bar.cmbsz, 1);
>      NVME_CMBSZ_SET_CQS(n->bar.cmbsz, 0);
> -    NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 0);
> +    NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 1);
>      NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
>      NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
>      NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2);

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky




