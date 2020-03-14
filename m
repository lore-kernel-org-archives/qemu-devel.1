Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3F7C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 06:40:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBEC82074D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 06:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hfrB+W0d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBEC82074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD0TY-0005ZR-TV
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 02:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jD0Sx-00052K-7F
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 02:40:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jD0Sw-0004jP-4f
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 02:40:11 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:46011)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jD0Sv-0004ec-TT
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 02:40:10 -0400
Received: by mail-pl1-x644.google.com with SMTP id b22so5343196pls.12
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 23:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=UNv7mbFCsIt+gDvuuQ73IFS+2/4+W79RVJ3t+h5YNUA=;
 b=hfrB+W0dHnh8rM6PNmbhBAFukrxIpVjcZgzNTGldMF7Dls/0MPzMOXTu64wYkXf6QR
 JTyH9QylMEr2BKvizj9WzYSdxVwASK/h/ogE3E+J1ciCa5ILI/Ql4E9/CMa3l3sOpnn9
 tlxWH35ztAfJlm7HFHYHcuMJGb6DcnanoEvxfC1jY+QGp2xTgrhAMhdXQTX8m71dGUDi
 KXJvmf1HbVnbaUTV0YwwDDlWLR3mtfx7iWjn2JvlfeaHa4p/1928JUvAFxB+DRVWyDU0
 oZNbPfF1InccVAVOS6Jf6feHSFgbPNYkfE91DCHNVGrpQRP1U+fzgH9evuo/810gsm7O
 U9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UNv7mbFCsIt+gDvuuQ73IFS+2/4+W79RVJ3t+h5YNUA=;
 b=fdiwHCAb0OlMYS3KC1WTRwjBUpwBTQV20RMNpAHTQuWUXb3U5O/vm5X+KwseQJ0GB1
 Sy8vs5+5njqKAZGTy0RS0z0fWr/r5+fIaOdZKyVu0Iaxr2WQkN6GS+jwDUVge/A3hNjg
 xjKMnqLbDcRjn8pxp8Yh8Z8W61UMgM8RnaHcqk1PXNk0Ah6wdPlNB7vjolQUf+MMGqX2
 10TmxKt7aQrngNg/U1TJkfBxN7xShLAATNdOGTRyyqV+Et7p8eGjf3+KFDNwzg0oEyqn
 v+67pM9E0UXbUMa1w6eFvdAzJ5AhcLZohaMPrrIJoArwGbC7O/UV94buOhSq9xF+hwsA
 T4xw==
X-Gm-Message-State: ANhLgQ3vgH/TozmNI3jujK1Eln7p1VzSWQ2PPVwH2bdeYZfktB2dgUfg
 aAJf5axLWakLrQWEbzwFbyK7pA==
X-Google-Smtp-Source: ADFU+vsviXP4RN1t/NVy2G0XJdN8wPqPKy/ymJ/APK6LcxMKKGcjJMOAO4SxBJPTlkhYWQNb4IdZSQ==
X-Received: by 2002:a17:902:8546:: with SMTP id
 d6mr16916258plo.193.1584168008752; 
 Fri, 13 Mar 2020 23:40:08 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 q91sm6949108pjb.11.2020.03.13.23.40.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2020 23:40:08 -0700 (PDT)
Subject: Re: [PATCH v5 16/60] target/riscv: vector integer min/max instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-17-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <dd447400-918e-b253-8bd5-becc485a03dd@linaro.org>
Date: Fri, 13 Mar 2020 23:40:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-17-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/12/20 7:58 AM, LIU Zhiwei wrote:
> +/* Vector Integer Min/Max Instructions */
> +GEN_OPIVV_GVEC_TRANS(vminu_vv, umin)
> +GEN_OPIVV_GVEC_TRANS(vmin_vv,  smin)
> +GEN_OPIVV_GVEC_TRANS(vmaxu_vv, umax)
> +GEN_OPIVV_GVEC_TRANS(vmax_vv,  smax)
> +GEN_OPIVX_TRANS(vminu_vx, opivx_check)
> +GEN_OPIVX_TRANS(vmin_vx,  opivx_check)
> +GEN_OPIVX_TRANS(vmaxu_vx, opivx_check)
> +GEN_OPIVX_TRANS(vmax_vx,  opivx_check)

As with rsub, it is possible to use tcg_gen_gvec_2s to produce inline
vectorizations of {u,s}{min,max}.  But that can wait, if you like.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

