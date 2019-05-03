Received: from eggs.gnu.org ([209.51.188.92]:55876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMRDH-00019D-2U
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:58:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMRDF-0005qa-UD
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:58:27 -0400
Message-ID: <1556863097.1887.4.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri, 03 May 2019 15:58:17 +1000
In-Reply-To: <20190503055316.6441-1-sjitindarsingh@gmail.com>
References: <20190503055316.6441-1-sjitindarsingh@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH 00/13] target/ppc: Implement KVM
 support under TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, clg@kaod.org, groug@kaod.org

On Fri, 2019-05-03 at 15:53 +1000, Suraj Jitindar Singh wrote:
> This patch series adds the necessary parts so that a tcg guest is
> able to use
> kvm facilities. That is a tcg guest can boot its own kvm guests.
> 
> The main requirements for this were a few registers and instructions
> as well as
> some hcalls and the addition of partition scoped translation in the
> radix mmu
> emulation.
> 
> This can be used to boot a kvm guest under a pseries tcg guest:
> Use power9_v2.2 cpu and add -machine cap-nested-hv=on for the first
> guest.
> Then inside that guest boot a kvm guest as normal.
> This takes advantage of the new hcalls with qemu emulating them as a
> normal
> hypervisor would on a real machine.
> 
> This can also be used to boot a kvm guest under a powernv tcg guest:
> Use any power9 cpu type.
> This takes advantage of the new hv register access added.
> Note that for powernv there is no xive interrupt excalation for KVM
> which means
> that while the guest will boot, it won't receive any interrupts.

Ah so I'm suddenly aware I based this on the wrong tree so it won't
apply to your dwg-ppc-for-4.1 David.

Consider this a RFC and I'll rebase and resend when required.

> 
> Suraj Jitindar Singh (13):
>   target/ppc: Implement the VTB for HV access
>   target/ppc: Work [S]PURR implementation and add HV support
>   target/ppc: Add SPR ASDR
>   target/ppc: Add SPR TBU40
>   target/ppc: Add privileged message send facilities
>   target/ppc: Enforce that the root page directory size must be at
> least
>     5
>   target/ppc: Handle partition scoped radix tree translation
>   target/ppc: Implement hcall H_SET_PARTITION_TABLE
>   target/ppc: Implement hcall H_ENTER_NESTED
>   target/ppc: Implement hcall H_TLB_INVALIDATE
>   target/ppc: Implement hcall H_COPY_TOFROM_GUEST
>   target/ppc: Introduce POWER9 DD2.2 cpu type
>   target/ppc: Enable SPAPR_CAP_NESTED_KVM_HV under tcg
> 
>  hw/ppc/ppc.c                    |  46 ++++-
>  hw/ppc/spapr_caps.c             |  22 ++-
>  hw/ppc/spapr_cpu_core.c         |   1 +
>  hw/ppc/spapr_hcall.c            | 409
> +++++++++++++++++++++++++++++++++++++++
>  include/hw/ppc/ppc.h            |   4 +-
>  include/hw/ppc/spapr.h          |   7 +-
>  linux-user/ppc/cpu_loop.c       |   5 +
>  target/ppc/cpu-models.c         |   2 +
>  target/ppc/cpu-models.h         |   1 +
>  target/ppc/cpu.h                |  70 +++++++
>  target/ppc/excp_helper.c        |  79 +++++++-
>  target/ppc/helper.h             |   9 +
>  target/ppc/misc_helper.c        |  46 +++++
>  target/ppc/mmu-radix64.c        | 412 ++++++++++++++++++++++++++++
> ------------
>  target/ppc/mmu-radix64.h        |   4 +
>  target/ppc/timebase_helper.c    |  20 ++
>  target/ppc/translate.c          |  28 +++
>  target/ppc/translate_init.inc.c | 107 +++++++++--
>  18 files changed, 1115 insertions(+), 157 deletions(-)
> 
