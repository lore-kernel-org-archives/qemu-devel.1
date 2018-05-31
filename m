Received: from eggs.gnu.org ([2001:4830:134:3::10]:36792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fOTbe-0001iW-GZ
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:51:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fOTba-0006V1-LW
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:51:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35334 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fOTba-0006Pz-H4
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:51:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6241E7D83A
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 19:51:20 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 31 May 2018 21:51:15 +0200
Message-Id: <20180531195119.22021-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/4] Fix usb-ccid hotplug regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, spopovyc@redhat.com, kraxel@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

The following series fixes the usb-ccid hotplug regression introduced
by commit 675f22c6d3b0: the plugged device is not completely removed
on device_del anymore, due to an extra reference added when doing
set_link(). It turns out the memory management of qdev bus/child is a
bit weird, this is my attempt to improve the situation and fix the
regression.

Fixes:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1556678

Marc-Andr=C3=A9 Lureau (4):
  bus: do not unref the added child bus on realize
  object: fix OBJ_PROP_LINK_UNREF_ON_RELEASE ambivalence
  usb-ccid: fix bus leak
  usb-hcd-xhci-test: add a test for ccid hotplug

 include/qom/object.h          | 12 +++++++++---
 hw/core/bus.c                 |  1 -
 hw/core/qdev-properties.c     |  2 +-
 hw/core/qdev.c                |  2 +-
 hw/display/xlnx_dp.c          |  2 +-
 hw/dma/xilinx_axidma.c        |  4 ++--
 hw/dma/xlnx-zdma.c            |  2 +-
 hw/i386/pc.c                  |  2 +-
 hw/i386/pc_piix.c             |  2 +-
 hw/i386/pc_q35.c              |  2 +-
 hw/ipmi/ipmi.c                |  2 +-
 hw/net/xilinx_axienet.c       |  4 ++--
 hw/ssi/xilinx_spips.c         |  2 +-
 hw/usb/dev-smartcard-reader.c |  1 +
 net/can/can_host.c            |  2 +-
 net/colo-compare.c            |  2 +-
 qom/object.c                  |  8 +++++---
 target/arm/cpu.c              |  4 ++--
 tests/usb-hcd-xhci-test.c     | 10 ++++++++++
 ui/console.c                  |  2 +-
 20 files changed, 43 insertions(+), 25 deletions(-)


base-commit: c181ddaa176856b3cd2dfd12bbcf25fa9c884a97
--=20
2.17.1.906.g10fd178552
