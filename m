Received: from eggs.gnu.org ([2001:4830:134:3::10]:42729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gRht4-0003H3-OI
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 13:15:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gRhsw-00018q-A6
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 13:15:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:23887)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gRhst-00017F-GR
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 13:14:57 -0500
Date: Tue, 27 Nov 2018 18:14:49 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181127181448.GC2616@work-vm>
References: <20181115192446.17187-1-minyard@acm.org>
	<20181115192446.17187-7-minyard@acm.org>
	<20181126172308.GJ2547@work-vm>
	<7055e173-6f4f-7954-69c7-47e0f26dfaf6@acm.org>
	<20181127160144.GB2616@work-vm>
	<d01dc051-f078-c703-bd19-e1874afdfc33@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <d01dc051-f078-c703-bd19-e1874afdfc33@acm.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 06/12] boards.h: Ignore migration for
 SMBus devices on older machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Corey Minyard <minyard@acm.org>, lvivier@redhat.com, dgibson@redhat.com
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

* Corey Minyard (minyard@acm.org) wrote:
> On 11/27/18 10:01 AM, Dr. David Alan Gilbert wrote:
> > * Corey Minyard (minyard@acm.org) wrote:
> > > On 11/26/18 11:23 AM, Dr. David Alan Gilbert wrote:
> > > > * minyard@acm.org (minyard@acm.org) wrote:
> > > > > From: Corey Minyard <cminyard@mvista.com>
> > > > >=20
> > > > > Migration capability is being added for pm_smbus and SMBus devi=
ces.
> > > > > This change will allow backwards compatibility to be kept when
> > > > > migrating back to an old qemu version.  Add a bool to the machi=
ne
> > > > > class tho keep smbus migration from happening.  Future changes
> > > > > will use this.
> > > > So this is also going to have to be in the 3.0 and 3.1 machine op=
tions
> > > > and maybe some other architectures?
> > > I'm not sure why it would need to be in both the 3.0 and 3.1 machin=
e
> > > options.
> > > If this goes in, I'm assuming it's for 3.1 and it should only need =
to be
> > > there.
> > > That's if it's too late for 3.0.
> > You're out by 1-2 releases;  3.0 shipped in August, 3.1 is in freeze =
at
> > the moment (hence you've missed it unless some part of this is
> > critical); so this will go in during the 4.0 release.
>=20
> Yes, you are right, this is for 4.0.
>=20
>=20
> >=20
> > > The pm_smbus device is also used by mips fulong.=A0 From what I can=
 tell, that
> > > machine doesn't have any concept of backwards compatibility, so it =
seemed
> > > save to no worry about it there.=A0 If it weren't for that, this bo=
ol could go
> > > into the
> > Yeh that's fine.
> >=20
> > What about the eeprom's are they used more widely?
>=20
> The only other I2C EEPROM I see is hw/nvram/eeprom_at24c.c.=A0 That dev=
ice is
> only
> configured for PPC.=A0 It has a block device backend, too.=A0 This is a=
 little
> annoying
> because smbus_eeprom.c emulates an at24c02.=A0 It would be nice to only=
 have
> one of these.

Added in David and Laurent for odd-ppc stuff;  if I'm reading it right
it's not used by one of the versioned machines.

> I can add it to that file, too, it wouldn't be hard to do and I could p=
ut it
> into the
> x86 config to test.=A0 It would be nicer to combine the two; smbus_eepr=
om
> seems
> like a hack to me.=A0 at24c.c is done as an SMBus slave, its done as a =
raw I2C
> device, which is IMHO is more correct since the at24cxx devices are not
> SMBus
> devices, they are I2C devices.
>=20
> In fact, smbus_eeprom.c is the only thing currently using the smbus_sla=
ve
> code.
> The IPMI interface on SMBus that I have pending uses the smbus_slave co=
de,
> too,
> so perhaps there's value, though it's no big deal either way.=A0 It wou=
ld be
> nice to get
> this right the first time and not hack it up in the future.

Dave
>=20
> Thanks,
>=20
> -corey
>=20
>=20
> >=20
> > Dave
> >=20
> > > PC specific structure.
> > >=20
> > > Thanks,
> > >=20
> > > -corey
> > >=20
> > > > Dave
> > > >=20
> > > > > Signed-off-by: Corey Minyard <cminyard@mvista.com>
> > > > > Cc: Eduardo Habkost <ehabkost@redhat.com>
> > > > > Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > > > > ---
> > > > >    hw/i386/pc_piix.c   | 1 +
> > > > >    hw/i386/pc_q35.c    | 1 +
> > > > >    include/hw/boards.h | 1 +
> > > > >    3 files changed, 3 insertions(+)
> > > > >=20
> > > > > diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> > > > > index cb28227cc3..3d1ccb1af1 100644
> > > > > --- a/hw/i386/pc_piix.c
> > > > > +++ b/hw/i386/pc_piix.c
> > > > > @@ -443,6 +443,7 @@ static void pc_i440fx_2_12_machine_options(=
MachineClass *m)
> > > > >        pc_i440fx_3_0_machine_options(m);
> > > > >        m->is_default =3D 0;
> > > > >        m->alias =3D NULL;
> > > > > +    m->smbus_no_migration_support =3D true;
> > > > >        SET_MACHINE_COMPAT(m, PC_COMPAT_2_12);
> > > > >    }
> > > > > diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> > > > > index 90e88c9b28..0c6fca6a40 100644
> > > > > --- a/hw/i386/pc_q35.c
> > > > > +++ b/hw/i386/pc_q35.c
> > > > > @@ -324,6 +324,7 @@ static void pc_q35_2_12_machine_options(Mac=
hineClass *m)
> > > > >    {
> > > > >        pc_q35_3_0_machine_options(m);
> > > > >        m->alias =3D NULL;
> > > > > +    m->smbus_no_migration_support =3D true;
> > > > >        SET_MACHINE_COMPAT(m, PC_COMPAT_2_12);
> > > > >    }
> > > > > diff --git a/include/hw/boards.h b/include/hw/boards.h
> > > > > index f82f28468b..65314fbe2a 100644
> > > > > --- a/include/hw/boards.h
> > > > > +++ b/include/hw/boards.h
> > > > > @@ -207,6 +207,7 @@ struct MachineClass {
> > > > >        void (*numa_auto_assign_ram)(MachineClass *mc, NodeInfo =
*nodes,
> > > > >                                     int nb_nodes, ram_addr_t si=
ze);
> > > > >        bool ignore_boot_device_suffixes;
> > > > > +    bool smbus_no_migration_support;
> > > > >        HotplugHandler *(*get_hotplug_handler)(MachineState *mac=
hine,
> > > > >                                               DeviceState *dev)=
;
> > > > > --=20
> > > > > 2.17.1
> > > > >=20
> > > > --
> > > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > >=20
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
