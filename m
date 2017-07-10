Received: from eggs.gnu.org ([2001:4830:134:3::10]:54903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUXas-00024L-J3
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:15:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUXan-0002qo-R0
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:15:14 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:34084)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dUXan-0002pl-KS
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:15:09 -0400
Received: by mail-wr0-x22e.google.com with SMTP id 77so136163056wrb.1
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 05:15:09 -0700 (PDT)
References: <20170707161822.29659-1-alex.bennee@linaro.org>
	<87inj49mr1.fsf@linaro.org>
	<CAFEAcA_YvS8OQVTPnvRtWyVuAKO2bccyNALOs1Oq7snTO1WwkA@mail.gmail.com>
	<a391e7e5-0be9-0863-bfb7-88d9168484f3@twiddle.net>
	<87h8yo9k2n.fsf@linaro.org>
	<638cda88-5bd8-2a86-d720-04005fa1c1c8@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <638cda88-5bd8-2a86-d720-04005fa1c1c8@twiddle.net>
Date: Mon, 10 Jul 2017 13:15:06 +0100
Message-ID: <87tw2ka3p1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH] target/arm: ensure eret exits the
 run-loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Etienne Carriere <etienne.carriere@linaro.org>, Joakim Bech <joakim.bech@linaro.org>, "Emilio G . Cota" <cota@braap.org>


Richard Henderson <rth@twiddle.net> writes:

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
> that are dynamic (fp state, page permissions) and those that are
> static (illegal opcodes).
>
> For the dynamic, we used to pessimistically save state, but now use
> the unwinder to restore it.  The unwinding is expensive but is used
> infrequently (especially compared to the number of load/store insns
> executed).
>
> For the static, we know the exception must be raised, and we know the
> state that must be saved.  By doing that, we save the expense of the
> unwinding.
>
> So, for the static case you're talking about, we could get the PC (and
> other state) back, and remove the explicit stores, but we shouldn't.

I'm thinking of how to bring this into line with the other translators.
Pretty much everyone else generates an exit block although m68k does do
a update_cc_op(dc); In the ARM translator we have the backend specific
DISAS_EXIT which behaves like DISAS_UPDATE everywhere else.

For consistency DISAS_UPDATE should work the same across all arches but
doing:

  gen_set_pc_im(dc, dc->pc);

if we are going to use DISAS_UPDATE instead of DISAS_EXIT is going to
break things like eret as dc->pc will certainly not be the correct PC.
Looking at translate.c (32 bit arm), we have:

  gen_srs
  gen_mrs_banked
  gen_msr_banked

These all manually set:

  gen_set_pc_im(s, s->pc - 4);

before their respective helpers. I think setting the PC after the helper
is superfluous given we are will at that point be exiting the block. The
situation is the same for translate-a64.c. So I think the correct
changes are:

  - strengthen commentary in exec-all.h
  - don't set pc on our way out of a DISAS_UPDATE
  - convert eret to DISAS_UPDATE
  - get rid of DISAS_EXIT and use DISAS_UPDATE instead

My only worry is inadvertently breaking something because something does
need the post-foo set_pc. But I can't think what does. Peter?


--
Alex Bennée
