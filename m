Received: from eggs.gnu.org ([209.51.188.92]:59788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gw3Pf-0001FQ-9J
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 06:18:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gw3Pd-0006xP-1J
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 06:18:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gw3Pc-0006vP-Mi
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 06:18:08 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 725FEC007341
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 11:18:07 +0000 (UTC)
Date: Tue, 19 Feb 2019 11:17:55 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190219111755.GE7154@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190219101510.9356-1-kraxel@redhat.com>
	<a7050f62-b56f-cc1a-7600-5197b83a27ac@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a7050f62-b56f-cc1a-7600-5197b83a27ac@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] audio: don't use alsa by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On Tue, Feb 19, 2019 at 11:39:49AM +0100, David Hildenbrand wrote:
> On 19.02.19 11:15, Gerd Hoffmann wrote:
> > ardware is present the driver initializes
> > successfully and throws errors later on, i.e. effectively the
> > automatic probing doesn't work.  So the driver should not be
> > used by default (until that is fixed).  Drop the can_be_default
> > flag.
> > 
> > Explicitly picking the alsa driver (using QEMU_AUDIO_DRV=alsa
> > environment variable) will continue to work.
> 
> Just pointing out that with this patch, audio initialization still
> hinders me from starting guests on my Fedora 29 when running under root
> (I don't think this patch was also intended to fix that, just pointing
> out for me the problem still exists).
> 
> 
> ALSA lib pulse.c:243:(pulse_connect) PulseAudio: Unable to connect:
> Connection refused
> 
> sdl: SDL_OpenAudio failed
> sdl: Reason: ALSA: Couldn't open audio device: Connection refused
> ALSA lib pulse.c:243:(pulse_connect) PulseAudio: Unable to connect:
> Connection refused
> 
> sdl: SDL_OpenAudio failed
> sdl: Reason: ALSA: Couldn't open audio device: Connection refused
> audio: Failed to create voice `pcspk'
> qemu-system-x86_64: Initialization of device isa-pcspk failed:
> Initializing audio voice failed
> 
> 
> For whatever reason, on my Fedora29 root cannot access alsa devices.
> Maybe it is a Fedora 29 problem, maybe only my setup is messed up (e.g.
> because of an upgrade). The workaround for me is to not run QEMU as
> root. (I don't have time to look into the details)

Does your machine actually have any sound card in it ?  ie does
/dev/snd/ report any pcm*  devices ?

Based on your logs here, I suspect it has no sound card. The reason
it will work as non-root, is that QEMU will activate the pulseaudio
backend that works fine [1] even if no sound card is present.



Regards,
Daniel

[1] by "fine" I mean it'll happily accept the audio stream from the app
    and send it to /dev/null :-)
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
