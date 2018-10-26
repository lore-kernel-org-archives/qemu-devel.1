Received: from eggs.gnu.org ([2001:4830:134:3::10]:45051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gG3z7-0001hs-Tg
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:25:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gG3z0-0007CS-Jm
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:25:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gG3z0-00073F-BO
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:25:06 -0400
Date: Fri, 26 Oct 2018 16:24:58 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181026152458.GC2388@work-vm>
References: <20181022110854.10284-1-fli@suse.com>
	<20181024212742.GB30830@xz-x1.hotspot.internet-for-guests.com>
	<45194647-7b30-df97-5517-1c758947a91e@suse.com>
	<20181025113229.GC30830@xz-x1.hotspot.internet-for-guests.com>
	<f528529e-e0e8-0264-422c-36e1a3881c49@suse.com>
	<20181026133546.GA5411@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181026133546.GA5411@xz-x1>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 0/2] Fix migration issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Fei Li <fli@suse.com>, qemu-devel@nongnu.org, quintela@redhat.com

* Peter Xu (peterx@redhat.com) wrote:
> On Fri, Oct 26, 2018 at 09:10:19PM +0800, Fei Li wrote:
> >=20
> >=20
> > On 10/25/2018 08:58 PM, Peter Xu wrote:
> > > On Thu, Oct 25, 2018 at 05:04:00PM +0800, Fei Li wrote:
> > >=20
> > > [...]
> > >=20
> > > > @@ -1325,22 +1325,24 @@ bool multifd_recv_all_channels_created(vo=
id)
> > > >  =A0/* Return true if multifd is ready for the migration, otherwi=
se false */
> > > >  =A0bool multifd_recv_new_channel(QIOChannel *ioc)
> > > >  =A0{
> > > > +=A0=A0=A0 MigrationIncomingState *mis =3D migration_incoming_get=
_current();
> > > >  =A0=A0=A0=A0 MultiFDRecvParams *p;
> > > >  =A0=A0=A0=A0 Error *local_err =3D NULL;
> > > >  =A0=A0=A0=A0 int id;
> > > >=20
> > > >  =A0=A0=A0=A0 id =3D multifd_recv_initial_packet(ioc, &local_err)=
;
> > > >  =A0=A0=A0=A0 if (id < 0) {
> > > > -=A0=A0=A0=A0=A0=A0=A0 multifd_recv_terminate_threads(local_err);
> > > > -=A0=A0=A0=A0=A0=A0=A0 return false;
> > > > +=A0=A0=A0=A0=A0=A0=A0 error_reportf_err(local_err,
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 "failed to receive packet via multifd channel %x:
> > > > ",
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 multifd_recv_state->count);
> > > > +=A0=A0=A0=A0=A0=A0=A0 goto fail;
> > > >  =A0=A0=A0=A0 }
> > > >=20
> > > >  =A0=A0=A0=A0 p =3D &multifd_recv_state->params[id];
> > > >  =A0=A0=A0=A0 if (p->c !=3D NULL) {
> > > >  =A0=A0=A0=A0=A0=A0=A0=A0 error_setg(&local_err, "multifd: receiv=
ed id '%d' already setup'",
> > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 id);
> > > > -=A0=A0=A0=A0=A0=A0=A0 multifd_recv_terminate_threads(local_err);
> > > > -=A0=A0=A0=A0=A0=A0=A0 return false;
> > > > +=A0=A0=A0=A0=A0=A0=A0 goto fail;
> > > >  =A0=A0=A0=A0 }
> > > >  =A0=A0=A0=A0 p->c =3D ioc;
> > > >  =A0=A0=A0=A0 object_ref(OBJECT(ioc));
> > > > @@ -1352,6 +1354,11 @@ bool multifd_recv_new_channel(QIOChannel *=
ioc)
> > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 QEMU_THREAD_JOINABLE);
> > > >  =A0=A0=A0=A0 atomic_inc(&multifd_recv_state->count);
> > > >  =A0=A0=A0=A0 return multifd_recv_state->count =3D=3D migrate_mul=
tifd_channels();
> > > > +fail:
> > > > +=A0=A0=A0 multifd_recv_terminate_threads(local_err);
> > > > +=A0=A0=A0 qemu_fclose(mis->from_src_file);
> > > > +=A0=A0=A0 mis->from_src_file =3D NULL;
> > > > +=A0=A0=A0 exit(EXIT_FAILURE);
> > > >  =A0}
> > > Yeah I think it makes sense to at least report some details when er=
ror
> > > happens, but I'm not sure whether it's good to explicitly exit() he=
re.
> > > IMHO you can add an Error** in multifd_recv_new_channel() parameter
> > > list to do that, and even through migration_ioc_process_incoming().
> > > What do you think?
> > >=20
> > > Regards,
> > >=20
> > You mean exit() in migration_ioc_process_incoming(), or further
> > caller migration_channel_process_incoming()? Actually either is
> > ok for me. :) But today I find if using postcopy and multifd together
> > to do live migration, it seems the hang still occurs even with the
> > above codes, so sad about that. I will keep debugging and see
> > how to fix this.
>=20
> Maybe you can move the error_report_err() in
> migration_channel_process_incoming() out of the TLS path so we can
> report the error if either TLS or non-TLS case got something wrong.
>=20
> And I don't even know whether multifd could work with postcopy...

Nope, it's not expected to work yet.

Dave

> Regards,
>=20
> --=20
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
