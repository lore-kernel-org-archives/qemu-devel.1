Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB46C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 02:35:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1100820C09
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 02:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8heTVqf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1100820C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kF705-0007PQ-UB
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 22:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kF6zU-0006vh-It
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 22:34:44 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22925
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kF6zR-0002yW-Qv
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 22:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599446080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lx7JEP6jg/UDHqKpOH2fAqytwc7rUdF70ypwtnaqmFY=;
 b=T8heTVqfubtKcu3NG30UmMMPKxBvFRo+LVjfZQei0M8rBjlclV8l29AWAJdvr2cB80xuf0
 +al/skCtcOeaPgs2zhkuEzDEYT/Bx5h6zrV8JHZ6FDoBG6DFhGJ8qsOnn6yUAo78CMKTT9
 8glfd0iwIJe1TSCm+S05L6mbvVUkyn0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398--8eHRLExM7qXPJ2PNQNbFg-1; Sun, 06 Sep 2020 22:34:38 -0400
X-MC-Unique: -8eHRLExM7qXPJ2PNQNbFg-1
Received: by mail-wr1-f69.google.com with SMTP id v12so5167266wrm.9
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2020 19:34:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=lx7JEP6jg/UDHqKpOH2fAqytwc7rUdF70ypwtnaqmFY=;
 b=o4NSTWuBjOtQ8hz2T8ziBWh99k8yHafXWUDJmMwVuAruz/rbAWWRu3h8eXxZrttBT7
 JViNhW6w2jApjR/3Q58CGStor8DnJ7rnzL05+qCKzFcI4BmzTl0lOIMp0Q5Z8DClYEwo
 DcO4ouO9DGeugG5RZfWTc3sLpY5+5N7V+4VfNjOMtTqGsZtN2g6/BVbcqnYb3eSHimiz
 yvu9HKqzXCguUAyen0NNrfS4ie/XcKFjScAHdYxBuy73F88rJSYMbKitDauQ6K88nX6y
 GWV5EHf6nVrVhpNk828tOPbdfba04lzMdv45UW1G6cHHBl/XzP3NgELDaMpN4gnI2l+m
 HVPA==
X-Gm-Message-State: AOAM533nw9LwmnT9Z6X5BS40A8A66WoPnOrJr9Wn7K6ujsiMO7EGan7D
 JIVCihd8Rbuv9g8NQRpnoet1ADyXfXt0WiqioJmTY0/mFElLVqvMuMPB6RSpNdr8RRUTPfgqOQv
 ihpO+QPKHa3jgCms=
X-Received: by 2002:a1c:8003:: with SMTP id b3mr19642060wmd.121.1599446076720; 
 Sun, 06 Sep 2020 19:34:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGaHOafXFm6+V9FcfUAggr+vNTiAqBH/FJgo1rjzTZPl8p7AUaqUDCETOXSrmNlAMDGettdA==
X-Received: by 2002:a1c:8003:: with SMTP id b3mr19642043wmd.121.1599446076459; 
 Sun, 06 Sep 2020 19:34:36 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id q186sm26725867wma.45.2020.09.06.19.34.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Sep 2020 19:34:35 -0700 (PDT)
Subject: Re: [PATCH 02/17] hw/block/nvme: handle dma errors
To: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org
References: <20200904141956.576630-1-its@irrelevant.dk>
 <20200904141956.576630-3-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <80b8b35d-8bf9-6f34-6b81-7116a294faa4@redhat.com>
Date: Mon, 7 Sep 2020 04:34:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200904141956.576630-3-its@irrelevant.dk>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/06 21:15:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.69, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Klaus,

On 9/4/20 4:19 PM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Handling DMA errors gracefully is required for the device to pass the
> block/011 test ("disable PCI device while doing I/O") in the blktests
> suite.
> 
> With this patch the device passes the test by retrying "critical"
> transfers (posting of completion entries and processing of submission
> queue entries).
> 
> If DMA errors occur at any other point in the execution of the command
> (say, while mapping the PRPs), the command is aborted with a Data
> Transfer Error status code.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Acked-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  hw/block/nvme.c       | 43 ++++++++++++++++++++++++++++++++-----------
>  hw/block/trace-events |  2 ++
>  include/block/nvme.h  |  2 +-
>  3 files changed, 35 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 63078f600920..49bcdf31ced6 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -140,14 +140,14 @@ static inline void *nvme_addr_to_cmb(NvmeCtrl *n, hwaddr addr)
>      return &n->cmbuf[addr - n->ctrl_mem.addr];
>  }
>  
> -static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
> +static int nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)

If this get merged first:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg737483.html
then please return MemTxResult, ...

>  {
>      if (n->bar.cmbsz && nvme_addr_is_cmb(n, addr)) {
>          memcpy(buf, nvme_addr_to_cmb(n, addr), size);
> -        return;
> +        return 0;
>      }
>  
> -    pci_dma_read(&n->parent_obj, addr, buf, size);
> +    return pci_dma_read(&n->parent_obj, addr, buf, size);
>  }
>  
>  static int nvme_check_sqid(NvmeCtrl *n, uint16_t sqid)
> @@ -253,7 +253,7 @@ static uint16_t nvme_map_addr_cmb(NvmeCtrl *n, QEMUIOVector *iov, hwaddr addr,
>      trace_pci_nvme_map_addr_cmb(addr, len);
>  
>      if (!nvme_addr_is_cmb(n, addr) || !nvme_addr_is_cmb(n, addr + len - 1)) {
> -        return NVME_DATA_TRAS_ERROR;
> +        return NVME_DATA_TRANSFER_ERROR;
>      }
>  
>      qemu_iovec_add(iov, nvme_addr_to_cmb(n, addr), len);
> @@ -307,6 +307,7 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, uint64_t prp1, uint64_t prp2,
>      int num_prps = (len >> n->page_bits) + 1;
>      uint16_t status;
>      bool prp_list_in_cmb = false;
> +    int ret;
>  
>      QEMUSGList *qsg = &req->qsg;
>      QEMUIOVector *iov = &req->iov;
> @@ -347,7 +348,11 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, uint64_t prp1, uint64_t prp2,
>  
>              nents = (len + n->page_size - 1) >> n->page_bits;
>              prp_trans = MIN(n->max_prp_ents, nents) * sizeof(uint64_t);
> -            nvme_addr_read(n, prp2, (void *)prp_list, prp_trans);
> +            ret = nvme_addr_read(n, prp2, (void *)prp_list, prp_trans);
> +            if (ret) {

... and check it (other cases following).

> +                trace_pci_nvme_err_addr_read(prp2);
> +                return NVME_DATA_TRANSFER_ERROR;
> +            }
>              while (len != 0) {
>                  uint64_t prp_ent = le64_to_cpu(prp_list[i]);
>  
> @@ -364,8 +369,12 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, uint64_t prp1, uint64_t prp2,
>                      i = 0;
>                      nents = (len + n->page_size - 1) >> n->page_bits;
>                      prp_trans = MIN(n->max_prp_ents, nents) * sizeof(uint64_t);
> -                    nvme_addr_read(n, prp_ent, (void *)prp_list,
> -                        prp_trans);
> +                    ret = nvme_addr_read(n, prp_ent, (void *)prp_list,
> +                                         prp_trans);
> +                    if (ret) {
> +                        trace_pci_nvme_err_addr_read(prp_ent);
> +                        return NVME_DATA_TRANSFER_ERROR;
> +                    }
>                      prp_ent = le64_to_cpu(prp_list[i]);
>                  }
>  
> @@ -457,6 +466,7 @@ static void nvme_post_cqes(void *opaque)
>      NvmeCQueue *cq = opaque;
>      NvmeCtrl *n = cq->ctrl;
>      NvmeRequest *req, *next;
> +    int ret;
>  
>      QTAILQ_FOREACH_SAFE(req, &cq->req_list, entry, next) {
>          NvmeSQueue *sq;
> @@ -466,15 +476,21 @@ static void nvme_post_cqes(void *opaque)
>              break;
>          }
>  
> -        QTAILQ_REMOVE(&cq->req_list, req, entry);
>          sq = req->sq;
>          req->cqe.status = cpu_to_le16((req->status << 1) | cq->phase);
>          req->cqe.sq_id = cpu_to_le16(sq->sqid);
>          req->cqe.sq_head = cpu_to_le16(sq->head);
>          addr = cq->dma_addr + cq->tail * n->cqe_size;
> +        ret = pci_dma_write(&n->parent_obj, addr, (void *)&req->cqe,
> +                            sizeof(req->cqe));
> +        if (ret) {
> +            trace_pci_nvme_err_addr_write(addr);
> +            timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> +                      500 * SCALE_MS);
> +            break;
> +        }
> +        QTAILQ_REMOVE(&cq->req_list, req, entry);
>          nvme_inc_cq_tail(cq);
> -        pci_dma_write(&n->parent_obj, addr, (void *)&req->cqe,
> -            sizeof(req->cqe));
>          nvme_req_exit(req);
>          QTAILQ_INSERT_TAIL(&sq->req_list, req, entry);
>      }
> @@ -1611,7 +1627,12 @@ static void nvme_process_sq(void *opaque)
>  
>      while (!(nvme_sq_empty(sq) || QTAILQ_EMPTY(&sq->req_list))) {
>          addr = sq->dma_addr + sq->head * n->sqe_size;
> -        nvme_addr_read(n, addr, (void *)&cmd, sizeof(cmd));
> +        if (nvme_addr_read(n, addr, (void *)&cmd, sizeof(cmd))) {
> +            trace_pci_nvme_err_addr_read(addr);
> +            timer_mod(sq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> +                      500 * SCALE_MS);
> +            break;
> +        }
>          nvme_inc_sq_head(sq);
>  
>          req = QTAILQ_FIRST(&sq->req_list);
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index 72cf2d15cb8e..50d5702e6b80 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -86,6 +86,8 @@ pci_nvme_mmio_shutdown_cleared(void) "shutdown bit cleared"
>  
>  # nvme traces for error conditions
>  pci_nvme_err_mdts(uint16_t cid, size_t len) "cid %"PRIu16" len %zu"
> +pci_nvme_err_addr_read(uint64_t addr) "addr 0x%"PRIx64""
> +pci_nvme_err_addr_write(uint64_t addr) "addr 0x%"PRIx64""
>  pci_nvme_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
>  pci_nvme_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is null or not page aligned: 0x%"PRIx64""
>  pci_nvme_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned: 0x%"PRIx64""
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 65e68a82c897..c8d0a3473f0d 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -630,7 +630,7 @@ enum NvmeStatusCodes {
>      NVME_INVALID_OPCODE         = 0x0001,
>      NVME_INVALID_FIELD          = 0x0002,
>      NVME_CID_CONFLICT           = 0x0003,
> -    NVME_DATA_TRAS_ERROR        = 0x0004,
> +    NVME_DATA_TRANSFER_ERROR    = 0x0004,
>      NVME_POWER_LOSS_ABORT       = 0x0005,
>      NVME_INTERNAL_DEV_ERROR     = 0x0006,
>      NVME_CMD_ABORT_REQ          = 0x0007,
> 


