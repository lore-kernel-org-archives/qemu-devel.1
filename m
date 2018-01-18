Received: from eggs.gnu.org ([2001:4830:134:3::10]:56096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ecAND-0007oL-TL
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:36:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ecAN9-0007Vt-US
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:36:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ecAN9-0007VA-PC
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:36:51 -0500
Date: Thu, 18 Jan 2018 13:36:43 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180118133643.GP19695@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20180112125854.18261-1-kraxel@redhat.com>
	<20180112125854.18261-11-kraxel@redhat.com>
	<CAFEAcA8UAbOvZuhxwjD2zAA7GBGucD8MAf5E0h05tb3NXKdGqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8UAbOvZuhxwjD2zAA7GBGucD8MAf5E0h05tb3NXKdGqw@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Jan 18, 2018 at 01:29:35PM +0000, Peter Maydell wrote:
> On 12 January 2018 at 12:58, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > From: "Daniel P. Berrange" <berrange@redhat.com>
> >
> > The VNC server must throttle data sent to the client to prevent the 'output'
> > buffer size growing without bound, if the client stops reading data off the
> > socket (either maliciously or due to stalled/slow network connection).
> 
> Hi. Coverity (CID 1385147) complains about a suspicious sign extension
> in this patch:
> 
> > +/*
> > + * Figure out how much pending data we should allow in the output
> > + * buffer before we throttle incremental display updates, and/or
> > + * drop audio samples.
> > + *
> > + * We allow for equiv of 1 full display's worth of FB updates,
> > + * and 1 second of audio samples. If audio backlog was larger
> > + * than that the client would already suffering awful audio
> > + * glitches, so dropping samples is no worse really).
> > + */
> > +static void vnc_update_throttle_offset(VncState *vs)
> > +{
> > +    size_t offset =
> > +        vs->client_width * vs->client_height * vs->client_pf.bytes_per_pixel;
> 
> because the multiply is done with the "int" type, and then may
> be sign-extended when converted to the probably-64-bit unsigned
> size_t, resulting in the high bits all being set if the
> multiply ended up with a 1 in bit 31.

I guess we can usefully change client_width/client_height to be an unsigned
int, since there's no valid scenario for them to be negative.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
