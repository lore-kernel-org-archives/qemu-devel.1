Received: from eggs.gnu.org ([2001:4830:134:3::10]:42763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eqhD6-0000Gt-8t
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:30:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eqhD3-0005aF-Me
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:30:32 -0500
Date: Tue, 27 Feb 2018 15:30:25 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180227153025.GA32480@stefanha-x1.localdomain>
References: <20180220131014.8998-1-stefanha@redhat.com>
	<20180223082044.GB31530@lemon.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <20180223082044.GB31530@lemon.usersys.redhat.com>
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2018 at 04:20:44PM +0800, Fam Zheng wrote:
> On Tue, 02/20 13:10, Stefan Hajnoczi wrote:
> > 1. virtio_scsi_handle_cmd_vq() racing with iothread_stop_all() hits the
> >    virtio_scsi_ctx_check() assertion failure because the BDS AioContext
> >    has been modified by iothread_stop_all().
>=20
> Does this patch fix the issue completely? IIUC virtio_scsi_handle_cmd can
> already be entered at the time of main thread calling virtio_scsi_clear_a=
io(),
> so this race condition still exists:
>=20
>   main thread                           iothread
> -------------------------------------------------------------------------=
----
>   vm_shutdown
>     ...
>       virtio_bus_stop_ioeventfd
>         virtio_scsi_dataplane_stop
>                                         aio_poll()
>                                           ...
>                                             virtio_scsi_data_plane_handle=
_cmd()
>           aio_context_acquire(s->ctx)
>                                               virtio_scsi_acquire(s).enter
>           virtio_scsi_clear_aio()
>           aio_context_release(s->ctx)
>                                               virtio_scsi_acquire(s).retu=
rn
>                                               virtio_scsi_handle_cmd_vq()
>                                                 ...
>                                                   virtqueue_pop()
>=20
> Is it possible that the above virtqueue_pop() still returns one element t=
hat was
> queued before vm_shutdown() was called?

No, it can't because virtio_scsi_clear_aio() invokes
virtio_queue_host_notifier_aio_read(&vq->host_notifier) to process the
virtqueue.  By the time we get back to iothread's
virtio_scsi_data_plane_handle_cmd() the virtqueue is already empty.

Vcpus have been paused so no additional elements can slip into the
virtqueue.

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJalXmRAAoJEJykq7OBq3PIFi0IAJtQXKgDr2Noe66q7Ae6HNnM
XG7vRZHT/yejuzwBkNbUwfHZwnzIQqAIc9LqdenDW9G48XZnMmRw39K62QFoOuF1
CZ6oqTgYpLSPiTn5BULequbQewFSx9uiGupm+4pDxsFc2Kdscyeui8XEtQRSGFtN
DmtHe6FouYaPF/UmAY6j5ry9UoKG7uecLTaJW2PCbtvLeKFZ7KCeoF+6vco20q6S
w1EX7tROp6PH7cUBE74CtW0cnUB48RheCKFo9sNJ1x4JHOsj6O7VLU4WJhd1CRpY
Gqg2452rANIY8lRg+v2Of37ry23QdlD+oviuwcoymLOgeklvQqtCLIim6ZDt8Es=
=RJ0N
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
