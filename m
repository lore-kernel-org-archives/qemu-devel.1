Return-Path: <SRS0=i/12=ZI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1846C432C3
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2019 11:58:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C1EC206D3
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2019 11:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xVjMuu35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1EC206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVwiy-0001Xk-OC
	for qemu-devel@archiver.kernel.org; Sat, 16 Nov 2019 06:58:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33129)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iVwiJ-00018v-HR
 for qemu-devel@nongnu.org; Sat, 16 Nov 2019 06:58:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iVwiI-0005qI-5d
 for qemu-devel@nongnu.org; Sat, 16 Nov 2019 06:58:03 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34205)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iVwiH-0005p9-Uz
 for qemu-devel@nongnu.org; Sat, 16 Nov 2019 06:58:02 -0500
Received: by mail-wm1-x341.google.com with SMTP id j18so12036093wmk.1
 for <qemu-devel@nongnu.org>; Sat, 16 Nov 2019 03:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=13dNquSSRitB2BWBZ3cHJne+NyQsQFYPvMcE+AYL8WA=;
 b=xVjMuu35I4/y8d6vQ10JESe5EJLjYvzpqVB7jjKXjKxeXlmMmagqfj02fuC1I/cRqk
 0a8mVV8xyxD0daOfa0bGpHjrhyR7B/J5WyYlDVk66uE8ug7cuEZHyhZE/1NlMtKlwgvl
 ncJHMA0GicF0NAlS4YoM9OKtgT56o/EsJua+RQAJyH3/lq6aevEuzZzp4YYRWDE6QUid
 X+niJUcVvPAl97E1bHBH6GYiqvdcSGsNWesMJfFTdujeRkwyNfanNnZm2t745RH21JBQ
 sVAFBJknipl6v6pIZvogKgaGZ3UUWLbPr43eGVN/iiBgmWE9qvO7PAraaedOBOIcIbAm
 QbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=13dNquSSRitB2BWBZ3cHJne+NyQsQFYPvMcE+AYL8WA=;
 b=UH8q2W9BSNKqGZIuHLC+wVPdC9nrK48L+oVu4TW0Wjx2dvetd2AzZUZbPbqM3UUN8Q
 GJbqvYGb1OVjVsUs+sQCs/snru/lvE3PKiSYKQuO3IAFcLWokgOO0paFRmOQp4XDuHAW
 8UyHCg47fWc+eXnMX+MavmfPMHTOrITiGUqT25uEMI4ARbkhSXtsS/Qjl4eewpHfmnc3
 MPBF3AKWw01Ndm2hjNMWKM/xYpI509cxI+Hd1hsgXYF3iS2fgm3ZjFnOBPsmlojQKXNa
 QLzCQngyirBRVENgt1Xw8DGLhCB18FsNoExuKFxdedIrFBhnvzK8KIkJRFkUy+LTpBkR
 KgmQ==
X-Gm-Message-State: APjAAAVxh4eJg7PyaKoDKAWZkv6PzYkCWrL5ICHq5q4EVW8dLeBSiR5S
 ypzQbAmeJHPtltT7we4xzLhA4g==
X-Google-Smtp-Source: APXvYqzkPNiIhQmm0K0yR9wJ+2z36qAEi6495VGdjLzjsqeKyx4KaRxEDIV7Lwl3O4cWbc/GWOx7yw==
X-Received: by 2002:a7b:c411:: with SMTP id k17mr2315490wmi.119.1573905480609; 
 Sat, 16 Nov 2019 03:58:00 -0800 (PST)
Received: from [192.168.8.102] (87.red-176-87-99.dynamicip.rima-tde.net.
 [176.87.99.87])
 by smtp.gmail.com with ESMTPSA id y6sm15147009wrw.6.2019.11.16.03.57.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 16 Nov 2019 03:57:59 -0800 (PST)
Subject: Re: [PATCH v1 1/5] Add a mutex to guarantee single writer to
 qemu_logfile handle.
To: Robert Foley <robert.foley@linaro.org>, qemu-devel@nongnu.org
References: <20191112150105.2498-1-robert.foley@linaro.org>
 <20191112150105.2498-2-robert.foley@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <f41150bd-81dc-f754-be91-72065b31cae4@linaro.org>
Date: Sat, 16 Nov 2019 12:57:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191112150105.2498-2-robert.foley@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: peter.puhov@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/12/19 4:01 PM, Robert Foley wrote:
> Also added qemu_logfile_init() for initializing the logfile mutex.
> 
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> ---
> v1
>     - changed qemu_logfile_init() to use __constructor__.
> ---
>  util/log.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/util/log.c b/util/log.c
> index 1ca13059ee..c25643dc99 100644
> --- a/util/log.c
> +++ b/util/log.c
> @@ -24,8 +24,10 @@
>  #include "qapi/error.h"
>  #include "qemu/cutils.h"
>  #include "trace/control.h"
> +#include "qemu/thread.h"
>  
>  static char *logfilename;
> +static QemuMutex qemu_logfile_mutex;
>  FILE *qemu_logfile;
>  int qemu_loglevel;
>  static int log_append = 0;
> @@ -49,6 +51,11 @@ int qemu_log(const char *fmt, ...)
>      return ret;
>  }
>  
> +static void __attribute__((__constructor__)) qemu_logfile_init(void)
> +{
> +    qemu_mutex_init(&qemu_logfile_mutex);
> +}
> +
>  static bool log_uses_own_buffers;
>  
>  /* enable or disable low levels log */
> @@ -58,6 +65,9 @@ void qemu_set_log(int log_flags)
>  #ifdef CONFIG_TRACE_LOG
>      qemu_loglevel |= LOG_TRACE;
>  #endif
> +
> +    g_assert(qemu_logfile_mutex.initialized);

Why the asserts?

If you want a runtime test, then use the test to initialize it.
Otherwise, trust the constructor.


r~

