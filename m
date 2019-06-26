Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29B2C48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 18:39:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DEFE20663
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 18:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y4GZ/vAS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DEFE20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgCpG-00015p-ND
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 14:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44212)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hgCfZ-0001Xa-Qc
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:29:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hgCfW-0007zi-C5
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:29:21 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40799)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hgCfW-0007yw-3f
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:29:18 -0400
Received: by mail-wr1-x444.google.com with SMTP id p11so3875362wre.7
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 11:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=L5TFjTIA0S4uo9coV4FdErRUtFqXXlJt9/7Jahxl5zg=;
 b=Y4GZ/vASz36bxNxYFcJWVfCfs8yi7wkS2kYlIGYv3q8uvdKY6foGkA6Ag5jX80+ZYP
 Xkpb1EYgbwOcrzZs+q9ZDz5dJ8XZhxQ+87Orn6cuJn9Kmaq3U6bkdi1O2wlVUyp9XCyU
 aQEq/tLrENSGYUUC/zkWepA8ePZXr+XAraw2k+esqNBjPl8zCNmb0qDGUV98sEYw1lsu
 Kqvahzw6mI+ou/RnfTMg5oyBjgci0tTdC3psxwjLFx3St931CBzvg9al73GCvcpRSAke
 dtqAx7IsZaz8NxtiW6BLsRQkteeyVHuBbfNkXNP2OqLukX2hrvoXxroaORbJHqJPH7JY
 +e8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=L5TFjTIA0S4uo9coV4FdErRUtFqXXlJt9/7Jahxl5zg=;
 b=VlZhM5eCVLlrzWX2veVvgSUrXuxHpnV4tuauhA0e5xAAWYcqCnwLmCK/1d3ztl6Ah2
 vwH393+YCtvS0jfs8YytI9TlyZlBjSApNGpHpLXTV/3r4LlgifHMt5uDwA9MogBhqPWG
 +V1lnx1jipChoOJGnCWAp8HzL/hZygKrSe5DrWDw1BnhK5n+erN2AC0TNuhYlidOIHkU
 TOlIKET5vAYYaJ8SD2ykf23T7pSAeHAFoyLCGfqzfBQZZ59M8Ugg+LVQ0IFFMhqnwS4/
 F4xj5ATSLobgc9oggLNViwZi9Q0phbPApp0QmxWLy5hYu2jTAmdguVyNBsVXfzfp9xNi
 x09Q==
X-Gm-Message-State: APjAAAUUG58HUs2eyVPQdTfk78GahQ/5WHGJBZ4192S73Jm9lsKIIbby
 6oSWkdkL9MV/Ot9fsUp8tdCIoA==
X-Google-Smtp-Source: APXvYqwo3t5ZMwLNX2xzhjoUY4QBzVLKd0wHISODXXD+VkXjxrGWw3NGG+GBNoEoUZM/W/EdSyhPTw==
X-Received: by 2002:adf:eb4e:: with SMTP id u14mr4778819wrn.168.1561573757143; 
 Wed, 26 Jun 2019 11:29:17 -0700 (PDT)
Received: from [192.168.2.137] (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id e11sm40649513wrc.9.2019.06.26.11.29.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Jun 2019 11:29:16 -0700 (PDT)
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20190621163422.6127-1-drjones@redhat.com>
 <20190621163422.6127-11-drjones@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <1e0bc93f-42e3-087f-a4b5-d356879cb806@linaro.org>
Date: Wed, 26 Jun 2019 17:22:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190621163422.6127-11-drjones@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v2 10/14] target/arm/kvm64: Add
 kvm_arch_get/put_sve
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
Cc: peter.maydell@linaro.org, armbru@redhat.com, eric.auger@redhat.com,
 imammedo@redhat.com, alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/21/19 6:34 PM, Andrew Jones wrote:
> +/*
> + * If ARM_MAX_VQ is increased to be greater than 16, then we can no
> + * longer hard code slices to 1 in kvm_arch_put/get_sve().
> + */
> +QEMU_BUILD_BUG_ON(ARM_MAX_VQ > 16);

This seems easy to fix, or simply drop the slices entirely for now, as
otherwise they are a teeny bit confusing.

It's a shame that these slices exist at all.  It seems like the kernel could
use the negotiated max sve size to grab the data all at once.

> +        for (n = 0; n < KVM_ARM64_SVE_NUM_ZREGS; n++) {
> +            uint64_t *q = aa64_vfp_qreg(env, n);
> +#ifdef HOST_WORDS_BIGENDIAN
> +            uint64_t d[ARM_MAX_VQ * 2];
> +            int j;
> +            for (j = 0; j < cpu->sve_max_vq * 2; j++) {
> +                d[j] = bswap64(q[j]);
> +            }
> +            reg.addr = (uintptr_t)d;
> +#else
> +            reg.addr = (uintptr_t)q;
> +#endif
> +            reg.id = KVM_REG_ARM64_SVE_ZREG(n, i);
> +            ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);

It might be worth splitting this...

> +        for (n = 0; n < KVM_ARM64_SVE_NUM_PREGS; n++) {
> +            uint64_t *q = &env->vfp.pregs[n].p[0];
> +#ifdef HOST_WORDS_BIGENDIAN
> +            uint64_t d[ARM_MAX_VQ * 2 / 8];
> +            int j;
> +            for (j = 0; j < cpu->sve_max_vq * 2 / 8; j++) {
> +                d[j] = bswap64(q[j]);
> +            }
> +            reg.addr = (uintptr_t)d;
> +#else
> +            reg.addr = (uintptr_t)q;
> +#endif
> +            reg.id = KVM_REG_ARM64_SVE_PREG(n, i);
> +            ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);

... and this (unified w/ reg + size parameters?) to a function because ...

> +        reg.addr = (uintptr_t)&env->vfp.pregs[FFR_PRED_NUM].p[0];
> +        reg.id = KVM_REG_ARM64_SVE_FFR(i);
> +        ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);

... you forgot to apply the bswap here.

Likewise for the other direction.


r~


PS: It's also tempting to drop the ifdefs and, since we know the host supports
sve instructions, and that the host supports sve_max_vq, do the reformatting as

    uint64_t scratch[ARM_MAX_VQ * 2];
    asm("whilelo  p0.d, xzr, %2\n\t"
        "ld1d     z0.d, p0/z [%1]\n\t"
        "str      z0, [%0]"
        : "=Q"(scratch)
        : "Q"(*aa64_vfp_qreg(env, n)),
          "r"(cpu->sve_max_vq)
        : "p0", "v0");

PPS: Ideally, this would be further cleaned up with acle builtins, but those
are still under development for GCC.

