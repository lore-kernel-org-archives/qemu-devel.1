Received: from eggs.gnu.org ([2001:4830:134:3::10]:60447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dhFSd-00088x-By
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 09:31:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dhFSZ-0006x2-NC
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 09:31:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:7401)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dhFSZ-0006wB-E5
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 09:31:11 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1501280035.git.alistair.francis@xilinx.com>
	<13edc53da08b5fb065eccb8f658bad0526a252b1.1501280035.git.alistair.francis@xilinx.com>
Date: Mon, 14 Aug 2017 15:30:59 +0200
In-Reply-To: <13edc53da08b5fb065eccb8f658bad0526a252b1.1501280035.git.alistair.francis@xilinx.com>
	(Alistair Francis's message of "Fri, 28 Jul 2017 15:16:39 -0700")
Message-ID: <87zib2wa24.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 4/5] Convert multi-line fprintf() to
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
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Max Reitz <mreitz@redhat.com>, Yongbok Kim <yongbok.kim@imgtec.com>, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, alistair23@gmail.com, Christian Borntraeger <borntraeger@de.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

Alistair Francis <alistair.francis@xilinx.com> writes:

> Convert all the multi-line uses of fprintf(stderr, "warning:"..."\n"...
> to use warn_report() instead. This helps standardise on a single
> method of printing warnings to the user.
>
> All of the warnings were changed using these commands:
>   find ./* -type f -exec sed -i \
>     'N; {s|fprintf(.*".*warning[,:] \(.*\)\\n"\(.*\));|warn_report("\1"\2);|Ig}' \
>     {} +
>   find ./* -type f -exec sed -i \
>     'N;N; {s|fprintf(.*".*warning[,:] \(.*\)\\n"\(.*\));|warn_report("\1"\2);|Ig}' \
>     {} +
>   find ./* -type f -exec sed -i \
>     'N;N;N; {s|fprintf(.*".*warning[,:] \(.*\)\\n"\(.*\));|warn_report("\1"\2);|Ig}' \
>     {} +
>   find ./* -type f -exec sed -i \
>     'N;N;N;N {s|fprintf(.*".*warning[,:] \(.*\)\\n"\(.*\));|warn_report("\1"\2);|Ig}' \
>     {} +
>   find ./* -type f -exec sed -i \
>     'N;N;N;N;N {s|fprintf(.*".*warning[,:] \(.*\)\\n"\(.*\));|warn_report("\1"\2);|Ig}' \
>     {} +
>   find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N {s|fprintf(.*".*warning[,:] \(.*\)\\n"\(.*\));|warn_report("\1"\2);|Ig}' \
>     {} +
>   find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N; {s|fprintf(.*".*warning[,:] \(.*\)\\n"\(.*\));|warn_report("\1"\2);|Ig}' \
>     {} +
>
> Indentation fixed up manually afterwards.
>
> Some of the lines were manually edited to reduce the line length to below
> 80 charecters. Some of the lines with newlines in the middle of the
> string were also manually edit to avoid checkpatch errrors.
>
> The #include lines were manually updated to allow the code to compile.
>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Yongbok Kim <yongbok.kim@imgtec.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Acked-by: Cornelia Huck <cohuck@redhat.com>
> ---
> I couldn't figure out any nice way (it is possible with some more logic
> inside the sed apparently) to do this is one command, so I had to use
> all of the commands above.

There's coccinelle, but swinging that hammer successfully requires
crawling up its learning curve.

>  accel/kvm/kvm-all.c         |  7 +++----
>  block/vvfat.c               |  4 ++--
>  hw/acpi/core.c              |  7 +++----
>  hw/arm/vexpress.c           |  4 ++--
>  hw/i386/xen/xen-mapcache.c  |  4 ++--
>  hw/mips/mips_malta.c        |  4 ++--
>  hw/mips/mips_r4k.c          |  6 +++---
>  hw/s390x/s390-virtio.c      | 16 ++++++++--------
>  net/hub.c                   |  9 ++++-----
>  net/net.c                   | 14 +++++++-------
>  target/i386/cpu.c           | 12 ++++++------
>  target/i386/hax-mem.c       |  6 +++---
>  target/ppc/translate_init.c | 18 +++++++++---------
>  ui/keymaps.c                |  9 +++++----
>  util/main-loop.c            |  6 +++---
>  15 files changed, 62 insertions(+), 64 deletions(-)
>
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 46ce479dc3..03e26e5a07 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -1629,10 +1629,9 @@ static int kvm_init(MachineState *ms)
>  
>      while (nc->name) {
>          if (nc->num > soft_vcpus_limit) {
> -            fprintf(stderr,
> -                    "Warning: Number of %s cpus requested (%d) exceeds "
> -                    "the recommended cpus supported by KVM (%d)\n",
> -                    nc->name, nc->num, soft_vcpus_limit);
> +            warn_report("Number of %s cpus requested (%d) exceeds "
> +                        "the recommended cpus supported by KVM (%d)",
> +                        nc->name, nc->num, soft_vcpus_limit);
>  
>              if (nc->num > hard_vcpus_limit) {
>                  fprintf(stderr, "Number of %s cpus requested (%d) exceeds "
> diff --git a/block/vvfat.c b/block/vvfat.c
> index d682f0a9dc..04801f3136 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -1227,8 +1227,8 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
>  
>      switch (s->fat_type) {
>      case 32:
> -            fprintf(stderr, "Big fat greek warning: FAT32 has not been tested. "
> -                "You are welcome to do so!\n");
> +        warn_report("FAT32 has not been tested. "
> +                    "You are welcome to do so!");
>          break;
>      case 16:
>      case 12:
> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> index 2a1b79c838..cd0a1d357b 100644
> --- a/hw/acpi/core.c
> +++ b/hw/acpi/core.c
> @@ -184,10 +184,9 @@ static void acpi_table_install(const char unsigned *blob, size_t bloblen,
>      }
>  
>      if (has_header && le32_to_cpu(ext_hdr->length) != acpi_payload_size) {
> -        fprintf(stderr,
> -                "warning: ACPI table has wrong length, header says "
> -                "%" PRIu32 ", actual size %zu bytes\n",
> -                le32_to_cpu(ext_hdr->length), acpi_payload_size);
> +        warn_report("ACPI table has wrong length, header says "
> +                    "%" PRIu32 ", actual size %zu bytes",
> +                    le32_to_cpu(ext_hdr->length), acpi_payload_size);
>      }
>      ext_hdr->length = cpu_to_le32(acpi_payload_size);
>  
> diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
> index 528c65ddb6..2445eb4408 100644
> --- a/hw/arm/vexpress.c
> +++ b/hw/arm/vexpress.c
> @@ -491,8 +491,8 @@ static void vexpress_modify_dtb(const struct arm_boot_info *info, void *fdt)
>          /* Not fatal, we just won't provide virtio. This will
>           * happen with older device tree blobs.
>           */
> -        fprintf(stderr, "QEMU: warning: couldn't find interrupt controller in "
> -                "dtb; will not include virtio-mmio devices in the dtb.\n");
> +        warn_report("couldn't find interrupt controller in "
> +                    "dtb; will not include virtio-mmio devices in the dtb.");

Drop the period, please.

>      } else {
>          int i;
>          const hwaddr *map = daughterboard->motherboard_map;
> diff --git a/hw/i386/xen/xen-mapcache.c b/hw/i386/xen/xen-mapcache.c
> index 369c3df8a0..3985a92f02 100644
> --- a/hw/i386/xen/xen-mapcache.c
> +++ b/hw/i386/xen/xen-mapcache.c
> @@ -125,8 +125,8 @@ void xen_map_cache_init(phys_offset_to_gaddr_t f, void *opaque)
>          rlimit_as.rlim_cur = rlimit_as.rlim_max;
>  
>          if (rlimit_as.rlim_max != RLIM_INFINITY) {
> -            fprintf(stderr, "Warning: QEMU's maximum size of virtual"
> -                    " memory is not infinity.\n");
> +            warn_report("QEMU's maximum size of virtual"
> +                        " memory is not infinity.");

Likewise.

>          }
>          if (rlimit_as.rlim_max < MCACHE_MAX_SIZE + NON_MCACHE_MEMORY_SIZE) {
>              mapcache->max_mcache_size = rlimit_as.rlim_max -
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 8ecd544baa..4fb6dfdf74 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -216,8 +216,8 @@ static void generate_eeprom_spd(uint8_t *eeprom, ram_addr_t ram_size)
>      }
>  
>      if (ram_size) {
> -        fprintf(stderr, "Warning: SPD cannot represent final %dMB"
> -                " of SDRAM\n", (int)ram_size);
> +        warn_report("SPD cannot represent final %dMB"
> +                    " of SDRAM", (int)ram_size);
>      }

Not your patch's fault, but here goes anyway: ram_addr_t ram_size should
be printed with "0x" RAM_ADDR_FMT.

If you consider RAM_ADDR_FMT too ugly to bear (I sympathize; including
the '%' in the macro shows lack of taste), you can perhaps get away with
%lld and (long long)ram_size.

>  
>      /* fill in SPD memory information */
> diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
> index 2f5ced7409..6ffb88fd70 100644
> --- a/hw/mips/mips_r4k.c
> +++ b/hw/mips/mips_r4k.c
> @@ -253,9 +253,9 @@ void mips_r4k_init(MachineState *machine)
>              fprintf(stderr, "qemu: Error registering flash memory.\n");
>  	}
>      } else if (!qtest_enabled()) {
> -	/* not fatal */
> -        fprintf(stderr, "qemu: Warning, could not load MIPS bios '%s'\n",
> -		bios_name);
> +        /* not fatal */
> +        warn_report("could not load MIPS bios '%s'",
> +                    bios_name);

Could be one line.

>      }
>      g_free(filename);
>  
> diff --git a/hw/s390x/s390-virtio.c b/hw/s390x/s390-virtio.c
> index afa4148e6b..964df517b4 100644
> --- a/hw/s390x/s390-virtio.c
> +++ b/hw/s390x/s390-virtio.c
> @@ -146,9 +146,9 @@ void gtod_save(QEMUFile *f, void *opaque)
>  
>      r = s390_get_clock(&tod_high, &tod_low);
>      if (r) {
> -        fprintf(stderr, "WARNING: Unable to get guest clock for migration. "
> -                        "Error code %d. Guest clock will not be migrated "
> -                        "which could cause the guest to hang.\n", r);
> +        warn_report("Unable to get guest clock for migration. "
> +                    "Error code %d. Guest clock will not be migrated "
> +                    "which could cause the guest to hang.", r);

Not your patch's fault, but here goes anyway: multiple sentences in an
error message are an anti-pattern.  Printing errno codes with %d is
another one.  Better:

           warn_report("Unable to get guest clock for migration: %s",
                       strerror(-r));
           error_printf("Guest clock will not be migrated "
                        "which could cause the guest to hang.");

More of the same below.

>          qemu_put_byte(f, S390_TOD_CLOCK_VALUE_MISSING);
>          return;
>      }
> @@ -165,8 +165,8 @@ int gtod_load(QEMUFile *f, void *opaque, int version_id)
>      int r;
>  
>      if (qemu_get_byte(f) == S390_TOD_CLOCK_VALUE_MISSING) {
> -        fprintf(stderr, "WARNING: Guest clock was not migrated. This could "
> -                        "cause the guest to hang.\n");
> +        warn_report("Guest clock was not migrated. This could "
> +                    "cause the guest to hang.");
>          return 0;
>      }
>  
> @@ -175,9 +175,9 @@ int gtod_load(QEMUFile *f, void *opaque, int version_id)
>  
>      r = s390_set_clock(&tod_high, &tod_low);
>      if (r) {
> -        fprintf(stderr, "WARNING: Unable to set guest clock value. "
> -                        "s390_get_clock returned error %d. This could cause "
> -                        "the guest to hang.\n", r);
> +        warn_report("Unable to set guest clock value. "
> +                    "s390_get_clock returned error %d. This could cause "
> +                    "the guest to hang.", r);
>      }
>  
>      return 0;
> diff --git a/net/hub.c b/net/hub.c
> index afe941ae7a..745a2168a1 100644
> --- a/net/hub.c
> +++ b/net/hub.c
> @@ -310,8 +310,8 @@ void net_hub_check_clients(void)
>          QLIST_FOREACH(port, &hub->ports, next) {
>              peer = port->nc.peer;
>              if (!peer) {
> -                fprintf(stderr, "Warning: hub port %s has no peer\n",
> -                        port->nc.name);
> +                warn_report("hub port %s has no peer",
> +                            port->nc.name);
>                  continue;
>              }
>  
> @@ -334,9 +334,8 @@ void net_hub_check_clients(void)
>              warn_report("vlan %d with no nics", hub->id);
>          }
>          if (has_nic && !has_host_dev) {
> -            fprintf(stderr,
> -                    "Warning: vlan %d is not connected to host network\n",
> -                    hub->id);
> +            warn_report("vlan %d is not connected to host network",
> +                        hub->id);
>          }
>      }
>  }
> diff --git a/net/net.c b/net/net.c
> index 0e28099554..45ab2a1a02 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -1481,9 +1481,9 @@ void net_check_clients(void)
>  
>      QTAILQ_FOREACH(nc, &net_clients, next) {
>          if (!nc->peer) {
> -            fprintf(stderr, "Warning: %s %s has no peer\n",
> -                    nc->info->type == NET_CLIENT_DRIVER_NIC ?
> -                    "nic" : "netdev", nc->name);
> +            warn_report("%s %s has no peer",
> +                        nc->info->type == NET_CLIENT_DRIVER_NIC ?
> +                        "nic" : "netdev", nc->name);

Opportunity to clean up the tasteless line break in the middle of an
argument expression:

               warn_report("%s %s has no peer",
                           nc->info->type == NET_CLIENT_DRIVER_NIC
                           ? "nic" : "netdev",
                           nc->name);

>          }
>      }
>  
> @@ -1494,10 +1494,10 @@ void net_check_clients(void)
>      for (i = 0; i < MAX_NICS; i++) {
>          NICInfo *nd = &nd_table[i];
>          if (nd->used && !nd->instantiated) {
> -            fprintf(stderr, "Warning: requested NIC (%s, model %s) "
> -                    "was not created (not supported by this machine?)\n",
> -                    nd->name ? nd->name : "anonymous",
> -                    nd->model ? nd->model : "unspecified");
> +            warn_report("requested NIC (%s, model %s) "
> +                        "was not created (not supported by this machine?)",
> +                        nd->name ? nd->name : "anonymous",
> +                        nd->model ? nd->model : "unspecified");
>          }
>      }
>  }
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index ddc45abd70..8c9ec7da0f 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1722,12 +1722,12 @@ static void report_unavailable_features(FeatureWord w, uint32_t mask)
>          if ((1UL << i) & mask) {
>              const char *reg = get_register_name_32(f->cpuid_reg);
>              assert(reg);
> -            fprintf(stderr, "warning: %s doesn't support requested feature: "
> -                "CPUID.%02XH:%s%s%s [bit %d]\n",
> -                kvm_enabled() ? "host" : "TCG",
> -                f->cpuid_eax, reg,
> -                f->feat_names[i] ? "." : "",
> -                f->feat_names[i] ? f->feat_names[i] : "", i);
> +            warn_report("%s doesn't support requested feature: "
> +                        "CPUID.%02XH:%s%s%s [bit %d]",
> +                        kvm_enabled() ? "host" : "TCG",
> +                        f->cpuid_eax, reg,
> +                        f->feat_names[i] ? "." : "",
> +                        f->feat_names[i] ? f->feat_names[i] : "", i);
>          }
>      }
>  }
> diff --git a/target/i386/hax-mem.c b/target/i386/hax-mem.c
> index af090343f3..756f2dd268 100644
> --- a/target/i386/hax-mem.c
> +++ b/target/i386/hax-mem.c
> @@ -178,9 +178,9 @@ static void hax_process_section(MemoryRegionSection *section, uint8_t flags)
>      if (!memory_region_is_ram(mr)) {
>          if (memory_region_is_romd(mr)) {
>              /* HAXM kernel module does not support ROMD yet  */
> -            fprintf(stderr, "%s: Warning: Ignoring ROMD region 0x%016" PRIx64
> -                    "->0x%016" PRIx64 "\n", __func__, start_pa,
> -                    start_pa + size);
> +            warn_report("Ignoring ROMD region 0x%016" PRIx64
> +                        "->0x%016" PRIx64 "", __func__, start_pa,
> +                        start_pa + size);

__func__ again.  Not your patch's fault.

>          }
>          return;
>      }
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 01723bdfec..a6f02f3c45 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -9215,14 +9215,14 @@ static void init_ppc_proc(PowerPCCPU *cpu)
>          env->tlb_per_way = env->nb_tlb / env->nb_ways;
>      }
>      if (env->irq_inputs == NULL) {
> -        fprintf(stderr, "WARNING: no internal IRQ controller registered.\n"
> -                " Attempt QEMU to crash very soon !\n");
> +        warn_report("no internal IRQ controller registered."
> +                    " Attempt QEMU to crash very soon !");
>      }
>  #endif
>      if (env->check_pow == NULL) {
> -        fprintf(stderr, "WARNING: no power management check handler "
> -                "registered.\n"
> -                " Attempt QEMU to crash very soon !\n");
> +        warn_report("no power management check handler "
> +                    "registered."
> +                    " Attempt QEMU to crash very soon !");
>      }
>  }
>  
> @@ -9776,10 +9776,10 @@ static int ppc_fixup_cpu(PowerPCCPU *cpu)
>       * tree. */
>      if ((env->insns_flags & ~PPC_TCG_INSNS)
>          || (env->insns_flags2 & ~PPC_TCG_INSNS2)) {
> -        fprintf(stderr, "Warning: Disabling some instructions which are not "
> -                "emulated by TCG (0x%" PRIx64 ", 0x%" PRIx64 ")\n",
> -                env->insns_flags & ~PPC_TCG_INSNS,
> -                env->insns_flags2 & ~PPC_TCG_INSNS2);
> +        warn_report("Disabling some instructions which are not "
> +                    "emulated by TCG (0x%" PRIx64 ", 0x%" PRIx64 ")",
> +                    env->insns_flags & ~PPC_TCG_INSNS,
> +                    env->insns_flags2 & ~PPC_TCG_INSNS2);
>      }
>      env->insns_flags &= PPC_TCG_INSNS;
>      env->insns_flags2 &= PPC_TCG_INSNS2;
> diff --git a/ui/keymaps.c b/ui/keymaps.c
> index 7fa21f81b2..a6cefdaff9 100644
> --- a/ui/keymaps.c
> +++ b/ui/keymaps.c
> @@ -26,6 +26,7 @@
>  #include "keymaps.h"
>  #include "sysemu/sysemu.h"
>  #include "trace.h"
> +#include "qemu/error-report.h"
>  
>  static int get_keysym(const name2keysym_t *table,
>                        const char *name)
> @@ -76,8 +77,8 @@ static void add_keysym(char *line, int keysym, int keycode, kbd_layout_t *k) {
>          k->keysym2keycode[keysym] = keycode;
>      } else {
>          if (k->extra_count >= MAX_EXTRA_COUNT) {
> -            fprintf(stderr, "Warning: Could not assign keysym %s (0x%x)"
> -                    " because of memory constraints.\n", line, keysym);
> +            warn_report("Could not assign keysym %s (0x%x)"
> +                        " because of memory constraints.", line, keysym);
>          } else {
>              trace_keymap_add("extra", keysym, keycode, line);
>              k->keysym2keycode_extra[k->extra_count].
> @@ -197,8 +198,8 @@ int keysym2scancode(void *kbd_layout, int keysym)
>      if (keysym < MAX_NORMAL_KEYCODE) {
>          if (k->keysym2keycode[keysym] == 0) {
>              trace_keymap_unmapped(keysym);
> -            fprintf(stderr, "Warning: no scancode found for keysym %d\n",
> -                    keysym);
> +            warn_report("no scancode found for keysym %d",
> +                        keysym);
>          }
>          return k->keysym2keycode[keysym];
>      } else {
> diff --git a/util/main-loop.c b/util/main-loop.c
> index 2f48f41e62..7558eb5f53 100644
> --- a/util/main-loop.c
> +++ b/util/main-loop.c
> @@ -32,6 +32,7 @@
>  #include "slirp/libslirp.h"
>  #include "qemu/main-loop.h"
>  #include "block/aio.h"
> +#include "qemu/error-report.h"
>  
>  #ifndef _WIN32
>  
> @@ -236,9 +237,8 @@ static int os_host_main_loop_wait(int64_t timeout)
>          static bool notified;
>  
>          if (!notified && !qtest_enabled() && !qtest_driver()) {
> -            fprintf(stderr,
> -                    "main-loop: WARNING: I/O thread spun for %d iterations\n",
> -                    MAX_MAIN_LOOP_SPIN);
> +            warn_report("I/O thread spun for %d iterations",
> +                        MAX_MAIN_LOOP_SPIN);
>              notified = true;
>          }

Drop the periods from the warning messages, and you may add
Reviewed-by: Markus Armbruster <armbru@redhat.com>

I encourage you to also use the opportunity to improve line breaks.

I'm not asking you to fix the other issues with the messages.
