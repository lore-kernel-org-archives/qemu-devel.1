Received: from eggs.gnu.org ([2001:4830:134:3::10]:43802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1daM3t-0002tS-75
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 09:09:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1daM3s-0005R3-1g
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 09:09:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1daM3r-0005Oi-OK
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 09:09:11 -0400
Date: Wed, 26 Jul 2017 10:00:25 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170726130025.GD20793@localhost.localdomain>
References: <20170725150951.16038-1-ldoktor@redhat.com>
	<20170725150951.16038-6-ldoktor@redhat.com>
	<20170725160639.GO2757@localhost.localdomain>
	<e9246b9c-c004-3647-edb7-44e849f33f94@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e9246b9c-c004-3647-edb7-44e849f33f94@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 05/10] qemu.py: Use custom exceptions
 rather than Exception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, apahim@redhat.com, mreitz@redhat.com, f4bug@amsat.org, armbru@redhat.com

On Wed, Jul 26, 2017 at 06:39:28AM +0200, Luk=C3=A1=C5=A1 Doktor wrote:
> Dne 25.7.2017 v 18:06 Eduardo Habkost napsal(a):
> > On Tue, Jul 25, 2017 at 05:09:46PM +0200, Luk=C3=A1=C5=A1 Doktor wrot=
e:
> >> The naked Exception should not be widely used. It makes sense to be =
a
> >> bit more specific and use better-suited custom exceptions. As a bene=
fit
> >> we can store the full reply in the exception in case someone needs i=
t
> >> when catching the exception.
> >>
> >> Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> >> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> >> ---
> >>  scripts/qemu.py | 17 +++++++++++++++--
> >>  1 file changed, 15 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/scripts/qemu.py b/scripts/qemu.py
> >> index 5948e19..e6df54c 100644
> >> --- a/scripts/qemu.py
> >> +++ b/scripts/qemu.py
> >> @@ -19,6 +19,19 @@ import subprocess
> >>  import qmp.qmp
> >> =20
> >> =20
> >> +class MonitorResponseError(qmp.qmp.QMPError):
> >> +    '''
> >> +    Represents erroneous QMP monitor reply
> >> +    '''
> >> +    def __init__(self, reply):
> >> +        try:
> >> +            desc =3D reply["error"]["desc"]
> >> +        except KeyError:
> >> +            desc =3D reply
> >                       ^^^ (*)
> >> +        super(MonitorResponseError, self).__init__(repr(desc))
> >=20
> > This will end up calling Exception.__init__.  I previously
> > suggested repr(desc) above(*) because I didn't know what happened
> > when the Exception.__init__ argument is not a string.
> >=20
> > I couldn't find any documentation on the right argument types for
> > Exception.__init__.  The examples in the Python documentation[1]
> > don't call Exception.__init__ at all: they simply implement
> > __str__().
> >=20
> > However, based on my testing and on the BaseException
> > documentation[2], I believe repr() isn't really necessary:
> >=20
> > "If str() or unicode() is called on an instance of this class,
> > the representation of the argument(s) to the instance are
> > returned, or the empty string when there were no arguments."
> >=20
> > So your previous version was good, already.
> >=20
> > But maybe we could do this instead, to make the constructor as
> > simple as possible:
> >=20
> > class MonitorResponseError(qmp.qmp.QMPError):
> >     def __init__(self, reply):
> >         self.reply =3D reply
> >=20
> >     def __str__(self):
> >         return self.reply.get('error', {}).get('desc', repr(self.repl=
y))
> >=20
> Well I know I can implement custom `__str__` class, but the
> default one simply stores the argument as string and reports
> it, so for simple strings I usually go with super call and with
> complex ones with custom `__str__`. Anyway if this suits this
> project style better I'll change it in v2.

If you prefer it, your previous version (without repr) was good
enough to me.

--=20
Eduardo
