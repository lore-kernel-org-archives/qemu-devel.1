Received: from eggs.gnu.org ([2001:4830:134:3::10]:40025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ecAwK-0003mR-Tq
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 09:13:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ecAwF-0000lk-3f
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 09:13:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ecAwE-0000ku-RS
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 09:13:07 -0500
Date: Thu, 18 Jan 2018 14:12:56 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180118141256.GS19695@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20180112125854.18261-1-kraxel@redhat.com>
	<20180112125854.18261-11-kraxel@redhat.com>
	<CAFEAcA8UAbOvZuhxwjD2zAA7GBGucD8MAf5E0h05tb3NXKdGqw@mail.gmail.com>
	<20180118133643.GP19695@redhat.com>
	<b56b41f6-f048-00bf-d5fb-a1ed20ddeb09@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b56b41f6-f048-00bf-d5fb-a1ed20ddeb09@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Jan 18, 2018 at 02:54:48PM +0100, Paolo Bonzini wrote:
> On 18/01/2018 14:36, Daniel P. Berrange wrote:
> >>> +/*
> >>> + * Figure out how much pending data we should allow in the output
> >>> + * buffer before we throttle incremental display updates, and/or
> >>> + * drop audio samples.
> >>> + *
> >>> + * We allow for equiv of 1 full display's worth of FB updates,
> >>> + * and 1 second of audio samples. If audio backlog was larger
> >>> + * than that the client would already suffering awful audio
> >>> + * glitches, so dropping samples is no worse really).
> >>> + */
> >>> +static void vnc_update_throttle_offset(VncState *vs)
> >>> +{
> >>> +    size_t offset =
> >>> +        vs->client_width * vs->client_height * vs->client_pf.bytes_per_pixel;
> >> because the multiply is done with the "int" type, and then may
> >> be sign-extended when converted to the probably-64-bit unsigned
> >> size_t, resulting in the high bits all being set if the
> >> multiply ended up with a 1 in bit 31.
> > I guess we can usefully change client_width/client_height to be an unsigned
> > int, since there's no valid scenario for them to be negative.
> 
> In addition to that, do we support a >= 2 GiB framebuffer at all? (Even
> with unsigned ints, Coverity would rightly complain about a truncated
> 32-bit multiplication being assigned to a 64-bit value).

client_width/client_height are values that are initialized from the
graphics card frontend config, and thus limited by amount of video
RAM QEMU allows.   bytes_per_pixel is limited to 8/16/32.

So I think we're safe from 2GB overflow in any normal case.

That said, VGA RAM size is configurable, so I'm curious what would happen
if someone configured an insanely large VGA RAM and asked for a big frame
buffer in guest.

VNC is protocol limited to uint16 for width/height size, and so is X11
so I imagine some exploding behavour would follow :-)

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
