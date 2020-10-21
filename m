Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD60EC388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 16:53:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E62D82173E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 16:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pYdM5dhb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E62D82173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVHMQ-00051s-Ok
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 12:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kVHHy-0001JW-Bm
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 12:48:38 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:40681)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kVHHw-0007qr-MF
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 12:48:37 -0400
Received: by mail-pf1-x443.google.com with SMTP id w21so1812820pfc.7
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 09:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=aZmbdTrIy8uAUv/JfJpmNUclpbvjmokm2StOBbnlNMs=;
 b=pYdM5dhbwkJGoCSEDv/7BeeJ9CM6GdrgZFLlXJrDYY6IU/nPvtpHFY4QWDdmjZ4YQA
 7FscVjxt+XhmZp+ftVvgd+rokWPXy6emTxd0KC02jRMTZsVdwmag09Qo36VS0CWKRB5F
 j+IpyS3PHXXITz1viAiE5k8y5O9PDdnmoi6D88oExGl4bfJNYyBIuOluxvNE4U82+Cel
 aVKCfRi6TPRL6WQ7hJyFVSXA3Xeufbr3TFZXeyrVbtB8nlSEnTrcrkG8Bkn5702ZBGc2
 vhAu0coNKZpjIkMvSW0rSX4aMHjbaMXfiDtkStae2wE9j/FO2uqAIdWAEdzWfHX/KRgs
 iRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aZmbdTrIy8uAUv/JfJpmNUclpbvjmokm2StOBbnlNMs=;
 b=Ml6tngoThIwYqI6ZaQF/pxctjCjDEZGAJ4koKT/1INdTf9qBDrisU/F1Fp5hm26LM5
 MXzxZ+oWkV1I6AG2iMxEffFh8mMW+3dWbEboKNp68k//WfuzJCMpaqBGN1IfOJNgmB8c
 YAPGpSk7K7KBSSyBiEQ68+MU/DXgPbflNF41LY1qMFBNe/NZuGQAFjYnMMgbjkRzgksK
 t5UX0FAcvMW79QrurZgiXrq7PYPxwnHIj59o/i8A/umKtXZ5nnULwd7aUiXogDM219h+
 YIkUYDsY87diTOhf9jrYQXZ12X/bhUAelks6wDWh3IkI6o9Y9NwhIntP0k1gp13EjTXq
 5lMA==
X-Gm-Message-State: AOAM533UzYlpa9Ih0SNLD8oRVnXNnHxLx/Vd4EQDCj6OjqniOqwytlkj
 CaNWMqD/zv/nn3aR6l1KW/QAqg==
X-Google-Smtp-Source: ABdhPJztufMvQX8vkDQhBS2XHgUnIB/Ijp30gbCEJUDOHy8acP2fMjvsDq8I2xitAA2RuFL/XlDDzA==
X-Received: by 2002:a62:3815:0:b029:152:80d4:2a6f with SMTP id
 f21-20020a6238150000b029015280d42a6fmr4188337pfa.72.1603298915268; 
 Wed, 21 Oct 2020 09:48:35 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id m34sm2965886pgl.94.2020.10.21.09.48.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2020 09:48:34 -0700 (PDT)
Subject: Re: [PATCH 0/3] sh4: Trivial clean-ups for sh_timer.c
To: Thomas Huth <thuth@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20201020153935.54315-1-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d2c757c1-6cf9-7332-6fd6-b53579df6308@linaro.org>
Date: Wed, 21 Oct 2020 09:48:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201020153935.54315-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: qemu-trivial@nongnu.org, Magnus Damm <magnus.damm@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/20/20 8:39 AM, Thomas Huth wrote:
> Thomas Huth (3):
>   hw/timer/sh_timer: Coding style clean-up
>   hw/timer/sh_timer: Silence warnings about missing fallthrough
>     statements
>   hw/timer/sh_timer: Remove superfluous "break" statements

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

