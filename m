Received: from eggs.gnu.org ([2001:4830:134:3::10]:39645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cl91X-0005hS-Lm
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 01:55:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cl91T-00080f-2H
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 01:55:07 -0500
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:33208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cl91S-0007zo-R1
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 01:55:02 -0500
Received: by mail-wr0-x22f.google.com with SMTP id u48so132083786wrc.0
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 22:55:01 -0800 (PST)
References: <20170306205609.6525-1-rth@twiddle.net>
	<387705521.29181055.1488834011451.JavaMail.zimbra@redhat.com>
	<5c02d7b4-6b8d-2fa5-b4f9-ce0e7fddaa73@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <5c02d7b4-6b8d-2fa5-b4f9-ce0e7fddaa73@twiddle.net>
Date: Tue, 07 Mar 2017 06:55:07 +0000
Message-ID: <87fuipinjo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] target/alpha: Take BQL around clock
 manipulations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org


Richard Henderson <rth@twiddle.net> writes:

> On 03/07/2017 08:00 AM, Paolo Bonzini wrote:
>>> Signed-off-by: Richard Henderson <rth@twiddle.net>
>>> ---
>>> This is similar to the patch that I saw go by for MIPS.
>>>
>>> I hadn't noticed any problems caused by this lack of locking.  This may
>>> be because interrupts cannot be delivered while in PALmode while these
>>> registers are being manipulated.  However, it's always better to obey
>>> the rules, right?
>>
>> This should not be necessary, clocks and timers are thread-safe.  Time
>> to make a list of the few things that are, I guess.
>>
>> There are issues if data is accessed by device models and CPU out of
>> the lock, but everything seems fine for typhoon_alarm_timer.
>
> This isn't typhoon_alarm_timer, but the move-to-special-register
> instruction on the cpu side.
>
> But I guess I misunderstood the problem that was happening for MIPS.
> If nothing needs changing for Alpha, that's great.

Fundamentally the MIPS instructions ended up calling into hw/mips/ which
could then end up triggering an IRQ (at which point the BQL assertion
kicks in).

Basically crossing from target/foo/helper to hw/foo/emulation is the
warning sign that you need to ensure you have appropriate device
emulation locking going on.

Helpers just messing with their own env should be able to continue just
fine.

>
>
> r~


--
Alex Bennée
