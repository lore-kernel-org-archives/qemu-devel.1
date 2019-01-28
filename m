Received: from eggs.gnu.org ([209.51.188.92]:42380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1go7q2-0005px-Rm
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:24:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1go7q1-0003Ck-3x
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:24:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1go7q0-00037j-Lp
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:24:36 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3106DDA334
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 14:24:26 +0000 (UTC)
From: Bandan Das <bsd@redhat.com>
Date: Mon, 28 Jan 2019 09:24:07 -0500
Message-Id: <20190128142410.11584-1-bsd@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/3] Break down the MTP write operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com


v3:
  Added patch 3/3
v2:
  Rebased on top of master and retested

For larger files, not only do we keep reallocating to increase the mtp bu=
ffer
size, the write also happens in one go. This does two things:

Write to file upto a certain data size we have received so far and second=
,
reuse the buffer again instead of reallocating to a larger buffer size.

Tested with different file sizes on a Linux guest.


Bandan Das (3):
  usb-mtp: Reallocate buffer in multiples of MTP_WRITE_BUF_SZ
  usb-mtp: breakup MTP write into smaller chunks
  usb-mtp: replace the homebrew write with qemu_write_full

 hw/usb/dev-mtp.c | 166 +++++++++++++++++++++++++++++------------------
 1 file changed, 102 insertions(+), 64 deletions(-)

--=20
2.19.2
