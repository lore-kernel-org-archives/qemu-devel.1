Received: from eggs.gnu.org ([2001:4830:134:3::10]:49334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sridhar_kulk@yahoo.com>) id 1edwgK-00027D-N5
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 06:24:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sridhar_kulk@yahoo.com>) id 1edwgE-0001Ep-Ri
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 06:24:00 -0500
Received: from sonic309-13.consmr.mail.bf2.yahoo.com ([74.6.129.123]:45337)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sridhar_kulk@yahoo.com>)
	id 1edwgE-0001EK-KL
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 06:23:54 -0500
Date: Tue, 23 Jan 2018 11:23:44 +0000 (UTC)
From: sridhar kulkarni <sridhar_kulk@yahoo.com>
Reply-To: sridhar kulkarni <sridhar_kulk@yahoo.com>
Message-ID: <799086446.3202863.1516706624459@mail.yahoo.com>
MIME-Version: 1.0
References: <799086446.3202863.1516706624459.ref@mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] savevm snapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

I am working on creating a snapshot for ARM based VM running on A7. We don'=
t use disk images, so to save the snapshot I am passing "-drive if=3Dnone, =
format=3Dqcow2, file=3D/home/sridhar/qemu_disk_images/dummy.qcow2" as dummy=
 disk to save the snapshot.
Then from qemu monitor, I run the "savevm" command. The savevm seems to exe=
cute and return, however I don't see the RAM being copied correctly, and lo=
advm fails to restore the VM state.
When I debugged, I can see that in "ram_control_save_page", the condition h=
ighlighted=C2=A0 in bold below fails and function returns=C2=A0RAM_SAVE_CON=
TROL_NOT_SUPP.
Am I missing something here? From the documents available on qemu.org, I ca=
n see that savevm should take care of saving RAM contents as well, and it s=
hould work seamlessly.
Can you help on this?
-Sridhar

| size_t ram_control_save_page(QEMUFile *f, ram_addr_t block_offset, |
|  |  ram_addr_t offset, size_t size, |
|  |  uint64_t *bytes_sent) |
|  | { |
|  |   if (f->hooks && f->hooks->save_page) { |
|  |  int ret =3D f->hooks->save_page(f, f->opaque, block_offset, |
|  |  offset, size, bytes_sent); |
|  |  |
|  |  if (ret !=3D RAM_SAVE_CONTROL_DELAYED) { |
|  |  if (bytes_sent && *bytes_sent > 0) { |
|  |  qemu_update_position(f, *bytes_sent); |
|  |  } else if (ret < 0) { |
|  |  qemu_file_set_error(f, ret); |
|  |  } |
|  |  } |
|  |  |
|  |  return ret; |
|  |  } |
|  |  |
|  |  return RAM_SAVE_CONTROL_NOT_SUPP; |
|  | } |
