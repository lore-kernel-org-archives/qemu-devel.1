Received: from eggs.gnu.org ([2001:4830:134:3::10]:36094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3eoG-0007Qb-NZ
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 05:34:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3eoD-0002zy-Ky
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 05:34:28 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:50714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1f3eoD-0002zu-Cp
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 05:34:25 -0400
Received: by mail-wm0-x22f.google.com with SMTP id t67so19382926wmt.0
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 02:34:25 -0700 (PDT)
Date: Wed, 4 Apr 2018 10:34:22 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180404093422.GH4467@stefanha-x1.localdomain>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1EKig6ypoSyM7jaD"
Content-Disposition: inline
In-Reply-To: <20180326150916.9602-1-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 00/38] RFC: monitor: add asynchronous
 command type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>


--1EKig6ypoSyM7jaD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 26, 2018 at 05:08:38PM +0200, Marc-Andr=E9 Lureau wrote:
> One of initial design goals of QMP was to have "asynchronous command
> completion" (http://wiki.qemu.org/Features/QAPI). Unfortunately, that
> goal was not fully achieved, and some broken bits left were removed
> progressively until commit 65207c59d that removed async command
> support.
>=20
> Yet there are clear benefits allowing the command handler to re-enter
> the main loop if the command cannot be handled synchronously, or if it
> is long-lasting. This is currently not possible and make some bugs
> such as rhbz#1230527 difficult to solve.  Furthermore, many QMP
> commands do IO and could be considered 'slow' and blocking the main
> loop today. The unwritten solution so far is to use a pair of
> command+event. But this approach has a number of issues, in particular
> to fix existing commands, and inadequacy since the event is
> broadcasted and may thus have command 'id' conflict, beside being
> rather inefficient and incorrect.

This paragraph implies changing the command+event QMP idiom but none of
the patches touch docs/interop/qmp-spec.txt.  So I guess this new
revision doesn't modify the QMP protocol anymore and this paragraph is
outdated?  This revision simply implements async command handlers but
QMP clients see no protocol change?

For more complex commands a coroutine would be cleaner than hand-written
async code.  The handler would look something like:

  QDict * coroutine_fn (*co_cmd)(Monitor *mon,
                                 const QDict *qdict,
                                 Error **errp)

The monitor invokes it from coroutine context.  The coroutine just needs
to return a QDict or set errp - no explicit QmpReturn API is needed.

Stefan

--1EKig6ypoSyM7jaD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaxJweAAoJEJykq7OBq3PIGJAH/RBQLwsY1PsjNA9SBNN65x9x
iTPP54Mc5hc7ydApdm2lvUI966FsHt/KL+DRxF53yWRfnGVetHGTHsW5bSdS5D/P
t4yNYHf0iEnAYuEX+PtlECFQKy5h8/JT+pX27jhQxGUSaTUAnbYlThmZ6fN1ZABe
PuNX76pl09DdEbcy5JmgvFOBQZFVjOjeityZuc8DY+sDlWs/OJAK+F0DxIF1f/UK
FzIpo8sZufg3sCqZI8oNKG/sKDFfa3KIZgR0ZQyBZTFsQWZWxVc0aimrgBybhfW1
pacMx2+RcXRkz2NaiZF/rN0YR9W55LI0kqICh/3zgK+EZO0YmTrH5atWGU3nh1o=
=vB5A
-----END PGP SIGNATURE-----

--1EKig6ypoSyM7jaD--
