Received: from eggs.gnu.org ([209.51.188.92]:48824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gkSwV-0002GN-Og
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:08:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gkSwU-00020C-PP
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:08:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gkSwS-0001p8-F2
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:08:10 -0500
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Fri, 18 Jan 2019 13:01:38 +0100
Message-Id: <20190118120143.21631-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 0/5] pvh: add new PVH option rom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, George Kennedy <george.kennedy@oracle.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Maran Wilson <maran.wilson@oracle.com>, Liam Merwick <liam.merwick@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Richard Henderson <rth@twiddle.net>, Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

This patch series is based on "[PATCH v3 0/4] QEMU changes to do PVH boot=
" and
provides a PVH option rom that can be used with SeaBIOS to boot uncompres=
sed
kernel using the x86/HVM direct boot ABI.

Patches 1 and 2 are to prepare the PVH option rom, moving common function=
s in
the new headers.  Patch 3 adds the new PVH option rom. Patch 4 uses it wh=
en we
are booting an uncompressed kernel using the x86/HVM direct boot ABI. Pat=
ch 5
adds the support of loading the initrd in the PVH option rom.

Based-on: <1547554687-12687-1-git-send-email-liam.merwick@oracle.com>

Changes in v5:
- Patch 5: added R-b's
- Patch 3: updated .gitignore (by Liam)

Changes in v4:
- addressed comments by Paolo:
  - Patch 2: linuxboot_dma.c: moved includes after the asm block to avoid
    compiler error
  - Patch 3: Makefile: fixed pvh.img rule

Changes in v3:
- added R-b's
- added Patch 5 to support initrd
- addressed comments by Eric and Liam:
    - Patch 3: comments by Liam
    - Patch 4: moved Based-on tag in the cover letter (by Eric)
- Patch 3: added pc-bios/pvh.bin binary in the commit

Changes in v2:
- addressed comments by Stefan and Eric:
  - Patch 2: moved inludes on top of linuxboot_dma.c and add <stdint.h> i=
n
    optrom.h
  - Patch 4: added check of pvh.bin in xen_load_linux()
- modified commit message of patch 2 to explain better the patch

Stefano Garzarella (5):
  linuxboot_dma: remove duplicate definitions of FW_CFG
  linuxboot_dma: move common functions in a new header
  optionrom: add new PVH option rom
  hw/i386/pc: use PVH option rom
  optionrom/pvh: load initrd from fw_cfg

 .gitignore                        |   4 +
 Makefile                          |   2 +-
 hw/i386/pc.c                      |   5 +
 pc-bios/optionrom/Makefile        |   5 +-
 pc-bios/optionrom/linuxboot_dma.c | 114 +++--------------
 pc-bios/optionrom/optrom.h        | 110 ++++++++++++++++
 pc-bios/optionrom/optrom_fw_cfg.h |  92 ++++++++++++++
 pc-bios/optionrom/pvh.S           | 200 ++++++++++++++++++++++++++++++
 pc-bios/optionrom/pvh_main.c      | 133 ++++++++++++++++++++
 pc-bios/pvh.bin                   | Bin 0 -> 1536 bytes
 10 files changed, 568 insertions(+), 97 deletions(-)
 create mode 100644 pc-bios/optionrom/optrom.h
 create mode 100644 pc-bios/optionrom/optrom_fw_cfg.h
 create mode 100644 pc-bios/optionrom/pvh.S
 create mode 100644 pc-bios/optionrom/pvh_main.c
 create mode 100644 pc-bios/pvh.bin

--=20
2.20.1
