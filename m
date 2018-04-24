Received: from eggs.gnu.org ([2001:4830:134:3::10]:40183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fB2Nk-0007nB-Io
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 14:09:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fB2Ng-0003qB-Fm
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 14:09:36 -0400
References: <1524570294-23058-1-git-send-email-thuth@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <45e83916-df9d-6417-0646-35381f4a98d5@redhat.com>
Date: Tue, 24 Apr 2018 20:09:29 +0200
MIME-Version: 1.0
In-Reply-To: <1524570294-23058-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH] hw/s390x: Allow to configure the
 consoles with the "-serial" parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 24.04.2018 13:44, Thomas Huth wrote:
> The consoles ("sclpconsole" and "sclplmconsole") can only be configured
> with "-device" and "-chardev" so far. Other machines use the convenience
> option "-serial" to configure the default consoles, too, even for virtual
> consoles like spapr-vty on the pseries machine. So let's support this
> option on s390x, too, so we can easily enable the serial console here
> again with "-nodefaults", for example. Also map the second -serial
> option to the "sclplmconsole", so that there is now an easy way to
> configure this second console on s390x, too.
> Additionally, the new code is also smaller than the old one and we have
> less s390x-specific code in vl.c :-)
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/s390x/event-facility.c         | 14 +++++++++++
>  hw/s390x/s390-virtio-ccw.c        | 19 +++++++++++++--
>  include/hw/boards.h               |  1 -
>  include/hw/s390x/event-facility.h |  2 ++
>  vl.c                              | 50 ---------------------------------------
>  5 files changed, 33 insertions(+), 53 deletions(-)
> 
> diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
> index 9c24bc6..e6940a2 100644
> --- a/hw/s390x/event-facility.c
> +++ b/hw/s390x/event-facility.c
> @@ -511,3 +511,17 @@ static void register_types(void)
>  }
>  
>  type_init(register_types)
> +
> +BusState *sclp_get_event_facility_bus(void)
> +{
> +    Object *busobj;
> +    SCLPEventsBus *sbus;
> +
> +    busobj = object_resolve_path_type("", TYPE_SCLP_EVENTS_BUS, NULL);
> +    sbus = OBJECT_CHECK(SCLPEventsBus, busobj, TYPE_SCLP_EVENTS_BUS);
> +    if (!sbus) {
> +        return NULL;
> +    }
> +
> +    return &sbus->qbus;
> +}
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 435f7c9..fe28514 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -288,6 +288,15 @@ static void s390_create_virtio_net(BusState *bus, const char *name)
>      }
>  }
>  
> +static void s390_create_sclpconsole(const char *type, Chardev *chardev)
> +{
> +    DeviceState *dev;
> +
> +    dev = qdev_create(sclp_get_event_facility_bus(), type);
> +    qdev_prop_set_chr(dev, "chardev", chardev);
> +    qdev_init_nofail(dev);
> +}
> +
>  static void ccw_init(MachineState *machine)
>  {
>      int ret;
> @@ -311,6 +320,14 @@ static void ccw_init(MachineState *machine)
>                        machine->initrd_filename, "s390-ccw.img",
>                        "s390-netboot.img", true);
>  
> +    /* init consoles */
> +    if (serial_hds[0]) {
> +        s390_create_sclpconsole("sclpconsole", serial_hds[0]);
> +    }
> +    if (serial_hds[1]) {
> +        s390_create_sclpconsole("sclplmconsole", serial_hds[1]);
> +    }
> +
>      /*
>       * We cannot easily make the pci host bridge conditional as older QEMUs
>       * always created it. Doing so would break migration across QEMU versions.
> @@ -470,10 +487,8 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
>      mc->block_default_type = IF_VIRTIO;
>      mc->no_cdrom = 1;
>      mc->no_floppy = 1;
> -    mc->no_serial = 1;
>      mc->no_parallel = 1;
>      mc->no_sdcard = 1;
> -    mc->use_sclp = 1;
>      mc->max_cpus = S390_MAX_CPUS;
>      mc->has_hotpluggable_cpus = true;
>      mc->get_hotplug_handler = s390_get_hotplug_handler;
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index a609239..5c5eee5 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -180,7 +180,6 @@ struct MachineClass {
>      unsigned int no_serial:1,
>          no_parallel:1,
>          use_virtcon:1,
> -        use_sclp:1,
>          no_floppy:1,
>          no_cdrom:1,
>          no_sdcard:1,
> diff --git a/include/hw/s390x/event-facility.h b/include/hw/s390x/event-facility.h
> index 5698e5e..5cc16f6 100644
> --- a/include/hw/s390x/event-facility.h
> +++ b/include/hw/s390x/event-facility.h
> @@ -210,4 +210,6 @@ typedef struct SCLPEventFacilityClass {
>      bool (*event_pending)(SCLPEventFacility *ef);
>  } SCLPEventFacilityClass;
>  
> +BusState *sclp_get_event_facility_bus(void);
> +
>  #endif
> diff --git a/vl.c b/vl.c
> index fce1fd1..b32340c 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -133,7 +133,6 @@ int main(int argc, char **argv)
>  #include "sysemu/iothread.h"
>  
>  #define MAX_VIRTIO_CONSOLES 1
> -#define MAX_SCLP_CONSOLES 1
>  
>  static const char *data_dir[16];
>  static int data_dir_idx;
> @@ -157,7 +156,6 @@ int no_frame;
>  Chardev *serial_hds[MAX_SERIAL_PORTS];
>  Chardev *parallel_hds[MAX_PARALLEL_PORTS];
>  Chardev *virtcon_hds[MAX_VIRTIO_CONSOLES];
> -Chardev *sclp_hds[MAX_SCLP_CONSOLES];
>  int win2k_install_hack = 0;
>  int singlestep = 0;
>  int smp_cpus;
> @@ -209,7 +207,6 @@ static int has_defaults = 1;
>  static int default_serial = 1;
>  static int default_parallel = 1;
>  static int default_virtcon = 1;
> -static int default_sclp = 1;
>  static int default_monitor = 1;
>  static int default_floppy = 1;
>  static int default_cdrom = 1;
> @@ -2571,39 +2568,6 @@ static int virtcon_parse(const char *devname)
>      return 0;
>  }
>  
> -static int sclp_parse(const char *devname)
> -{
> -    QemuOptsList *device = qemu_find_opts("device");
> -    static int index = 0;
> -    char label[32];
> -    QemuOpts *dev_opts;
> -
> -    if (strcmp(devname, "none") == 0) {
> -        return 0;
> -    }
> -    if (index == MAX_SCLP_CONSOLES) {
> -        error_report("too many sclp consoles");
> -        exit(1);
> -    }
> -
> -    assert(arch_type == QEMU_ARCH_S390X);
> -
> -    dev_opts = qemu_opts_create(device, NULL, 0, NULL);
> -    qemu_opt_set(dev_opts, "driver", "sclpconsole", &error_abort);
> -
> -    snprintf(label, sizeof(label), "sclpcon%d", index);
> -    sclp_hds[index] = qemu_chr_new(label, devname);
> -    if (!sclp_hds[index]) {
> -        error_report("could not connect sclp console"
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
> @@ -4237,9 +4201,6 @@ int main(int argc, char **argv, char **envp)
>      if (!has_defaults || !machine_class->use_virtcon) {
>          default_virtcon = 0;
>      }
> -    if (!has_defaults || !machine_class->use_sclp) {
> -        default_sclp = 0;
> -    }
>      if (!has_defaults || machine_class->no_floppy) {
>          default_floppy = 0;
>      }
> @@ -4286,16 +4247,11 @@ int main(int argc, char **argv, char **envp)
>              add_device_config(DEV_SERIAL, "mon:stdio");
>          } else if (default_virtcon && default_monitor) {
>              add_device_config(DEV_VIRTCON, "mon:stdio");
> -        } else if (default_sclp && default_monitor) {
> -            add_device_config(DEV_SCLP, "mon:stdio");
>          } else {
>              if (default_serial)
>                  add_device_config(DEV_SERIAL, "stdio");
>              if (default_virtcon)
>                  add_device_config(DEV_VIRTCON, "stdio");
> -            if (default_sclp) {
> -                add_device_config(DEV_SCLP, "stdio");
> -            }
>              if (default_monitor)
>                  monitor_parse("stdio", "readline", false);
>          }
> @@ -4308,9 +4264,6 @@ int main(int argc, char **argv, char **envp)
>              monitor_parse("vc:80Cx24C", "readline", false);
>          if (default_virtcon)
>              add_device_config(DEV_VIRTCON, "vc:80Cx24C");
> -        if (default_sclp) {
> -            add_device_config(DEV_SCLP, "vc:80Cx24C");
> -        }
>      }
>  
>  #if defined(CONFIG_VNC)
> @@ -4560,9 +4513,6 @@ int main(int argc, char **argv, char **envp)
>          exit(1);
>      if (foreach_device_config(DEV_VIRTCON, virtcon_parse) < 0)
>          exit(1);
> -    if (foreach_device_config(DEV_SCLP, sclp_parse) < 0) {
> -        exit(1);
> -    }
>      if (foreach_device_config(DEV_DEBUGCON, debugcon_parse) < 0)
>          exit(1);
>  
> 

If this doesn't break any setups we have, I really like it :)

-- 

Thanks,

David / dhildenb
