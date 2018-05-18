Received: from eggs.gnu.org ([2001:4830:134:3::10]:53955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fJcis-0002Fz-4Y
	for qemu-devel@nongnu.org; Fri, 18 May 2018 06:34:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fJcin-0005SN-8d
	for qemu-devel@nongnu.org; Fri, 18 May 2018 06:34:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58734 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fJcin-0005Rk-40
	for qemu-devel@nongnu.org; Fri, 18 May 2018 06:34:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CCFCE857A7
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 10:34:47 +0000 (UTC)
Date: Fri, 18 May 2018 11:34:42 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180518103441.GD2478@work-vm>
References: <20180515234017.2277-1-quintela@redhat.com>
	<20180515234017.2277-11-quintela@redhat.com>
	<20180518085902.GB4833@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180518085902.GB4833@localhost.localdomain>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 10/40] migration: Delay start of migration
 main routines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com, berrange@redhat.com

* Kevin Wolf (kwolf@redhat.com) wrote:
> Am 16.05.2018 um 01:39 hat Juan Quintela geschrieben:
> > We need to make sure that we have started all the multifd threads.
> >=20
> > Signed-off-by: Juan Quintela <quintela@redhat.com>
> > Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>
>=20
> This commit makes qemu-iotests 091 hang for me. Either it breaks
> backward compatibility intentionally and we need to update the test
> case, or there is a bug somewhere.

It's not an intentional break.
And the avocado tcp and exec migrations pass OK, so hmm.

Dave

> Can you have a look, please?
>=20
> Kevin
>=20
> > ---
> >  migration/migration.c | 4 ++--
> >  migration/migration.h | 1 +
> >  migration/ram.c       | 3 +++
> >  migration/socket.c    | 4 ++++
> >  4 files changed, 10 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 8e5b421b97..61c4ee7850 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -430,7 +430,7 @@ static void migration_incoming_setup(QEMUFile *f)
> >      qemu_file_set_blocking(f, false);
> >  }
> > =20
> > -static void migration_incoming_process(void)
> > +void migration_incoming_process(void)
> >  {
> >      Coroutine *co =3D qemu_coroutine_create(process_incoming_migrati=
on_co, NULL);
> >      qemu_coroutine_enter(co);
> > @@ -448,7 +448,7 @@ void migration_ioc_process_incoming(QIOChannel *i=
oc)
> > =20
> >      if (!mis->from_src_file) {
> >          QEMUFile *f =3D qemu_fopen_channel_input(ioc);
> > -        migration_fd_process_incoming(f);
> > +        migration_incoming_setup(f);
> >          return;
> >      }
> >      multifd_recv_new_channel(ioc);
> > diff --git a/migration/migration.h b/migration/migration.h
> > index 7c69598c54..26e5951d56 100644
> > --- a/migration/migration.h
> > +++ b/migration/migration.h
> > @@ -200,6 +200,7 @@ void migrate_set_state(int *state, int old_state,=
 int new_state);
> > =20
> >  void migration_fd_process_incoming(QEMUFile *f);
> >  void migration_ioc_process_incoming(QIOChannel *ioc);
> > +void migration_incoming_process(void);
> > =20
> >  bool  migration_has_all_channels(void);
> > =20
> > diff --git a/migration/ram.c b/migration/ram.c
> > index 87434d3fce..f7e8615e15 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -717,6 +717,9 @@ void multifd_recv_new_channel(QIOChannel *ioc)
> >      qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
> >                         QEMU_THREAD_JOINABLE);
> >      atomic_inc(&multifd_recv_state->count);
> > +    if (multifd_recv_state->count =3D=3D migrate_multifd_channels())=
 {
> > +        migration_incoming_process();
> > +    }
> >  }
> > =20
> >  /**
> > diff --git a/migration/socket.c b/migration/socket.c
> > index e09fd1aae5..7a5eb562b8 100644
> > --- a/migration/socket.c
> > +++ b/migration/socket.c
> > @@ -170,6 +170,10 @@ static void socket_accept_incoming_migration(QIO=
NetListener *listener,
> >          qio_net_listener_disconnect(listener);
> > =20
> >          object_unref(OBJECT(listener));
> > +
> > +        if (!migrate_use_multifd()) {
> > +            migration_incoming_process();
> > +        }
> >      }
> >  }
> > =20
> > --=20
> > 2.17.0
> >=20
> >=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
