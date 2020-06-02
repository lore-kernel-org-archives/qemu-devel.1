Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EBAC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 17:12:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7224206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 17:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6opK736"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7224206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgASH-0007x6-3I
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 13:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jgAO6-0000O9-O3
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 13:07:42 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36884)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jgAO6-00007C-2p
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 13:07:42 -0400
Received: by mail-wr1-x442.google.com with SMTP id x13so4183248wrv.4
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 10:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BYSvh/fQuJVEkE2VwpocvfEmb5uN+NqpsBPPVR05uQ4=;
 b=j6opK736vpgSKhLxXkioc5EnFTWz+7Z0gLKbHrsOVkbCNLwbwYUJOQ+Xa9Y2htyYk6
 W8qrVCyobnghaI1Yr/zp2O71ZprRy8dkuWjVk0BiUNjSdUit/oVY/enWM9Fru5CRxtFj
 WuVrfqLUMyOTTWIurqzjqSkX/5TCTu3o6V+VLkw8CMNVOQ0Zl/o46zIE7hZYQKSokZ+O
 G6F/kG9pU07AL0DmQT+tsDm5AhrYD2Z7B1eWrWk+46Ia8TyGshs01wNExGWdz95b+Ba7
 afOTcRTmqLplCFwX3+ZIkzkVsCeJQasL5+Cn4jZsEF3XrzqmTuq0NrdF855dZOi5gOXM
 ziHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BYSvh/fQuJVEkE2VwpocvfEmb5uN+NqpsBPPVR05uQ4=;
 b=IWLnbFKerqhNgxJldIxnk+PO5UC+VDOaaVaMOkapBQZSjawY9HEmXsTVSx86n5uzb0
 FNMCUzAKGwwtbjeZStlmi7jtu2nHSQO1KK0VdUvy8bfzudtX2QfxM3vucM0CWbAeUHP8
 K0zGuE+a3ChO8TuiH/eHqybc78nxTbVOiLnosyWZk226+cfU32JRRBHupyzaVOgaOIb5
 Bcu4/l2Ncx3byLPXrSqkdSFyLggcquXWGNyq89NoP0Z4lB9DSchtdg+jAWRbSXoK9Cqo
 SJqy5yAzXyq7ojxmis+y+AhvGpIp16BHw/yl9cJpvGzgqnV42BBXw8Lwq3yX4Nq+5152
 oawA==
X-Gm-Message-State: AOAM532pTECUI9A8RejNuvnNEW9z1EQuQkkPxfuoHML2bf0zZb7poKbw
 UJhu+Pcx7UnlyWgH+idawG8=
X-Google-Smtp-Source: ABdhPJwCaZMwAzAGq74d0CGYj32xzywt8Wk0hVFd43uZkqgUxHMeqYnR8K0KeZ+d1RbLnY/HqjXjNg==
X-Received: by 2002:adf:80eb:: with SMTP id 98mr10291192wrl.351.1591117660649; 
 Tue, 02 Jun 2020 10:07:40 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id y37sm5963150wrd.55.2020.06.02.10.07.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2020 10:07:39 -0700 (PDT)
Subject: Re: [PATCH v1 4/9] tests/plugin: correctly honour io_count
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200602154624.4460-1-alex.bennee@linaro.org>
 <20200602154624.4460-5-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c7d60343-523e-a0ac-e8c3-bdbd3c565587@amsat.org>
Date: Tue, 2 Jun 2020 19:07:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200602154624.4460-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
Cc: robert.foley@linaro.org, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, cota@braap.org, peter.puhov@linaro.org,
 kuhn.chenqun@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/2/20 5:46 PM, Alex Bennée wrote:

Fixes: 671f760b93b ?

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/plugin/mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/plugin/mem.c b/tests/plugin/mem.c
> index 878abf09d19..4725bd851d8 100644
> --- a/tests/plugin/mem.c
> +++ b/tests/plugin/mem.c
> @@ -28,7 +28,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
>  
>      g_string_printf(out, "mem accesses: %" PRIu64 "\n", mem_count);
>      if (do_haddr) {
> -        g_string_append_printf(out, "io accesses: %" PRIu64 "\n", mem_count);
> +        g_string_append_printf(out, "io accesses: %" PRIu64 "\n", io_count);
>      }
>      qemu_plugin_outs(out->str);
>  }
> 


