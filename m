Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49631C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 15:14:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B6562075B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 15:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J10VVrWf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B6562075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBg58-0005FH-9N
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 11:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBg4N-0004UX-OR
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 11:13:35 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:53608)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBg4M-00053C-4b
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 11:13:35 -0400
Received: by mail-pj1-x1043.google.com with SMTP id nv17so628528pjb.3
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 08:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0OBMjIW/lFPIlNgz0b0Ud3zUgNRsC/sa1j91GvakNV4=;
 b=J10VVrWflOVYze8K2Teg05p1QLhMkupd3EE86I4ZXhBxkZfmq/U6ayP0u/jDNtb038
 t/wpHCsF/0RiCbWX4JM/bruqaLRFMBxyklbWbh3h+uAYfUctRoTIIKyaQ0QnftjRdHj7
 W6qu7rgR78w6SKlyLlS/nYRhYx2hwIMQscL0M/forySXmbMJNzKQEKEZ5WRLNX+O6fB7
 IMd2lExQiYSfCf+dk0ycli+dbob25L2D6GKRmaJQXgvu40rckPU6G7pWjttkjEV7DdbI
 5/OpvdumEub1NXQePaRucLWqK6nTTMzwE6ApgzjQRn+d0AramOQnsMpPquM5STb7iC7n
 pMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0OBMjIW/lFPIlNgz0b0Ud3zUgNRsC/sa1j91GvakNV4=;
 b=T0V8SkICCp5jvhGw7MH0jOrKpUITp3r9fBKOzQeO4QvSqf9EDUTDOcI4NbHf62HfLz
 ymJdxsC/INJrDht2PWWWAAZ6I0o8V5ySd28Z/Av9jvsTzxfyXyXzocnGfVyfW9k68IJ7
 QOzupgyjlCFyoD/BBLeSbNjtBvZWFvxsgIrA75A/uYVxcHpL7Dw9LSIxAClY5MAj0DTY
 wBrPkWEzRPB3WWXPYpHqd3YsWiAwrnn/YBYybvV934Bdb7rgliVtnWkzH8opQqlIKD9C
 nYhduNXetjpnexrladnBHVZHa1PgxyUvOMo/5A02BUqfTzU5UUJ6gV/jzuOXqqgkmddL
 EB2w==
X-Gm-Message-State: AOAM5319JEKbEKh+1r7OABKIYR6eh4fiDVTvFXDH1nG+57XmOXpm6UEp
 3KzpGOVnhmTZe7cCNd10mUHSNg==
X-Google-Smtp-Source: ABdhPJxnsQRtujCGiM/BUy6uMOFKaFPozkBOK/EuL6DMCAsVpqFLkR1LdQdiwQJiI1jvUoPhM3vCsg==
X-Received: by 2002:a17:90a:e604:: with SMTP id
 j4mr1586169pjy.215.1598627609907; 
 Fri, 28 Aug 2020 08:13:29 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id mp24sm1540931pjb.42.2020.08.28.08.13.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2020 08:13:29 -0700 (PDT)
Subject: Re: [PATCH 1/2] crypto: fix build without gcrypt and gnutls
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200828132716.279782-1-berrange@redhat.com>
 <20200828132716.279782-2-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0a1a8958-691f-d16d-2f6b-6392e6a20966@linaro.org>
Date: Fri, 28 Aug 2020 08:13:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828132716.279782-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/28/20 6:27 AM, Daniel P. Berrangé wrote:
> If nettle is disabled and gcrypt enabled, the compiler and linker flags
> needed for gcrypt are not passed.
> 
> Gnutls was also not added as a dependancy wen gcrypt is enabled.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

This still needs something else.  I get

Linking target qemu-x86_64
/usr/bin/ld: libqemuutil.a(crypto_init.c.o): in function `qcrypto_init':
/home/rth/qemu/bld-g/../qemu/crypto/init.c:111: undefined reference to
`gnutls_global_init'
/usr/bin/ld: /home/rth/qemu/bld-g/../qemu/crypto/init.c:113: undefined
reference to `gnutls_strerror'
collect2: error: ld returned 1 exit status
make: *** [Makefile.ninja:1570: qemu-x86_64] Error 1


r~

