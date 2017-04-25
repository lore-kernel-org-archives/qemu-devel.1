Received: from eggs.gnu.org ([2001:4830:134:3::10]:43704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d2xR6-0003qU-Gy
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:11:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d2xR2-0004Yv-DS
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:11:08 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:35471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d2xR2-0004Ym-2i
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:11:04 -0400
Received: by mail-wr0-x242.google.com with SMTP id g12so6299423wrg.2
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 03:11:04 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <ab4f029c-8264-7d35-b0e0-9b35a8e80d9d@twiddle.net>
	<20170423215420.27098-1-shorne@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <f6a7d386-80a9-0cc3-e1ec-1b2058aa5bf9@twiddle.net>
Date: Tue, 25 Apr 2017 12:11:00 +0200
MIME-Version: 1.0
In-Reply-To: <20170423215420.27098-1-shorne@gmail.com>
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

On 04/23/2017 11:54 PM, Stafford Horne wrote:
> The OpenRISC architecture has the Power Management Register (PMR)
> special purpose register to manage cpu power states.  The interesting
> modes are:
> 
>   * Doze Mode (DME) - Stop cpu except timer & pic - wake on interrupt
>   * Sleep Mode (SME) - Stop cpu and all units - wake on interrupt
>   * Suspend Model (SUME) - Stop cpu and all units - wake on reset
> 
> The linux kernel will set DME when idle.

And SUME would be, essentially, poweroff?  Perhaps at least for the purposes of 
QEMU; on real hardware one could press a button to assert reset and reboot.

> Also, I don't know if its due to this patch of an issue with the timer
> interrupts.  After applying this patch the timer interrupts do not trigger
> until a keypress is make.  i.e. something like this...
> 
>    $ sleep 5
>    <hangs forever until a key is pressed>
...
> +            cpu_restore_state(cs, GETPC() + 4);

This isn't correct.  You want

	cpu_restore_state(cs, GETPC());
	cs->env.pc += 4;

So what's happening is that you're re-executing the MTSPR and going back to 
sleep again.  Which probably explains the hang.


r~
