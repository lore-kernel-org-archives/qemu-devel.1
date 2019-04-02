Received: from eggs.gnu.org ([209.51.188.92]:42148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hBCoj-0001UJ-8o
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 02:22:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hBChg-0007ii-91
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 02:15:25 -0400
Date: Tue, 2 Apr 2019 08:15:12 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190402081512.6194a58f@redhat.com>
In-Reply-To: <20190402035343.GA6527@richard>
References: <20190313044253.31988-1-richardw.yang@linux.intel.com>
	<20190313044253.31988-4-richardw.yang@linux.intel.com>
	<20190313132300.3f56a5ca@redhat.com>
	<20190313133359.h2njohyijgvkcbtv@master>
	<20190313170943.5384f5cf@redhat.com>
	<20190402035343.GA6527@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 3/3] hw/acpi: Extract build_mcfg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, peter.maydell@linaro.org, mst@redhat.com, qemu-devel@nongnu.org, shannon.zhaosl@gmail.com, qemu-arm@nongnu.org

On Tue, 2 Apr 2019 11:53:43 +0800
Wei Yang <richardw.yang@linux.intel.com> wrote:

> On Wed, Mar 13, 2019 at 05:09:43PM +0100, Igor Mammedov wrote:
> >On Wed, 13 Mar 2019 13:33:59 +0000
> >Wei Yang <richard.weiyang@gmail.com> wrote:
> >  
> >> 
> >> I am lost at this place.
> >> 
> >> sig is a part of ACPI table header, you mean the sig is not necessary to
> >> be set in ACPI table header?
> >> 
> >> "skip table generation" means remove build_header() in build_mcfg()?  
> >I mean do not call build_mcfg() at all when you don't have to.
> >
> >And when you need to keep table_blob the same size (for old machines)
> >using acpi_data_push() to reserve space instead of build_mcfg(sig="QEMU")
> >might just work as well. it's still hack but it can live in x86 specific
> >acpi_build() keeping build_mcfg() generic.
> >
> >As for defining what to use as criteria to decide when we need to keep
> >table_blob size the same, I don't remember history of it, so I'd suggest
> >to look at commit a1666142, study history of acpi_ram_update() and
> >legacy_acpi_table_size to figure out since which machine type one doesn't
> >have to keep table_blob size the same.
> >  
> 
> Hi, Igor
> 
> It took me sometime to go through the migration infrastructure.
> 
> Before continuing, I'd like to talk about what I understand to make sure my
> direction is correct.
> 
> ACPI has a structure named AcpiBuildState, which contains all related
> information. During migration, those data in AcpiBuildState should be
> transferred to destination, e.g. table_mr, rsdp_mr and link_mr.
> 
> In the case related to mcfg, the problem lies in table_mr. And the reason
> breaking migration is the size of table_mr is different between source and
> destination.(This reason is a guess from those change logs and mails.)
This is about right if I recall it correctly.
 
> The migration infrastructure has several SaveStateEntry to help migrate
> different elements. The one with name "ram" take charge of RAMBlock. So this
> SaveStateEntry and its ops is the next step for me to investigate. And from
> this to see the effect of different size MemoryRegion during migration.
I don't think that you need to dig in migration mechanics so deep.
For our purpose of finding QEMU&machine version where migration between
size mismatched MemoryRegions (or RAMBlocks) is fixed is sufficient.

Aside from trying to grasp how migration works internally, you can try
to simulate[1] problem and bisect it to a commit that fixed it.
It still not easy due to amount of combinations you'd need to try,
but it's probably much easier than trying to figure out issue just
by reading code.

1) to stimulate you need to recreate conditions for table_mr jumping
from initial padded size to the next padded size after adding bridge
so you'd have reproducer which makes table_mr differ in size.

If I recall correctly in that time conditions were created by large
amount hotpluggble CPUs (maxcpus - CLI option) and then addidng
PCI bridges.
I'd just hack QEMU to print table_mr size in acpi_build_update()
to find coldplug CLI where we jump to the next padded size and then
use it for bisection with bridge[s] hotplug on source and migrating that
without reboot to target where hotplugged bridges are on CLI (one has to
configure target so it would have all devices that source has including
hotplugged ones)

> Is this sounds correct?
> 
