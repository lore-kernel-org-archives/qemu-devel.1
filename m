Received: from eggs.gnu.org ([2001:4830:134:3::10]:38148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fXtNf-0000DT-4O
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 15:12:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fXtNc-0006uT-Fy
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 15:11:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36700 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fXtNc-0006uH-AC
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 15:11:56 -0400
Date: Tue, 26 Jun 2018 20:11:51 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180626191151.GD2505@work-vm>
References: <20180609141457.6283-1-vsementsov@virtuozzo.com>
	<20180615120649.GC2615@work-vm>
	<f40607cd-a777-b033-ae37-0be50e3bc3d2@virtuozzo.com>
	<20180625171447.GJ2390@work-vm> <20180625175039.GK2390@work-vm>
	<40eea991-4e7f-c06b-dee4-334a245721cf@redhat.com>
	<7b6640d1-9e93-4692-500b-f1bce22852ab@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <7b6640d1-9e93-4692-500b-f1bce22852ab@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] migration: invalidate cache before source
 start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com

* Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
> 25.06.2018 21:03, John Snow wrote:
> >=20
> > On 06/25/2018 01:50 PM, Dr. David Alan Gilbert wrote:
> > > * Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
> > > > * Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
> > > > > 15.06.2018 15:06, Dr. David Alan Gilbert wrote:
> > > > > > * Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wro=
te:
> > > > > > > Invalidate cache before source start in case of failed migr=
ation.
> > > > > > >=20
> > > > > > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@vir=
tuozzo.com>
> > > > > > Why doesn't the code at the bottom of migration_completion,
> > > > > > fail_invalidate:   and the code in migrate_fd_cancel   handle=
 this?
> > > > > >=20
> > > > > > What case did you see it in that those didn't handle?
> > > > > > (Also I guess it probably should set s->block_inactive =3D fa=
lse)
> > > > > on source I see:
> > > > >=20
> > > > > 81392@1529065750.766289:migrate_set_state new state 7
> > > > > 81392@1529065750.766330:migration_thread_file_err
> > > > > 81392@1529065750.766332:migration_thread_after_loop
> > > > >=20
> > > > > so, we are leaving loop on
> > > > >  =A0=A0=A0=A0=A0=A0=A0 if (qemu_file_get_error(s->to_dst_file))=
 {
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 migrate_set_state(&s->state,=
 current_active_state,
> > > > > MIGRATION_STATUS_FAILED);
> > > > > trace_migration_thread_file_err();
> > > > > break;
> > > > >  =A0=A0=A0=A0=A0=A0=A0 }
> > > > >=20
> > > > > and skip migration_completion()
> > > > Yeh, OK; I'd seen soemthing else a few days ago, where a cancella=
tion
> > > > test that had previously ended with a 'cancelled' state has now e=
nded up
> > > > in 'failed' (which is the state 7 you have above).
> > > > I suspect there's something else going on as well; I think what i=
s
> > > > supposed to happen in the case of 'cancel' is that it spins in 'c=
ancelling' for
> > > > a while in migrate_fd_cancel and then at the bottom of migrate_fd=
_cancel
> > > > it does the recovery, but because it's going to failed instead, t=
hen
> > > > it's jumping over that recovery.
> > > Going back and actually looking at the patch again;
> > > can I ask for 1 small change;
> > >     Can you set s->block_inactive =3D false   in the case where you
> > > don't get the local_err (Like we do at the bottom of migrate_fd_can=
cel)
> > >=20
> > >=20
> > > Does that make sense?
> > >=20
> > > Thanks,
> > >=20
> > > Dave
> > >=20
> > Vladimir, one more question for you because I'm not as familiar with
> > this code:
> >=20
> > In the normal case we need to invalidate the qcow2 cache as a way to
> > re-engage the disk (yes?) when we have failed during the late-migrati=
on
> > steps.
> >=20
> > In this case, we seem to be observing a failure during the bulk trans=
fer
> > loop. Why is it important to invalidate the cache at this step -- wou=
ld
> > the disk have been inactivated yet? It shouldn't, because it's in the
> > bulk transfer phase -- or am I missing something?
> >=20
> > I feel like this code is behaving in a way that's fairly surprising f=
or
> > a casual reader so I was hoping you could elaborate for me.
> >=20
> > --js
>=20
> In my case, source is already in postcopy state, when error occured, so=
 it
> is inactivated.

Ah, that explains why I couldn't understand the path that got you there;
I never think about restarting the source once we're in postcopy -
because once the destination is running all is lost.
But, you might be in the gap efore management has actually started
the destination so it does need fixing.

Dave

> --=20
> Best regards,
> Vladimir
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
