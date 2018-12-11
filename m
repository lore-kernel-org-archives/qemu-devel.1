Received: from eggs.gnu.org ([2001:4830:134:3::10]:42225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gWnb0-0002xY-TB
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 14:21:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gWnb0-000172-3G
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 14:21:30 -0500
References: <20181207085635.4291-1-mark.cave-ayland@ilande.co.uk>
	<20181207085635.4291-5-mark.cave-ayland@ilande.co.uk>
	<958fc521-9193-bd72-ca82-c8aac222fad2@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <7297dcf6-c856-5e5c-e8e7-9bf8bb0f2178@ilande.co.uk>
Date: Tue, 11 Dec 2018 19:21:11 +0000
MIME-Version: 1.0
In-Reply-To: <958fc521-9193-bd72-ca82-c8aac222fad2@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
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
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 10/12/2018 19:05, Richard Henderson wrote:

> On 12/7/18 2:56 AM, Mark Cave-Ayland wrote:
>> Instead of accessing the FPR, VMX and VSX registers through static arrays of
>> TCGv_i64 globals, remove them and change the helpers to load/store data directly
>> within cpu_env.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>  target/ppc/translate.c | 59 ++++++++++++++------------------------------------
>>  1 file changed, 16 insertions(+), 43 deletions(-)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> Note however, that there are other steps that you must add here before using
> vector operations in the next patch:
> 
> (1a) The fpr and vsr arrays must be merged, since fpr[n] == vsrh[n].
>      If this isn't done, then you simply cannot apply one operation
>      to two disjoint memory blocks.
> 
> (1b) The vsr and avr arrays should be merged, since vsr[32+n] == avr[n].
>      This is simply tidiness, matching the layout to the architecture.
> 
> These steps will modify gdbstub.c, machine.c, and linux-user/.

The reason I didn't touch the VSR arrays was because I was hoping that this could be
done as a follow up later; my thought was that since I'd only introduced vector
operations into the VMX instructions then currently no vector operations could be
done across the 2 separate memory blocks?

> (2) The vsr array needs to be QEMU_ALIGN(16).  See target/arm/cpu.h.
>     We assert that the host addresses are 16 byte aligned, so that we
>     can eventually use Altivec/VSX in tcg/ppc/.

That's a good observation. Presumably being on Intel the unaligned accesses would
still work but just be slower? I've certainly seen the new vector ops being emitted
in the generated code.


ATB,

Mark.
