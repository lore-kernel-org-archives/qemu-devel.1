Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B614C4363D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 17:59:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 089F5206C1
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 17:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOhgiJJt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 089F5206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOloO-0007Vf-6A
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 13:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kOlmJ-0005JQ-Bi
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 13:57:03 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36819)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kOlmH-0005A8-Bn
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 13:57:03 -0400
Received: by mail-wm1-x341.google.com with SMTP id e2so4896157wme.1
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2020 10:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=RnlEYWO9WLH+3LGtzlV6BcD0kb/RdJQD/qsXm6Q0F/w=;
 b=NOhgiJJt7bQycQMMYjjwW9diTPFF/2uHD27xe44RNzdGVmf7gK4IUA/HirUis3U9rT
 jWET4f5avSLQko/tXG6Hvx/QtHJPRQhym9kgG3TQ/1+f5avz6XqDUB+LyQMWIQ/5FASf
 RvI/UcW+KBad2nhq0elR919i4qNd5U1/3lFbrUFgpjjfSQnCmt+VlQJw2yy2TdMprQqP
 8eVikqW/MPHOiBSQeMnLoo4rIfOfqqiSjbT31Xmuffpyg3ZCRMJUmye7t2BYadXvJXRN
 OR8hpu/qzVYgJ69HC80Ij2irtN90/PB5gu8F0whJqaaJ8Vcx4s8JuOVhIlXDiv3Z52tW
 sXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RnlEYWO9WLH+3LGtzlV6BcD0kb/RdJQD/qsXm6Q0F/w=;
 b=q4SUIGYQhiHGj+Aq9bq1fc1CaLO+q38jBWNoq1O/AVTvU8kDQTlR5XTMV/PrMYmKEM
 TcYJWwK1GZHBqHZRiAnjkcT0lLPtIxVSa3muj6xFq1EQ/UwlxqQOjEHwBo+IALBxu8UN
 vwAqbwpwz+TIodvoW5tJ6Fu8t3w1JJWe4XXyX9KY1haVouN8Du66+uTbyuAygiGH0T47
 aLiyblnA7iDFO+xxFZbJ/vqZLua3vZjhqGGfnRva4PbKlUR4NbunjIWFb0t22JqRkRTq
 cXq8EAlFp0D+5RfW96AMZ1XEZ5/0CsKpuL+fpGh23X90Dlo+bUKXtbjDAzREJeSbaaaZ
 /Wag==
X-Gm-Message-State: AOAM532P49pAS8jjpZlhWirf2qn3cMxRduGEk1lYYgcjTZldNZfnfwMK
 Ho2jCNX3u9nlyio1A32EiF8=
X-Google-Smtp-Source: ABdhPJwjJy2VbQ65wWOVlFvJrhpXlCGsT809TOH5dx6AMK7GvI5TpnrjcRDkUOFHWzaPQiQuM1LDSA==
X-Received: by 2002:a1c:7f8b:: with SMTP id a133mr9204602wmd.155.1601747819383; 
 Sat, 03 Oct 2020 10:56:59 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id k6sm5873283wmi.1.2020.10.03.10.56.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2020 10:56:58 -0700 (PDT)
Subject: Re: [PATCH 1/6] qom: Fix DECLARE_*CHECKER documentation
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20201003025424.199291-1-ehabkost@redhat.com>
 <20201003025424.199291-2-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2be2a009-8fea-9bfd-9901-7d534930eb6c@amsat.org>
Date: Sat, 3 Oct 2020 19:56:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201003025424.199291-2-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.252,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/3/20 4:54 AM, Eduardo Habkost wrote:
> Correct copy/paste mistake in the DECLARE_INSTANCE_CHECKER and
> DECLARE_CLASS_CHECKERS documentation.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  include/qom/object.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 27aaa67e63f..e738dfc6744 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -170,7 +170,7 @@ struct Object
>   * Direct usage of this macro should be avoided, and the complete
>   * OBJECT_DECLARE_TYPE macro is recommended instead.
>   *
> - * This macro will provide the three standard type cast functions for a
> + * This macro will provide the the instance type cast functions for a

Using a single "the":
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>   * QOM type.
>   */
>  #define DECLARE_INSTANCE_CHECKER(InstanceType, OBJ_NAME, TYPENAME) \
> @@ -187,7 +187,7 @@ struct Object
>   * Direct usage of this macro should be avoided, and the complete
>   * OBJECT_DECLARE_TYPE macro is recommended instead.
>   *
> - * This macro will provide the three standard type cast functions for a
> + * This macro will provide the class type cast functions for a
>   * QOM type.
>   */
>  #define DECLARE_CLASS_CHECKERS(ClassType, OBJ_NAME, TYPENAME) \
> 


