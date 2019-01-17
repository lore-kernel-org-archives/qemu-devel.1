Received: from eggs.gnu.org ([209.51.188.92]:45303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1gk5No-0007m9-5I
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:58:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1gk5Nn-00084Z-19
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:58:48 -0500
Received: from smtp56.i.mail.ru ([217.69.128.36]:57148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1gk5Nl-00080O-St
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:58:46 -0500
References: <20190115143650.15725-1-jusual@mail.ru>
	<CAKmqyKOyfP=ZT-diiFFfAieYKt98DPSxf0HyVdwYE4g+jv5w0w@mail.gmail.com>
	<797be79d-7ffc-222a-6acd-b01ff7269a63@mail.ru>
	<20190117101309.GA27840@stefanha-x1.localdomain>
From: Julia Suvorova <jusual@mail.ru>
Message-ID: <960bbd92-a160-a65c-22c7-9e899dc3fa78@mail.ru>
Date: Thu, 17 Jan 2019 13:58:37 +0300
MIME-Version: 1.0
In-Reply-To: <20190117101309.GA27840@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/core/generic-loader: Fix PC overwriting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Alistair Francis <alistair23@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair@alistair23.me>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On 17.01.2019 13:13, Stefan Hajnoczi wrote:
> On Wed, Jan 16, 2019 at 10:05:58PM +0300, Julia Suvorova via Qemu-devel wrote:
>> On 16.01.2019 0:51, Alistair Francis wrote:
>>> On Tue, Jan 15, 2019 at 7:04 AM Julia Suvorova via Qemu-devel
>>> <qemu-devel@nongnu.org> wrote:
>>>>
>>>> If the memory is set using a file, and PC is specified on the command
>>>> line, it will be overwritten with the value 'entry'. This is not only
>>>> illogical, but also incorrect, because the load_ * functions do not take
>>>> into account the specifics of the ARM-M PC.
>>>
>>> How does this come up?
>>> I see that the value of entry will force overwrite the PC addr, but
>>> doesn't force_raw fix that? Is there a common use case of loading an
>>> ELF/uimage but having to manually specify a start address?
>>
>> generic_loader_reset() is called after arm_cpu_reset() and damages PC
>> (it is wrong to call arm_cpu_set_pc() with entry to set ARM PC reset
>> value). Therefore, I tried to configure PC manually and ran into this
>> problem.
>>
>> By the way, I do not know the right way to fix the original issue. Try
>> to replace generic_loader_reset() with the device reset function or
>> change the reset order or transfer PC reset value setting to a separate
>> function and associate it with cpu. What do you think about it?
> 
> generic_loader_reset() calls cpu_reset(s->cpu) followed by
> CPUClass->set_pc(s->cpu, s->addr).
> 
> ARM's arm_cpu_set_pc() doesn't special-case the Thumb bit (that's only
> done in arm_cpu_reset()) so we end up with an invalid PC for Thumb mode
> addresses.
> 
> Maybe the following arm_cpu_reset() code should be moved to
> arm_cpu_set_pc():
> 
>    env->regs[15] = initial_pc & ~1;
>    env->thumb = initial_pc & 1;
> 
> Then arm_cpu_reset() can call arm_cpu_set_pc() instead of duplicating
> this code.

No, set_pc() is called in cpu_tb_exec() to restore the PC value and
therefore should not be changed.

> I haven't checked whether more special logic is needed in
> arm_cpu_set_pc() aside from setting Thumb mode, but I think this should
> do the trick?

The logic is a bit more complicated, but I think that it can be
transferred to a separate function, but not to arm_cpu_set_pc().

Best regards, Julia Suvorova.
