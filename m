Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F433C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 07:51:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5DE620E65
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 07:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5DE620E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnHEP-000753-6X
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 03:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dovgaluk@ispras.ru>)
 id 1jnHDp-0006ZJ-Vk
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 03:50:29 -0400
Received: from mail.ispras.ru ([83.149.199.84]:50298)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dovgaluk@ispras.ru>)
 id 1jnHDo-0003Fy-4x
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 03:50:29 -0400
Received: from [192.168.0.183] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id DF57D40A6332;
 Mon, 22 Jun 2020 07:50:24 +0000 (UTC)
Subject: Re: what are the requirements on target/ code for -icount to work
 correctly?
To: Max Filippov <jcmvbkbc@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
References: <CAFEAcA_HOxdK5rgKVnww6Bum3vGb=TrhDEp7oqDwsd=UbHmC_g@mail.gmail.com>
 <c47e9e4e-49eb-88c5-fdc7-8ebec121c165@ispras.ru>
 <f4fc4a1b-4054-cffd-0272-22c28d656aba@redhat.com>
 <CAFEAcA_OfF2pBPCv7Wj+u4Rm3fjtApzfiE9WYhiGeEzffd60Kw@mail.gmail.com>
 <CAMo8BfKTMfZY_2RBncoWpZHcLQ7ug+LPxnUaS9pHe8AiAQL-0w@mail.gmail.com>
From: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Message-ID: <9698cdc6-e3f8-877f-2ca9-3b60e7694f48@ispras.ru>
Date: Mon, 22 Jun 2020 10:50:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAMo8BfKTMfZY_2RBncoWpZHcLQ7ug+LPxnUaS9pHe8AiAQL-0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84; envelope-from=dovgaluk@ispras.ru;
 helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 03:17:28
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22.06.2020 08:24, Max Filippov wrote:
> On Fri, Jun 19, 2020 at 10:05 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>> I've just sent a patch that removes the target/arm gen_io_end() calls.
>> I had a quick look at sparc, xtensa and ppc, but they were too complicated
>> for a quick look to be sufficient :-)
> 
> I've checked the xtensa translator. The only gen_io_end() is for
> opcodes that end TB when a full instruction is translated, because
> they can change active interrupt requests. So it can be removed.
> I'll send a patch.
> 
> One instance of gen_io_start is for the rsr.ccount opcode that reads
> current cycle counter that translates to reading
> QEMU_CLOCK_VIRTUAL clock.

Right, this is documented by Alex in the new document recently sent into 
the mailing list:
https://lore.kernel.org/qemu-devel/7611429f-ec38-554d-3aec-e4a2f456a1ea@linaro.org/T/#mff14f2e3dc2cedd7cc6b1356985a0454e4772202

> Looks like this adds one more case to the
> following list:
> 
>> As I understand it, the definition of "I/O insn" is anything that can
>> either:
>>
>> - affect the icount deadline (e.g. by setting or removing a
>> QEMU_CLOCK_VIRTUAL timer)
>>
>> - interrupt the current translation block with cpu_loop_exit,
>> cpu_restore_state or similar.
> 


