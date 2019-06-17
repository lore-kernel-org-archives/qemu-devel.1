Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6568AC31E59
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 11:35:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41905208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 11:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41905208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46238 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcpuw-0000ZO-R6
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 07:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53365)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefan.brankovic@rt-rk.com>) id 1hcprq-0007dM-Jx
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:32:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefan.brankovic@rt-rk.com>) id 1hcprp-0002RQ-KQ
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:32:06 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:40955 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefan.brankovic@rt-rk.com>)
 id 1hcprp-000149-C6
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:32:05 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 153E81A2273;
 Mon, 17 Jun 2019 13:31:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from [10.10.13.132] (rtrkw870-lin.domain.local [10.10.13.132])
 by mail.rt-rk.com (Postfix) with ESMTPSA id CF7F11A2245;
 Mon, 17 Jun 2019 13:30:59 +0200 (CEST)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <1559816130-17113-1-git-send-email-stefan.brankovic@rt-rk.com>
 <1559816130-17113-2-git-send-email-stefan.brankovic@rt-rk.com>
 <0d30e79a-12c8-7fa5-237c-25bd00682d2b@linaro.org>
From: Stefan Brankovic <stefan.brankovic@rt-rk.com>
Message-ID: <8e37914f-dfbf-c45f-f153-18e029858e50@rt-rk.com>
Date: Mon, 17 Jun 2019 13:31:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <0d30e79a-12c8-7fa5-237c-25bd00682d2b@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: Re: [Qemu-devel] [PATCH 1/8] target/ppc: Optimize emulation of lvsl
 and lvsr instructions
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
Cc: david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 6.6.19. 18:46, Richard Henderson wrote:
> On 6/6/19 5:15 AM, Stefan Brankovic wrote:
>> +    tcg_gen_addi_i64(result, sh, 7);
>> +    for (i = 7; i >= 1; i--) {
>> +        tcg_gen_shli_i64(tmp, sh, i * 8);
>> +        tcg_gen_or_i64(result, result, tmp);
>> +        tcg_gen_addi_i64(sh, sh, 1);
>> +    }
> Better to replicate sh into the 8 positions and then use one add.
>
>      tcg_gen_muli_i64(sh, sh, 0x0101010101010101ull);
>      tcg_gen_addi_i64(hi_result, sh, 0x0001020304050607ull);
>      tcg_gen_addi_i64(lo_result, sh, 0x08090a0b0c0d0e0full);
>
> and
>
>      tcg_gen_subfi_i64(hi_result, 0x1011121314151617ull, sh);
>      tcg_gen_subfi_i64(lo_result, 0x18191a1b1c1d1e1full, sh);
>
> for lvsr.
>
I think you are right, this is definitely better way of implementing it. 
I will adopt your approach in v2.

Kind Regards,

Stefan

> r~

