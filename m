Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB9EC43463
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 23:21:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87F0420723
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 23:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sk0gOV/F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87F0420723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kK8eQ-0001jM-H0
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 19:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kK8dG-0001DD-JS
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 19:20:34 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:38356)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kK8dD-0006gW-Iu
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 19:20:34 -0400
Received: by mail-pf1-x443.google.com with SMTP id l126so7595856pfd.5
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 16:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=pePguU57LqFD1mooXhvHCAQdqtt1s51NiiD5fE+eEuM=;
 b=Sk0gOV/FRxBj/UuY+1Fu9FiAl8Kj11qKB+0WUC9/GMn9wzEsfmu+p4PjZ7acJ6892W
 FI7KuwreV/DEeME/nMgICz5UqthibmvwPiOoWTTjxfzU6SqZjvXD1jx27ocVjU6bl89A
 JbZpc2p4sFAopNeaP3aYxRmpiryTWGdYg3vEZJNOw8R4Iu3HzUsIKg7QeB0Y5Fj6UpMC
 JAwCbcPs1X8tyuknPwUHb6Y/2sR3ck+UUmtL/KBaj7wikPJo9ubjd3GPANhIUUCvug2N
 JOzPkFMi/7YnNlhZRQi4m6KglvgN4ljEEAqVnTjsDq1Pm8IKVnxBzmYepGqo5g8nBtYb
 AP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pePguU57LqFD1mooXhvHCAQdqtt1s51NiiD5fE+eEuM=;
 b=gyxvyjaux35b3OKwDOpBZqgPi+56+08BlYxriRf49tEOivVtMT3cWWTRETagkLmAt8
 2Y4ANHvoclos0LMb96mCiq062CzPTCNybEc+5DEo59Wqi7ynWpYb9BlEqKHMhZZwCW4z
 kDIhjoPQteXMHuIWthrfZYQN+0NuL2atwKVHSl+Do0S3IxFw96/1nAHD4DwI+1FvAZHB
 rWFfhtpu906rmzgkJfwA+7Gd7WUc+K5EZX+2nB+3YQ+vCykrn0IH39zapMxRQOvQEWHa
 gxmYyjJNoGFcu5gKHxYS0OWiqO8BdWrY4r0j82X3vu5YK7X7bk96aHxap//WeKFVz5WR
 UYAw==
X-Gm-Message-State: AOAM530hhOZ21p96kJsWiFpnJpOd8BcHphn/w4TXI5LygGat3K1Ub6dc
 6kzgWuVFae8kpqw9sLHcm0f5kqEsGoPVLA==
X-Google-Smtp-Source: ABdhPJzauvHEYAKNJK7NpsyqtTPTl98cV85AEG46zPCyWRJqxTCGmrhl3UcCKFQBRqRImqdD9OLpCw==
X-Received: by 2002:a17:902:fe94:b029:d1:e5e7:bddd with SMTP id
 x20-20020a170902fe94b02900d1e5e7bdddmr24429885plm.61.1600644029418; 
 Sun, 20 Sep 2020 16:20:29 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j144sm10312024pfd.106.2020.09.20.16.20.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Sep 2020 16:20:28 -0700 (PDT)
Subject: Re: [PATCH 3/4] configure: do not clobber environment
 CFLAGS/CXXFLAGS/LDFLAGS
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200920093016.1150346-1-pbonzini@redhat.com>
 <20200920093016.1150346-4-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <99c2b869-54c1-0115-ebdf-a874c9665db5@linaro.org>
Date: Sun, 20 Sep 2020 16:20:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200920093016.1150346-4-pbonzini@redhat.com>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/20/20 2:30 AM, Paolo Bonzini wrote:
> If the CFLAGS, CXXFLAGS or LDFLAGS variables are present in the environment,
> any modification made within the configure script is passed down to Meson.
> This is particularly undesirable for the "-pie" option, since it overrides
> "-shared" and thus messes up the linker flags for shared modules.
> 
> Using a separate variable therefore fixes the bug, while clarifying that
> the scope of these CFLAGS is just the configure script.
> 
> Reported-by: Frederic Bezies
> Analyzed-by: Toolybird
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


