Received: from eggs.gnu.org ([2001:4830:134:3::10]:43417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dVr08-00053s-2h
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 23:10:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dVr07-0007oM-3O
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 23:10:43 -0400
Message-ID: <1500001828.11655.1.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri, 14 Jul 2017 13:10:28 +1000
In-Reply-To: <03821688-88ac-ca87-6cc4-85999fe4c1fc@kaod.org>
References: <03821688-88ac-ca87-6cc4-85999fe4c1fc@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] CPU hotplug on POWER9 (TCG) fails in
 ppc_radix64_handle_mmu_fault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>

Hi Cedric,

On Wed, 2017-07-12 at 19:19 +0200, Cédric Le Goater wrote:
> Hi, 
> 
> Today, if you try to hotplug a CPU on a POWER9 guest (TCG), it fails
> with an assert on the LPCR_UPRT bit missing in
> ppc_radix64_handle_mmu_fault()
> 
>   (qemu) device_add POWER9_v1.0-spapr-cpu-core,core-id=4,id=foo
>   (qemu) [   12.766102] pseries-hotplug-cpu: Attempting to add CPU,
> drc index: 10000004
>   qemu-system-ppc64: ./target/ppc/mmu-radix64.c:204:
> ppc_radix64_handle_mmu_fault: Assertion `ppc64_use_proc_tbl(cpu)'
> failed.
>   Aborted (core dumped)
> 
> The LPCR SPR is incorrectly set. I have hacked my way through to
> make 
> it work, by changing cpu_ppc_set_papr(), but this is really ugly and 
> certainly wrong. 

Yes this is happening because the guest is radix (the bit is set in the
process table) however the UPRT (use process tables) bit is not set in
the LPCR, which is a requirement when in radix mode (there is no other
way to translate addresses than to use process tables).

Thus in the radix mmu emulation code the assert is failing (as you
document above). I assume this is because when the hot-plugged cpu is
added it is in the default state. For TCG at least the default state is
assumed to be hash page tables (not radix). We set the UPRT bit in the
LPCR and radix bit for the guest when handling the H_REGISTER_PROC_TBL
hcall.

> 
> I would happy to cook the fix, as I need it for XIVE development.
> What
> would be the correct approach ?

I'm not sure what the code path is when hot plugging a cpu, but you
would need to do some checks on the state of the guest and the other
cpus and setup the cpu which you are adding appropriately. In this
circumstance it would be checking if the guest is radix (there is
already a function in target/ppc/mmu-book3s-v3.h ppc64_radix_guest())
and setting up the cpu state for the new cpu appropriately (i.e.
setting the LPCR bits).

> 
> Thanks,
> 
> C.
