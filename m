Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2FAC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 20:49:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91E252074D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 20:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A3ru7EN5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91E252074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6gdL-0001ew-QJ
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 16:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6gcf-0001G3-7e
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 16:48:21 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:51550)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6gcd-0005Dm-OI
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 16:48:20 -0400
Received: by mail-pj1-x1043.google.com with SMTP id c6so4964900pje.1
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 13:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ouXyePKU5t9LDbbcj/c8t6CJIT+6wAJm66GXegQ0DdY=;
 b=A3ru7EN5/pfoEQyUPPJqUoW8FNZPphbJq8HxjiBS1Umh4KbssL6Ea9DYkJQ+S/fZQv
 8HG/or3M/7XQIswabTTVeBCFT7oQBawhbWZyFFncydvRSmAlo/5KVZiFhqdL3bLEn21o
 wCAXPo4E5+I9hVCqpTqmkCERZGp7XLFd1oJPIb6des5VtKiw6z8pi3qi7p59NQM4eOW6
 EWw5zHdnvE99L/MQQGbXFYs4RLgz3e2W9qywFAiItf6XdrrVSBJUkccoxELSnNVuKjfb
 jhiKJdhBcB7HN/u0Mom/1N9oBlsO+EjL/IcedJrBjLPTLnlj1AcNgldrTDNRwF6Zbn22
 kI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ouXyePKU5t9LDbbcj/c8t6CJIT+6wAJm66GXegQ0DdY=;
 b=o2PLUIN8l3G/2pS3bs69cFXwRy+gApWAbmT0+xHQvvWSnDPPFUqND81CR2+8ukYh42
 9AO3UiCpi/LmJYS/tnKhP8eu4FlH0aZhGq1oUmo8wUyvW06oHT/873e+m99bAGHJ4Z/w
 9pTSm7pbwo3k1PjeDC5uNBCM+1CEPjScVI8E/KIPx6Xftp8Ix1O1YPR1txCKxB5pDPMP
 /kaL7p8ZC3KFPiroVlqCOPsurtYdVbQsFWPKLS+o96sa4nJ58Nge7m3FjrfEqDvHzm+8
 wjvBNemDUFLrZ+ODFdTfDxkrlRuEtq6NQ0sLch2w1sUh0APn/+g+lceeiiGNLF74mTFV
 P8Xw==
X-Gm-Message-State: AOAM530KgkY/EmcJcgYrf6UUAzb7pNNeEGYwrrZZwfZEZ+CG0fSNWrBz
 nA8sOUe9nzy5FmlHj2EfQV34ig==
X-Google-Smtp-Source: ABdhPJyldnh4DEfnoY9S1M5BMl+LFa4JGflKyijgynrkpi3UkN3HgVYRgB9G+5k2pqvBtGMTedQ12A==
X-Received: by 2002:a17:90b:1093:: with SMTP id
 gj19mr3706153pjb.149.1597438098580; 
 Fri, 14 Aug 2020 13:48:18 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id w14sm7768498pfi.211.2020.08.14.13.48.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 13:48:17 -0700 (PDT)
Subject: Re: [PATCH v5 06/14] cpus: extract out hax-specific code to
 target/i386/
To: Claudio Fontana <cfontana@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>
References: <20200812183250.9221-1-cfontana@suse.de>
 <20200812183250.9221-7-cfontana@suse.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6ef68463-cc22-acef-fa5a-dc9a3a6abc9a@linaro.org>
Date: Fri, 14 Aug 2020 13:48:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200812183250.9221-7-cfontana@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
 Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Wenchao Wang <wenchao.wang@intel.com>,
 haxm-team@intel.com, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <rth@twiddle.net>, Colin Xu <colin.xu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/12/20 11:32 AM, Claudio Fontana wrote:
> +CpusAccel hax_cpus = {
> +    .create_vcpu_thread = hax_start_vcpu_thread,
> +    .kick_vcpu_thread = hax_kick_vcpu_thread,
> +
> +    .synchronize_post_reset = hax_cpu_synchronize_post_reset,
> +    .synchronize_post_init = hax_cpu_synchronize_post_init,
> +    .synchronize_state = hax_cpu_synchronize_state,
> +    .synchronize_pre_loadvm = hax_cpu_synchronize_pre_loadvm,
> +};

const.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

