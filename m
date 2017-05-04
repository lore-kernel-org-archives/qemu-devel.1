Received: from eggs.gnu.org ([2001:4830:134:3::10]:50600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <he.chen@linux.intel.com>) id 1d66xr-0000zL-CX
	for qemu-devel@nongnu.org; Wed, 03 May 2017 22:58:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <he.chen@linux.intel.com>) id 1d66xo-0003j8-Ai
	for qemu-devel@nongnu.org; Wed, 03 May 2017 22:57:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:36701)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <he.chen@linux.intel.com>)
	id 1d66xo-0003if-1G
	for qemu-devel@nongnu.org; Wed, 03 May 2017 22:57:56 -0400
Date: Thu, 4 May 2017 10:58:18 +0800
From: He Chen <he.chen@linux.intel.com>
Message-ID: <20170504025818.GA4115@he>
References: <1493803036-4048-1-git-send-email-he.chen@linux.intel.com>
	<20170503150705.7a55ca5c@nial.brq.redhat.com>
	<20170503193304.GW3482@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170503193304.GW3482@thinpad.lan.raisama.net>
Subject: Re: [Qemu-devel] [PATCH] tests: acpi: extend cphp and memhp
 testcase with numa distance check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Andrew Jones <drjones@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On Wed, May 03, 2017 at 04:33:04PM -0300, Eduardo Habkost wrote:
> On Wed, May 03, 2017 at 03:07:05PM +0200, Igor Mammedov wrote:
> > On Wed,  3 May 2017 17:17:16 +0800
> > He Chen <he.chen@linux.intel.com> wrote:
> > 
> > > Signed-off-by: He Chen <he.chen@linux.intel.com>
> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> 
> Thanks!
> 
> > 
> > Eduardo,
> > 
> > could you take it through your tree as well and
> > add as part of this patch SLIT tables blobs for
> > piix4/q35 that tests/acpi-test-data/rebuild-expected-aml.sh
> > will generate.
> 
> Queued to numa-next, updated SRAT and SLIT blobs. diffstat of commit fixup:
> 
>  tests/acpi-test-data/pc/SLIT.cphp   | Bin 0 -> 48 bytes
>  tests/acpi-test-data/pc/SLIT.memhp  | Bin 0 -> 48 bytes
>  tests/acpi-test-data/pc/SRAT.memhp  | Bin 224 -> 264 bytes
>  tests/acpi-test-data/q35/SLIT.cphp  | Bin 0 -> 48 bytes
>  tests/acpi-test-data/q35/SLIT.memhp | Bin 0 -> 48 bytes
>  tests/acpi-test-data/q35/SRAT.memhp | Bin 224 -> 264 bytes
>  6 files changed, 0 insertions(+), 0 deletions(-)
> 
> Are you able to explain why SRAT.memhp changed, but SRAT.cphp didn't?
> 

ACPI spec says SRAT table is an optional table that provides information
that allows OSPM to associate processors and memory ranges, including
ranges of memory provided by hot-added memory devices, with system
localities proximity domains and clock domains.

I think the reason why SRAT.cphp does not change is that in CPU hotplug
test, the NUMA topology is not changed although the NUMA distance
information is added (distance information is contained in SLIT table
rather than SRAT table).

While for memory hot plug test, we change the NUMA topology (NUMA node
from 1 to 2 nodes.), thus the processors and memory ranges is changed,
which results in SRAT table gets changed.
> > 
> > > ---
> > >  tests/bios-tables-test.c | 16 ++++++++++++----
> > >  1 file changed, 12 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> > > index 88dbf97..c593165 100644
> > > --- a/tests/bios-tables-test.c
> > > +++ b/tests/bios-tables-test.c
> > > @@ -710,7 +710,8 @@ static void test_acpi_piix4_tcg_cphp(void)
> > >      data.machine = MACHINE_PC;
> > >      data.variant = ".cphp";
> > >      test_acpi_one("-smp 2,cores=3,sockets=2,maxcpus=6"
> > > -                  " -numa node -numa node",
> > > +                  " -numa node -numa node"
> > > +                  " -numa dist,src=0,dst=1,val=21",
> > >                    &data);
> > >      free_test_data(&data);
> > >  }
> > > @@ -723,7 +724,8 @@ static void test_acpi_q35_tcg_cphp(void)
> > >      data.machine = MACHINE_Q35;
> > >      data.variant = ".cphp";
> > >      test_acpi_one(" -smp 2,cores=3,sockets=2,maxcpus=6"
> > > -                  " -numa node -numa node",
> > > +                  " -numa node -numa node"
> > > +                  " -numa dist,src=0,dst=1,val=21",
> > >                    &data);
> > >      free_test_data(&data);
> > >  }
> > > @@ -772,7 +774,10 @@ static void test_acpi_q35_tcg_memhp(void)
> > >      memset(&data, 0, sizeof(data));
> > >      data.machine = MACHINE_Q35;
> > >      data.variant = ".memhp";
> > > -    test_acpi_one(" -m 128,slots=3,maxmem=1G -numa node", &data);
> > > +    test_acpi_one(" -m 128,slots=3,maxmem=1G"
> > > +                  " -numa node -numa node"
> > > +                  " -numa dist,src=0,dst=1,val=21",
> > > +                  &data);
> > >      free_test_data(&data);
> > >  }
> > >  
> > > @@ -783,7 +788,10 @@ static void test_acpi_piix4_tcg_memhp(void)
> > >      memset(&data, 0, sizeof(data));
> > >      data.machine = MACHINE_PC;
> > >      data.variant = ".memhp";
> > > -    test_acpi_one(" -m 128,slots=3,maxmem=1G -numa node", &data);
> > > +    test_acpi_one(" -m 128,slots=3,maxmem=1G"
> > > +                  " -numa node -numa node"
> > > +                  " -numa dist,src=0,dst=1,val=21",
> > > +                  &data);
> > >      free_test_data(&data);
> > >  }
> > >  
> > 
> 
> -- 
> Eduardo
> 
