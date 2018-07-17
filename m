Received: from eggs.gnu.org ([2001:4830:134:3::10]:39090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffXvC-0008Ux-7H
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 17:54:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffXvB-000818-0H
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 17:54:14 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:44122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ffXvA-00080f-QS
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 17:54:12 -0400
Received: by mail-oi0-x243.google.com with SMTP id s198-v6so4913724oih.11
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 14:54:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.1807172232001.51759@zero.eik.bme.hu>
References: <20180716195851.0FE177456B7@zero.eik.bme.hu>
	<CAFEAcA-Lu=gZWQOROa+oEwaWP8FWSY__=jneDQZVK=mFXAcFMw@mail.gmail.com>
	<alpine.BSF.2.21.1807171644120.57515@zero.eik.bme.hu>
	<64174176-84a6-57dc-4b34-d3cd11d585c9@ilande.co.uk>
	<alpine.BSF.2.21.1807172049050.25631@zero.eik.bme.hu>
	<e32447d1-92dd-7508-d388-ed2ac606c1b8@ilande.co.uk>
	<alpine.BSF.2.21.1807172232001.51759@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jul 2018 22:53:51 +0100
Message-ID: <CAFEAcA_=XpFw-FL8-dTux+JftrmVN-pp8J2JyjbMgVmFq7Wa+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-ppc] Profiling results
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 17 July 2018 at 21:46, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> On Tue, 17 Jul 2018, Mark Cave-Ayland wrote:
>> Good question. A quick grep for 'asidx_from_attrs' shows that
>> cc->asidx_from_attrs() isn't set for PPC targets, so as a quick test does
>> replacing the inline function cpu_asidx_from_attrs() in include/qom/cpu.h
>> with a simple "return 0" change the profile at all?
>
>
> It does seem to lessen its impact but it's still higher than I expected:

It may be worth special-casing the CPU method lookups (or at
least that one) if we can, then...

> %        cum. %     linenr info                 symbol name
> 10.7949  10.7949    exec-all.h:410              helper_lookup_tb_ptr
>  7.8663  18.6612    cputlb.c:793                io_readx
>  6.0265  24.6878    cputlb.c:114                tlb_flush_nocheck
>  4.0671  28.7548    sm501_template.h:62         draw_line16_32
>  4.0559  32.8107    object.c:765
> object_class_dynamic_cast_assert
>  3.3780  36.1887    memory.c:1350               memory_region_access_valid
>  2.8920  39.0808    qemu-thread-posix.c:61      qemu_mutex_lock_impl
>  2.7187  41.7995    memory.c:1415               memory_region_dispatch_read
>  2.6011  44.4006    qht.c:487                   qht_lookup_custom
>  2.5356  46.9362    softmmu_template.h:112      helper_ret_ldub_mmu
>
> Maybe it's called from somewhere else too? I know draw_line16_32 but I
> wonder where could helper_lookup_tb_ptr and tlb flushes come from? Those
> seem to be significant. And io_readx in itself seems to be too high on the
> list too.

helper_lookup_tb_ptr is part of TCG -- it's where we look for
the next TB to go to. Any non-computed branch to a different page
will result in our calling this. So it's high on the profile
because we do it a lot, I think, but that's not necessarily a
problem as such.

io_readx is the slow path for guest memory accesses -- any
guest access to something that's not RAM will have to go through
here. My first guess (given the other things in the profile,
especially helper_ret_ldub_mmu, memory_region_dispatch_read
and memory_region_access_valid) is that the guest is in a tight
loop doing a read on a device register a lot of the time.

> I wonder if it may have something to do with the background task
> trying to read non-implemented i2c stuff frequently (as discussed in point
> 2. in http://zero.eik.bme.hu/~balaton/qemu/amiga/#morphos).

Could be, or some similar thing. If you suspect the i2c you
could try putting in an unimplemented-device stub in the
right place and see how often -d unimp yells about reads to it.

So overall I'd be a little wary of optimizing based on this
profile, because I suspect it's atypical -- the guest is sat
in a tight polling loop and the profile says "all the functions
in the code path for doing device access are really hot".
The fix is to improve our model so the guest doesn't get
stuck like that, not to try to slightly improve the speed
of device accesses (we call it the "slow path" for a reason :-))

(But places like asidx_from_attrs are likely to be on hot
paths in general, so having the QOM class lookup there be
overly heavyweight is maybe worth fixing anyhow.)

thanks
-- PMM
