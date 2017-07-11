Received: from eggs.gnu.org ([2001:4830:134:3::10]:35778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dUxIZ-0007Aa-0y
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:42:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dUxIY-0001eJ-1L
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:42:03 -0400
Date: Tue, 11 Jul 2017 11:41:45 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <1177675548.49553273.1499787705474.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170711152356.GA31231@stefanha-x1.localdomain>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
	<20170704220346.29244-3-marcandre.lureau@redhat.com>
	<20170711152356.GA31231@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/35] WIP: coroutine: manually tag the
 fast-paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Jeff Cody <jcody@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, "open list:Sheepdog" <sheepdog@lists.wpkg.org>, Stefan Hajnoczi <stefanha@redhat.com>, Liu Yuan <namei.unix@gmail.com>

Hi

----- Original Message -----
> On Wed, Jul 05, 2017 at 12:03:13AM +0200, Marc-Andr=C3=A9 Lureau wrote:
> > Some functions are both regular and coroutine. They may call coroutine
> > functions in some cases, if it is known to be running in a coroutine.
> >=20
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  block.c                 |  2 ++
> >  block/block-backend.c   |  2 ++
> >  block/io.c              | 16 +++++++++++++++-
> >  block/sheepdog.c        |  2 ++
> >  block/throttle-groups.c | 10 ++++++++--
> >  migration/rdma.c        |  2 ++
> >  6 files changed, 31 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/block.c b/block.c
> > index 694396281b..b08c006da4 100644
> > --- a/block.c
> > +++ b/block.c
> > @@ -443,7 +443,9 @@ int bdrv_create(BlockDriver *drv, const char* filen=
ame,
> > =20
> >      if (qemu_in_coroutine()) {
> >          /* Fast-path if already in coroutine context */
> > +        co_role_acquire(_coroutine_fn);
> >          bdrv_create_co_entry(&cco);
> > +        co_role_release(_coroutine_fn);
> >      } else {
> >          co =3D qemu_coroutine_create(bdrv_create_co_entry, &cco);
> >          qemu_coroutine_enter(co);
>=20
> I guess the clever analysis for clang would be to detect that if
> (qemu_in_coroutine()) means we have the _coroutine_fn role.  It's
> similar to how Coverity sees an if (ptr) and knows whether the pointer
> is NULL/non-NULL in the branches.
>=20
> But this patch is okay too :-).

Right, I though about using try_acquire_capability, similarly needed for tr=
y_lock etc. However, I don't see how to automatically release the capabilit=
y when going out of scope. Apparently there are some known limitations arou=
nd these patterns. I would love to hear from compilers folks what they thin=
k about -Wthread-safety and if it can be added to gcc with various kind of =
improvements.
