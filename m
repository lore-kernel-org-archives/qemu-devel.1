Received: from eggs.gnu.org ([209.51.188.92]:53763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h1qax-0001Xi-Bw
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:49:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h1qaw-0002XW-Eu
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:49:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1h1qaw-0002XA-7Y
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:49:46 -0500
Date: Thu, 7 Mar 2019 10:49:38 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190307104938.GM32268@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
	<9fb589af-a78e-6eeb-ca1c-a5049c5ac5ab@redhat.com>
	<13c59d63-1761-b61e-9cb9-039a3ef1be08@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <13c59d63-1761-b61e-9cb9-039a3ef1be08@redhat.com>
Subject: Re: [Qemu-devel] converting build system to Meson?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, Mar 07, 2019 at 11:40:05AM +0100, Paolo Bonzini wrote:
> On 07/03/19 07:39, Thomas Huth wrote:
> > On 06/03/2019 19.12, Paolo Bonzini wrote:
> >> Hi all,
> >>
> >> lately I have been thinking of converting the QEMU build system to
> >> Meson.  Meson is a relatively new build system that can replace
> >> Autotools or hand-written Makefiles such as QEMU; as a die-hard
> >> Autotools fan, I must say that Meson is by far better than anything else
> >> that has ever tried to replace Autotools, and actually has the potential
> >> to do so.
> >>
> >> Advantages of Meson that directly matter for QEMU include:[...]
> > 
> > I'm not objecting a new build system per se, but could you elaborate on
> >  problems of the current QEMU build system that will be fixed by this
> > change?
> 
> In order of importance:
> 
> - Make lacks introspection abilities; people want to be able to quickly
> say "I don't have this security issue because I didn't compile this
> file".  Make only gives you the build logs, which may not be easily
> accessible to the end user.
> 
> - Makefile.objs unnesting does not apply throughout the tree, for
> example it does not apply to tests.  We don't apply it there because it
> it is hard to extend Makefile.objs to dozens of targets and it would
> also be very very slow.  The result is lack of homogeneity between
> places that use Makefile.objs and places that use Makefile.include.
> 
> - Makefile.objs unnesting is hard to understand---granted, you rarely
> have to understand it because it mostly works, but we should consider
> whether it is a local optimum.  For example, how many people know how to
> add a dynamically-loadd module to Makefile.objs?

We have a long standing bug in unnesting which breaks if two dirs
have a .c file with the same name and a per-o file library link:

  https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg02654.html

The nesting stuff is insanely clever, but it is also fragile and full
of dragons like this one.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
