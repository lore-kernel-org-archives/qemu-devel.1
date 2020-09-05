Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B68DC43461
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 21:36:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4C942074B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 21:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8nOsrSq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C942074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEfri-0008CL-0x
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 17:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kEfqu-0007FE-Vo
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 17:36:04 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33171)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kEfqt-0000Z0-7h
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 17:36:04 -0400
Received: by mail-wr1-x441.google.com with SMTP id m6so10876319wrn.0
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2020 14:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1QGpsbUVYcVqW3TQM6TCEVmoInMoKqgyKs+x264Eg/8=;
 b=Q8nOsrSqKVi2VEey6NCzIMrnFg4xkS/IXyjXDyM9tjexVy+dK5XZcDsOcauIQqS7LE
 LiLa2luHJfM52DD9nBbHRtYwAgx5msNu57nFg0+C84ObbZSM+7gouHzyQjEFXKAn5Paa
 I0QvMQe2piDCEMK7E/ABIBzWTmvuPHDfGJWnPLWRMn3TxBNZO2x/Pqd8Ma6RXOEFC26h
 iqOv05UJHlrrO/ceIcdb213chHde3EjrHL3qOjKEo/XO+bMCe9y1KzPNd2O1YcE1KgYS
 pTZoUHgs3N0Pc/g4Dh+BhX7S0lKoTXUJ1M3ZzEzzKr9KovAC3PXKP8HZnb0/2z02Vp3j
 t8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1QGpsbUVYcVqW3TQM6TCEVmoInMoKqgyKs+x264Eg/8=;
 b=IQ1dAqA0IWxIZCCrGiQccH22UF612Zg6xkuzYDguHEYXHyj7PIogJw1zygkzwx7890
 zgKV/kqblsDTkPlssmsLVq3fbPpG+E9n9WcNMVEAVpsRy+KTh/I1i3ioMbd6FuTQtBuH
 fcZSC1fC/FCFOkovkMMGMt5nFsfBZroSfxJQPfzKb/DsQYZ8d+gHJBvPdtbfk0/+n9H0
 38GlguZ+nF0jvKLDBhNtWKe8XRilDWThN/3ScQE6H9iYUEf1P0FUrNzZDOYVbxWCypOd
 7M7X1kV0q4vQEkx+Ee7tFi5ks89Z18IQm9stwEK2qEywY0KdP4VXidRzkNOMsNpwl7Os
 hEAA==
X-Gm-Message-State: AOAM531ERZR8q7RtcO711nPFBDOpcHUju+0uGVt57h0wVq60Lq1HGzPh
 odDRxV8aYzw9jsA7ZL5uESM3bpD2ehs=
X-Google-Smtp-Source: ABdhPJzRD/AZiPdGDgUY5ir9TTw9qYofPGkKbuzBHy58GInH3AeU57RhXb9jwpg0EI+MbwYnf9rRJw==
X-Received: by 2002:adf:fa0c:: with SMTP id m12mr13574481wrr.406.1599341761963; 
 Sat, 05 Sep 2020 14:36:01 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id 8sm21150984wrl.7.2020.09.05.14.36.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Sep 2020 14:36:01 -0700 (PDT)
Subject: Re: [PATCH v3 13/19] target/microblaze: Reorg MicroBlazeCPUConfig to
 minimize holes
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200904190842.2282109-1-richard.henderson@linaro.org>
 <20200904190842.2282109-14-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6eba6a5f-6f9e-3568-9a30-17a8532639a2@amsat.org>
Date: Sat, 5 Sep 2020 23:36:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200904190842.2282109-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-0.107,
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
Cc: edgar.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/4/20 9:08 PM, Richard Henderson wrote:
> Sort the elements by type and size, removing a number of holes
> and reducing the size of the entire struct.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/microblaze/cpu.h | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index 59d2a079c4..4d53345f23 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -293,13 +293,22 @@ struct CPUMBState {
>  
>  /*
>   * Microblaze Configuration Settings
> + *
> + * Note that the structure is sorted by type and size to minimize holes.
>   */
>  typedef struct {
> -    bool stackprot;
> +    char *version;
> +
>      uint32_t base_vectors;
> +    uint32_t pvr_user2;
> +
>      uint8_t addr_size;
>      uint8_t use_fpu;
>      uint8_t use_hw_mul;
> +    uint8_t pvr_user1;
> +    uint8_t pvr;
> +
> +    bool stackprot;
>      bool use_barrel;
>      bool use_div;
>      bool use_msr_instr;
> @@ -313,10 +322,6 @@ typedef struct {
>      bool opcode_0_illegal;
>      bool div_zero_exception;
>      bool unaligned_exceptions;
> -    uint8_t pvr_user1;
> -    uint32_t pvr_user2;
> -    char *version;
> -    uint8_t pvr;
>  } MicroBlazeCPUConfig;
>  
>  /**
> 

