Received: from eggs.gnu.org ([209.51.188.92]:58003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1goTIn-0003n5-8q
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:19:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1goTIm-0003nu-H0
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:19:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1goTIl-0003li-9f
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:19:43 -0500
From: Bandan Das <bsd@redhat.com>
Date: Tue, 29 Jan 2019 08:19:05 -0500
Message-Id: <20190129131908.27924-1-bsd@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 0/3] Break down the MTP write operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, eblake@redhat.com, peter.maydell@linaro.org

v4:
  Used KiB for MTP_WRITE_BUF_SZ (1/3)
  Add back the Suggested-by tag (3/3)
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

 hw/usb/dev-mtp.c | 167 +++++++++++++++++++++++++++++------------------
 1 file changed, 103 insertions(+), 64 deletions(-)

--=20
2.19.2
