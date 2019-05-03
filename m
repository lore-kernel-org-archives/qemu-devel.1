Received: from eggs.gnu.org ([209.51.188.92]:57041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMfq6-0005uT-FW
	for qemu-devel@nongnu.org; Fri, 03 May 2019 17:35:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMfq5-0001Zh-2z
	for qemu-devel@nongnu.org; Fri, 03 May 2019 17:35:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hMfq2-0001Y8-EB
	for qemu-devel@nongnu.org; Fri, 03 May 2019 17:35:27 -0400
Date: Fri, 3 May 2019 18:34:57 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190503213457.GX28722@habkost.net>
References: <20190503004130.8285-1-ehabkost@redhat.com>
	<20190503004130.8285-20-ehabkost@redhat.com>
	<40c4d236-ed76-e433-51d5-c9feabb4374a@redhat.com>
	<20190503210011.GW28722@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190503210011.GW28722@habkost.net>
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

On Fri, May 03, 2019 at 06:00:11PM -0300, Eduardo Habkost wrote:
> On Fri, May 03, 2019 at 06:41:43PM +0200, Thomas Huth wrote:
> > On 03/05/2019 02.41, Eduardo Habkost wrote:
> > > From: Daniel P. Berrang=E9 <berrange@redhat.com>
> > >=20
> > > Unless overridden via an env var or configure arg, QEMU will only l=
ook
> > > for the 'python' binary in $PATH. This is unhelpful on distros whic=
h
> > > are only shipping Python 3.x (eg Fedora) in their default install a=
s,
> > > if they comply with PEP 394, the bare 'python' binary won't exist.
> > >=20
> > > This changes configure so that by default it will search for all th=
ree
> > > common python binaries, preferring to find Python 3.x versions.
> > >=20
> > > Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> > > Message-Id: <20190327170701.23798-1-berrange@redhat.com>
> > > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > > ---
> > >  configure | 18 +++++++++++++++---
> > >  1 file changed, 15 insertions(+), 3 deletions(-)
> >=20
> > I haven't bisected it, but I think this patch here broke the gitlab-c=
i tests:
> >=20
> >  https://gitlab.com/huth/qemu/-/jobs/206806257
> >=20
> > Seems like the test is now failing when you don't have an UTF-8 local=
e:
> >=20
> >  LANG=3DC make check-qapi-schema
>=20
> I couldn't reproduce it this way, probably because I'm running Python 3=
.7 which
> implements PEP 538 ("Coercing the legacy C locale to a UTF-8 based loca=
le").
>=20
> But I can force it to break using:
>=20
>   PYTHONIOENCODING=3Dascii make check-qapi-schema
>=20
> >  [...]
> >  TEST    tests/qapi-schema/union-base-empty.out
> >  --- /builds/huth/qemu/tests/qapi-schema/unicode-str.err	2019-05-03 1=
5:21:39.000000000 +0000
> >  +++ -	2019-05-03 15:42:01.561762978 +0000
> >  @@ -1 +1 @@
> >  -tests/qapi-schema/unicode-str.json:2: 'command' uses invalid name '=
=E9'
> >  +tests/qapi-schema/unicode-str.json:2: 'command' uses invalid name '=
\xe9'
> >  /builds/huth/qemu/tests/Makefile.include:1105: recipe for target 'ch=
eck-tests/qapi-schema/unicode-str.json' failed
> >  make: *** [check-tests/qapi-schema/unicode-str.json] Error 1
> >=20
> > Any ideas how to fix this?
>=20
> Probably we just need to specify an explicit encoding at the statement =
that
> prints the error message to stderr.  I will give it a try.

Forcing a specific encoding inside test-qapi.py would very easy
on Python 3.7+ (sys.stderr.reconfigure(...)), but tricky on older
versions.  I believe this is the simplest way to fix the problem
on Python 3.5 and 3.6.

Can somebody confirm this really fixes the problem on gitlab-ci?

---
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 7c8b9c84b2..af88ab6f8b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -1103,7 +1103,7 @@ check-tests/qemu-iotests-quick.sh: tests/qemu-iotes=
ts-quick.sh qemu-img$(EXESUF)
 .PHONY: $(patsubst %, check-%, $(check-qapi-schema-y))
 $(patsubst %, check-%, $(check-qapi-schema-y)): check-%.json: $(SRC_PATH=
)/%.json
 	$(call quiet-command, PYTHONPATH=3D$(SRC_PATH)/scripts \
-		$(PYTHON) $(SRC_PATH)/tests/qapi-schema/test-qapi.py \
+		PYTHONIOENCODING=3Dutf-8 $(PYTHON) $(SRC_PATH)/tests/qapi-schema/test-=
qapi.py \
 		$^ >$*.test.out 2>$*.test.err; \
 		echo $$? >$*.test.exit, \
 		"TEST","$*.out")

--=20
Eduardo
