Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76C2C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 11:04:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1021207F5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 11:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YV+aQcxL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1021207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k16MT-0003Bl-1L
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 07:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1k16Le-0002Xw-Hz
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 07:03:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43263
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1k16Lc-0001lb-UF
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 07:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596107020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NsxkEbf0Y98svVBiITK46OFIWadlKmON0bg0Fky1/PU=;
 b=YV+aQcxLC32JPueQMUS+726KFXwxVSMFcp5aFtLAquCb1Wm4h9Of2I2rjIYG2gAVlMGuQn
 U1+ulEpRmnvBzq/4uUC1f7HgKyN9v+bAwaPXbFAUMJMcf5IRSTZJzg0lwQWufpMBelRjGZ
 I5ubqySXaLuR4lCYk5g1pyrsw6K/pnQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-ticjDkKbN-OyehXjiBcxQw-1; Thu, 30 Jul 2020 07:03:36 -0400
X-MC-Unique: ticjDkKbN-OyehXjiBcxQw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 204D18017FB;
 Thu, 30 Jul 2020 11:03:35 +0000 (UTC)
Received: from starship (unknown [10.35.206.161])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 62B315DA7A;
 Thu, 30 Jul 2020 11:03:32 +0000 (UTC)
Message-ID: <b8c0c570b3c2d0a92d553ee9d09ba761fb574ffe.camel@redhat.com>
Subject: Re: [PATCH v2 16/16] hw/block/nvme: remove explicit qsg/iov parameters
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org
Date: Thu, 30 Jul 2020 14:03:31 +0300
In-Reply-To: <20200729220638.344477-17-its@irrelevant.dk>
References: <20200729220638.344477-1-its@irrelevant.dk>
 <20200729220638.344477-17-its@irrelevant.dk>
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 23:51:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Max Reitz <mreitz@redhat.com>,
 Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
 Minwoo Im <minwoo.im.dev@gmail.com>, Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2020-07-30 at 00:06 +0200, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Since nvme_map_prp always operate on the request-scoped qsg/iovs, just
> pass a single pointer to the NvmeRequest instead of two for each of the
> qsg and iov.
> 
> Suggested-by: Minwoo Im <minwoo.im.dev@gmail.com>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 55b1a68ced8c..aea8a8b6946c 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -284,8 +284,8 @@ static uint16_t nvme_map_addr(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
>      return NVME_SUCCESS;
>  }
>  
> -static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
> -                             uint64_t prp2, uint32_t len, NvmeCtrl *n)
> +static uint16_t nvme_map_prp(NvmeCtrl *n, uint64_t prp1, uint64_t prp2,
> +                             uint32_t len, NvmeRequest *req)
>  {
>      hwaddr trans_len = n->page_size - (prp1 % n->page_size);
>      trans_len = MIN(len, trans_len);
> @@ -293,6 +293,9 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
>      uint16_t status;
>      bool prp_list_in_cmb = false;
>  
> +    QEMUSGList *qsg = &req->qsg;
> +    QEMUIOVector *iov = &req->iov;
> +
>      trace_pci_nvme_map_prp(trans_len, len, prp1, prp2, num_prps);
>  
>      if (unlikely(!prp1)) {
> @@ -386,7 +389,7 @@ static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
>  {
>      uint16_t status = NVME_SUCCESS;
>  
> -    status = nvme_map_prp(&req->qsg, &req->iov, prp1, prp2, len, n);
> +    status = nvme_map_prp(n, prp1, prp2, len, req);
>      if (status) {
>          return status;
>      }
> @@ -431,7 +434,7 @@ static uint16_t nvme_map_dptr(NvmeCtrl *n, size_t len, NvmeRequest *req)
>      uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
>      uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
>  
> -    return nvme_map_prp(&req->qsg, &req->iov, prp1, prp2, len, n);
> +    return nvme_map_prp(n, prp1, prp2, len, req);
>  }
>  
>  static void nvme_post_cqes(void *opaque)
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


