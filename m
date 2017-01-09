Received: from eggs.gnu.org ([2001:4830:134:3::10]:43053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cQapt-0002LQ-Ip
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:22:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cQapo-0007rJ-RG
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:22:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:25022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cQapo-0007rA-IL
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:22:04 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BE6C2A794
	for <qemu-devel@nongnu.org>; Mon,  9 Jan 2017 14:22:04 +0000 (UTC)
Date: Mon, 9 Jan 2017 15:22:01 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170109152201.311fdebb@nial.brq.redhat.com>
In-Reply-To: <1480980749-182204-1-git-send-email-imammedo@redhat.com>
References: <1480980749-182204-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9 00/10] pc: acpi: memory hotplug
 cleanup/consolidation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>

On Tue,  6 Dec 2016 00:32:19 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> Series cleanups and consolidates scattered memory hotplug
> code so it could be easily reused by ARM target later.
> 
> As result:
>  * added memory hotplug variant to bios tables test
>  * all ACPI related parts of memory hotplug are consolidated
>    within memory_hotplug.c
>  * DSDT table size is reduced ~900 bytes when memory hotplug
>    is not enabled (by not generating not used AML)
>  * DSDT table size is reduced on 12 bytes per slot
>    (i.e. up to ~3000 bytes savings for 256 DIMMs) with memory hotplug
>    enabled due AML reorganization that makes calls to common functions
>    smaller as devices and common functions are now within the same scope.
> 
> Tested with following guests:
>   - RHEL7.3, WS2008DC, WS2008R2DC, WS2012R2DC, WS2016TP5 - no regressions found
>   - XP3 and WS2003 - boots fine even if memhotplug is enabled (but otherwise
>     it never worked as memhp is not supported there)

Michael,

Marcel's already reviewed this series a while ago could you
pull it in your tree if there aren't any questions?


> Git tree for testing:
>   https://github.com/imammedo/qemu.git memhp_consolidate_v1
> viewing:
>   https://github.com/imammedo/qemu/commits/memhp_consolidate_v1
> 
> Note to maintaner:
>   * blobs patch 2/10 should be merged to patch 1/10
>   * ACPI tables should be regenarated and applied after series is merged
>     as DSDT will cange for all tests cases due removal of inactive
>     memory hotplug code.
> 
> CC: "Michael S. Tsirkin" <mst@redhat.com>
> CC: Eduardo Habkost <ehabkost@redhat.com>
> CC: Marcel Apfelbaum <marcel@redhat.com>
> 
> 
> Igor Mammedov (10):
>   tests: pc: add memory hotplug acpi tables tests
>   tests: pc: acpi: add SRAT and DSDT blobs for memory hotplug variant
>   memhp: move build_memory_hotplug_aml() into memory_hotplug.c
>   memhp: move build_memory_devices() into memory_hotplug.c
>   memhp: consolidate scattered MHPD device declaration
>   memhp: merge build_memory_devices() into build_memory_hotplug_aml()
>   memhp: move GPE handler_E03 into build_memory_hotplug_aml()
>   memhp: move memory hotplug only defines to memory_hotplug.c
>   memhp: don't generate memory hotplug AML if it's not enabled/supported
>   memhp: move DIMM devices into dedicated scope with related common
>     methods
> 
>  include/hw/acpi/memory_hotplug.h    |  12 +-
>  include/hw/acpi/pc-hotplug.h        |  23 --
>  hw/acpi/Makefile.objs               |   2 +-
>  hw/acpi/ich9.c                      |   3 +-
>  hw/acpi/memory_hotplug.c            | 420 +++++++++++++++++++++++++++++++++++-
>  hw/acpi/memory_hotplug_acpi_table.c | 262 ----------------------
>  hw/acpi/piix4.c                     |   3 +-
>  hw/i386/acpi-build.c                | 197 +++--------------
>  tests/acpi-test-data/pc/DSDT.memhp  | Bin 0 -> 6613 bytes
>  tests/acpi-test-data/pc/SRAT.memhp  | Bin 0 -> 224 bytes
>  tests/acpi-test-data/q35/DSDT.memhp | Bin 0 -> 9375 bytes
>  tests/acpi-test-data/q35/SRAT.memhp | Bin 0 -> 224 bytes
>  tests/bios-tables-test.c            |  24 +++
>  13 files changed, 479 insertions(+), 467 deletions(-)
>  delete mode 100644 hw/acpi/memory_hotplug_acpi_table.c
>  create mode 100644 tests/acpi-test-data/pc/DSDT.memhp
>  create mode 100644 tests/acpi-test-data/pc/SRAT.memhp
>  create mode 100644 tests/acpi-test-data/q35/DSDT.memhp
>  create mode 100644 tests/acpi-test-data/q35/SRAT.memhp
> 
