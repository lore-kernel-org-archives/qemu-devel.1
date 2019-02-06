Received: from eggs.gnu.org ([209.51.188.92]:42462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1grKlN-0001RS-9l
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 05:49:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1grKlM-0004U4-FM
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 05:49:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1grKlM-0004QQ-9X
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 05:49:04 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 66EFB46202
	for <qemu-devel@nongnu.org>; Wed,  6 Feb 2019 10:48:59 +0000 (UTC)
Date: Wed, 6 Feb 2019 11:48:51 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20190206104851.GT5349@paraplu.home>
References: <20190205134926.8312-1-marcandre.lureau@redhat.com>
	<781b71d9-f045-ffa9-3674-f6222f6e7e0b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <781b71d9-f045-ffa9-3674-f6222f6e7e0b@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qmp-shell: fix nested json regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com, Cleber Rosa <crosa@redhat.com>, ehabkost@redhat.com

On Tue, Feb 05, 2019 at 08:44:12PM -0500, John Snow wrote:
> On 2/5/19 8:49 AM, Marc-Andr=E9 Lureau wrote:

[...]

> > Replace with a regexp to split while respecting quoted strings and pr=
eserving quotes:
> >=20
> > re.findall(r'''(?:[^\s"']|"(?:\\.|[^"])*"|'(?:\\.|[^'])*')+''', cmd)
> > ['blockdev-create',
> >  'job-id=3D"job0 foo"',
> >  'options=3D{"driver":"qcow2","size":16384,"file":{"driver":"file","f=
ilename":"foo.qcow2"}}']
> >=20
> > Fixes: fcfab7541 ("qmp-shell: learn to send commands with quoted argu=
ments")
> > Reported-by: Kashyap Chamarthy <kchamart@redhat.com>
> > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  scripts/qmp/qmp-shell | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
> > index 770140772d..813dd68232 100755
> > --- a/scripts/qmp/qmp-shell
> > +++ b/scripts/qmp/qmp-shell
> > @@ -74,7 +74,7 @@ import sys
> >  import os
> >  import errno
> >  import atexit
> > -import shlex
> > +import re
> > =20
> >  class QMPCompleter(list):
> >      def complete(self, text, state):
> > @@ -220,7 +220,7 @@ class QMPShell(qmp.QEMUMonitorProtocol):
> > =20
> >              < command-name > [ arg-name1=3Darg1 ] ... [ arg-nameN=3D=
argN ]
> >          """
> > -        cmdargs =3D shlex.split(cmdline)
> > +        cmdargs =3D re.findall(r'''(?:[^\s"']|"(?:\\.|[^"])*"|'(?:\\=
.|[^'])*')+''', cmdline)
>=20
> It might really be nice to have a comment briefly explaining the regex.
> This is pretty close to symbol soup.

Yeah, a little comment explaining it would be nice. =20

And thanks for the fix, indeed.  FWIW:

    Tested-by: Kashyap Chamarthy <kchamart@redhat.com>

> Though I suppose we are approaching the limits of what this hacky littl=
e
> debug script can do for us...

It is good enough for 80% of the cases. :-)

--=20
/kashyap
