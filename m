Received: from eggs.gnu.org ([209.51.188.92]:47195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hCMTc-0004Qx-Lh
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 06:53:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hCMTZ-0005iI-FW
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 06:53:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hCMTY-0005gm-Ml
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 06:53:37 -0400
Date: Fri, 5 Apr 2019 11:53:27 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190405105326.GD2819@work-vm>
References: <e5fb5172-983a-c8a0-1d86-8406fe8ff99c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <e5fb5172-983a-c8a0-1d86-8406fe8ff99c@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] How to correctly use more than 2 floppy drives?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

* Philippe Mathieu-Daud=E9 (philmd@redhat.com) wrote:
> Hi,
>=20
> I am trying to understand the possible values for the MAX_FD variable
> used by the floppy controller model (hw/block/fdc.c).
>=20
> Looking at git history:
>=20
> - 2004-01-05 7138fcfbf7dd + 8977f3c107ef (Jocelyn Mayer):
>   FDC introduced with "#define MAX_FD 2"
>=20
> - 2008-04-29 78ae820cfeb0 (Herv=E9 Poussineau):
>   Supports up to 4 floppy drives if MAX_FD is set to 4
>   Migration stream knows about runtime value of MAX_FD
>=20
> - 2009-09-10 d7a6c2703577 (Juan Quintela):
>   FDC vmstate-ified
>   Migration stream use compile time value of MAX_FD
>=20
> Since 7138fcfbf7dd MAX_FD has always been defined as 2.
>=20
> Since d7a6c2703577 MAX_FD can not be different than 2 without breaking
> migration.
>=20
> If I understand correctly migration, first we should change in
> vmstate_fdc the user-definable MAX_FD by a constant 2 value.

Right.

> Then to be able to use >2 floppy disks I have to modify the the
> vmstate.version_id, and
>=20
> 1/ add a new field in the vmstate_fdc containing the number of drives
> and add code to check >2 and adapt
>=20
> or
>=20
> 2/ change MAX_FD to 4 for all the codebase, adding some code to migrate
> to older FDC with only 2 disks...

Or, you add a subsection which is conditional on MAX_FD > 2 and which
only stores the state of the extra FDs.

> Another option I don't like is:
>=20
> 3/ get ride of MAX_FD !=3D 2 and clean the codebase...

Seems sane to me.

> $ git grep '#if MAX_FD'
> hw/block/fdc.c:744:#if MAX_FD =3D=3D 4
> hw/block/fdc.c:758:#if MAX_FD =3D=3D 4
> hw/block/fdc.c:1317:#if MAX_FD =3D=3D 4
> hw/block/fdc.c:1340:#if MAX_FD =3D=3D 4
> hw/block/fdc.c:2041:#if MAX_FD =3D=3D 4
> hw/block/fdc.c:2079:#if MAX_FD =3D=3D 4
> hw/block/fdc.c:2104:#if MAX_FD =3D=3D 4
>=20
> Herv=E9, what board are/were you using with 4 floppy drives?
>=20
> BTW this link is somehow interesting :)
> https://www.seasip.info/VintagePC/floppies.html

Ah interesting; I did wonder because I've never seen machines
with more than 2 (double sided) drives.

Dave

> Thanks,
>=20
> Phil.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
