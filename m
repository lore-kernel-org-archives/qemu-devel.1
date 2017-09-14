Received: from eggs.gnu.org ([2001:4830:134:3::10]:50317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dsWve-0002Wa-Bj
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 12:23:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dsWvb-0006n9-6K
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 12:23:50 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:50510 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dsWva-0006mB-QQ
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 12:23:47 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <150505986682.19604.11937392314067517230.stgit@frigg.lan>
	<150506131942.19604.1306593039321280342.stgit@frigg.lan>
	<418914ee-c8bf-2576-3cea-4a3eb2a9d4f7@linaro.org>
Date: Thu, 14 Sep 2017 19:23:34 +0300
In-Reply-To: <418914ee-c8bf-2576-3cea-4a3eb2a9d4f7@linaro.org> (Richard
	Henderson's message of "Wed, 13 Sep 2017 11:01:39 -0700")
Message-ID: <877ex1nta1.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/7] trace: Add event "guest_inst_after"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Richard Henderson writes:

> On 09/10/2017 09:35 AM, Llu=C3=ADs Vilanova wrote:
>> Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>> ---
>> accel/tcg/translator.c |   23 ++++++++++++++++++-----
>> trace-events           |    8 ++++++++
>> 2 files changed, 26 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
>> index d66d601c89..c010aeee45 100644
>> --- a/accel/tcg/translator.c
>> +++ b/accel/tcg/translator.c
>> @@ -35,7 +35,8 @@ void translator_loop_temp_check(DisasContextBase *db)
>> void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
>> CPUState *cpu, TranslationBlock *tb)
>> {
>> -    target_ulong pc_bbl;
>> +    target_ulong pc_bbl, pc_insn =3D 0;
>> +    bool translated_insn =3D false;
>> int max_insns;
>>=20
>> /* Initialize DisasContext */
>> @@ -75,10 +76,15 @@ void translator_loop(const TranslatorOps *ops, Disas=
ContextBase *db,
>> tcg_debug_assert(db->is_jmp =3D=3D DISAS_NEXT);  /* no early exit */
>>=20
>> while (true) {
>> -        target_ulong pc_insn =3D db->pc_next;
>> TCGv_i32 insn_size_tcg =3D 0;
>> int insn_size_opcode_idx;
>>=20
>> +        /* Tracing after (previous instruction) */
>> +        if (db->num_insns > 0) {
>> +            trace_guest_inst_after_tcg(cpu, tcg_ctx.tcg_env, pc_insn);
>> +        }

> How does this differ from "guest_inst"?  Why would you need two trace poi=
nts?

I assume you mean how it differs from guest_inst_before. The two main ideas=
 are:

* To be able to get a trace an execution-time event only after the instruct=
ion
  or TB have finished executing successfully (i.e., there could be an excep=
tion).
* Some values are only known *after* the instruction is translated (like the
  instruction size, or other extra information we might add in the future),=
 so
  an efficient way to collect that is to trace guest_bbl_* and guest_insn_a=
fter
  at translation time (to build a TB "dictionary" as some call it), and tra=
ce
  guest_bbl_before at execution time (and use the detailed info above that =
you
  got at translation time).


> Why are you placing this at the beginning of the while loop rather than t=
he end?

Yeah, that'll be much clearer.


>> @@ -164,6 +172,9 @@ void translator_loop(const TranslatorOps *ops, Disas=
ContextBase *db,
>>=20
>> gen_set_inline_region_begin(tcg_ctx.disas.inline_label);
>>=20
>> +        if (TRACE_GUEST_INST_AFTER_ENABLED && translated_insn) {
>> +            trace_guest_inst_after_tcg(cpu, tcg_ctx.tcg_env, pc_insn);
>> +        }
>> if (TRACE_GUEST_BBL_AFTER_ENABLED) {
>> trace_guest_bbl_after_tcg(cpu, tcg_ctx.tcg_env, pc_bbl);
>> }

> I think I'm finally beginning to understand what you're after with your
> inlining.  But I still think this should be doable in the appropriate opc=
ode
> generating functions.

I'm not sure we can if we want to avoid having the duplicate translation-ti=
me
events I said in a previous response (since TB can have two exit points and
we're detecting them through goto_tb).


Thanks,
  Lluis
