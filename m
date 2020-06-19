Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7049C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 05:48:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5B882078D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 05:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B882078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm9sg-0007iZ-Sx
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 01:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dovgaluk@ispras.ru>)
 id 1jm9ri-0007GK-81
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 01:47:02 -0400
Received: from mail.ispras.ru ([83.149.199.45]:51304)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dovgaluk@ispras.ru>) id 1jm9rg-000395-5F
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 01:47:01 -0400
Received: from [192.168.0.183] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id 6902ABFD21;
 Fri, 19 Jun 2020 08:46:55 +0300 (MSK)
Subject: Re: what are the requirements on target/ code for -icount to work
 correctly?
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <CAFEAcA_HOxdK5rgKVnww6Bum3vGb=TrhDEp7oqDwsd=UbHmC_g@mail.gmail.com>
From: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Message-ID: <c47e9e4e-49eb-88c5-fdc7-8ebec121c165@ispras.ru>
Date: Fri, 19 Jun 2020 08:46:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_HOxdK5rgKVnww6Bum3vGb=TrhDEp7oqDwsd=UbHmC_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=83.149.199.45; envelope-from=dovgaluk@ispras.ru;
 helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 01:46:55
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 18.06.2020 20:38, Peter Maydell wrote:
> For -icount mode to work, there are requirements on the target/
> code (notably around marking up "I/O" instructions). Unfortunately
> we've never documented what these are, which makes it pretty rough
> for people writing new targets or reviewing changes to existing ones.
> Does anybody understand what they actually are?
>
> Some more specific questions on the general theme:
>
> Q1: the comment on gen_io_end() says:
> /*
>   * cpu->can_do_io is cleared automatically at the beginning of
>   * each translation block.  The cost is minimal and only paid
>   * for -icount, plus it would be very easy to forget doing it
>   * in the translator.  Therefore, backends only need to call
>   * gen_io_start.
>   */
> but in fact multiple backends *do* call gen_io_end(). When
> does a backend have to call this, and when not? Or are those
> all legacy useless calls we should delete? (If so, can we
> just get rid of this function entirely ?)

That was my refactoring patch for removing gen_io_end calls.

But in some cases I wasn't sure that translation is stopped after that. 
In such cases gen_io_end wasn't removed.

I think, that we need some efforts from target maintainers to remove all 
such calls.

> Q2: is it a requirement that after an insn which is a "known
> to be an I/O insn" one (like x86 in/out) and which is marked
> up with gen_io_start()/gen_io_end() that we also end the TB?

It is a requirement for instructions that access virtual clock/icount 
value (directly or not).

There is also an assertion that can_do_io is enabled while generating an 
interrupt. I believe, that it doesn't affect RR, but is useful for 
deterministic icount mode.

> Or is it OK to generate more insns after that one? If the former,
> is there somewhere we can assert() that this is done ?

Sounds reasonable.

> Q3: why does gen_tb_start() call gen_io_end()? This is the
> *start* of the TB so by definition we haven't started doing
> any IO yet...

This is an artifact of gen_io_end refactoring.


Pavel Dovgalyuk


