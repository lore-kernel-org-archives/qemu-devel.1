Received: from eggs.gnu.org ([2001:4830:134:3::10]:33687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dVx5F-0006b4-2Y
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:40:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dVx5B-0007ZF-OY
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:40:25 -0400
Received: from chuckie.co.uk ([82.165.15.123]:41062
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dVx5B-0007Yu-HF
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:40:21 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 14 Jul 2017 10:40:05 +0100
Message-Id: <1500025208-14827-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv9 0/3] fw_cfg: qdev-related tidy-ups
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
Depends-on: https://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg01994.html <20170707213052.13087-1-ehabkost@redhat.com>

v9:
- Rebase onto master
- Reduce comment verbosity for fw_cfg_find()
- Remove local_err parameter from fw_cfg_common_realize() callers
  (instead use errp directly)

v8:
- Rebase onto master
- Drop patches 1 and 2 since they have already been applied
- Drop patch 4 since fw_cfg_unattached_at_realize() isn't required (it was a
  bug in object_resolve_path_type())
- Add comment on the return value of fw_cfg_find()
- Add Reviewed-By from Igor

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


Mark Cave-Ayland (3):
  fw_cfg: switch fw_cfg_find() to locate the fw_cfg device by type
    rather than path
  fw_cfg: move qdev_init_nofail() from fw_cfg_init1() to callers
  fw_cfg: move QOM type defines and fw_cfg types into fw_cfg.h

 hw/nvram/fw_cfg.c         |   79 +++++++++++----------------------------------
 include/hw/nvram/fw_cfg.h |   50 ++++++++++++++++++++++++++++
 include/qemu/typedefs.h   |    1 +
 3 files changed, 70 insertions(+), 60 deletions(-)

-- 
1.7.10.4
