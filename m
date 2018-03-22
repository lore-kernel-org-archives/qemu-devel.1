Received: from eggs.gnu.org ([2001:4830:134:3::10]:49084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1ez0bC-00059y-6l
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 09:49:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1ez0bB-0001q4-8l
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 09:49:46 -0400
Date: Thu, 22 Mar 2018 14:49:35 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180322134935.n5u6aitfrfl2ppts@hawk.localdomain>
References: <20180322031216.14569-1-wei@redhat.com>
	<20180322110712.GN3583@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180322110712.GN3583@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] mach-virt: Set VM's SMBIOS system
 version to mc->desc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Wei Huang <wei@redhat.com>, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On Thu, Mar 22, 2018 at 11:07:12AM +0000, Daniel P. Berrang=E9 wrote:
> On Wed, Mar 21, 2018 at 10:12:16PM -0500, Wei Huang wrote:
> > Instead of using "1.0" as the system version of SMBIOS, we should use
> > mc->desc for mach-virt machine type. With this patch, "dmidecode -t 1=
"
> > (e.g., "-M virt-2.12,accel=3Dkvm") will show:
> >=20
> >     Handle 0x0100, DMI type 1, 27 bytes
> >     System Information
> >             Manufacturer: QEMU
> >             Product Name: KVM Virtual Machine
> >             Version: QEMU 2.12 ARM Virtual Machine
> >             Serial Number: Not Specified
> >             ...
> >=20
> > instead of:
> >     Handle 0x0100, DMI type 1, 27 bytes
> >     System Information
> >             Manufacturer: QEMU
> >             Product Name: KVM Virtual Machine
> >             Version: 1.0
> >             Serial Number: Not Specified
> >             ...
> >=20
> > Signed-off-by: Wei Huang <wei@redhat.com>
> > ---
> >  hw/arm/virt.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index 2c07245047..da7228b297 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -1132,6 +1132,7 @@ static void *machvirt_dtb(const struct arm_boot=
_info *binfo, int *fdt_size)
> > =20
> >  static void virt_build_smbios(VirtMachineState *vms)
> >  {
> > +    MachineClass *mc =3D MACHINE_GET_CLASS(vms);
> >      uint8_t *smbios_tables, *smbios_anchor;
> >      size_t smbios_tables_len, smbios_anchor_len;
> >      const char *product =3D "QEMU Virtual Machine";
> > @@ -1145,7 +1146,7 @@ static void virt_build_smbios(VirtMachineState =
*vms)
> >      }
> > =20
> >      smbios_set_defaults("QEMU", product,
> > -                        "1.0", false, true, SMBIOS_ENTRY_POINT_30);
> > +                        mc->desc, false, true, SMBIOS_ENTRY_POINT_30=
);
>=20
> Surely this needs to be handled in back compatible manner so that exist=
ing
> machine types are not changed - only the new virt-2.12 machine type sho=
uld
> get new format.

On real hardware this table can change when there's a firmware update,
so I don't think any OS would expect it to stay the same across reboots.
I also can't imagine any applications caring at all about this,
particularly because it's currently the useless "1.0" string. I think
we're safe to neglect compat code in this case, but I may be missing
something. Is there a particular issue you're aware of that we'd risk
hitting? (Well, besides Windows detecting its installation machine has
"changed", invalidating its license or whatever. We don't yet have any
Windows guests to worry about.)

Thanks,
drew
