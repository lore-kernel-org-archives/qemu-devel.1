Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF675C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:44:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2D3C2083E
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CZ4Azo21"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D3C2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCrbe-0007uo-RD
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 17:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCrb6-0007VF-O2
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:44:16 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:39749)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCrb4-0004Y9-4X
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:44:16 -0400
Received: by mail-pl1-x644.google.com with SMTP id x18so2643077pll.6
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 14:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mOj92M6z/DeAo1lowpDfxwqCpg/mExPdADSUPgU7FXA=;
 b=CZ4Azo21j5A1bUE1UGG9UY06JgMLJ1omzK/nahnowncQd5AEutrE0L5ARZVk0xCu02
 RRHFmDtPajI5nuiSIc51mzgdS4y3fhw0qrfOvG07wFugN7S824rnSLd9Ibl/JJod/vFD
 GGuCuj7MZx563PnERUncMepqXn7iNESg6hl4Wi6WdvE0oyiEL+4GzIhdCLteCFMEy9jO
 7R3aDC3PYCloIoHzwXICHGKY7Gp5lxHpPQVR9EVGkojJ0oV3O+KCRP+3JY0hLm6Zw9Gs
 EBmuvWA7+oMe4nYk97eQymAhXS5kSS42UWVsM8aS/ItU2bR6ibhTrhGivUUeKTyeesLA
 VoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mOj92M6z/DeAo1lowpDfxwqCpg/mExPdADSUPgU7FXA=;
 b=SFsuIhsQqJ2lDb1DaAv5sRW6nybMQu6n/uDu7dV1IlNTJ8Rjlu935/M/9ZEfXrmxMT
 EzlP4z5d7E9QHsPu+/NHU6zH42gBRsZTY5P7Dg1g99X9whIEdd4fjUNZIgBugNJmVD2y
 ZEhcXkAedSPL9Q9neOkGEuAVq1YTiTDrOAdyCG6GWfIpYs0HQV3iL/4cI11R42ROObdo
 Q2IH/58fecw1uKBD6G0PLFrKoq7wRM446odWM5tL2qc7GFRosMoI/+kdBRZUByXUjSUF
 ZgdMtd2dCuEACBhLDNftrr3o9+HOGM80xwVLvPGmy2rDX/45IfjA2fs+ZXZNUtrWfW1M
 jgDw==
X-Gm-Message-State: AOAM533rPyWGrVArd/AOm14jPC76nEdIDD0+zWWopiF0XmWiUtSmASC+
 JoLw/jtnsBaBaiwbrYPWI5F/cw==
X-Google-Smtp-Source: ABdhPJy8SezVJYIE8Wgu5i3gLfpLhInvLfvr7gvTev0Tjmv0nfCRg2om5myplDE0zmkMaV51cT2C5w==
X-Received: by 2002:a17:902:8a85:: with SMTP id
 p5mr2581196plo.193.1598910252287; 
 Mon, 31 Aug 2020 14:44:12 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id lj3sm557589pjb.26.2020.08.31.14.44.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2020 14:44:11 -0700 (PDT)
Subject: Re: [PATCH v2 5/7] accel/tcg: Change BQL critical section in
 cpu_handle_interrupt
To: Robert Foley <robert.foley@linaro.org>, qemu-devel@nongnu.org
References: <20200819182856.4893-1-robert.foley@linaro.org>
 <20200819182856.4893-6-robert.foley@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <945c4b19-9941-5628-214d-b3f2c83aef6c@linaro.org>
Date: Mon, 31 Aug 2020 14:44:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819182856.4893-6-robert.foley@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
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
Cc: pbonzini@redhat.com, peter.puhov@linaro.org, alex.bennee@linaro.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/19/20 11:28 AM, Robert Foley wrote:
> @@ -625,7 +624,6 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
>          }
>  
>          /* If we exit via cpu_loop_exit/longjmp it is reset in cpu_exec */
> -        qemu_mutex_unlock_iothread();

The comment no longer has an "it" to reference.
We should probably expand that to mention which lock.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

