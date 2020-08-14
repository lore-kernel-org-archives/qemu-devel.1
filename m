Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED7BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 18:05:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 234E620771
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 18:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMOnAasZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 234E620771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6e5M-0002o6-BS
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 14:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6e27-0006Kq-IM
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 14:02:27 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39661)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6e25-0003pc-Vh
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 14:02:27 -0400
Received: by mail-wm1-x342.google.com with SMTP id g75so8624294wme.4
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 11:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ixljhcPxpjv2vd8J7lewF+1Xl2YtOq6ZO52rl6pTbGs=;
 b=GMOnAasZd3Pi7GXdrXoGUtScM/SgAuFrVsA97Y0d0cMA534FVol7qjI5tR+0f54toZ
 u1GO6ExE1IVZHZGR0dOPsOO7/84LIW0sTI5EQ4oSggkg/xXpcQq7Zueygtz0bLgSXHlJ
 QTOYJlmS9zywhkDu4Eh7HGJgnyvZ7HVRzCUhLwuMeJyJHUtOyt0hLHApvfH7k8S+BaMx
 +aPlYHYvX6+gv1GxALY+RV7eeOiFrslln4lLu+q5GCvwKPi73FLyNq6Bi4I5e8TRw/6o
 tyc8H/wyYF2Gn3QKqHRvjTlxO8sbcB0q49wlrKHlM2yGzmKiyV/zr2bxjCZcyQk6kWI5
 oWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ixljhcPxpjv2vd8J7lewF+1Xl2YtOq6ZO52rl6pTbGs=;
 b=UEB7qS4Yz9VTXqt6WHA7Zjat8ExZqsuBKQ2W+n+XsCWkZ/TMMFq+/fR8ILc+Y62dOW
 nLbPS4pbAn+hJ+l0crpi6BvDt/qCqt6zQvr8LEEP+eT+JKFHY6QiOwpxm74Ml/tn9XSE
 wjL5S3Eq8mmJzq3t14d6P+krotcGMEpTM3ozXXHDqbGxi1TLLR/CSAHshJjoqUZlS7oF
 ESFmNnJuYCjrOEeMVQ3u34we4Jb4JgkPLNxafxzTi4HiZqC+XQmX6tOtJCGLlnN1qVoi
 8mx9qv4jxkSBYsDLxWtyA/QqSe6pWfUyt0FzDiOj3XWQMCIyzkhPBWX2ATSv+UB8+rqD
 lyuQ==
X-Gm-Message-State: AOAM5310il5qgt1lA/lT5/u/XT2sX6SHF/GK8oLORYjYvf7JgVAIV0O1
 AchMkT32YltDW7PFlOrsAoY=
X-Google-Smtp-Source: ABdhPJwzlSSHfBxqk8gqGx5a4HVnndwlnfry2MeVBE699jB60RCqkqJBZ1VC/eZ6GpxOLA1J7W4Tqw==
X-Received: by 2002:a1c:b7c2:: with SMTP id h185mr3813225wmf.168.1597428144649; 
 Fri, 14 Aug 2020 11:02:24 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id a23sm18202803wme.0.2020.08.14.11.02.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 11:02:24 -0700 (PDT)
Subject: Re: [PATCH 18/41] i8254: Move PITCommonState/PITCommonClass typedefs
 to i8254.h
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20200813222625.243136-1-ehabkost@redhat.com>
 <20200813222625.243136-19-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9332495f-a762-0eae-fcac-a6b7a89357eb@amsat.org>
Date: Fri, 14 Aug 2020 20:02:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200813222625.243136-19-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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
> Move typedef closer to the type check macros, to make it easier
> to convert the code to OBJECT_DEFINE_TYPE() in the future.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/hw/timer/i8254.h          | 2 ++
>  include/hw/timer/i8254_internal.h | 8 ++++----
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/timer/i8254.h b/include/hw/timer/i8254.h
> index e75b4a5a08..206b8f8464 100644
> --- a/include/hw/timer/i8254.h
> +++ b/include/hw/timer/i8254.h
> @@ -39,6 +39,8 @@ typedef struct PITChannelInfo {
>  } PITChannelInfo;
>  
>  #define TYPE_PIT_COMMON "pit-common"
> +typedef struct PITCommonState PITCommonState;
> +typedef struct PITCommonClass PITCommonClass;
>  #define PIT_COMMON(obj) \
>       OBJECT_CHECK(PITCommonState, (obj), TYPE_PIT_COMMON)
>  #define PIT_COMMON_CLASS(klass) \
> diff --git a/include/hw/timer/i8254_internal.h b/include/hw/timer/i8254_internal.h
> index 3db462aecd..a9a600d941 100644
> --- a/include/hw/timer/i8254_internal.h
> +++ b/include/hw/timer/i8254_internal.h
> @@ -50,14 +50,14 @@ typedef struct PITChannelState {
>      uint32_t irq_disabled;
>  } PITChannelState;
>  
> -typedef struct PITCommonState {
> +struct PITCommonState {
>      ISADevice dev;
>      MemoryRegion ioports;
>      uint32_t iobase;
>      PITChannelState channels[3];
> -} PITCommonState;
> +};
>  
> -typedef struct PITCommonClass {
> +struct PITCommonClass {
>      ISADeviceClass parent_class;
>  
>      void (*set_channel_gate)(PITCommonState *s, PITChannelState *sc, int val);
> @@ -65,7 +65,7 @@ typedef struct PITCommonClass {
>                               PITChannelInfo *info);
>      void (*pre_save)(PITCommonState *s);
>      void (*post_load)(PITCommonState *s);
> -} PITCommonClass;
> +};
>  
>  int pit_get_out(PITChannelState *s, int64_t current_time);
>  int64_t pit_get_next_transition_time(PITChannelState *s, int64_t current_time);
> 


