Received: from eggs.gnu.org ([2001:4830:134:3::10]:34243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sridhar_kulk@yahoo.com>) id 1egTFP-0005sb-NM
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 05:34:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sridhar_kulk@yahoo.com>) id 1egTFJ-00071C-J2
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 05:34:39 -0500
Received: from sonic304-10.consmr.mail.bf2.yahoo.com ([74.6.128.33]:36572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sridhar_kulk@yahoo.com>)
	id 1egTFJ-00070x-DN
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 05:34:33 -0500
Date: Tue, 30 Jan 2018 10:34:31 +0000 (UTC)
From: sridhar kulkarni <sridhar_kulk@yahoo.com>
Reply-To: sridhar kulkarni <sridhar_kulk@yahoo.com>
Message-ID: <1972503886.3523325.1517308471375@mail.yahoo.com>
MIME-Version: 1.0
References: <1972503886.3523325.1517308471375.ref@mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Savevm and loadvm not working
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi,
I am new bee to snapshot feature and how to use it correctly. My requiremen=
t is simple, in that I want to snapshot the running VM and save the snapsho=
t file. Using the snapshot file, I want to boot the VM directly to snapshot=
 state.I came across the qemu monitors "savevm" and "loadvm" commands. The =
following are the steps I follow to create snapshot and load the snapshot,S=
tep 1: Launch VM using below command,=20
qemu-system-arm -M arm-machine -m 512M -name my_name -kernel main.rbx -seri=
al pty -serial vc -serial vc -serial vc -drive if=3Dnone,format=3Dqcow2,fil=
e=3D/home/sridhar/qemu_disk_image/dummy.qcow2=20

Step 2: Save the snapshot (issue savevm from qemu monitor)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --> savevm my_snapshot

Step 3 Launch the VM using snapshot image saved in step 2,
qemu-system-arm -M arm-machine -m 512M -name my_name -kernel main.rbx -seri=
al pty -serial vc -serial vc -serial vc -drive if=3Dnone,format=3Dqcow2,fil=
e=3D/home/sridhar/qemu_disk_image/dummy.qcow2 -loadvm my_snapshot
With this approach, I am seeing that RAM contents are not getting saved whe=
n I issue "savevm" command. I have copied the part of the file, when the fu=
nction "ram_control_save_page" returns "RAM_SAVE_CONTROL_NOT_SUPP" and henc=
e the page is not getting saved.

size_t ram_control_save_page(QEMUFile *f, ram_addr_t block_offset,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ram_addr_t offset, size_t size,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 uint64_t *bytes_sent)
{
=C2=A0=C2=A0=C2=A0 if (f->hooks && f->hooks->save_page) {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D f->hooks->save_page(=
f, f->opaque, block_offset,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 of=
fset, size, bytes_sent);

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret !=3D RAM_SAVE_CONTROL_DE=
LAYED) {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (byte=
s_sent && *bytes_sent > 0) {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 qemu_update_position(f, *bytes_sent);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else i=
f (ret < 0) {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 qemu_file_set_error(f, ret);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
=C2=A0=C2=A0=C2=A0 }

=C2=A0=C2=A0=C2=A0 return RAM_SAVE_CONTROL_NOT_SUPP;
}

Is there anything that I am missing here in the understanding "savevm" and =
"loadvm" commands?=20

Thanks
