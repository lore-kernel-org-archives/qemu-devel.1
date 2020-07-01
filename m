Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2909CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 22:17:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F280B20853
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 22:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F280B20853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgraf.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jql2x-0005Jg-86
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 18:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <agraf@csgraf.de>)
 id 1jql20-0004kn-7n; Wed, 01 Jul 2020 18:16:41 -0400
Received: from mail.csgraf.de ([188.138.100.120]:47266
 helo=zulu616.server4you.de) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <agraf@csgraf.de>)
 id 1jql1x-0007Ms-AV; Wed, 01 Jul 2020 18:16:39 -0400
Received: from macbook.alex.local (x4d024519.dyn.telefonica.de [77.2.69.25])
 by csgraf.de (Postfix) with ESMTPSA id 3CE65390039A;
 Thu,  2 Jul 2020 00:16:34 +0200 (CEST)
Subject: Re: [PATCH] target/arm: Treat unknown SMC calls as NOP
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200701200848.26746-1-agraf@csgraf.de>
 <CAFEAcA9S5v0LHMNc4fu9JGUzecbg8DsogZuCEv_aGNqVxRAcDQ@mail.gmail.com>
From: Alexander Graf <agraf@csgraf.de>
Message-ID: <60440cb5-bd18-2928-afcf-974766222dd7@csgraf.de>
Date: Thu, 2 Jul 2020 00:16:33 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9S5v0LHMNc4fu9JGUzecbg8DsogZuCEv_aGNqVxRAcDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=188.138.100.120; envelope-from=agraf@csgraf.de;
 helo=zulu616.server4you.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 18:16:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 01.07.20 22:47, Peter Maydell wrote:
> On Wed, 1 Jul 2020 at 21:08, Alexander Graf <agraf@csgraf.de> wrote:
>> We currently treat unknown SMC calls as UNDEF. This behavior is different
>> from KVM, which treats them as NOP.
>>
>> Unfortunately, the UNDEF exception breaks running Windows for ARM in QEMU,
>> as that probes an OEM SMCCC call on boot, but does not expect to receive
>> an UNDEF exception as response.
>>
>> So instead, let's follow the KVM path and ignore SMC calls that we don't
>> handle. This fixes booting the Windows 10 for ARM preview in TCG for me.
>>
>> Signed-off-by: Alexander Graf <agraf@csgraf.de>
>> +    if (cs->exception_index == EXCP_SMC &&
>> +        !arm_feature(env, ARM_FEATURE_EL3) &&
>> +        cpu->psci_conduit != QEMU_PSCI_CONDUIT_SMC) {
> This condition says: "we got an SMC, and this CPU doesn't
> have EL3, and we're not imitating real EL3 firmware".


I like to think of it as "This CPU exposes an environment that looks
like KVM, so it implements HVC calls (EL2) and is responsible for
handling SMC calls as well.

The main difference between the two semantics is that in yours, you
don't have EL3. In mine, there is an EL3, but it's virtualized by the
same layer that implements EL2.


> The architecturally correct behaviour here (since we don't
> implement nested-virt yet, which might allow it to trap
> to guest EL2) is to UNDEF, as far as I can see from a quick
> look at the AArch64.CheckForSMCUndefOrTrap().
>
> I'm not sure why KVM makes these NOP; if I'm right about the
> architectural behaviour then making them NOP would be a KVM bug.
>
> If Windows makes an SMC call on boot that seems like a guest
> bug: it would crash on a real CPU without EL2/EL3 as well.


I don't think there can be a real SBBR compatible CPU without EL2/EL3,
because PSCI is a base requirement. That means either SMC calls succeed
(Windows running in EL2) or SMC calls are trapped into EL2 and it's up
to the hypervisor to decide what to do with them.


>
>       *  Conduit SMC, valid call  Trap to EL2         PSCI Call
>       *  Conduit SMC, inval call  Trap to EL2         Undef insn
> -     *  Conduit not SMC          Undef insn          Undef insn
> +     *  Conduit not SMC          nop                 nop
>
> The line in this table that your commit message says you're
> fixing is "Conduit SMC, inval call"; the line your code
> change affects is "Conduit not SMC", which is not the same
> thing. (I'd have to look at the PSCI spec to see what it
> requires for SMCs that aren't valid PSCI calls.)


The patch fixes the default environment, which is "Conduit HVC, PSCI
over HVC implemented by QEMU". If the patch description wasn't clear,
I'm happy to reword it :).


Alex



