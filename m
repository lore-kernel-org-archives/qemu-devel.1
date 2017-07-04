Received: from eggs.gnu.org ([2001:4830:134:3::10]:39457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dSTHI-00054v-Dg
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 15:14:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dSTHH-0004Ix-D0
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 15:14:28 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:36713)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dSTHH-0004Ic-4X
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 15:14:27 -0400
Received: by mail-wm0-x233.google.com with SMTP id 62so203986293wmw.1
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 12:14:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8760f8av0c.fsf@frigg.lan>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865316837.17063.1608754834009945976.stgit@frigg.lan>
	<528c921e-d04c-f064-08f8-2c6a0b3f23f1@twiddle.net>
	<8760f8av0c.fsf@frigg.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Jul 2017 20:14:05 +0100
Message-ID: <CAFEAcA8VPgejz7oUKMR7965BjyU3t+DA8Vq7GatUUhTC0j9XRg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 04/29] target: [tcg] Add generic
 translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Emilio G. Cota" <cota@braap.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 4 July 2017 at 19:59, Llu=C3=ADs Vilanova <vilanova@ac.upc.edu> wrote:
> Richard Henderson writes:
>
>> On 06/28/2017 05:32 AM, Llu=C3=ADs Vilanova wrote:
>>> +    void (*init_disas_context)(DisasContextBase *db, CPUState *cpu);
>>> +    void (*init_globals)(DisasContextBase *db, CPUState *cpu);
>>> +    void (*tb_start)(DisasContextBase *db, CPUState *cpu);
>>> +    void (*insn_start)(DisasContextBase *db, CPUState *cpu);
>>> +    BreakpointCheckType (*breakpoint_check)(DisasContextBase *db, CPUS=
tate *cpu,
>>> +                                            const CPUBreakpoint *bp);
>>> +    target_ulong (*translate_insn)(DisasContextBase *db, CPUState *cpu=
);
>>> +    void (*tb_stop)(DisasContextBase *db, CPUState *cpu);
>>> +    void (*disas_log)(const DisasContextBase *db, CPUState *cpu);
>
>> Any reason not to stuff the cpu pointer into the DisasContextBase instea=
d of
>> passing it around separately?
>
> None, really. I'll move it from DisasContext (in targets where it's prese=
nt)
> into DisasContextBase, and use that one everywhere.

I kind of like not having CPUState* in DisasContext, because
it enforces the rule that you can't read from fields of
it inside the target translate.c code without jumping through
a hoop (ie copying the info from CPUState->foo to
DisasContext->foo). That then acts as a useful flag in code
review (or when writing the code) to confirm that foo really
is constant for the life of the simulation (or to recommend
using a TB flag instead).

thanks
-- PMM
