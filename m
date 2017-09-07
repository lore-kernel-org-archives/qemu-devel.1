Received: from eggs.gnu.org ([2001:4830:134:3::10]:59205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpve2-0005LS-5P
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 08:10:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpvdw-0000SJ-WA
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 08:10:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dpvdw-0000S7-NU
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 08:10:48 -0400
Date: Thu, 7 Sep 2017 13:10:10 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170907121009.GM2098@work-vm>
References: <20170824192730.8440-1-dgilbert@redhat.com>
	<20170824192730.8440-15-dgilbert@redhat.com>
	<CAJ+F1CKKiFrBLFy092d6RhEo=o9kTmOHeKgjZo2zUQtO_TtEdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKKiFrBLFy092d6RhEo=o9kTmOHeKgjZo2zUQtO_TtEdA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 14/32] vhost+postcopy: Transmit 'listen'
 to client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Maxime Coquelin <maxime.coquelin@redhat.com>, a.perevalov@samsung.com, "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, aarcange@redhat.com, Felipe Franciosi <felipe@nutanix.com>, Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>

* Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> On Thu, Aug 24, 2017 at 12:27 PM, Dr. David Alan Gilbert (git)
> <dgilbert@redhat.com> wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > Notify the vhost-user client on reception of the 'postcopy-listen'
> > event from the source.
> >
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  contrib/libvhost-user/libvhost-user.c | 21 +++++++++++++++++++++
> >  contrib/libvhost-user/libvhost-user.h |  2 ++
> >  docs/interop/vhost-user.txt           |  6 ++++++
> >  hw/virtio/trace-events                |  3 +++
> >  hw/virtio/vhost-user.c                | 30 +++++++++++++++++++++++++=
+++++
> >  migration/postcopy-ram.h              |  1 +
> >  migration/savevm.c                    |  7 +++++++
> >  7 files changed, 70 insertions(+)
> >
> > diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost=
-user/libvhost-user.c
> > index f9b5b12b28..e8accf11db 100644
> > --- a/contrib/libvhost-user/libvhost-user.c
> > +++ b/contrib/libvhost-user/libvhost-user.c
> > @@ -15,7 +15,9 @@
> >
> >  #include <qemu/osdep.h>
> >  #include <sys/eventfd.h>
> > +#include <sys/ioctl.h>
> >  #include <sys/syscall.h>
> > +#include <linux/userfaultfd.h>
> >  #include <linux/vhost.h>
> >
>=20
> Belong to an earlier patch

oops, thanks.

> >  #include "qemu/atomic.h"
> > @@ -64,6 +66,7 @@ vu_request_to_string(int req)
> >          REQ(VHOST_USER_IOTLB_MSG),
> >          REQ(VHOST_USER_SET_VRING_ENDIAN),
> >          REQ(VHOST_USER_POSTCOPY_ADVISE),
> > +        REQ(VHOST_USER_POSTCOPY_LISTEN),
> >          REQ(VHOST_USER_MAX),
> >      };
> >  #undef REQ
> > @@ -802,6 +805,22 @@ out:
> >  }
> >
> >  static bool
> > +vu_set_postcopy_listen(VuDev *dev, VhostUserMsg *vmsg)
> > +{
> > +    vmsg->payload.u64 =3D -1;
> > +    vmsg->size =3D sizeof(vmsg->payload.u64);
> > +
> > +    if (dev->nregions) {
> > +        vu_panic(dev, "Regions already registered at postcopy-listen=
");
> > +        return true;
> > +    }
> > +    dev->postcopy_listening =3D true;
> > +
> > +    vmsg->flags =3D VHOST_USER_VERSION |  VHOST_USER_REPLY_MASK;
> > +    vmsg->payload.u64 =3D 0; /* Success */
> > +    return true;
> > +}
> > +static bool
> >  vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
> >  {
> >      int do_reply =3D 0;
> > @@ -868,6 +887,8 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg=
)
> >          break;
> >      case VHOST_USER_POSTCOPY_ADVISE:
> >          return vu_set_postcopy_advise(dev, vmsg);
> > +    case VHOST_USER_POSTCOPY_LISTEN:
> > +        return vu_set_postcopy_listen(dev, vmsg);
> >      default:
> >          vmsg_close_fds(vmsg);
> >          vu_panic(dev, "Unhandled request: %d", vmsg->request);
> > diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost=
-user/libvhost-user.h
> > index 3e8efdd919..29c11ba56c 100644
> > --- a/contrib/libvhost-user/libvhost-user.h
> > +++ b/contrib/libvhost-user/libvhost-user.h
> > @@ -67,6 +67,7 @@ typedef enum VhostUserRequest {
> >      VHOST_USER_IOTLB_MSG        =3D 22,
> >      VHOST_USER_SET_VRING_ENDIAN =3D 23,
> >      VHOST_USER_POSTCOPY_ADVISE  =3D 24,
> > +    VHOST_USER_POSTCOPY_LISTEN  =3D 25,
> >      VHOST_USER_MAX
> >  } VhostUserRequest;
> >
> > @@ -237,6 +238,7 @@ struct VuDev {
> >
> >      /* Postcopy data */
> >      int postcopy_ufd;
> > +    bool postcopy_listening;
> >  };
> >
> >  typedef struct VuVirtqElement {
> > diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.tx=
t
> > index dad2a1b343..73c3dd74db 100644
> > --- a/docs/interop/vhost-user.txt
> > +++ b/docs/interop/vhost-user.txt
> > @@ -615,6 +615,12 @@ Master message types
> >        the slave must open a userfaultfd for later use.
> >        Note that at this stage the migration is still in precopy mode=
.
> >
> > + * VHOST_USER_POSTCOPY_LISTEN
> > +      Id: 25
> > +      Master payload: N/A
> > +
> > +      Master advises slave that a transition to postcopy mode has ha=
ppened.
> > +
> >  Slave message types
> >  -------------------
> >
> > diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> > index 775461ae98..f736c7c84f 100644
> > --- a/hw/virtio/trace-events
> > +++ b/hw/virtio/trace-events
> > @@ -1,5 +1,8 @@
> >  # See docs/devel/tracing.txt for syntax documentation.
> >
> > +# hw/virtio/vhost-user.c
> > +vhost_user_postcopy_listen(void) ""
> > +
> >  # hw/virtio/virtio.c
> >  virtqueue_alloc_element(void *elem, size_t sz, unsigned in_num, unsi=
gned out_num) "elem %p size %zd in_num %u out_num %u"
> >  virtqueue_fill(void *vq, const void *elem, unsigned int len, unsigne=
d int idx) "vq %p elem %p len %u idx %u"
> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > index b7898f8939..9178271ab2 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
> > @@ -69,6 +69,7 @@ typedef enum VhostUserRequest {
> >      VHOST_USER_IOTLB_MSG =3D 22,
> >      VHOST_USER_SET_VRING_ENDIAN =3D 23,
> >      VHOST_USER_POSTCOPY_ADVISE  =3D 24,
> > +    VHOST_USER_POSTCOPY_LISTEN  =3D 25,
> >      VHOST_USER_MAX
> >  } VhostUserRequest;
> >
> > @@ -788,6 +789,32 @@ static int vhost_user_postcopy_advise(struct vho=
st_dev *dev, Error **errp)
> >      return 0;
> >  }
> >
> > +/*
> > + * Called at the switch to postcopy on reception of the 'listen' com=
mand.
> > + */
> > +static int vhost_user_postcopy_listen(struct vhost_dev *dev, Error *=
*errp)
> > +{
> > +    int ret;
> > +    VhostUserMsg msg =3D {
> > +        .request =3D VHOST_USER_POSTCOPY_LISTEN,
> > +        .flags =3D VHOST_USER_VERSION | VHOST_USER_NEED_REPLY_MASK,
> > +    };
> > +
> > +    trace_vhost_user_postcopy_listen();
> > +    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
> > +        error_setg(errp, "Failed to send postcopy_listen to vhost");
> > +        return -1;
> > +    }
> > +
> > +    ret =3D process_message_reply(dev, &msg);
> > +    if (ret) {
> > +        error_setg(errp, "Failed to receive reply to postcopy_listen=
");
> > +        return ret;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> >  static int vhost_user_postcopy_notifier(NotifierWithReturn *notifier=
,
> >                                          void *opaque)
> >  {
> > @@ -810,6 +837,9 @@ static int vhost_user_postcopy_notifier(NotifierW=
ithReturn *notifier,
> >      case POSTCOPY_NOTIFY_INBOUND_ADVISE:
> >          return vhost_user_postcopy_advise(dev, pnd->errp);
> >
> > +    case POSTCOPY_NOTIFY_INBOUND_LISTEN:
> > +        return vhost_user_postcopy_listen(dev, pnd->errp);
> > +
> >      default:
> >          /* We ignore notifications we don't know */
> >          break;
> > diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
> > index 28c216cc7a..873c147b68 100644
> > --- a/migration/postcopy-ram.h
> > +++ b/migration/postcopy-ram.h
> > @@ -129,6 +129,7 @@ void postcopy_infrastructure_init(void);
> >  enum PostcopyNotifyReason {
> >      POSTCOPY_NOTIFY_PROBE =3D 0,
> >      POSTCOPY_NOTIFY_INBOUND_ADVISE,
> > +    POSTCOPY_NOTIFY_INBOUND_LISTEN,
> >  };
> >
> >  struct PostcopyNotifyData {
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index d35911731d..72f084e10d 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -1557,6 +1557,8 @@ static int loadvm_postcopy_handle_listen(Migrat=
ionIncomingState *mis)
> >  {
> >      PostcopyState ps =3D postcopy_state_set(POSTCOPY_INCOMING_LISTEN=
ING);
> >      trace_loadvm_postcopy_handle_listen();
> > +    Error *local_err =3D NULL;
> > +
> >      if (ps !=3D POSTCOPY_INCOMING_ADVISE && ps !=3D POSTCOPY_INCOMIN=
G_DISCARD) {
> >          error_report("CMD_POSTCOPY_LISTEN in wrong postcopy state (%=
d)", ps);
> >          return -1;
> > @@ -1578,6 +1580,11 @@ static int loadvm_postcopy_handle_listen(Migra=
tionIncomingState *mis)
> >          return -1;
> >      }
> >
> > +    if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_LISTEN, &local_err))=
 {
> > +        error_report_err(local_err);
> > +        return -1;
> > +    }
> > +
> >      if (mis->have_listen_thread) {
> >          error_report("CMD_POSTCOPY_RAM_LISTEN already has a listen t=
hread");
> >          return -1;
> > --
> > 2.13.5
> >
> >
>=20
>=20
> Looks good to me otherwise,
> Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Thanks.

Dave

>=20
> --=20
> Marc-Andr=E9 Lureau
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
