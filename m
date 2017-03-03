Received: from eggs.gnu.org ([2001:4830:134:3::10]:58439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cjnEh-0002lM-UI
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:27:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cjnEc-0004u1-WB
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:27:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cjnEc-0004tg-OL
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:27:02 -0500
Date: Fri, 3 Mar 2017 13:26:54 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170303132653.GD2439@work-vm>
References: <33183CC9F5247A488A2544077AF19020DA1D01C2@DGGEMA505-MBX.china.huawei.com>
	<20170303120054.GB2439@work-vm>
	<10d66d73-a269-acb4-bc3d-2250793cba8e@redhat.com>
	<20170303131150.GC2439@work-vm>
	<bcaabb9b-44a6-ee7d-14b9-eade207e1538@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <bcaabb9b-44a6-ee7d-14b9-eade207e1538@redhat.com>
Subject: Re: [Qemu-devel] [Bug?] BQL about live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "quintela@redhat.com" <quintela@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, yanghongyang <yanghongyang@huawei.com>, Huangzhichao <huangzhichao@huawei.com>

* Paolo Bonzini (pbonzini@redhat.com) wrote:
>=20
>=20
> On 03/03/2017 14:11, Dr. David Alan Gilbert wrote:
> > * Paolo Bonzini (pbonzini@redhat.com) wrote:
> >>
> >>
> >> On 03/03/2017 13:00, Dr. David Alan Gilbert wrote:
> >>> Ouch that's pretty nasty; I remember Paolo explaining to me a while a=
go that
> >>> their were times when run_on_cpu would have to drop the BQL and I wor=
ried about it,
> >>> but this is the 1st time I've seen an error due to it.
> >>>
> >>> Do you know what the migration state was at that point? Was it MIGRAT=
ION_STATUS_CANCELLING?
> >>> I'm thinking perhaps we should stop 'cont' from continuing while migr=
ation is in
> >>> MIGRATION_STATUS_CANCELLING.  Do we send an event when we hit CANCELL=
ED - so that
> >>> perhaps libvirt could avoid sending the 'cont' until then?
> >>
> >> No, there's no event, though I thought libvirt would poll until
> >> "query-migrate" returns the cancelled state.  Of course that is a small
> >> consolation, because a segfault is unacceptable.
> >=20
> > I think you might get an event if you set the new migrate capability ca=
lled
> > 'events' on!
> >=20
> > void migrate_set_state(int *state, int old_state, int new_state)
> > {
> >     if (atomic_cmpxchg(state, old_state, new_state) =3D=3D old_state) {
> >         trace_migrate_set_state(new_state);
> >         migrate_generate_event(new_state);
> >     }
> > }
> >=20
> > static void migrate_generate_event(int new_state)
> > {
> >     if (migrate_use_events()) {
> >         qapi_event_send_migration(new_state, &error_abort);=20
> >     }
> > }
> >=20
> > That event feature went in sometime after 2.3.0.
> >=20
> >> One possibility is to suspend the monitor in qmp_migrate_cancel and
> >> resume it (with add_migration_state_change_notifier) when we hit the
> >> CANCELLED state.  I'm not sure what the latency would be between the e=
nd
> >> of migrate_fd_cancel and finally reaching CANCELLED.
> >=20
> > I don't like suspending monitors; it can potentially take quite a signi=
ficant
> > time to do a cancel.
> > How about making 'cont' fail if we're in CANCELLING?
>=20
> Actually I thought that would be the case already (in fact CANCELLING is
> internal only; the outside world sees it as "active" in query-migrate).
>=20
> Lei, what is the runstate?  (That is, why did cont succeed at all)?

I suspect it's RUN_STATE_FINISH_MIGRATE - we set that before we do the devi=
ce
save, and that's what we get at the end of a migrate and it's legal to rest=
art
=66rom there.

> Paolo
>=20
> > I'd really love to see the 'run_on_cpu' being more careful about the BQ=
L;
> > we really need all of the rest of the devices to stay quiesced at times.
>=20
> That's not really possible, because of how condition variables work. :(

*Really* we need to find a solution to that - there's probably lots of=20
other things that can spring up in that small window other than the
'cont'.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
