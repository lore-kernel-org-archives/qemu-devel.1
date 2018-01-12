Received: from eggs.gnu.org ([2001:4830:134:3::10]:36229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ghammer@redhat.com>) id 1eZv0l-0001b7-BR
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 03:48:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ghammer@redhat.com>) id 1eZv0i-0002HH-5Y
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 03:48:27 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ghammer@redhat.com>) id 1eZv0h-0002Fk-MY
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 03:48:24 -0500
Received: by mail-lf0-f67.google.com with SMTP id d19so5106093lfj.5
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 00:48:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180111215210-mutt-send-email-mst@kernel.org>
References: <1515665816-10313-1-git-send-email-ghammer@redhat.com>
	<20180111215210-mutt-send-email-mst@kernel.org>
From: Gal Hammer <ghammer@redhat.com>
Date: Fri, 12 Jan 2018 10:48:21 +0200
Message-ID: <CAA2ifQycadzATfW4w0icnskOgLTB1MUT2cMxVOt4=ZMWwgL=TQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio: improve virtio devices
 initialization time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org

On Thu, Jan 11, 2018 at 9:52 PM, Michael S. Tsirkin <mst@redhat.com> wrote:

> On Thu, Jan 11, 2018 at 12:16:56PM +0200, Gal Hammer wrote:
> > The loading time of a VM is quite significant when its virtio
> > devices uses a large amount of virt-queues (e.g. a virtio-serial
> > device with
> =E2=80=8B=E2=80=8B
> max_ports=3D511). Most of the time is spend in the
> > creation of all the required event notifiers (ioeventfd and memory
> > regions).
> >
> > This patch pack all the changes to the memory regions in a
> > single memory transaction.
> >
> > Reported-by: Sitong Liu <siliu@redhat.com>
> > Reported-by: Xiaoling Gao <xiagao@redhat.com>
> > Signed-off-by: Gal Hammer <ghammer@redhat.com>
>
> Nice patch! Any timing numbers to share before/after?
>

=E2=80=8BThanks. Unfortunately =E2=80=8BI made a mistake in the shutdown co=
de (the
transaction is wrapping the code which doesn't modify the memory regions),
so a V2 is on its way.

=E2=80=8BAs for the timing. Running a VM with 25 virtio-serial devices,=E2=
=80=8B each one
with =E2=80=8Bmax_ports=3D511, results in a boot time of around 30 minutes.=
 With this
patch (and a another patch to kvm) reduce it to approximately 3 minutes.

This was reported and tracked here:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1528588

    Gal.


>
> > ---
> >  hw/virtio/virtio.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index ad564b0..8d8d93d 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -2574,6 +2574,7 @@ static int virtio_device_start_ioeventfd_impl(Vir=
tIODevice
> *vdev)
> >      VirtioBusState *qbus =3D VIRTIO_BUS(qdev_get_parent_
> bus(DEVICE(vdev)));
> >      int n, r, err;
> >
> > +    memory_region_transaction_begin();
> >      for (n =3D 0; n < VIRTIO_QUEUE_MAX; n++) {
> >          VirtQueue *vq =3D &vdev->vq[n];
> >          if (!virtio_queue_get_num(vdev, n)) {
> > @@ -2596,6 +2597,7 @@ static int virtio_device_start_ioeventfd_impl(Vir=
tIODevice
> *vdev)
> >          }
> >          event_notifier_set(&vq->host_notifier);
> >      }
> > +    memory_region_transaction_commit();
> >      return 0;
> >
> >  assign_error:
> > @@ -2609,6 +2611,7 @@ assign_error:
> >          r =3D virtio_bus_set_host_notifier(qbus, n, false);
> >          assert(r >=3D 0);
> >      }
> > +    memory_region_transaction_commit();
> >      return err;
> >  }
> >
> > @@ -2625,6 +2628,7 @@ static void virtio_device_stop_ioeventfd_impl(Vir=
tIODevice
> *vdev)
> >      VirtioBusState *qbus =3D VIRTIO_BUS(qdev_get_parent_
> bus(DEVICE(vdev)));
> >      int n, r;
> >
> > +    memory_region_transaction_begin();
> >      for (n =3D 0; n < VIRTIO_QUEUE_MAX; n++) {
> >          VirtQueue *vq =3D &vdev->vq[n];
> >
> > @@ -2632,6 +2636,13 @@ static void virtio_device_stop_ioeventfd_impl(Vi=
rtIODevice
> *vdev)
> >              continue;
> >          }
> >          event_notifier_set_handler(&vq->host_notifier, NULL);
> > +    }
> > +    memory_region_transaction_commit();
> > +
> > +    for (n =3D 0; n < VIRTIO_QUEUE_MAX; n++) {
> > +        if (!virtio_queue_get_num(vdev, n)) {
> > +            continue;
> > +        }
> >          r =3D virtio_bus_set_host_notifier(qbus, n, false);
> >          assert(r >=3D 0);
> >      }
> > --
> > 2.7.5
>
