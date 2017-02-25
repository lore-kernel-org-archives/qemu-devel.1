Received: from eggs.gnu.org ([2001:4830:134:3::10]:39629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1chRhZ-0002ks-QZ
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 21:03:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1chRhW-0002Nd-Mp
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 21:03:13 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1487879800-12352-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487879800-12352-7-git-send-email-nikunj@linux.vnet.ibm.com>
	<755c77c5-0930-b5ee-0b3b-1e0608301c8d@twiddle.net>
	<87a89cza5l.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170224025841.GN17615@umbus.fritz.box>
	<4a13acc6-8a7e-f259-fdb7-6c3156b9ac6c@twiddle.net>
	<87o9xs2hnl.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <34bf17ea-3f3a-3af1-5df6-ebaaed21573a@twiddle.net>
Date: Sat, 25 Feb 2017 13:03:02 +1100
MIME-Version: 1.0
In-Reply-To: <87o9xs2hnl.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 06/15] target/ppc: remove xer split-out
 flags(so, ov, ca)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

On 02/24/2017 06:05 PM, Nikunj A Dadhania wrote:
> Richard Henderson <rth@twiddle.net> writes:
>
>> On 02/24/2017 01:58 PM, David Gibson wrote:
>>> On Fri, Feb 24, 2017 at 06:18:22AM +0530, Nikunj A Dadhania wrote:
>>>> Richard Henderson <rth@twiddle.net> writes:
>>>>
>>>>> On 02/24/2017 06:56 AM, Nikunj A Dadhania wrote:
>>>>>> Now get rid all the split out variables so, ca, ov. After this patch,
>>>>>> all the bits are stored in CPUPPCState::xer at appropriate places.
>>>>>>
>>>>>> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
>>>>>> ---
>>>>>>  target/ppc/cpu.c        |   8 +---
>>>>>>  target/ppc/cpu.h        |  26 ++++++------
>>>>>>  target/ppc/int_helper.c |  12 +++---
>>>>>>  target/ppc/translate.c  | 106 +++++++++++++++++++++++++-----------------------
>>>>>>  4 files changed, 78 insertions(+), 74 deletions(-)
>>>>>
>>>>> I do not think this is a good direction to take this.
>>>>
>>>> Hmm, any particular reason?
>>>
>>> Right, I suggested this, but based only a suspicion that the split
>>> variables weren't worth the complexity.  I'm happy to be corrected by
>>> someone with better knowledge of TCG, but it'd be nice to know why.
>>
>> Normally we're interested in minimizing the size of the generated code,
>> delaying computation until we can show it being used.
>>
>> Now, ppc is a bit different from other targets (which might compute overflow
>> for any addition insn) in that it only computes overflow when someone asks for
>> it.  Moreover, it's fairly rare for the addo/subo/nego instructions to
>> be used.
>
>> Therefore, I'm not 100% sure what the "best" solution is.
>
> Agreed, with that logic, wont it be more efficient to move the OV/CA
> updationg to respective callers, and when xer_read/write happens, its
> just one tcg_ops.
>
>
>> However, I'd be surprised if the least amount of code places all of
>> the bits into their canonical location within XER.
>>
>> Do note that when looking at this, the various methods by which the OV/SO bits
>> are copied to CR flags ought to be taken into account.
>
> I lost you in the last two para, can you explain in detail?

Reading XER via MFSPR is not the only way to access the CA/OV/SO bits.  One may 
use the "dot" form of the instruction to copy SO to CR0[3].  One may use the 
MCRXRX instruction to copy 5 bits from XER to CR[BF].  One may use the add/sub 
extended instructions to access the CA bit.

Therefore it is not a forgone conclusion that a read of XER will *ever* occur, 
and therefore it is not necessarily most efficient to keep the CA/OV/SO bits in 
the canonical XER form.

I think it's especially important to keep CA separate in order to facilitate 
multi-word addition chains.

I suspect that it's most efficient to keep SO in a form that best simplifies 
"dot" instructions, e.g. since there is no un-dotted "andi" instruction. 
Naturally, the form in which you store SO is going to influence how you store OV.

The other thing that is desirable is to allow the TCG optimizer to delete 
computations that are dead.  That cannot be done if you're constantly folding 
results back into a single XER register.

Consider a sequence like

	li	r0, 0
	mtspr	xer, r0
	addo	r3, r4, r5
	addo.	r6, r7, r8

where we clear XER (and thus SO), perform two computations, and then read SO 
via the dot.  Obviously the two computations of OV are not dead, because they 
get ORed into SO.  However, the first computation of OV32 is dead, shadowed by 
the second, because there is no accumulating SO32 bit.


r~
