Received: from eggs.gnu.org ([2001:4830:134:3::10]:37563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d601S-0006ek-G1
	for qemu-devel@nongnu.org; Wed, 03 May 2017 15:33:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d601O-0003RI-FV
	for qemu-devel@nongnu.org; Wed, 03 May 2017 15:33:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d601O-0003QH-6z
	for qemu-devel@nongnu.org; Wed, 03 May 2017 15:33:10 -0400
Date: Wed, 3 May 2017 16:33:04 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170503193304.GW3482@thinpad.lan.raisama.net>
References: <1493803036-4048-1-git-send-email-he.chen@linux.intel.com>
	<20170503150705.7a55ca5c@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170503150705.7a55ca5c@nial.brq.redhat.com>
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: He Chen <he.chen@linux.intel.com>, qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Andrew Jones <drjones@redhat.com>

On Wed, May 03, 2017 at 03:07:05PM +0200, Igor Mammedov wrote:
> On Wed,  3 May 2017 17:17:16 +0800
> He Chen <he.chen@linux.intel.com> wrote:
> 
> > Signed-off-by: He Chen <he.chen@linux.intel.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Thanks!

> 
> Eduardo,
> 
> could you take it through your tree as well and
> add as part of this patch SLIT tables blobs for
> piix4/q35 that tests/acpi-test-data/rebuild-expected-aml.sh
> will generate.

Queued to numa-next, updated SRAT and SLIT blobs. diffstat of commit fixup:

 tests/acpi-test-data/pc/SLIT.cphp   | Bin 0 -> 48 bytes
 tests/acpi-test-data/pc/SLIT.memhp  | Bin 0 -> 48 bytes
 tests/acpi-test-data/pc/SRAT.memhp  | Bin 224 -> 264 bytes
 tests/acpi-test-data/q35/SLIT.cphp  | Bin 0 -> 48 bytes
 tests/acpi-test-data/q35/SLIT.memhp | Bin 0 -> 48 bytes
 tests/acpi-test-data/q35/SRAT.memhp | Bin 224 -> 264 bytes
 6 files changed, 0 insertions(+), 0 deletions(-)

Are you able to explain why SRAT.memhp changed, but SRAT.cphp didn't?

> 
> > ---
> >  tests/bios-tables-test.c | 16 ++++++++++++----
> >  1 file changed, 12 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> > index 88dbf97..c593165 100644
> > --- a/tests/bios-tables-test.c
> > +++ b/tests/bios-tables-test.c
> > @@ -710,7 +710,8 @@ static void test_acpi_piix4_tcg_cphp(void)
> >      data.machine = MACHINE_PC;
> >      data.variant = ".cphp";
> >      test_acpi_one("-smp 2,cores=3,sockets=2,maxcpus=6"
> > -                  " -numa node -numa node",
> > +                  " -numa node -numa node"
> > +                  " -numa dist,src=0,dst=1,val=21",
> >                    &data);
> >      free_test_data(&data);
> >  }
> > @@ -723,7 +724,8 @@ static void test_acpi_q35_tcg_cphp(void)
> >      data.machine = MACHINE_Q35;
> >      data.variant = ".cphp";
> >      test_acpi_one(" -smp 2,cores=3,sockets=2,maxcpus=6"
> > -                  " -numa node -numa node",
> > +                  " -numa node -numa node"
> > +                  " -numa dist,src=0,dst=1,val=21",
> >                    &data);
> >      free_test_data(&data);
> >  }
> > @@ -772,7 +774,10 @@ static void test_acpi_q35_tcg_memhp(void)
> >      memset(&data, 0, sizeof(data));
> >      data.machine = MACHINE_Q35;
> >      data.variant = ".memhp";
> > -    test_acpi_one(" -m 128,slots=3,maxmem=1G -numa node", &data);
> > +    test_acpi_one(" -m 128,slots=3,maxmem=1G"
> > +                  " -numa node -numa node"
> > +                  " -numa dist,src=0,dst=1,val=21",
> > +                  &data);
> >      free_test_data(&data);
> >  }
> >  
> > @@ -783,7 +788,10 @@ static void test_acpi_piix4_tcg_memhp(void)
> >      memset(&data, 0, sizeof(data));
> >      data.machine = MACHINE_PC;
> >      data.variant = ".memhp";
> > -    test_acpi_one(" -m 128,slots=3,maxmem=1G -numa node", &data);
> > +    test_acpi_one(" -m 128,slots=3,maxmem=1G"
> > +                  " -numa node -numa node"
> > +                  " -numa dist,src=0,dst=1,val=21",
> > +                  &data);
> >      free_test_data(&data);
> >  }
> >  
> 

-- 
Eduardo
