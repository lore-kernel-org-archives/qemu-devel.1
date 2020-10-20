Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B50FC388F7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:21:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76F102223C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GYUc9j4P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76F102223C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUpiB-0000Yt-64
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 07:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUpgG-0007EC-0f
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 07:19:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20890)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUpgD-0000P9-M7
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 07:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603192787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EMcFP8byCQyMzL0oop4bwWNTFqjXIbIoyTgbUn4Aiqo=;
 b=GYUc9j4P328PATGQBcwQPPIZikm9ND2fRUOJyw/MNZ5zJk8CpIQPURCb20fqo0g9TQCkKo
 vwU+yN2ylroS9YROS2XMDQfKFHk/OgIDS8Y6BwqaJVpoabN1EPcISD5XVG7DsIZIo2gf8+
 lXhHGORTzv+6TUG/Dl2U9FQT050vBtQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-Fw-hZIlmPueWSXxk_wjBiQ-1; Tue, 20 Oct 2020 07:19:45 -0400
X-MC-Unique: Fw-hZIlmPueWSXxk_wjBiQ-1
Received: by mail-wr1-f69.google.com with SMTP id q15so682033wrw.8
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 04:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EMcFP8byCQyMzL0oop4bwWNTFqjXIbIoyTgbUn4Aiqo=;
 b=ShXTAzbBOZGROB8IENWRjDfu+/SSFi9N0jtP1xH6cq8y4+JcIl3Rf8vG/QaY4U2IXi
 Vdn6w8Urj5e7pVEF8FMSe3MJDcpmqkMsECBJ2cTxISBiR8iDEBEpdZxXaNek5+xPvCGp
 AfqLYch/6agPH3Q6uZf1DiG/+AwM4pMfcGnFrrkom0Ndr2SwW+hNZULG5e+lNRvG9qXC
 /XRm6BFCAqpwKu9x8WrhkTiQKNQxbg1Zbosc4u1JV99pg8OlDvuzpjT503L0246pgFLv
 1L34FhDv16qbbGXf+tN7idxkcwyAK4sUUOjGJHONzhy9q11h1ZtWhmQetdJz/3zKLb/C
 bYug==
X-Gm-Message-State: AOAM533ZV4EShyp8DymEURWX57osPnVy4sMCbrEgDtyr3veRe/PToSa6
 7LlVD6lbJpK57ES8MJSiy5Z9YoBtHXWabtZXuquqMSAk4ODgYY/hEaKcLUBTQErXkAFa0qC2Grr
 9hRRUI7nUmHl8jOk=
X-Received: by 2002:a1c:7d49:: with SMTP id y70mr2393738wmc.103.1603192784391; 
 Tue, 20 Oct 2020 04:19:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxvJXiSbO5KWUHdMfMGQ91E/OVPO7XbOUEhjA0izUMBra/xzFBtBKM6IkpWhA3+13WwvZD+w==
X-Received: by 2002:a1c:7d49:: with SMTP id y70mr2393718wmc.103.1603192784162; 
 Tue, 20 Oct 2020 04:19:44 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id d129sm1206416wmd.5.2020.10.20.04.19.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2020 04:19:43 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] util/oslib-win32: Use _aligned_malloc for
 qemu_try_memalign
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20201020111743.2074694-1-philmd@redhat.com>
 <20201020111743.2074694-2-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e223770b-c8ca-387b-cd6e-e1196fe04d41@redhat.com>
Date: Tue, 20 Oct 2020 13:19:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201020111743.2074694-2-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/20/20 1:17 PM, Philippe Mathieu-Daudé wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
> 
> We do not need or want to be allocating page sized quanta.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Reviewed-by: Stefan Weil <sw@weilnetz.de>
> Message-Id: <20201018164836.1149452-1-richard.henderson@linaro.org>

Oops I forgot:
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   util/oslib-win32.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> index e99debfb8dd..29dd05d59d7 100644
> --- a/util/oslib-win32.c
> +++ b/util/oslib-win32.c
> @@ -39,6 +39,7 @@
>   #include "trace.h"
>   #include "qemu/sockets.h"
>   #include "qemu/cutils.h"
> +#include <malloc.h>
>   
>   /* this must come after including "trace.h" */
>   #include <shlobj.h>
> @@ -56,10 +57,8 @@ void *qemu_try_memalign(size_t alignment, size_t size)
>   {
>       void *ptr;
>   
> -    if (!size) {
> -        abort();
> -    }
> -    ptr = VirtualAlloc(NULL, size, MEM_COMMIT, PAGE_READWRITE);
> +    g_assert(size != 0);
> +    ptr = _aligned_malloc(alignment, size);
>       trace_qemu_memalign(alignment, size, ptr);
>       return ptr;
>   }
> @@ -93,9 +92,7 @@ void *qemu_anon_ram_alloc(size_t size, uint64_t *align, bool shared)
>   void qemu_vfree(void *ptr)
>   {
>       trace_qemu_vfree(ptr);
> -    if (ptr) {
> -        VirtualFree(ptr, 0, MEM_RELEASE);
> -    }
> +    _aligned_free(ptr);
>   }
>   
>   void qemu_anon_ram_free(void *ptr, size_t size)
> 


