Received: from eggs.gnu.org ([2001:4830:134:3::10]:55589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gOjkd-0003H2-Ib
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 08:38:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gOjkX-000833-Vm
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 08:38:07 -0500
Date: Mon, 19 Nov 2018 14:37:48 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181119133748.GF8066@localhost.localdomain>
References: <20181116164526.31487-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181116164526.31487-1-mreitz@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1? v2 0/3] block: Fix two minor
 reopen issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>, Fam Zheng <famz@redhat.com>

Am 16.11.2018 um 17:45 hat Max Reitz geschrieben:
> These are fixes for issues I found when looking after something Berto
> has reported.  The second patch fixes that issue Berto found, the first
> one is only kind of related.
>=20
> For the first patch:  bdrv_reopen_abort() or bdrv_reopen_commit() are
> called only if the respective bdrv_reopen_prepare() has succeeded.
> However, bdrv_reopen_prepare() can fail even if the block driver=E2=80=99=
s
> .bdrv_reopen_prepare() succeeded.  In that case, the block driver is
> expecting a .bdrv_reopen_abort() or .bdrv_reopen_commit(), but will
> never get it.
>=20
> This is fixed by making bdrv_reopen_prepare() call .bdrv_reopen_abort()
> if an error occurs after .bdrv_reopen_prepare() has already succeeded.
>=20
> In practice this just prevents resource leaks, so nothing too dramatic
> (fine for qemu-next).  It also means I=E2=80=99ve been incapable of wri=
ting a
> test, sorry.
>=20
>=20
> The second issue is more severe: file-posix applies the inverse share
> locks when reopening.  Now the user can only directly do reopens from
> the monitor for now, so that wouldn=E2=80=99t be so bad.  But of course=
 there
> are other places in qemu that implicitly reopen nodes, like dropping
> R/W to RO or gaining R/W from RO.  Most of these places are symmetrical
> at least (they=E2=80=99ll get R/W on an RO image for a short period of =
time and
> then drop back to RO), so you=E2=80=99ll see the wrong shared permissio=
n locks
> only for a short duration.  But at least blockdev-snapshot and
> blockdev-snapshot-sync are one way; they drop R/W to RO and stay there.
> So if you do a blockdev-snapshot*, the shared permission bits will be
> flipped.  This is therefore very much user-visible.
>=20
> It=E2=80=99s not catastrophic, though, so I=E2=80=99m not sure whether =
we need it in
> 3.1.  It=E2=80=99s definitely a bugfix, and I think we have patches que=
ued for
> the next RC already, so I think it makes sense to include at least
> patches 2 and 3 as well.

Thanks, applied to the block branch.

Kevin
