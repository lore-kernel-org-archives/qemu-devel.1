Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7D7C388F2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:30:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4AD22067C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyJiV/+9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4AD22067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZm59-0002Pp-R8
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 21:29:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZm3P-00014K-Hc; Mon, 02 Nov 2020 21:28:11 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40174)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZm3L-0005sW-LZ; Mon, 02 Nov 2020 21:28:11 -0500
Received: by mail-wr1-x444.google.com with SMTP id 33so5986384wrl.7;
 Mon, 02 Nov 2020 18:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=R4W6Up8fZ0pGiMe32f0Q6Q7teHooQxTaUOD9jKr3cqw=;
 b=IyJiV/+9hXi88DgxKEOvdBYul10dRFkNd13+VlvwR01RDbTDZVgNBv3fuVh25uBov+
 iCAOBVNOwIBAchJr8szsIFd/1p9SHtU5qVdqBRDhwpXWB9UionZaHSG/Rt493X3Rt74N
 mPt4kIulG6FxWSl5b/MAzyXjI0QDfsy5Hu0ioieiRl2pNKIX6fj6p5NSHT3a62prWwb3
 Ji1LdbHeLpdYs5h2j6AY1mD7NjWX5bkMFrhT6tszX7YfpC5HesYIjCUkS8mk2t6y5OxD
 b6rZINTHvV3elNU/cKJzmTQjsO9uFrk0UhilmmOG9WCu4PWxZ/EeO1oIAZXSlW0TgWhx
 OVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=R4W6Up8fZ0pGiMe32f0Q6Q7teHooQxTaUOD9jKr3cqw=;
 b=IWfa8nUrSsh0u+8Sbt7IzWI2bULJIh1FvHxDh2GCFkfiOzk6AlUfG3g/NiWEvtnvSy
 eXiQeZkis+6IcXQy9wRK0H8iIGjgrFtIhezH6iM8YAFafiDLQgPEiZG2ekKqsPioQnkC
 Sijrb5vRCQgfQM961DAAy+Jn+5LIUFTPYRTqdj27SBEz+xOqBQdnrgKZXuRJMqBImaIu
 XiwDJAUsBkyDj5pDgC6KI2WLxG50+VZXlccU7iqPS/IEyY8lRKnifYjYdRwO2tebsGCq
 Deqwj9hKbg5bnLrfUgN1Yx/ZsslxHV/yksOGpRGhEM1GhWXJnWJ0vjmK4b5qy2rmPnT4
 16ug==
X-Gm-Message-State: AOAM5320uEPkRBH6xFhgiEi5YIP2rp/aqLletiU3fSFBoi7gNpXbSH+T
 k8SpN/U6iqVGJH/4T+aMHM8=
X-Google-Smtp-Source: ABdhPJyzAX2hDZnIDuVPl9JugpukIG4H2xOkd/YeLdJS8bChX+ie5CFfnYVcm0aLpNlKkYMtHBMFwQ==
X-Received: by 2002:adf:e743:: with SMTP id c3mr23769135wrn.317.1604370476260; 
 Mon, 02 Nov 2020 18:27:56 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id l11sm22500032wro.89.2020.11.02.18.27.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2020 18:27:55 -0800 (PST)
Subject: Re: [PATCH 1/6] target/xtensa: fix uninitialized variable warning
To: Chen Qun <kuhn.chenqun@huawei.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>
References: <20201103015228.2250547-1-kuhn.chenqun@huawei.com>
 <20201103015228.2250547-2-kuhn.chenqun@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ae6feaeb-9b1f-0996-33d6-1d19fef5f3fc@amsat.org>
Date: Tue, 3 Nov 2020 03:27:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201103015228.2250547-2-kuhn.chenqun@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: zhang.zhanghailiang@huawei.com, ganqixin@huawei.com,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/3/20 2:52 AM, Chen Qun wrote:
> The compiler cannot determine whether the return values of the xtensa_operand_is_register(isa, opc, opnd)
>  and xtensa_operand_is_visible(isa, opc, opnd) functions are the same.
> So,it assumes that 'rf' is not assigned, but it's used.
> 
> The compiler showed warning:
> target/xtensa/translate.c: In function ‘disas_xtensa_insn’:
> target/xtensa/translate.c:985:43: warning: ‘rf’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>   985 |                     arg[vopnd].num_bits = xtensa_regfile_num_bits(isa, rf);
>       |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Add a default value for 'rf' to prevented the warning.
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  target/xtensa/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
> index 944a157747..eea851bbe7 100644
> --- a/target/xtensa/translate.c
> +++ b/target/xtensa/translate.c
> @@ -953,7 +953,7 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
>  
>          for (opnd = vopnd = 0; opnd < opnds; ++opnd) {
>              void **register_file = NULL;
> -            xtensa_regfile rf;
> +            xtensa_regfile rf = -1;

NAck (code smells).

Deferring to Max, but possible fix:

-- >8 --
@@ -953,10 +953,9 @@ static void disas_xtensa_insn(CPUXtensaState *env,
DisasContext *dc)

         for (opnd = vopnd = 0; opnd < opnds; ++opnd) {
             void **register_file = NULL;
-            xtensa_regfile rf;
+            xtensa_regfile rf = xtensa_operand_regfile(isa, opc, opnd);

             if (xtensa_operand_is_register(isa, opc, opnd)) {
-                rf = xtensa_operand_regfile(isa, opc, opnd);
                 register_file = dc->config->regfile[rf];

                 if (rf == dc->config->a_regfile) {
---

