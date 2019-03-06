Received: from eggs.gnu.org ([209.51.188.92]:59849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h1b2P-0004vX-HE
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:13:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h1b2J-0006bN-Dx
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:13:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1h1b2I-0006O5-Cw
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:12:58 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
Date: Wed, 6 Mar 2019 19:12:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] converting build system to Meson?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Daniel Berrange <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>

Hi all,

lately I have been thinking of converting the QEMU build system to
Meson.  Meson is a relatively new build system that can replace
Autotools or hand-written Makefiles such as QEMU; as a die-hard
Autotools fan, I must say that Meson is by far better than anything else
that has ever tried to replace Autotools, and actually has the potential
to do so.

Advantages of Meson that directly matter for QEMU include:

- build definitions in a very readable and user friendly DSL, which
supports looping and conditions.

- ability to introspect the build definitions so that you can find out
what is built without building it (the DSL is not Turing complete and
most objects in it are immutable, so it cannot be abused that much :))

- support for a non-recursive build from per-subdirectory input (similar
to Makefile.objs)

- ease of distributing a full copy of Meson to support distros that ship
an older version (no dependencies apart from Python 3.5).  At 40000
lines of Python, Meson is relatively small.


Unlike Autoconf, meson.build files include both feature detection and
build rules.  Also unlike Autoconf, Meson must be present on the system
of whoever builds QEMU, which is why the last bullet above matters.
However, it is possible to keep a configure script, if only to provide
backwards command line compatibility and support a bundled copy of Meson.

Of course a full conversion of QEMU's build system, including the 7k
lines configure script is not easy.  In addition, even though Meson
supports extension modules that are written in Python, those are really
used only for namespacing purposes as the extensions need to live in the
Meson tree and not in the QEMU tree.  Therefore I have tried to identify
the parts of QEMU's Makefiles that could complicate the transition, and
see in advance if they can be addressed:

- --enable-modules's usage of special linker options -u SYMBOL.  For
this I initially wrote patches to Meson that would make everything
automatic, however they were rejected.  Instead, the Meson maintainer
prodded me to find a way to implement the behavior in QEMU's build
system without having to extend Meson, and we managed to find one.  This
was a good exercise because it showed that, despite being very
"opinionated", Meson manages to be pretty flexible too.

- ease of use for test logs and the ability to cut and paste test
invocations from the logs to the command line.  For this I have started
"probing" how the Meson developers feel about this kind of change[1],
and intend to follow up until the meson test driver is comparable in
usability to QEMU's "make check",

- ease of converting Makefile.objs files.  The Makefile.objs files are
very nice to change for simple modifications, and any replacement should
have the same feature.  This will require a Meson extension which I have
proposed already[2], where adding a source file will look like

    obj.add(['CONFIG_VIRTIO'], files('virtio.c'),
            if_false: files('virtio-stub.c'))
    common_obj.add(['CONFIG_SDL'], files('sdl.c'],
                   dependencies: sdl)

This is a little more verbose than Makefile.objs, but should be okay
assuming the extension is accepted.  Rejection of my extension would be
a blocker though, because QEMU is quite special in how it builds dozens
of large binaries, all *from the same sources* (unlike e.g. gstreamer
which has >100 build targets but they are all independent plugins).

Rules for generators like trace-tool or QAPI would becomes quite a bit
more verbose.  Hopefully this is offset by increased clarity if we don't
rely anymore on stuff like pattern rules and instead have foreach loops.

- unintended performance issues.  I wouldn't be surprised if QEMU
stressed Meson more than many other projects did.  However, this should
be mitigated by the fact that source selection is done in Python rather
than in Meson's DSL.  Everything else is O(#binaries) or O(#sources),
but not O(#sources*#binaries).

- ability to use the currently in progress Kconfig declarations for
dependencies.  Meson developers have expressed that they would accept an
extension module that loads Kconfig-like declarations from a file; this
would also be useful to start using Meson only as a Make replacement
while keeping the current configure script[4], since we could slurp
config-host.mak and config-target.mak from Meson.  However, this is only
half of the story, since we also have to compute the Kconfig
dependencies.  For this it should be possible to take the existing
minikconf and change it to produce Meson's DSL.  For example

   config FOO
     default y if BAR
     select BAZ

would become

   if config.get('BAR') =3D=3D 'y' and not config.has('FOO') then
     config.set('FOO', 'y')
   endif
   if config.get('FOO') =3D=3D 'y' then
     if config.has('BAZ') and config.get('BAZ') !=3D 'y' then
       error('FOO selects BAZ, but BAZ is disabled')
     endif
     config.set('BAZ', 'y')
   endif

I have not tried doing this, but it seems feasible.

- Meson generates a build.ninja file rather than a Makefile, which also
complicates a bit interoperability with the current system.  This is
perhaps minor, since in most cases the change is just s/make/ninja/ but
it may matter for day-to-day development.  For this I have prototyped a
converter (written in Python) from ninja back to Make, so that we could
even just "include" the Meson-generated build system into Make and keep
a (progressively more) minimal Makefile veneer around it.  I benchmarked
Make a bit and its slowness of QEMU on a do-nothing build is simply due
to the complexity of the unnest-vars macro machinery; Make could parse a
synthetic 90000-target Makefile in 2 seconds (QEMU has 9000 object
files), and the ninja->Make converter is careful to avoid traps where
Make has quadratic complexity.


To be clear, this is not something I am going to work anytime soon.
Still in my opinion it's a worthwhile exercise to think about it.  As I
will see in the next few weeks what the Meson maintainers' reaction will
be to some of the proposed extensions, I wanted to gauge the reactions
of you all as well. :)

Thanks,

Paolo

[1] https://github.com/mesonbuild/meson/pull/5025
[2] https://github.com/mesonbuild/meson/pull/5028
[3] https://github.com/mesonbuild/meson/pull/1617
