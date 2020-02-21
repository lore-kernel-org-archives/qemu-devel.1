Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6102C35641
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 09:10:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74ACD20679
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 09:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+t3OfBT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74ACD20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j54KW-0007r6-N2
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 04:10:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36962)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maz@kernel.org>) id 1j54Jo-0007HE-QV
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 04:09:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maz@kernel.org>) id 1j54Jn-00007I-Gw
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 04:09:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:41140)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <maz@kernel.org>)
 id 1j54Jk-0008Mw-Ee; Fri, 21 Feb 2020 04:09:52 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 41CE320679;
 Fri, 21 Feb 2020 09:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1582276191;
 bh=R7+5yU6mbOOiUk6fZSEKZTK9mWI3EWQBdjFrf3WRYfU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=c+t3OfBTAUm8KLMJLaonEfVQtbMNbtkfkMR1wut7NY4Tz1J+9+gMcRChOXGlN2JQD
 oodgVYqxXGtwqJLPuE4dxoAbyxYTS7A9667zl8k8ypIr+cPoNn0a2UVNmAJWc1/AIw
 +HGlt/CYgdzG+xPWxfmNseUyLFm5H6CUU/mTRxmU=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1j54Jh-006zi1-IF; Fri, 21 Feb 2020 09:09:49 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 21 Feb 2020 09:09:49 +0000
From: Marc Zyngier <maz@kernel.org>
To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH] hw/char/pl011: Output characters using best-effort mode
In-Reply-To: <fda602ae-43d5-728c-a5bb-f607f0acd3df@redhat.com>
References: <20200220060108.143668-1-gshan@redhat.com>
 <f3c8adba729d050ba2144cc9c834fe82@kernel.org>
 <CAFEAcA8inLO75XOcCO3bUiiJQyZT+nqmp1be+z6ZtQx2a=68+g@mail.gmail.com>
 <fda602ae-43d5-728c-a5bb-f607f0acd3df@redhat.com>
Message-ID: <69bdfa5b09791a9d148b791076f2441f@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: gshan@redhat.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, shan.gavin@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 198.145.29.99
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Shan Gavin <shan.gavin@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Gavin,

On 2020-02-21 04:24, Gavin Shan wrote:
> Hi Peter and Marc,
> 
> On 2/20/20 9:10 PM, Peter Maydell wrote:
>> On Thu, 20 Feb 2020 at 09:10, Marc Zyngier <maz@kernel.org> wrote:
>>> On 2020-02-20 06:01, Gavin Shan wrote:
>>>> This fixes the issue by using newly added API
>>>> qemu_chr_fe_try_write_all(),
>>>> which provides another type of service (best-effort). It's different
>>>> from
>>>> qemu_chr_fe_write_all() as the data will be dropped if the backend 
>>>> has
>>>> been running into so-called broken state or 50 attempts of
>>>> transmissions.
>>>> The broken state is cleared if the data is transmitted at once.
>>> 
>>> I don't think dropping the serial port output is an acceptable 
>>> outcome.
>> 
>> Agreed. The correct fix for this is the one cryptically described
>> in the XXX comment this patch deletes:
>> 
>> -        /* XXX this blocks entire thread. Rewrite to use
>> -         * qemu_chr_fe_write and background I/O callbacks */
>> 
>> The idea is that essentially we end up emulating the real
>> hardware's transmit FIFO:
>>   * as data arrives from the guest we put it in the FIFO
>>   * we try to send the data with qemu_chr_fe_write(), which does
>>     not block
>>   * if qemu_chr_fe_write() tells us it did not send all the data,
>>     we use qemu_chr_fe_add_watch() to set up an I/O callback
>>     which will get called when the output chardev has drained
>>     enough that we can try again
>>   * we make sure all the guest visible registers and mechanisms
>>     for tracking tx fifo level (status bits, interrupts, etc) are
>>     correctly wired up
>> 
>> Then we don't lose data or block QEMU if the guest sends
>> faster than the chardev backend can handle, assuming the
>> guest is well-behaved -- just as with a real hardware slow
>> serial port, the guest will fill the tx fifo and then either poll
>> or wait for an interrupt telling it that the fifo has drained
>> before it tries to send more data.
>> 
>> There is an example of this in hw/char/cadence_uart.c
>> (and an example of how it works for a UART with no tx
>> fifo in hw/char-cmsdk-apb-uart.c, which is basically the
>> same except the 'fifo' is just one byte.)
>> 
>> You will also find an awful lot of XXX comments like the
>> above one in various UART models in hw/char, because
>> converting an old-style simple blocking UART implementation
>> to a non-blocking one is a bit fiddly and needs knowledge
>> of the specifics of the UART behaviour.
>> 
>> The other approach here would be that we could add
>> options to relevant chardev backends so the user
>> could say "if you couldn't connect to the tcp server I
>> specified, throw away data rather than waiting", where
>> we don't have suitable options already. If the user specifically
>> tells us they're ok to throw away the serial data, then it's
>> fine to throw away the serial data :-)
>> 
> 
> I was intended to convince Marc that it's fine to lose data if the
> serial connection is broken with an example. Now, I'm taking the
> example trying to convince both of you: Lets assume we have a ARM
> board and the UART (RS232) cable is unplugged and plugged in the middle 
> of
> system booting. I think we would get some output lost. We're emulating
> pl011 and I think it would have same behavior. However, I'm not sure
> if it makes sense :)

But the case you describe in the commit message is not that one.
The analogy is that of a serial port *plugged* and asserting flow 
control.

Another thing is that the "system" as been constructed this way by the
user. QEMU is not in a position to choose and output what is convenient,
when it is convenient. In my world, the serial output is absolutely
crucial. This is where I look for clues about failures and odd 
behaviours,
and I rely on the serial port emulation to be 100% reliable (and for 
what
it's worth, the Linux kernel can output to the serial port 
asynchronously,
to some extent).

[...]

> If above analysis is correct and the first approach doesn't work out. 
> We have to
> consider the 2nd approach - adding option to backend to allow losing 
> data. I'm
> going to add "allow-data-lost" option for TYPE_CHARDEV_SOCKET. With the 
> option,
> a back-off algorithm in tcp_chr_write(): The channel is consider as 
> broken if
> it fails to transmit data in last continuous 5 times. The transmission 
> is still
> issued when the channel is in broken state and recovered to normal 
> state if
> transmission succeeds for once.

That'd be an option if you could configure the UART with something that 
says
"no flow control". In that case, dropping data on the floor becomes 
perfectly
acceptable, as it requires buy-in from the user.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

