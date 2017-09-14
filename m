Received: from eggs.gnu.org ([2001:4830:134:3::10]:57410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dsVcm-0002T0-Ek
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:00:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dsVcg-000746-Fl
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:00:16 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:43158)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dsVcg-00071k-5d
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:00:10 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <150505986682.19604.11937392314067517230.stgit@frigg.lan>
	<150506059354.19604.5050182852156612042.stgit@frigg.lan>
	<0250ce97-bef3-1feb-d9a9-4e4a91084fa7@linaro.org>
Date: Thu, 14 Sep 2017 17:59:57 +0300
In-Reply-To: <0250ce97-bef3-1feb-d9a9-4e4a91084fa7@linaro.org> (Richard
	Henderson's message of "Wed, 13 Sep 2017 10:07:44 -0700")
Message-ID: <87inglpbpu.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/7] trace: Add event
 "guest_inst_info_before"
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

> On 09/10/2017 09:23 AM, Llu=C3=ADs Vilanova wrote:
>> Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>> ---
>> accel/tcg/translator.c |   18 ++++++++++++++++++
>> trace-events           |    9 +++++++++
>> 2 files changed, 27 insertions(+)
>>=20
>> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
>> index 287d27b4f7..6598931171 100644
>> --- a/accel/tcg/translator.c
>> +++ b/accel/tcg/translator.c
>> @@ -70,6 +70,8 @@ void translator_loop(const TranslatorOps *ops, DisasCo=
ntextBase *db,
>>=20
>> while (true) {
>> target_ulong pc_insn =3D db->pc_next;
>> +        TCGv_i32 insn_size_tcg =3D 0;
>> +        int insn_size_opcode_idx;

> Initializing a TCGv_i32 is wrong.
> And surely insn_size_opcode is surely uninitialized?

>> +        if (TRACE_GUEST_INST_INFO_BEFORE_EXEC_ENABLED) {
>> +            insn_size_tcg =3D tcg_temp_new_i32();
>> +            insn_size_opcode_idx =3D tcg_op_buf_count();
>> +            tcg_gen_movi_i32(insn_size_tcg, 0xdeadbeef);
>> +
>> +            trace_guest_inst_info_before_tcg(
>> +                cpu, tcg_ctx.tcg_env, pc_insn, insn_size_tcg);
>> +
>> +            tcg_temp_free_i32(insn_size_tcg);

> There's no reason you can't declare insn_size_tcg right here and avoid the
> incorrect initialization above.

Yes, I guess I did not move the declaration here by error after refactoring=
 the
code.


> Is there a reason to have both "guest_insn" and "guest_insn_info"?

I initially wanted to have a bare-bones event with simple information, and =
an
*_info variant with more detailed information like register usage and physi=
cal
 addresses (which would be disabled by default to avoid performance impact).

We had a discussion long time ago that led to decide that register usage
information as I implemented it was only partial (it did not capture regist=
er
usage helpers), and thus was not worth adding.

Since physical address information is not gonna be added in this series (if=
 at
all), what do you say about hoisting instruction length info into
guest_insn_before/after and dropping the *_info variants?


Thanks,
  Lluis
