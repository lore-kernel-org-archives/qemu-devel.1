Received: from eggs.gnu.org ([2001:4830:134:3::10]:51477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eqyER-0002tP-H4
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 04:41:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eqyEQ-0002E8-Ew
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 04:41:03 -0500
Date: Wed, 28 Feb 2018 09:40:37 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180228094037.GA13990@stefanha-x1.localdomain>
References: <20180220131014.8998-1-stefanha@redhat.com>
	<20180223082044.GB31530@lemon.usersys.redhat.com>
	<20180227153025.GA32480@stefanha-x1.localdomain>
	<20180228015813.GC21336@lemon.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <20180228015813.GC21336@lemon.usersys.redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] vl: introduce vm_shutdown()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Kevin Wolf <kwolf@redhat.com>, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2018 at 09:58:13AM +0800, Fam Zheng wrote:
> On Tue, 02/27 15:30, Stefan Hajnoczi wrote:
> > On Fri, Feb 23, 2018 at 04:20:44PM +0800, Fam Zheng wrote:
> > > On Tue, 02/20 13:10, Stefan Hajnoczi wrote:
> > > > 1. virtio_scsi_handle_cmd_vq() racing with iothread_stop_all() hits=
 the
> > > >    virtio_scsi_ctx_check() assertion failure because the BDS AioCon=
text
> > > >    has been modified by iothread_stop_all().
> > >=20
> > > Does this patch fix the issue completely? IIUC virtio_scsi_handle_cmd=
 can
> > > already be entered at the time of main thread calling virtio_scsi_cle=
ar_aio(),
> > > so this race condition still exists:
> > >=20
> > >   main thread                           iothread
> > > ---------------------------------------------------------------------=
--------
> > >   vm_shutdown
> > >     ...
> > >       virtio_bus_stop_ioeventfd
> > >         virtio_scsi_dataplane_stop
> > >                                         aio_poll()
> > >                                           ...
> > >                                             virtio_scsi_data_plane_ha=
ndle_cmd()
> > >           aio_context_acquire(s->ctx)
> > >                                               virtio_scsi_acquire(s).=
enter
> > >           virtio_scsi_clear_aio()
> > >           aio_context_release(s->ctx)
> > >                                               virtio_scsi_acquire(s).=
return
> > >                                               virtio_scsi_handle_cmd_=
vq()
> > >                                                 ...
> > >                                                   virtqueue_pop()
> > >=20
> > > Is it possible that the above virtqueue_pop() still returns one eleme=
nt that was
> > > queued before vm_shutdown() was called?
> >=20
> > No, it can't because virtio_scsi_clear_aio() invokes
> > virtio_queue_host_notifier_aio_read(&vq->host_notifier) to process the
> > virtqueue.  By the time we get back to iothread's
> > virtio_scsi_data_plane_handle_cmd() the virtqueue is already empty.
> >=20
> > Vcpus have been paused so no additional elements can slip into the
> > virtqueue.
>=20
> So there is:
>=20
> static void virtio_queue_host_notifier_aio_read(EventNotifier *n)
> {
>     VirtQueue *vq =3D container_of(n, VirtQueue, host_notifier);
>     if (event_notifier_test_and_clear(n)) {
>         virtio_queue_notify_aio_vq(vq);
>     }
> }
>=20
> Guest kicks after adding an element to VQ, but we check ioeventfd before =
trying
> virtqueue_pop(). Is that a problem? If VCPUs are paused after enqueuing b=
ut
> before kicking VQ, the ioeventfd is not set, the virtqueue is not process=
ed
> here.

You are right.

This race condition also affects the existing 'stop' command, where
ioeventfd is disabled in the same way.  I'll send a v2 with a patch to
fix this.

Stefan

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJalnkVAAoJEJykq7OBq3PIMFEH/2WKrDA5hAzaisCet46NpBSq
XTMmMOBIi7VUgE3sAcbCKKxYEIeUgkAU6zbm0EiXeP0jP/MZvtgc8W/ABXWPiLEh
gWP6xNGdhzk6mj36fLRRNCNbvZf7y6IY6GwSVHdU9IvZ+UNrzf7oLHb80LZWiRDz
06gbWHzbDklDpems8eID3RzYXBiCVtxxgIPcvoxtIL5+SFjq24o0KUGLsB9CLh9S
FnOMI7ri4XpUHwEFFr560vU2ToeGkZjnZVH4oBcf6L/+jUmtbGDb4IC9zH5xNYCE
oc/z/w9A35lRp3umSNKLRlgryk182GVejfJb0wIZikEMPDFdhGsurSs80dU76Ck=
=VsKp
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
