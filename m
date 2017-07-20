Received: from eggs.gnu.org ([2001:4830:134:3::10]:52243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dYCvz-0002ld-7y
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:00:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dYCvw-0005XR-1r
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:00:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dYCvv-0005Tc-Nr
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:00:07 -0400
Date: Thu, 20 Jul 2017 16:59:57 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170720165957.743ccf1a@nial.brq.redhat.com>
In-Reply-To: <1500543086-26588-1-git-send-email-sf@sfritsch.de>
References: <1500543086-26588-1-git-send-email-sf@sfritsch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] acpi: Add emulated sleep button
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Fritsch <sf@sfritsch.de>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael
	S. Tsirkin" <mst@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, 20 Jul 2017 11:31:26 +0200
Stefan Fritsch <sf@sfritsch.de> wrote:

> From: Stefan Fritsch <stefan_fritsch@genua.de>
> 
> Add an ACPI sleep button and QMP/HMP commands to trigger it.  A sleep
> button is a so called "fixed hardware feature", which makes it more
> suitable for putting the system to sleep than a laptop lid, for example.
> 
> The sleep button is disabled by default (Bit 5 in the FACP flags
> register set and no button "device" present in SSDT/DSDT). Clearing said
> bit enables it as a fixed feature device.

per spec sleep button is used for both putting system into
sleep and for waking it up.

Reusing system_wakeup 'button' to behave as per spec would
make this patch significantly smaller.

If you like idea of separate command/button better, then
I'd go generic control sleep button way instead of fixed
hardware, it would allow us to reuse most of the code in
ARM target, plus I'd avoid notifiers and use acpi device
lookup instead (see: qmp_query_acpi_ospm_status as example)


> Signed-off-by: Stefan Fritsch <stefan_fritsch@genua.de>
> ---
>  hmp-commands.hx         | 16 ++++++++++++++++
>  hmp.c                   |  5 +++++
>  hmp.h                   |  1 +
>  hw/acpi/core.c          |  8 ++++++++
>  hw/acpi/ich9.c          | 10 ++++++++++
>  hw/acpi/piix4.c         | 12 ++++++++++++
>  hw/i386/acpi-build.c    |  1 -
>  include/hw/acpi/acpi.h  |  2 ++
>  include/hw/acpi/ich9.h  |  1 +
>  include/sysemu/sysemu.h |  2 ++
>  qapi-schema.json        | 12 ++++++++++++
>  qmp.c                   |  5 +++++
>  tests/test-hmp.c        |  1 +
>  vl.c                    | 29 +++++++++++++++++++++++++++++
>  14 files changed, 104 insertions(+), 1 deletion(-)
> 
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 1941e19932..8ba4380883 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -638,6 +638,22 @@ Reset the system.
>  ETEXI
>  
>      {
> +        .name       = "system_sleep",
> +        .args_type  = "",
> +        .params     = "",
> +        .help       = "send ACPI sleep event",
> +        .cmd = hmp_system_sleep,
> +    },
> +
> +STEXI
> +@item system_sleep
> +@findex system_sleep
> +
> +Push the virtual sleep button; if supported the system will enter
> +an ACPI sleep state.
> +ETEXI
> +
> +    {
>          .name       = "system_powerdown",
>          .args_type  = "",
>          .params     = "",
> diff --git a/hmp.c b/hmp.c
> index bf1de747d5..b4b584016c 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -1047,6 +1047,11 @@ void hmp_system_reset(Monitor *mon, const QDict *qdict)
>      qmp_system_reset(NULL);
>  }
>  
> +void hmp_system_sleep(Monitor *mon, const QDict *qdict)
> +{
> +    qmp_system_sleep(NULL);
> +}
> +
>  void hmp_system_powerdown(Monitor *mon, const QDict *qdict)
>  {
>      qmp_system_powerdown(NULL);
> diff --git a/hmp.h b/hmp.h
> index 1ff455295e..15b53de9ed 100644
> --- a/hmp.h
> +++ b/hmp.h
> @@ -45,6 +45,7 @@ void hmp_info_iothreads(Monitor *mon, const QDict *qdict);
>  void hmp_quit(Monitor *mon, const QDict *qdict);
>  void hmp_stop(Monitor *mon, const QDict *qdict);
>  void hmp_system_reset(Monitor *mon, const QDict *qdict);
> +void hmp_system_sleep(Monitor *mon, const QDict *qdict);
>  void hmp_system_powerdown(Monitor *mon, const QDict *qdict);
>  void hmp_cpu(Monitor *mon, const QDict *qdict);
>  void hmp_memsave(Monitor *mon, const QDict *qdict);
> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> index 95fcac95a2..2ee64b6878 100644
> --- a/hw/acpi/core.c
> +++ b/hw/acpi/core.c
> @@ -422,6 +422,14 @@ void acpi_pm1_evt_power_down(ACPIREGS *ar)
>      }
>  }
>  
> +void acpi_pm1_evt_sleep(ACPIREGS *ar)
> +{
> +    if (ar->pm1.evt.en & ACPI_BITMASK_SLEEP_BUTTON_ENABLE) {
> +        ar->pm1.evt.sts |= ACPI_BITMASK_SLEEP_BUTTON_STATUS;
> +        ar->tmr.update_sci(ar);
> +    }
> +}
> +
>  void acpi_pm1_evt_reset(ACPIREGS *ar)
>  {
>      ar->pm1.evt.sts = 0;
> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> index c5d8646abc..3faeab4d2e 100644
> --- a/hw/acpi/ich9.c
> +++ b/hw/acpi/ich9.c
> @@ -260,6 +260,14 @@ static void pm_reset(void *opaque)
>      acpi_update_sci(&pm->acpi_regs, pm->irq);
>  }
>  
> +static void pm_sleep_req(Notifier *n, void *opaque)
> +{
> +    ICH9LPCPMRegs *pm = container_of(n, ICH9LPCPMRegs, sleep_notifier);
> +
> +    acpi_pm1_evt_sleep(&pm->acpi_regs);
> +}
> +
> +
>  static void pm_powerdown_req(Notifier *n, void *opaque)
>  {
>      ICH9LPCPMRegs *pm = container_of(n, ICH9LPCPMRegs, powerdown_notifier);
> @@ -299,6 +307,8 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm,
>      qemu_register_reset(pm_reset, pm);
>      pm->powerdown_notifier.notify = pm_powerdown_req;
>      qemu_register_powerdown_notifier(&pm->powerdown_notifier);
> +    pm->sleep_notifier.notify = pm_sleep_req;
> +    qemu_register_sleep_notifier(&pm->sleep_notifier);
>  
>      legacy_acpi_cpu_hotplug_init(pci_address_space_io(lpc_pci),
>          OBJECT(lpc_pci), &pm->gpe_cpu, ICH9_CPU_HOTPLUG_IO_BASE);
> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> index f276967365..15e20976c3 100644
> --- a/hw/acpi/piix4.c
> +++ b/hw/acpi/piix4.c
> @@ -79,6 +79,7 @@ typedef struct PIIX4PMState {
>      int smm_enabled;
>      Notifier machine_ready;
>      Notifier powerdown_notifier;
> +    Notifier sleep_notifier;
>  
>      AcpiPciHpState acpi_pci_hotplug;
>      bool use_acpi_pci_hotplug;
> @@ -371,6 +372,15 @@ static void piix4_pm_powerdown_req(Notifier *n, void *opaque)
>      acpi_pm1_evt_power_down(&s->ar);
>  }
>  
> +static void piix4_pm_sleep_req(Notifier *n, void *opaque)
> +{
> +    PIIX4PMState *s = container_of(n, PIIX4PMState, sleep_notifier);
> +
> +    assert(s != NULL);
> +    acpi_pm1_evt_sleep(&s->ar);
> +}
> +
> +
>  static void piix4_device_plug_cb(HotplugHandler *hotplug_dev,
>                                   DeviceState *dev, Error **errp)
>  {
> @@ -535,6 +545,8 @@ static void piix4_pm_realize(PCIDevice *dev, Error **errp)
>  
>      s->powerdown_notifier.notify = piix4_pm_powerdown_req;
>      qemu_register_powerdown_notifier(&s->powerdown_notifier);
> +    s->sleep_notifier.notify = piix4_pm_sleep_req;
> +    qemu_register_sleep_notifier(&s->sleep_notifier);
>  
>      s->machine_ready.notify = piix4_pm_machine_ready;
>      qemu_add_machine_init_done_notifier(&s->machine_ready);
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 6b7bade183..06b28dacfe 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -294,7 +294,6 @@ static void fadt_setup(AcpiFadtDescriptorRev3 *fadt, AcpiPmInfo *pm)
>      fadt->plvl3_lat = cpu_to_le16(0xfff); /* C3 state not supported */
>      fadt->flags = cpu_to_le32((1 << ACPI_FADT_F_WBINVD) |
>                                (1 << ACPI_FADT_F_PROC_C1) |
> -                              (1 << ACPI_FADT_F_SLP_BUTTON) |
>                                (1 << ACPI_FADT_F_RTC_S4));
>      fadt->flags |= cpu_to_le32(1 << ACPI_FADT_F_USE_PLATFORM_CLOCK);
>      /* APIC destination mode ("Flat Logical") has an upper limit of 8 CPUs
> diff --git a/include/hw/acpi/acpi.h b/include/hw/acpi/acpi.h
> index 7b3d93cf0d..51cf901ef6 100644
> --- a/include/hw/acpi/acpi.h
> +++ b/include/hw/acpi/acpi.h
> @@ -78,6 +78,7 @@
>  #define ACPI_BITMASK_PM1_COMMON_ENABLED         ( \
>          ACPI_BITMASK_RT_CLOCK_ENABLE        | \
>          ACPI_BITMASK_POWER_BUTTON_ENABLE    | \
> +        ACPI_BITMASK_SLEEP_BUTTON_ENABLE    | \
>          ACPI_BITMASK_GLOBAL_LOCK_ENABLE     | \
>          ACPI_BITMASK_TIMER_ENABLE)
>  
> @@ -148,6 +149,7 @@ void acpi_pm_tmr_reset(ACPIREGS *ar);
>  /* PM1a_EVT: piix and ich9 don't implement PM1b. */
>  uint16_t acpi_pm1_evt_get_sts(ACPIREGS *ar);
>  void acpi_pm1_evt_power_down(ACPIREGS *ar);
> +void acpi_pm1_evt_sleep(ACPIREGS *ar);
>  void acpi_pm1_evt_reset(ACPIREGS *ar);
>  void acpi_pm1_evt_init(ACPIREGS *ar, acpi_update_sci_fn update_sci,
>                         MemoryRegion *parent);
> diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
> index a352c94fde..2073eec168 100644
> --- a/include/hw/acpi/ich9.h
> +++ b/include/hw/acpi/ich9.h
> @@ -48,6 +48,7 @@ typedef struct ICH9LPCPMRegs {
>  
>      uint32_t pm_io_base;
>      Notifier powerdown_notifier;
> +    Notifier sleep_notifier;
>  
>      bool cpu_hotplug_legacy;
>      AcpiCpuHotplug gpe_cpu;
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index b21369672a..00f54653dc 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -75,6 +75,8 @@ void qemu_register_wakeup_notifier(Notifier *notifier);
>  void qemu_system_shutdown_request(ShutdownCause reason);
>  void qemu_system_powerdown_request(void);
>  void qemu_register_powerdown_notifier(Notifier *notifier);
> +void qemu_system_sleep_request(void);
> +void qemu_register_sleep_notifier(Notifier *notifier);
>  void qemu_system_debug_request(void);
>  void qemu_system_vmstop_request(RunState reason);
>  void qemu_system_vmstop_request_prepare(void);
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 8b015bee2e..c6ccfcd70f 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -2314,6 +2314,18 @@
>  { 'command': 'system_reset' }
>  
>  ##
> +# @system_sleep:
> +#
> +# Requests that a guest perform a ACPI sleep transition by pushing a virtual
> +# sleep button.
> +#
> +# Notes: A guest may or may not respond to this command.  This command
> +#        returning does not indicate that a guest has accepted the request or
> +#        that it has gone to sleep.
> +##
> +{ 'command': 'system_sleep' }
> +
> +##
>  # @system_powerdown:
>  #
>  # Requests that a guest perform a powerdown operation.
> diff --git a/qmp.c b/qmp.c
> index b86201e349..bc1f2e3d7f 100644
> --- a/qmp.c
> +++ b/qmp.c
> @@ -108,6 +108,11 @@ void qmp_system_reset(Error **errp)
>      qemu_system_reset_request(SHUTDOWN_CAUSE_HOST_QMP);
>  }
>  
> +void qmp_system_sleep(Error **erp)
> +{
> +    qemu_system_sleep_request();
> +}
> +
>  void qmp_system_powerdown(Error **erp)
>  {
>      qemu_system_powerdown_request();
> diff --git a/tests/test-hmp.c b/tests/test-hmp.c
> index d77b3c8710..3fa850bf1e 100644
> --- a/tests/test-hmp.c
> +++ b/tests/test-hmp.c
> @@ -67,6 +67,7 @@ static const char *hmp_cmds[] = {
>      "sum 0 512",
>      "x /8i 0x100",
>      "xp /16x 0",
> +    "system_sleep",
>      NULL
>  };
>  
> diff --git a/vl.c b/vl.c
> index fb6b2efafa..6a0f847dcf 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1608,6 +1608,7 @@ static ShutdownCause reset_requested;
>  static ShutdownCause shutdown_requested;
>  static int shutdown_signal;
>  static pid_t shutdown_pid;
> +static int sleep_requested;
>  static int powerdown_requested;
>  static int debug_requested;
>  static int suspend_requested;
> @@ -1618,6 +1619,8 @@ static NotifierList suspend_notifiers =
>      NOTIFIER_LIST_INITIALIZER(suspend_notifiers);
>  static NotifierList wakeup_notifiers =
>      NOTIFIER_LIST_INITIALIZER(wakeup_notifiers);
> +static NotifierList sleep_notifiers =
> +    NOTIFIER_LIST_INITIALIZER(sleep_notifiers);
>  static uint32_t wakeup_reason_mask = ~(1 << QEMU_WAKEUP_REASON_NONE);
>  
>  ShutdownCause qemu_shutdown_requested_get(void)
> @@ -1838,6 +1841,24 @@ static void qemu_system_powerdown(void)
>      notifier_list_notify(&powerdown_notifiers, NULL);
>  }
>  
> +static void qemu_system_sleep(void)
> +{
> +    notifier_list_notify(&sleep_notifiers, NULL);
> +}
> +
> +static int qemu_sleep_requested(void)
> +{
> +    int r = sleep_requested;
> +    sleep_requested = 0;
> +    return r;
> +}
> +
> +void qemu_system_sleep_request(void)
> +{
> +    sleep_requested = 1;
> +    qemu_notify_event();
> +}
> +
>  void qemu_system_powerdown_request(void)
>  {
>      trace_qemu_system_powerdown_request();
> @@ -1850,6 +1871,11 @@ void qemu_register_powerdown_notifier(Notifier *notifier)
>      notifier_list_add(&powerdown_notifiers, notifier);
>  }
>  
> +void qemu_register_sleep_notifier(Notifier *notifier)
> +{
> +    notifier_list_add(&sleep_notifiers, notifier);
> +}
> +
>  void qemu_system_debug_request(void)
>  {
>      debug_requested = 1;
> @@ -1899,6 +1925,9 @@ static bool main_loop_should_exit(void)
>      if (qemu_powerdown_requested()) {
>          qemu_system_powerdown();
>      }
> +    if (qemu_sleep_requested()) {
> +        qemu_system_sleep();
> +    }
>      if (qemu_vmstop_requested(&r)) {
>          vm_stop(r);
>      }
