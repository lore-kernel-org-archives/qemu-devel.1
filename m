Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5ABC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:01:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6455F21534
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UqyHngJF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6455F21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUpOm-0003nr-20
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 07:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUpMo-0002X0-W0
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 06:59:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26363)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUpMl-00064C-9Z
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 06:59:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603191579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sDl3SIP1eENTcbJOMSeeKKGZN4KlER055QA4Gw6BRYc=;
 b=UqyHngJF6IL/vQGWWlFN+9YGjkHn1h0CFcTI7R1cnqqTw9O89x0yHv7EJU3U+NS6WmHwhL
 V2sXGezKpAOtZzjzk5gMySGBNwZB3xjk1mgxvvCrjt1jSLYPZClkD6x44GpqEHKsfyoJLH
 0xTaBwTtGATpvyYd53i5Nn4e5upQTsA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-X84rVtWVO72HmsHizX93xw-1; Tue, 20 Oct 2020 06:59:37 -0400
X-MC-Unique: X84rVtWVO72HmsHizX93xw-1
Received: by mail-wm1-f70.google.com with SMTP id z7so323400wmi.3
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 03:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sDl3SIP1eENTcbJOMSeeKKGZN4KlER055QA4Gw6BRYc=;
 b=PFYxiu7Y9VugT9uFHLvXXffUH0qjbu9IiJ4kwPAxKeKauqEWHB7zr+Vju6iiBD7Z1W
 ke4wf9Xj71ZlxHGG2bVabDs+nQuDWcMUiBdzxBSHzsk94KOwdjPgLfaIChTJMvCJF++g
 KzFQ3R3SjU+JiBd8GEJGt427L8G3tKwNfvvxkUBRle+97OA1VZ/xd4zQNJAw9QfhRL4e
 GaM6viDKBKVSQo/yewRPMA1bhMiXYO5VhwxZCqIVMNL21tR75+NY1rgHStgH9H5hGL0X
 8+d0pMHMGKJE2Opit7++bfXNbEFKqLEi8aML5lCljyn3YtPMPode+H8R9/bV3SYa5REG
 4IAA==
X-Gm-Message-State: AOAM532SAIbdHx87LACIyg+pkn4aXh7IXg59/M/PH44ye4yXBb3v+VBN
 ckVXdNBFhIyWkhUuTzJjeEujiMkkS+217Jh3q+LPHbZqSVTdI+9Abo9+niyDleMDjAmWn5Y3mej
 cXxGjIe/9HoBwTNc=
X-Received: by 2002:adf:ed8f:: with SMTP id c15mr2737425wro.136.1603191576408; 
 Tue, 20 Oct 2020 03:59:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIInzv1bRloDe5gSIZuunMIOmQkjsLtED+zjk6XBkkhfj8eDEwRYDssb7ftg3S3ISQfsB9zg==
X-Received: by 2002:adf:ed8f:: with SMTP id c15mr2737401wro.136.1603191576164; 
 Tue, 20 Oct 2020 03:59:36 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id x22sm2349428wmj.25.2020.10.20.03.59.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2020 03:59:35 -0700 (PDT)
Subject: Re: [RFC 2/5] block/nvme: Change size and alignment of IDENTIFY
 response buffer
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, stefanha@redhat.com,
 fam@euphon.net, alex.williamson@redhat.com
References: <20201015115252.15582-1-eric.auger@redhat.com>
 <20201015115252.15582-3-eric.auger@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5fae4be4-2d62-7fa3-acbd-7da3154fbc47@redhat.com>
Date: Tue, 20 Oct 2020 12:59:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201015115252.15582-3-eric.auger@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/15/20 1:52 PM, Eric Auger wrote:
> In preparation of 64kB host page support, let's change the size
> and alignment of the IDENTIFY command response buffer so that
> the VFIO DMA MAP succeeds. We align on the host page size.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   block/nvme.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/block/nvme.c b/block/nvme.c
> index e3d96f20d0..088ff1825a 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -513,19 +513,21 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
>           .opcode = NVME_ADM_CMD_IDENTIFY,
>           .cdw10 = cpu_to_le32(0x1),
>       };
> +    size_t id_size = QEMU_ALIGN_UP(sizeof(*id), qemu_real_host_page_size);

Do we really need to ALIGN_UP if we then call qemu_try_memalign()?

>   
> -    id = qemu_try_memalign(s->page_size, sizeof(*id));
> +    id = qemu_try_memalign(qemu_real_host_page_size, id_size);
>       if (!id) {
>           error_setg(errp, "Cannot allocate buffer for identify response");
>           goto out;
>       }
> -    r = qemu_vfio_dma_map(s->vfio, id, sizeof(*id), true, &iova);
> +    r = qemu_vfio_dma_map(s->vfio, id, id_size, true, &iova);
>       if (r) {
>           error_setg(errp, "Cannot map buffer for DMA");
>           goto out;
>       }
>   
> -    memset(id, 0, sizeof(*id));
> +    memset(id, 0, id_size);
> +
>       cmd.dptr.prp1 = cpu_to_le64(iova);
>       if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
>           error_setg(errp, "Failed to identify controller");
> @@ -547,7 +549,7 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
>       s->supports_write_zeroes = !!(oncs & NVME_ONCS_WRITE_ZEROES);
>       s->supports_discard = !!(oncs & NVME_ONCS_DSM);
>   
> -    memset(id, 0, sizeof(*id));
> +    memset(id, 0, id_size);
>       cmd.cdw10 = 0;
>       cmd.nsid = cpu_to_le32(namespace);
>       if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
> 


