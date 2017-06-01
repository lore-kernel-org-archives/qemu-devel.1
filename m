Received: from eggs.gnu.org ([2001:4830:134:3::10]:36886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dGMue-0004qw-6r
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 06:01:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dGMuZ-0005k9-CG
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 06:01:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dGMuY-0005jn-RX
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 06:00:59 -0400
Date: Thu, 1 Jun 2017 18:00:54 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170601100054.GC13127@lemon.lan>
References: <20170527161755.7761-1-f4bug@amsat.org>
	<20170527161755.7761-3-f4bug@amsat.org> <87vaohrnsa.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87vaohrnsa.fsf@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 02/24] docker: add --include-files
 argument to 'build' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

On Wed, 05/31 17:31, Alex Benn=E9e wrote:
>=20
> Philippe Mathieu-Daud=E9 <f4bug@amsat.org> writes:
>=20
> > Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> > ---
> >  tests/docker/Makefile.include |  3 +++
> >  tests/docker/docker.py        | 11 ++++++++---
> >  2 files changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.in=
clude
> > index 03eda37bf4..fe1a9a53ff 100644
> > --- a/tests/docker/Makefile.include
> > +++ b/tests/docker/Makefile.include
> > @@ -51,6 +51,7 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
> >  		$(SRC_PATH)/tests/docker/docker.py build qemu:$* $< \
> >  		$(if $V,,--quiet) $(if $(NOCACHE),--no-cache) \
> >  		$(if $(NOUSER),,--add-current-user) \
> > +		$(if $(EXTRA_FILES),--extra-files $(EXTRA_FILES))\
> >  		$(if $(EXECUTABLE),--include-executable=3D$(EXECUTABLE)),\
> >  		"BUILD","$*")
> >
> > @@ -107,6 +108,8 @@ docker:
> >  	@echo '    NOUSER               Define to disable adding current us=
er to containers passwd.'
> >  	@echo '    NOCACHE=3D1            Ignore cache when build images.'
> >  	@echo '    EXECUTABLE=3D<path>    Include executable in image.'
> > +	@echo '    EXTRA_FILES=3D"<path> [... <path>]"'
> > +	@echo '                         Include extra files in image.'
> >
> >  # This rule if for directly running against an arbitrary docker targ=
et.
> >  # It is called by the expanded docker targets (e.g. make
> > diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> > index 6ddc6e4c2a..5401e58fce 100755
> > --- a/tests/docker/docker.py
> > +++ b/tests/docker/docker.py
> > @@ -237,6 +237,10 @@ class BuildCommand(SubCommand):
> >                              help=3D"""Specify a binary that will be =
copied to the
> >                              container together with all its dependen=
t
> >                              libraries""")
> > +        parser.add_argument("--extra-files", "-f", nargs=3D'*',
> > +                            help=3D"""Specify files that will be cop=
ied in the
> > +                            Docker image, fulfilling the ADD directi=
ve from the
> > +                            Dockerfile""")
> >          parser.add_argument("--add-current-user", "-u", dest=3D"user=
",
> >                              action=3D"store_true",
> >                              help=3D"Add the current user to image's =
passwd")
> > @@ -270,10 +274,11 @@ class BuildCommand(SubCommand):
> >                      print "%s exited with code %d" % (docker_pre, rc=
)
> >                      return 1
> >
> > -            # Do we include a extra binary?
> > +            # Include files used by ADD directives found within the
> > Dockerfile.
>=20
> Minor nit, as we are not actually parsing the Dockerfile here maybe it
> should be re-worded to something like:
>=20
>   "Copy any extra files into the Docker context. These can be included =
by the use
>     of the ADD directive in the Dockerfile."?

Yes, I prefer it this way as well.

Fam
