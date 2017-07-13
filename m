Received: from eggs.gnu.org ([2001:4830:134:3::10]:45821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dVaMr-0004Mh-Ij
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 05:25:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dVaMn-0001ji-BT
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 05:25:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dVaMn-0001jS-20
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 05:25:01 -0400
Date: Thu, 13 Jul 2017 10:24:53 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170713092453.GE4011@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170712162550.8061-1-berrange@redhat.com>
	<292ec5a0-8722-4c66-d3d6-377b9863e092@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <292ec5a0-8722-4c66-d3d6-377b9863e092@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Don't enable networking as a side-effect
 of DEBUG=1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>

On Wed, Jul 12, 2017 at 06:55:45PM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Hi Daniel,
>=20
> On 07/12/2017 01:25 PM, Daniel P. Berrange wrote:
> > When trying to debug problems with tests it is natural to set
> > DEBUG=3D1 when starting the docker environment. Unfortunately
> > this has a side-effect of enabling an eth0 network interface
> > in the container, which changes the operating environment of
> > the test suite. IOW tests with fail may suddenly start
> > working again if DEBUG=3D1 is set, due to changed network setup.
> >=20
> > Add a separate NETWORK=3D1 option to allow enablement of
> > networking separately from DEBUG=3D1, since common debugging
> > tasks probably don't require networking anyway.
> >=20
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >   tests/docker/Makefile.include | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.in=
clude
> > index 037cb9e..a8c4b82 100644
> > --- a/tests/docker/Makefile.include
> > +++ b/tests/docker/Makefile.include
> > @@ -106,6 +106,7 @@ docker:
> >   	@echo '                         (default is 1)'
> >   	@echo '    DEBUG=3D1              Stop and drop to shell in the cr=
eated container'
> >   	@echo '                         before running the command.'
> > +	@echo '    NETWORK=3D1            Enable eth0 virtual network inter=
face.'
>=20
> "eth0" is not always true...
>=20
> This patch could be more generic, maybe documented as:
>=20
>   NETWORK=3Dhost     Use full host network stack (default no network).'
>=20
> >   	@echo '    NOUSER               Define to disable adding current u=
ser to containers passwd.'
> >   	@echo '    NOCACHE=3D1            Ignore cache when build images.'
> >   	@echo '    EXECUTABLE=3D<path>    Include executable in image.'
> > @@ -132,7 +133,8 @@ docker-run: docker-qemu-src
> >   		$(SRC_PATH)/tests/docker/docker.py run 			\
> >   			$(if $(NOUSER),,-u $(shell id -u)) -t 		\
> >   			$(if $V,,--rm) 					\
> > -			$(if $(DEBUG),-i,--net=3Dnone) 			\
> > +			$(if $(DEBUG),-i,)				\
> > +			$(if $(NETWORK),,--net=3Dnone)			\
>=20
> and here use directly:  --net=3D${NETWORK:-none}
>=20
> so an experimented docker user could even run tests as:
>=20
>   make docker-test-quick@centos6 NETWORK=3Dcontainer:qemu
>=20
> (or NETWORK=3Dbridge)

This is a nice idea, though slightly more complicated. It would be good
to support NETWORK=3D1 as a short-cut for enabling the default docker
network backend, as well as being able to give an explicit backend for
those who really care about the flexibility.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
