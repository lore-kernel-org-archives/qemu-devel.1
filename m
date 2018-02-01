Received: from eggs.gnu.org ([2001:4830:134:3::10]:54140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sridhar_kulk@yahoo.com>) id 1ehDpv-0000p6-Am
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 07:19:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sridhar_kulk@yahoo.com>) id 1ehDpq-0003di-BR
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 07:19:27 -0500
Received: from sonic310-13.consmr.mail.bf2.yahoo.com ([74.6.135.123]:42779)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sridhar_kulk@yahoo.com>)
	id 1ehDpq-0003dG-4Q
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 07:19:22 -0500
Date: Thu, 1 Feb 2018 12:19:20 +0000 (UTC)
From: sridhar kulkarni <sridhar_kulk@yahoo.com>
Reply-To: sridhar kulkarni <sridhar_kulk@yahoo.com>
Message-ID: <75114832.1210415.1517487560355@mail.yahoo.com>
In-Reply-To: <20180130115510.GA13988@xz-mi>
References: <1972503886.3523325.1517308471375.ref@mail.yahoo.com>
	<1972503886.3523325.1517308471375@mail.yahoo.com>
	<20180130115510.GA13988@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Savevm and loadvm not working
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

=20

    On Tuesday, January 30, 2018 5:25 PM, Peter Xu <peterx@redhat.com> wrot=
e:
=20

 On Tue, Jan 30, 2018 at 10:34:31AM +0000, sridhar kulkarni via Qemu-devel =
wrote:
> Hi,
> I am new bee to snapshot feature and how to use it correctly. My requirem=
ent is simple, in that I want to snapshot the running VM and save the snaps=
hot file. Using the snapshot file, I want to boot the VM directly to snapsh=
ot state.I came across the qemu monitors "savevm" and "loadvm" commands. Th=
e following are the steps I follow to create snapshot and load the snapshot=
,Step 1: Launch VM using below command,=20
> qemu-system-arm -M arm-machine -m 512M -name my_name -kernel main.rbx -se=
rial pty -serial vc -serial vc -serial vc -drive if=3Dnone,format=3Dqcow2,f=
ile=3D/home/sridhar/qemu_disk_image/dummy.qcow2=20
>=20
> Step 2: Save the snapshot (issue savevm from qemu monitor)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --> savevm my_snapshot
>=20
> Step 3 Launch the VM using snapshot image saved in step 2,
> qemu-system-arm -M arm-machine -m 512M -name my_name -kernel main.rbx -se=
rial pty -serial vc -serial vc -serial vc -drive if=3Dnone,format=3Dqcow2,f=
ile=3D/home/sridhar/qemu_disk_image/dummy.qcow2 -loadvm my_snapshot
> With this approach, I am seeing that RAM contents are not getting saved w=
hen I issue "savevm" command.

Could I ask how do you know that RAM contents are not saved?=C2=A0 Is there
any error happened after your loadvm operation?
I thought that RAM contents are not saved because of return value RAM_SAVE_=
CONTROL_NOT_SUPP. Now that you clarified about this, I debugged this furthe=
r. After doing loadvm operation, I am getting following error,qemu-system-a=
rm: error while loading state for instance 0x0 of device 'cpu'
qemu-system-arm: Error -1 while loading VM state
I figured out that, this error is because of following function returning F=
ALSE. "write_raw_cp_reg" writes a value and "read_raw_cp_reg" reads the val=
ue back. There is mismatch between what we write and what is being read bac=
k, and hence function returns FALSE.
Between I want to mention that, I am trying the snapshot on a VM which runs=
 ARM 7 core. I am not sure if this snapshot feature is fully function for A=
RM targets.

bool write_list_to_cpustate(ARMCPU *cpu)
{
=C2=A0=C2=A0=C2=A0 int i;
=C2=A0=C2=A0=C2=A0 bool ok =3D true;

=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < cpu->cpreg_array_len; i++) {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t regidx =3D kvm_to_cpreg=
_id(cpu->cpreg_indexes[i]);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t v =3D cpu->cpreg_values=
[i];
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const ARMCPRegInfo *ri;

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ri =3D get_arm_cp_reginfo(cpu->c=
p_regs, regidx);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ri) {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ok =3D f=
alse;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue=
;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ri->type & ARM_CP_NO_RAW) {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue=
;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Write value and confirm it re=
ads back as written
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * (to catch read-only regi=
sters and partially read-only
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * registers where the inco=
ming migration value doesn't match)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 write_raw_cp_reg(&cpu->env, ri, =
v);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (read_raw_cp_reg(&cpu->env, r=
i) !=3D v) {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ok =3D f=
alse;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
=C2=A0=C2=A0=C2=A0 }
=C2=A0=C2=A0=C2=A0 return ok;

> I have copied the part of the file, when the function "ram_control_save_p=
age" returns "RAM_SAVE_CONTROL_NOT_SUPP" and hence the page is not getting =
saved.
>=20
> size_t ram_control_save_page(QEMUFile *f, ram_addr_t block_offset,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ram_addr_t offset, size_t size,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 uint64_t *bytes_sent)
> {
> =C2=A0=C2=A0=C2=A0 if (f->hooks && f->hooks->save_page) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D f->hooks->save_pag=
e(f, f->opaque, block_offset,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 offset, size, bytes_sent);
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret !=3D RAM_SAVE_CONTROL_=
DELAYED) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (by=
tes_sent && *bytes_sent > 0) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 qemu_update_position(f, *bytes_sent);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else=
 if (ret < 0) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 qemu_file_set_error(f, ret);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> =C2=A0=C2=A0=C2=A0 }
>=20
> =C2=A0=C2=A0=C2=A0 return RAM_SAVE_CONTROL_NOT_SUPP;

Here IMHO as long as you are not using RDMA, this function should
always return with RAM_SAVE_CONTROL_NOT_SUPP.

And I do think the name is slightly misleading.

> }
>=20
> Is there anything that I am missing here in the understanding "savevm" an=
d "loadvm" commands?=20
>=20
> Thanks

--=20
Peter Xu


  =20
