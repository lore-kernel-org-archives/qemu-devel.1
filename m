Received: from eggs.gnu.org ([2001:4830:134:3::10]:60495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dDms1-0003qB-JA
	for qemu-devel@nongnu.org; Thu, 25 May 2017 03:07:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dDmrw-000177-Iv
	for qemu-devel@nongnu.org; Thu, 25 May 2017 03:07:41 -0400
Received: from mail-ua0-f170.google.com ([209.85.217.170]:33268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1dDmrw-00016G-Dv
	for qemu-devel@nongnu.org; Thu, 25 May 2017 03:07:36 -0400
Received: by mail-ua0-f170.google.com with SMTP id e28so110407387uah.0
	for <qemu-devel@nongnu.org>; Thu, 25 May 2017 00:07:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170524113835.2276bc0e@nial.brq.redhat.com>
References: <20170524080914.23484-1-lprosek@redhat.com>
	<437f8abb-8d19-f4cd-b92d-9780efa0fe0e@redhat.com>
	<CABdb737srRzOoZT4Usr174yn65rRk4AvM2YEnzs0VjvKRo8BMg@mail.gmail.com>
	<20170524113835.2276bc0e@nial.brq.redhat.com>
From: Ladi Prosek <lprosek@redhat.com>
Date: Thu, 25 May 2017 09:07:35 +0200
Message-ID: <CABdb736_rkKqFyG2UPC+Hvzj_T-OrM1SoDf1g1Epnnt6r7kHjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] pc: ACPI BIOS: use highest NUMA node for
 hotplug mem hole SRAT entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

On Wed, May 24, 2017 at 11:38 AM, Igor Mammedov <imammedo@redhat.com> wrote:
> On Wed, 24 May 2017 11:16:14 +0200
> Ladi Prosek <lprosek@redhat.com> wrote:
>
>> On Wed, May 24, 2017 at 11:07 AM, Laszlo Ersek <lersek@redhat.com> wrote:
>> > On 05/24/17 10:09, Ladi Prosek wrote:
>> >> For reasons unknown, Windows won't online all memory, both at command
>> >> line and hot-plugged later, unless the hotplug mem hole SRAT entry
>> >> specifies a node greater or equal to the ones where memory is added.
>> >
>> > s/greater or equal to/greater *than* or equal to/
>> >
>> > Thanks,
>> > Laszlo
>> > (always finding the important issues! ;) )
>>
>> Haha, thanks! Igor, please let me know if you'd like me to send a
>> corrected version.
> if you are going to respin see for nit below
>
> also could you check that 'make V=1 check' is happy,
> since patch changes SRAT table, bios tables test may fail
> if that happen then please add to commit message
> you can verify that updating reference blobs fixes make check with
> tests/acpi-test-data/rebuild-expected-aml.sh

Yes, a couple of tests print a warning (but still pass) with this
change. Sending v2 now and curious what comes back from patchew this
time :)

> ---
> note to maintainer:
> tests/acpi-test-data need to be updated due to change in SRAT table
>
>>
>> >>
>> >> Using the highest node on the machine makes recent versions of Windows
>> >> happy.
>> >>
>> >> With this example command line:
>> >>   ... \
>> >>   -m 1024,slots=4,maxmem=32G \
>> >>   -numa node,nodeid=0 \
>> >>   -numa node,nodeid=1 \
>> >>   -numa node,nodeid=2 \
>> >>   -numa node,nodeid=3 \
>> >>   -object memory-backend-ram,size=1G,id=mem-mem1 \
>> >>   -device pc-dimm,id=dimm-mem1,memdev=mem-mem1,node=1
>> >>
>> >> Windows reports a total of 1G of RAM without this commit and the expected
>> >> 2G with this commit.
>> >>
>> >> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
>> >> ---
>> >>  hw/i386/acpi-build.c | 7 +++++--
>> >>  1 file changed, 5 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> >> index afcadac..9653583 100644
>> >> --- a/hw/i386/acpi-build.c
>> >> +++ b/hw/i386/acpi-build.c
>> >> @@ -2404,14 +2404,17 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>> >>      }
>> >>
>> >>      /*
>> >> -     * Entry is required for Windows to enable memory hotplug in OS.
>> >> +     * Entry is required for Windows to enable memory hotplug in OS
>> >> +     * and for Linux to enable SWIOTLB even if booted with less than
> s/even if/when/
>
>> >> +     * 4G of RAM. Windows works better if the entry sets proximity
>> >> +     * to the highest NUMA node in the machine.
>> >>       * Memory devices may override proximity set by this entry,
>> >>       * providing _PXM method if necessary.
>> >>       */
>> >>      if (hotplugabble_address_space_size) {
>> >>          numamem = acpi_data_push(table_data, sizeof *numamem);
>> >>          build_srat_memory(numamem, pcms->hotplug_memory.base,
>> >> -                          hotplugabble_address_space_size, 0,
>> >> +                          hotplugabble_address_space_size, pcms->numa_nodes - 1,
>> >>                            MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
>> >>      }
>> >>
>> >>
>> >
>
