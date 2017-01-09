Received: from eggs.gnu.org ([2001:4830:134:3::10]:60137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQa9v-0005EX-W6
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:38:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQa9v-0000vA-30
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:38:48 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cQa9u-0000ui-S8
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:38:47 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Jan 2017 13:38:41 +0000
Message-Id: <1483969123-14839-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/2] virtio-gpu: fix issues with VM load code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

These patches fix a couple of issues with the VM load code
which I noticed while investigating a coverity warning.

The first patch fixes a problem with the accounting for
host pixmap memory usage -- we didn't recalculate the
current usage following a VM migration, but instead
started again at zero, which means that if you keep
bumping the VM from host to host you can sidestep the
host_maxmem limit.

The second patch fixes the coverity warning (that if we
fail in the "creating resources" loop in the load function
we will leak memory and so on). The leak isn't very
serious, because if we fail the inbound migration then
the whole QEMU process is pretty useless for anything,
but it's easy enough to fix "correctly", ie so that a
subsequent system reset will put the device back into
a sane state.

Peter Maydell (2):
  virtio-gpu: Recalculate VirtIOGPU::hostmem on VM load
  virtio-gpu: Fix memory leak in virtio_gpu_load()

 hw/display/virtio-gpu.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

-- 
2.7.4
