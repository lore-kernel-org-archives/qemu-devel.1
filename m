Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE50C7618F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 14:58:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60F482080D
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 14:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gk+9bV+u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F482080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho7rn-0003nl-LA
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 10:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38295)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1ho7rb-0003JA-K6
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 10:58:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ho7ra-0006L1-Gi
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 10:58:31 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:37388)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ho7ra-0006Kc-8e
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 10:58:30 -0400
Received: by mail-pl1-x641.google.com with SMTP id b3so14026864plr.4
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 07:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TgjiWKnYVhNow5aXdsbc/uRaAI4MYXerKql/FbghhWU=;
 b=Gk+9bV+upaQ1YgstmeYjiwhK8OJvM2Q68ZuapcDbLc4iEOXb9mr3npR4P59nxWi+zE
 sNLk9bRrFA2clzQJmOWgWYfkN34RQnGNumpgU5Y0d7bAbiCGxJ3YMaYaMaOpnLmhhQvG
 hiFjp9NeqkxpcfyA+zvTEGN4u3DTcGPJLcBLhAq0CG9610V8GJbdIMNfNXEVFOJaWly8
 HP7zzsYdxp6X/4zyf/OLvNdORRdBpsPJNj4jFTKVSiOm4D0AcrLVHvEXgDB793ZokSf4
 aDVj84bnzXyI2+KpuZ58r2fmNvyAR4jGmnh8V2XEjSG7Y/+DC6ZXgyX9dCnNIZc/ENpD
 d7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TgjiWKnYVhNow5aXdsbc/uRaAI4MYXerKql/FbghhWU=;
 b=eqORMpE7LK33TsvntGkjuvqyijbQlnqysn29OTA6WkOjrupIS94+tQChM1V4uHalVE
 uPW2y4JbkKzt0nZIozDqMFMQX76bQ5XCgzkDuEeiYmiUgZoi+S4q4ltGvXt1BoqCg1oZ
 wCHO/CQjR+lsB1/FAnoxMXRwVGqbNlGAgr0sCRTRvlzYi6ya1Trmp/G756lof55Szx3L
 VdCRqUd/p7MkmZ8bg65boYcbfOxKVwiQQqWbBYaib6SOXhRK2XqNgucVHpX/gh4xW2eA
 QHSyE3qzNfAs97HLAOuF1+wRuMcjghIpvlIEbo1ybsSY0qT5pVaVnBouUx2BeAP6zWZE
 /5sg==
X-Gm-Message-State: APjAAAXYPev2ipxDH2vWEmrBGgHQ6e7YIg5fDkK+ar9VGJjOaiYYvKGq
 ofXlTmfG8YzinM6u7Vzv5TKdVg==
X-Google-Smtp-Source: APXvYqxTBR2lbuJeeNk0ACGX2TgvYzf9zUcFi4VAYQKmXcMZSptDP1Sb1aVngks/y1+7tqEpIUkaog==
X-Received: by 2002:a17:902:a607:: with SMTP id
 u7mr50899107plq.43.1563461908878; 
 Thu, 18 Jul 2019 07:58:28 -0700 (PDT)
Received: from [192.168.1.11] (97-113-176-6.tukw.qwest.net. [97.113.176.6])
 by smtp.gmail.com with ESMTPSA id c130sm26785693pfc.184.2019.07.18.07.58.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Jul 2019 07:58:28 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190718125928.20147-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <3b7e18bf-5450-3246-137f-9bc694edc17b@linaro.org>
Date: Thu, 18 Jul 2019 07:58:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190718125928.20147-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: Re: [Qemu-devel] [PATCH for-4.1] target/arm: Limit ID register
 assertions to TCG
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/18/19 5:59 AM, Peter Maydell wrote:
> In arm_cpu_realizefn() we make several assertions about the values of
> guest ID registers:
>  * if the CPU provides AArch32 v7VE or better it must advertise the
>    ARM_DIV feature
>  * if the CPU provides AArch32 A-profile v6 or better it must
>    advertise the Jazelle feature
> 
> These are essentially consistency checks that our ID register
> specifications in cpu.c didn't accidentally miss out a feature,
> because increasingly the TCG emulation gates features on the values
> in ID registers rather than using old-style checks of ARM_FEATURE_FOO
> bits.
> 
> Unfortunately, these asserts can cause problems if we're running KVM,
> because in that case we don't control the values of the ID registers
> -- we read them from the host kernel.  In particular, if the host
> kernel is older than 4.15 then it doesn't expose the ID registers via
> the KVM_GET_ONE_REG ioctl, and we set up dummy values for some
> registers and leave the rest at zero.  (See the comment in
> target/arm/kvm64.c kvm_arm_get_host_cpu_features().) This set of
> dummy values is not sufficient to pass our assertions, and so on
> those kernels running an AArch32 guest on AArch64 will assert.
> 
> We could provide a more sophisticated set of dummy ID registers in
> this case, but that still leaves the possibility of a host CPU which
> reports bogus ID register values that would cause us to assert.  It's
> more robust to only do these ID register checks if we're using TCG,
> as that is the only case where this is truly a QEMU code bug.
> 
> Reported-by: Laszlo Ersek <lersek@redhat.com>
> Fixes: https://bugs.launchpad.net/qemu/+bug/1830864
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Laszlo, would you mind testing this on your setup? I don't have
> a system with an old enough kernel to trigger the assert. (The
> change is pretty much a "has to work" one though :-))

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

