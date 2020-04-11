Return-Path: <SRS0=9/5m=53=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFA7C2BA19
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 20:13:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78BEC20CC7
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 20:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UlLcb2yp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78BEC20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNMUy-0004BL-K3
	for qemu-devel@archiver.kernel.org; Sat, 11 Apr 2020 16:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45395)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jNMTr-0002lM-SQ
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 16:11:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jNMTq-00072c-RL
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 16:11:55 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:51631)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jNMTq-00072K-LT
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 16:11:54 -0400
Received: by mail-pj1-x1041.google.com with SMTP id e16so1851935pjp.1
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2020 13:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=56ECiAV8GODj17SLrwrSpGtHX4YSTl6PzQOgS1DX9Gs=;
 b=UlLcb2ypcf/70RaZDdoV5/JmectnPrsZL/yaNDJP7VPaJ9KZ8pDnzBqtaXbpfCG1Gf
 MWb7VDJTvC25bwcfaE0SaVEIKYTZriniHwNJlNAgQTK3ukheqRBdvyJDHLwmiykcuHXN
 kPVHnA1X215/Ui84qaDFyNMg4O1T0mMpfW0MEitJtPQmenDmoadYnTwUH5LUKvZiXy/v
 GM8yjgTDtp/C2KCcpB9gSdOfoPqZATRJw9d77DOFxTFlxngsTYedvSC/hhT+bHgsiTY2
 39qM6ha4xAjkU5BSFP7caczSGcjSvynIj+2ebgVD4ra1pLhVQZfUJ1ErMaCXKn8Cj3SK
 PABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=56ECiAV8GODj17SLrwrSpGtHX4YSTl6PzQOgS1DX9Gs=;
 b=DgW1qnTlan8YwVmQvAWSPef7exJISnHj3BmLt0yMB4Qekd2TUF08uucJCbjnpgUFL3
 0Q/cnz0EDVxJi0ZjhPZyyDdGOCmLSF+uW6HSEFeTo1VFdqxICBJ3DhEi9ybY0hQy6l75
 XTvLsOyGvAvw2ZabSNr1bzYDkmRxCSbgKe7h9Csjl5IlqoC7WcFm+991hME+J+MYTUtO
 ua3q9yxdW3DpowiXSmxkQoZxEX1SU8W2vXhUnZPixEDYs/L+r79VcSl7FVlv3zLzxv1z
 fu2yKjg6i6+Ie4h2470vRp2a73ySu+7z4qYYDhBGP4Tkby+U06usORUO5nkVJR/Heke8
 PiRQ==
X-Gm-Message-State: AGi0PubfGhCoM37AEkadpSeheS6AV43KdhzB26h/0ibg+yCc7Pa7s+Fy
 1jpIkrSvfJpkSz6Xj1k1oVMu+/FmW5I=
X-Google-Smtp-Source: APiQypIsJSJQb576F3KcM5ZQxKrfK4EUs/daW9+esb4Su2Dolyf9wzB01tp539JL6ERX8Muqy/6D6g==
X-Received: by 2002:a17:902:8305:: with SMTP id
 bd5mr10008530plb.114.1586635913549; 
 Sat, 11 Apr 2020 13:11:53 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id i124sm4756620pfg.14.2020.04.11.13.11.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Apr 2020 13:11:52 -0700 (PDT)
Subject: Re: [PATCH for-5.0? 2/3] scripts/kernel-doc: Add missing close-paren
 in c:function directives
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200411182934.28678-1-peter.maydell@linaro.org>
 <20200411182934.28678-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6fbcc5f8-aea2-f20f-313c-f904375aa705@linaro.org>
Date: Sat, 11 Apr 2020 13:11:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200411182934.28678-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/11/20 11:29 AM, Peter Maydell wrote:
> When kernel-doc generates a 'c:function' directive for a function
> one of whose arguments is a function pointer, it fails to print
> the close-paren after the argument list of the function pointer
> argument, for instance:
>   .. c:function:: void memory_region_init_resizeable_ram (MemoryRegion * mr, struct Object * owner, const char * name, uint64_t size, uint64_t max_size, void (*resized) (const char*, uint64_t length, void *host, Error ** errp)
> 
> which should have a ')' after the 'void *host' which is the
> last argument to 'resized'.
> 
> Older versions of Sphinx don't try to parse the argumnet
> to c:function, but Sphinx 3.0 does do this and will complain:
> 
>   /home/petmay01/linaro/qemu-from-laptop/qemu/docs/../include/exec/memory.h:834: WARNING: Error in declarator or parameters
>   Invalid C declaration: Expecting "," or ")" in parameters, got "EOF". [error at 208]
>     void memory_region_init_resizeable_ram (MemoryRegion * mr, struct Object * owner, const char * name, uint64_t size, uint64_t max_size, void (*resized) (const char*, uint64_t length, void *host, Error ** errp)
>     ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------^
> 
> Add the missing close-paren.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  scripts/kernel-doc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


