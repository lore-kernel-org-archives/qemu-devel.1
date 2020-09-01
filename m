Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3790C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 16:36:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D93220767
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 16:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hhIKX+uv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D93220767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD9GM-0007HN-Pg
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 12:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kD9FI-0006PU-Vf
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 12:34:56 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48218
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kD9FH-0000TA-2M
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 12:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598978093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hgAgYBzetUTJH2I4dt1Xh+Ejqv5WW7Wrsge4eTaiFKE=;
 b=hhIKX+uvuMLFzTaTcpFmRoBJVWLKrpxJErE+awQPJtx41uDhfWpvCVJ+3f0McaOG7VYwGh
 5DPKmER/apROKSNuFSRBN31WP+h8KY/AAceHGbefKLQGxXSNwuZ9YszihEpDBf4Jgnh0/0
 4gvV+2fClqqbiCDvQIkZnfsQxftUS54=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-vtLBoc5aMq6wdaXdyzNlQA-1; Tue, 01 Sep 2020 12:34:52 -0400
X-MC-Unique: vtLBoc5aMq6wdaXdyzNlQA-1
Received: by mail-wr1-f70.google.com with SMTP id b18so797760wrn.6
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 09:34:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=hgAgYBzetUTJH2I4dt1Xh+Ejqv5WW7Wrsge4eTaiFKE=;
 b=tCCHLx7IgUTxWIZmgYUd2Y0Iwsvfua53pqghmrdP1qKgVpHEHGubh78RSlc7/n6NLx
 DdCpEDy9ZTakdzEFVVXQy/AUnoRLP/XS0i7FXlS1YzNcDsL+vlZGM5geoO/ZxT5YTnaF
 7+xNbmSgczfNiyZfej9elhviHNosNa8Xj0TqHl38+vCohlBFz0Oi7vuT9qPMz46iYFPT
 fhS6YsQ4rVLtALrfkirILJSH8fuucsrTD8ClBnLmXfKm5shCTXekpNCOn/uTZgEyXDXd
 1KL1GWcTmn3/j/cv2bKjmuPQdHQgNJke1ZE7J16dmxo9/CoZYJyvbmhQ7oqJVNw1jVzb
 P/sA==
X-Gm-Message-State: AOAM5338o0rY1DvG6tvQ6ufrobkdksOrYG/8lNL0C2BCoPkL/n8Rn9DV
 7gIqyoE8LLEirhrUAGzCEFlIiCwPRa076fFgUj2JID3VN127HgW7CtGZ6WEoNF+CjHDr8WdyTNh
 5kfGr2S+HpMUM77Y=
X-Received: by 2002:a5d:4910:: with SMTP id x16mr3053120wrq.204.1598978091300; 
 Tue, 01 Sep 2020 09:34:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgdST8ckMbIPcksyEKpFpoT+wh9pg9Ex+a2g7AdabKACVrkr2ljWj6EtNdk/oPjjT3n28Y2g==
X-Received: by 2002:a5d:4910:: with SMTP id x16mr3053087wrq.204.1598978091049; 
 Tue, 01 Sep 2020 09:34:51 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id w1sm2590980wmc.18.2020.09.01.09.34.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 09:34:50 -0700 (PDT)
Subject: Re: [PATCH v4 1/7] usb/hcd-xhci: Make dma read/writes hooks pci free
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?=27Marc-Andr=c3=a9_Lureau=27?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Francisco Iglesias <francisco.iglesias@xilinx.com>
References: <1598642380-27817-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1598642380-27817-2-git-send-email-sai.pavan.boddu@xilinx.com>
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
Message-ID: <cefca93c-37d5-63b7-aff3-e6966d771892@redhat.com>
Date: Tue, 1 Sep 2020 18:34:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1598642380-27817-2-git-send-email-sai.pavan.boddu@xilinx.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 02:08:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Vikram Garhwal <fnuv@xilinx.com>,
 qemu-devel@nongnu.org, Paul Zimmerman <pauldzim@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, Ying Fang <fangying1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/28/20 9:19 PM, Sai Pavan Boddu wrote:
> This patch starts making the hcd-xhci.c pci free, as part of this
> restructuring dma read/writes are handled without passing pci object.
> 
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> ---
>  hw/usb/hcd-xhci.c | 24 +++++++++++-------------
>  hw/usb/hcd-xhci.h |  3 +++
>  2 files changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index 67a18fe..2590f7a 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -495,7 +495,7 @@ static inline void xhci_dma_read_u32s(XHCIState *xhci, dma_addr_t addr,
>  
>      assert((len % sizeof(uint32_t)) == 0);
>  
> -    pci_dma_read(PCI_DEVICE(xhci), addr, buf, len);
> +    dma_memory_read(xhci->as, addr, buf, len);
>  
>      for (i = 0; i < (len / sizeof(uint32_t)); i++) {
>          buf[i] = le32_to_cpu(buf[i]);
> @@ -515,7 +515,7 @@ static inline void xhci_dma_write_u32s(XHCIState *xhci, dma_addr_t addr,
>      for (i = 0; i < n; i++) {
>          tmp[i] = cpu_to_le32(buf[i]);
>      }
> -    pci_dma_write(PCI_DEVICE(xhci), addr, tmp, len);
> +    dma_memory_write(xhci->as, addr, tmp, len);
>  }
>  
>  static XHCIPort *xhci_lookup_port(XHCIState *xhci, struct USBPort *uport)
> @@ -644,7 +644,6 @@ static void xhci_die(XHCIState *xhci)
>  
>  static void xhci_write_event(XHCIState *xhci, XHCIEvent *event, int v)
>  {
> -    PCIDevice *pci_dev = PCI_DEVICE(xhci);
>      XHCIInterrupter *intr = &xhci->intr[v];
>      XHCITRB ev_trb;
>      dma_addr_t addr;
> @@ -663,7 +662,7 @@ static void xhci_write_event(XHCIState *xhci, XHCIEvent *event, int v)
>                                 ev_trb.status, ev_trb.control);
>  
>      addr = intr->er_start + TRB_SIZE*intr->er_ep_idx;
> -    pci_dma_write(pci_dev, addr, &ev_trb, TRB_SIZE);
> +    dma_memory_write(xhci->as, addr, &ev_trb, TRB_SIZE);
>  
>      intr->er_ep_idx++;
>      if (intr->er_ep_idx >= intr->er_size) {
> @@ -720,12 +719,11 @@ static void xhci_ring_init(XHCIState *xhci, XHCIRing *ring,
>  static TRBType xhci_ring_fetch(XHCIState *xhci, XHCIRing *ring, XHCITRB *trb,
>                                 dma_addr_t *addr)
>  {
> -    PCIDevice *pci_dev = PCI_DEVICE(xhci);
>      uint32_t link_cnt = 0;
>  
>      while (1) {
>          TRBType type;
> -        pci_dma_read(pci_dev, ring->dequeue, trb, TRB_SIZE);
> +        dma_memory_read(xhci->as, ring->dequeue, trb, TRB_SIZE);
>          trb->addr = ring->dequeue;
>          trb->ccs = ring->ccs;
>          le64_to_cpus(&trb->parameter);
> @@ -762,7 +760,6 @@ static TRBType xhci_ring_fetch(XHCIState *xhci, XHCIRing *ring, XHCITRB *trb,
>  
>  static int xhci_ring_chain_length(XHCIState *xhci, const XHCIRing *ring)
>  {
> -    PCIDevice *pci_dev = PCI_DEVICE(xhci);
>      XHCITRB trb;
>      int length = 0;
>      dma_addr_t dequeue = ring->dequeue;
> @@ -773,7 +770,7 @@ static int xhci_ring_chain_length(XHCIState *xhci, const XHCIRing *ring)
>  
>      while (1) {
>          TRBType type;
> -        pci_dma_read(pci_dev, dequeue, &trb, TRB_SIZE);
> +        dma_memory_read(xhci->as, dequeue, &trb, TRB_SIZE);
>          le64_to_cpus(&trb.parameter);
>          le32_to_cpus(&trb.status);
>          le32_to_cpus(&trb.control);
> @@ -828,7 +825,7 @@ static void xhci_er_reset(XHCIState *xhci, int v)
>          xhci_die(xhci);
>          return;
>      }
> -    pci_dma_read(PCI_DEVICE(xhci), erstba, &seg, sizeof(seg));
> +    dma_memory_read(xhci->as, erstba, &seg, sizeof(seg));
>      le32_to_cpus(&seg.addr_low);
>      le32_to_cpus(&seg.addr_high);
>      le32_to_cpus(&seg.size);
> @@ -1440,7 +1437,7 @@ static int xhci_xfer_create_sgl(XHCITransfer *xfer, int in_xfer)
>      int i;
>  
>      xfer->int_req = false;
> -    pci_dma_sglist_init(&xfer->sgl, PCI_DEVICE(xhci), xfer->trb_count);
> +    qemu_sglist_init(&xfer->sgl, DEVICE(xhci), xfer->trb_count, xhci->as);
>      for (i = 0; i < xfer->trb_count; i++) {
>          XHCITRB *trb = &xfer->trbs[i];
>          dma_addr_t addr;
> @@ -2101,7 +2098,7 @@ static TRBCCode xhci_address_slot(XHCIState *xhci, unsigned int slotid,
>      assert(slotid >= 1 && slotid <= xhci->numslots);
>  
>      dcbaap = xhci_addr64(xhci->dcbaap_low, xhci->dcbaap_high);
> -    poctx = ldq_le_pci_dma(PCI_DEVICE(xhci), dcbaap + 8 * slotid);
> +    poctx = ldq_le_dma(xhci->as, dcbaap + 8 * slotid);
>      ictx = xhci_mask64(pictx);
>      octx = xhci_mask64(poctx);
>  
> @@ -2439,7 +2436,7 @@ static TRBCCode xhci_get_port_bandwidth(XHCIState *xhci, uint64_t pctx)
>      /* TODO: actually implement real values here */
>      bw_ctx[0] = 0;
>      memset(&bw_ctx[1], 80, xhci->numports); /* 80% */
> -    pci_dma_write(PCI_DEVICE(xhci), ctx, bw_ctx, sizeof(bw_ctx));
> +    dma_memory_write(xhci->as, ctx, bw_ctx, sizeof(bw_ctx));
>  
>      return CC_SUCCESS;
>  }
> @@ -3431,6 +3428,7 @@ static void usb_xhci_realize(struct PCIDevice *dev, Error **errp)
>      }
>  
>      usb_xhci_init(xhci);
> +    xhci->as = pci_get_address_space(dev);
>      xhci->mfwrap_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, xhci_mfwrap_timer, xhci);
>  
>      memory_region_init(&xhci->mem, OBJECT(xhci), "xhci", LEN_REGS);
> @@ -3531,7 +3529,7 @@ static int usb_xhci_post_load(void *opaque, int version_id)
>              continue;
>          }
>          slot->ctx =
> -            xhci_mask64(ldq_le_pci_dma(pci_dev, dcbaap + 8 * slotid));
> +            xhci_mask64(ldq_le_dma(xhci->as, dcbaap + 8 * slotid));
>          xhci_dma_read_u32s(xhci, slot->ctx, slot_ctx, sizeof(slot_ctx));
>          slot->uport = xhci_lookup_uport(xhci, slot_ctx);
>          if (!slot->uport) {
> diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
> index 946af51..edbd926 100644
> --- a/hw/usb/hcd-xhci.h
> +++ b/hw/usb/hcd-xhci.h
> @@ -22,6 +22,8 @@
>  #ifndef HW_USB_HCD_XHCI_H
>  #define HW_USB_HCD_XHCI_H
>  
> +#include "sysemu/dma.h"

AddressSpace is forward-declared in "qemu/typedefs.h",
so no need to include it here (yes in the sources including
hcd-xhci.h).

With that fixed:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +
>  #define TYPE_XHCI "base-xhci"
>  #define TYPE_NEC_XHCI "nec-usb-xhci"
>  #define TYPE_QEMU_XHCI "qemu-xhci"
> @@ -189,6 +191,7 @@ struct XHCIState {
>  
>      USBBus bus;
>      MemoryRegion mem;
> +    AddressSpace *as;
>      MemoryRegion mem_cap;
>      MemoryRegion mem_oper;
>      MemoryRegion mem_runtime;
> 


