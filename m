Received: from eggs.gnu.org ([2001:4830:134:3::10]:51363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gFfTk-0002v4-NC
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 09:15:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gFfDM-0004fR-7Z
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 08:58:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gFfDL-0004eE-IN
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 08:58:16 -0400
Date: Thu, 25 Oct 2018 13:58:06 +0100
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181025113229.GC30830@xz-x1.hotspot.internet-for-guests.com>
References: <20181022110854.10284-1-fli@suse.com>
	<20181024212742.GB30830@xz-x1.hotspot.internet-for-guests.com>
	<45194647-7b30-df97-5517-1c758947a91e@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <45194647-7b30-df97-5517-1c758947a91e@suse.com>
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
To: Fei Li <fli@suse.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, dgilbert@redhat.com

On Thu, Oct 25, 2018 at 05:04:00PM +0800, Fei Li wrote:

[...]

> @@ -1325,22 +1325,24 @@ bool multifd_recv_all_channels_created(void)
> =C2=A0/* Return true if multifd is ready for the migration, otherwise f=
alse */
> =C2=A0bool multifd_recv_new_channel(QIOChannel *ioc)
> =C2=A0{
> +=C2=A0=C2=A0=C2=A0 MigrationIncomingState *mis =3D migration_incoming_=
get_current();
> =C2=A0=C2=A0=C2=A0=C2=A0 MultiFDRecvParams *p;
> =C2=A0=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;
> =C2=A0=C2=A0=C2=A0=C2=A0 int id;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 id =3D multifd_recv_initial_packet(ioc, &local=
_err);
> =C2=A0=C2=A0=C2=A0=C2=A0 if (id < 0) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 multifd_recv_terminate_thre=
ads(local_err);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_reportf_err(local_err=
,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 "failed to receive packet via multifd channel %x:
> ",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 multifd_recv_state->count);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 p =3D &multifd_recv_state->params[id];
> =C2=A0=C2=A0=C2=A0=C2=A0 if (p->c !=3D NULL) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(&local_err,=
 "multifd: received id '%d' already setup'",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 multifd_recv_terminate_thre=
ads(local_err);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0 p->c =3D ioc;
> =C2=A0=C2=A0=C2=A0=C2=A0 object_ref(OBJECT(ioc));
> @@ -1352,6 +1354,11 @@ bool multifd_recv_new_channel(QIOChannel *ioc)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QEMU_T=
HREAD_JOINABLE);
> =C2=A0=C2=A0=C2=A0=C2=A0 atomic_inc(&multifd_recv_state->count);
> =C2=A0=C2=A0=C2=A0=C2=A0 return multifd_recv_state->count =3D=3D migrat=
e_multifd_channels();
> +fail:
> +=C2=A0=C2=A0=C2=A0 multifd_recv_terminate_threads(local_err);
> +=C2=A0=C2=A0=C2=A0 qemu_fclose(mis->from_src_file);
> +=C2=A0=C2=A0=C2=A0 mis->from_src_file =3D NULL;
> +=C2=A0=C2=A0=C2=A0 exit(EXIT_FAILURE);
> =C2=A0}

Yeah I think it makes sense to at least report some details when error
happens, but I'm not sure whether it's good to explicitly exit() here.
IMHO you can add an Error** in multifd_recv_new_channel() parameter
list to do that, and even through migration_ioc_process_incoming().
What do you think?

Regards,

--=20
Peter Xu
