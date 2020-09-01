Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD077C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 17:35:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 757A820866
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 17:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mgTPeSTM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 757A820866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDABX-0000uW-Lz
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 13:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDAAw-0000R1-8j
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 13:34:30 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:38257)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDAAu-0000KX-Nf
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 13:34:29 -0400
Received: by mail-pf1-x441.google.com with SMTP id d22so1207143pfn.5
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 10:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9EiRMNxlMlQ4tAvPhGjUhb/B5hKFmH7FnZjM8MQfa2k=;
 b=mgTPeSTM+w14KZyeg8/q2FO11giwn2qrBxhpv+ra4/uohcnjXHnvV7CDaUmBXrDkAe
 NC8wN7a4G0Ot3xOh4RcNkyz61Azidy53ugM5mASw/BNVm9zdMsC0EM4H6u8R415P7XqD
 yvucYRtHHA6MGBG/sQXFRiNgU2ySBVuMiGn6uJgjss4IWH6vfPWsklyXwYXRf9aYqbye
 2h0yhxcfINkwKdw/eWlbyIcZUTq/EDANgzANIBEiOfJBzUDvbtd2/rrMBlt9pCpXCRgc
 jN38fofdNxfBJYwfflvNGswLaUxqf2UqWxoC/79no+1B+Z9Zwd9x2wdkh3oCzpNamuKQ
 PLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9EiRMNxlMlQ4tAvPhGjUhb/B5hKFmH7FnZjM8MQfa2k=;
 b=Mef3ta6lQOqScjey+EjJoC6YVDGcgiNZdT1bkqCBL71sdppvGrvdjWMGei8QVnB6at
 QszHyWC/adBFX3Jn0a5pTxezHY7uUOZm5bluZMiMv4uC+tbXq75wOPouQBZpxwNlY5Hg
 7SfCXO1HiaRCb4s4XV64G9xMYuXuI0J09MvREjYDL3x6NCHEQS8SlIMnqaDViBjKVUk1
 ljAPtpN5yzITsjqnKVjINrI4RqMS6CCpIfZwInEpv+fButmVgRClqOEMxZASwRw61AB+
 2Ir0tdDRXw9JTx9NAOr4aOd1oSP/6f0WoF2x7j+hN3UzBy2V6XsN8dITdV1qSKhQew1b
 udzA==
X-Gm-Message-State: AOAM533UTi6yG4U2LaKp7d9huERcX1rEkh4CZfbzFJvjm0oK27KYiJXV
 nK1B9HPCDo7QzJliro5je5RsoQ==
X-Google-Smtp-Source: ABdhPJyvcjvz/+Nl+E5qGzCiv5pMP3rO4l4lNduUPFfpdTAD98h4R6s6ZWtuApt+/rV7MzVz0Tq/QQ==
X-Received: by 2002:aa7:8e86:0:b029:138:8ec9:6d05 with SMTP id
 a6-20020aa78e860000b02901388ec96d05mr2818698pfr.3.1598981667142; 
 Tue, 01 Sep 2020 10:34:27 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id a12sm2635018pfr.217.2020.09.01.10.34.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 10:34:26 -0700 (PDT)
Subject: Re: [PATCH v6 04/16] cpus: extract out TCG-specific code to accel/tcg
To: Claudio Fontana <cfontana@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>
References: <20200901072201.7133-1-cfontana@suse.de>
 <20200901072201.7133-5-cfontana@suse.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b2209f1f-a05c-31a4-7590-f19663bf0323@linaro.org>
Date: Tue, 1 Sep 2020 10:34:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901072201.7133-5-cfontana@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.13,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alberto Garcia <berto@igalia.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Colin Xu <colin.xu@intel.com>, haxm-team@intel.com,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Wenchao Wang <wenchao.wang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/1/20 12:21 AM, Claudio Fontana wrote:
> TCG is the first accelerator to register a "CpusAccel" interface
> on initialization, providing functions for starting a vcpu,
> kicking a vcpu, sychronizing state and getting virtual clock
> and ticks.
> 
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> [added const]
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~



