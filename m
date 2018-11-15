Received: from eggs.gnu.org ([2001:4830:134:3::10]:43533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gNHhx-00088S-5C
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:29:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gNHhu-0001YE-PG
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:29:20 -0500
Date: Thu, 15 Nov 2018 14:28:54 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181115142854.1c62f32f@redhat.com>
In-Reply-To: <20181105014047.26447-16-sameo@linux.intel.com>
References: <20181105014047.26447-1-sameo@linux.intel.com>
	<20181105014047.26447-16-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 15/24] hw: i386: Export the i386 ACPI
 SRAT build method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, Richard Henderson <rth@twiddle.net>

On Mon,  5 Nov 2018 02:40:38 +0100
Samuel Ortiz <sameo@linux.intel.com> wrote:

> This is the standard way of building SRAT on x86 platfoms. But future
> machine types could decide to define their own custom SRAT build method
> through the ACPI builder methods.
> Moreover, we will also need to reach build_srat() from outside of
> acpi-build in order to use it as the ACPI builder SRAT build method.
SRAT is usually highly machine specific (memory holes, layout, guest OS
specific quirks) so it's hard to generalize it.

I'd  drop SRAT related patches from this series and introduce
i386/virt specific SRAT when you post patches for it.

What we could generalize here is building blocks used to
create entries into acpi/aml-build.c
   build_srat_memory -> build_srat_memory_entry()
   build_apic_entry()
   build_x2apic_entry()
and please switch these blocks to build_append_int_noprefix() API
before moving them to acpi/aml-build.c

> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> ---
>  hw/i386/acpi-build.h | 5 +++++
>  hw/i386/acpi-build.c | 2 +-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/acpi-build.h b/hw/i386/acpi-build.h
> index 065a1d8250..d73c41fe8f 100644
> --- a/hw/i386/acpi-build.h
> +++ b/hw/i386/acpi-build.h
> @@ -4,6 +4,11 @@
>  
>  #include "hw/acpi/acpi.h"
>  
> +/* ACPI SRAT (Static Resource Affinity Table) build method for x86 */
> +void
> +build_srat(GArray *table_data, BIOSLinker *linker,
> +           MachineState *machine, AcpiConfiguration *acpi_conf);
> +
>  void acpi_setup(MachineState *machine, AcpiConfiguration *acpi_conf);
>  
>  #endif
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 1ef1a38441..673c5dfafc 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1615,7 +1615,7 @@ build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
>  #define HOLE_640K_START  (640 * KiB)
>  #define HOLE_640K_END   (1 * MiB)
>  
> -static void
> +void
>  build_srat(GArray *table_data, BIOSLinker *linker,
>             MachineState *machine, AcpiConfiguration *acpi_conf)
>  {
