Received: from eggs.gnu.org ([2001:4830:134:3::10]:43494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fAeMr-0001iu-NB
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:31:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fAeMl-0003LK-Ly
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:31:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33144 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fAeMl-0003L3-G3
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:30:59 -0400
Date: Mon, 23 Apr 2018 17:30:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180423163041.GQ3267@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <c7e00162-cf50-0194-d283-17e7dc8fae56@linux.ibm.com>
	<CAFEAcA-KJb6L0bCKQAE-TjfSQg6OSb0JvumGjVyYYTE46mdKbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-KJb6L0bCKQAE-TjfSQg6OSb0JvumGjVyYYTE46mdKbA@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC] configure script mistakenly detects static
 libraries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: muriloo@linux.ibm.com, QEMU Developers <qemu-devel@nongnu.org>

On Mon, Apr 23, 2018 at 05:16:02PM +0100, Peter Maydell wrote:
> On 23 April 2018 at 17:10, Murilo Opsfelder Araujo
> <muriloo@linux.ibm.com> wrote:
> > Hi, everyone!
> >
> > I'm facing an issue on how configure script detects static libraries and
> > would like to hear from community to find a common ground on how to
> > possibly fix it.
> >
> > Throughout configure, we use pkg-config command to verify if a library
> > is installed so qemu can be linked to it. This works fine when linking
> > qemu dynamically. However, configuring qemu with --static can mistakenly
> > detect a library that is actually not present on the system.
> >
> > For example, on Ubuntu Xenial, libcacard-dev package provides only
> > libcacard.so (not libcacard.a) and pkg-config reports success in both
> > cases:
> >
> >     $ pkg-config libcacard
> >     $ echo $?
> >     0
> >
> >     $ pkg-config --static libcacard
> >     $ echo $?
> >     0
> >
> > Since we use `pkg-config libcacard` to set smartcard=yes, this
> > mistakenly enables smartcard feature. This is acceptable with dynamic
> > linkage, but can be an issue with static linkage, where libcacard.a
> > doesn't exist on the system, resulting on a build error:
> 
> This seems to me to be an error in your distro's pkg-config information.
> If static linking against libcacard doesn't work, then
> "pkg-config --static libcacard" should fail.

IIUC, --static isn't actually proving that a static version of a library
exists. Rather it just changes the logic for figuring out the dependancy
graph & compiler/linker flags. So --static will always work fine even if
only the .so is present, and no .a file exists.

Similarly pkg-config without --static doesn't actually guarantee that a
shared .so exists either - just tells you the flags you would need if
it did exist.

This works fine if you always build & ship static & shared versions of
every library, but distros often ditch static builds of all but a
handful of libraries, because of the ripple effect static linking
has when security updates are issued.

> Unfortunately IME the static linking support in distro-suppled
> pkgconfig files is rarely tested, so it's not uncommon for it to
> be broken.
> 
> From an upstream QEMU point of view, we primarily support --static
> for the benefit of the linux-user binaries, not for system emulation.
> So we care more if a "configure --disable-system --disable-tools --static"
> build doesn't work, than if the problem is only with features used
> by the system emulator binaries.

That reduces the 3rd party deps to essentially just your C library and
glib2, which makes it more tractable from a security update POV. I would
certainly not wish to see static linking of a system emulator which pulls
in 150+ 3rd party libraries on my system !

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
