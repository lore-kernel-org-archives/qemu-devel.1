Received: from eggs.gnu.org ([2001:4830:134:3::10]:50803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ciro.santilli@gmail.com>) id 1enjQX-0002SY-4k
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 06:16:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ciro.santilli@gmail.com>) id 1enjQV-0004U4-Ap
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 06:16:09 -0500
Received: from mail-io0-x22b.google.com ([2607:f8b0:4001:c06::22b]:37329)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ciro.santilli@gmail.com>)
	id 1enjQV-0004Ti-4l
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 06:16:07 -0500
Received: by mail-io0-x22b.google.com with SMTP id t126so10915183iof.4
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 03:16:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <001201d3a957$f85ed610$e91c8230$@ru>
References: <20180207120353.5389.54531.stgit@pasha-VirtualBox>
	<CAFXrp_fenK2mzLSOUUcWLTR1r4_jUEN07QDqfkRDpTFEo4oHpQ@mail.gmail.com>
	<002401d3a010$8d551280$a7ff3780$@ru>
	<CAFXrp_c09S6e9EnT7LOYox2YMiOXN_suFo30wfqcmzwRB8zx2A@mail.gmail.com>
	<CAFXrp_dUAZDYLUTqY0nxbGg7w4TEqD2+rNRPT+47a0B8N1Y6Aw@mail.gmail.com>
	<001b01d3a3c5$032e09f0$098a1dd0$@ru>
	<CAFXrp_dNj+BSYo+0rpv5d4PxdjJ1RL_cROaDWRvjQTLziFtO_Q@mail.gmail.com>
	<000c01d3a496$fd2bc470$f7834d50$@ru>
	<CAFXrp_cEsHH_6VQevxsrj8GTchraGKEJ_t0xhSbfajcBu-mmzg@mail.gmail.com>
	<001a01d3a4b1$273f1a90$75bd4fb0$@ru>
	<002201d3a4b5$2a642b80$7f2c8280$@ru>
	<CAFEAcA9yO_4FX0J6hsdAmV7TwZd5kp9J-B2EPwm_KZxDO25bGQ@mail.gmail.com>
	<000d01d3a590$caa17950$5fe46bf0$@ru>
	<001201d3a957$f85ed610$e91c8230$@ru>
From: Ciro Santilli <ciro.santilli@gmail.com>
Date: Mon, 19 Feb 2018 11:15:45 +0000
Message-ID: <CAFXrp_cR16EOwZp-FauZuZcwuWwB53gxSO57ggy5qud-vyzimA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v6 00/20] replay additions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: Peter Maydell <peter.maydell@linaro.org>, richard.henderson@linaro.org, cota@braap.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, war2jordan@live.com, Igor R <boost.lists@gmail.com>, Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Aleksandr Bezzubikov <zuban32s@gmail.com>, maria.klimushenkova@ispras.ru, Gerd Hoffmann <kraxel@redhat.com>, Thomas Dullien <thomas.dullien@googlemail.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Mon, Feb 19, 2018 at 8:02 AM, Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote=
:
>> From: Pavel Dovgalyuk [mailto:dovgaluk@ispras.ru]
>> > From: Peter Maydell [mailto:peter.maydell@linaro.org]
>> > On 13 February 2018 at 10:26, Pavel Dovgalyuk <dovgaluk@ispras.ru> wro=
te:
>> > > Then I added SCSI adapter with the option =E2=80=93device lsi,id=3Ds=
csi0 and QEMU
>> > > failed with the following error:
>> > >
>> > > qemu: fatal: IO on conditional branch instruction
>> >
>> > > Seems, that your kernel is incomatible with QEMU, which ARM emulatio=
n is not
>> > > good enough.
>> >
>> > It seems fairly unlikely to me that the Linux driver for this
>> > SCSI adaptor is using weirdo self-modifying code of the kind
>> > that would trip up that cpu_abort(). I would suggest a bit
>> > more investigation into what's actually happening...
>>
>> Peter, I bisected this bug and figured out the following.
>>
>> icount in ARM was broken by the following commit: 9b990ee5a3cc6aa38f8126=
6fb0c6ef37a36c45b9
>> tcg: Add CPUState cflags_next_tb
>> This commit breaks execution of Ciro's kernel with enabled icount.
>> I haven't yet figured out why this happens.
>
> The problem is in the following code.
> As far, as I can understand, original version recompiles the TB and
> continues the execution as it goes.
>
> But the modified version sets cflags for the next compilation.
> And these are the flags for the old TB which should replace the original =
one.
> TCG tries to use cflags for the new TB (which starts after the interrupte=
d one)
> and fails, because these flags are inappropriate.
> That is why icount execution fails.
>
> New version also does not include recompilation of the old block, which i=
s wrong too.
>

Awesome! Can you push it to a branch, and give the full qemu command
line so I can test it?

>
> @@ -1773,9 +1765,7 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t reta=
ddr)
>      CPUArchState *env =3D cpu->env_ptr;
>  #endif
>      TranslationBlock *tb;
> -    uint32_t n, cflags;
> -    target_ulong pc, cs_base;
> -    uint32_t flags;
> +    uint32_t n;
>
>      tb_lock();
>      tb =3D tb_find_pc(retaddr);
> @@ -1813,12 +1803,9 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t ret=
addr)
>          cpu_abort(cpu, "TB too big during recompile");
>      }
>
> -    cflags =3D n | CF_LAST_IO;
> -    cflags |=3D curr_cflags();
> -    pc =3D tb->pc;
> -    cs_base =3D tb->cs_base;
> -    flags =3D tb->flags;
> -    tb_phys_invalidate(tb, -1);
> +    /* Adjust the execution state of the next TB.  */
> +    cpu->cflags_next_tb =3D curr_cflags() | CF_LAST_IO | n;
> +
>      if (tb->cflags & CF_NOCACHE) {
>          if (tb->orig_tb) {
>              /* Invalidate original TB if this TB was generated in
> @@ -1827,9 +1814,6 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t reta=
ddr)
>          }
>          tb_free(tb);
>      }
> -    /* FIXME: In theory this could raise an exception.  In practice
> -       we have already translated the block once so it's probably ok.  *=
/
> -    tb_gen_code(cpu, pc, cs_base, flags, cflags);
>
>      /* TODO: If env->pc !=3D tb->pc (i.e. the faulting instruction was n=
ot
>       * the first in the TB) then we end up generating a whole new TB and
>
>
>
> Pavel Dovgalyuk
>
