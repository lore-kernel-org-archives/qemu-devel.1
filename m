Received: from eggs.gnu.org ([2001:4830:134:3::10]:37356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d3nKm-0002Ca-Va
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 13:36:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d3nKl-0003wu-QN
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 13:36:04 -0400
Date: Thu, 27 Apr 2017 19:35:51 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170427193551.446a6793@Igors-MacBook-Pro.local>
In-Reply-To: <5902218B0200004800143927@prv-mh.provo.novell.com>
References: <1493233622-14485-1-git-send-email-brogers@suse.com>
	<20170427111135.7a7bbfa9@nial.brq.redhat.com>
	<590211DF02000048001438FF@prv-mh.provo.novell.com>
	<20170427180832.55eed506@Igors-MacBook-Pro.local>
	<5902218B0200004800143927@prv-mh.provo.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] ACPI: call acpi_set_pci_info when only
 acpi enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bruce Rogers <brogers@suse.com>
Cc: sstabellini@kernel.org, mst@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org

On Thu, 27 Apr 2017 10:51:23 -0600
"Bruce Rogers" <brogers@suse.com> wrote:

> 
> 
> >>> On 4/27/2017 at 10:08 AM, Igor Mammedov <imammedo@redhat.com> wrote: 
> > On Thu, 27 Apr 2017 09:44:31 -0600
> > "Bruce Rogers" <brogers@suse.com> wrote:
> > 
> >> >>> On 4/27/2017 at 03:11 AM, Igor Mammedov <imammedo@redhat.com> wrote: 
> >> > On Wed, 26 Apr 2017 13:07:02 -0600
> >> > Bruce Rogers <brogers@suse.com> wrote:
> >> > 
> >> >> Commit f0c9d64a exposed an issue with the code order in acpi_setup.
> >> >> As of that commit, a xenfv machine type guest will no longer start
> >> >> if using pci passthrough. Re-order the code in that function to
> >> >> allow acpi_set_pci_info to be called before bailing on the other,
> >> >> non-related conditions. With this change I can again use pci
> >> >> passthrough and xenfv together.
> >> >> 
> >> >> Signed-off-by: Bruce Rogers <brogers@suse.com>
> >> > it doesn't look right,
> >> > acpi_set_pci_info() is supposed to affect only ACPI based hotplug
> >> > 
> >> > could you elaborate more on what's going on and
> >> > what error you see at startup?
> >> 
> >> I am using libvirt, driving the creation of the Xen HVM guest via
> >> libxl. libxl dynamically attaches the pci device via QMP. In the
> >> context of qmp_device_add(), we get a failure in hw/acpi/pcihp.c:
> >> acpi_pcihp_device_plug_cb() when it checks for bsel, and errors
> >> with the message: "Unsupported bus. Bus doesn't have property
> >> 'acpi-pcihp-bsel' set". I guess it wasn't clear from my description
> >> that hotplug was involved.
> >> 
> > is dev->hotplugged in acpi_pcihp_device_plug_cb() true at that time?
> > 
> > the point is that bsel is needed only when there is supporting ACPI code
> > and useless otherwise, so acpi_pcihp_device_plug_cb() probably shouldn't
> > run under xenfv. I'd try to add compat prop to PIIX4_PM and disable
> > acpi_pcihp_device_plug_cb() for xenfv via machine compat property.
> 
> So what would be wrong with simply conditionalizing the call to 
>  acpi_pcihp_device_plug_cb() with a check for xen in piix4_device_plug_cb()
> as follows:
> 
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
> 
> Wouldn't that be the solution?
it should work

is it possible to see unplug on that device later under xen?

> 
> Bruce
> 
> 
