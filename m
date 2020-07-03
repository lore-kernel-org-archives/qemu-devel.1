Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC4AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 08:04:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8B5C206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 08:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dv0ii4gr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8B5C206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrGgP-0005nN-1X
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 04:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrGfj-00055Z-2b
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 04:03:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45918
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrGff-0007RR-QB
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 04:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593763422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WLX/UqIc40CIkA4oanS8dEA3NlMfQjeKnF3ZHE1adgY=;
 b=Dv0ii4grA+7wvXEEGhsWuDVFnVsprskqeB9G0uDZFdjPBqAEvlIlv1AEdVm42sjDNrpBvp
 xzFnE63A4EsCuRnLa9tt6k52MJv5zDNV1YqxHRjI1NlERqUt/aHjbvjnpe1ju2SawLL386
 I1D5kujD7zTYenzbdRkeQ+is3HzzF9Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-2OJ7lpm6N7KkuuVrfY7yLg-1; Fri, 03 Jul 2020 04:03:39 -0400
X-MC-Unique: 2OJ7lpm6N7KkuuVrfY7yLg-1
Received: by mail-wr1-f72.google.com with SMTP id v3so1302203wrq.10
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 01:03:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=WLX/UqIc40CIkA4oanS8dEA3NlMfQjeKnF3ZHE1adgY=;
 b=gr5hEbZ1ak5N3bfG/cdVTYx1qGa6j83lZKgejxEOIZmam3FVJ0NVC27QFqGKZws4xc
 QlZrWnC2NYf6/KrbnajkrPTPXfe6YTc6Y/s80rD//moRZ8feVrj0bUhsmMYoWeOkKY9Q
 U5k1iLr3+iIsnmuFHDL97JMpyJtrxKvsnoiXM2Ejcf2moPMuJNYnR3e2lZNXTx5tk/33
 +n2cWBf217BtrYGxGYe+VoaEdu5eNzU+uSbaedIWhUa1A0l0nIhYjY9IgiPqTZFkAi1e
 DoOaWp7JPDPMcCiZgl9FUdBZjUzo/LEiAOzMNJVNm16j/miCMjjRjeJZ5b08W+VRFg6F
 vGxQ==
X-Gm-Message-State: AOAM530M7agcaK25phk2K54fmgbvdrAlsDA10W8pjDjnBRRLOTfMjpNk
 oA9qfYcY/UgoByur4aGEMAy+Rtn2ELQbEOqKOBk74mQWzsESovkW8NZxViJMsWrj7wIZcIJHW3A
 afnRERGFX5uwNAQM=
X-Received: by 2002:adf:ec88:: with SMTP id z8mr35425558wrn.395.1593763418137; 
 Fri, 03 Jul 2020 01:03:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzigf53U9EWIyT7H9tzmJLXzMv5pwUyZMh2jbXVEBtWPzTP6/jzMLCyFTczNrqrk3mr/y6vw==
X-Received: by 2002:adf:ec88:: with SMTP id z8mr35425530wrn.395.1593763417804; 
 Fri, 03 Jul 2020 01:03:37 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id d132sm12631736wmd.35.2020.07.03.01.03.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2020 01:03:37 -0700 (PDT)
Subject: Re: [PATCH v2 02/18] hw/block/nvme: additional tracing
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200703063420.2241014-1-its@irrelevant.dk>
 <20200703063420.2241014-3-its@irrelevant.dk>
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
Message-ID: <f474e1b3-2510-2b93-908e-31310f19b1a5@redhat.com>
Date: Fri, 3 Jul 2020 10:03:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200703063420.2241014-3-its@irrelevant.dk>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 01:34:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/3/20 8:34 AM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Add various additional tracing and streamline nvme_identify_ns and
> nvme_identify_nslist (they do not need to repeat the command, it is
> already in the trace name).
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Reviewed-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  hw/block/nvme.c       | 19 +++++++++++++++++++
>  hw/block/nvme.h       | 14 ++++++++++++++
>  hw/block/trace-events | 13 +++++++++++--
>  3 files changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 71b388aa0e20..f5d9148f0936 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -331,6 +331,8 @@ static void nvme_post_cqes(void *opaque)
>  static void nvme_enqueue_req_completion(NvmeCQueue *cq, NvmeRequest *req)
>  {
>      assert(cq->cqid == req->sq->cqid);
> +    trace_pci_nvme_enqueue_req_completion(nvme_cid(req), cq->cqid,
> +                                          req->status);
>      QTAILQ_REMOVE(&req->sq->out_req_list, req, entry);
>      QTAILQ_INSERT_TAIL(&cq->req_list, req, entry);
>      timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
> @@ -343,6 +345,8 @@ static void nvme_rw_cb(void *opaque, int ret)
>      NvmeCtrl *n = sq->ctrl;
>      NvmeCQueue *cq = n->cq[sq->cqid];
>  
> +    trace_pci_nvme_rw_cb(nvme_cid(req));
> +
>      if (!ret) {
>          block_acct_done(blk_get_stats(n->conf.blk), &req->acct);
>          req->status = NVME_SUCCESS;
> @@ -378,6 +382,8 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>      uint64_t offset = slba << data_shift;
>      uint32_t count = nlb << data_shift;
>  
> +    trace_pci_nvme_write_zeroes(nvme_cid(req), slba, nlb);
> +
>      if (unlikely(slba + nlb > ns->id_ns.nsze)) {
>          trace_pci_nvme_err_invalid_lba_range(slba, nlb, ns->id_ns.nsze);
>          return NVME_LBA_RANGE | NVME_DNR;
> @@ -445,6 +451,8 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>      NvmeNamespace *ns;
>      uint32_t nsid = le32_to_cpu(cmd->nsid);
>  
> +    trace_pci_nvme_io_cmd(nvme_cid(req), nsid, nvme_sqid(req), cmd->opcode);
> +
>      if (unlikely(nsid == 0 || nsid > n->num_namespaces)) {
>          trace_pci_nvme_err_invalid_ns(nsid, n->num_namespaces);
>          return NVME_INVALID_NSID | NVME_DNR;
> @@ -876,6 +884,8 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>  
>  static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>  {
> +    trace_pci_nvme_admin_cmd(nvme_cid(req), nvme_sqid(req), cmd->opcode);
> +
>      switch (cmd->opcode) {
>      case NVME_ADM_CMD_DELETE_SQ:
>          return nvme_del_sq(n, cmd);
> @@ -1204,6 +1214,8 @@ static uint64_t nvme_mmio_read(void *opaque, hwaddr addr, unsigned size)
>      uint8_t *ptr = (uint8_t *)&n->bar;
>      uint64_t val = 0;
>  
> +    trace_pci_nvme_mmio_read(addr);
> +
>      if (unlikely(addr & (sizeof(uint32_t) - 1))) {
>          NVME_GUEST_ERR(pci_nvme_ub_mmiord_misaligned32,
>                         "MMIO read not 32-bit aligned,"
> @@ -1273,6 +1285,8 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
>              return;
>          }
>  
> +        trace_pci_nvme_mmio_doorbell_cq(cq->cqid, new_head);
> +
>          start_sqs = nvme_cq_full(cq) ? 1 : 0;
>          cq->head = new_head;
>          if (start_sqs) {
> @@ -1311,6 +1325,8 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
>              return;
>          }
>  
> +        trace_pci_nvme_mmio_doorbell_sq(sq->sqid, new_tail);
> +
>          sq->tail = new_tail;
>          timer_mod(sq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
>      }
> @@ -1320,6 +1336,9 @@ static void nvme_mmio_write(void *opaque, hwaddr addr, uint64_t data,
>      unsigned size)
>  {
>      NvmeCtrl *n = (NvmeCtrl *)opaque;
> +
> +    trace_pci_nvme_mmio_write(addr, data);
> +
>      if (addr < sizeof(n->bar)) {
>          nvme_write_bar(n, addr, data, size);
>      } else if (addr >= 0x1000) {
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index 1d30c0bca283..1bf5c80ed843 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -115,4 +115,18 @@ static inline uint64_t nvme_ns_nlbas(NvmeCtrl *n, NvmeNamespace *ns)
>      return n->ns_size >> nvme_ns_lbads(ns);
>  }
>  
> +static inline uint16_t nvme_cid(NvmeRequest *req)
> +{
> +    if (req) {
> +        return le16_to_cpu(req->cqe.cid);
> +    }
> +
> +    return 0xffff;

In this case I find the inverted logic easier. Matter
of taste :)

> +}
> +
> +static inline uint16_t nvme_sqid(NvmeRequest *req)
> +{
> +    return le16_to_cpu(req->sq->sqid);
> +}

Later I'd prefer we move these out of the header, and remove
the inline attribute.
I.e. nvme_ns_nlbas() is only used once.

OK for now.
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +
>  #endif /* HW_NVME_H */
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index 958fcc5508d1..c40c0d2e4b28 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -33,19 +33,28 @@ pci_nvme_irq_msix(uint32_t vector) "raising MSI-X IRQ vector %u"
>  pci_nvme_irq_pin(void) "pulsing IRQ pin"
>  pci_nvme_irq_masked(void) "IRQ is masked"
>  pci_nvme_dma_read(uint64_t prp1, uint64_t prp2) "DMA read, prp1=0x%"PRIx64" prp2=0x%"PRIx64""
> +pci_nvme_io_cmd(uint16_t cid, uint32_t nsid, uint16_t sqid, uint8_t opcode) "cid %"PRIu16" nsid %"PRIu32" sqid %"PRIu16" opc 0x%"PRIx8""
> +pci_nvme_admin_cmd(uint16_t cid, uint16_t sqid, uint8_t opcode) "cid %"PRIu16" sqid %"PRIu16" opc 0x%"PRIx8""
>  pci_nvme_rw(const char *verb, uint32_t blk_count, uint64_t byte_count, uint64_t lba) "%s %"PRIu32" blocks (%"PRIu64" bytes) from LBA %"PRIu64""
> +pci_nvme_rw_cb(uint16_t cid) "cid %"PRIu16""
> +pci_nvme_write_zeroes(uint16_t cid, uint64_t slba, uint32_t nlb) "cid %"PRIu16" slba %"PRIu64" nlb %"PRIu32""
>  pci_nvme_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsize, uint16_t qflags) "create submission queue, addr=0x%"PRIx64", sqid=%"PRIu16", cqid=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16""
>  pci_nvme_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t size, uint16_t qflags, int ien) "create completion queue, addr=0x%"PRIx64", cqid=%"PRIu16", vector=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16", ien=%d"
>  pci_nvme_del_sq(uint16_t qid) "deleting submission queue sqid=%"PRIu16""
>  pci_nvme_del_cq(uint16_t cqid) "deleted completion queue, cqid=%"PRIu16""
>  pci_nvme_identify_ctrl(void) "identify controller"
> -pci_nvme_identify_ns(uint16_t ns) "identify namespace, nsid=%"PRIu16""
> -pci_nvme_identify_nslist(uint16_t ns) "identify namespace list, nsid=%"PRIu16""
> +pci_nvme_identify_ns(uint32_t ns) "nsid %"PRIu32""
> +pci_nvme_identify_nslist(uint32_t ns) "nsid %"PRIu32""
>  pci_nvme_getfeat_vwcache(const char* result) "get feature volatile write cache, result=%s"
>  pci_nvme_getfeat_numq(int result) "get feature number of queues, result=%d"
>  pci_nvme_setfeat_numq(int reqcq, int reqsq, int gotcq, int gotsq) "requested cq_count=%d sq_count=%d, responding with cq_count=%d sq_count=%d"
>  pci_nvme_setfeat_timestamp(uint64_t ts) "set feature timestamp = 0x%"PRIx64""
>  pci_nvme_getfeat_timestamp(uint64_t ts) "get feature timestamp = 0x%"PRIx64""
> +pci_nvme_enqueue_req_completion(uint16_t cid, uint16_t cqid, uint16_t status) "cid %"PRIu16" cqid %"PRIu16" status 0x%"PRIx16""
> +pci_nvme_mmio_read(uint64_t addr) "addr 0x%"PRIx64""
> +pci_nvme_mmio_write(uint64_t addr, uint64_t data) "addr 0x%"PRIx64" data 0x%"PRIx64""
> +pci_nvme_mmio_doorbell_cq(uint16_t cqid, uint16_t new_head) "cqid %"PRIu16" new_head %"PRIu16""
> +pci_nvme_mmio_doorbell_sq(uint16_t sqid, uint16_t new_tail) "cqid %"PRIu16" new_tail %"PRIu16""
>  pci_nvme_mmio_intm_set(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask set, data=0x%"PRIx64", new_mask=0x%"PRIx64""
>  pci_nvme_mmio_intm_clr(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask clr, data=0x%"PRIx64", new_mask=0x%"PRIx64""
>  pci_nvme_mmio_cfg(uint64_t data) "wrote MMIO, config controller config=0x%"PRIx64""
> 


