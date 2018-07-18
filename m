Received: from eggs.gnu.org ([2001:4830:134:3::10]:46673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ffmlZ-0001cU-QG
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 09:45:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ffmlZ-00058Q-3Y
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 09:45:17 -0400
Date: Wed, 18 Jul 2018 10:45:07 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180718134507.GX31657@localhost.localdomain>
References: <7a6766fc-9fac-79a5-d53c-b5209abccaae@amsat.org>
	<20180718072548.GB9812@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180718072548.GB9812@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] qemu-iotests: workaround to avoid Python3 while
 running tests on Fedora Docker image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Wed, Jul 18, 2018 at 08:25:48AM +0100, Daniel P. Berrang=E9 wrote:
> On Tue, Jul 17, 2018 at 08:37:58PM -0300, Philippe Mathieu-Daud=E9 wrot=
e:
> > I noticed this while running "make docker-test-block@fedora":
> >=20
> > $ make docker-test-block@fedora NETWORK=3D1
> >   BUILD   fedora
> >     RUN test-block in qemu:fedora
> > Configure options:
> > --enable-werror --prefix=3D/tmp/qemu-test/install
> > --python=3D/usr/bin/python3 --target-list=3Dx86_64-softmmu
> > ...
> > python            /usr/bin/python3 -B
> > ...
> >=20
> > 194         - output mismatch (see 194.out.bad)
> > --- /tmp/qemu-test/src/tests/qemu-iotests/194.out       2018-07-17
> > 22:51:10.000000000 +0000
> > +++ /tmp/qemu-test/build/tests/qemu-iotests/194.out.bad 2018-07-17
> > 22:58:01.646916625 +0000
> > @@ -1,18 +1,18 @@
> >  Launching VMs...
> >  Launching NBD server on destination...
> > -{u'return': {}}
> > -{u'return': {}}
> > +{'return': {}}
> > +{'return': {}}
> >=20
> > and many more errors, until:
> >=20
> > Failures: 045 132 148 152 162 169 194 205 208 218 222
> > Failed 11 of 49 tests
> > Test failed: iotests raw
> >=20
> > All failures are due to Python2 syntax.
> > I started to fix but noticed there are too many and this isn't to
> > correct fix for this release.
>=20
> Were they all due to the unicode string prefix, or where there
> difference failures too ?
>=20
> The unicode string prefix could probably be fixed once by changing
> the log() method in iotests.py to have a built-in filter that
> chomps the leading 'u'

We can implement more consistent behavior by making the QMP
methods return a dictionary object with a custom __unicode__()
method.

Using JSON when printing QMP messages (instead of the default
repr() output) is probably a good idea everywhere (not just on
iotests).

--=20
Eduardo
