Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE742C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 00:07:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B7B72075A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 00:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YYCv/iJj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B7B72075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3pvG-00081P-DG
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 20:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k3prh-0006TE-27
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 20:04:05 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:46201)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k3prf-0006OI-DW
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 20:04:04 -0400
Received: by mail-pf1-x42f.google.com with SMTP id 74so19467pfx.13
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 17:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ho45DBGj9ihQx+//JMUAsoSDjVWvwe+kK/BHEcqW30M=;
 b=YYCv/iJjhGtSNYahuG6YuHgDfOWjqkrMO6zijJz0fnLQY0aVqTx5e43WrsRqpFA6Ro
 Kbcq73XPe+wfnk6HGhaUqpXvR4e0FffexQQDveJ0WjY1FglVYc0hBpT9J6kDORBGqZVT
 iP7CcKKv2Cjrz9sj0mTKJxsbBtVFHeR6c+hDDU3Dyun8S3wRlu1qGjvAWfB9YgF2gYsA
 z4TnrZr9I32oA/kbckunlAL1ZxExtxlE3y8B5NOET9bcuv0qpnHDuLd4NUn0WE6pvlC5
 ayH5eWT4VABzJDwX/8zFeHr70tzdDub1hqIZdVpVgMobNWGt38PFX0vkF67dlu2LfE4b
 APuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ho45DBGj9ihQx+//JMUAsoSDjVWvwe+kK/BHEcqW30M=;
 b=gLwRdBNZwpFLUqzVK7W/6i9ujgY5noz95DC8dg/M8wJz9c6PCj2sO/sh4IvwxbbhMn
 SoXw7Sw7/Qqw/GKru+4vyXykrcdBALAtZwjPzycCYUgOeCczZ830Ywxjm9NsnqrV+Ea4
 GF6uSRd+lnaGOq4LYcB3VQ9gea+eYFRJBpnP+L3A9Ez9S+Kub0DNQ9/oYGk/x63wcKwb
 6QHXAl7cO+/scHCzMsLR+id1Cbx3fgXFt6zvMEwsLb5wHQT5O8rIraWfp/BPfx46oyrz
 oQA8DrOwKm0GUru7qbKIrKL8O7d4rz/aQW6AgUnvzzvawtUZITctPSRAIredfhvCEjxO
 kTTg==
X-Gm-Message-State: AOAM532zLdWSf/NyhNFXjb/8KJHToVe6NG/vfwuReDKli0asw2fBvMc5
 zgQ3Z0xLIbrvl43GBJerC5VOkw==
X-Google-Smtp-Source: ABdhPJxY/JDNh6ff59xzGYiE0Sl24m18pTEyQyridsU2r3YLx1KQWpXWeqFPcKl3TArN324+3D4YnQ==
X-Received: by 2002:a63:3589:: with SMTP id c131mr9344919pga.158.1596758641682; 
 Thu, 06 Aug 2020 17:04:01 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 144sm9754565pfu.114.2020.08.06.17.04.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2020 17:04:01 -0700 (PDT)
Subject: Re: [RFC v3 26/71] target/riscv: rvv-1.0: update vext_max_elems() for
 load/store insns
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200806104709.13235-1-frank.chang@sifive.com>
 <20200806104709.13235-27-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <90f01984-54a4-2a56-c52f-d1f4332b39d4@linaro.org>
Date: Thu, 6 Aug 2020 17:03:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806104709.13235-27-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/20 3:46 AM, frank.chang@sifive.com wrote:
> +static inline uint32_t vext_max_elems(uint32_t desc, uint32_t esz, bool is_ldst)
>  {
> -    return simd_maxsz(desc) << vext_lmul(desc);
> +    /*
> +     * As simd_desc support at most 256 bytes, the max vlen is 256 bits.
> +     * so vlen in bytes (vlenb) is encoded as maxsz.
> +     */
> +    uint32_t vlenb = simd_maxsz(desc);
> +
> +    if (is_ldst) {
> +        /*
> +         * Vector load/store instructions have the EEW encoded
> +         * directly in the instructions. The maximum vector size is
> +         * calculated with EMUL rather than LMUL.
> +         */
> +        uint32_t eew = ctzl(esz);
> +        uint32_t sew = vext_sew(desc);
> +        uint32_t lmul = vext_lmul(desc);
> +        int32_t emul = eew - sew + lmul;
> +        uint32_t emul_r = emul < 0 ? 0 : emul;
> +        return 1 << (ctzl(vlenb) + emul_r - ctzl(esz));

As I said before, the is_ldst instructions should put the EEW and EMUL values
into the SEW and LMUL desc fields, so that this does not need to be
special-cased at all.

> +        /* Return VLMAX */
> +        return 1 << (ctzl(vlenb) + vext_lmul(desc) - ctzl(esz));

This is overly complicated.

(1) 1 << ctzl(vlenb) == vlenb.
(2) I'm not sure why esz is not already a log2 number.

This ought to look more like

  int scale = lmul - esz;
  return (scale < 0
          ? vlenb >> -scale
          : vlenb << scale);


r~

