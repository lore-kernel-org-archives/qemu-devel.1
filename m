Received: from eggs.gnu.org ([2001:4830:134:3::10]:50993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1eMv0v-0003Dv-7U
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 07:10:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1eMv0u-0006rn-E3
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 07:10:53 -0500
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <b630fe8c-6905-6743-d29d-ded450d5d10b@redhat.com>
Date: Thu, 7 Dec 2017 13:10:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] QEMU not honouring bootorder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: qemu-block@nongnu.org

Dear list,

I've encountered the following problem. I have two disks:

  /var/lib/libvirt/images/fedora.qcow2  (which contains OS)
  /dev/sde (iSCSI dummy disk just for testing)

Now, when I configure QEMU to start with both of them, QEMU/Seabios
tries to boot from /dev/sde which fails obviously. Even setting
bootorder does not help. Here's my command line:

  qemu-system-x86_64 \
  -boot menu=on,strict=on \
  -device lsi,id=scsi0,bus=pci.0 \
  -drive file=/var/lib/libvirt/images/fedora.qcow2,format=qcow2,if=none,id=drive-scsi0 \
  -device scsi-hd,bus=scsi0.0,drive=drive-scsi0,bootindex=1 \
  -drive file=/dev/sde,format=raw,if=none,id=drive-scsi1 \
  -device scsi-block,bus=scsi0.0,drive=drive-scsi1,bootindex=2

It was found that if 'drive-scsi1' is scsi-hd instead of scsi-block
everything works as expected and I can boot my guest successfully.

Michal
