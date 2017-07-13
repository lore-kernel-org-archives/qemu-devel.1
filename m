Received: from eggs.gnu.org ([2001:4830:134:3::10]:48592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVXYG-0001P9-FL
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 02:24:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVXYB-0000Pz-5w
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 02:24:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dVXYA-0000PF-Sb
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 02:24:35 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1499774331.git.alistair.francis@xilinx.com>
	<b80b284089ce9d4664a5014b65266c0e25e40072.1499774331.git.alistair.francis@xilinx.com>
	<874lui9eog.fsf@dusky.pond.sub.org>
	<20170712194504.GM6020@localhost.localdomain>
Date: Thu, 13 Jul 2017 08:24:29 +0200
In-Reply-To: <20170712194504.GM6020@localhost.localdomain> (Eduardo Habkost's
	message of "Wed, 12 Jul 2017 16:45:04 -0300")
Message-ID: <87r2xkua5e.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 4/8] hw/i386: Improve some of the
 warning messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: philippe@mathieu-daude.net, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, Igor Mammedov <imammedo@redhat.com>, alistair23@gmail.com

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Wed, Jul 12, 2017 at 11:39:59AM +0200, Markus Armbruster wrote:
>> Alistair Francis <alistair.francis@xilinx.com> writes:
>> 
>> > Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> > Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
>> 
>> You forgot to cc: Eduardo.  Fixed.
>> 
>> > ---
>> >
>> >  hw/i386/acpi-build.c | 7 ++++---
>> >  hw/i386/pc.c         | 9 ++++-----
>> >  hw/i386/pc_q35.c     | 4 ++--
>> >  3 files changed, 10 insertions(+), 10 deletions(-)
>> >
>> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> > index 6b7bade183..f9efb6be41 100644
>> > --- a/hw/i386/acpi-build.c
>> > +++ b/hw/i386/acpi-build.c
>> > @@ -2766,7 +2766,8 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>> >                       ACPI_BUILD_ALIGN_SIZE);
>> >          if (tables_blob->len > legacy_table_size) {
>> >              /* Should happen only with PCI bridges and -M pc-i440fx-2.0.  */
>> > -            warn_report("migration may not work.");
>> > +            warn_report("ACPI tables are larger than legacy_table_size");
>> > +            warn_report("migration may not work");
>> 
>> The user has no idea what legacy_table_size means, what its value might
>> be, or what he can do to reduce it.
>> 
>> Recommend
>> 
>>                warn_report("ACPI tables too large, migration may not work");
>> 
>> If the user can do something to reduce the table size, printing suitable
>> hints would be nice.  Printing both tables_blob->len and
>> legacy_table_size might also help then.
>> 
>> >          }
>> >          g_array_set_size(tables_blob, legacy_table_size);
>> >      } else {
>> > @@ -2774,9 +2775,9 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>> >          if (tables_blob->len > ACPI_BUILD_TABLE_SIZE / 2) {
>> >              /* As of QEMU 2.1, this fires with 160 VCPUs and 255 memory slots.  */
>> >              warn_report("ACPI tables are larger than 64k.");
>> 
>> The warning text hardcodes the value of ACPI_BUILD_TABLE_SIZE / 2.  Not
>> nice.  Clean up while there?
>> 
>> > -            warn_report("migration may not work.");
>> > +            warn_report("migration may not work");
>> >              warn_report("please remove CPUs, NUMA nodes, "
>> > -                        "memory slots or PCI bridges.");
>> > +                        "memory slots or PCI bridges");
>> 
>> Aha, here's what the user can do.
>> 
>> What about:
>> 
>>                warn_report("ACPI tables are large, migration may not work");
>>                error_printf("Try removing CPUs, NUMA nodes, memory slots"
>>                             " or PCI bridges.");
>> 
>> If we want to show actual size and limit, then this might do instead:
>> 
>>                warn_report("ACPI table size %u exceeds %d bytes,"
>>                            " migration may not work",
>>                            tables_blob->len, ACPI_BUILD_TABLE_SIZE / 2);
>>                error_printf("Try removing CPUs, NUMA nodes, memory slots"
>>                             " or PCI bridges.");
>
> Yep, this suggestion is good for both cases: the check
> (ACPI_BUILD_TABLE_SIZE / 2), and the check for legacy_table_size.
>
>> 
>> >          }
>> >          acpi_align_size(tables_blob, ACPI_BUILD_TABLE_SIZE);
>> >      }
>> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> > index 465e91cc5b..084ca796c2 100644
>> > --- a/hw/i386/pc.c
>> > +++ b/hw/i386/pc.c
>> > @@ -383,8 +383,8 @@ ISADevice *pc_find_fdc0(void)
>> >      if (state.multiple) {
>> >          warn_report("multiple floppy disk controllers with "
>> >                      "iobase=0x3f0 have been found");
>> > -        error_printf("the one being picked for CMOS setup might not reflect "
>> > -                     "your intent\n");
>> > +        warn_report("the one being picked for CMOS setup might not reflect "
>> > +                    "your intent");
>> 
>> Please keep error_printf() here.
>> 
>
> I think I suggested warn_report() here for consistency, because I
> have seen other cases where multiple warn_report() calls were
> used.  We probably want to change those other cases like you
> suggested above.
>
>> >      }
>> >  
>> >      return state.floppy;
>> > @@ -2087,9 +2087,8 @@ static void pc_machine_set_max_ram_below_4g(Object *obj, Visitor *v,
>> >      }
>> >  
>> >      if (value < (1ULL << 20)) {
>> > -        warn_report("small max_ram_below_4g(%"PRIu64
>> > -                    ") less than 1M.  BIOS may not work..",
>> > -                    value);
>> > +        warn_report("max_ram_below_4g (%" PRIu64 ") is less than 1M; "
>> > +                    "BIOS may not work.", value);
>> 
>> The user has no idea what max_ram_below_4g might be.  Suggest:
>> 
>>            warn_report("Only %" PRIu64 " bytes of RAM below the 4GiB boundary,"
>>                        "BIOS may not work with less than 1MiB");
>
> Actually, the user probably knows what it is, because this setter
> will be invoked only if "-M max-ram-below-4g=..." is used in the
> command-line.  We should fix the spelling to "max-ram-below-4g",
> though.
>
>> 
>> >      }
>> >  
>> >      pcms->max_ram_below_4g = value;
>> > diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
>> > index 1653a47f0a..682c576cf1 100644
>> > --- a/hw/i386/pc_q35.c
>> > +++ b/hw/i386/pc_q35.c
>> > @@ -101,8 +101,8 @@ static void pc_q35_init(MachineState *machine)
>> >          lowmem = pcms->max_ram_below_4g;
>> >          if (machine->ram_size - lowmem > lowmem &&
>> >              lowmem & ((1ULL << 30) - 1)) {
>> > -            warn_report("Large machine and max_ram_below_4g(%"PRIu64
>> > -                        ") not a multiple of 1G; possible bad performance.",
>> > +            warn_report("Large machine and max_ram_below_4g (%"PRIu64") not a "
>> > +                        "multiple of 1G; possible bad performance.",
>> 
>> Space between string literal and PRIu64, please.
>> 
>> The user has no idea what max_ram_below_4g might be, [...]
>
> Same as above: the warning should appear only if the user set
> "max-ram-below-4g" explicitly, so the user probably knows what it
> is.
>
>>                                                [...] or what makes the
>> machine "large".
>
> True.
>
>> 
>> >                          pcms->max_ram_below_4g);
>> >          }
>> >      }

Alistair, I suggest I apply just the other six patches for now, and you
improve this patch without undue time pressure.  What do you think?
