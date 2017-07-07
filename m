Received: from eggs.gnu.org ([2001:4830:134:3::10]:60356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dTS1V-0000Bo-MH
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:06:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dTS1S-0007TT-Fx
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:06:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dTS1S-0007T0-5x
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:06:10 -0400
Date: Fri, 7 Jul 2017 09:06:00 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170707120600.GQ12152@localhost.localdomain>
References: <cover.1499381754.git.alistair.francis@xilinx.com>
	<0a1d5638543965d532284bdc6fce391cf9f509d0.1499381754.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a1d5638543965d532284bdc6fce391cf9f509d0.1499381754.git.alistair.francis@xilinx.com>
Subject: Re: [Qemu-devel] [PATCH v1 3/6] Convert error_report() to
 warn_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com, philippe@mathieu-daude.net, berrange@redhat.com, armbru@redhat.com, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>, Josh Durgin <jdurgin@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>, Rob Herring <robh@kernel.org>, Peter Maydell <peter.maydell@linaro.org>, Peter Chubb <peter.chubb@nicta.com.au>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Gerd Hoffmann <kraxel@redhat.com>, Jason Wang <jasowang@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Thu, Jul 06, 2017 at 04:49:44PM -0700, Alistair Francis wrote:
> Convert all uses of error_report("[Ww]arning:"... to use warn_report()
> instead. This helps standardise on a single method of printing warnings
> to the user.
> 
> All of the warnings were found using this regex expression:
>     error_report.*[Ww]arning:
> and replaced with:
>     warn_report("
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Suggested-by: Thomas Huth <thuth@redhat.com>

I have reviewed the changes in: */i386/*, qdev-properties.c,
vl.c, and tests/test-qdev-global-props.c.  They look good, except
for kvm_arch_init_vcpu() below.

There are also a few places below where we could improve the
error messages in a follow-up patch (or in a new version of this
patch if you prefer).

[...]
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 5464977424..6b7bade183 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2766,17 +2766,17 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>                       ACPI_BUILD_ALIGN_SIZE);
>          if (tables_blob->len > legacy_table_size) {
>              /* Should happen only with PCI bridges and -M pc-i440fx-2.0.  */
> -            error_report("Warning: migration may not work.");
> +            warn_report("migration may not work.");

I suggest removing the period.

Adding a justification to why migration may not work is a good
idea, too.  We could copy the messages below (replacing "64k"
with legacy_table_size).


>          }
>          g_array_set_size(tables_blob, legacy_table_size);
>      } else {
>          /* Make sure we have a buffer in case we need to resize the tables. */
>          if (tables_blob->len > ACPI_BUILD_TABLE_SIZE / 2) {
>              /* As of QEMU 2.1, this fires with 160 VCPUs and 255 memory slots.  */
> -            error_report("Warning: ACPI tables are larger than 64k.");
> -            error_report("Warning: migration may not work.");
> -            error_report("Warning: please remove CPUs, NUMA nodes, "
> -                         "memory slots or PCI bridges.");
> +            warn_report("ACPI tables are larger than 64k.");
> +            warn_report("migration may not work.");
> +            warn_report("please remove CPUs, NUMA nodes, "
> +                        "memory slots or PCI bridges.");

I was going to suggest removing the periods here, but I'm not
sure because we have multiple full sentences.

However, if we are going to keep full sentences, I believe we
should use uppercase letters.

>          }
>          acpi_align_size(tables_blob, ACPI_BUILD_TABLE_SIZE);
>      }
> diff --git a/hw/i386/kvm/pci-assign.c b/hw/i386/kvm/pci-assign.c
> index 9f2615cbe0..33e20cb3e8 100644
> --- a/hw/i386/kvm/pci-assign.c
> +++ b/hw/i386/kvm/pci-assign.c
> @@ -1353,9 +1353,9 @@ static int assigned_device_pci_cap_init(PCIDevice *pci_dev, Error **errp)
>                             PCI_CAP_ID_EXP);
>                  return -EINVAL;
>              } else if (size != 0x3c) {
> -                error_report("WARNING, %s: PCIe cap-id 0x%x has "
> -                             "non-standard size 0x%x; std size should be 0x3c",
> -                             __func__, PCI_CAP_ID_EXP, size);
> +                warn_report("%s: PCIe cap-id 0x%x has "
> +                            "non-standard size 0x%x; std size should be 0x3c",
> +                            __func__, PCI_CAP_ID_EXP, size);
>              }
>          } else if (version == 0) {
>              uint16_t vid, did;
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 224fe58fe7..58f8a4f4a5 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -381,8 +381,8 @@ ISADevice *pc_find_fdc0(void)
>      }
>  
>      if (state.multiple) {
> -        error_report("warning: multiple floppy disk controllers with "
> -                     "iobase=0x3f0 have been found");
> +        warn_report("multiple floppy disk controllers with "
> +                    "iobase=0x3f0 have been found");
>          error_printf("the one being picked for CMOS setup might not reflect "
>                       "your intent\n");

The error_printf() on the second line could use warn_report() for
consistency?  In either case, the "\n" needs to be removed.


>      }
> @@ -1310,7 +1310,7 @@ void pc_acpi_init(const char *default_dsdt)
>  
>      filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, default_dsdt);
>      if (filename == NULL) {
> -        fprintf(stderr, "WARNING: failed to find %s\n", default_dsdt);
> +        warn_report("failed to find %s", default_dsdt);
>      } else {
>          QemuOpts *opts = qemu_opts_create(qemu_find_opts("acpi"), NULL, 0,
>                                            &error_abort);
> @@ -2087,9 +2087,9 @@ static void pc_machine_set_max_ram_below_4g(Object *obj, Visitor *v,
>      }
>  
>      if (value < (1ULL << 20)) {
> -        error_report("Warning: small max_ram_below_4g(%"PRIu64
> -                     ") less than 1M.  BIOS may not work..",
> -                     value);
> +        warn_report("small max_ram_below_4g(%"PRIu64
> +                    ") less than 1M.  BIOS may not work..",
> +                    value);

I suggest removing the "..", adding a space before "(", and
possibly removing the word "small".

Maybe we could use the same "<fact>; <possible consequence>."
pattern from the other messages below?  e.g.:

        warn_report("max_ram_below_4g(%" PRIu64 ") is less than 1M; "
                    "BIOS may not work.", value);


>      }
>  
>      pcms->max_ram_below_4g = value;
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 22dbef64c6..11b4336a42 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -131,10 +131,10 @@ static void pc_init1(MachineState *machine,
>                      lowmem = 0xc0000000;
>                  }
>                  if (lowmem & ((1ULL << 30) - 1)) {
> -                    error_report("Warning: Large machine and max_ram_below_4g "
> -                                 "(%" PRIu64 ") not a multiple of 1G; "
> -                                 "possible bad performance.",
> -                                 pcms->max_ram_below_4g);
> +                    warn_report("Large machine and max_ram_below_4g "
> +                                "(%" PRIu64 ") not a multiple of 1G; "
> +                                "possible bad performance.",
> +                                pcms->max_ram_below_4g);
>                  }
>              }
>          }
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 8f696b7cb6..1653a47f0a 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -101,9 +101,9 @@ static void pc_q35_init(MachineState *machine)
>          lowmem = pcms->max_ram_below_4g;
>          if (machine->ram_size - lowmem > lowmem &&
>              lowmem & ((1ULL << 30) - 1)) {
> -            error_report("Warning: Large machine and max_ram_below_4g(%"PRIu64
> -                         ") not a multiple of 1G; possible bad performance.",
> -                         pcms->max_ram_below_4g);
> +            warn_report("Large machine and max_ram_below_4g(%"PRIu64
> +                        ") not a multiple of 1G; possible bad performance.",
> +                        pcms->max_ram_below_4g);

I suggest a space before "(".

>          }
>      }
>  
[...]
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index f84a49d366..3b29f5a758 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -600,10 +600,10 @@ static int kvm_arch_set_tsc_khz(CPUState *cs)
>                         kvm_vcpu_ioctl(cs, KVM_GET_TSC_KHZ) :
>                         -ENOTSUP;
>          if (cur_freq <= 0 || cur_freq != env->tsc_khz) {
> -            error_report("warning: TSC frequency mismatch between "
> -                         "VM (%" PRId64 " kHz) and host (%d kHz), "
> -                         "and TSC scaling unavailable",
> -                         env->tsc_khz, cur_freq);
> +            warn_report("TSC frequency mismatch between "
> +                        "VM (%" PRId64 " kHz) and host (%d kHz), "
> +                        "and TSC scaling unavailable",
> +                        env->tsc_khz, cur_freq);
>              return r;
>          }
>      }
> @@ -919,7 +919,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>                  error_report("kvm: LMCE not supported");
>                  return -ENOTSUP;
>              }
> -            error_report("warning: Unsupported MCG_CAP bits: 0x%" PRIx64,
> +            warn_report(" Unsupported MCG_CAP bits: 0x%" PRIx64,
>                           unsupported_caps);

Extra whitespace here.


>          }
>  
[...]

-- 
Eduardo
