Received: from eggs.gnu.org ([2001:4830:134:3::10]:48692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dyyjO-0008Dy-7s
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 07:17:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dyyjL-0007TA-FT
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 07:17:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dyyjL-0007Ss-97
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 07:17:47 -0400
Date: Mon, 2 Oct 2017 12:17:39 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171002111739.GH27086@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CGME20171002083119eucas1p1a73232b22e354c9b27dbc4c0b9b78907@eucas1p1.samsung.com>
	<1506933058-28313-1-git-send-email-a.perevalov@samsung.com>
	<1506933058-28313-2-git-send-email-a.perevalov@samsung.com>
	<CAFEAcA8oo4cenAVsmcS5cmC3Uuh5e+bocM4hbHtvcpFB1ZJKGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8oo4cenAVsmcS5cmC3Uuh5e+bocM4hbHtvcpFB1ZJKGQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] Makefile: don't use LINKPROG for
 tests/migration/stress
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alexey Perevalov <a.perevalov@samsung.com>, heetae82.ahn@samsung.com, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, i.maximets@samsung.com
List-ID: <qemu-devel.nongnu.org>

On Mon, Oct 02, 2017 at 12:14:39PM +0100, Peter Maydell wrote:
> On 2 October 2017 at 09:30, Alexey Perevalov <a.perevalov@samsung.com> wrote:
> > This patch just replaces  LINKPROG for CC.
> > LINKPROG invokes both CXX and CC.
> > So in case of static linking of C source, static libstdc++
> > is required by build, but it could be missing in system.
> > And static libstdc++ may not be needed for whole QEMU.
> >
> > Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> > ---
> >  tests/Makefile.include | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > index abc6707..bf94516 100644
> > --- a/tests/Makefile.include
> > +++ b/tests/Makefile.include
> > @@ -803,7 +803,7 @@ tests/numa-test$(EXESUF): tests/numa-test.o
> >  tests/vmgenid-test$(EXESUF): tests/vmgenid-test.o tests/boot-sector.o tests/acpi-utils.o
> >
> >  tests/migration/stress$(EXESUF): tests/migration/stress.o
> > -       $(call quiet-command, $(LINKPROG) -static -O3 $(PTHREAD_LIB) -o $@ $< ,"LINK","$(TARGET_DIR)$@")
> > +       $(call quiet-command, $(CC) -static -O3 $(PTHREAD_LIB) -o $@ $< ,"LINK","$(TARGET_DIR)$@")
> >
> >  INITRD_WORK_DIR=tests/migration/initrd
> 
> Why does this executable need to define its own link rule anyway?
> Ideally it should just use the standard rules.mak LINK function
> like everything else. If it does need to do something weird
> it should have a comment saying why it's weird...

Primarily because we're static linking this binary so that it can be put
into an initrd without needing any extra files added. It doesn't use any
of the 3rd party libraries the rest of QEMU uses - ie no glib2 in particular.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
