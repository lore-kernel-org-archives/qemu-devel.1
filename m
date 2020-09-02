Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328A9C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 20:43:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEBDA20767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 20:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="njLV5JTx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEBDA20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDZbX-0004oL-V1
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 16:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDZal-0004Lu-09
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 16:42:51 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33998)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDZaj-0002f2-9X
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 16:42:50 -0400
Received: by mail-pg1-x541.google.com with SMTP id u13so302075pgh.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 13:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JcfsDaJEaVXex6zp70DbyH4ZEfEy9sJH3MCaSyEZARM=;
 b=njLV5JTxtITrrf1TTe1V+hEeVqjD+6MjBPdx5PLzErRSs0VCozqFoBdwpWcviZT1Mu
 K9KuER60AomijPub9g7s8zAEW881SGANC8Fuu6BgZQUKCeFcMOGBkK/5mfkUnIAbSQ6z
 esDAKNz+gSyHoCrLCZVOjg+hlutChBSTPjBdQ6K1jo2qhEKl78GFABFC7HEl3xuHDWB2
 oiHGeToYqyGfrCGXnyKGaM08YRanLysWACk8SYuuVuWFUsy2lN9U2kqEIOBJp7bq4pXP
 gQdBqUa58zPgUFV9/1sxWHvXO61obchydOk3OLQpIgD6h/FAH8gMzLfMCxP/au9enouD
 KVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JcfsDaJEaVXex6zp70DbyH4ZEfEy9sJH3MCaSyEZARM=;
 b=PIieZ6YKaFUXEVZx4YDK/5JvL2JNLkE+YdeMVgUNULQm2q9YwHbi/e0jQh3RUEj2wr
 J5kybb5an8rGMXoQXO9Et9OVf56aRgjmSVuon1jiWT/la0zLy+dddl8MJCGhGgpM/e6K
 oFPtHgnMDbIKLsU2i1fLMfQlwo06IoWBVY92saagj3vqipProQgNtSLa81v7taqQ1YEN
 CDLy3fYnVKIy5i92EOth/WhSMpFIyWpbOkGNqNHKhKffZoJqMuFh64pv8GRkq/QUrY0R
 gougDEMSUQgJhB5XO99FwPyiRrUTTbq2iC9mgcVcGkF4Z/uZ2S8hm+8UBKziJLj92/zp
 ivAw==
X-Gm-Message-State: AOAM531zEN+Ga9KCQW+x9TVCQnirthgq4RxupyNuLSeZycH8eACZg6V6
 6qRtYvS/NHuS6R1DcS4oWuzDvg==
X-Google-Smtp-Source: ABdhPJz8P2hSPgIZK3TFWLhg4MqBz5ZDT1ZYq018hOAG+VXhDNv89kV868ara9RfRgZrRudvwoupfA==
X-Received: by 2002:a17:902:b786:: with SMTP id e6mr207837pls.5.1599079367412; 
 Wed, 02 Sep 2020 13:42:47 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id l13sm235879pgq.33.2020.09.02.13.42.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 13:42:46 -0700 (PDT)
Subject: Re: [PATCH v3 4/8] hw/hppa: Change fw_cfg port address
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <20200902193456.29844-1-deller@gmx.de>
 <20200902193456.29844-5-deller@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b81e49f2-3207-4350-96a3-9fc5d4fc12b1@linaro.org>
Date: Wed, 2 Sep 2020 13:42:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200902193456.29844-5-deller@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.324,
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
Cc: Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/2/20 12:34 PM, Helge Deller wrote:
> Devices on hppa occupy at least 4k starting at the HPA, so MEMORY_HPA+4k is
> blocked (by Linux) for the memory module.  I noticed this when testing the new
> Linux kernel patch to let the fw_cfg entries show up in Linux under /proc.
> The Linux kernel driver could not allocate the region for fw_cfg.
> This new base address seems to not conflict.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>  hw/hppa/hppa_hardware.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/hppa/hppa_hardware.h b/hw/hppa/hppa_hardware.h
> index cdb7fa6240..b2fbbc2eec 100644
> --- a/hw/hppa/hppa_hardware.h
> +++ b/hw/hppa/hppa_hardware.h
> @@ -38,8 +38,7 @@
>  #define PORT_PCI_CMD    (PCI_HPA + DINO_PCI_ADDR)
>  #define PORT_PCI_DATA   (PCI_HPA + DINO_CONFIG_DATA)
> 
> -/* QEMU fw_cfg interface port */
> -#define QEMU_FW_CFG_IO_BASE     (MEMORY_HPA + 0x80)
> +#define QEMU_FW_CFG_IO_BASE     0xfffa0000
> 
>  #define PORT_SERIAL1    (DINO_UART_HPA + 0x800)
>  #define PORT_SERIAL2    (LASI_UART_HPA + 0x800)

I guess this is ok.  Moving this up a few lines, with the other HPA, and
sorting, would make this more obvious.

I see that, because HPPA_MAX_CPUS = 8, that CPU_HPA covers 0xfffb000 -
0xfffb7fff.  Thus there is also 7 slots available between the end of CPU_HPA
and MEMORY_HPA.  Picking 0xfffbe000 might be better than blocking a possible
64k slot.

But either way,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


