Received: from eggs.gnu.org ([2001:4830:134:3::10]:36193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gUdJ5-0000CH-Cy
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 14:58:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gUdJ0-0005sx-Li
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 14:58:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gUdJ0-0005ri-Dx
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 14:57:58 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed,  5 Dec 2018 17:57:02 -0200
Message-Id: <20181205195704.17605-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH for-4.0 v4 0/2] virtio: Provide
 version-specific variants of virtio PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gonglei <arei.gonglei@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Amit Shah <amit@kernel.org>, Andrea Bolognani <abologna@redhat.com>, Cleber Rosa <crosa@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Fam Zheng <famz@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, libvir-list@redhat.com, Wainer dos Santos Moschetta <wainersm@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Markus Armbruster <armbru@redhat.com>, Laine Stump <laine@redhat.com>, Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Caio Carrara <ccarrara@redhat.com>

Existing modern-only device types are not being touched by v3, as
they don't need separate variants.  However, I plan to implement
separate cleanups in the code that calls virtio_pci_force_virtio_1(),
first, and then propose additional changes (e.g. deprecating
disable-legacy and disable-modern in those device types).

Changes v3 -> v4:
* Trivial comment fixes (Cornelia Huck)
* Test code update (Caio Carrara)

Changes v2 -> v3:
* Split into two separate patches (type registration helper
  and introduction of new types)
* Rewrote virtio_pci_types_register() completely:
  * Replaced magic generation of type names with explicit fields in
    VirtioPCIDeviceTypeInfo
  * Removed modern_only field (not necessary anymore)
  * Don't register a separate base type unless necessary

Changes v1 -> v2:
* Removed *-0.9 devices.  Nobody will want to use them, if
  transitional devices work with legacy drivers
  (Gerd Hoffmann, Michael S. Tsirkin)
* Drop virtio version from name: rename -1.0-transitional to
  -transitional (Michael S. Tsirkin)
* Renamed -1.0 to -non-transitional
* Don't add any extra variants to modern-only device types
  (they don't need it)
* Fix typo on TYPE_VIRTIO_INPUT_HOST_PCI (crash reported by
  Cornelia Huck)
* No need to change cast macros for modern-only devices
* Rename virtio_register_types() to virtio_pci_types_register()

Original patch description:

Many of the current virtio-*-pci device types actually represent
3 different types of devices:
* virtio 1.0 non-transitional devices
* virtio 1.0 transitional devices
* virtio 0.9 ("legacy device" in virtio 1.0 terminology)

That would be just an annoyance if it didn't break our device/bus
compatibility QMP interfaces.  With this multi-purpose device
type, there's no way to tell management software that
transitional devices and legacy devices require a Conventional
PCI bus.

The multi-purpose device types would also prevent us from telling
management software what's the PCI vendor/device ID for them,
because their PCI IDs change at runtime depending on the bus
where they were plugged.

This patch adds separate device types for each of those virtio
device flavors:

* virtio-*-pci: the existing multi-purpose device types
* virtio-*-pci-transitional: virtio-1.0 device supporting legacy drivers
* virtio-*-pci-non-transitional: modern-only

Reference to previous discussion that originated this idea:
  https://www.mail-archive.com/qemu-devel@nongnu.org/msg558389.html

Eduardo Habkost (2):
  virtio: Helper for registering virtio device types
  virtio: Provide version-specific variants of virtio PCI devices

 hw/virtio/virtio-pci.h             |  78 +++++++--
 hw/display/virtio-gpu-pci.c        |   7 +-
 hw/display/virtio-vga.c            |   7 +-
 hw/virtio/virtio-crypto-pci.c      |   7 +-
 hw/virtio/virtio-pci.c             | 267 ++++++++++++++++++++++-------
 tests/acceptance/virtio_version.py | 176 +++++++++++++++++++
 6 files changed, 452 insertions(+), 90 deletions(-)
 create mode 100644 tests/acceptance/virtio_version.py

-- 
2.18.0.rc1.1.g3f1ff2140
