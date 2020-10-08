Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6475C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:46:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 472BE221FE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pmR9mbP0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 472BE221FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQa0H-0003Np-0r
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 13:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQZyB-0000ui-U9
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:44:47 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35026)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQZy9-0002g3-TB
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:44:47 -0400
Received: by mail-ot1-x343.google.com with SMTP id s66so6325849otb.2
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 10:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JlCKIDzL06TETmIyLgqZN56T4P1n8vLk7Sh0pCBSLyM=;
 b=pmR9mbP0Vy/p1h+P8aIHkhaDh9w9CsCzFBpjN+s8QyjgkTg2lcGfaqLRqSsaobBQAD
 Pa4vgLotJJ8UNtM/ub/r6m5UfoR2mhy6vU1CQg+NUY+LmT/hU00j3YCvWVn4rH+Y51eP
 reZP0DgSr6oUiPk8jpqjPLc2dkyDK5ctYLPtX5PFUEhh+RXei1Lndk16TzhifFghmO0f
 u4RuE7cyB7l0RoeHHhH4mFV8UPOc1xgdG7Q7opZUwmWtwINxwOqUEO/Y/QV4mrlsB7qg
 wJ+oPR/fIr9TJnm/ojf1ULY4om+PrxfLNTBq6BtFer3n/eJDyUkkmiLdgipg/a1YlqJh
 O+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JlCKIDzL06TETmIyLgqZN56T4P1n8vLk7Sh0pCBSLyM=;
 b=XRBhMmtSEtFBjaYg2iDgD4Un5K8qbugBqQFIrjhq8jpgY7/aFkqyU8i9RZO7eqASz4
 ZxZKTkgF3rgxLknnnMovFWpQUclm7rwN/UpwanFotp0kF50DzN86LdXlEnvvlf0bCDaa
 Prkr2NUCsHFDlHoyotyvNBZWdy1xTv2lKCfjQ14WEP4EcJKClt1tqin+JSDgEyBEH9Xj
 2SqtpJyYUvILdGz6PiSICFuylUb9+fDFDbn4jXsdFE9CLj42YZpi98JNSCjTp8vL3JKb
 exZB2DEZpVM7c8uLAxIv+SbPOqOvsVaPLeyY5ZoUcIIJ/lezOYUUKWyaGXyx64QrynS7
 PYTg==
X-Gm-Message-State: AOAM531l2SLOjX79T0kGhUk9XIUduyXzafQShpltzTi/RcvpEpqQIxbB
 qIoc6+hVyZ/PE+T4G04qt5E52GvhuKTWvGls
X-Google-Smtp-Source: ABdhPJzBZHih7XD6qoUQbnQvZvhQ3rTd5IxVU2ZKAFmx4ado4dsLyFme6hdEpA7VHmR9AJ4+yBjqdg==
X-Received: by 2002:a9d:4818:: with SMTP id c24mr6256121otf.128.1602179084094; 
 Thu, 08 Oct 2020 10:44:44 -0700 (PDT)
Received: from [172.24.51.127] (168.189-204-159.bestelclientes.com.mx.
 [189.204.159.168])
 by smtp.gmail.com with ESMTPSA id 65sm4493806otj.75.2020.10.08.10.44.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 10:44:43 -0700 (PDT)
Subject: Re: does make check now require TCG? Or is it a parallelism issue?
To: Paolo Bonzini <pbonzini@redhat.com>, Claudio Fontana <cfontana@suse.de>
References: <11ef73ff-4178-b3e8-2e49-44ff014a13ed@suse.de>
 <569520f6-adf6-6212-9625-a184bf499e24@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d21dff22-90b1-4769-0948-6bc37eaeb885@linaro.org>
Date: Thu, 8 Oct 2020 12:44:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <569520f6-adf6-6212-9625-a184bf499e24@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.214,
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
Cc: Alex Bennee <alex.bennee@linaro.org>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/20 10:02 AM, Paolo Bonzini wrote:
> On 08/10/20 16:48, Claudio Fontana wrote:
>> on master, a build without tcg like:
>>
>> exec '../configure' '--disable-tcg' '--enable-kvm' '--enable-hax' "$@"
>>
>> make -j120 check
>> Generating qemu-version.h with a meson_exe.py custom command
>> make: *** No rule to make target 'qemu-system-aarch64', needed by 'check-block'.  Stop.
>> make: *** Waiting for unfinished jobs....
>>
>> qemu-system-aarch64 is required for check-block now?
> 
> No, it's not, it's an unnecessary dependency.  This will fix it:
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 5aca98e60c..1ca70d88ce 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -140,7 +140,7 @@ QEMU_IOTESTS_HELPERS-$(CONFIG_LINUX) = tests/qemu-iotests/socket_scm_helper$(EXE
>  check: check-block
>  check-block: $(SRC_PATH)/tests/check-block.sh qemu-img$(EXESUF) \
>  		qemu-io$(EXESUF) qemu-nbd$(EXESUF) $(QEMU_IOTESTS_HELPERS-y) \
> -		$(patsubst %-softmmu,qemu-system-%,$(filter %-softmmu,$(TARGET_DIRS)))
> +		qemu-system-$(patsubst ppc64%,ppc64, $(shell uname -m))

Why doesn't the original line work?  Waiting until all of the configured
qemu-system-* executables to finish building doesn't seem wrong, even if they
won't all be used by check-block.

This replacement would seem to break e.g.

./configure --target-list=arm-softmmu

by making check-block dependent on qemu-system-x86_64, which will never be built.


r~

