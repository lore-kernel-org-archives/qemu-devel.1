Received: from eggs.gnu.org ([2001:4830:134:3::10]:60547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gSsvc-00026q-TX
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 19:14:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gSsvY-0006If-Ur
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 19:14:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gSsvY-0006IK-Pb
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 19:14:32 -0500
From: Alex Williamson <alex.williamson@redhat.com>
Date: Fri, 30 Nov 2018 17:14:23 -0700
Message-ID: <154362326378.7153.16540171270213783793.stgit@gimli.home>
In-Reply-To: <154362272919.7153.15101701755308287523.stgit@gimli.home>
References: <154362272919.7153.15101701755308287523.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [for-3.2 PATCH 6/9] pcie: Allow generic PCIe root port
 to specify link speed and width
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Geoffrey McRae <geoff@hostfission.com>

Allow users to specify speed and width values for the generic PCIe
root port.  Defaults remain at 2.5GT/s & x1 for compatiblity.

Note for libvirt testing that pcie-root-port controllers are given
default names like "pci.7" which don't play well with using the
"-set device.$name.$prop=$value" options accessible to us via
<qemu:commandline> options.  The solution is to add an <alias> to the
pcie-root-port <controller>, for example:

    <controller type='pci' index='7' model='pcie-root-port'>
      <model name='pcie-root-port'/>
      <target chassis='7' port='0x15'/>
      <alias name='ua-gfx0'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x5'/>
    </controller>

The "ua-" here is a mandatory prefix.  We can then use:

  <qemu:commandline>
    <qemu:arg value='-set'/>
    <qemu:arg value='device.ua-gfx0.speed=8'/>
    <qemu:arg value='-set'/>
    <qemu:arg value='device.ua-gfx0.width=16'/>
  </qemu:commandline>

or, without an alias, set globals such as:

  <qemu:commandline>
    <qemu:arg value='-global'/>
    <qemu:arg value='pcie-root-port.speed=8'/>
    <qemu:arg value='-global'/>
    <qemu:arg value='pcie-root-port.width=16'/>
  </qemu:commandline>

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Tested-by: Geoffrey McRae <geoff@hostfission.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/pci-bridge/gen_pcie_root_port.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
index 299de429ec1e..e3bba2ab68ef 100644
--- a/hw/pci-bridge/gen_pcie_root_port.c
+++ b/hw/pci-bridge/gen_pcie_root_port.c
@@ -124,6 +124,8 @@ static Property gen_rp_props[] = {
                      res_reserve.mem_pref_32, -1),
     DEFINE_PROP_SIZE("pref64-reserve", GenPCIERootPort,
                      res_reserve.mem_pref_64, -1),
+    DEFINE_PROP_PCIE_LINK_SPEED("speed", PCIESlot, speed, PCIE_LINK_SPEED_2_5),
+    DEFINE_PROP_PCIE_LINK_WIDTH("width", PCIESlot, width, PCIE_LINK_WIDTH_1),
     DEFINE_PROP_END_OF_LIST()
 };
 
