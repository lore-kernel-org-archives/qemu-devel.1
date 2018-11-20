Received: from eggs.gnu.org ([2001:4830:134:3::10]:56333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gP9k1-0004Gk-Lp
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 12:23:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gP9jt-0002zU-US
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 12:23:07 -0500
Date: Tue, 20 Nov 2018 17:22:42 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181120172241.GC5072@work-vm>
References: <20181120152753.10463-1-marcandre.lureau@redhat.com>
	<20181120152753.10463-3-marcandre.lureau@redhat.com>
	<03454b5c-f889-9401-f502-5b14eaab40c8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <03454b5c-f889-9401-f502-5b14eaab40c8@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1? 2/3] migration: fix
 stringop-truncation warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>, Jeff Cody <jcody@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Liu Yuan <namei.unix@gmail.com>

* Eric Blake (eblake@redhat.com) wrote:
> On 11/20/18 9:27 AM, Marc-Andr=E9 Lureau wrote:
> > Adding an assert is enough to silence GCC.
> >=20
> > ~/src/qemu/migration/global_state.c: In function 'global_state_store_=
running':
> > ~/src/qemu/migration/global_state.c:45:5: error: 'strncpy' specified =
bound 100 equals destination size [-Werror=3Dstringop-truncation]
> >       strncpy((char *)global_state.runstate,
> >       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >              state, sizeof(global_state.runstate));
> >              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
> >=20
> > (alternatively, we could hard-code "running")
> >=20
> > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   migration/global_state.c | 1 +
> >   1 file changed, 1 insertion(+)
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> I think this is safe for 3.1, but I know the migration code is particul=
arly
> wary of assert()s, even when they are non-triggerable (a 100-byte buffe=
r at
> global_state.runstate is big enough for ALL of the run states, not just
> RUN_STATE_RUNNING).

That's OK; the universe would have to be particularly broken to trigger
that one, and it's in no way connected with any state, so it would
trigger on even the most basic tests.

However, I wonder if this fixes the problem on mingw builds - windows
asserts are not marked as noreturn.

Dave

> >=20
> > diff --git a/migration/global_state.c b/migration/global_state.c
> > index 8e8ab5c51e..01805c567a 100644
> > --- a/migration/global_state.c
> > +++ b/migration/global_state.c
> > @@ -42,6 +42,7 @@ int global_state_store(void)
> >   void global_state_store_running(void)
> >   {
> >       const char *state =3D RunState_str(RUN_STATE_RUNNING);
> > +    assert(strlen(state) < sizeof(global_state.runstate));
> >       strncpy((char *)global_state.runstate,
> >              state, sizeof(global_state.runstate));
> >   }
> >=20
>=20
> --=20
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
