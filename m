Received: from eggs.gnu.org ([209.51.188.92]:42070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gtzBY-0008VG-Ui
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 13:23:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gtz13-0004ZU-Tu
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 13:12:14 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:40000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gtz13-0004Xq-Hl
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 13:12:13 -0500
Received: by mail-pl1-x634.google.com with SMTP id bj4so1550448plb.7
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 10:12:13 -0800 (PST)
Date: Wed, 13 Feb 2019 10:12:10 -0800 (PST)
In-Reply-To: <CAKmqyKMWuqYD-_nYFR1dwvw7ZqPTqqsBdF_V0FBzryuWOgL4zQ@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-40d9ba8a-37f0-43af-8a37-d56716c48630@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
To: alistair23@gmail.com
Cc: chouteau@adacore.com, qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org, mjc@sifive.com, Alistair Francis <Alistair.Francis@wdc.com>

On Fri, 08 Feb 2019 10:41:17 PST (-0800), alistair23@gmail.com wrote:
> On Thu, Feb 7, 2019 at 2:08 AM Fabien Chouteau <chouteau@adacore.com> wrote:
>>
>> Hello Alistair,
>>
>> On 07/02/2019 01:42, Alistair Francis wrote:>
>> > Can you describe what this fixes?
>> >
>>
>> I encountered this problem when I tried to write 0xffffffffffffffff in timecmp.
>>
>> With the integer overflow in QEMU, writing this value means that the QEMU timer
>> will be set in the past.
>>
>> > Won't an overflow be ok as we then just wrap around anyway? I guess
>> > there is a problem if we want a value so large that we wrap around
>> > past our current time though.
>> >
>>
>> The overflow was in the computation of the value `next_ns`. It is used to set
>> the QEMU timer:
>>
>> timer_mod(cpu->env.timer, next_ns);
>>
>> A negative `next_ns` -because of the overflow- means that the timer
>> triggers immediately instead of far in the future.
>
> Ah you are right here. The expired time of the timer will be set to
> zero (it looks like QEMU ensures it can't be negative) but then it
> detects that as being in the past and will trigger the timer event as
> timer_expired_ns() will return true.
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Thanks.  I'll target this for the next PR.
