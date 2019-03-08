Received: from eggs.gnu.org ([209.51.188.92]:42003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h2OK1-0001wh-Rh
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 17:50:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h2OK1-0007CJ-3b
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 17:50:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1h2OK0-00074X-DG
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 17:50:32 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AE22E3087BD5
	for <qemu-devel@nongnu.org>; Fri,  8 Mar 2019 22:50:19 +0000 (UTC)
References: <20190205134926.8312-1-marcandre.lureau@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <9b037d46-8e73-e5ee-49f2-0c79f06e758f@redhat.com>
Date: Fri, 8 Mar 2019 17:50:18 -0500
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

Hi, did this get misplaced? Would be nice to have back for 4.0 release.
