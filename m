Received: from eggs.gnu.org ([2001:4830:134:3::10]:39046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eyJ0r-0004JC-L1
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:17:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eyJ0n-0008Io-K4
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:17:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60044 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eyJ0n-0008Hd-9o
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:17:17 -0400
Date: Tue, 20 Mar 2018 15:17:04 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180320151704.GV4530@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180320142343.13867-1-berrange@redhat.com>
	<CAFEAcA8dqLa2sTqOm9+z+sh4uft8OM06wNRTs1YkjsSa73yhRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8dqLa2sTqOm9+z+sh4uft8OM06wNRTs1YkjsSa73yhRQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] make: improve check for stale generated
 files in source dir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Tue, Mar 20, 2018 at 02:36:01PM +0000, Peter Maydell wrote:
> On 20 March 2018 at 14:23, Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
> > When doing a build with builddir !=3D srcdir, if any generated files =
are
> > accidentally present in srcdir from a previous build, these can cause
> > unexpected failures.
> >
> > Currently there is a rule that checks for existance of config-host.ma=
k,
> > but there have been cases where config-host.mak is absent, while othe=
r
> > generated files still exist.
> >
> > Update the check to look at every file listed in $(GENERATED_FILES). =
To
> > do this we must move the check further down after $(GENERATED_FILES) =
has
> > been populated.
> >
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >  Makefile | 29 +++++++++++++++++++----------
> >  1 file changed, 19 insertions(+), 10 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index c8116694a0..73caabc019 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -52,16 +52,6 @@ endif
> >
> >  .git-submodule-status: git-submodule-update config-host.mak
> >
> > -# Check that we're not trying to do an out-of-tree build from
> > -# a tree that's been used for an in-tree build.
> > -ifneq ($(realpath $(SRC_PATH)),$(realpath .))
> > -ifneq ($(wildcard $(SRC_PATH)/config-host.mak),)
> > -$(error This is an out of tree build but your source tree ($(SRC_PAT=
H)) \
> > -seems to have been used for an in-tree build. You can fix this by ru=
nning \
> > -"$(MAKE) distclean && rm -rf *-linux-user *-softmmu" in your source =
tree)
> > -endif
> > -endif
> > -
> >  CONFIG_SOFTMMU :=3D $(if $(filter %-softmmu,$(TARGET_DIRS)),y)
> >  CONFIG_USER_ONLY :=3D $(if $(filter %-user,$(TARGET_DIRS)),y)
> >  CONFIG_XEN :=3D $(CONFIG_XEN_BACKEND)
> > @@ -1027,6 +1017,25 @@ ifdef SIGNCODE
> >  endif # SIGNCODE
> >  endif # CONFIG_WIN
> >
> > +define nl
> > +
> > +
> > +endef
> > +
> > +CHECK_FILES =3D config-host.mak $(filter-out .git-submodule-status, =
$(GENERATED_FILES))
> > +UNEXPECTED_FILES =3D $(wildcard $(CHECK_FILES:%=3D$(SRC_PATH)/%))
> > +
> > +# Check that we're not trying to do an out-of-tree build from
> > +# a tree that's been used for an in-tree build.
> > +ifneq ($(realpath $(SRC_PATH)),$(realpath .))
> > +ifneq ($(UNEXPECTED_FILES),)
> > +$(error Stale files in source tree:${nl}${nl} $(UNEXPECTED_FILES:%=3D=
  %${nl}) ${nl}\
> > +This is an out of tree build but your source tree ($(SRC_PATH)) \
> > +seems to have been used for an in-tree build. You can fix this by ru=
nning \
> > +"$(MAKE) distclean && rm -rf *-linux-user *-softmmu" in your source =
tree)
> > +endif
> > +endif
> > +
> >  # Add a dependency on the generated files, so that they are always
> >  # rebuilt before other object files
> >  ifneq ($(wildcard config-host.mak),)
> > --
>=20
> Does this still mean the check is made sufficiently early, before
> we start trying to build config-all-devices.mak and other things?
> This change has moved it down after 'include' directives which
> I think will cause make to try to build the file that it must
> include.

I'm not 100% sure, but what I did to test was as follows, starting
from git srcdir

   ./configure --target-list=3Dx86_64-softmmu
   make -j 8
   mkdir build
   cd build
   ../configure --target-list=3Dx86_64-softmmu
   find -type f > /tmp/before.txt
   make -j 8
   find -type f > /tmp/after.txt

and confirmed that before.txt & after.txt have same list of files
after make complains about dirty srcdir. So it does not appear to
be triggering any rebuild rules.

I also did another tests where instad of running 'make' in the src
dir, I just arbitrarily touchd the single qemu-version.h file

I think that's important here is that this error checking logic is
not attached to any make target - it is something that is run
immediately as make parses the makefile, before executing any
rules. So as long as we don't have other code that is target
independant, we should be ok.

> It's also moved out of the "only run this if we've actually run
> configure" block, but I think that part is OK.

Yeah I think that is safe for this usage scenario.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
