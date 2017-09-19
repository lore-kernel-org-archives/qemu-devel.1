Received: from eggs.gnu.org ([2001:4830:134:3::10]:43248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1duOKg-000464-FA
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 15:37:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1duOKc-0007Sm-Hh
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 15:37:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1duOKc-0007Rt-9o
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 15:37:18 -0400
References: <20170919142654.16369-1-david@redhat.com>
	<20170919142654.16369-4-david@redhat.com>
	<452a304a-70e4-c3ab-2e76-a67823922e90@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <8bc7cb17-522a-48ea-5818-12bdbfb37d70@redhat.com>
Date: Tue, 19 Sep 2017 21:36:55 +0200
MIME-Version: 1.0
In-Reply-To: <452a304a-70e4-c3ab-2e76-a67823922e90@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] s390x/tcg: add basic MSA features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Alexander Graf <agraf@suse.de>, Aurelien Jarno <aurelien@aurel32.net>

On 19.09.2017 19:47, Richard Henderson wrote:
> On 09/19/2017 09:26 AM, David Hildenbrand wrote:
>> +    const uint8_t fc = env->regs[0] & 0x7fULL;
> 
> Don't mask here...

Bit 56 is the mod bit (see variable "mod") and is checked inside the
switch(). The function code really is just composed of bit 57 - 63, so
this is correct.

> 
>> +    if (fc >= 128 || !test_be_bit(fc, subfunc)) {

... however the fc >= 128 case can be dropped, as this can in fact never
happen (due to the masking).

>> +        cpu_restore_state(cs, ra);
>> +        program_interrupt(env, PGM_SPECIFICATION, 4);
>> +        return 0;
>> +    }
> 
> ... because you are indeed supposed to test bit 56.  But you've already ensured
> that won't be set above.
> 
> Do you in fact need to set bit 63 in subfunc, since that itself is query?
> Certainly you won't get past this test, regardless...

Yes, it always has to be set and is guaranteed by s390_get_feat_block().
So test_be_bit(fc, subfunc) will always allow bit 0 (query).

Especially due to the statement:

"When a bit is one, the corresponding function is installed; otherwise,
the function is not installed."

Query is always installed.


> 
> 
>> +static ExitStatus op_msa(DisasContext *s, DisasOps *o)
>> +{
>> +    int r1 = have_field(s->fields, r1) ? get_field(s->fields, r1) : 0;
>> +    int r2 = have_field(s->fields, r2) ? get_field(s->fields, r2) : 0;
>> +    int r3 = have_field(s->fields, r3) ? get_field(s->fields, r3) : 0;
>> +    TCGv_i32 t_r1, t_r2, t_r3, type;
>> +
>> +    switch (s->insn->data) {
>> +    case S390_FEAT_TYPE_KMCTR:
>> +        if (r3 & 1 || !r3) {
>> +            gen_program_exception(s, PGM_SPECIFICATION);
>> +            return EXIT_NORETURN;
>> +        }
>> +        /* FALL THROUGH */
>> +    case S390_FEAT_TYPE_PPNO:
>> +    case S390_FEAT_TYPE_KMF:
>> +    case S390_FEAT_TYPE_KMC:
>> +    case S390_FEAT_TYPE_KMO:
>> +    case S390_FEAT_TYPE_KM:
>> +        if (r1 & 1 || !r1) {
>> +            gen_program_exception(s, PGM_SPECIFICATION);
>> +            return EXIT_NORETURN;
>> +        }
>> +        /* FALL THROUGH */
>> +    case S390_FEAT_TYPE_KMAC:
>> +    case S390_FEAT_TYPE_KIMD:
>> +    case S390_FEAT_TYPE_KLMD:
>> +        if (r2 & 1 || !r2) {
>> +            gen_program_exception(s, PGM_SPECIFICATION);
>> +            return EXIT_NORETURN;
>> +        }
> 
> Even though it would be silly to do so, considering that r0+r1 are implicit
> arguments to these insns, I see nothing that insists that r[123] are not 0,
> only that they are even.
> 

E.g. for KMAC (7-187):

"A specification exception is recognized and no other
action is taken if any of the following occurs:
[...]
 The R2 field designates an odd-numbered regis-
ter or general register 0."

Or KMCTR (7-103):

"A specification exception is recognized and no other
action is taken if any of the following occurs:
[...]
 The R1 R2, or R3 field designates an odd-num-
bered register or general register 0."


I implemented kvm-unit-tests that test all of these conditions.
Especially they also pass on KVM, so I assume they are correct (as these
instructions are fully interpreted by HW).

https://www.spinics.net/lists/kvm/msg155690.html

In the test included is
a) checking that the mod bit must not be set for certain instructions
b) r1-3 either odd or 0 for certain instructions
c) that query is always indicated


Thanks for the review!

> 
> r~
> 


-- 

Thanks,

David
