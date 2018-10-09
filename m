Received: from eggs.gnu.org ([2001:4830:134:3::10]:49208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9uDW-000688-KV
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:46:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9uDS-000184-CR
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:46:38 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:38443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g9uDR-00015Q-Nn
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:46:34 -0400
Received: by mail-wr1-x42c.google.com with SMTP id a13-v6so2368763wrt.5
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 08:46:29 -0700 (PDT)
References: <20181008232756.30704-1-cota@braap.org>
	<87murnmh7j.fsf@linaro.org> <20181009143837.GA24820@flamenco>
	<87h8hvmb5b.fsf@linaro.org> <20181009151924.GA7480@flamenco>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181009151924.GA7480@flamenco>
Date: Tue, 09 Oct 2018 16:46:26 +0100
Message-ID: <87bm83m8bx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 0/5] Dynamic TLB sizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> On Tue, Oct 09, 2018 at 15:45:36 +0100, Alex Benn=C3=A9e wrote:
>>
>> Emilio G. Cota <cota@braap.org> writes:
>>
>> > On Tue, Oct 09, 2018 at 13:34:40 +0100, Alex Benn=C3=A9e wrote:
>> >>
>> >> Emilio G. Cota <cota@braap.org> writes:
>> >>
>> >> > v1: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg01146.=
html
>> >> >
>> >> > Changes since v1:
>> >>
>> >> Hmm I'm seeing some qtest failures, for example:
>> >>
>> >>   $ make check-qtest-alpha V=3D1
>> >>   ...
>> >>   QTEST_QEMU_BINARY=3Dalpha-softmmu/qemu-system-alpha QTEST_QEMU_IMG=
=3Dqemu-img MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1=
))} gtester -k --verbose -m=3Dquick test
>> >>   s/boot-serial-test tests/qmp-test tests/qmp-cmd-test tests/device-i=
ntrospect-test tests/cdrom-test tests/machine-none-test tests/qom-test test=
s/test-hmp
>> >>   TEST: tests/boot-serial-test... (pid=3D31091)
>> >>     /alpha/boot-serial/clipper:                                      =
    Broken pipe
>> >>   tests/libqtest.c:129: kill_qemu() detected QEMU death from signal 1=
1 (Segmentation fault) (core dumped)
>> >>   FAIL
>> >>   GTester: last random seed: R02S948c4a5112fd7682934f4d96e1aff38e
>> >>   (pid=3D31099)
>> >>   FAIL: tests/boot-serial-test
>> >
>> > I'm pretty sure that the problem is that tlb_init is not being
>> > called at all. Note that this applies to the tlb-lock series
>> > as well, although there we're just calling qemu_spin_init,
>> > which is not really necessary because CPUArchState is 0-allocated.
>> >
>> > I'll take a look.
>>
>> Yeah I hadn't tried to bisect it, but I'm on top of tlb-lock-v4 as
>> requested.
>
> It's the tlb_flush in alpha_cpu_initfn:
>
> static void alpha_cpu_initfn(Object *obj)
> {
>     CPUState *cs =3D CPU(obj);
>     AlphaCPU *cpu =3D ALPHA_CPU(obj);
>     CPUAlphaState *env =3D &cpu->env;
>
>     cs->env_ptr =3D env;
>     tlb_flush(cs);
>
> We call tlb_init later on at realize time.
>
> I think we can safely get rid of this tlb_flush.

Agreed.

> Unicore
> also has it. I'll add patches for both to the tlb-lock series.

Weirdly this didn't fail, but I agree it's superfluous.

>
> 		Emilio


--
Alex Benn=C3=A9e
