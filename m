Received: from eggs.gnu.org ([2001:4830:134:3::10]:59557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gPjTE-0001Xj-6s
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 02:32:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gPjT9-0007dI-ME
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 02:32:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gPjT6-0007WL-J2
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 02:32:10 -0500
Date: Thu, 22 Nov 2018 08:32:02 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181122073202.zafys4gyewgjpgko@sirius.home.kraxel.org>
References: <D965412A-A975-4660-BEC5-6FBF34E35C45@gmail.com>
	<CAFEAcA983Q16B8y1j3msg31BtM5LXhUcB5ouyg6Dp1y-aUaDpw@mail.gmail.com>
	<CAFEAcA8WMh8AnD8X5eMz7YX_c5z0Aw8_ydZ-0poY5Sv9mnxUHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8WMh8AnD8X5eMz7YX_c5z0Aw8_ydZ-0poY5Sv9mnxUHw@mail.gmail.com>
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

> Something somewhere in this call chain should have taken
> the iothread lock, I assume, but I'm not sure where.
> 
> Gerd -- what are the rules of the UI subsystem regarding
> multiple threads, and what threads are allowed to call
> UI functions like qemu_input_event_send_key_qcode(),
> from which threads, and whether they need to eg hold
> the iothread lock when they do so? There's no
> documentation on these functions in include/ui/input.h.

UI event handling code typically runs in iothread context.  So, yes,
when calling qemu_input_* the UI code holds the iothread lock.

> (To fix a problem on OSX Mojave this patchset has moved
> which thread the UI executes on, so it is now always
> the main thread and not the thread which calls
> the QemuDisplay 'init' callback. That seems to break
> an implicit assumption in the UI layer.)

Hmm, I guess the options are (a) grab the iothread lock before calling
input layer functions, or (b) queue the event and schedule a bottom half
which processes the queue (which will then be called from iothread
context, with the lock already taken).

cheers,
  Gerd
