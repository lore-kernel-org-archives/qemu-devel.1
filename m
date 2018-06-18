Received: from eggs.gnu.org ([2001:4830:134:3::10]:36337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fUuk7-0006Ie-T5
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:02:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fUuk3-0006Th-S1
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:02:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38370 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fUuk3-0006TR-Ll
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:02:47 -0400
Date: Mon, 18 Jun 2018 15:02:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180618140243.GI3589@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAFEAcA_S41uEj=ae1efd042aTJcLUe+LXpD8WUwSkeWLnPCj=w@mail.gmail.com>
	<20180618135410.GA18383@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180618135410.GA18383@localhost.localdomain>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] enabling smart-http git protocol on git.qemu.org
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Iliya Dyachenko <gandalfthewhite@mail.ru>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Mon, Jun 18, 2018 at 09:54:10AM -0400, Jeff Cody wrote:
> On Mon, Jun 18, 2018 at 11:55:05AM +0100, Peter Maydell wrote:
> > On 18 June 2018 at 10:47, Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
> > > On Mon, Jun 18, 2018 at 12:32:01PM +0300, Iliya Dyachenko wrote:
> > >> Signed-off-by: Iliya Dyachenko <gandalfthewhite@mail.ru>
> > >> ---
> > >>  .gitmodules | 32 ++++++++++++++++----------------
> > >>  1 file changed, 16 insertions(+), 16 deletions(-)
> > >>
> > >> diff --git a/.gitmodules b/.gitmodules
> > >> index 49e9c2e3f4..e6bc732d16 100644
> > >> --- a/.gitmodules
> > >> +++ b/.gitmodules
> > >> @@ -1,48 +1,48 @@
> > >>  [submodule "roms/vgabios"]
> > >>       path =3D roms/vgabios
> > >> -     url =3D git://git.qemu-project.org/vgabios.git/
> > >> +     url =3D https://git.qemu.org/git/vgabios.git
> > >
> > > [snip]
> > >
> > > This is highly desirable, however, we cannot do it right now.
> > >
> > > The git.qemu.org server is still using the dumb git http protocol, =
so it
> > > would be a performance regression over git://
> > >
> > > We need the server config fixing to use the smart http protocol.
> > >
> > > Essentially this just involves configuring apache to add
> > >
> > >   <Directory /usr/libexec/git-core>
> > >     Allow from all
> > >   </Directory>
> > >
> > >   SetEnv GIT_PROJECT_ROOT /data/git
> > >
> > >   ScriptAliasMatch "^/git/(.*\.git/(HEAD|info/refs))$" \
> > >     /usr/libexec/git-core/git-http-backend/$1
> > >   ScriptAliasMatch "^/git/(.*\.git/git-(upload|receive)-pack)$" \
> > >     /usr/libexec/git-core/git-http-backend/$1
> >=20
> > Sounds like a good idea -- I've cc'd Jeff and Stefan (who
> > are the people who care for our git server)...
> >
>=20
> Thanks, it is a good idea.  I think Peter also brought this up once bef=
ore,
> if I am not mistaken.  I'll work on implementing that today.

To check it is working correctly once configured, use the following:

  $ curl -si https://git.qemu.org/git/capstone.git/info/refs?service=3Dgi=
t-upload-pack | grep --binary-files=3Dtext '^Content-Type'


Once configured correctly that should display:

   Content-Type: application/x-git-upload-pack-advertisement

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
