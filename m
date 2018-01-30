Received: from eggs.gnu.org ([2001:4830:134:3::10]:53339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1egUVa-0004y3-2V
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 06:55:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1egUVQ-0006VU-DC
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 06:55:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1egUVP-0006UB-M4
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 06:55:15 -0500
Date: Tue, 30 Jan 2018 19:55:10 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180130115510.GA13988@xz-mi>
References: <1972503886.3523325.1517308471375.ref@mail.yahoo.com>
	<1972503886.3523325.1517308471375@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1972503886.3523325.1517308471375@mail.yahoo.com>
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
To: sridhar kulkarni <sridhar_kulk@yahoo.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Tue, Jan 30, 2018 at 10:34:31AM +0000, sridhar kulkarni via Qemu-devel=
 wrote:
> Hi,
> I am new bee to snapshot feature and how to use it correctly. My requir=
ement is simple, in that I want to snapshot the running VM and save the s=
napshot file. Using the snapshot file, I want to boot the VM directly to =
snapshot state.I came across the qemu monitors "savevm" and "loadvm" comm=
ands. The following are the steps I follow to create snapshot and load th=
e snapshot,Step 1: Launch VM using below command,=20
> qemu-system-arm -M arm-machine -m 512M -name my_name -kernel main.rbx -=
serial pty -serial vc -serial vc -serial vc -drive if=3Dnone,format=3Dqco=
w2,file=3D/home/sridhar/qemu_disk_image/dummy.qcow2=20
>=20
> Step 2: Save the snapshot (issue savevm from qemu monitor)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --> savevm my_snapshot
>=20
> Step 3 Launch the VM using snapshot image saved in step 2,
> qemu-system-arm -M arm-machine -m 512M -name my_name -kernel main.rbx -=
serial pty -serial vc -serial vc -serial vc -drive if=3Dnone,format=3Dqco=
w2,file=3D/home/sridhar/qemu_disk_image/dummy.qcow2 -loadvm my_snapshot
> With this approach, I am seeing that RAM contents are not getting saved=
 when I issue "savevm" command.

Could I ask how do you know that RAM contents are not saved?  Is there
any error happened after your loadvm operation?

> I have copied the part of the file, when the function "ram_control_save=
_page" returns "RAM_SAVE_CONTROL_NOT_SUPP" and hence the page is not gett=
ing saved.
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
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D f->hooks->save_p=
age(f, f->opaque, block_offset,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 offset, size, bytes_sent);
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret !=3D RAM_SAVE_CONTRO=
L_DELAYED) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
bytes_sent && *bytes_sent > 0) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 qemu_update_position(f, *bytes_sent);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } el=
se if (ret < 0) {
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
> Is there anything that I am missing here in the understanding "savevm" =
and "loadvm" commands?=20
>=20
> Thanks

--=20
Peter Xu
