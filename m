Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6E3C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 13:22:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2438820678
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 13:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2438820678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dornerworks.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irM9q-00050b-0A
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 08:22:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Jeff.Kubascik@dornerworks.com>) id 1irM8k-0003iy-D6
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 08:21:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Jeff.Kubascik@dornerworks.com>) id 1irM8i-0001WE-Jw
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 08:21:50 -0500
Received: from mail.dornerworks.com ([12.207.209.150]:17960
 helo=webmail.dornerworks.com) by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <Jeff.Kubascik@dornerworks.com>)
 id 1irM8i-0001Vp-FN; Tue, 14 Jan 2020 08:21:48 -0500
Subject: Re: [PATCH] target/arm: adjust program counter for wfi exception in
 AArch32
To: Richard Henderson <richard.henderson@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>, <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
References: <20200110180211.29025-1-jeff.kubascik@dornerworks.com>
 <7f45c4a2-0192-aaaa-8d0f-7ea7890ca448@linaro.org>
From: Jeff Kubascik <jeff.kubascik@dornerworks.com>
Message-ID: <879fa44b-a405-e1d6-eb3f-90216f5d3385@dornerworks.com>
Date: Tue, 14 Jan 2020 08:22:40 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <7f45c4a2-0192-aaaa-8d0f-7ea7890ca448@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.27.13.179]
X-ClientProxiedBy: Mcbain.dw.local (172.27.1.45) To Mcbain.dw.local
 (172.27.1.45)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 12.207.209.150
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
Cc: Stewart Hildebrand <Stewart.Hildebrand@dornerworks.com>,
 Jarvis Roach <Jarvis.Roach@dornerworks.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/13/2020 9:41 PM, Richard Henderson wrote:
> On 1/10/20 8:02 AM, Jeff Kubascik wrote:
>> -        env->pc -= insn_len;
>> +        if (env->aarch64)
>> +            env->pc -= insn_len;
>> +        else
>> +            env->regs[15] -= insn_len;
> 
> QEMU requires all braces.  See CODING_STYLE.

I received an automated email from Patchew regarding the coding style issue. I
have submitted a v2 of the patch with this correction yesterday.

> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~
> 

Thanks!
Jeff Kubascik

