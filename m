Return-Path: <SRS0=CqNf=4L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4E5C35673
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 23:58:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5823820704
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 23:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OY4WaYIt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5823820704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j618L-0002Z4-JG
	for qemu-devel@archiver.kernel.org; Sun, 23 Feb 2020 18:58:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41038)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gshan@redhat.com>) id 1j617m-000273-S0
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 18:57:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gshan@redhat.com>) id 1j617k-0004sM-Qr
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 18:57:26 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39789
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gshan@redhat.com>) id 1j617k-0004rx-MY
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 18:57:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582502243;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vQsa5htc3UPwO2qSfJjEM7AdRsMCOivhC27dTmnOIng=;
 b=OY4WaYItFiBVsM/8W+SbrL1MUR7NRWU/Dmq8z/OCa4+z3Ij763TqNYnc7lNjrnGy4C6ubC
 X87IVpXlVjUSzlTOnUzBdrmAzzR3JH9Zml5VWP0wHOMzFh4uzbz/i4McUHurmoDVyqBLlq
 PFvL0AhGxkMIKul2KAWBtheUuXSzh4M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-zWnR_FrkO8SBiZAOlxJ0AQ-1; Sun, 23 Feb 2020 18:57:22 -0500
X-MC-Unique: zWnR_FrkO8SBiZAOlxJ0AQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF67D100550E;
 Sun, 23 Feb 2020 23:57:20 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-48.bne.redhat.com [10.64.54.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C7A9F1001902;
 Sun, 23 Feb 2020 23:57:18 +0000 (UTC)
Subject: Re: [PATCH] hw/char/pl011: Output characters using best-effort mode
To: Marc Zyngier <maz@kernel.org>
References: <20200220060108.143668-1-gshan@redhat.com>
 <f3c8adba729d050ba2144cc9c834fe82@kernel.org>
 <CAFEAcA8inLO75XOcCO3bUiiJQyZT+nqmp1be+z6ZtQx2a=68+g@mail.gmail.com>
 <fda602ae-43d5-728c-a5bb-f607f0acd3df@redhat.com>
 <69bdfa5b09791a9d148b791076f2441f@kernel.org>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <4eec5935-1114-2c8e-05ce-21f80f71d041@redhat.com>
Date: Mon, 24 Feb 2020 10:57:16 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <69bdfa5b09791a9d148b791076f2441f@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Reply-To: Gavin Shan <gshan@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Shan Gavin <shan.gavin@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Marc,

On 2/21/20 8:09 PM, Marc Zyngier wrote:
> On 2020-02-21 04:24, Gavin Shan wrote:
>> On 2/20/20 9:10 PM, Peter Maydell wrote:
>>> On Thu, 20 Feb 2020 at 09:10, Marc Zyngier <maz@kernel.org> wrote:
>>>> On 2020-02-20 06:01, Gavin Shan wrote:
>>>>> This fixes the issue by using newly added API
>>>>> qemu_chr_fe_try_write_all(),
>>>>> which provides another type of service (best-effort). It's different
>>>>> from
>>>>> qemu_chr_fe_write_all() as the data will be dropped if the backend ha=
s
>>>>> been running into so-called broken state or 50 attempts of
>>>>> transmissions.
>>>>> The broken state is cleared if the data is transmitted at once.
>>>>
>>>> I don't think dropping the serial port output is an acceptable outcome=
.
>>>
>>> Agreed. The correct fix for this is the one cryptically described
>>> in the XXX comment this patch deletes:
>>>
>>> -=A0=A0=A0=A0=A0=A0=A0 /* XXX this blocks entire thread. Rewrite to use
>>> -=A0=A0=A0=A0=A0=A0=A0=A0 * qemu_chr_fe_write and background I/O callba=
cks */
>>>
>>> The idea is that essentially we end up emulating the real
>>> hardware's transmit FIFO:
>>> =A0 * as data arrives from the guest we put it in the FIFO
>>> =A0 * we try to send the data with qemu_chr_fe_write(), which does
>>> =A0=A0=A0 not block
>>> =A0 * if qemu_chr_fe_write() tells us it did not send all the data,
>>> =A0=A0=A0 we use qemu_chr_fe_add_watch() to set up an I/O callback
>>> =A0=A0=A0 which will get called when the output chardev has drained
>>> =A0=A0=A0 enough that we can try again
>>> =A0 * we make sure all the guest visible registers and mechanisms
>>> =A0=A0=A0 for tracking tx fifo level (status bits, interrupts, etc) are
>>> =A0=A0=A0 correctly wired up
>>>
>>> Then we don't lose data or block QEMU if the guest sends
>>> faster than the chardev backend can handle, assuming the
>>> guest is well-behaved -- just as with a real hardware slow
>>> serial port, the guest will fill the tx fifo and then either poll
>>> or wait for an interrupt telling it that the fifo has drained
>>> before it tries to send more data.
>>>
>>> There is an example of this in hw/char/cadence_uart.c
>>> (and an example of how it works for a UART with no tx
>>> fifo in hw/char-cmsdk-apb-uart.c, which is basically the
>>> same except the 'fifo' is just one byte.)
>>>
>>> You will also find an awful lot of XXX comments like the
>>> above one in various UART models in hw/char, because
>>> converting an old-style simple blocking UART implementation
>>> to a non-blocking one is a bit fiddly and needs knowledge
>>> of the specifics of the UART behaviour.
>>>
>>> The other approach here would be that we could add
>>> options to relevant chardev backends so the user
>>> could say "if you couldn't connect to the tcp server I
>>> specified, throw away data rather than waiting", where
>>> we don't have suitable options already. If the user specifically
>>> tells us they're ok to throw away the serial data, then it's
>>> fine to throw away the serial data :-)
>>>
>>
>> I was intended to convince Marc that it's fine to lose data if the
>> serial connection is broken with an example. Now, I'm taking the
>> example trying to convince both of you: Lets assume we have a ARM
>> board and the UART (RS232) cable is unplugged and plugged in the middle =
of
>> system booting. I think we would get some output lost. We're emulating
>> pl011 and I think it would have same behavior. However, I'm not sure
>> if it makes sense :)
>=20
> But the case you describe in the commit message is not that one.
> The analogy is that of a serial port *plugged* and asserting flow control=
.
>=20

Thanks for your time on the discussion.

Well, I would say we saw two side of a coin. TCP connection isn't bidirecti=
onal
until accept() is called on server side. The connection isn't fully functio=
nal
until two directions are finalized. It would be unplug if the connection is=
 treated
as the cable :)

> Another thing is that the "system" as been constructed this way by the
> user. QEMU is not in a position to choose and output what is convenient,
> when it is convenient. In my world, the serial output is absolutely
> crucial. This is where I look for clues about failures and odd behaviours=
,
> and I rely on the serial port emulation to be 100% reliable (and for what
> it's worth, the Linux kernel can output to the serial port asynchronously=
,
> to some extent).
>=20
> [...]
>=20

Yep, totally agreed :)

>> If above analysis is correct and the first approach doesn't work out. We=
 have to
>> consider the 2nd approach - adding option to backend to allow losing dat=
a. I'm
>> going to add "allow-data-lost" option for TYPE_CHARDEV_SOCKET. With the =
option,
>> a back-off algorithm in tcp_chr_write(): The channel is consider as brok=
en if
>> it fails to transmit data in last continuous 5 times. The transmission i=
s still
>> issued when the channel is in broken state and recovered to normal state=
 if
>> transmission succeeds for once.
>=20
> That'd be an option if you could configure the UART with something that s=
ays
> "no flow control". In that case, dropping data on the floor becomes perfe=
ctly
> acceptable, as it requires buy-in from the user.
>=20

Yep, the point is to has user's buy-in and it seems an explicit option like
"allow-data-lost" fills the gap, but it seems Peter isn't reaching conclusi=
on
or decision yet. Lets see what's that finally :)

Thanks,
Gavin


