Received: from eggs.gnu.org ([209.51.188.92]:34488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hEXHu-0001lg-3q
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:50:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hEXHt-0006fH-4h
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:50:34 -0400
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 11 Apr 2019 12:50:24 +0200
Message-Id: <20190411105025.97397-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH RFC 0/1] block/rbd: increase dynamically the
 image size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Josh Durgin <jdurgin@redhat.com>, Kevin Wolf <kwolf@redhat.com>

RBD APIs don't allow us to write more than the maximum size of the file s=
et
with rbd_create() or rbd_resize(), so we are not able to create/use a qco=
w2
image with the rbd driver.

What I found is the following:
- when qcow2 uses the rbd driver, the new file is created (rbd_create)
  with the size equals to 0. (qemu_opt_get_size_del(opts,
  BLOCK_OPT_SIZE, 0) returns 0 in qemu_rbd_co_create_opts())
- the file is truncated (implemented with rbd_resize) to 0 before to
  write the qcow2 header.
- the "size" parameter passed to rbd_create() or rbd_resize() is
  interpreted as the maximum size of the file, this means that all
  writes that exceed that size, fails and returns -22.

As a workaround, I'm checking if the RW operations exceed the maximum
size and then I'll resize the file. It works, but I'm not sure it is the
right way.

Any suggestions?

Thanks,
Stefano

Stefano Garzarella (1):
  block/rbd: increase dynamically the image size

 block/rbd.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

--=20
2.20.1
