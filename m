Received: from eggs.gnu.org ([2001:4830:134:3::10]:51956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1d3mIB-00037U-3V
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 12:29:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1d3mI7-00014t-W4
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 12:29:19 -0400
Message-Id: <59021C58020000480014391D@prv-mh.provo.novell.com>
Date: Thu, 27 Apr 2017 10:29:12 -0600
From: "Bruce Rogers" <brogers@suse.com>
References: <1493233622-14485-1-git-send-email-brogers@suse.com>
	<20170427111135.7a7bbfa9@nial.brq.redhat.com>
	<590211DF02000048001438FF@prv-mh.provo.novell.com>
	<20170427180832.55eed506@Igors-MacBook-Pro.local>
In-Reply-To: <20170427180832.55eed506@Igors-MacBook-Pro.local>
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: sstabellini@kernel.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org, mst@redhat.com



>>> On 4/27/2017 at 10:08 AM, Igor Mammedov <imammedo@redhat.com> =
wrote:=20
> On Thu, 27 Apr 2017 09:44:31 -0600
> "Bruce Rogers" <brogers@suse.com> wrote:
>=20
>> >>> On 4/27/2017 at 03:11 AM, Igor Mammedov <imammedo@redhat.com> =
wrote:=20
>> > On Wed, 26 Apr 2017 13:07:02 -0600
>> > Bruce Rogers <brogers@suse.com> wrote:
>> >=20
>> >> Commit f0c9d64a exposed an issue with the code order in acpi_setup.
>> >> As of that commit, a xenfv machine type guest will no longer start
>> >> if using pci passthrough. Re-order the code in that function to
>> >> allow acpi_set_pci_info to be called before bailing on the other,
>> >> non-related conditions. With this change I can again use pci
>> >> passthrough and xenfv together.
>> >>=20
>> >> Signed-off-by: Bruce Rogers <brogers@suse.com>
>> > it doesn't look right,
>> > acpi_set_pci_info() is supposed to affect only ACPI based hotplug
>> >=20
>> > could you elaborate more on what's going on and
>> > what error you see at startup?
>>=20
>> I am using libvirt, driving the creation of the Xen HVM guest via
>> libxl. libxl dynamically attaches the pci device via QMP. In the
>> context of qmp_device_add(), we get a failure in hw/acpi/pcihp.c:
>> acpi_pcihp_device_plug_cb() when it checks for bsel, and errors
>> with the message: "Unsupported bus. Bus doesn't have property
>> 'acpi-pcihp-bsel' set". I guess it wasn't clear from my description
>> that hotplug was involved.
>>=20
> is dev->hotplugged in acpi_pcihp_device_plug_cb() true at that time?

Yes it is. It gets set in hw/core/qdev.c:device_initfn().

>=20
> the point is that bsel is needed only when there is supporting ACPI code
> and useless otherwise, so acpi_pcihp_device_plug_cb() probably shouldn't
> run under xenfv. I'd try to add compat prop to PIIX4_PM and disable
> acpi_pcihp_device_plug_cb() for xenfv via machine compat property.

I'll look into this then. I'm not too familiar yet with this area of the =
code.
I simply bisected the problem, which pointed to the commit id referenced
in the patch, and came up with what seemed like the most obvious solution.

>=20
>> Bruce
>>=20
>> >=20
>> >> ---
>> >>  hw/i386/acpi-build.c | 14 +++++++-------
>> >>  1 file changed, 7 insertions(+), 7 deletions(-)
>> >>=20
>> >> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> >> index 2073108..1ec072f 100644
>> >> --- a/hw/i386/acpi-build.c
>> >> +++ b/hw/i386/acpi-build.c
>> >> @@ -2834,6 +2834,13 @@ void acpi_setup(void)
>> >>      AcpiBuildState *build_state;
>> >>      Object *vmgenid_dev;
>> >> =20
>> >> +    if (!acpi_enabled) {
>> >> +        ACPI_BUILD_DPRINTF("ACPI disabled. Bailing out.\n");
>> >> +        return;
>> >> +    }
>> >> +
>> >> +    acpi_set_pci_info();
>> >> +
>> >>      if (!pcms->fw_cfg) {
>> >>          ACPI_BUILD_DPRINTF("No fw cfg. Bailing out.\n");
>> >>          return;
>> >> @@ -2844,15 +2851,8 @@ void acpi_setup(void)
>> >>          return;
>> >>      }
>> >> =20
>> >> -    if (!acpi_enabled) {
>> >> -        ACPI_BUILD_DPRINTF("ACPI disabled. Bailing out.\n");
>> >> -        return;
>> >> -    }
>> >> -
>> >>      build_state =3D g_malloc0(sizeof *build_state);
>> >> =20
>> >> -    acpi_set_pci_info();
>> >> -
>> >>      acpi_build_tables_init(&tables);
>> >>      acpi_build(&tables, MACHINE(pcms));
>> >> =20
>>=20
>>=20
