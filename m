Received: from eggs.gnu.org ([2001:4830:134:3::10]:38838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g9tnP-0004M2-Tr
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:19:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g9tnK-0000ON-4d
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:19:39 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:53287)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g9tnI-0000Ii-2B
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:19:32 -0400
Date: Tue, 9 Oct 2018 11:19:24 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181009151924.GA7480@flamenco>
References: <20181008232756.30704-1-cota@braap.org> <87murnmh7j.fsf@linaro.org>
	<20181009143837.GA24820@flamenco> <87h8hvmb5b.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h8hvmb5b.fsf@linaro.org>
Subject: Re: [Qemu-devel] [RFC v2 0/5] Dynamic TLB sizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>

On Tue, Oct 09, 2018 at 15:45:36 +0100, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
> 
> > On Tue, Oct 09, 2018 at 13:34:40 +0100, Alex Bennée wrote:
> >>
> >> Emilio G. Cota <cota@braap.org> writes:
> >>
> >> > v1: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg01146.html
> >> >
> >> > Changes since v1:
> >>
> >> Hmm I'm seeing some qtest failures, for example:
> >>
> >>   $ make check-qtest-alpha V=1
> >>   ...
> >>   QTEST_QEMU_BINARY=alpha-softmmu/qemu-system-alpha QTEST_QEMU_IMG=qemu-img MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))} gtester -k --verbose -m=quick test
> >>   s/boot-serial-test tests/qmp-test tests/qmp-cmd-test tests/device-introspect-test tests/cdrom-test tests/machine-none-test tests/qom-test tests/test-hmp
> >>   TEST: tests/boot-serial-test... (pid=31091)
> >>     /alpha/boot-serial/clipper:                                          Broken pipe
> >>   tests/libqtest.c:129: kill_qemu() detected QEMU death from signal 11 (Segmentation fault) (core dumped)
> >>   FAIL
> >>   GTester: last random seed: R02S948c4a5112fd7682934f4d96e1aff38e
> >>   (pid=31099)
> >>   FAIL: tests/boot-serial-test
> >
> > I'm pretty sure that the problem is that tlb_init is not being
> > called at all. Note that this applies to the tlb-lock series
> > as well, although there we're just calling qemu_spin_init,
> > which is not really necessary because CPUArchState is 0-allocated.
> >
> > I'll take a look.
> 
> Yeah I hadn't tried to bisect it, but I'm on top of tlb-lock-v4 as
> requested.

It's the tlb_flush in alpha_cpu_initfn:

static void alpha_cpu_initfn(Object *obj)
{
    CPUState *cs = CPU(obj);
    AlphaCPU *cpu = ALPHA_CPU(obj);
    CPUAlphaState *env = &cpu->env;

    cs->env_ptr = env;
    tlb_flush(cs);

We call tlb_init later on at realize time.

I think we can safely get rid of this tlb_flush. Unicore
also has it. I'll add patches for both to the tlb-lock series.

		Emilio
