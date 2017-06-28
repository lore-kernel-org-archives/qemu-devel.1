Received: from eggs.gnu.org ([2001:4830:134:3::10]:55364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQBSW-00070P-Nr
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:48:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQBSR-0002zN-Og
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:48:36 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
	<149838531005.6497.12362377034456580175.stgit@frigg.lan>
	<c43f4c84-debd-ffbe-7d48-97c74a0b8bd0@twiddle.net>
Date: Wed, 28 Jun 2017 14:48:07 +0300
In-Reply-To: <c43f4c84-debd-ffbe-7d48-97c74a0b8bd0@twiddle.net> (Richard
	Henderson's message of "Mon, 26 Jun 2017 20:33:08 -0700")
Message-ID: <87podocozs.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v9 21/26] target: [tcg,
 arm] Port to insn_start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>

Richard Henderson writes:

> On 06/25/2017 03:08 AM, Llu=C3=ADs Vilanova wrote:
>> +static void arm_trblock_insn_start(DisasContextBase *db, CPUState *cpu)
>> +{
>> +    DisasContext *dc =3D container_of(db, DisasContext, base);
>> +
>> +    dc->insn_start_idx =3D tcg_op_buf_count();
>> +    tcg_gen_insn_start(dc->pc,
>> +                       (dc->condexec_cond << 4) | (dc->condexec_mask >>=
 1),
>> +                       0);
>> +
>> +#ifdef CONFIG_USER_ONLY
>> +    /* Intercept jump to the magic kernel page.  */
>> +    if (dc->pc >=3D 0xffff0000) {
>> +        /* We always get here via a jump, so know we are not in a
>> +           conditional execution block.  */
>> +        gen_exception_internal(EXCP_KERNEL_TRAP);
>> +        dc->is_jmp =3D DJ_EXC;
>> +    }
>> +#endif
>> +}

> I think this DJ_EXC block is better placed at the start of disas_insn.

> It is, however, the answer to one of my questions re patch 4/26.

It cannot, because DJ_EXC make the generic code break out of trasnlation be=
fore
doing anything else, which is what the original code does.

Cheers,
  Lluis
