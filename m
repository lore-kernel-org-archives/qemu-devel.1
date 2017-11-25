Received: from eggs.gnu.org ([2001:4830:134:3::10]:47625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eIcBq-0005N1-3l
	for qemu-devel@nongnu.org; Sat, 25 Nov 2017 10:16:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eIcBm-00054A-VW
	for qemu-devel@nongnu.org; Sat, 25 Nov 2017 10:16:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eIcBm-000543-PE
	for qemu-devel@nongnu.org; Sat, 25 Nov 2017 10:16:18 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Sat, 25 Nov 2017 13:16:04 -0200
Message-Id: <20171125151610.20547-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/6] Replace has_dynamic_sysbus with list of
 allowed device types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jgross@suse.com, Thomas Huth <thuth@redhat.com>, sstabellini@kernel.org, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>

Changes v1 (RFC) -> v2:
* Patch 1 now just adds TYPE_SYS_BUS_DEVICE to the existing
  has_dynamic_sysbus=3Dtrue machines, and other patches make
  the lists on each machine-type more specific.
* Change the name of the new field to
  allowed_dynamic_sysbus_devices.
* The q35 allowed list is much shorter because the list of
  user-creatable sysbus devices in QEMU is shorter.
* Keep the xen_set_dynamic_sysbus() hack, just change it
  to add 'xen-sysdev" to the allowed list.
* Simplified the arm/virt code.

Summary
-------

This series replaces the existing has_dynamic_sysbus flag (that
makes the machine accept every user-creatable sysbus device type
on the command-line) with a list of allowed devices.

This will be helpful when implementing the new query-device-slots
command, because each machine type will include only the sysbus
devices it really supports, instead of including a catch-all
TYPE_SYS_BUS_DEVICE "slot".

This will be useful to add support to new sysbus devices on
machines like pc_piix, that don't have has_dynamic_sysbus set
today.

This also makes the code safer: just compiling a new sysbus
device in the same QEMU binary won't make a machine-type
automatically start accepting the device.

Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: Alexander Graf <agraf@suse.de>

Eduardo Habkost (6):
  machine: Replace has_dynamic_sysbus with list of allowed devices
  hw/arm/virt: Allow only supported dynamic sysbus devices
  ppc: e500: Allow only supported dynamic sysbus devices
  spapr: Allow only supported dynamic sysbus devices
  xen: Add only xen-sysdev to dynamic sysbus device list
  q35: Allow only supported dynamic sysbus devices

 include/hw/boards.h  |  5 ++++-
 hw/arm/virt.c        |  5 ++++-
 hw/core/machine.c    | 43 +++++++++++++++++++++++++++++--------------
 hw/i386/pc_q35.c     |  5 ++++-
 hw/ppc/e500plat.c    |  4 +++-
 hw/ppc/spapr.c       |  2 +-
 hw/xen/xen_backend.c |  2 +-
 7 files changed, 46 insertions(+), 20 deletions(-)

--=20
2.13.6
