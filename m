Received: from eggs.gnu.org ([2001:4830:134:3::10]:37211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d31oy-00077g-AJ
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:52:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d31ou-00045A-EV
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:52:04 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:35804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d31ou-00044s-7z
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:52:00 -0400
Received: by mail-wr0-x243.google.com with SMTP id g12so7324662wrg.2
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 07:52:00 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <ab4f029c-8264-7d35-b0e0-9b35a8e80d9d@twiddle.net>
	<20170423215420.27098-1-shorne@gmail.com>
	<f6a7d386-80a9-0cc3-e1ec-1b2058aa5bf9@twiddle.net>
	<20170425141827.GA2724@lianli.shorne-pla.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <23c73add-77f3-f5c2-056f-0dc728a9027f@twiddle.net>
Date: Tue, 25 Apr 2017 16:51:55 +0200
MIME-Version: 1.0
In-Reply-To: <20170425141827.GA2724@lianli.shorne-pla.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC] target/openrisc: Support non-busy idle
 state using PMR SPR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>
Cc: QEMU Development <qemu-devel@nongnu.org>, Openrisc <openrisc@lists.librecores.org>

On 04/25/2017 04:18 PM, Stafford Horne wrote:
> On Tue, Apr 25, 2017 at 12:11:00PM +0200, Richard Henderson wrote:
>> On 04/23/2017 11:54 PM, Stafford Horne wrote:
>>> The OpenRISC architecture has the Power Management Register (PMR)
>>> special purpose register to manage cpu power states.  The interesting
>>> modes are:
>>>
>>>    * Doze Mode (DME) - Stop cpu except timer & pic - wake on interrupt
>>>    * Sleep Mode (SME) - Stop cpu and all units - wake on interrupt
>>>    * Suspend Model (SUME) - Stop cpu and all units - wake on reset
>>>
>>> The linux kernel will set DME when idle.
>>
>> And SUME would be, essentially, poweroff?  Perhaps at least for the purposes
>> of QEMU; on real hardware one could press a button to assert reset and
>> reboot.
> 
> Yes, that is what I am thinking, but I could add this later, after some
> reviews with other OpenRISC folks.
> 
>>> Also, I don't know if its due to this patch of an issue with the timer
>>> interrupts.  After applying this patch the timer interrupts do not trigger
>>> until a keypress is make.  i.e. something like this...
>>>
>>>     $ sleep 5
>>>     <hangs forever until a key is pressed>
>> ...
>>> +            cpu_restore_state(cs, GETPC() + 4);
>>
>> This isn't correct.  You want
>>
>> 	cpu_restore_state(cs, GETPC());
>> 	cs->env.pc += 4;
>>
>> So what's happening is that you're re-executing the MTSPR and going back to
>> sleep again.  Which probably explains the hang.
> 
> I have changed to the above, but I think its essentially the same.  It
> resumes after the MTSPR in both cases.

It's not essentially the same.  GETPC is a host address.  Doing guest 
arithmetic on that is just wrong.

> I fixed this now though, you should see another patch.  The issue is the
> timer events get ignored once the cpu is in halt state, I added a
> qemu_cpu_kick() call in the timer hardware to wake up the cpu on timer
> interrupts.  Not sure if thats the best way to do it, but it works 100%
> now.

Ah, that could be.


r~
