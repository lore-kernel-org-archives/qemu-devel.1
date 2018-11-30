Received: from eggs.gnu.org ([2001:4830:134:3::10]:55822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gSg3M-0001wI-SF
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 05:29:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gSg3L-0005le-HV
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 05:29:44 -0500
Date: Fri, 30 Nov 2018 11:29:29 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181130112929.238fe26c@redhat.com>
In-Reply-To: <20181129132428.333-1-sameo@linux.intel.com>
References: <20181129132428.333-1-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/8] hw: acpi: RSDP fixes and refactoring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>, "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, 29 Nov 2018 14:24:20 +0100
Samuel Ortiz <sameo@linux.intel.com> wrote:

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

Series needs to fix up minor issues but otherwise it looks good.

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
>  include/hw/acpi/acpi-defs.h | 19 ++++++--------
>  include/hw/acpi/aml-build.h |  2 ++
>  tests/acpi-utils.h          |  5 +++-
>  hw/acpi/aml-build.c         | 50 +++++++++++++++++++++++++++++++++++++
>  hw/arm/virt-acpi-build.c    | 40 +++++++----------------------
>  hw/i386/acpi-build.c        | 36 +++++++-------------------
>  tests/acpi-utils.c          | 46 ++++++++++++++++++++++++++++------
>  tests/bios-tables-test.c    | 27 ++++++++++++++------
>  tests/vmgenid-test.c        |  8 +++---
>  9 files changed, 143 insertions(+), 90 deletions(-)
> 
