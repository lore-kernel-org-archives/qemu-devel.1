Received: from eggs.gnu.org ([209.51.188.92]:37206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmFiO-0000xT-K0
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:25:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmFiM-0003Xp-Nj
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:25:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gmFiM-0003WP-Dr
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:24:58 -0500
Date: Wed, 23 Jan 2019 11:24:52 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190123102452.x5iyl77ul52wayof@sirius.home.kraxel.org>
References: <20190123080005.31078-1-kraxel@redhat.com>
	<20190123080005.31078-5-kraxel@redhat.com>
	<484e921f-7cee-755d-12a9-02e8bf182fa4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <484e921f-7cee-755d-12a9-02e8bf182fa4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] [RfC] audio: probe audio drivers by
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Brad Smith <brad@comstyle.com>

On Wed, Jan 23, 2019 at 09:27:48AM +0100, Thomas Huth wrote:
> On 2019-01-23 09:00, Gerd Hoffmann wrote:
> > 
> > This is RfC because we might look at the ordering.  On linux we probably
> > want prefer alsa over oss.
> Yes, please! I've run into the trap a couple of times already: OSS
> headers were available, but these days the OSS compatibility kernel
> modules are not loaded anymore by default. So you compile QEMU with OSS
> support and then wonder why you do not get any audio output at all...
> 
> IMHO we should put OSS as last item in the list on Linux nowadays.

Tweaked the pulseaudio driver to check whenever the damon pidfile is
present before trying to initialize.  With that in place we can move
pulse to be first in the list, without having pulse throwing error
messages when it can't connect the server.

So the linux ordering is this now:

	audio_drv_list="try-pa try-alsa try-sdl oss"

Requests / suggestions for other guests?

Probing pulseaudio first probably makes sense everywhere (when
available).  Most BSDs have both sdl and oss, which one should be
preferred here?

cheers,
  Gerd
