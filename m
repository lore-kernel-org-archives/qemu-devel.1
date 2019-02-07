Received: from eggs.gnu.org ([209.51.188.92]:33908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chouteau@adacore.com>) id 1grgbw-0007BP-SR
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:08:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chouteau@adacore.com>) id 1grgbt-0007FI-Hl
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:08:48 -0500
References: <20190130185242.12490-1-chouteau@adacore.com>
	<CAKmqyKMNqYBN9ZCESAxfqWSOidjFRhQNofN130MOPDOyRwQ28w@mail.gmail.com>
From: Fabien Chouteau <chouteau@adacore.com>
Message-ID: <5cb673ce-930d-81d5-eb59-d33471f7318b@adacore.com>
Date: Thu, 7 Feb 2019 11:08:24 +0100
MIME-Version: 1.0
In-Reply-To: <CAKmqyKMNqYBN9ZCESAxfqWSOidjFRhQNofN130MOPDOyRwQ28w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/riscv/sifive_clint.c: avoid integer
 overflow in timecmp write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Michael Clark <mjc@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>

Hello Alistair,

On 07/02/2019 01:42, Alistair Francis wrote:> 
> Can you describe what this fixes?
> 

I encountered this problem when I tried to write 0xffffffffffffffff in timecmp.

With the integer overflow in QEMU, writing this value means that the QEMU timer
will be set in the past.

> Won't an overflow be ok as we then just wrap around anyway? I guess
> there is a problem if we want a value so large that we wrap around
> past our current time though.
> 

The overflow was in the computation of the value `next_ns`. It is used to set
the QEMU timer:

timer_mod(cpu->env.timer, next_ns);

A negative `next_ns` -because of the overflow- means that the timer
triggers immediately instead of far in the future.

Regards,
