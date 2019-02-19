Received: from eggs.gnu.org ([209.51.188.92]:43844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gw4NW-0008LT-3L
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:20:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gw4NU-0001Hp-4i
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:20:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gw4NS-0001HJ-4N
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:20:00 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 30AE1C058CB0
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 12:19:57 +0000 (UTC)
Date: Tue, 19 Feb 2019 12:19:46 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190219121946.GG7154@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190219101510.9356-1-kraxel@redhat.com>
	<a7050f62-b56f-cc1a-7600-5197b83a27ac@redhat.com>
	<20190219121258.rua536oattwkwgkc@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190219121258.rua536oattwkwgkc@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [PATCH] audio: don't use alsa by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org

On Tue, Feb 19, 2019 at 01:12:58PM +0100, Gerd Hoffmann wrote:
> On Tue, Feb 19, 2019 at 11:39:49AM +0100, David Hildenbrand wrote:
> > On 19.02.19 11:15, Gerd Hoffmann wrote:
> > > ardware is present the driver initializes
> > > successfully and throws errors later on, i.e. effectively the
> > > automatic probing doesn't work.  So the driver should not be
> > > used by default (until that is fixed).  Drop the can_be_default
> > > flag.
> > > 
> > > Explicitly picking the alsa driver (using QEMU_AUDIO_DRV=alsa
> > > environment variable) will continue to work.
> > 
> > Just pointing out that with this patch, audio initialization still
> > hinders me from starting guests on my Fedora 29 when running under root
> > (I don't think this patch was also intended to fix that, just pointing
> > out for me the problem still exists).
> > 
> > 
> > ALSA lib pulse.c:243:(pulse_connect) PulseAudio: Unable to connect:
> > Connection refused
> > 
> > sdl: SDL_OpenAudio failed
> > sdl: Reason: ALSA: Couldn't open audio device: Connection refused
> > ALSA lib pulse.c:243:(pulse_connect) PulseAudio: Unable to connect:
> > Connection refused
> > 
> > sdl: SDL_OpenAudio failed
> > sdl: Reason: ALSA: Couldn't open audio device: Connection refused
> > audio: Failed to create voice `pcspk'
> > qemu-system-x86_64: Initialization of device isa-pcspk failed:
> > Initializing audio voice failed
> 
> So SDL has the same problem (possibly only when using alsa).
> 
> Hmm.  Dropping can_be_default here will too break sound on BSD ...

We could temporarily put the Linux default ordering back to have "oss"
before sdl/alsa until the initialization code in sdl/alsa can be fixed to
correctly detect working audio.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
