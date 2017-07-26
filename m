Received: from eggs.gnu.org ([2001:4830:134:3::10]:39453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1daKUW-0007LT-Dt
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:28:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1daKUS-0003Ue-H8
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:28:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1daKUS-0003Ta-BX
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:28:32 -0400
Date: Wed, 26 Jul 2017 12:28:26 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170726112826.GE7620@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170724164601.21063-1-berrange@redhat.com>
	<88f8a661-f832-1d03-2736-d7b35c920e32@reactos.org>
	<20170725083251.GB26394@redhat.com>
	<1500983620.29790.3.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1500983620.29790.3.camel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 2.10] ps2: fix sending of PAUSE/BREAK
 scancodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, qemu-devel@nongnu.org

On Tue, Jul 25, 2017 at 01:53:40PM +0200, Gerd Hoffmann wrote:
>   Hi,
> 
> > > You're putting some specific code for spice in ps2 emulation.
> > > IMO, the workaround should be moved to spice keyboard handling
> > > (ui/spice-input.c),
> > > which needs to generate a qcode instead of a scancode.
> > 
> > This isn't really a spice specific hack. QEMU internal code is *not*
> > required
> > to use qcodes 
> 
> qcodes are prefered in new code though.
> 
> > - the KeyValue struct is a union that allows use of either qcodes
> > or XT scancodes, and the latter is what all the frontends (SPICE,
> > VNC, GTk, SDL)
> > use. QCodes are really only input by the monitor (the sendkey
> > command).
> 
> Well, PAUSE is actually sent as qcode by sdl and gtk.  This avoids
> special cases in the input layer (PAUSE is the only three scancodes key
> sequence).  IMO spice should do the same.  I want switch UIs to qcodes
> anyway.

qcodes as currently defined cover only a subset of the AT set1 scancodes,
so we need to define countless more qcodes before we consider converting
UIs to use qcodes.

Aside from the pause/break bug, the changes to ps2 driver to round trip
via qcodes have now made it impossible to send a large number of key
sequences to the guest OS :-( Admittedly the missing key codes are not
so commonly used, but it is still a notable regression in functionality
today

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
