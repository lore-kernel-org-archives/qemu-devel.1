Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CD0CA9ECB
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 18:37:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D59DD20650
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 18:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="hnxcfrNr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D59DD20650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQFK8-0001lO-LD
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 14:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1iQFGA-0000Uz-9T
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 14:33:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luc.michel@greensocs.com>) id 1iQFG7-0003SF-0H
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 14:33:26 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:36816)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luc.michel@greensocs.com>)
 id 1iQFG1-0003OX-4v; Thu, 31 Oct 2019 14:33:17 -0400
Received: from [192.168.43.155] (unknown [92.184.112.187])
 by beetle.greensocs.com (Postfix) with ESMTPSA id BB60396EF0;
 Thu, 31 Oct 2019 18:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1572546793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/49r9UMM8AeBMGh4JYHXInBDi+HCKoUUFsC+qls+aLA=;
 b=hnxcfrNro7PFxseifwmesR20+R3aEN3dGl/kn6Jg0idIZ204PdUF5YIjlpUEQW9xA0ma96
 1u04OccdUuWrPyWW8v2FY+OYiyCep68xwWnc6kzyMDWG5S0n2udekaCdp3HES6GCO0q15w
 30j/1dNS2BhKc8Mot54pLAILBtpW5ks=
Subject: Re: [PATCH v1 1/1] hw/arm/boot: Rebuild hflags when modifying
 CPUState at boot
To: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20191031040830.18800-1-edgar.iglesias@xilinx.com>
 <20191031040830.18800-2-edgar.iglesias@xilinx.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <5f4953c2-fbda-1a0f-b835-185d95465ef6@greensocs.com>
Date: Thu, 31 Oct 2019 19:33:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191031040830.18800-2-edgar.iglesias@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-PH
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1572546794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/49r9UMM8AeBMGh4JYHXInBDi+HCKoUUFsC+qls+aLA=;
 b=TsNHSPeQxsXBKng+viBpKlJb1qh/zOyVMFA+I3VUB9Jo9MEfpxvDC6HIoxww0VQC931lzl
 YZm8+aJtBUOliUTqPX0MlJZ3N0Ao85ZkoBZjR4uyX2A/R0/0iydGIWvGq8Yfj5eToYrIsB
 Yl/wxgOIPOSUD49m77uoE4QAzyvdnR0=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1572546794; a=rsa-sha256; cv=none;
 b=3TDEO5ALzaBHDVDPn70PX3SSzeprR0a2faaryu/lo6BXn9LclpCJyr9UDZ0FAAZafnMJdt
 DUdTrEHDFTGcPWBwNsREW41EN7876iv6BM4RdXFQhe7sx1gS07AXsE0eO3tnarUbKhjOf5
 JDBqRLgGPf7v+XLxLjx8CoebC9mLfKU=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=luc smtp.mailfrom=luc.michel@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 sai.pavan.boddu@xilinx.com, frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/31/19 5:08 AM, Edgar E. Iglesias wrote:
> Rebuild hflags when modifying CPUState at boot.
> 
> Fixes: e979972a6a
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>  hw/arm/boot.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index c264864c11..ef6724960c 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -786,6 +786,7 @@ static void do_cpu_reset(void *opaque)
>                  info->secondary_cpu_reset_hook(cpu, info);
>              }
>          }
> +        arm_rebuild_hflags(env);
>      }
>  }
>  
> 

