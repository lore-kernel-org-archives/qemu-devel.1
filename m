Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49C3C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 12:38:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04E762075E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 12:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DM7lpP2v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04E762075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY7CQ-00035H-Ur
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 08:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY7B8-0002Lk-MX
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 08:37:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30031)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY7B6-0007MF-Rd
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 08:37:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603975035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TTMoMZfD+y983n5MDt/rUD2rbGL0EyZ93h69e8Y6y28=;
 b=DM7lpP2v807mTYCoEsW3rAxZKkDdwISHHldVhPelEspuJ1hKeBtvJyJGN+2QZR9iZbvUt0
 GCDDdqFTyZhnTc30ZhpDuj647JDI6+cEHbsKJ9xra6ZVQ7sxbpg3Sn4iYwixdRWOVaU7iy
 2FRmf0VwhElGABCmeVIIG3ZmQXHz3LY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-71Da5lTPMBqnmUs84PXtoQ-1; Thu, 29 Oct 2020 08:37:14 -0400
X-MC-Unique: 71Da5lTPMBqnmUs84PXtoQ-1
Received: by mail-ed1-f72.google.com with SMTP id 28so1112615edv.9
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 05:37:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TTMoMZfD+y983n5MDt/rUD2rbGL0EyZ93h69e8Y6y28=;
 b=YR+r2bXEW/iiHgjCUL5l2efCun4EwMATET21O5ufc24t5emtgWD6pJKgaZj1htQlzO
 PouX8QbExstieJ3MxbnuY59JhwZ8MQ0+nGtKQxLLDUR3KqfPeWxYa/gz4EnumguQZfQ7
 KFNcWgcO3NQrb+9yH8OcLfgtSw9LJjw7jLtlrle0SfoxtZzLKHTxlI8bTYiumVhfV/aM
 lO9EaAjdmCb/7tcLLn62PsXdQlmIhG+RZ3UQs9uM2IYvmRe6ZhEYcL1w04fs0QXfMARt
 1WWpmXc5UMUFChyaMPX/oAp7QxXjZ32VwB9FUOgPdMeYADVvYfXyDoaC25dp8J9WSibE
 rbKg==
X-Gm-Message-State: AOAM531nPY16gL4j2Y4UAZXMzoJK01vx+nqF15u5PwgM9hPgwQyTGmrt
 7oF4Jmp02deKYZiYdZQbxmM7KibcO3Dzthtkh5XZJ8tjZJRcjtlyTx6P20SxjoILNPuc4LzfnrP
 3pOcpNM7dP+LaYqw=
X-Received: by 2002:a17:906:b204:: with SMTP id
 p4mr3992528ejz.214.1603975032816; 
 Thu, 29 Oct 2020 05:37:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfR75fWz+xTF98QckoYgiWhKl46FfQpcv6tiVxIb7wRdQ7RbiQrlcg785+yhtryEwkayei7Q==
X-Received: by 2002:a17:906:b204:: with SMTP id
 p4mr3992516ejz.214.1603975032634; 
 Thu, 29 Oct 2020 05:37:12 -0700 (PDT)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id b24sm936459eja.30.2020.10.29.05.37.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2020 05:37:11 -0700 (PDT)
Subject: Re: [PATCH] tcg/optimize: Add fallthrough annotations
To: Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>,
 qemu-devel@nongnu.org
References: <20201029122833.195420-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ffbb5d98-5a74-0f22-eda7-e25eb92c541e@redhat.com>
Date: Thu, 29 Oct 2020 13:37:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201029122833.195420-1-thuth@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.261, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Chen Qun <kuhn.chenqun@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/29/20 1:28 PM, Thomas Huth wrote:
> To be able to compile this file with -Werror=implicit-fallthrough,
> we need to add some fallthrough annotations to the case statements
> that might fall through. Unfortunately, the typical "/* fallthrough */"
> comments do not work here as expected since some case labels are
> wrapped in macros and the compiler fails to match the comments in
> this case. But using __attribute__((fallthrough)) seems to work fine,
> so let's use that instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tcg/optimize.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 220f4601d5..c2768c9770 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -26,6 +26,12 @@
>  #include "qemu/osdep.h"
>  #include "tcg/tcg-op.h"
>  
> +#if __has_attribute(fallthrough)
> +# define fallthrough() __attribute__((fallthrough))
> +#else
> +# define fallthrough() do {} while (0)
> +#endif

This looks something we can reuse, what about adding it
as QEMU_FALLTHROUGH in "qemu/compiler.h"?

> +
>  #define CASE_OP_32_64(x)                        \
>          glue(glue(case INDEX_op_, x), _i32):    \
>          glue(glue(case INDEX_op_, x), _i64)
> @@ -855,6 +861,7 @@ void tcg_optimize(TCGContext *s)
>              if ((arg_info(op->args[1])->mask & 0x80) != 0) {
>                  break;
>              }
> +            fallthrough();
>          CASE_OP_32_64(ext8u):
>              mask = 0xff;
>              goto and_const;
> @@ -862,6 +869,7 @@ void tcg_optimize(TCGContext *s)
>              if ((arg_info(op->args[1])->mask & 0x8000) != 0) {
>                  break;
>              }
> +            fallthrough();
>          CASE_OP_32_64(ext16u):
>              mask = 0xffff;
>              goto and_const;
> @@ -869,6 +877,7 @@ void tcg_optimize(TCGContext *s)
>              if ((arg_info(op->args[1])->mask & 0x80000000) != 0) {
>                  break;
>              }
> +            fallthrough();
>          case INDEX_op_ext32u_i64:
>              mask = 0xffffffffU;
>              goto and_const;
> @@ -886,6 +895,7 @@ void tcg_optimize(TCGContext *s)
>              if ((arg_info(op->args[1])->mask & 0x80000000) != 0) {
>                  break;
>              }
> +            fallthrough();
>          case INDEX_op_extu_i32_i64:
>              /* We do not compute affected as it is a size changing op.  */
>              mask = (uint32_t)arg_info(op->args[1])->mask;
> 


