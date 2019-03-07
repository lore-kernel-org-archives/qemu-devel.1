Received: from eggs.gnu.org ([209.51.188.92]:49308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h1qHQ-0001E0-I8
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:29:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h1qHP-0000Zw-BH
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:29:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:30576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1h1qHO-0000ZU-9M
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:29:34 -0500
Date: Thu, 7 Mar 2019 10:29:25 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190307102925.GJ32268@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
	<CAMxuvaychZk+OG5dJ-2HhttNozxLwNx+Qqj1kjpQmFy5AzRx+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMxuvaychZk+OG5dJ-2HhttNozxLwNx+Qqj1kjpQmFy5AzRx+g@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] converting build system to Meson?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>

On Wed, Mar 06, 2019 at 07:50:49PM +0100, Marc-Andr=C3=A9 Lureau wrote:
> Hi Paolo
>=20
> On Wed, Mar 6, 2019 at 7:12 PM Paolo Bonzini <pbonzini@redhat.com> wrot=
e:
> >
> > Hi all,
> >
> > lately I have been thinking of converting the QEMU build system to
> > Meson.  Meson is a relatively new build system that can replace
> > Autotools or hand-written Makefiles such as QEMU; as a die-hard
> > Autotools fan, I must say that Meson is by far better than anything e=
lse
> > that has ever tried to replace Autotools, and actually has the potent=
ial
> > to do so.
> >
> > Advantages of Meson that directly matter for QEMU include:
> >
> > - build definitions in a very readable and user friendly DSL, which
> > supports looping and conditions.
> >
> > - ability to introspect the build definitions so that you can find ou=
t
> > what is built without building it (the DSL is not Turing complete and
> > most objects in it are immutable, so it cannot be abused that much :)=
)
> >
> > - support for a non-recursive build from per-subdirectory input (simi=
lar
> > to Makefile.objs)
> >
> > - ease of distributing a full copy of Meson to support distros that s=
hip
> > an older version (no dependencies apart from Python 3.5).  At 40000
> > lines of Python, Meson is relatively small.
> >
> >
> > Unlike Autoconf, meson.build files include both feature detection and
> > build rules.  Also unlike Autoconf, Meson must be present on the syst=
em
> > of whoever builds QEMU, which is why the last bullet above matters.
> > However, it is possible to keep a configure script, if only to provid=
e
> > backwards command line compatibility and support a bundled copy of Me=
son.
>=20
> Yes, we will probably have a transition period where both build-sys
> have to co-exist (same story with libslirp, which I proposed as
> meson-only first)

I'd very much *not* want to have them co-existing. Doing that significant=
ly
increases the maint burden for any developer needing to change build rule=
s.
It also introduces significant risks that each build system produces
different results. GTK took this approach and created a number of serious
problems where meson results differed from autoconf results.

> > Of course a full conversion of QEMU's build system, including the 7k
> > lines configure script is not easy.  In addition, even though Meson
>=20
> I don't think a complete transition in one go is feasible. Could we
> start with some basic things?
>=20
> For example, we could quite easily start converting tools (qemu-img
> etc), some tests...

The difficulty of doing this is that alot of our code is shared between
the tools and the system emulators.  It is particularly problematic for
code that is auto-generated upfront. For example trace files and qapi
files. The new build system would have to be able to consume .o & .c
files already built by the other build system, with correct dependancy
ordering to ensure parallel build succeeds.  I'm not saying it is
impossible, but it is certainly very hard, to the extent that it may
well be easier to do a big-bang.


> > even just "include" the Meson-generated build system into Make and ke=
ep
> > a (progressively more) minimal Makefile veneer around it.  I benchmar=
ked
> > Make a bit and its slowness of QEMU on a do-nothing build is simply d=
ue
> > to the complexity of the unnest-vars macro machinery; Make could pars=
e a
> > synthetic 90000-target Makefile in 2 seconds (QEMU has 9000 object
> > files), and the ninja->Make converter is careful to avoid traps where
> > Make has quadratic complexity.
> >
> >
> > To be clear, this is not something I am going to work anytime soon.
> > Still in my opinion it's a worthwhile exercise to think about it.  As=
 I
> > will see in the next few weeks what the Meson maintainers' reaction w=
ill
> > be to some of the proposed extensions, I wanted to gauge the reaction=
s
> > of you all as well. :)
>=20
> I like meson better than anything else. It is still young, one can
> find quickly limitations & documentation could be better (if you
> compare it with make/autoconf/automake reference manual for ex).

I actually though the meson documentation was really pretty decent.
Where I've personally had problems was when trying to find docs for
features that don't exist yet in meson :-P

I like it better than any of the other programs that has been put
forwards as an autotools killer, to the extent I've been converting
all my personal projects to it. It might not be mature enough to
cover all the hard bits, but what it does do, it does very clearly
making the resulting build files nice to maintain.

Converting QEMU though would certainly be a large challenge in scope
pushing the boundaries of what's possible.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
