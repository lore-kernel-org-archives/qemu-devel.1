Received: from eggs.gnu.org ([209.51.188.92]:44562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwpBU-0005Mn-Dk
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:18:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwpBT-0002mr-KG
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:18:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gwpBT-0002m8-DH
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:18:43 -0500
Date: Thu, 21 Feb 2019 15:18:41 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190221141841.2gberr5endb7mfpe@sirius.home.kraxel.org>
References: <7287de8f-b1af-9285-0ac1-173ed7197f94@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7287de8f-b1af-9285-0ac1-173ed7197f94@msgid.tls.msk.ru>
Subject: Re: [Qemu-devel] Qemu GTK display mouse pointer visibility/position
 problem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel qemu-devel <qemu-devel@nongnu.org>, 919057@bugs.debian.org

  Hi,

> I have similar problems as the original reporter, specifically, after
> upgrading to qemu 3.1 from stretch [from qemu 2.8 -- mjt], mouse pointer
> is invisible in guest systems iff the pointer is grabbed,
> with -display gtk and qxl is used.

> When using -vga std, both linux and windows guests show a mouse pointer.
> likewise, with -vga qxl and/or additional -device qxl, a mouse pointer is
> shown *iff* the input isn't grabbed.
> 
> The behaviour is perfectly repeatable here: if I press ctrl-alt-g, mouse
> pointer becomes invisible, ctrl-alt-g again, pointer becomes visible
> again.

Why do you grab in the first place?

> I have tried this with both ubuntu 17.10 and windows 10 + qxl-dod driver
> (virtio 0.141 and 0.164), and the behaviour is consistent, so I think
> this is a bug in the gtk+ interface of qemu when qxl is used (or when a
> hardware pointer is used, as I guess -vga std does not emulate a hardware
> pointer).

Yes, -vga std has no hardware cursor support.

qxl has two modes: "server mouse mode" where the guest/spice-server
renders the cursor (effectively software cursor), and "client mouse
mode" where the spice-client renders the cursor (effectively hardware
cursor, typically done by setting the window cursor to the guest
cursor).

"client mouse mode" is used in case a absolute pointing device is
present, "server mouse mode" otherwise.

Likewise qemu UIs (both gtk and sdl) do not grab the pointer in case a
absolute pointing device is present, otherwise they do automatically
grab the pointer on mouse clicks.

So typically you run either in server mouse mode with grab or client
mouse mode without grab.  The gtk ui has some logic to handle that,
specifically it hides the cursor in some cases to avoid that you see
both software and hardware cursor.  When manually activating the grab
you are confusing that logic ...

> Googling around, I saw recommendations to use -show-cursor - I have no
> clue what it does, it didn't have any effect, either.

Try "-display gtk,grab-on-hover=on"?

That'll activate the *keyboard* grab in case the mouse pointer is within
the qemu window, so hotkeys go to the guest instead of being captured by
the hosts window manager.  Then you don't have to manually activate the
grab via Ctrl-Alt-G (which grabs both keyboard and pointer) for that.

HTH,
  Gerd
