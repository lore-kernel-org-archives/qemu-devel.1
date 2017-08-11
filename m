Received: from eggs.gnu.org ([2001:4830:134:3::10]:36823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dg7j8-00043F-5b
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 07:03:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dg7j5-0005Ee-2z
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 07:03:38 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:53622
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1dg7j4-0005ER-Q7
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 07:03:35 -0400
References: <3710e9b8-4b16-1bcc-da17-80fb2cc2c644@adacore.com>
	<CAFEAcA-WJizoHGftAaHgNTmL5kTXM-yyFZBxVRBHU_K4BQ6edQ@mail.gmail.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <ec720f9e-664f-cd08-3db7-b744a4e065d1@adacore.com>
Date: Fri, 11 Aug 2017 13:03:04 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-WJizoHGftAaHgNTmL5kTXM-yyFZBxVRBHU_K4BQ6edQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] big endian arm.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>



On 08/11/2017 12:18 PM, Peter Maydell wrote:
> On 11 August 2017 at 10:59, KONRAD Frederic <frederic.konrad@adacore.com> wrote:
>> Hi Peters,
>>
>> I got some strange results since this commit:
>>
>> commit 9776f636455b6f0d9c14dce112242ed653f954b4
>> Author: Peter Crosthwaite <crosthwaitepeter@gmail.com>
>> Date:   Fri Mar 4 11:30:21 2016 +0000
>>
>>      arm: boot: Support big-endian elfs
>>
>>      Support ARM big-endian ELF files in system-mode emulation. When loading
>>      an elf, determine the endianness mode expected by the elf, and set the
>>      relevant CPU state accordingly.
>>
>>      With this, big-endian modes are now fully supported via system-mode LE,
>>      so there is no need to restrict the elf loading to the TARGET
>>      endianness so the ifdeffery on TARGET_WORDS_BIGENDIAN goes away.
>>
>>      Signed-off-by: Peter Crosthwaite <crosthwaite.peter@gmail.com>
>>      Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>      [PMM: fix typo in comments]
>>      Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>
>> It seems that when I try to load a big endian image on a
>> Cortex-R5 it gets confused:
>>   * the instructions are fine it executes some code.
>>   * GDB address / insns are wrong endianness.
>>   * in monitor x command is good endianness.
>>   * the data order seems to be wrong endianness:
>>     Here is my Hello World: lleHlroW
> 
> R profile bigendian is weird (ie not like A profile) because
> it has a special fudge: SCTLR.IE is an Instruction Endianness
> bit which lets you specify big-endian instruction order (IMPDEF
> how it's set, but for the Cortex-R5 it's an external config
> signal so the SoC can hardwire it as it likes). For A profile
> this bit is always 0 and instructions are LE always. We
> don't implement letting the board model set SCTLR.IE (or
> the code needed to honour it being non-zero).
> 
> If your code requires SCTLR.IE to be 1 then you'll need
> to implement that handling (if the instructions are being
> correctly executed then that suggests it doesn't, but
> you should check).

Yes it seems the instruction are OK as they are swapped during
the load.
> 
>> We used to add a armeb-softmmu/qemu-system-armeb target for the
>> big endian cpu but it doesn't work anymore as it's double
>> reversed by the elf endianness (data_swab <= 2).
> 
> This was never the right way to do system BE :-)  We should
> fix up whatever the R profile issues you see are...
> 
>> And I'm surprised we don't set the CPSR_E and SCTLR_EE bits
>> accordingly?
> 
> Setting SCTLR_EE is the job of the board model: a BE board
> model sets the 'cfgend' property on the CPU, which configures
> the reset SCTLR.EE (or SCTLR.B for v5/v6 cores). (You may
> also be able to set -cpu=something,cfgend=true on the command
> line but that's kind of a hack.) SCTLR.EE is then supposed
> to set the CPSR.E on exception entry including reset.
> 
> There is I think a bug here though: we set CPSR.E on
> exception entry in arm_cpu_do_interrupt_aarch32():
> 
>      /* Set new mode endianness */
>      env->uncached_cpsr &= ~CPSR_E;
>      if (env->cp15.sctlr_el[arm_current_el(env)] & SCTLR_EE) {
>          env->uncached_cpsr |= CPSR_E;
>      }
> 
> but we forgot to do anything in arm_cpu_reset() to get
> the CPSR.E bit right on initial reset.
> 
> That said, if you specify a BE elf file then we do
> set the SCTLR.EE and CPSR.E bits on reset in do_cpu_reset()
> (a change added in the commit you quote), which is probably
> why we haven't noticed the arm_cpu_reset() bug.

Yes that was what I saw. But seems the bits are not reset anymore
in do_cpu_reset() we probably lost that change.

Fred

> 
> Dunno about the gdbstub stuff.
> 
> thanks
> -- PMM
> 
