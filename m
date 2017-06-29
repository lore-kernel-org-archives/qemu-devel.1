Received: from eggs.gnu.org ([2001:4830:134:3::10]:34977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dQa6c-0006BV-PG
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:07:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dQa6Y-0006xv-PL
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:07:38 -0400
Received: from chuckie.co.uk ([82.165.15.123]:60687
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dQa6Y-0006xg-J6
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:07:34 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu, 29 Jun 2017 15:07:14 +0100
Message-Id: <1498745240-30658-1-git-send-email-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCHv7 0/6] fw_cfg: qdev-related tidy-ups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, lersek@redhat.com, somlo@cmu.edu, ehabkost@redhat.com, mst@redhat.com, pbonzini@redhat.com, rjones@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org

As part of some ongoing sun4u work, I need to be able to wire the fw_cfg
IO interface to a separate IO space by instantiating the qdev device instead
of calling fw_cfg_init_io(). This patchset brings FW_CFG_IO in line with
FW_CFG_MEM and tidies up the realize methods accordingly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

v7:
- Remove instance_init() function with assert()
- Switch fw_cfg_find() over to use object_resolve_path_type() which removes the
  need for the fw_cfg device to exist at a fixed QOM path
- Switch check for existence of another fw_cfg device over to use the new
  fw_cfg_find()
- Add check for fw_cfg parent at realize time

v6:
- Revert move of FWCfgEntry from fw_cfg.c to fw_cfg.h from v5
- Add Reviewed-by tag from Laszlo for patch 5
- Add Tested-by tags from Laszlo for the series

v5:
- Remove unused FWCfgIoState iobase and dma_iobase fields
- Add Reviewed-By tags from Laszlo
- Update commit message in patch 5 as suggested by Laszlo
- Move FWCfgEntry typedef from fw_cfg.h to typedefs.h with the others

v4:
- Undo accidental typedef change in patch 5 caught in v3 rework

v3:
- Rework patch 1 to use sysbus_add_io() as suggested by Laszlo
- Add Reviewed-By from Laszlo for patch 2
- Fix assert() when instantiating > 1 fw_cfg device (new patch 3)
- Rename fw_cfg_init1() to fw_cfg_common_realize() as part of patch 4

v2:
- Fix the QOM bug in patch 1 as indicated by Laszlo
- Minimise code churn compared to v1


Mark Cave-Ayland (6):
  fw_cfg: don't map the fw_cfg IO ports in fw_cfg_io_realize()
  fw_cfg: move setting of FW_CFG_VERSION_DMA bit to fw_cfg_init1()
  fw_cfg: switch fw_cfg_find() to locate the fw_cfg device by type
    rather than path
  fw_cfg: add assert() to ensure the fw_cfg device has been added as a
    child property
  fw_cfg: move qdev_init_nofail() from fw_cfg_init1() to callers
  fw_cfg: move QOM type defines and fw_cfg types into fw_cfg.h

 hw/nvram/fw_cfg.c         |  133 +++++++++++++++++++--------------------------
 include/hw/nvram/fw_cfg.h |   50 +++++++++++++++++
 include/qemu/typedefs.h   |    1 +
 3 files changed, 108 insertions(+), 76 deletions(-)

-- 
1.7.10.4
