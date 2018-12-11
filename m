Received: from eggs.gnu.org ([2001:4830:134:3::10]:46913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWpVi-0007w1-TD
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 16:24:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWpVf-00041p-Mm
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 16:24:10 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44309)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gWpVf-00041S-6U
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 16:24:07 -0500
Received: by mail-ot1-x344.google.com with SMTP id f18so15525288otl.11
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 13:24:07 -0800 (PST)
References: <20181207085635.4291-1-mark.cave-ayland@ilande.co.uk>
	<20181207085635.4291-5-mark.cave-ayland@ilande.co.uk>
	<958fc521-9193-bd72-ca82-c8aac222fad2@linaro.org>
	<7297dcf6-c856-5e5c-e8e7-9bf8bb0f2178@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e71301ba-0350-4a4a-eb3b-e156fef33720@linaro.org>
Date: Tue, 11 Dec 2018 15:24:02 -0600
MIME-Version: 1.0
In-Reply-To: <7297dcf6-c856-5e5c-e8e7-9bf8bb0f2178@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 4/6] target/ppc: switch FPR,
 VMX and VSX helpers to access data directly from cpu_env
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 12/11/18 1:21 PM, Mark Cave-Ayland wrote:
>> Note however, that there are other steps that you must add here before using
>> vector operations in the next patch:
>>
>> (1a) The fpr and vsr arrays must be merged, since fpr[n] == vsrh[n].
>>      If this isn't done, then you simply cannot apply one operation
>>      to two disjoint memory blocks.
>>
>> (1b) The vsr and avr arrays should be merged, since vsr[32+n] == avr[n].
>>      This is simply tidiness, matching the layout to the architecture.
>>
>> These steps will modify gdbstub.c, machine.c, and linux-user/.
> 
> The reason I didn't touch the VSR arrays was because I was hoping that this could be
> done as a follow up later; my thought was that since I'd only introduced vector
> operations into the VMX instructions then currently no vector operations could be
> done across the 2 separate memory blocks?

True, until you convert the VSX insns you can delay this.
Though honestly I would consider doing both at once.

>> (2) The vsr array needs to be QEMU_ALIGN(16).  See target/arm/cpu.h.
>>     We assert that the host addresses are 16 byte aligned, so that we
>>     can eventually use Altivec/VSX in tcg/ppc/.
> 
> That's a good observation. Presumably being on Intel the unaligned accesses would
> still work but just be slower? I've certainly seen the new vector ops being emitted
> in the generated code.

Yes, currently I generate unaligned loads.  It made sense when considering AVX2
and ARM SVE, since I do not increase the alignment requirements to 32-bytes
when using 256-bit vectors.

I do wonder if I should go back and generate aligned loads, just to raise
SIGBUS when one has forgotten the QEMU_ALIGN marker, as a portability aid.


r~
