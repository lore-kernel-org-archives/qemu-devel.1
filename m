Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DB0C55178
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 18:49:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BD28206FA
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 18:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lQsCgsNI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD28206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYZTH-0000AH-EC
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 14:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYZSh-00084e-R6
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 14:49:19 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:37373)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYZSf-0001pq-37
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 14:49:19 -0400
Received: by mail-pl1-x641.google.com with SMTP id b12so3403773plr.4
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 11:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QSOyHPfkws29/043P9DzlW3T+ooa6irrXr5ncbzIpUw=;
 b=lQsCgsNI6sQ6PSAC5Lt8mo3XgOqjTLsjQTKIuWISvKMDYjtkhE9s/DRNQq/Xkg9RKk
 IJS3C46xKkthO3GN6CdEAUM01V/sOW2/yvelPijDv1DGJVqq42T/T2lhVKkQbqxxCC5B
 jVFRnFbdQ8X9jbQmVJkB2XeLYno8PQdihV4dnPgjmgqruTTdoGOhbtOpAV7XazKkPzLw
 GHSkSNkIzIlfUSrte+0rSc++KpYeF5/rKkwo8lLTreXtdRVSjUqaKEuMzomHVKzVJXs9
 BDFJl9U/QscLYB/U9ccAmoJNxPQlOU/KzBJUIKbyL5ymtIzIXMzk2MpB/Fc23SdkfgKy
 ouGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QSOyHPfkws29/043P9DzlW3T+ooa6irrXr5ncbzIpUw=;
 b=dc1WmhL2z1w8vzjDCCtsoFX6zzEs/bLMnzpPkY4vsvhudmEcqgwZSs3OTQdFJ1vsDG
 GiCOa7w5jrr8uxReLA+YbeBwS8SiBWK6ugDxllciV/qs8Ewq8+0t50Kk19CD1CcQsCIi
 cJ400Idf21f7AhyuRQoLkJKm9AThaBhHfE8xtWMzc/lTwPct94SlPeNj7ne/cWFxpQih
 X03Jl58kYFsBA62IiuI5AtdbGbAImerDnbNIVBGnscjSyi1w7tTqIHTNBHepTLwsUS2d
 T2dRMW0TdrDgtGOOf4Ig5Ab5tCbT8htSVeKxAPONhQbYsOL5vo2v7Md1hycxsRxAZu9X
 dxuQ==
X-Gm-Message-State: AOAM533bjbF22QmaPzfjHyclCshRXXC0vIKt8N6cfvdfLPevB84ALWPv
 8FiEgZpRTZ+CuEaCmSTcDlRwzw==
X-Google-Smtp-Source: ABdhPJwHvNTs3MDMHXD2TFkoGRjdQQmuzUAW6teVIkTTy+MouU4+L5b3x7PPxi7NC1JtA9cwA/9plA==
X-Received: by 2002:a17:902:ee11:b029:d6:30a7:9e71 with SMTP id
 z17-20020a170902ee11b02900d630a79e71mr10286831plb.8.1604083755575; 
 Fri, 30 Oct 2020 11:49:15 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id bo16sm4492991pjb.41.2020.10.30.11.49.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2020 11:49:14 -0700 (PDT)
Subject: Re: [PATCH-for-5.2 v2] hw/rx/rx-gdbsim: Fix memory leak
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20201030134918.1518930-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <996efc40-c616-c73a-c65c-ea3ae13e1d5c@linaro.org>
Date: Fri, 30 Oct 2020 11:49:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201030134918.1518930-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.253,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/30/20 6:49 AM, Philippe Mathieu-Daudé wrote:
> As load_device_tree() returns allocated memory,
> we need to free it.
> 
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Fixes: bda19d7bb56 ("hw/rx: Add RX GDB simulator")
> Reported-by: Coverity (CID 1432307: RESOURCE_LEAK)
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> v2: NULL-initialize (Richard)
> ---
>  hw/rx/rx-gdbsim.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/rx/rx-gdbsim.c b/hw/rx/rx-gdbsim.c
> index 417ec0564b3..d70865962e8 100644
> --- a/hw/rx/rx-gdbsim.c
> +++ b/hw/rx/rx-gdbsim.c
> @@ -122,7 +122,7 @@ static void rx_gdbsim_init(MachineState *machine)
>          if (dtb_filename) {
>              ram_addr_t dtb_offset;
>              int dtb_size;
> -            void *dtb;
> +            g_autofree void *dtb = NULL;
>  
>              dtb = load_device_tree(dtb_filename, &dtb_size);

What I said was, merge the declaration and statement:

  g_autofree void *dtb =
    load_device_tree(...);

but whatever.  You can still keep my previous conditional r-b.

r~

