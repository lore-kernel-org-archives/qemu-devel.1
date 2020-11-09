Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344D4C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:31:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7284E206D8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DKSPqQJI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7284E206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc8Ck-0001hP-Bt
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 09:31:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kc85a-00037X-RP
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 09:24:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39178)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kc85Z-0007Cp-3M
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 09:24:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604931848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Fkd1wsPMAMcY0pfaFLrNu+/4wsDFWRRmkpEb/tpppU=;
 b=DKSPqQJIDJvANXQL8bwj8v9fQQj4HAFxV8ZHlIo4NJA7ep9koa291qyRTB/Vl4nXzVuJLU
 GCVhdxD8AsIyCBHj0x1s1JczMFdVzSfsOlgjk1gPXyIzFpVW9ac43yyVSmKikQoFy1mdlf
 Cdlmld6ybMty1VSa8PFVSx03mm2KRzs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-AxY8BE1GM2ibiZ3N0fIm5g-1; Mon, 09 Nov 2020 09:24:07 -0500
X-MC-Unique: AxY8BE1GM2ibiZ3N0fIm5g-1
Received: by mail-wm1-f72.google.com with SMTP id u9so2088967wmb.2
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 06:24:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/Fkd1wsPMAMcY0pfaFLrNu+/4wsDFWRRmkpEb/tpppU=;
 b=VaB9Vt2Q4pkfF+LwffsOvv1Es1gTaBnEAJrWpQhiXMaX9wiX3UWPkEDWFP94iA/E0W
 elmKnc/GnASS1RS7BXaEoVfEF3RKfSAefxmyjPfln0zY6K0sRfdTFtHyNJcrbDtPyo05
 7kWlqCmzli5+Yh1BufDc/7YcZx3GFRlxeMJ8hPjo1HMCedI7Qwd5GFOwzadsGpsgoLS3
 E1kv0C0dG1JECJcL7U9xJ6YWlNj0dPN/nL+9UsAOQuRsiNIOc62j/DlWOazD+dK+YJXl
 oOQo58IN2Cmq4GmM55662oUPKnvN+PPhEQWdH6BEGQAt0zluY64la0tNAZkRGEsTa2DI
 z+RA==
X-Gm-Message-State: AOAM531zq5tE1bvTQeXp44C98v/eVR6nQzFhveLSawCReCLhLJiiIF93
 Yy/UWkaw79b/n7FPLROVSu2+l+C3hc2thc0XMNRpC4+eqg61lWSsiXWACZ3M0IbFNXC/c5XGFTJ
 ePLJ3ubVlyiAft7Y=
X-Received: by 2002:a1c:309:: with SMTP id 9mr14130920wmd.80.1604931844619;
 Mon, 09 Nov 2020 06:24:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw/RAy1U8CE+uuOdS/5Z1zSUXOgHwFvA/ymccqODhMo8bofZQe8hXKPCzVthfGBEQSbHs3nZQ==
X-Received: by 2002:a1c:309:: with SMTP id 9mr14130906wmd.80.1604931844448;
 Mon, 09 Nov 2020 06:24:04 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id n10sm3237464wrv.77.2020.11.09.06.24.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 06:24:03 -0800 (PST)
Subject: Re: [PATCH] physmem: improve ram size error messages
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, qemu-devel@nongnu.org
References: <20201022111302.8105-1-pankaj.gupta.linux@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7d480b24-c505-534d-fff8-e54285328ff4@redhat.com>
Date: Mon, 9 Nov 2020 15:24:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201022111302.8105-1-pankaj.gupta.linux@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Li Zhang <li.zhang@cloud.ionos.com>, pankaj.gupta@cloud.ionos.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/10/20 13:13, Pankaj Gupta wrote:
>   Ram size mismatch condition logs below message.
> 
>     "Length mismatch: pc.ram: 0x80000000 in != 0x180000000: Invalid argument"
> 
>   This patch improves the readability of error messages.
>   Removed the superflous "in" and changed "Length" to "Size".
> 
> Signed-off-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Reported-by: Li Zhang <li.zhang@cloud.ionos.com>
> ---
>   softmmu/physmem.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
> index e319fb2a1e..8da184f4a6 100644
> --- a/softmmu/physmem.c
> +++ b/softmmu/physmem.c
> @@ -1756,15 +1756,15 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp)
>   
>       if (!(block->flags & RAM_RESIZEABLE)) {
>           error_setg_errno(errp, EINVAL,
> -                         "Length mismatch: %s: 0x" RAM_ADDR_FMT
> -                         " in != 0x" RAM_ADDR_FMT, block->idstr,
> +                         "Size mismatch: %s: 0x" RAM_ADDR_FMT
> +                         " != 0x" RAM_ADDR_FMT, block->idstr,
>                            newsize, block->used_length);
>           return -EINVAL;
>       }
>   
>       if (block->max_length < newsize) {
>           error_setg_errno(errp, EINVAL,
> -                         "Length too large: %s: 0x" RAM_ADDR_FMT
> +                         "Size too large: %s: 0x" RAM_ADDR_FMT
>                            " > 0x" RAM_ADDR_FMT, block->idstr,
>                            newsize, block->max_length);
>           return -EINVAL;
> 

Queued, thanks.

Paolo


