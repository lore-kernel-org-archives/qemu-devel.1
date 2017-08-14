Received: from eggs.gnu.org ([2001:4830:134:3::10]:49948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dhExJ-0006qW-Ny
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 08:58:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dhExF-0001Kn-Pj
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 08:58:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dhExF-0001KV-FA
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 08:58:49 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1501280035.git.alistair.francis@xilinx.com>
	<8ee229215bce0152a94928512507abedea078013.1501280035.git.alistair.francis@xilinx.com>
Date: Mon, 14 Aug 2017 14:58:20 +0200
In-Reply-To: <8ee229215bce0152a94928512507abedea078013.1501280035.git.alistair.francis@xilinx.com>
	(Alistair Francis's message of "Fri, 28 Jul 2017 15:16:36 -0700")
Message-ID: <878timxq4z.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 3/5] Convert single line fprintf() to
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
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, James Hogan <james.hogan@imgtec.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Yongbok Kim <yongbok.kim@imgtec.com>, alistair23@gmail.com, Michael Roth <mdroth@linux.vnet.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

Alistair Francis <alistair.francis@xilinx.com> writes:

> Convert all the single line uses of fprintf(stderr, "warning:"..."\n"...
> to use warn_report() instead. This helps standardise on a single
> method of printing warnings to the user.
>
> All of the warnings were changed using this command:
>   find ./* -type f -exec sed -i \
>     's|fprintf(.*".*warning[,:] \(.*\)\\n"\(.*\));|warn_report("\1"\2);|Ig' \
>     {} +
>
> Some of the lines were manually edited to reduce the line length to below
> 80 charecters.
>
> The #include lines were manually updated to allow the code to compile.
>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
> Cc: James Hogan <james.hogan@imgtec.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Yongbok Kim <yongbok.kim@imgtec.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>
>  block/vvfat.c              | 4 +++-
>  hw/acpi/core.c             | 3 ++-
>  hw/i386/pc.c               | 2 +-
>  hw/misc/applesmc.c         | 2 +-
>  hw/usb/hcd-ehci.c          | 5 +++--
>  hw/virtio/virtio-balloon.c | 3 ++-
>  net/hub.c                  | 3 ++-
>  net/socket.c               | 7 +++++--
>  qga/vss-win32.c            | 2 +-
>  target/mips/kvm.c          | 4 ++--
>  trace/simple.c             | 2 +-
>  ui/keymaps.c               | 2 +-
>  ui/spice-display.c         | 2 +-
>  13 files changed, 25 insertions(+), 16 deletions(-)
>
> diff --git a/block/vvfat.c b/block/vvfat.c
> index a9e207f7f0..d682f0a9dc 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -32,6 +32,7 @@
>  #include "qapi/qmp/qbool.h"
>  #include "qapi/qmp/qstring.h"
>  #include "qemu/cutils.h"
> +#include "qemu/error-report.h"
>  
>  #ifndef S_IWGRP
>  #define S_IWGRP 0
> @@ -3028,7 +3029,8 @@ DLOG(checkpoint());
>                          if (memcmp(direntries + k,
>                                      array_get(&(s->directory), dir_index + k),
>                                      sizeof(direntry_t))) {
> -                            fprintf(stderr, "Warning: tried to write to write-protected file\n");
> +                            warn_report("tried to write to write-protected "
> +                                        "file");
>                              return -1;
>                          }
>                      }
> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> index 95fcac95a2..2a1b79c838 100644
> --- a/hw/acpi/core.c
> +++ b/hw/acpi/core.c
> @@ -28,6 +28,7 @@
>  #include "qapi/opts-visitor.h"
>  #include "qapi-visit.h"
>  #include "qapi-event.h"
> +#include "qemu/error-report.h"
>  
>  struct acpi_table_header {
>      uint16_t _length;         /* our length, not actual part of the hdr */
> @@ -221,7 +222,7 @@ static void acpi_table_install(const char unsigned *blob, size_t bloblen,
>      }
>  
>      if (!has_header && changed_fields == 0) {
> -        fprintf(stderr, "warning: ACPI table: no headers are specified\n");
> +        warn_report("ACPI table: no headers are specified");
>      }
>  
>      /* recalculate checksum */
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index a67440f2a1..2f4ba4cd4f 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1310,7 +1310,7 @@ void pc_acpi_init(const char *default_dsdt)
>  
>      filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, default_dsdt);
>      if (filename == NULL) {
> -        fprintf(stderr, "WARNING: failed to find %s\n", default_dsdt);
> +        warn_report("failed to find %s", default_dsdt);
>      } else {
>          QemuOpts *opts = qemu_opts_create(qemu_find_opts("acpi"), NULL, 0,
>                                            &error_abort);
> diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
> index 7896812304..7be8b5f13c 100644
> --- a/hw/misc/applesmc.c
> +++ b/hw/misc/applesmc.c
> @@ -331,7 +331,7 @@ static void applesmc_isa_realize(DeviceState *dev, Error **errp)
>                          s->iobase + APPLESMC_ERR_PORT);
>  
>      if (!s->osk || (strlen(s->osk) != 64)) {
> -        fprintf(stderr, "WARNING: Using AppleSMC with invalid key\n");
> +        warn_report("Using AppleSMC with invalid key");
>          s->osk = default_osk;
>      }
>  
> diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
> index 604912cb3e..46fd30b075 100644
> --- a/hw/usb/hcd-ehci.c
> +++ b/hw/usb/hcd-ehci.c
> @@ -32,6 +32,7 @@
>  #include "hw/usb/ehci-regs.h"
>  #include "hw/usb/hcd-ehci.h"
>  #include "trace.h"
> +#include "qemu/error-report.h"
>  
>  #define FRAME_TIMER_FREQ 1000
>  #define FRAME_TIMER_NS   (NANOSECONDS_PER_SECOND / FRAME_TIMER_FREQ)
> @@ -348,7 +349,7 @@ static void ehci_trace_sitd(EHCIState *s, hwaddr addr,
>  static void ehci_trace_guest_bug(EHCIState *s, const char *message)
>  {
>      trace_usb_ehci_guest_bug(message);
> -    fprintf(stderr, "ehci warning: %s\n", message);
> +    warn_report("%s", message);
>  }
>  
>  static inline bool ehci_enabled(EHCIState *s)
> @@ -1728,7 +1729,7 @@ static int ehci_state_fetchsitd(EHCIState *ehci, int async)
>          /* siTD is not active, nothing to do */;
>      } else {
>          /* TODO: split transfers are not implemented */
> -        fprintf(stderr, "WARNING: Skipping active siTD\n");
> +        warn_report("Skipping active siTD");
>      }
>  
>      ehci_set_fetch_addr(ehci, async, sitd.next);
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index a705e0ec55..37cde38982 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -26,6 +26,7 @@
>  #include "qapi/visitor.h"
>  #include "qapi-event.h"
>  #include "trace.h"
> +#include "qemu/error-report.h"
>  
>  #include "hw/virtio/virtio-bus.h"
>  #include "hw/virtio/virtio-access.h"
> @@ -292,7 +293,7 @@ static void virtio_balloon_receive_stats(VirtIODevice *vdev, VirtQueue *vq)
>      s->stats_vq_offset = offset;
>  
>      if (qemu_gettimeofday(&tv) < 0) {
> -        fprintf(stderr, "warning: %s: failed to get time of day\n", __func__);
> +        warn_report("%s: failed to get time of day", __func__);

__func__ in error messages is an anti-pattern: if you need the function
name (and thus a developer) to make sense of the message, then it's
pretty bad.

>          goto out;
>      }
>  
> diff --git a/net/hub.c b/net/hub.c
> index 32d8cf5cd4..afe941ae7a 100644
> --- a/net/hub.c
> +++ b/net/hub.c
> @@ -18,6 +18,7 @@
>  #include "clients.h"
>  #include "hub.h"
>  #include "qemu/iov.h"
> +#include "qemu/error-report.h"
>  
>  /*
>   * A hub broadcasts incoming packets to all its ports except the source port.
> @@ -330,7 +331,7 @@ void net_hub_check_clients(void)
>              }
>          }
>          if (has_host_dev && !has_nic) {
> -            fprintf(stderr, "Warning: vlan %d with no nics\n", hub->id);
> +            warn_report("vlan %d with no nics", hub->id);
>          }
>          if (has_nic && !has_host_dev) {
>              fprintf(stderr,
> diff --git a/net/socket.c b/net/socket.c
> index f85ef7d61b..354f967769 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -449,8 +449,11 @@ static NetSocketState *net_socket_fd_init(NetClientState *peer,
>      case SOCK_STREAM:
>          return net_socket_fd_init_stream(peer, model, name, fd, is_connected);
>      default:
> -        /* who knows ... this could be a eg. a pty, do warn and continue as stream */
> -        fprintf(stderr, "qemu: warning: socket type=%d for fd=%d is not SOCK_DGRAM or SOCK_STREAM\n", so_type, fd);
> +        /* who knows ... this could be a eg. a pty, do warn and continue as
> +         * stream
> +         */
> +        warn_report("socket type=%d for fd=%d is not SOCK_DGRAM or "
> +                    "SOCK_STREAM", so_type, fd);
>          return net_socket_fd_init_stream(peer, model, name, fd, is_connected);
>      }
>      return NULL;

This is going to conflict with "[PATCH v8 1/4] net/socket: Don't treat
odd socket type as SOCK_STREAM", just queued by Jason, but the conflict
should be trivial to resolve.

> diff --git a/qga/vss-win32.c b/qga/vss-win32.c
> index a80933c98b..b748b9ff57 100644
> --- a/qga/vss-win32.c
> +++ b/qga/vss-win32.c
> @@ -61,7 +61,7 @@ static bool vss_check_os_version(void)
>              return false;
>          }
>          if (wow64) {
> -            fprintf(stderr, "Warning: Running under WOW64\n");
> +            warn_report("Running under WOW64");
>          }
>  #endif
>          return !wow64;
> diff --git a/target/mips/kvm.c b/target/mips/kvm.c
> index 3317905e71..a23aa438d2 100644
> --- a/target/mips/kvm.c
> +++ b/target/mips/kvm.c
> @@ -95,11 +95,11 @@ void kvm_mips_reset_vcpu(MIPSCPU *cpu)
>      CPUMIPSState *env = &cpu->env;
>  
>      if (!kvm_mips_fpu_cap && env->CP0_Config1 & (1 << CP0C1_FP)) {
> -        fprintf(stderr, "Warning: KVM does not support FPU, disabling\n");
> +        warn_report("KVM does not support FPU, disabling");
>          env->CP0_Config1 &= ~(1 << CP0C1_FP);
>      }
>      if (!kvm_mips_msa_cap && env->CP0_Config3 & (1 << CP0C3_MSAP)) {
> -        fprintf(stderr, "Warning: KVM does not support MSA, disabling\n");
> +        warn_report("KVM does not support MSA, disabling");
>          env->CP0_Config3 &= ~(1 << CP0C3_MSAP);
>      }
>  
> diff --git a/trace/simple.c b/trace/simple.c
> index a221a3f703..003db00229 100644
> --- a/trace/simple.c
> +++ b/trace/simple.c
> @@ -405,7 +405,7 @@ bool st_init(void)
>  
>      thread = trace_thread_create(writeout_thread);
>      if (!thread) {
> -        fprintf(stderr, "warning: unable to initialize simple trace backend\n");
> +        warn_report("unable to initialize simple trace backend");
>          return false;
>      }
>  

Hmm, why is failure to initialize only a warning?  Aha: the only caller
is trace_init_backends():

    bool trace_init_backends(void)
    {
    #ifdef CONFIG_TRACE_SIMPLE
        if (!st_init()) {
            fprintf(stderr, "failed to initialize simple tracing backend.\n");
            return false;
        }
    #endif
    [...]
    }

which is universally called like this:

    if (!trace_init_backends()) {
        exit(1);
    }

In other words, it's always a fatal error, and reported like this:

    warning: unable to initialize simple trace backend
    failed to initialize simple tracing backend.

Your patch changes it to something like

    qemu-system-x86_64: warning: unable to initialize simple trace backend
    failed to initialize simple tracing backend.

An improvement of sorts.

> diff --git a/ui/keymaps.c b/ui/keymaps.c
> index fa00b82027..7fa21f81b2 100644
> --- a/ui/keymaps.c
> +++ b/ui/keymaps.c
> @@ -141,7 +141,7 @@ static kbd_layout_t *parse_keyboard_layout(const name2keysym_t *table,
>                  int keysym;
>                  keysym = get_keysym(table, keyname);
>                  if (keysym == 0) {
> -                    /* fprintf(stderr, "Warning: unknown keysym %s\n", line);*/
> +                    /* warn_report("unknown keysym %s", line);*/
>                  } else {
>                      const char *rest = line + offset + 1;
>                      int keycode = strtol(rest, NULL, 0);

Blech.  The maintainer of this file should make up his mind whether the
condition is worth a warning, a tracepoint, or nothing.

> diff --git a/ui/spice-display.c b/ui/spice-display.c
> index 042292cc90..0963c7825f 100644
> --- a/ui/spice-display.c
> +++ b/ui/spice-display.c
> @@ -850,7 +850,7 @@ static void qemu_spice_gl_unblock_bh(void *opaque)
>  
>  static void qemu_spice_gl_block_timer(void *opaque)
>  {
> -    fprintf(stderr, "WARNING: spice: no gl-draw-done within one second\n");
> +    warn_report("spice: no gl-draw-done within one second");
>  }
>  
>  static void spice_gl_refresh(DisplayChangeListener *dcl)

As for PATCH v1 2/5, the things I hate all predate your patch, so
Reviewed-by: Markus Armbruster <armbru@redhat.com>
