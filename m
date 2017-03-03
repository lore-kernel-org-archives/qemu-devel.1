Received: from eggs.gnu.org ([2001:4830:134:3::10]:50484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cjr9c-0003Cm-CU
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 12:38:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cjr9Y-0002Uq-Fx
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 12:38:08 -0500
Received: from greensocs.com ([193.104.36.180]:45877)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cjr9Y-0002UM-1l
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 12:38:04 -0500
References: <20170302195337.31558-1-alex.bennee@linaro.org>
From: Frederic Konrad <fred.konrad@greensocs.com>
Message-ID: <058f0960-bc1b-fd44-9871-66d11d2e9b76@greensocs.com>
Date: Fri, 3 Mar 2017 18:38:00 +0100
MIME-Version: 1.0
In-Reply-To: <20170302195337.31558-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/11] MTTCG fixups for 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, rth@twiddle.net, pbonzini@redhat.com, mttcg@listserver.greensocs.com, nikunj@linux.vnet.ibm.com, a.rigo@virtualopensystems.com, qemu-devel@nongnu.org, cota@braap.org, bobby.prani@gmail.com

Hi All,

I've a strangeness with the "drop iolock" patch.
It seems it has an impact on the MMIO execution patch-set I'm working
on:

Basically modifying the memory tree is causing a Bad Ram Address error.
I wonder if this can't happen with hotplug/unplug model as well.

I'll look into this.
Shoot if you have any evidence of why that doesn't work :).

Thanks,
Fred

On 03/02/2017 08:53 PM, Alex Benn=C3=A9e wrote:
> Hi Peter,
>=20
> So perhaps predictably the merging of MTTCG has thrown up some issues
> during soft-freeze. The following patches fix up some of those:
>=20
> The following where in v1 and just have r-b tags:
>=20
>   vl/cpus: be smarter with icount and MTTCG
>   target/i386/cpu.h: declare TCG_GUEST_DEFAULT_MO
>   cpus.c: add additional error_report when !TARGET_SUPPORT_MTTCG
>=20
> The next change downgrades the asserts to tcg_debug_asserts. This will
> reduce the instances of production builds failing on non-MTTCG enabled
> guests. The races still need to be fixed but you now have to
> --enable-debug-tcg to go hunting for them:
>=20
>   translate: downgrade IRQ BQL asserts to tcg_debug_assert
>=20
> This never came up in my testing but it seems some guests can
> translate while doing a tlb_fill. The call to cpu_restore_state never
> worked before (as we are translating the block you are looking for)
> but by bugging out we avoid the double tb_lock().
>=20
>   translate-all: exit cpu_restore_state early if translating
>=20
> Then we have a bunch of fixes from the reports on the list. They are
> safe to merge but I'll leave that up to the maintainers. There may be
> an argument for holding these patches back until the guest is
> converted to be MTTCG aware and a full audit of the CPU<->HW emulation
> boundaries is done for each one:
>=20
>   sparc/sparc64: grab BQL before calling cpu_check_irqs
>   s390x/misc_helper.c: wrap IO instructions in BQL
>   target/xtensa: hold BQL for interrupt processing
>   target/mips/op_helper: hold BQL before calling cpu_mips_get_count
>=20
> Finally these are just tiny debug fixes while investigating the icount
> regression:
>=20
>   target/arm/helper: make it clear the EC field is also in hex
>   hw/intc/arm_gic: modernise the DPRINTF
>=20
> Going forward I think 1-5 are ready to be merged now. For 6-9 we
> should await decisions from the target maintainers. The last two are
> entirely up to you.
>=20
> It looks like the -icount regression is a poor interaction between
> icount timers and the BQL but this is going to require discussion with
> Paolo in the morning.
>=20
> Cheers,
>=20
>=20
> Alex Benn=C3=A9e (11):
>   vl/cpus: be smarter with icount and MTTCG
>   target/i386/cpu.h: declare TCG_GUEST_DEFAULT_MO
>   cpus.c: add additional error_report when !TARGET_SUPPORT_MTTCG
>   translate: downgrade IRQ BQL asserts to tcg_debug_assert
>   translate-all: exit cpu_restore_state early if translating
>   sparc/sparc64: grab BQL before calling cpu_check_irqs
>   s390x/misc_helper.c: wrap IO instructions in BQL
>   target/xtensa: hold BQL for interrupt processing
>   target/mips/op_helper: hold BQL before calling cpu_mips_get_count
>   target/arm/helper: make it clear the EC field is also in hex
>   hw/intc/arm_gic: modernise the DPRINTF
>=20
>  cpus.c                      | 11 +++++++----
>  hw/intc/arm_gic.c           | 13 +++++++++----
>  hw/sparc/sun4m.c            |  3 +++
>  hw/sparc64/sparc64.c        |  3 +++
>  target/arm/helper.c         |  2 +-
>  target/i386/cpu.h           |  3 +++
>  target/mips/op_helper.c     | 17 ++++++++++++++---
>  target/s390x/misc_helper.c  | 21 +++++++++++++++++++++
>  target/sparc/int64_helper.c |  3 +++
>  target/sparc/win_helper.c   | 11 +++++++++++
>  target/xtensa/helper.c      |  1 +
>  target/xtensa/op_helper.c   |  7 +++++++
>  translate-all.c             |  9 ++++++++-
>  translate-common.c          |  3 ++-
>  vl.c                        |  7 ++-----
>  15 files changed, 95 insertions(+), 19 deletions(-)
>=20
