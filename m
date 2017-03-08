Received: from eggs.gnu.org ([2001:4830:134:3::10]:39353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1clXc6-0008BA-T0
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 04:10:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1clXc2-0000hO-Qs
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 04:10:30 -0500
Received: from mx3-phx2.redhat.com ([209.132.183.24]:52517)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1clXc2-0000h6-IR
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 04:10:26 -0500
Date: Wed, 8 Mar 2017 04:10:26 -0500 (EST)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <519330901.29898313.1488964226313.JavaMail.zimbra@redhat.com>
In-Reply-To: <61938aa1-2698-f55e-ea1c-e7d96da0b5d7@redhat.com>
References: <1488876478-6889-1-git-send-email-jasowang@redhat.com>
	<313e32c5-140d-ec13-6b10-98043756f2e6@redhat.com>
	<f3e9db7e-f3ab-1ae5-4da6-05dbd8d0206f@redhat.com>
	<61938aa1-2698-f55e-ea1c-e7d96da0b5d7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio: destroy region cache during reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com



----- Original Message -----
> From: "Jason Wang" <jasowang@redhat.com>
> To: "Paolo Bonzini" <pbonzini@redhat.com>, mst@redhat.com, qemu-devel@non=
gnu.org
> Cc: peterx@redhat.com
> Sent: Wednesday, March 8, 2017 7:22:06 AM
> Subject: Re: [Qemu-devel] [PATCH] virtio: destroy region cache during res=
et
>=20
>=20
>=20
> On 2017=E5=B9=B403=E6=9C=8808=E6=97=A5 11:21, Jason Wang wrote:
> >
> > On 2017=E5=B9=B403=E6=9C=8807=E6=97=A5 18:55, Paolo Bonzini wrote:
> >>
> >> On 07/03/2017 09:47, Jason Wang wrote:
> >>> We don't destroy region cache during reset which can make the maps
> >>> of previous driver leaked to a buggy or malicious driver that don't
> >>> set vring address before starting to use the device.
> >> I'm still not sure as to how this can happen.  Reset does clear
> >> desc/used/avail, which should then be checked before accessing the
> >> caches.
> >
> > But the code does not check them in fact? (E.g the attached qtest
> > patch can still pass check-qtest).
> >
> > Thanks
>=20
> Ok, the reproducer seems wrong. And I think what you mean is something
> like the check done in virtio_queue_ready(). But looks like not all
> virtqueue check for this. One example is virtio_net_handle_ctrl(), and
> there may be even more. So you want to fix them all?

Why would virtio_net_handle_ctrl be called when desc =3D=3D 0?  The checks
are all in common virtio code.

static void virtio_queue_notify_vq(VirtQueue *vq)
{
    if (vq->vring.desc && vq->handle_output) {
        VirtIODevice *vdev =3D vq->vdev;

        if (unlikely(vdev->broken)) {
            return;
        }

        trace_virtio_queue_notify(vdev, vq - vdev->vq, vq);
        vq->handle_output(vdev, vq);
    }
}
                                                                           =
                                                                           =
                         1440,29       55%
Paolo
