Received: from eggs.gnu.org ([2001:4830:134:3::10]:44050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1d3pXl-0007Xl-Ne
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 15:57:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1d3pXg-00040I-TC
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 15:57:37 -0400
Message-Id: <59024D270200004800143945@prv-mh.provo.novell.com>
Date: Thu, 27 Apr 2017 13:57:27 -0600
From: "Bruce Rogers" <brogers@suse.com>
References: <1493233622-14485-1-git-send-email-brogers@suse.com>
	<20170427111135.7a7bbfa9@nial.brq.redhat.com>
	<590211DF02000048001438FF@prv-mh.provo.novell.com>
	<20170427180832.55eed506@Igors-MacBook-Pro.local>
	<5902218B0200004800143927@prv-mh.provo.novell.com>
	<20170427193551.446a6793@Igors-MacBook-Pro.local>
	<alpine.DEB.2.10.1704271107260.11141@sstabellini-ThinkPad-X260>
In-Reply-To: <alpine.DEB.2.10.1704271107260.11141@sstabellini-ThinkPad-X260>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
To: Stefano Stabellini <sstabellini@kernel.org>, Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, mst@redhat.com



>>> On 4/27/2017 at 12:08 PM, Stefano Stabellini <sstabellini@kernel.org> =
wrote:=20
> On Thu, 27 Apr 2017, Igor Mammedov wrote:
>> On Thu, 27 Apr 2017 10:51:23 -0600
>> "Bruce Rogers" <brogers@suse.com> wrote:
>>=20
>> >=20
>> >=20
>> > >>> On 4/27/2017 at 10:08 AM, Igor Mammedov <imammedo@redhat.com> =
wrote:=20
>> > > On Thu, 27 Apr 2017 09:44:31 -0600
>> > > "Bruce Rogers" <brogers@suse.com> wrote:
>> > >=20
>> > >> >>> On 4/27/2017 at 03:11 AM, Igor Mammedov <imammedo@redhat.com> =
wrote:=20
>> > >> > On Wed, 26 Apr 2017 13:07:02 -0600
>> > >> > Bruce Rogers <brogers@suse.com> wrote:
>> > >> >=20
>> > >> >> Commit f0c9d64a exposed an issue with the code order in =
acpi_setup.
>> > >> >> As of that commit, a xenfv machine type guest will no longer =
start
>> > >> >> if using pci passthrough. Re-order the code in that function to
>> > >> >> allow acpi_set_pci_info to be called before bailing on the =
other,
>> > >> >> non-related conditions. With this change I can again use pci
>> > >> >> passthrough and xenfv together.
>> > >> >>=20
>> > >> >> Signed-off-by: Bruce Rogers <brogers@suse.com>
>> > >> > it doesn't look right,
>> > >> > acpi_set_pci_info() is supposed to affect only ACPI based =
hotplug
>> > >> >=20
>> > >> > could you elaborate more on what's going on and
>> > >> > what error you see at startup?
>> > >>=20
>> > >> I am using libvirt, driving the creation of the Xen HVM guest via
>> > >> libxl. libxl dynamically attaches the pci device via QMP. In the
>> > >> context of qmp_device_add(), we get a failure in hw/acpi/pcihp.c:
>> > >> acpi_pcihp_device_plug_cb() when it checks for bsel, and errors
>> > >> with the message: "Unsupported bus. Bus doesn't have property
>> > >> 'acpi-pcihp-bsel' set". I guess it wasn't clear from my description=

>> > >> that hotplug was involved.
>> > >>=20
>> > > is dev->hotplugged in acpi_pcihp_device_plug_cb() true at that =
time?
>> > >=20
>> > > the point is that bsel is needed only when there is supporting ACPI =
code
>> > > and useless otherwise, so acpi_pcihp_device_plug_cb() probably =
shouldn't
>> > > run under xenfv. I'd try to add compat prop to PIIX4_PM and disable
>> > > acpi_pcihp_device_plug_cb() for xenfv via machine compat property.
>> >=20
>> > So what would be wrong with simply conditionalizing the call to=20
>> >  acpi_pcihp_device_plug_cb() with a check for xen in piix4_device_plug=
_cb()
>> > as follows:
>> >=20
>> >          }
>> >      } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
>> > -        acpi_pcihp_device_plug_cb(hotplug_dev, &s->acpi_pci_hotplug, =
dev,=20
> errp);
>> > +        if (!xen_enabled()) {
>> > +            acpi_pcihp_device_plug_cb(hotplug_dev, &s->acpi_pci_hotpl=
ug, dev,
>> > +                                      errp);
>> > +        }
>> >      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>> >          if (s->cpu_hotplug_legacy) {
>> >              legacy_acpi_cpu_plug_cb(hotplug_dev, &s->gpe_cpu, dev, =
errp);
>> >=20
>> > Wouldn't that be the solution?
>> it should work
>>=20
>> is it possible to see unplug on that device later under xen?
>=20
> Yes, it would be possible. I guess we need to do the same for
> acpi_pcihp_device_unplug_cb?

Thanks guys, I'll send a new patch based on this discussion.

Bruce
