Received: from eggs.gnu.org ([2001:4830:134:3::10]:57730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9WYM-0008J1-Cb
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:30:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9WYJ-0003Kd-87
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:30:34 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:56094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g9WYJ-0003JY-12
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:30:31 -0400
Received: by mail-wm1-x343.google.com with SMTP id 206-v6so8369165wmb.5
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 07:30:30 -0700 (PDT)
References: <20181005211450.847-1-cota@braap.org>
	<20181005211450.847-4-cota@braap.org>
	<8736tgo81t.fsf@linaro.org> <20181008141219.GB19899@flamenco>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181008141219.GB19899@flamenco>
Date: Mon, 08 Oct 2018 15:30:28 +0100
Message-ID: <87y3b8mry3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/4] cputlb: serialize tlb updates with
 env->tlb_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>


Emilio G. Cota <cota@braap.org> writes:

> On Mon, Oct 08, 2018 at 14:57:18 +0100, Alex Benn=C3=A9e wrote:
>> Emilio G. Cota <cota@braap.org> writes:
>> > The readers that do not hold tlb_lock must use atomic reads when
>> > reading .addr_write, since this field can be updated by other threads;
>> > the conversion to atomic reads is done in the next patch.
>>
>> We don't enforce this for the TCG code - but rely on the backend ISA's
>> to avoid torn reads from updates from cputlb that could invalidate an
>> entry.
>
> We do enforce it though; the TLB reads we emit in TCG backend
> code are appropriately sized to guarantee atomic reads.
>
>> > -/* For atomic correctness when running MTTCG we need to use the right
>> > - * primitives when copying entries */
>> > -static inline void copy_tlb_helper(CPUTLBEntry *d, CPUTLBEntry *s,
>> > -                                   bool atomic_set)
>> > +/* Called with tlb_lock held */
>> > +static inline void copy_tlb_helper_locked(CPUTLBEntry *d, const CPUTL=
BEntry *s)
>> >  {
>> > -#if TCG_OVERSIZED_GUEST
>> >      *d =3D *s;
>>
>> In general I'm happy with the patch set but what ensures that this
>> always DRT with respect to the TCG code reads that race with it?
>
> copy_tlb_helper is only called by the "owner" CPU, so it cannot
> race with TCG code (i.e. the owner thread cannot race with itself).
>
> I wanted to add an assert_cpu_is_self(cpu) here, but that needs
> a CPUState pointer. Maybe I should just get rid of the function?
> All the callers have the assert, so that might make the code
> clearer.

I'm happy keeping the function and just expanding the comment:

/* Called with tlb_lock held and only ever from the vCPU context */

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>
> Thanks,
>
> 		Emilio


--
Alex Benn=C3=A9e
