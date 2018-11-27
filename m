Received: from eggs.gnu.org ([2001:4830:134:3::10]:44722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gRhyT-0006ST-Vk
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 13:20:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gRhyQ-00046l-0H
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 13:20:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gRhyP-00046T-PI
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 13:20:37 -0500
Date: Tue, 27 Nov 2018 18:20:09 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181127182008.GD2616@work-vm>
References: <20181115192446.17187-1-minyard@acm.org>
	<20181115192446.17187-8-minyard@acm.org>
	<20181126172058.GI2547@work-vm>
	<9d4437e4-c9ab-913d-5ac6-e9338b26a0a8@acm.org>
	<9b21748b-10b9-427b-2822-18b5c3cd5066@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <9b21748b-10b9-427b-2822-18b5c3cd5066@acm.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 07/12] i2c:pm_smbus: Fix state transfer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Corey Minyard <minyard@acm.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>

* Corey Minyard (minyard@acm.org) wrote:
> On 11/26/18 12:24 PM, Corey Minyard wrote:
> > On 11/26/18 11:20 AM, Dr. David Alan Gilbert wrote:
> > > * minyard@acm.org (minyard@acm.org) wrote:
> > > > From: Corey Minyard <cminyard@mvista.com>
> > > >=20
> > > > Transfer the state information for the SMBus registers and
> > > > internal data so it will work on a VM transfer.
> > > >=20
> > > > Signed-off-by: Corey Minyard <cminyard@mvista.com>
> > > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > > Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > > ---
> > > > =A0 hw/acpi/piix4.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 3 ++-
> > > > =A0 hw/i2c/pm_smbus.c=A0=A0=A0=A0=A0=A0=A0=A0 | 31 ++++++++++++++=
+++++++++++++++++
> > > > =A0 hw/i2c/smbus_ich9.c=A0=A0=A0=A0=A0=A0 |=A0 6 ++++--
> > > > =A0 include/hw/i2c/pm_smbus.h |=A0 2 ++
> > > > =A0 4 files changed, 39 insertions(+), 3 deletions(-)
> > > >=20
> > > > diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> > > > index e330f24c71..313305f5a0 100644
> > > > --- a/hw/acpi/piix4.c
> > > > +++ b/hw/acpi/piix4.c
> > > > @@ -309,7 +309,7 @@ static const VMStateDescription
> > > > vmstate_cpuhp_state =3D {
> > > > =A0=A0 */
> > > > =A0 static const VMStateDescription vmstate_acpi =3D {
> > > > =A0=A0=A0=A0=A0 .name =3D "piix4_pm",
> > > > -=A0=A0=A0 .version_id =3D 3,
> > > > +=A0=A0=A0 .version_id =3D 4,
> > > OK, so do we need to bump this version ?=A0 Ideally you'd keep the =
version
> > > as is and let the needed do the work.
> >=20
> >=20
> > Got it, that makes sense.=A0 Same for the comments below, I'll get al=
l
> > those.
> >=20
> Well, maybe not.=A0 the .needed function is only called on the save sid=
e, it
> is
> not called on the load side=A0 So a 2.12 to 3.0 transfer fails.=A0 So I=
've
> exported
> the migration needed function and I'm using the VMSTATE_STRUCT_TEST()
> function to transfer it in each case.=A0 With that I can migrate from 2=
.12 to
> 3.0 and back without issue.

Ah OK, that's an interesting observation; I hadn't realised it wasn't
symmetric like that, but I can kind of see why thinking about how the
code got that way.

Dave

> -corey
>=20
>=20
> > Thanks,
> >=20
> > -corey
> >=20
> >=20
> > > > =A0=A0=A0=A0=A0 .minimum_version_id =3D 3,
> > > > =A0=A0=A0=A0=A0 .minimum_version_id_old =3D 1,
> > > > =A0=A0=A0=A0=A0 .load_state_old =3D acpi_load_old,
> > > > @@ -320,6 +320,7 @@ static const VMStateDescription vmstate_acpi =
=3D {
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 VMSTATE_UINT16(ar.pm1.evt.en, PIIX4PM=
State),
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 VMSTATE_UINT16(ar.pm1.cnt.cnt, PIIX4P=
MState),
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 VMSTATE_STRUCT(apm, PIIX4PMState, 0, =
vmstate_apm, APMState),
> > > > +=A0=A0=A0=A0=A0=A0=A0 VMSTATE_STRUCT(smb, PIIX4PMState, 4, pmsmb=
_vmstate, PMSMBus),
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 VMSTATE_TIMER_PTR(ar.tmr.timer, PIIX4=
PMState),
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 VMSTATE_INT64(ar.tmr.overflow_time, P=
IIX4PMState),
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 VMSTATE_STRUCT(ar.gpe, PIIX4PMState, =
2, vmstate_gpe,
> > > > ACPIGPE),
> > > > diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
> > > > index 8793113c25..75907e1c22 100644
> > > > --- a/hw/i2c/pm_smbus.c
> > > > +++ b/hw/i2c/pm_smbus.c
> > > > @@ -19,6 +19,7 @@
> > > > =A0=A0 */
> > > > =A0 #include "qemu/osdep.h"
> > > > =A0 #include "hw/hw.h"
> > > > +#include "hw/boards.h"
> > > > =A0 #include "hw/i2c/pm_smbus.h"
> > > > =A0 #include "hw/i2c/smbus_master.h"
> > > > =A0 @@ -450,6 +451,36 @@ static const MemoryRegionOps pm_smbus_op=
s =3D {
> > > > =A0=A0=A0=A0=A0 .endianness =3D DEVICE_LITTLE_ENDIAN,
> > > > =A0 };
> > > > =A0 +static bool pm_smbus_vmstate_needed(void *opaque)
> > > > +{
> > > > +=A0=A0=A0 MachineClass *mc =3D MACHINE_GET_CLASS(qdev_get_machin=
e());
> > > > +
> > > > +=A0=A0=A0 return !mc->smbus_no_migration_support;
> > > > +}
> > > OK
> > >=20
> > > > +const VMStateDescription pmsmb_vmstate =3D {
> > > > +=A0=A0=A0 .name =3D "pmsmb",
> > > > +=A0=A0=A0 .version_id =3D 1,
> > > > +=A0=A0=A0 .minimum_version_id =3D 1,
> > > > +=A0=A0=A0 .needed =3D pm_smbus_vmstate_needed,
> > > > +=A0=A0=A0 .fields =3D (VMStateField[]) {
> > > > +=A0=A0=A0=A0=A0=A0=A0 VMSTATE_UINT8(smb_stat, PMSMBus),
> > > > +=A0=A0=A0=A0=A0=A0=A0 VMSTATE_UINT8(smb_ctl, PMSMBus),
> > > > +=A0=A0=A0=A0=A0=A0=A0 VMSTATE_UINT8(smb_cmd, PMSMBus),
> > > > +=A0=A0=A0=A0=A0=A0=A0 VMSTATE_UINT8(smb_addr, PMSMBus),
> > > > +=A0=A0=A0=A0=A0=A0=A0 VMSTATE_UINT8(smb_data0, PMSMBus),
> > > > +=A0=A0=A0=A0=A0=A0=A0 VMSTATE_UINT8(smb_data1, PMSMBus),
> > > > +=A0=A0=A0=A0=A0=A0=A0 VMSTATE_UINT32(smb_index, PMSMBus),
> > > > +=A0=A0=A0=A0=A0=A0=A0 VMSTATE_UINT8_ARRAY(smb_data, PMSMBus, PM_=
SMBUS_MAX_MSG_SIZE),
> > > > +=A0=A0=A0=A0=A0=A0=A0 VMSTATE_UINT8(smb_auxctl, PMSMBus),
> > > > +=A0=A0=A0=A0=A0=A0=A0 VMSTATE_BOOL(i2c_enable, PMSMBus),
> > > > +=A0=A0=A0=A0=A0=A0=A0 VMSTATE_BOOL(op_done, PMSMBus),
> > > > +=A0=A0=A0=A0=A0=A0=A0 VMSTATE_BOOL(in_i2c_block_read, PMSMBus),
> > > > +=A0=A0=A0=A0=A0=A0=A0 VMSTATE_BOOL(start_transaction_on_status_r=
ead, PMSMBus),
> > > > +=A0=A0=A0=A0=A0=A0=A0 VMSTATE_END_OF_LIST()
> > > > +=A0=A0=A0 }
> > > > +};
> > > > +
> > > > =A0 void pm_smbus_init(DeviceState *parent, PMSMBus *smb, bool
> > > > force_aux_blk)
> > > > =A0 {
> > > > =A0=A0=A0=A0=A0 smb->op_done =3D true;
> > > > diff --git a/hw/i2c/smbus_ich9.c b/hw/i2c/smbus_ich9.c
> > > > index e6d8d28194..c9b7482a54 100644
> > > > --- a/hw/i2c/smbus_ich9.c
> > > > +++ b/hw/i2c/smbus_ich9.c
> > > > @@ -45,10 +45,12 @@ typedef struct ICH9SMBState {
> > > > =A0 =A0 static const VMStateDescription vmstate_ich9_smbus =3D {
> > > > =A0=A0=A0=A0=A0 .name =3D "ich9_smb",
> > > > -=A0=A0=A0 .version_id =3D 1,
> > > > +=A0=A0=A0 .version_id =3D 2,
> > > Again, do we need to bump this?
> > >=20
> > > > =A0=A0=A0=A0=A0 .minimum_version_id =3D 1,
> > > > =A0=A0=A0=A0=A0 .fields =3D (VMStateField[]) {
> > > > -=A0=A0=A0=A0=A0=A0=A0 VMSTATE_PCI_DEVICE(dev, struct ICH9SMBStat=
e),
> > > > +=A0=A0=A0=A0=A0=A0=A0 VMSTATE_PCI_DEVICE(dev, ICH9SMBState),
> > > > +=A0=A0=A0=A0=A0=A0=A0 VMSTATE_BOOL_V(irq_enabled, ICH9SMBState, =
2),
> > > Can we make this a VMSTATE_BOOL_TEST (see VMSTATE_UINT64_TEST for t=
he
> > > pattern) tied to the same .neede, and again we don't need to bump t=
he
> > > version.
> > >=20
> > > > +=A0=A0=A0=A0=A0=A0=A0 VMSTATE_STRUCT(smb, ICH9SMBState, 2, pmsmb=
_vmstate, PMSMBus),
> > > So that's taken care of by the .needed.
> > >=20
> > > Dave
> > >=20
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 VMSTATE_END_OF_LIST()
> > > > =A0=A0=A0=A0=A0 }
> > > > =A0 };
> > > > diff --git a/include/hw/i2c/pm_smbus.h b/include/hw/i2c/pm_smbus.=
h
> > > > index 7bcca97672..5075fc64fa 100644
> > > > --- a/include/hw/i2c/pm_smbus.h
> > > > +++ b/include/hw/i2c/pm_smbus.h
> > > > @@ -43,4 +43,6 @@ typedef struct PMSMBus {
> > > > =A0 =A0 void pm_smbus_init(DeviceState *parent, PMSMBus *smb, boo=
l
> > > > force_aux_blk);
> > > > =A0 +extern const VMStateDescription pmsmb_vmstate;
> > > > +
> > > > =A0 #endif /* PM_SMBUS_H */
> > > > --=20
> > > > 2.17.1
> > > >=20
> > > --=20
> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >=20
> >=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
