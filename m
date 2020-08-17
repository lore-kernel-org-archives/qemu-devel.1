Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80E3C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 05:28:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8311820758
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 05:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpQbRXz7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8311820758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7Xgt-0002VE-Pj
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 01:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7XgO-00025N-7C
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 01:27:44 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42912)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7XgM-0007Tp-QL
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 01:27:43 -0400
Received: by mail-wr1-x443.google.com with SMTP id r4so13601225wrx.9
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2020 22:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IlECHUgOml0+MGrFQLbCyfvQ6Xe3OkqSay5Ng7zKs1M=;
 b=QpQbRXz7xSddXHmLYyCpJQ5e5t09UyfQlSP6B7tQBScdv9da2VChD3baaxju0sqbkc
 KNwFocl5jtP2nXP7E4qBhPiUxnytvRRw7ZkWwugwtqqR7RWkRW2pAcXuQLx8HWS/lNe2
 pLH99KscE+gSKyqH9JC0ALWggKz5E0GzYw2dGqdUTGg4ZHiWZa+T60ZCVyu/bAajzRqR
 kb3OwiWFg4Z8aXIhmg1qwX4pK0ckNYfhbz8/lSAz/Pss0eKiwqp82aQzoU8YNNl5lToN
 UqNfT3y26OWjKfP+NoDnbC/WH7jgcRVXCd4kE69+R+P9sMNcCaTRxDWkoVyM/sIiNdbU
 z2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IlECHUgOml0+MGrFQLbCyfvQ6Xe3OkqSay5Ng7zKs1M=;
 b=R9UU4rU4wLZLsnBU5ySLnL57X8/3jadzUXHc6fMVmCE/qfQAj9BGe8L7W+0NlhkUSG
 nE/77m8MoHQaOXIq4UFZOZ7uDCqBN3zqhoMqXtVOXLxBZJ/7AjolFWEUcIKJhpG1PD32
 2YU55OBwFkC9sjEI0M8ojB0Y3VLiqeGIaqxUQysrcvafMkkhZCQlQImhdErmzJW1BDvD
 q3eWyyt7c4hzLoO2PFeA3JAotSZFfsY/vSsajv4dKO2Ypmt36hQu+43UuEjPIJSES7Xj
 ww+V/x6zZhVOpwVa88wLJtMqRxQjr8E6Y1ur9zOwlsphUin5jRjThBxuxH8Fk13E+K0Z
 Hmdg==
X-Gm-Message-State: AOAM5314dOiz0vFsXmQUKMrKpfxxYIvSrqwjcOye1NW18+IEx1NfPrs/
 xUcNZgmkKsJ9afSW928svgM=
X-Google-Smtp-Source: ABdhPJwtNVa2S25/o8otcEG6S7BIbnOBOR47sZnjMqT6C1A0I/xOy2Luc+8nyORQyAYZK+CgKzrB6g==
X-Received: by 2002:adf:9e8b:: with SMTP id a11mr13101468wrf.309.1597642061455; 
 Sun, 16 Aug 2020 22:27:41 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id z15sm30401186wrn.89.2020.08.16.22.27.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2020 22:27:40 -0700 (PDT)
Subject: Re: [PATCH] memory: Initialize MemoryRegionOps for RAM memory regions
To: qemu-devel@nongnu.org
References: <20200816182602.352-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8e562b3d-ead5-b277-4791-66baecdebacb@amsat.org>
Date: Mon, 17 Aug 2020 07:27:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200816182602.352-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Prasad J Pandit <pjp@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Prasad

On 8/16/20 8:26 PM, Philippe Mathieu-Daudé wrote:
> There is an issue when using memory_region_dispatch_read() or
> memory_region_dispatch_write() on RAM memory regions.
> 
> RAM memory regions are initialized as:
> 
>   memory_region_init_ram()
>   -> memory_region_init_ram_nomigrate()
>      -> memory_region_init_ram_shared_nomigrate()
>         -> memory_region_init()
>            -> object_initialize(TYPE_MEMORY_REGION)
>               -> memory_region_initfn()
>                  -> mr->ops = &unassigned_mem_ops;
> 
> Later when accessing the alias, the memory_region_dispatch_read()
> flow is:
> 
>   memory_region_dispatch_read()
>   -> memory_region_dispatch_read1()
>      -> if (mr->ops->read) { ... }
>                    ^^^^^^
>                    NULL deref as unassigned_mem_ops.read is NULL.
> 
>   memory_region_dispatch_write()
>   -> if (mr->ops->write) { ... }
>                 ^^^^^^^
>                 NULL deref as unassigned_mem_ops.read is NULL.
> 
> Fix by initializing the MemoryRegionOps to ram_device_mem_ops,
> this way the memory accesses are properly dispatched using
> memory_region_ram_device_read() / memory_region_ram_device_write().
> 
> Fixes: 4a2e242bbb ("memory: Don't use memcpy for ram_device regions")
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  softmmu/memory.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/softmmu/memory.c b/softmmu/memory.c
> index af25987518..2fce3fef2d 100644
> --- a/softmmu/memory.c
> +++ b/softmmu/memory.c
> @@ -1509,6 +1509,8 @@ void memory_region_init_ram_shared_nomigrate(MemoryRegion *mr,
>      Error *err = NULL;
>      memory_region_init(mr, owner, name, size);
>      mr->ram = true;
> +    mr->ops = &ram_device_mem_ops;
> +    mr->opaque = mr;
>      mr->terminates = true;
>      mr->destructor = memory_region_destructor_ram;
>      mr->ram_block = qemu_ram_alloc(size, share, mr, &err);
> @@ -1533,6 +1535,8 @@ void memory_region_init_resizeable_ram(MemoryRegion *mr,
>      Error *err = NULL;
>      memory_region_init(mr, owner, name, size);
>      mr->ram = true;
> +    mr->ops = &ram_device_mem_ops;
> +    mr->opaque = mr;
>      mr->terminates = true;
>      mr->destructor = memory_region_destructor_ram;
>      mr->ram_block = qemu_ram_alloc_resizeable(size, max_size, resized,
> @@ -1558,6 +1562,8 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
>      Error *err = NULL;
>      memory_region_init(mr, owner, name, size);
>      mr->ram = true;
> +    mr->ops = &ram_device_mem_ops;
> +    mr->opaque = mr;
>      mr->terminates = true;
>      mr->destructor = memory_region_destructor_ram;
>      mr->align = align;
> @@ -1581,6 +1587,8 @@ void memory_region_init_ram_from_fd(MemoryRegion *mr,
>      Error *err = NULL;
>      memory_region_init(mr, owner, name, size);
>      mr->ram = true;
> +    mr->ops = &ram_device_mem_ops;
> +    mr->opaque = mr;
>      mr->terminates = true;
>      mr->destructor = memory_region_destructor_ram;
>      mr->ram_block = qemu_ram_alloc_from_fd(size, mr,
> @@ -1603,6 +1611,8 @@ void memory_region_init_ram_ptr(MemoryRegion *mr,
>  {
>      memory_region_init(mr, owner, name, size);
>      mr->ram = true;
> +    mr->ops = &ram_device_mem_ops;
> +    mr->opaque = mr;
>      mr->terminates = true;
>      mr->destructor = memory_region_destructor_ram;
>      mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
> 

