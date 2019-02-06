Received: from eggs.gnu.org ([209.51.188.92]:41398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1grCGF-0000LC-1O
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 20:44:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1grCGC-00066k-Un
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 20:44:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1grCGA-00064s-Pi
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 20:44:20 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CE9DD73
	for <qemu-devel@nongnu.org>; Wed,  6 Feb 2019 01:44:16 +0000 (UTC)
References: <20190205134926.8312-1-marcandre.lureau@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <781b71d9-f045-ffa9-3674-f6222f6e7e0b@redhat.com>
Date: Tue, 5 Feb 2019 20:44:12 -0500
MIME-Version: 1.0
In-Reply-To: <20190205134926.8312-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, Cleber Rosa <crosa@redhat.com>, ehabkost@redhat.com, kchamart@redhat.com



On 2/5/19 8:49 AM, Marc-Andr=C3=A9 Lureau wrote:
> Commit fcfab7541 ("qmp-shell: learn to send commands with quoted
> arguments") introduces the usage of Python 'shlex' to handle quoted
> arguments, but it accidentally broke generation of nested JSON
> structs.
>=20
> shlex drops quotes, which breaks parsing of the nested struct.
>=20
> cmd=3D'blockdev-create job-id=3D"job0 foo" options=3D{"driver":"qcow2",=
"size":16384,"file":{"driver":"file","filename":"foo.qcow2"}}'
>=20
> shlex.split(cmd)
> ['blockdev-create',
>  'job-id=3Djob0 foo',
>  'options=3D{driver:qcow2,size:16384,file:{driver:file,filename:foo.qco=
w2}}']
>=20
> Replace with a regexp to split while respecting quoted strings and pres=
erving quotes:
>=20
> re.findall(r'''(?:[^\s"']|"(?:\\.|[^"])*"|'(?:\\.|[^'])*')+''', cmd)
> ['blockdev-create',
>  'job-id=3D"job0 foo"',
>  'options=3D{"driver":"qcow2","size":16384,"file":{"driver":"file","fil=
ename":"foo.qcow2"}}']
>=20
> Fixes: fcfab7541 ("qmp-shell: learn to send commands with quoted argume=
nts")
> Reported-by: Kashyap Chamarthy <kchamart@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qmp/qmp-shell | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
> index 770140772d..813dd68232 100755
> --- a/scripts/qmp/qmp-shell
> +++ b/scripts/qmp/qmp-shell
> @@ -74,7 +74,7 @@ import sys
>  import os
>  import errno
>  import atexit
> -import shlex
> +import re
> =20
>  class QMPCompleter(list):
>      def complete(self, text, state):
> @@ -220,7 +220,7 @@ class QMPShell(qmp.QEMUMonitorProtocol):
> =20
>              < command-name > [ arg-name1=3Darg1 ] ... [ arg-nameN=3Dar=
gN ]
>          """
> -        cmdargs =3D shlex.split(cmdline)
> +        cmdargs =3D re.findall(r'''(?:[^\s"']|"(?:\\.|[^"])*"|'(?:\\.|=
[^'])*')+''', cmdline)

It might really be nice to have a comment briefly explaining the regex.
This is pretty close to symbol soup.

Though I suppose we are approaching the limits of what this hacky little
debug script can do for us...

thank you for fixing it.

> =20
>          # Transactional CLI entry/exit:
>          if cmdargs[0] =3D=3D 'transaction(':
>=20
