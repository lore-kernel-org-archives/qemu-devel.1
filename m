Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E6AC47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:49:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAD372073E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W1rnXekc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAD372073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUEFC-0004T4-TG
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 14:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38780)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUDwo-000713-IQ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:30:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUDwm-00051j-QD
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:30:10 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:55924)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUDwm-0004wl-Bd
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:30:08 -0400
Received: by mail-pj1-x1043.google.com with SMTP id a32so1088295pje.5
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 11:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=L5jdqP3nOkRKrOSceDd/G4FGfjto9mJjy8zkhK2QHSU=;
 b=W1rnXekcKUNYSDzepkfU4jYUx9+6kzFG7m4B6WVYq6FHCCMx9MI/yTao9GcBpMFYoV
 2yxNetacs9RZsa8dI0Tb9KA7O2EYzeJLauLqA/N8QPILHz271BIicatvtopdO8W4cDYf
 Kn+gndwXjdmjQijlCQiLW81qzJyW0npz4PqIB1ZbZUjKJehrt9ASYkL8W/KzKzvhk8OK
 t1r3KqGVvhcsgU3putfj4ZrFO3n/ZPcJpq8M2GgtVqtUXTsn1y9U9+5V1L+pozyeXfkF
 n+mgt6u1Aw1iA+pcbAtJvSxCzRO6ENf1+cUyjeB0rBw8CoiBEGCMGoAhWFWB5jeEMmXy
 86aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=L5jdqP3nOkRKrOSceDd/G4FGfjto9mJjy8zkhK2QHSU=;
 b=Q/HwCNKltSakFXkYvxI4U1JFSFubdGXL/eFwwXLO9in3B+hfkyU+a/+MHpkpoiabBq
 V/2BPmeQ+E8wAsxSmIRDUSTteeTi0Wc8RTGaXaAqeq+QqFUGMOf678r8nTdNnPUp3Rqk
 64hTCJk1Lph0BKgcMAW4mTJGBPg6oiK9hAc68eu3d+deqcgNKnsO8EnpFCgzzuVQQ77i
 j3Rrl27Iagl0v3b5q5ZZ5fq5WDRWjM7OUMpmfcdIoG/XqjNaBhyzcn9VG90QstA8DhML
 AvQXYNm/zskMgf4Wc4RppskUQlsg3/v0oYx3I4PYyd+00L/Sck5AhwjVOOaYG6HFrWt+
 FCug==
X-Gm-Message-State: AGi0PuYZizlPwj8BvumVbZGIbFHVgqXmGhDq+KBOkaLkkvW//xRAU3rh
 5dsp1SMBFPkTkTJ9DFZ0mhYLm7wnU/c=
X-Google-Smtp-Source: APiQypLZeSo20UTzo0HMgRKfY+/kkQs3KzP5jQ+t/Ol8GGLaSYVgrs1Vl3b+ovBAYgwucc5VGkN0Iw==
X-Received: by 2002:a17:90a:1b4c:: with SMTP id q70mr90801pjq.55.1588271406456; 
 Thu, 30 Apr 2020 11:30:06 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id d203sm419462pfd.79.2020.04.30.11.30.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 11:30:05 -0700 (PDT)
Subject: Re: [PATCH 03/36] target/arm: Add stubs for AArch32 Neon decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200430181003.21682-1-peter.maydell@linaro.org>
 <20200430181003.21682-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9fc66f0b-d818-c4e3-db06-5776f97184e6@linaro.org>
Date: Thu, 30 Apr 2020 11:30:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430181003.21682-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1043
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

On 4/30/20 11:09 AM, Peter Maydell wrote:
> Add the infrastructure for building and invoking a decodetree decoder
> for the AArch32 Neon encodings.  At the moment the new decoder covers
> nothing, so we always fall back to the existing hand-written decode.
> 
> We follow the same pattern we did for the VFP decodetree conversion
> (commit 78e138bc1f672c145ef6ace74617d and following): code that deals
> with Neon will be moving gradually out to translate-neon.vfp.inc,
> which we #include into translate.c.
> 
> In order to share the decode files between A32 and T32, we
> split Neon into 3 parts:
>  * data-processing
>  * load-store
>  * 'shared' encodings
> 
> The first two groups of instructions have similar but not identical
> A32 and T32 encodings, so we need to manually transform the T32
> encoding into the A32 one before calling the decoder; the third group
> covers the Neon instructions which are identical in A32 and T32.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/Makefile.objs        | 18 +++++++++++++++++
>  target/arm/translate-neon.inc.c | 32 +++++++++++++++++++++++++++++
>  target/arm/translate.c          | 36 +++++++++++++++++++++++++++++++--
>  target/arm/neon-dp.decode       | 29 ++++++++++++++++++++++++++
>  target/arm/neon-ls.decode       | 29 ++++++++++++++++++++++++++
>  target/arm/neon-shared.decode   | 27 +++++++++++++++++++++++++
>  6 files changed, 169 insertions(+), 2 deletions(-)
>  create mode 100644 target/arm/translate-neon.inc.c
>  create mode 100644 target/arm/neon-dp.decode
>  create mode 100644 target/arm/neon-ls.decode
>  create mode 100644 target/arm/neon-shared.decode

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

