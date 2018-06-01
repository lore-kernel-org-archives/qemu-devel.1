Received: from eggs.gnu.org ([2001:4830:134:3::10]:53796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fOiX8-0004og-Ui
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:47:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fOiX7-0001PC-L6
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:47:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37166 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fOiX7-0001OS-Dy
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:47:49 -0400
Date: Fri, 1 Jun 2018 12:47:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180601114743.GQ3458@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180116134217.8725-1-berrange@redhat.com>
	<20180116134217.8725-14-berrange@redhat.com>
	<f9c970db-61ff-d65f-37f0-b7baa9b028f8@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f9c970db-61ff-d65f-37f0-b7baa9b028f8@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 13/14] travis: improve python version
 test coverage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>

On Thu, May 31, 2018 at 01:09:37PM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Hi Daniel,
>=20
> On 01/16/2018 10:42 AM, Daniel P. Berrange wrote:
> > Currently travis declares ancient python 2.4 is desired. Update that =
to
> > 2.6 which is the oldest version any targetted distros still needs. If=
 we
> > just list a python 3 version at the top level this will double the
> > number of travis jobs we run which is unreasonable.
> >=20
> > So arbitrarily pick the clang test matrix entries to build with pytho=
n
> > 3.0 and 3.6, to extend coverage of python versions, without increasin=
g
> > job count or build time.
>=20
> I'm seeing 3.0 builds taking the double time than 3.6 builds (and
> triggering the 50min timeout), any idea what could cause this huge
> difference?

Ouch, that's real bad. I don't have any bright ideas, other than fact
that its a .0 release, so perhaps it was just really bad.

Wonder at which 3.x release it got "fast"

>=20
> >=20
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  .travis.yml | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/.travis.yml b/.travis.yml
> > index f583839755..708c886017 100644
> > --- a/.travis.yml
> > +++ b/.travis.yml
> > @@ -1,7 +1,7 @@
> >  sudo: false
> >  language: c
> >  python:
> > -  - "2.4"
> > +  - "2.6"
> >  compiler:
> >    - gcc
> >  cache: ccache
> > @@ -115,15 +115,17 @@ matrix:
> >          - sudo apt-get build-dep -qq qemu
> >          - wget -O - http://people.linaro.org/~alex.bennee/qemu-submo=
dule-git-seed.tar.xz | tar -xvJ
> >          - git submodule update --init --recursive
> > -    # Trusty System build with latest stable clang
> > +    # Trusty System build with latest stable clang & python 3.0
> >      - sudo: required
> >        addons:
> >        dist: trusty
> >        language: generic
> >        compiler: none
> > +      python:
> > +        - "3.0"
> >        env:
> >          - COMPILER_NAME=3Dclang CXX=3Dclang++-3.9 CC=3Dclang-3.9
> > -        - CONFIG=3D"--disable-linux-user --cc=3Dclang-3.9 --cxx=3Dcl=
ang++-3.9"
> > +        - CONFIG=3D"--disable-linux-user --cc=3Dclang-3.9 --cxx=3Dcl=
ang++-3.9 --python=3D/usr/bin/python3"
> >        before_install:
> >          - wget -nv -O - http://llvm.org/apt/llvm-snapshot.gpg.key | =
sudo apt-key add -
> >          - sudo apt-add-repository -y 'deb http://llvm.org/apt/trusty=
 llvm-toolchain-trusty-3.9 main'
> > @@ -134,15 +136,17 @@ matrix:
> >          - git submodule update --init --recursive
> >        before_script:
> >          - ./configure ${CONFIG} || cat config.log
> > -    # Trusty Linux User build with latest stable clang
> > +    # Trusty Linux User build with latest stable clang & python 3.6
> >      - sudo: required
> >        addons:
> >        dist: trusty
> >        language: generic
> >        compiler: none
> > +      python:
> > +        - "3.6"
> >        env:
> >          - COMPILER_NAME=3Dclang CXX=3Dclang++-3.9 CC=3Dclang-3.9
> > -        - CONFIG=3D"--disable-system --cc=3Dclang-3.9 --cxx=3Dclang+=
+-3.9"
> > +        - CONFIG=3D"--disable-system --cc=3Dclang-3.9 --cxx=3Dclang+=
+-3.9 --python=3D/usr/bin/python3"
> >        before_install:
> >          - wget -nv -O - http://llvm.org/apt/llvm-snapshot.gpg.key | =
sudo apt-key add -
> >          - sudo apt-add-repository -y 'deb http://llvm.org/apt/trusty=
 llvm-toolchain-trusty-3.9 main'
> >=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
