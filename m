Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC63DC433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 06:56:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06D08206B8
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 06:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcC/bCR7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D08206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFB4r-000440-Qb
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 02:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kFB3y-0002ok-ES; Mon, 07 Sep 2020 02:55:38 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:47000)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kFB3v-0006s6-GC; Mon, 07 Sep 2020 02:55:36 -0400
Received: by mail-lf1-x142.google.com with SMTP id u27so6896166lfm.13;
 Sun, 06 Sep 2020 23:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=WrRktfKg9nVHXVgZREzitAzJFDIfClOLqyiAcxjhWIU=;
 b=kcC/bCR7FLABysZnzysNwBebonmc4rHoO7n4AWZHtcLIeyk7aPKROOHBxHPscivYfx
 5A4JQoW7zQOnwJJYehuUZlWOITUhrF1tiEQpaD7DeFLa2vRWFqdtSeUOlR0dJcl2F+b1
 QcnB2INOs2GRPX1L577Mv/sXTbmmoTMOdCq8c1Kika/dYMPDZcLkljjrxLpc3a54IevX
 8kMPcYghjgheqgLkG2bOoruzoCSy8Fx2+KvTViwOB9SUbQuaXzCM4Vg+r2Hpqno57kzZ
 eO/prZjcSw2gciulLvDVo8bCeWPQgUXwSNyAVkr7lKHYcufXrrTPyfftclen/nYK4c/H
 rXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=WrRktfKg9nVHXVgZREzitAzJFDIfClOLqyiAcxjhWIU=;
 b=l5PPf5C8Kx7GlOb4CIWU/Y8ldsV34yaS1/KBrvO+EL87wLPXfKpOEn9BVVjYCPXB0I
 HO0wyLvtzuwSDCYEOub2dxKmN5r6DI0kQo7snXBhWRHsrSzq7LSQwuMu3VspPCMFP86/
 4AdBapNLg1gBcVL27h55weyBy/oRsjl9DsqyNUP65y3yLnmopsxfCn3zwA1DqUB6z9rE
 fq/YK+FId558LktohZJdMyIT2/h17NFuuDksRiaduppIhyjYIK+lJxoxkQeexZnA5GcQ
 R8J+wq8tBPi2SGoB53Kxn0R2xIO8VVK5tYZRl/Mz/StPz2MSxZ+8T4rAKJDE8ic/Lmm7
 TVtA==
X-Gm-Message-State: AOAM533vXoOeyb3YhOXRKpZKC1p5Ab+/OCulnOe9vvFW66fJpODNhpis
 L7VQI18wupgaZ+3BALcWe5k=
X-Google-Smtp-Source: ABdhPJwNBJ6B7VLUd7EuVOY+x0FX1CmKjvfwm73joRJv4QqQNLgtHIEfZtXuAGKpqvGbCuwdHLyBxQ==
X-Received: by 2002:a19:7605:: with SMTP id c5mr9463190lff.116.1599461730780; 
 Sun, 06 Sep 2020 23:55:30 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id u9sm6188528ljh.20.2020.09.06.23.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2020 23:55:29 -0700 (PDT)
Date: Mon, 7 Sep 2020 08:55:28 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 03/13] dma: Document
 address_space_map/address_space_unmap() prototypes
Message-ID: <20200907065528.GY2954729@toto>
References: <20200904154439.643272-1-philmd@redhat.com>
 <20200904154439.643272-4-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200904154439.643272-4-philmd@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=2.633, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-block@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>,
 Joel Stanley <joel@jms.id.au>, David Gibson <david@gibson.dropbear.id.au>,
 Laszlo Ersek <lersek@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, Jan Kiszka <jan.kiszka@web.de>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Andrew Jeffery <andrew@aj.id.au>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 04, 2020 at 05:44:29PM +0200, Philippe Mathieu-Daudé wrote:
> Add documentation based on address_space_map / address_space_unmap.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  include/sysemu/dma.h | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
> index 80c5bc3e02d..19bc9ad1b69 100644
> --- a/include/sysemu/dma.h
> +++ b/include/sysemu/dma.h
> @@ -1,7 +1,7 @@
>  /*
>   * DMA helper functions
>   *
> - * Copyright (c) 2009 Red Hat
> + * Copyright (c) 2009, 2020 Red Hat
>   *
>   * This work is licensed under the terms of the GNU General Public License
>   * (GNU GPL), version 2 or later.
> @@ -125,6 +125,20 @@ static inline int dma_memory_write(AddressSpace *as, dma_addr_t addr,
>  
>  int dma_memory_set(AddressSpace *as, dma_addr_t addr, uint8_t c, dma_addr_t len);
>  
> +/**
> + * address_space_map: Map a physical memory region into a DMA controller
> + *                    virtual address

It may be easier to understand this if you change DMA controller virtual address
to host virtual address.

Either way:
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



> + *
> + * May map a subset of the requested range, given by and returned in @plen.
> + * May return %NULL and set *@plen to zero(0), if resources needed to perform
> + * the mapping are exhausted.
> + * Use only for reads OR writes - not for read-modify-write operations.
> + *
> + * @as: #AddressSpace to be accessed
> + * @addr: address within that address space
> + * @len: pointer to length of buffer; updated on return
> + * @dir: indicates the transfer direction
> + */
>  static inline void *dma_memory_map(AddressSpace *as,
>                                     dma_addr_t addr, dma_addr_t *len,
>                                     DMADirection dir)
> @@ -138,6 +152,20 @@ static inline void *dma_memory_map(AddressSpace *as,
>      return p;
>  }
>  
> +/**
> + * address_space_unmap: Unmaps a memory region previously mapped
> + *                      by dma_memory_map()
> + *
> + * Will also mark the memory as dirty if @dir == %DMA_DIRECTION_FROM_DEVICE.
> + * @access_len gives the amount of memory that was actually read or written
> + * by the caller.
> + *
> + * @as: #AddressSpace used
> + * @buffer: host pointer as returned by address_space_map()
> + * @len: buffer length as returned by address_space_map()
> + * @dir: indicates the transfer direction
> + * @access_len: amount of data actually transferred
> + */
>  static inline void dma_memory_unmap(AddressSpace *as,
>                                      void *buffer, dma_addr_t len,
>                                      DMADirection dir, dma_addr_t access_len)
> -- 
> 2.26.2
> 

