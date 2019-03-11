Received: from eggs.gnu.org ([209.51.188.92]:44081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1h3Ky8-0002Ae-78
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:27:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1h3Ky6-0008NU-Ba
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:27:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37731)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1h3Ky6-0008Iq-1V
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:27:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5A6EF3DDB6
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 13:27:45 +0000 (UTC)
Date: Mon, 11 Mar 2019 10:27:36 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190311132736.GI8899@habkost.net>
References: <20190205134926.8312-1-marcandre.lureau@redhat.com>
	<9b037d46-8e73-e5ee-49f2-0c79f06e758f@redhat.com>
	<8736nw775l.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <8736nw775l.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: John Snow <jsnow@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, kchamart@redhat.com, Cleber Rosa <crosa@redhat.com>

On Sat, Mar 09, 2019 at 10:01:58AM +0100, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
>=20
> > On 2/5/19 8:49 AM, Marc-Andr=E9 Lureau wrote:
> >> Commit fcfab7541 ("qmp-shell: learn to send commands with quoted
> >> arguments") introduces the usage of Python 'shlex' to handle quoted
> >> arguments, but it accidentally broke generation of nested JSON
> >> structs.
> >>=20
> >> shlex drops quotes, which breaks parsing of the nested struct.
> >>=20
> >> cmd=3D'blockdev-create job-id=3D"job0 foo" options=3D{"driver":"qcow=
2","size":16384,"file":{"driver":"file","filename":"foo.qcow2"}}'
> >>=20
> >> shlex.split(cmd)
> >> ['blockdev-create',
> >>  'job-id=3Djob0 foo',
> >>  'options=3D{driver:qcow2,size:16384,file:{driver:file,filename:foo.=
qcow2}}']
> >>=20
> >> Replace with a regexp to split while respecting quoted strings and p=
reserving quotes:
> >>=20
> >> re.findall(r'''(?:[^\s"']|"(?:\\.|[^"])*"|'(?:\\.|[^'])*')+''', cmd)
> >> ['blockdev-create',
> >>  'job-id=3D"job0 foo"',
> >>  'options=3D{"driver":"qcow2","size":16384,"file":{"driver":"file","=
filename":"foo.qcow2"}}']
> >>=20
> >> Fixes: fcfab7541 ("qmp-shell: learn to send commands with quoted arg=
uments")
> >> Reported-by: Kashyap Chamarthy <kchamart@redhat.com>
> >> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> >
> > Hi, did this get misplaced? Would be nice to have back for 4.0 releas=
e.
>=20
> Eduardo, Cleber, I think this one's for you.

Queued, thanks.

I'm really bothered by the lack of tests for qmp-shell
command-line parsing.  Does anybody volunteer to write a small
set of doctest examples for __build_cmd()?

--=20
Eduardo
