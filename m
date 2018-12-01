Received: from eggs.gnu.org ([2001:4830:134:3::10]:50909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gT4QK-0005as-PW
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 07:31:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gT4QJ-0008S0-TY
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 07:31:04 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:53156)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gT4QJ-0008Qj-NN
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 07:31:03 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat,  1 Dec 2018 12:30:51 +0000
Message-Id: <20181201123056.432-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC 0/5] ui/cocoa: Use OSX's main loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, John Arbuckle <programmingkidx@gmail.com>, Berkus Decker <berkus@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Roman Bolshakov <r.bolshakov@yadro.com>

This set of patches rearranges how we handle events on
the OSX Cocoa UI so that we use the main thread to run
the OSX event loop, and we don't do a long blocking
operation from the applicationDidFinishLaunching callback.
Instead we create a second thread which runs qemu_main()
and becomes the QEMU main-loop thread. The callbacks from
QEMU into the cocoa code asynchronously dispatch their
work to the main thread, and the main thread takes the
iothread lock before calling into QEMU code.

This code all works (though I have only smoke-tested it),
but it is marked RFC because it seems to be unclear whether
the current code in git master is really problematic for
Mojave. If it's not actually solving a problem then it's
a bit tricky to justify this rework, though it does mean
we're doing a less "weird" set of things and behaving a bit
more like how OSX expects apps to behave, so it might in
theory mean less chance of future breakage.

NB: the code to asynchronously run code blocks on the
main thread uses dispatch_get_main_queue(), which is a
10.10-or-later function. If we're going to go with this
refactoring I think the benefit in clarity-of-code is a
worthwhile gain for dropping support for ancient OSX versions.

Patchset structure:
 * patch 1 does the "make sure we have the iothread lock for
   calls into QEMU" (which is effectively a no-op initially
   since we'll already be holding that lock when our refresh
   etc callbacks are called)
 * patch 2 makes switchSurface directly take the pixman image
   (which is refcounted) rather than the DisplaySurface (which
   is not), so we can make the calls to it asynchronous later
 * patches 3 and 4 are just trivial code motion
 * patch 5 does the bulk of the work (and can't really be split
   further without the UI being broken at the intermediate point)

thanks
-- PMM

Peter Maydell (5):
  ui/cocoa: Ensure we have the iothread lock when calling into QEMU
  ui/cocoa: Use the pixman image directly in switchSurface
  ui/cocoa: Factor out initial menu creation
  ui/cocoa: Move console/device menu creation code up in file
  ui/cocoa: Perform UI operations only on the main thread

 ui/cocoa.m | 441 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 258 insertions(+), 183 deletions(-)

-- 
2.19.2
