Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD69FC4727D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 701712086A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0z26b7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 701712086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLoFq-0007q6-JI
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 09:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1kLoDu-0004vV-5h
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 09:57:18 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:33258)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1kLoDs-0001jt-21
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 09:57:17 -0400
Received: by mail-io1-xd42.google.com with SMTP id r25so2851330ioj.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 06:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HzxiBbkFjxXyI3NNu62FTkU8w+N5v/t8ZRNLVHbK+Eg=;
 b=M0z26b7wLXyIadukmFbwZtEgtl5E3n8YJNkd50Rr+sG8C10sCFiA9+U/yabHB+O/IO
 zn6F2pjiAzw/eUjcaLtc5oEdGG7mNudp1Kjaa3vJleZLSenaSJEEOGx1McPJyrntBuZd
 4weu0fLT9+1yT6ogHHxglyXljeEMDERZtcFM143pjdqJp71MskziYY0DCiTMkrsF2acK
 ArbSYk4XySj85prU/pmh0ofyT0rylHN5of01iIO95Bla+kwuOKlbppk/ekpRtig/CY6J
 uySnZVStwVKJt0/TSEhxt5IgfXKJn7Z1OCNnpV0yIvS2D7cUVM3Wwvg8vPZG2QgKpOes
 LF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HzxiBbkFjxXyI3NNu62FTkU8w+N5v/t8ZRNLVHbK+Eg=;
 b=hw107jLPi3kK7wvEQrBel0RqKwtZqpx75oxsuvJwq/nB7edvwGaOVyUS6tEFWYK4Ws
 q6CpkWsa1lRG5iiJF8GR91AQK+kVv8qdF5OQE39c6UplRhZGjZzjkqkR0oOlMXK126DI
 pMDf4MMI6zdZdhrLsr73Jby8FTAuCYe5izEehWoZ5NSP8SIiSWlDhBdjYt6o8+8jJ04X
 MtCUpubsMrYqWz31GZztcFp9qpMzB9ILgwvNo+CqHOs2xhrmHJ6GOA4795Xmkk4T4FJk
 DkwUnVaYa5btR2mIN3dC9FLIJevwc6ijbunIw3ORG2v/1qdZ7OQ2RCYKrKtvXYeY+2qr
 IdhQ==
X-Gm-Message-State: AOAM5306PDNjui1yyKZ+EBBvrtmSuPfQXpilR0FGwbuEBAZjnAuKGBSK
 QUoZNKwR9AB84U1OPIuuAax09lwKTO9cHK1e8HY=
X-Google-Smtp-Source: ABdhPJyULfH5OQb1DVSWplRrW1F45sN7ngLCc+lw5fCFLDVKo1k1agRpmNEtU171vogsDZKOX1CMQuL/S0T5/Bnc7eY=
X-Received: by 2002:a6b:2b45:: with SMTP id r66mr292777ior.159.1601042235031; 
 Fri, 25 Sep 2020 06:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200923113900.72718-1-david@redhat.com>
 <20200923113900.72718-3-david@redhat.com>
In-Reply-To: <20200923113900.72718-3-david@redhat.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Fri, 25 Sep 2020 15:57:03 +0200
Message-ID: <CAM9Jb+i=ZoYY6HZcntTAsc0mamdk+CYOhG1m0UvafShbszw1qQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] virtio-mem: Check that "memaddr" is multiples of
 the block size
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=pankaj.gupta.linux@gmail.com; helo=mail-io1-xd42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 Wei Yang <richardw.yang@linux.intel.com>,
 Qemu Developers <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> The spec requires us to set the "addr" in guest physical address space to
> multiples of the block size. In some cases, this is not the case right
> now: For example, when starting a VM with 4 GiB boot memory and a
> virtio-mem device with a block size of 2 GiB, "memaddr" will be
> auto-assigned to 0x140000000 / 5 GiB.
>
> We'll try to improve auto-assignment for memory devices next, to avoid
> bailing out in case memory device code selects a bad address.
>
> Note: The Linux driver doesn't support such big block sizes yet.
>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Wei Yang <richardw.yang@linux.intel.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/virtio/virtio-mem.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> index 58098686ee..716eddd792 100644
> --- a/hw/virtio/virtio-mem.c
> +++ b/hw/virtio/virtio-mem.c
> @@ -515,6 +515,11 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
>                     ")", VIRTIO_MEM_REQUESTED_SIZE_PROP,
>                     VIRTIO_MEM_BLOCK_SIZE_PROP, vmem->block_size);
>          return;
> +    } else if (!QEMU_IS_ALIGNED(vmem->addr, vmem->block_size)) {
> +        error_setg(errp, "'%s' property has to be multiples of '%s' (0x%" PRIx64
> +                   ")", VIRTIO_MEM_ADDR_PROP, VIRTIO_MEM_BLOCK_SIZE_PROP,
> +                   vmem->block_size);
> +        return;
>      } else if (!QEMU_IS_ALIGNED(memory_region_size(&vmem->memdev->mr),
>                                  vmem->block_size)) {
>          error_setg(errp, "'%s' property memdev size has to be multiples of"
> --
> 2.26.2

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

