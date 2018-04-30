Received: from eggs.gnu.org ([2001:4830:134:3::10]:35344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fD4xL-0004Wf-LX
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:18:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fD4xH-0002KY-Jh
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:18:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50994 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fD4xH-0002Iw-Dg
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:18:43 -0400
Date: Mon, 30 Apr 2018 10:18:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180430091833.GF3249@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1524666934-8064-1-git-send-email-lidongchen@tencent.com>
	<1524666934-8064-5-git-send-email-lidongchen@tencent.com>
	<20180426173641.GN2631@work-vm>
	<CAOGPPbcPb4F2m_o4jPn2ELRK19=Yr=P+QRi4r_-eVhzmV0d5kA@mail.gmail.com>
	<20180427091603.GD32172@redhat.com>
	<CAOGPPbcG4-FiV1d134g5YA8z4cNrdzELED3rpR+NrJzc2OfwcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOGPPbcG4-FiV1d134g5YA8z4cNrdzELED3rpR+NrJzc2OfwcA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/5] migration: implement bi-directional
 RDMA QIOChannel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 858585 jemmy <jemmy858585@gmail.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Gal Shachaf <galsha@mellanox.com>, Aviad Yehezkel <aviadye@mellanox.com>, licq@mellanox.com, adido@mellanox.com, Lidong Chen <lidongchen@tencent.com>

On Sat, Apr 28, 2018 at 12:16:36PM +0800, 858585 jemmy wrote:
> On Fri, Apr 27, 2018 at 5:16 PM, Daniel P. Berrang=C3=A9 <berrange@redh=
at.com> wrote:
> so I prefer to add a lock for QEMUFile struct, like this:
>=20
> int qemu_fclose(QEMUFile *f)
> {
>     int ret;
>     qemu_fflush(f);
>     ret =3D qemu_file_get_error(f);
>=20
>     if (f->ops->close) {
> +        qemu_mutex_lock(&f->lock);
>         int ret2 =3D f->ops->close(f->opaque);
> +       qemu_mutex_unlock(&f->lock);
>         if (ret >=3D 0) {
>             ret =3D ret2;
>         }
>     }

That looks ok


> >> > But is there nothing else to make the QIOChannel bidirectional?
> >> >
> >> > Also, a lot seems dependent on listen_id, can you explain how that=
's
> >> > being used.
> >>
> >> The destination qemu is server side, so listen_id is not zero. the
> >> source qemu is client side,
> >> the listen_id is zero.
> >> I use listen_id to determine whether qemu is destination or source.
> >>
> >> for the destination qemu, if write data to source, it need use the
> >> return_path rdma, like this:
> >>     if (rdma->listen_id) {
> >>         rdma =3D rdma->return_path;
> >>     }
> >>
> >> for the source qemu, if read data from destination, it also need use
> >> the return_path rdma.
> >>     if (!rdma->listen_id) {
> >>         rdma =3D rdma->return_path;
> >>     }
> >
> > This feels uncessarily complex to me. Why not just change QIOCHannelR=
MDA
> > struct, so that it has 2 RDMA context pointers eg
> >
> > struct QIOChannelRDMA {
> >     QIOChannel parent;
> >     RDMAContext *rdmain;
> >     RDMAContext *rdmaout;
> >     QEMUFile *file;
> >     bool blocking; /* XXX we don't actually honour this yet */
> > };
>=20
> The reason is the parameter of some function is RDMAContext.
> like qemu_rdma_accept, rdma_start_outgoing_migration.
> It's easier to implement return path.

I don't see that as an issue - qemu_fopen_rdma() function should be able
to setup a pair of RDMAContext pointers when it creates the QIOChannelRDM=
A
struct. It just has to request the return path from the single RDMAContex=
t
it gets passed, and then set that on the QIOChannelRDMA struct.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
