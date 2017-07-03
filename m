Received: from eggs.gnu.org ([2001:4830:134:3::10]:50269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=35088db86=owen.smith@citrix.com>)
	id 1dS1Ev-0006sE-66
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 09:18:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=35088db86=owen.smith@citrix.com>)
	id 1dS1Er-0003ol-U4
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 09:18:09 -0400
Received: from smtp.citrix.com ([66.165.176.89]:18422)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=35088db86=owen.smith@citrix.com>)
	id 1dS1Er-0003oA-Ny
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 09:18:05 -0400
From: Owen Smith <owen.smith@citrix.com>
Date: Mon, 3 Jul 2017 13:17:39 +0000
Message-ID: <1499087861-2132-1-git-send-email-owen.smith@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/2 v2] xenfb: Fix protocol for HVM guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xen.org, sstabellini@kernel.org, anthony.perard@citrix.com, kraxel@redhat.com, Owen Smith <owen.smith@citrix.com>

This series is intended to alow HVM guests to use the vkbd device with a
PV frontend driver. Initial version at:
http://xenbits.xen.org/gitweb/?p=pvdrivers/win/xenvkbd.git;a=tree

Since the vkbd device is initialised for HVM guests, using the vkbd device
can allow the disabling of the USB controller and USB tablet and maintaining
the same easy to use absolute pointer. The main problem, is that the vkbd 
device does not connect unless a vfb device is present, to facilitate the
rescaling of absolute coordinates.
This series rearranges the input handlers to use the qemu_input_handler_*
functions, by using the callbacks directly, rather than via the compatability
layer in input-legacy.c. The series also registers the "feature-raw-pointer"
feature to indicate the backend can supply raw unscaled absolute cordinates.
The frontend uses "request-raw-pointer" to request raw unscaled values.

Adding the feature is also to enable detecting the difference between older,
broken, backend and newer backends that can connect without the vfb present.

v2:
* reworks the input handlers to use qemu_input_handler_* functions
* rename the feature proposed to a better name - the name better reflects the
  intended use-case (raw pointer vs backend requires vfb device)

Owen Smith (2):
  xenfb: Use qemu_input_handler_* calls directly
  xenfb: Allow vkbd to connect without a DisplayState

 hw/display/xenfb.c | 157 +++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 139 insertions(+), 18 deletions(-)

-- 
2.1.4
