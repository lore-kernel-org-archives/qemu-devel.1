Received: from eggs.gnu.org ([209.51.188.92]:51750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMfI4-0003J3-L6
	for qemu-devel@nongnu.org; Fri, 03 May 2019 17:00:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMfI1-0003Q0-Ih
	for qemu-devel@nongnu.org; Fri, 03 May 2019 17:00:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hMfI0-0003Ff-Hm
	for qemu-devel@nongnu.org; Fri, 03 May 2019 17:00:16 -0400
Date: Fri, 3 May 2019 18:00:11 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190503210011.GW28722@habkost.net>
References: <20190503004130.8285-1-ehabkost@redhat.com>
	<20190503004130.8285-20-ehabkost@redhat.com>
	<40c4d236-ed76-e433-51d5-c9feabb4374a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <40c4d236-ed76-e433-51d5-c9feabb4374a@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 19/19] configure: automatically pick python3
 is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Fri, May 03, 2019 at 06:41:43PM +0200, Thomas Huth wrote:
> On 03/05/2019 02.41, Eduardo Habkost wrote:
> > From: Daniel P. Berrang=E9 <berrange@redhat.com>
> >=20
> > Unless overridden via an env var or configure arg, QEMU will only loo=
k
> > for the 'python' binary in $PATH. This is unhelpful on distros which
> > are only shipping Python 3.x (eg Fedora) in their default install as,
> > if they comply with PEP 394, the bare 'python' binary won't exist.
> >=20
> > This changes configure so that by default it will search for all thre=
e
> > common python binaries, preferring to find Python 3.x versions.
> >=20
> > Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> > Message-Id: <20190327170701.23798-1-berrange@redhat.com>
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  configure | 18 +++++++++++++++---
> >  1 file changed, 15 insertions(+), 3 deletions(-)
>=20
> I haven't bisected it, but I think this patch here broke the gitlab-ci =
tests:
>=20
>  https://gitlab.com/huth/qemu/-/jobs/206806257
>=20
> Seems like the test is now failing when you don't have an UTF-8 locale:
>=20
>  LANG=3DC make check-qapi-schema

I couldn't reproduce it this way, probably because I'm running Python 3.7=
 which
implements PEP 538 ("Coercing the legacy C locale to a UTF-8 based locale=
").

But I can force it to break using:

  PYTHONIOENCODING=3Dascii make check-qapi-schema

>  [...]
>  TEST    tests/qapi-schema/union-base-empty.out
>  --- /builds/huth/qemu/tests/qapi-schema/unicode-str.err	2019-05-03 15:=
21:39.000000000 +0000
>  +++ -	2019-05-03 15:42:01.561762978 +0000
>  @@ -1 +1 @@
>  -tests/qapi-schema/unicode-str.json:2: 'command' uses invalid name '=E9=
'
>  +tests/qapi-schema/unicode-str.json:2: 'command' uses invalid name '\x=
e9'
>  /builds/huth/qemu/tests/Makefile.include:1105: recipe for target 'chec=
k-tests/qapi-schema/unicode-str.json' failed
>  make: *** [check-tests/qapi-schema/unicode-str.json] Error 1
>=20
> Any ideas how to fix this?

Probably we just need to specify an explicit encoding at the statement th=
at
prints the error message to stderr.  I will give it a try.

--=20
Eduardo
