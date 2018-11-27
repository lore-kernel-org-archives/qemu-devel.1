Received: from eggs.gnu.org ([2001:4830:134:3::10]:60680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gRfoL-0001G0-7b
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 11:02:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gRfo9-0003Sp-3j
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 11:02:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gRfo8-0003S2-Sg
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 11:01:53 -0500
Date: Tue, 27 Nov 2018 16:01:44 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181127160144.GB2616@work-vm>
References: <20181115192446.17187-1-minyard@acm.org>
	<20181115192446.17187-7-minyard@acm.org>
	<20181126172308.GJ2547@work-vm>
	<7055e173-6f4f-7954-69c7-47e0f26dfaf6@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <7055e173-6f4f-7954-69c7-47e0f26dfaf6@acm.org>
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
To: Corey Minyard <minyard@acm.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

* Corey Minyard (minyard@acm.org) wrote:
> On 11/26/18 11:23 AM, Dr. David Alan Gilbert wrote:
> > * minyard@acm.org (minyard@acm.org) wrote:
> > > From: Corey Minyard <cminyard@mvista.com>
> > >=20
> > > Migration capability is being added for pm_smbus and SMBus devices.
> > > This change will allow backwards compatibility to be kept when
> > > migrating back to an old qemu version.  Add a bool to the machine
> > > class tho keep smbus migration from happening.  Future changes
> > > will use this.
> > So this is also going to have to be in the 3.0 and 3.1 machine option=
s
> > and maybe some other architectures?
>=20
> I'm not sure why it would need to be in both the 3.0 and 3.1 machine
> options.
> If this goes in, I'm assuming it's for 3.1 and it should only need to b=
e
> there.
> That's if it's too late for 3.0.

You're out by 1-2 releases;  3.0 shipped in August, 3.1 is in freeze at
the moment (hence you've missed it unless some part of this is
critical); so this will go in during the 4.0 release.

> The pm_smbus device is also used by mips fulong.=A0 From what I can tel=
l, that
> machine doesn't have any concept of backwards compatibility, so it seem=
ed
> save to no worry about it there.=A0 If it weren't for that, this bool c=
ould go
> into the

Yeh that's fine.

What about the eeprom's are they used more widely?

Dave

> PC specific structure.
>=20
> Thanks,
>=20
> -corey
>=20
> > Dave
> >=20
> > > Signed-off-by: Corey Minyard <cminyard@mvista.com>
> > > Cc: Eduardo Habkost <ehabkost@redhat.com>
> > > Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > > ---
> > >   hw/i386/pc_piix.c   | 1 +
> > >   hw/i386/pc_q35.c    | 1 +
> > >   include/hw/boards.h | 1 +
> > >   3 files changed, 3 insertions(+)
> > >=20
> > > diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> > > index cb28227cc3..3d1ccb1af1 100644
> > > --- a/hw/i386/pc_piix.c
> > > +++ b/hw/i386/pc_piix.c
> > > @@ -443,6 +443,7 @@ static void pc_i440fx_2_12_machine_options(Mach=
ineClass *m)
> > >       pc_i440fx_3_0_machine_options(m);
> > >       m->is_default =3D 0;
> > >       m->alias =3D NULL;
> > > +    m->smbus_no_migration_support =3D true;
> > >       SET_MACHINE_COMPAT(m, PC_COMPAT_2_12);
> > >   }
> > > diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> > > index 90e88c9b28..0c6fca6a40 100644
> > > --- a/hw/i386/pc_q35.c
> > > +++ b/hw/i386/pc_q35.c
> > > @@ -324,6 +324,7 @@ static void pc_q35_2_12_machine_options(Machine=
Class *m)
> > >   {
> > >       pc_q35_3_0_machine_options(m);
> > >       m->alias =3D NULL;
> > > +    m->smbus_no_migration_support =3D true;
> > >       SET_MACHINE_COMPAT(m, PC_COMPAT_2_12);
> > >   }
> > > diff --git a/include/hw/boards.h b/include/hw/boards.h
> > > index f82f28468b..65314fbe2a 100644
> > > --- a/include/hw/boards.h
> > > +++ b/include/hw/boards.h
> > > @@ -207,6 +207,7 @@ struct MachineClass {
> > >       void (*numa_auto_assign_ram)(MachineClass *mc, NodeInfo *node=
s,
> > >                                    int nb_nodes, ram_addr_t size);
> > >       bool ignore_boot_device_suffixes;
> > > +    bool smbus_no_migration_support;
> > >       HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
> > >                                              DeviceState *dev);
> > > --=20
> > > 2.17.1
> > >=20
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
