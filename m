Received: from eggs.gnu.org ([2001:4830:134:3::10]:43258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eedVy-0001js-6r
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 04:08:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eedVv-0003sf-45
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 04:08:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eedVu-0003sK-UR
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 04:08:07 -0500
Date: Thu, 25 Jan 2018 10:08:02 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180125090802.g57orr3tglafxqhn@sirius.home.kraxel.org>
References: <20180112125854.18261-11-kraxel@redhat.com>
	<CAFEAcA8UAbOvZuhxwjD2zAA7GBGucD8MAf5E0h05tb3NXKdGqw@mail.gmail.com>
	<20180118133643.GP19695@redhat.com>
	<b56b41f6-f048-00bf-d5fb-a1ed20ddeb09@redhat.com>
	<20180118141256.GS19695@redhat.com>
	<85686228-03dd-a7fc-1477-f27d09de5007@redhat.com>
	<CAFEAcA9sFenca+n37VOjQ3tUJLV_Vt0A7iwNdj=WbOvrMP6Pbg@mail.gmail.com>
	<5eb947cb-6481-9081-0574-306858f985e0@redhat.com>
	<d7719996-d418-48f8-61c8-7de24f8138b2@redhat.com>
	<1c036781-756c-5f63-3fb5-ff7b537dba97@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c036781-756c-5f63-3fb5-ff7b537dba97@redhat.com>
Subject: Re: [Qemu-devel] [PULL 10/14] ui: fix VNC client throttling when
 audio capture is active
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

  Hi,

> >>>>> VNC is protocol limited to uint16 for width/height size, and so is X11
> >>>>> so I imagine some exploding behavour would follow :-)
> >>>>
> >>>> Indeed, and even 2^16 x 2^16 * 32bpp is already 34 bits.  So perhaps we
> >>>> should limit VNC to 16384 pixels on each axis (maximum frame buffer size
> >>>> 1 GiB).
> >>>
> >>> Google says you can already get graphics cards that can do 15360x8640,
> >>> which is really quite close to that 16384 limit...
> >>
> >> Then we can do 32767 * 16384 * 4, but I'm a bit afraid of off-by-ones.
> > 
> > Simply limit it to 30000 * 20000 ?
> 
> That's too much (exceeds 2^31-1 at 32bpp), but yeah, 30720*17280 is
> twice what Peter found and it's safe.

We already have:

#define VNC_MAX_WIDTH ROUND_UP(2560, VNC_DIRTY_PIXELS_PER_BIT)
#define VNC_MAX_HEIGHT 2048

If the guest framebuffer is larger you'll get the upper left corner
only I think.  spice can handle larger resolutions.

cheers,
  Gerd
