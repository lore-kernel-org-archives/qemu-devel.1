Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA18C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 09:35:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E772A206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 09:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJZGKwT6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E772A206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc45f-0001wy-2T
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 05:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jc43B-0007My-PH
 for qemu-devel@nongnu.org; Fri, 22 May 2020 05:33:09 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46074)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jc43A-0004vg-PM
 for qemu-devel@nongnu.org; Fri, 22 May 2020 05:33:09 -0400
Received: by mail-wr1-x441.google.com with SMTP id c3so5254240wru.12
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 02:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=K8yWd16Tv8GNxoJUk5cqLVj39nB/RnExrCwEptv3Jtc=;
 b=UJZGKwT6deqBBCsVDxyijoljnOqxUnIsHsrH4qQEH2g8uc9G09WeyAS9KwCVCjG0SA
 LXrRyhIkh02ZBINi/Y+eY3GHy7j0j3gDslZVXU3Z5k2c3sgsj4bfPkAZrubFguwABGG1
 OI4kYFX4iktFmchKAyWQe+EjfQeVTE1hztS+1l+es0ZnOtz58yZosGiEP8FHthaYf8O9
 W21uS2DtwozHxesCw/WL9wDd7ZgxLtbWDnYGQjorZ3CuBEwXwEBx9QdKX03R0O+5l+h1
 /g8aAJoc+2FjLk9l3NNjrLWLCSdLOpQnz+rzJ8vWIooYsa5lNay2E6aTB8xHs4WKXP53
 S8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=K8yWd16Tv8GNxoJUk5cqLVj39nB/RnExrCwEptv3Jtc=;
 b=el7BdC5iBL3p4NO+oxIcl3FPqtdrfcsm2qCUPDy5LGcql7b0XdJUmRbE5BQYBQqL4H
 I9HO8+uZCD51jqAca5aUA9bq61jF3OzGxQlq64ed4DXFt239Tk44hoSH31zk12NcBwjh
 Df1bYIp2TV0M40R8ddj9iPNkVMddezOvkZuEjwh8i5XmE5uj7uJ1UE/8nBWn/6lHmgJZ
 pH16WuoZjYFRtdlSCasLpj3Zc2+nXRjD8DUZAt8Xcehc9jo+7NOHNfTSHWe3rbeAl2Tp
 pRJI2QvRPd4GBnUhDaZ5lB9GvTngZR8XWmQtO6AhoKX0RByEQvmPYuaKosUDHFVzQhGI
 P9YA==
X-Gm-Message-State: AOAM530QWrEgrTe94DIV8NU/8yNn0sHH33dyuxG+tuLdnDBRhBm+asGE
 WYgkU/6OMpRYIVABJtyoJIw=
X-Google-Smtp-Source: ABdhPJz+3mHhz4MW3vLBLVTy8EoEXsDVoBuIi+6DinYTpjNi50gjA4hYoy/wkQU/zi/+NjfQEGC0jQ==
X-Received: by 2002:a5d:4c4f:: with SMTP id n15mr2850887wrt.249.1590139987322; 
 Fri, 22 May 2020 02:33:07 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id y5sm3969423wrs.63.2020.05.22.02.33.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2020 02:33:06 -0700 (PDT)
Subject: Re: [PATCH v1 7/8] tests/tcg: add new threadcount test
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200513173200.11830-1-alex.bennee@linaro.org>
 <20200513173200.11830-8-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d0a13139-49b5-05ac-cc60-b33fb49a27fa@amsat.org>
Date: Fri, 22 May 2020 11:33:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200513173200.11830-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Nikolay Igotti <igotti@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/13/20 7:31 PM, Alex Bennée wrote:
> Based on the original testcase by Nikolay Igotti.
> 
> Message-ID: <CAEme+7GLKg_dNsHizzTKDymX9HyD+Ph2iZ=WKhOw2XG+zhViXg@mail.gmail.com>
> Cc: Nikolay Igotti <igotti@gmail.com>
> [Nikolay can we have your signed of by to add the testcase?]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/tcg/multiarch/threadcount.c   | 62 +++++++++++++++++++++++++++++
>   tests/tcg/multiarch/Makefile.target |  2 +
>   2 files changed, 64 insertions(+)
>   create mode 100644 tests/tcg/multiarch/threadcount.c
> 
> diff --git a/tests/tcg/multiarch/threadcount.c b/tests/tcg/multiarch/threadcount.c
> new file mode 100644
> index 00000000000..546dd90eeb2
> --- /dev/null
> +++ b/tests/tcg/multiarch/threadcount.c
> @@ -0,0 +1,62 @@
> +/*
> + * Thread Exerciser
> + *
> + * Unlike testthread which is mainly concerned about testing thread
> + * semantics this test is used to exercise the thread creation and
> + * accounting. A version of this test found a problem with clashing
> + * cpu_indexes which caused a break in plugin handling.
> + *
> + * Based on the original test case by Nikolay Igotti.
> + *
> + * Copyright (c) 2020 Linaro Ltd
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <pthread.h>
> +
> +int max_threads = 10;
> +
> +typedef struct {
> +    int delay;
> +} ThreadArg;
> +
> +static void *thread_fn(void* varg)  {
> +    ThreadArg* arg = varg;
> +    usleep(arg->delay);
> +    free(arg);
> +    return NULL;
> +}
> +
> +int main(int argc, char **argv) {
> +    int i;
> +    pthread_t *threads;
> +
> +    if (argc > 1) {
> +        max_threads = atoi(argv[1]);
> +    }
> +    threads = calloc(sizeof(pthread_t), max_threads);
> +
> +    for (i = 0; i < max_threads; i++) {
> +        ThreadArg* arg = calloc(sizeof(ThreadArg), 1);
> +        arg->delay = i * 100;
> +        pthread_create(threads + i, NULL, thread_fn, arg);
> +    }
> +
> +    printf("Created %d threads\n", max_threads);
> +
> +    /* sleep until roughly half the threads have "finished" */
> +    usleep(max_threads * 50);
> +
> +    for (i = 0; i < max_threads; i++) {
> +        pthread_join(threads[i], NULL);
> +    }
> +
> +    printf("Done\n");
> +
> +    return 0;
> +}
> diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
> index 51fb75ecfdd..cb49cc9ccb2 100644
> --- a/tests/tcg/multiarch/Makefile.target
> +++ b/tests/tcg/multiarch/Makefile.target
> @@ -28,6 +28,8 @@ run-float_%: float_%
>   
>   testthread: LDFLAGS+=-lpthread
>   
> +threadcount: LDFLAGS+=-lpthread
> +
>   # We define the runner for test-mmap after the individual
>   # architectures have defined their supported pages sizes. If no
>   # additional page sizes are defined we only run the default test.
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

