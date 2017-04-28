Received: from eggs.gnu.org ([2001:4830:134:3::10]:38993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d44pp-0001fe-Ny
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 08:17:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d44pk-0001kq-RL
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 08:17:17 -0400
Date: Fri, 28 Apr 2017 14:17:06 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170428141706.73df15ee@nial.brq.redhat.com>
In-Reply-To: <1493380626-10883-1-git-send-email-brogers@suse.com>
References: <1493380626-10883-1-git-send-email-brogers@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] ACPI: don't call
 acpi_pcihp_device_plug_cb on xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bruce Rogers <brogers@suse.com>
Cc: qemu-devel@nongnu.org, sstabellini@kernel.org, mst@redhat.com, qemu-stable@nongnu.org

On Fri, 28 Apr 2017 05:57:06 -0600
Bruce Rogers <brogers@suse.com> wrote:

> Commit f0c9d64a exposed the issue that with a xenfv machine using
> pci passthrough, acpi pci hotplug code was being executed by mistake.
> Guard calls to acpi_pcihp_device_plug_cb (and corresponding
> acpi_pcihp_device_unplug_cb) with a check for xen_enabled(). Without
> this check I am seeing the following error report: "Unsupported bus.
> Bus doesn't have property 'acpi-pcihp-bsel' set".
> 
> Signed-off-by: Bruce Rogers <brogers@suse.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/piix4.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> index a553a7e..c409374 100644
> --- a/hw/acpi/piix4.c
> +++ b/hw/acpi/piix4.c
> @@ -385,7 +385,10 @@ static void piix4_device_plug_cb(HotplugHandler *hotplug_dev,
>                                  dev, errp);
>          }
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> -        acpi_pcihp_device_plug_cb(hotplug_dev, &s->acpi_pci_hotplug, dev, errp);
> +        if (!xen_enabled()) {
> +            acpi_pcihp_device_plug_cb(hotplug_dev, &s->acpi_pci_hotplug, dev,
> +                                      errp);
> +        }
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>          if (s->cpu_hotplug_legacy) {
>              legacy_acpi_cpu_plug_cb(hotplug_dev, &s->gpe_cpu, dev, errp);
> @@ -408,8 +411,10 @@ static void piix4_device_unplug_request_cb(HotplugHandler *hotplug_dev,
>          acpi_memory_unplug_request_cb(hotplug_dev, &s->acpi_memory_hotplug,
>                                        dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> -        acpi_pcihp_device_unplug_cb(hotplug_dev, &s->acpi_pci_hotplug, dev,
> -                                    errp);
> +        if (!xen_enabled()) {
> +            acpi_pcihp_device_unplug_cb(hotplug_dev, &s->acpi_pci_hotplug, dev,
> +                                        errp);
> +        }
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU) &&
>                 !s->cpu_hotplug_legacy) {
>          acpi_cpu_unplug_request_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
