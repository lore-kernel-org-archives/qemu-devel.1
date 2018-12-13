Received: from eggs.gnu.org ([2001:4830:134:3::10]:34839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gXQsz-0001QZ-NY
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 08:18:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gXQss-0002ox-NX
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 08:18:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gXQss-0002o5-BP
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 08:18:34 -0500
References: <1544684731-18828-1-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9be7ef6d-15b2-6e82-7beb-aeb287b50c3b@redhat.com>
Date: Thu, 13 Dec 2018 14:18:22 +0100
MIME-Version: 1.0
In-Reply-To: <1544684731-18828-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu-options: Remove deprecated
 "-virtioconsole" option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Amit Shah <amit@kernel.org>, qemu-devel@nongnu.org
Cc: libvir-list@redhat.com

On 13/12/18 08:05, Thomas Huth wrote:
> It's been deprecated since QEMU 3.0, and nobody complained so far, so
> it is time to remove this option now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Queued (for the next pull request, not this one).  It made sense for
s390 before the sclp{,lm}console was connected to -serial, but not
anymore.  Thanks,

Paolo
> ---
>  docs/qdev-device-use.txt |  4 ----
>  include/hw/boards.h      |  1 -
>  qemu-deprecated.texi     |  5 ----
>  qemu-options.hx          | 10 --------
>  vl.c                     | 61 +-----------------------------------------------
>  5 files changed, 1 insertion(+), 80 deletions(-)
> 
> diff --git a/docs/qdev-device-use.txt b/docs/qdev-device-use.txt
> index 98229b3..cc53e97 100644
> --- a/docs/qdev-device-use.txt
> +++ b/docs/qdev-device-use.txt
> @@ -190,10 +190,6 @@ The appropriate DEVNAME depends on the machine type.  For type "pc":
>  
>    -device usb-braille,chardev=braille -chardev braille,id=braille
>  
> -* -virtioconsole becomes
> -  -device virtio-serial-pci,class=C,vectors=V,ioeventfd=IOEVENTFD,max_ports=N
> -  -device virtconsole,is_console=NUM,nr=NR,name=NAME
> -
>  LEGACY-CHARDEV translates to -chardev HOST-OPTS... as follows:
>  
>  * null becomes -chardev null
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index f82f284..5df67d2 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -181,7 +181,6 @@ struct MachineClass {
>      int default_cpus;
>      unsigned int no_serial:1,
>          no_parallel:1,
> -        use_virtcon:1,
>          no_floppy:1,
>          no_cdrom:1,
>          no_sdcard:1,
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 72b8191..5cc18b4 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -60,11 +60,6 @@ The @code{--no-frame} argument works with SDL 1.2 only. The other user
>  interfaces never implemented this in the first place. So this will be
>  removed together with SDL 1.2 support.
>  
> -@subsection -virtioconsole (since 3.0.0)
> -
> -Option @option{-virtioconsole} has been replaced by
> -@option{-device virtconsole}.
> -
>  @subsection -clock (since 3.0.0)
>  
>  The @code{-clock} option is ignored since QEMU version 1.7.0. There is no
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 269eda7..5330603 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3635,16 +3635,6 @@ character to Control-t.
>  @end table
>  ETEXI
>  
> -DEF("virtioconsole", HAS_ARG, QEMU_OPTION_virtiocon, \
> -    "-virtioconsole c\n" \
> -    "                set virtio console\n", QEMU_ARCH_ALL)
> -STEXI
> -@item -virtioconsole @var{c}
> -@findex -virtioconsole
> -Set virtio console.
> -This option is deprecated, please use @option{-device virtconsole} instead.
> -ETEXI
> -
>  DEF("show-cursor", 0, QEMU_OPTION_show_cursor, \
>      "-show-cursor    show cursor\n", QEMU_ARCH_ALL)
>  STEXI
> diff --git a/vl.c b/vl.c
> index a5ae5f2..595d610 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -164,7 +164,6 @@ int no_frame;
>  static int num_serial_hds;
>  static Chardev **serial_hds;
>  Chardev *parallel_hds[MAX_PARALLEL_PORTS];
> -Chardev *virtcon_hds[MAX_VIRTIO_CONSOLES];
>  int win2k_install_hack = 0;
>  int singlestep = 0;
>  int smp_cpus;
> @@ -215,7 +214,6 @@ bool xen_domid_restrict;
>  static int has_defaults = 1;
>  static int default_serial = 1;
>  static int default_parallel = 1;
> -static int default_virtcon = 1;
>  static int default_monitor = 1;
>  static int default_floppy = 1;
>  static int default_cdrom = 1;
> @@ -236,8 +234,6 @@ static struct {
>      { .driver = "ide-drive",            .flag = &default_cdrom     },
>      { .driver = "scsi-cd",              .flag = &default_cdrom     },
>      { .driver = "scsi-hd",              .flag = &default_cdrom     },
> -    { .driver = "virtio-serial-pci",    .flag = &default_virtcon   },
> -    { .driver = "virtio-serial",        .flag = &default_virtcon   },
>      { .driver = "VGA",                  .flag = &default_vga       },
>      { .driver = "isa-vga",              .flag = &default_vga       },
>      { .driver = "cirrus-vga",           .flag = &default_vga       },
> @@ -2374,7 +2370,6 @@ struct device_config {
>          DEV_BT,        /* -bt            */
>          DEV_SERIAL,    /* -serial        */
>          DEV_PARALLEL,  /* -parallel      */
> -        DEV_VIRTCON,   /* -virtioconsole */
>          DEV_DEBUGCON,  /* -debugcon */
>          DEV_GDB,       /* -gdb, -s */
>          DEV_SCLP,      /* s390 sclp */
> @@ -2472,39 +2467,6 @@ static int parallel_parse(const char *devname)
>      return 0;
>  }
>  
> -static int virtcon_parse(const char *devname)
> -{
> -    QemuOptsList *device = qemu_find_opts("device");
> -    static int index = 0;
> -    char label[32];
> -    QemuOpts *bus_opts, *dev_opts;
> -
> -    if (strcmp(devname, "none") == 0)
> -        return 0;
> -    if (index == MAX_VIRTIO_CONSOLES) {
> -        error_report("too many virtio consoles");
> -        exit(1);
> -    }
> -
> -    bus_opts = qemu_opts_create(device, NULL, 0, &error_abort);
> -    qemu_opt_set(bus_opts, "driver", "virtio-serial", &error_abort);
> -
> -    dev_opts = qemu_opts_create(device, NULL, 0, &error_abort);
> -    qemu_opt_set(dev_opts, "driver", "virtconsole", &error_abort);
> -
> -    snprintf(label, sizeof(label), "virtcon%d", index);
> -    virtcon_hds[index] = qemu_chr_new_mux_mon(label, devname);
> -    if (!virtcon_hds[index]) {
> -        error_report("could not connect virtio console"
> -                     " to character backend '%s'", devname);
> -        return -1;
> -    }
> -    qemu_opt_set(dev_opts, "chardev", label, &error_abort);
> -
> -    index++;
> -    return 0;
> -}
> -
>  static int debugcon_parse(const char *devname)
>  {
>      QemuOpts *opts;
> @@ -3546,15 +3508,6 @@ int main(int argc, char **argv, char **envp)
>                      exit(1);
>                  }
>                  break;
> -            case QEMU_OPTION_virtiocon:
> -                warn_report("This option is deprecated, "
> -                            "use '-device virtconsole' instead");
> -                add_device_config(DEV_VIRTCON, optarg);
> -                default_virtcon = 0;
> -                if (strncmp(optarg, "mon:", 4) == 0) {
> -                    default_monitor = 0;
> -                }
> -                break;
>              case QEMU_OPTION_parallel:
>                  add_device_config(DEV_PARALLEL, optarg);
>                  default_parallel = 0;
> @@ -4171,9 +4124,6 @@ int main(int argc, char **argv, char **envp)
>      if (!has_defaults || machine_class->no_parallel) {
>          default_parallel = 0;
>      }
> -    if (!has_defaults || !machine_class->use_virtcon) {
> -        default_virtcon = 0;
> -    }
>      if (!has_defaults || machine_class->no_floppy) {
>          default_floppy = 0;
>      }
> @@ -4206,8 +4156,7 @@ int main(int argc, char **argv, char **envp)
>           * usage, -nographic is just a no-op in this case.
>           */
>          if (nographic
> -            && (default_parallel || default_serial
> -                || default_monitor || default_virtcon)) {
> +            && (default_parallel || default_serial || default_monitor)) {
>              error_report("-nographic cannot be used with -daemonize");
>              exit(1);
>          }
> @@ -4224,13 +4173,9 @@ int main(int argc, char **argv, char **envp)
>              add_device_config(DEV_PARALLEL, "null");
>          if (default_serial && default_monitor) {
>              add_device_config(DEV_SERIAL, "mon:stdio");
> -        } else if (default_virtcon && default_monitor) {
> -            add_device_config(DEV_VIRTCON, "mon:stdio");
>          } else {
>              if (default_serial)
>                  add_device_config(DEV_SERIAL, "stdio");
> -            if (default_virtcon)
> -                add_device_config(DEV_VIRTCON, "stdio");
>              if (default_monitor)
>                  monitor_parse("stdio", "readline", false);
>          }
> @@ -4241,8 +4186,6 @@ int main(int argc, char **argv, char **envp)
>              add_device_config(DEV_PARALLEL, "vc:80Cx24C");
>          if (default_monitor)
>              monitor_parse("vc:80Cx24C", "readline", false);
> -        if (default_virtcon)
> -            add_device_config(DEV_VIRTCON, "vc:80Cx24C");
>      }
>  
>  #if defined(CONFIG_VNC)
> @@ -4473,8 +4416,6 @@ int main(int argc, char **argv, char **envp)
>          exit(1);
>      if (foreach_device_config(DEV_PARALLEL, parallel_parse) < 0)
>          exit(1);
> -    if (foreach_device_config(DEV_VIRTCON, virtcon_parse) < 0)
> -        exit(1);
>      if (foreach_device_config(DEV_DEBUGCON, debugcon_parse) < 0)
>          exit(1);
>  
> 
