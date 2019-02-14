Received: from eggs.gnu.org ([209.51.188.92]:46049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guEML-00026t-Ie
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:35:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guEFp-0003tQ-IG
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:28:32 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guEFh-0003ki-VP
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:28:23 -0500
Received: by mail-wr1-x444.google.com with SMTP id o17so5877248wrw.3
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 02:28:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 10:28:09 +0000
Message-Id: <20190214102816.3393-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/7] ui/cocoa: Use OSX's main loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, John Arbuckle <programmingkidx@gmail.com>, Roman Bolshakov <r.bolshakov@yadro.com>, Berkus Decker <berkus@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Ben Hekster <ben.hekster@foghorn.io>, BALATON Zoltan <balaton@eik.bme.hu>

This set of patches rearranges how we handle events on
the OSX Cocoa UI so that we use the main thread to run
the OSX event loop, and we don't do a long blocking
operation from the applicationDidFinishLaunching callback.
Instead we create a second thread which runs qemu_main()
and becomes the QEMU main-loop thread. The callbacks from
QEMU into the cocoa code asynchronously dispatch their
work to the main thread, and the main thread takes the
iothread lock before calling into QEMU code.

NB: the code to asynchronously run code blocks on the
main thread uses dispatch_get_main_queue(), which is a
10.10-or-later function. I think the benefit in
clarity-of-code is a worthwhile gain for dropping support
for ancient OSX versions.

The change from v1 is that we actually wire up input events
from OSX to the handleEvent method. There are a couple of
plausible ways we could do this:

 * most OSX apps do this by implementing event handling
   methods on their NSView. This won't work for us, because
   these only get called after OSX has dealt with some events
   like menu bar accelerator keystrokes, and we would like to
   send those to the guest instead in some situations.
 * we could use addLocalMonitorForEventsMatchingMask to
   add a "local event monitor", which gets to examine/filter
   events before the usual OSX event processing. I think this
   would work, but it's not what I chose
 * we can subclass NSApplication and implement a custom
   sendEvent method in our subclass. This gets all events
   first and can either handle them or call the superclass
   sendEvent to hand them to OSX as usual. This is what I
   ended up going for.
 * It is also possible to implement sendEvent on NSWindow,
   but I think this has the "only called after OSX has done
   menu keystroke processing" issue.

I've tested this a bit better than the v1 RFC, and it seems
to work OK for me.

Patchset structure:
 * patch 1 does the "make sure we have the iothread lock for
   calls into QEMU" (which is effectively a no-op initially
   since we'll already be holding that lock when our refresh
   etc callbacks are called)
 * patch 2 makes switchSurface directly take the pixman image
   (which is refcounted) rather than the DisplaySurface (which
   is not), so we can make the calls to it asynchronous later
 * patches 3 and 4 are just trivial code motion
 * patch 5 (new in v2) restructures handleEvent so it doesn't
   directly call sendEvent but instead returns a flag indicating
   whether it consumed the event or not
 * patch 6 (new in v2) subclasses NSApplication
 * patch 7 (the old patch 5) does the bulk of the work (and can't
   really be split further without the UI being broken at the
   intermediate point)

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

 ui/cocoa.m | 483 ++++++++++++++++++++++++++++++++---------------------
 1 file changed, 294 insertions(+), 189 deletions(-)

-- 
2.17.2 (Apple Git-113)
