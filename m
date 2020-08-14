Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9BEC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 18:06:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4108A20771
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 18:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WayDzb9T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4108A20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6e64-0003g6-HC
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 14:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6e5T-00034S-LF
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 14:05:55 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36157)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6e5Q-0004Ef-W4
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 14:05:55 -0400
Received: by mail-wm1-x341.google.com with SMTP id 3so8651192wmi.1
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 11:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WitJbOpTxk6zlIDA1wT4dVYzgY4J3Pun1+YTvgArosc=;
 b=WayDzb9TnNVD/IDY0VK0/kN+sW6lcKcLIbcCZQ357elxwT0SQAL2wTbEQTqA4iyRJD
 bKM9q+k17bQdJGa4uvkRMmq3lZyBwaAk5BWetJ7pIAQndem72uW+FCTPsz+WebcaY0+C
 nW8wJ//hcWHNMKYtDLG8CLN0g42kxbVbPYyf0CilVUwe1fmj9ZFpGtRx5/NclBPxurxj
 k/syan4Zua7C+YpRc3iU/FHyo90RiHmx1CoCJWTRvKLu69OI01N2F1r0sCI08+XJEntA
 4u1oN3W6Hs7XMONj8up7rAJp8P2OnvGM4BcUSQvmkdFQrLX/8CqfND2BSgHFSnYGfbgf
 VnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WitJbOpTxk6zlIDA1wT4dVYzgY4J3Pun1+YTvgArosc=;
 b=Mi9zOsTH4Iqp2uVbG7vSLqh/a76WkKSnEpk5QalyHuqJN5hmUEnWb0ws27EsrV1ySf
 uaGGA6HnqAGqW7veHvr+W6QQDtRdDSz4qnI2tVeybB49RfiTfRWzbznqNqTWv4+9tfGx
 GrFORUIWtKzPv8LjeSUXL1FsawM9QF2hAr3C7sHcQxkRtOL3yRfsk24I0ea4TtLHPkhL
 9pXwMZcJxiE6geeFlvrC5r4AdeTqaSQ0lqRF6HddehX8/CWRv3870+Ty6b2sIgsOmd4J
 3JPNnUMoovG0JV9x7hHBgvjzHE0AYG4DMNBC4lMqEsFGbf+f4lzmYnNQAwNWGuI/pXQy
 9cLQ==
X-Gm-Message-State: AOAM533hhbOb4nmICIPhdL2q8h9eTzdDAA/B9WUI6O/7LAX3oq0Rkpwq
 +KbSNxsPG6tQ+QzZHKVwZII=
X-Google-Smtp-Source: ABdhPJya5ngD4cpij4XlBVTIto7c1FrwthCSeN85CE5LzUj0Y5eDK2wmjelWFl1oi58mTK2rQ/w9/A==
X-Received: by 2002:a7b:c95a:: with SMTP id i26mr3740712wml.106.1597428351655; 
 Fri, 14 Aug 2020 11:05:51 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id h189sm17051523wme.17.2020.08.14.11.05.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 11:05:50 -0700 (PDT)
Subject: Re: [PATCH 30/41] qom: Make type checker functions accept const
 pointers
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20200813222625.243136-1-ehabkost@redhat.com>
 <20200813222625.243136-31-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ea42c253-d249-4da0-2543-558839855b5e@amsat.org>
Date: Fri, 14 Aug 2020 20:05:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200813222625.243136-31-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/14/20 12:26 AM, Eduardo Habkost wrote:
> The existing type check macros all unconditionally drop const
> qualifiers from their arguments.  Keep this behavior in the
> macros generated by DECLARE_*CHECKER* by now.
> 
> In the future, we might use _Generic to preserve const-ness of
> the cast function arguments.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/qom/object.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 4cd84998c2..1d6a520d35 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -567,7 +567,7 @@ struct Object
>   */
>  #define DECLARE_INSTANCE_CHECKER(InstanceType, OBJ_NAME, TYPENAME) \
>      static inline G_GNUC_UNUSED InstanceType * \
> -    OBJ_NAME(void *obj) \
> +    OBJ_NAME(const void *obj) \
>      { return OBJECT_CHECK(InstanceType, obj, TYPENAME); }
>  
>  /**
> @@ -581,14 +581,16 @@ struct Object
>   *
>   * This macro will provide the three standard type cast functions for a
>   * QOM type.
> + *
> + *FIXME: Use _Generic to make this const-safe
>   */
>  #define DECLARE_CLASS_CHECKERS(ClassType, OBJ_NAME, TYPENAME) \
>      static inline G_GNUC_UNUSED ClassType * \
> -    OBJ_NAME##_GET_CLASS(void *obj) \
> +    OBJ_NAME##_GET_CLASS(const void *obj) \
>      { return OBJECT_GET_CLASS(ClassType, obj, TYPENAME); } \
>      \
>      static inline G_GNUC_UNUSED ClassType * \
> -    OBJ_NAME##_CLASS(void *klass) \
> +    OBJ_NAME##_CLASS(const void *klass) \
>      { return OBJECT_CLASS_CHECK(ClassType, klass, TYPENAME); }
>  
>  /**
> 


