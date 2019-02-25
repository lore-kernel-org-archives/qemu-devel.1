Received: from eggs.gnu.org ([209.51.188.92]:33025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gyDRC-00069V-Is
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 05:24:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gyDRB-0002yJ-7d
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 05:24:42 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53194)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gyDR9-0002uZ-CM
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 05:24:41 -0500
Received: by mail-wm1-x342.google.com with SMTP id m1so7504071wml.2
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 02:24:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Feb 2019 10:24:26 +0000
Message-Id: <20190225102433.22401-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 0/7] ui/cocoa: Use OSX's main loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Roman Bolshakov <r.bolshakv@yadro.com>, BALATON Zoltan <balaton@eik.bme.hu>, John Arbuckle <programmingkidx@gmail.com>, Berkus Decker <berkus@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Ben Hekster <ben.hekster@foghorn.io>

This set of patches rearranges how we handle events on
the OSX Cocoa UI so that we use the main thread to run
the OSX event loop, and we don't do a long blocking
operation from the applicationDidFinishLaunching callback.
Instead we create a second thread which runs qemu_main()
and becomes the QEMU main-loop thread. The callbacks from
QEMU into the cocoa code asynchronously dispatch their
work to the main thread, and the main thread takes the
iothread lock before calling into QEMU code.

The changes from v2 to v3 are all minor, and all patches
have now had review/test; I plan to apply this to master
towards the end of the week, absent any further review
comments.

 * patch 1: add with_iothread_lock wrap to qmp_stop/qmp_cont calls
 * patch 5: remove stray whitespace
 * patch 7: remove unnecessary null check on cocoaView
 * patch 7: make semaphore variables file-local
 * patch 7: deref pixman_image in dealloc

thanks
-- PMM

Peter Maydell (7):
  ui/cocoa: Ensure we have the iothread lock when calling into QEMU
  ui/cocoa: Use the pixman image directly in switchSurface
  ui/cocoa: Factor out initial menu creation
  ui/cocoa: Move console/device menu creation code up in file
  ui/cocoa: Don't call NSApp sendEvent directly from handleEvent
  ui/cocoa: Subclass NSApplication so we can implement sendEvent
  ui/cocoa: Perform UI operations only on the main thread

 ui/cocoa.m | 495 ++++++++++++++++++++++++++++++++---------------------
 1 file changed, 303 insertions(+), 192 deletions(-)

-- 
2.17.2 (Apple Git-113)
