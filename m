Received: from eggs.gnu.org ([2001:4830:134:3::10]:53563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dTsTw-0000rD-Kt
	for qemu-devel@nongnu.org; Sat, 08 Jul 2017 12:21:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dTsTv-0003yN-OW
	for qemu-devel@nongnu.org; Sat, 08 Jul 2017 12:21:20 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170707161822.29659-1-alex.bennee@linaro.org>
	<87inj49mr1.fsf@linaro.org>
	<CAFEAcA_YvS8OQVTPnvRtWyVuAKO2bccyNALOs1Oq7snTO1WwkA@mail.gmail.com>
	<a391e7e5-0be9-0863-bfb7-88d9168484f3@twiddle.net>
	<87h8yo9k2n.fsf@linaro.org>
	<638cda88-5bd8-2a86-d720-04005fa1c1c8@twiddle.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <dfd89c2b-8ed6-0a78-93df-51fb442f0adb@amsat.org>
Date: Sat, 8 Jul 2017 13:21:08 -0300
MIME-Version: 1.0
In-Reply-To: <638cda88-5bd8-2a86-d720-04005fa1c1c8@twiddle.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [RFC PATCH] target/arm: ensure eret
 exits the run-loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Emilio G . Cota" <cota@braap.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Joakim Bech <joakim.bech@linaro.org>, Etienne Carriere <etienne.carriere@linaro.org>

Hi Alex,

On 07/07/2017 03:52 PM, Richard Henderson wrote:
> On 07/07/2017 08:29 AM, Alex Bennée wrote:
>>> Naming all of these different exit conditions is certainly
>>> non-trivial.
>>
>> Given the variation of usage this is something that should probably be
>> done after Lluís common run loop goes in and we can beef up the
>> semantics of the various exit conditions.
> 
> Definitely.
> 
>> One thing I have noticed in the ARM translator is DISAS_UPDATE does a:
>>
>>      gen_a64_set_pc_im(dc->pc);
>>
>> I think this is to deal with handling exceptions either side of various
>> instructions. Am I right in thinking this is superfluous now as we can
>> derive the PC from the translated code address?
> 
> Yes and no.
> 
> We have typically distinguished between two kinds of exceptions: those 
> that are dynamic (fp state, page permissions) and those that are static 
> (illegal opcodes).
> 
> For the dynamic, we used to pessimistically save state, but now use the 
> unwinder to restore it.  The unwinding is expensive but is used 
> infrequently (especially compared to the number of load/store insns 
> executed).
> 
> For the static, we know the exception must be raised, and we know the 
> state that must be saved.  By doing that, we save the expense of the 
> unwinding.
> 
> So, for the static case you're talking about, we could get the PC (and 
> other state) back, and remove the explicit stores, but we shouldn't.

While doing changes in this file, can you add a comment around 
DISAS_UPDATE about Richard explanation?

> 
> 
> r~
> 
