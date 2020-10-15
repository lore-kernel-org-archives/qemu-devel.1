Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C969CC433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:31:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28FC82225B
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GPWdYpvY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28FC82225B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT3M4-0004E2-W9
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 09:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kT3KB-0002vJ-7n
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:29:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48866)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kT3K9-0007Mm-Fx
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:29:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602768580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wWIj/V+At6wGcT9oMPT+XqqE/jReRtUlFwmdw1Nr46E=;
 b=GPWdYpvY/Vl83raT55PHlxjiNkWkk9NOJsS28mZ2THIBbiMITyUEkRA4OTLg/s+j9P6ANF
 mz/YjL5/iRadcAGlDs1T6H7ttvqdo7PzplOy1mLcLDsehQh98TuK4cS5+xRnshRYgMk5BY
 3+H9NOZ8vfWsUIKY5/HdoewtTF6CxZQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-rf5dbduvPeOCez_JewTb3g-1; Thu, 15 Oct 2020 09:29:37 -0400
X-MC-Unique: rf5dbduvPeOCez_JewTb3g-1
Received: by mail-wr1-f71.google.com with SMTP id r8so1887050wrp.5
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 06:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wWIj/V+At6wGcT9oMPT+XqqE/jReRtUlFwmdw1Nr46E=;
 b=ESxaf9lAoznujPlMbfbkuYoAEHkay6rA98Zs6na/W15DEfv87Iu9B+ByTTIUh1XIsN
 2+DTqNZmtUIENArFlL24PZr7FGxEJRW8XuM+SzvRLA8G5UoFtGtC1VC7PzyYFIca1unu
 OeZKuxZ5Cn1u7R/cJ/sksnzwxbZmYs8WBZOQ3FYqXt/ODN/PzR7MZT0Q7cMU0WK4CRCm
 DGQvblIGP6IKUK+jz0gzAIHfTSkCOcMPoFtTShtGfomql1+VNi7oqqjtOfDBI7mOJjdd
 ZZYEQXHTyCevrUwPxqqD2HjB4OxN8i8VxD9CIhI+vK0RSzvK30EdCS9dt1aecJO8SQ3M
 v9iw==
X-Gm-Message-State: AOAM5338oMqg/6MEdbFggNnXfDMPGG1uL0hD5vPHmjWVMFbr5G5WMaJS
 PbqGaTsoz7xnhEzk0PGilmb1NMma2cwkR1y1sPiV+ksrYsUtUtFEMSWChg3FQ9s9jkaHpSBVhl7
 X6GAVMghXCcmCn+8=
X-Received: by 2002:adf:bc4a:: with SMTP id a10mr4402097wrh.253.1602768576576; 
 Thu, 15 Oct 2020 06:29:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdexvqVOJ0YXy42kPmOHI1vQRe1EQ8lUJoib1nwcIfH1C24evWt8k6JPh0LNJZyTGj7THFyw==
X-Received: by 2002:adf:bc4a:: with SMTP id a10mr4402072wrh.253.1602768576330; 
 Thu, 15 Oct 2020 06:29:36 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id a127sm4827909wmh.13.2020.10.15.06.29.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2020 06:29:35 -0700 (PDT)
Subject: Re: [RFC 1/5] block/nvme: use some NVME_CAP_* macros
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, stefanha@redhat.com,
 fam@euphon.net, alex.williamson@redhat.com
References: <20201015115252.15582-1-eric.auger@redhat.com>
 <20201015115252.15582-2-eric.auger@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ca512856-40a7-01a6-ec82-3a5b8c81b52a@redhat.com>
Date: Thu, 15 Oct 2020 15:29:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201015115252.15582-2-eric.auger@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:38:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.019, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/15/20 1:52 PM, Eric Auger wrote:
> let's use NVME_CAP_DSTRD, NVME_CAP_MPSMIN and NVME_CAP_TO macros
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   block/nvme.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/block/nvme.c b/block/nvme.c
> index f4f27b6da7..e3d96f20d0 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -728,10 +728,10 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
>           goto out;
>       }
>   
> -    s->page_size = MAX(4096, 1 << (12 + ((cap >> 48) & 0xF)));
> -    s->doorbell_scale = (4 << (((cap >> 32) & 0xF))) / sizeof(uint32_t);
> +    s->page_size = MAX(4096, 1 << (12 + NVME_CAP_MPSMIN(cap)));

Are you suggesting commit fad1eb68862 ("block/nvme: Use register
definitions from 'block/nvme.h'") is buggy?

> +    s->doorbell_scale = (4 << ((NVME_CAP_DSTRD(cap)))) / sizeof(uint32_t);
>       bs->bl.opt_mem_alignment = s->page_size;
> -    timeout_ms = MIN(500 * ((cap >> 24) & 0xFF), 30000);
> +    timeout_ms = MIN(500 * NVME_CAP_TO(cap), 30000);
>   
>       /* Reset device to get a clean state. */
>       s->regs->ctrl.cc = cpu_to_le32(le32_to_cpu(s->regs->ctrl.cc) & 0xFE);
> 


