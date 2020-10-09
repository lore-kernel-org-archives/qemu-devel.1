Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0B0C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:58:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 404FF21D6C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pMmU0brW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404FF21D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQwf1-0007kl-Gl
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 13:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQwe0-0006tP-Ht
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 13:57:28 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:35903)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQwdy-0007y1-UE
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 13:57:28 -0400
Received: by mail-oi1-x230.google.com with SMTP id u17so11084257oie.3
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 10:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=VWXoUlhrihZHdeYv9Q6pYpDUJLFdpFM3zZJeR3athUQ=;
 b=pMmU0brWHROdC8egsL7tibGSPKgk9SBqjJODnfpSDaYLOmehA+z30BPNZZrylMUmyO
 aCeQDrhZIp28aolGel/CITVyndtPB6wWHL1/Vpa5uH7b1iG2ZD3CZ2Yz1tiibGYe4pDt
 H6kweI7osq2T1ZZ4mAACyHuR9E3qGpsZSYppXdySYFojdQthhJ0dw1rzxYRoNiMKMqaX
 J5h5LxeSVq+CLi8le7UTc7gyv66DeOgim4B/DXBfNRiHaGVtM+jxH2XZc1FV3/pn+zdo
 iD4nr7A65FLsnSLLcFXWYdlVXXwT+5bwdwND9D8M5RK+RgXCiq4hG//d2dMaBJg3H0Xm
 rVRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VWXoUlhrihZHdeYv9Q6pYpDUJLFdpFM3zZJeR3athUQ=;
 b=j/vcwR2LSb0F4kzrb7N7W9kvfQ0ASta6s6xx0PjM7Wvse92qhCAgCNYKYG1vys8fyt
 yzQKDILqM8M2CVEcXYsyjlx+GOJWK7na02omrd6Qzgf0nBVG6xdP6dc4DDpjQ6CLUpcV
 a4uDn5DGE7LYtItebsL+QGdeMntHVfUz5q0GbE3YtXZG4bLLgTO3PtqmB+vikGGLjVP2
 AwkNHGOW7GAyFfpiwCgUXLkMWkjMTkeEF3RECbA7faTQPR4ngKCoVeliwRewow7xdzw1
 MB96BiJtZYa/s+WsFKwifw3ywu9octp3XJe5TjMAk34v8kXb+wJJ3zZK6LOpZq9pNYDs
 3eQg==
X-Gm-Message-State: AOAM533DepY6hqNu9aynfa1LkH4mtjw+opkJrj3TY3nKvJX4KI/TiXAM
 +TJy9AZgzZVNAofvjH/FgdRieCCFsraxao7R
X-Google-Smtp-Source: ABdhPJx0dVCDZUsv71uP1qzUqYEfk3GL/juufW+s7hWZaxmEKawtlSt3r5ics4WgAyp3fpel8+n+dg==
X-Received: by 2002:aca:e0d5:: with SMTP id x204mr3042000oig.160.1602266245219; 
 Fri, 09 Oct 2020 10:57:25 -0700 (PDT)
Received: from [172.24.51.127] (168.189-204-159.bestelclientes.com.mx.
 [189.204.159.168])
 by smtp.gmail.com with ESMTPSA id d9sm7375737oig.56.2020.10.09.10.57.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2020 10:57:24 -0700 (PDT)
Subject: Re: [PATCH] target/arm: Fix SMLAD incorrect setting of Q bit
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20201009144712.11187-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9b6bcfac-922d-675c-d7b4-35491a3efe60@linaro.org>
Date: Fri, 9 Oct 2020 12:57:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201009144712.11187-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.208,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/9/20 9:47 AM, Peter Maydell wrote:
> +        /*
> +         * t1 is the low half of the result which goes into Rd.
> +         * We have overflow and must set Q if the high half (t2)
> +         * is different from the sign-extension of t1.
> +         */
> +        t3 = tcg_temp_new_i32();
> +        tcg_gen_sari_i32(t3, t1, 31);
> +        qf = load_cpu_field(QF);
> +        one = tcg_const_i32(1);
> +        tcg_gen_movcond_i32(TCG_COND_NE, qf, t2, t3, one, qf);
> +        store_cpu_field(qf, QF);

This works, however, QF is not restricted to {0,1}.

Perhaps this is simpler?

	qf = load_cpu_field(QF);
	/* t1 is the low half; extract the sign bit */
	tcg_gen_shri_i32(t3, t1, 31);
	/* t2 is the high half; must be 0 or -1,
	   and the extension of the sign bit.  adding them
	   must equal 0 (0 + 0 = 0; -1 + 1 = 0). */
	tcg_gen_add_i32(t3, t3, t2);
	/* Any non-zero result sets QF */
	tcg_gen_or_i32(qf, qf, t3);
	store_cpu_field(qf, QF);

Either way,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

