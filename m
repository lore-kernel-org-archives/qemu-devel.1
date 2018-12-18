Received: from eggs.gnu.org ([2001:4830:134:3::10]:37486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZ3ue-0005ZL-0x
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 20:11:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZ3uc-0006JV-4f
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 20:11:07 -0500
Date: Mon, 17 Dec 2018 20:10:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181217201034-mutt-send-email-mst@kernel.org>
References: <20181217104838.18957-1-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217104838.18957-1-sameo@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/8] hw: acpi: RSDP fixes and refactoring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, Ben Warren <ben@skyportsystems.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Dec 17, 2018 at 11:48:30AM +0100, Samuel Ortiz wrote:
> This patch serie fixes a couple of RSDP checksum related issues:
> 
> - On RSDP rev2, we are not adding the extended checksum and computing
>   the checksum on the full table instead of the first 20 bytes.
> - On RSDP rev1, we are computing the checksum on 36 bytes instead of 20.
>   We're lucky enough that this is only adding zeroes to the checksum.
> 
> A guest Linux kernel does not seem to care about RSDP checksums, so
> those 2 fixes are mostly for correctness sake.
> Any machine type that generates rev2 RSDP will see its RSDP table
> modified but since x86 builds RSDP v1 and all ACPI tests only run on
> either pc or q35, the ACPI tests tables are not affected by this fix.
> 
> The serie also extends the ARM virt ACPI RSDP build routine to support
> both RSDP v1 and v2, in order to share this code between x86 and
> aarch64. While extending, we also convert the routine to the latest
> build_append_foo() API. The new implementation is a closer reflection of
> the ACPI spec itself, is endian agnostic and allows for getting rid of the
> AcpiRsdpDescriptor structure.


OK I queued this, so we can proceed to do incremental patches on top.

> V3 -> V4:
>   * Add missing Reviewed-Bys from Igor and Andrew.
>   * Removed unneeded white space addition.
>   * Added 16 bytes padding to revision 0 RSDP structures for legacy (2.2
>     and older) machine types.
>   * Fixed a missing break in an ACPI RSDP test switch.
> 
> V2 -> V3:
>   * Add Reviewed-Bys from Igor and Andrew.
>   * Check for valid RSDP and XSDT pointers depending on the revision.
>   * Use RSDP initial table len as offset for checksum and pointer
>     insertion.
>   * Do not explictly pass RSDP revision as the RSDP table parsing test
>     utility.
> 
> v1 -> v2:
>   * Add missing SOBs.
>   * Rephrase some commit messages according to the maintainer's input.
>   * Replace ACPI spec definitions with hard coded constants.
>   * Replace init_rsdp_data() helper with open coded rsdp variable init.
>   * Rename acpi_find_[rx]sdt_address to acpi_get_[rx]sdt_address.
> 
> Igor Mammedov (2):
>   hw: arm: acpi: Fix incorrect checksums in RSDP
>   hw: i386: Use correct RSDT length for checksum
> 
> Samuel Ortiz (6):
>   hw: acpi: The RSDP build API can return void
>   hw: arm: Carry RSDP specific data through AcpiRsdpData
>   hw: arm: Convert the RSDP build to the buid_append_foo() API
>   hw: arm: Support both legacy and current RSDP build
>   hw: acpi: Export and share the ARM RSDP build
>   hw: acpi: Remove AcpiRsdpDescriptor and fix tests
> 
>  include/hw/acpi/acpi-defs.h | 19 ++++-------
>  include/hw/acpi/aml-build.h |  2 ++
>  tests/acpi-utils.h          |  4 ++-
>  hw/acpi/aml-build.c         | 68 +++++++++++++++++++++++++++++++++++++
>  hw/arm/virt-acpi-build.c    | 40 +++++-----------------
>  hw/i386/acpi-build.c        | 46 +++++++++++--------------
>  tests/acpi-utils.c          | 46 ++++++++++++++++++++-----
>  tests/bios-tables-test.c    | 22 +++++++++---
>  tests/vmgenid-test.c        |  8 +++--
>  9 files changed, 168 insertions(+), 87 deletions(-)
> 
> -- 
> 2.19.2
