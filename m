Received: from eggs.gnu.org ([2001:4830:134:3::10]:54844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gRCG1-0006eF-PF
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 03:28:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gRCFx-00086h-RP
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 03:28:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gRCFx-00086A-Lx
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 03:28:37 -0500
Date: Mon, 26 Nov 2018 09:28:35 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181126082835.txegulyu6eciivh5@sirius.home.kraxel.org>
References: <D965412A-A975-4660-BEC5-6FBF34E35C45@gmail.com>
	<CAFEAcA983Q16B8y1j3msg31BtM5LXhUcB5ouyg6Dp1y-aUaDpw@mail.gmail.com>
	<CAFEAcA8WMh8AnD8X5eMz7YX_c5z0Aw8_ydZ-0poY5Sv9mnxUHw@mail.gmail.com>
	<20181122073202.zafys4gyewgjpgko@sirius.home.kraxel.org>
	<CAFEAcA-NAbimZZ8=URgUb5hFe7LG72DRM05SwecARtJUcWL1zA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-NAbimZZ8=URgUb5hFe7LG72DRM05SwecARtJUcWL1zA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] Fix for crashes and non-responsive UI on
 macOS Mojave
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Berkus Decker <berkus@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

  Hi,

> What are the required semantics for update/switch/refresh?
> These don't seem to be documented. Can we validly make
> those be asychronous, or does the midlayer require that
> the operation has completed and been reflected onscreen
> before the update/switch/refresh callback returns ?


refresh
-------

refresh() is called at regular intervals, for guest display refresh.  By
default it is called every 30 ms (GUI_REFRESH_INTERVAL_DEFAULT), UIs can
ask for a different interval using update_displaychangelistener() though.

Typically the refresh() callback will first call
graphic_hw_update(vd->dcl.con), which in turn calls into the display
device emulation for display update checks.  vga emulation will check
dirty tracking here to figure whenever the guest has updated the
display.

Next is actually updating the UI (but see below).


switch
------

Notifies the UI that the DisplaySurface has changed.  Will happen when
the guest switches the video mode.  Can also happen on pageflips.

Can happen during the graphic_hw_update() call, but can also happen
independant from that.

Qemu will free the old DisplaySurface after the switch callback returns,
so you must make sure you don't keep a reference.  These days the
DisplaySurface is just a thin wrapper around a pixman image though, and
pixman images are reference counted.  So if you want handle display
updates outside the iothread the best way to do that is to grab the
pixman image (DisplaySurface->image), get a reference to make sure it is
not released under your feet (pixman_image_ref()) and run with that in
your UI thread.


update
------

Notifies the UI that the guest has updated a specific display rectangle
and the UI should redraw it.

Can happen during the graphic_hw_update() call, but can also happen
independant from that.

You can do the UI update right here, or you can just record the
rectangles, then do a batched update in the refresh() callback.  Or
you can pass on the rectangle to your UI thread for processing.

HTH,
  Gerd
