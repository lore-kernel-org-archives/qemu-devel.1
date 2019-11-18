Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224F0C43215
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 07:48:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5B9620409
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 07:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qyNM7qRP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B9620409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWblT-0004Fq-1P
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 02:48:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45566)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iWbkh-0003hS-Jf
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 02:47:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iWbkg-0003oC-6s
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 02:47:15 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55597)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iWbkg-0003nb-0I
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 02:47:14 -0500
Received: by mail-wm1-x341.google.com with SMTP id b11so16222068wmb.5
 for <qemu-devel@nongnu.org>; Sun, 17 Nov 2019 23:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=AAwFRhwSVohiqTkQ6SVJsPsxHBR1y5GsuQjMUHNAlBY=;
 b=qyNM7qRPFAZfm4AsRK+RJq/uh7dzvhSXOlV4X4SOADKC9HNrm+D99WJ4/eonDJZJ5Q
 SBF1/gYivX8rPziylD2YvY0Nw9yzIl80q0AjWOIS7YMkZcexPSbcJFYK1g++9kHeg3eb
 LRK8/yUCt0ragw9fOUZUgaEt1dTQj0i0cd/mHRyISrKDxJuZy9WasmxQ9YyInVxwozl0
 1nAgJ0ObkJl3gqhwU1U5730mivr6JoSknuzwauYr9cIS9/7b4dsQFjEcfLdGtD4MMUnC
 QDXjqENFvseUp0bXG6itJQVpiZ/Cj8/c5vfO0YSQc5MydARr5kqoAQrMph7Lw015gBdE
 0qUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AAwFRhwSVohiqTkQ6SVJsPsxHBR1y5GsuQjMUHNAlBY=;
 b=O3JlL+ey4JU5Ntl5OucWiU2TjJyZRWVmMLEhSS2SQmcjc/83un/w+CXYkoZOzkBLuJ
 UViB6sJeLz6CQv72h7nEM21fpRP+MhIQQFTHrA87FBaXsiKMscA6ybwN8nbHvwd382fd
 Aer9lQ3EEpLpr1ZrSbt1uG0rJwas/CN1381CoOu//xsJVWVk8Ja3nVpstEpn+J+0nz3e
 /w6LOgYNxHahtUDdJ5HjrYMYPcZf8OOVTz6MfeFJYYHFHz+EMHLpobdwa5fO10vKABvQ
 EKEKkaOHVsL3bUtZZiWWhZ/+UOsydrWgSMSPY7Xg/cYRp5R3VMGHBlcXreJ5/Ad0+2Xz
 Xwlg==
X-Gm-Message-State: APjAAAWvbjy37kL0UMjpZp+26fx67IulOq4S+Ot5wFCBre5XLhmfwa1Q
 +YVGCikcSOu6ewcwjbf6SRBqLQ==
X-Google-Smtp-Source: APXvYqyDQqk3TWhthKUNVvMHRKm7+BQ4kzZcf6F+yBLMXk0MlnQfHMHQe9GUuKX+2Sdqr7W97jfOiw==
X-Received: by 2002:a1c:e08a:: with SMTP id
 x132mr28394772wmg.146.1574063232625; 
 Sun, 17 Nov 2019 23:47:12 -0800 (PST)
Received: from [192.168.8.102] (65.red-79-149-41.dynamicip.rima-tde.net.
 [79.149.41.65])
 by smtp.gmail.com with ESMTPSA id d7sm22481519wrx.11.2019.11.17.23.47.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 17 Nov 2019 23:47:12 -0800 (PST)
Subject: Re: [RFC PATCH 02/11] gdbstub: stop passing GDBState * around
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191115173000.21891-1-alex.bennee@linaro.org>
 <20191115173000.21891-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9c06e53f-3efe-d2e4-1a76-5fc84d8cb6ea@linaro.org>
Date: Mon, 18 Nov 2019 08:47:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191115173000.21891-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: damien.hedde@greensocs.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 luis.machado@linaro.org, alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/15/19 6:29 PM, Alex Bennée wrote:
> We only have one GDBState which should be allocated at the time we
> process any commands. This will make further clean-up a bit easier.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  gdbstub.c | 307 +++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 177 insertions(+), 130 deletions(-)
> 
> diff --git a/gdbstub.c b/gdbstub.c
> index c5b6701825f..2e6ff5f583c 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1399,7 +1399,6 @@ static int cmd_parse_params(const char *data, const char *schema,
>  }
>  
>  typedef struct GdbCmdContext {
> -    GDBState *s;
>      GdbCmdVariant *params;
>      int num_params;
>      uint8_t mem_buf[MAX_PACKET_LENGTH];
> @@ -1480,7 +1479,7 @@ static int process_string_cmd(GDBState *s, void *user_ctx, const char *data,
>              return -1;
>          }
>  
> -        gdb_ctx.s = s;
> +        g_assert(s == gdbserver_state);
>          cmd->handler(&gdb_ctx, user_ctx);
>          return 0;
>      }
> @@ -1505,7 +1504,7 @@ static void run_cmd_parser(GDBState *s, const char *data,
>  static void handle_detach(GdbCmdContext *gdb_ctx, void *user_ctx)
>  {
>      GDBProcess *process;
> -    GDBState *s = gdb_ctx->s;
> +    GDBState *s = gdbserver_state;
>      uint32_t pid = 1;
>  
>      if (s->multiprocess) {
[...]

Modulo my question about why not use a non-pointer variable,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

