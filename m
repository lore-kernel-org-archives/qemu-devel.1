Received: from eggs.gnu.org ([2001:4830:134:3::10]:58859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evNtx-0005T5-F3
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:54:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evNtu-0004By-4L
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:54:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40868 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1evNtt-0004AS-Tt
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:54:06 -0400
Date: Mon, 12 Mar 2018 13:53:57 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180312135356.GE3219@work-vm>
References: <20180308195811.24894-1-dgilbert@redhat.com>
	<20180308195811.24894-12-dgilbert@redhat.com>
	<CAJ+F1CJzYoJKZgYsjApLGtksgbcMC7FBQB9CvTOCMtY4TY8s8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CJzYoJKZgYsjApLGtksgbcMC7FBQB9CvTOCMtY4TY8s8A@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 11/29] vhost+postcopy: Transmit 'listen'
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
Cc: QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

* Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> Hi
>=20
> On Thu, Mar 8, 2018 at 8:57 PM, Dr. David Alan Gilbert (git)
> <dgilbert@redhat.com> wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > Notify the vhost-user client on reception of the 'postcopy-listen'
> > event from the source.
>=20
> minor nit, please change with "vhost-user slave", since that's the
> terminology we use for vhost-user protocol. (server/client is for the
> socket layer relation)

Done; there are probably a few more in there!

Dave

> >
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > ---
> >  contrib/libvhost-user/libvhost-user.c | 19 +++++++++++++++++++
> >  contrib/libvhost-user/libvhost-user.h |  2 ++
> >  docs/interop/vhost-user.txt           | 11 +++++++++++
> >  hw/virtio/trace-events                |  3 +++
> >  hw/virtio/vhost-user.c                | 34 +++++++++++++++++++++++++=
+++++++++
> >  migration/postcopy-ram.h              |  1 +
> >  migration/savevm.c                    |  7 +++++++
> >  7 files changed, 77 insertions(+)
> >
> > diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost=
-user/libvhost-user.c
> > index 0b563fc5ae..beec7695a8 100644
> > --- a/contrib/libvhost-user/libvhost-user.c
> > +++ b/contrib/libvhost-user/libvhost-user.c
> > @@ -98,6 +98,7 @@ vu_request_to_string(unsigned int req)
> >          REQ(VHOST_USER_GET_CONFIG),
> >          REQ(VHOST_USER_SET_CONFIG),
> >          REQ(VHOST_USER_POSTCOPY_ADVISE),
> > +        REQ(VHOST_USER_POSTCOPY_LISTEN),
> >          REQ(VHOST_USER_MAX),
> >      };
> >  #undef REQ
> > @@ -933,6 +934,22 @@ out:
> >      return true; /* =3D send a reply */
> >  }
> >
> > +static bool
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
> >  static bool
> >  vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
> >  {
> > @@ -1006,6 +1023,8 @@ vu_process_message(VuDev *dev, VhostUserMsg *vm=
sg)
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
> > index 074b7860f6..ed505cf0c1 100644
> > --- a/contrib/libvhost-user/libvhost-user.h
> > +++ b/contrib/libvhost-user/libvhost-user.h
> > @@ -86,6 +86,7 @@ typedef enum VhostUserRequest {
> >      VHOST_USER_CREATE_CRYPTO_SESSION =3D 26,
> >      VHOST_USER_CLOSE_CRYPTO_SESSION =3D 27,
> >      VHOST_USER_POSTCOPY_ADVISE  =3D 28,
> > +    VHOST_USER_POSTCOPY_LISTEN  =3D 29,
> >      VHOST_USER_MAX
> >  } VhostUserRequest;
> >
> > @@ -285,6 +286,7 @@ struct VuDev {
> >
> >      /* Postcopy data */
> >      int postcopy_ufd;
> > +    bool postcopy_listening;
> >  };
> >
> >  typedef struct VuVirtqElement {
> > diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.tx=
t
> > index acc4186c79..7cc7006ef3 100644
> > --- a/docs/interop/vhost-user.txt
> > +++ b/docs/interop/vhost-user.txt
> > @@ -709,6 +709,17 @@ Master message types
> >        the slave must open a userfaultfd for later use.
> >        Note that at this stage the migration is still in precopy mode=
.
> >
> > + * VHOST_USER_POSTCOPY_LISTEN
> > +      Id: 29
> > +      Master payload: N/A
> > +
> > +      Master advises slave that a transition to postcopy mode has ha=
ppened.
> > +      The slave must ensure that shared memory is registered with us=
erfaultfd
> > +      to cause faulting of non-present pages.
> > +
> > +      This is always sent sometime after a VHOST_USER_POSTCOPY_ADVIS=
E, and
> > +      thus only when VHOST_USER_PROTOCOL_F_PAGEFAULT is supported.
> > +
> >  Slave message types
> >  -------------------
> >
> > diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> > index 742ff0f90b..06ec03d6e7 100644
> > --- a/hw/virtio/trace-events
> > +++ b/hw/virtio/trace-events
> > @@ -6,6 +6,9 @@ vhost_region_add_section(const char *name, uint64_t g=
pa, uint64_t size, uint64_t
> >  vhost_region_add_section_abut(const char *name, uint64_t new_size) "=
%s: 0x%"PRIx64
> >  vhost_section(const char *name, int r) "%s:%d"
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
> > index 9f74111e92..ee200f703e 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
> > @@ -20,6 +20,7 @@
> >  #include "sysemu/cryptodev.h"
> >  #include "migration/migration.h"
> >  #include "migration/postcopy-ram.h"
> > +#include "trace.h"
> >
> >  #include <sys/ioctl.h>
> >  #include <sys/socket.h>
> > @@ -79,6 +80,7 @@ typedef enum VhostUserRequest {
> >      VHOST_USER_CREATE_CRYPTO_SESSION =3D 26,
> >      VHOST_USER_CLOSE_CRYPTO_SESSION =3D 27,
> >      VHOST_USER_POSTCOPY_ADVISE  =3D 28,
> > +    VHOST_USER_POSTCOPY_LISTEN  =3D 29,
> >      VHOST_USER_MAX
> >  } VhostUserRequest;
> >
> > @@ -172,6 +174,8 @@ struct vhost_user {
> >      int slave_fd;
> >      NotifierWithReturn postcopy_notifier;
> >      struct PostCopyFD  postcopy_fd;
> > +    /* True once we've entered postcopy_listen */
> > +    bool               postcopy_listen;
> >  };
> >
> >  static bool ioeventfd_enabled(void)
> > @@ -858,6 +862,33 @@ static int vhost_user_postcopy_advise(struct vho=
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
> > +    struct vhost_user *u =3D dev->opaque;
> > +    int ret;
> > +    VhostUserMsg msg =3D {
> > +        .hdr.request =3D VHOST_USER_POSTCOPY_LISTEN,
> > +        .hdr.flags =3D VHOST_USER_VERSION | VHOST_USER_NEED_REPLY_MA=
SK,
> > +    };
> > +    u->postcopy_listen =3D true;
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
> > @@ -880,6 +911,9 @@ static int vhost_user_postcopy_notifier(NotifierW=
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
> > index f21eef6702..c8ced3470b 100644
> > --- a/migration/postcopy-ram.h
> > +++ b/migration/postcopy-ram.h
> > @@ -131,6 +131,7 @@ void postcopy_infrastructure_init(void);
> >  enum PostcopyNotifyReason {
> >      POSTCOPY_NOTIFY_PROBE =3D 0,
> >      POSTCOPY_NOTIFY_INBOUND_ADVISE,
> > +    POSTCOPY_NOTIFY_INBOUND_LISTEN,
> >  };
> >
> >  struct PostcopyNotifyData {
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index 1f2bf12a28..305c3ceaf5 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -1618,6 +1618,8 @@ static int loadvm_postcopy_handle_listen(Migrat=
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
> > @@ -1643,6 +1645,11 @@ static int loadvm_postcopy_handle_listen(Migra=
tionIncomingState *mis)
> >          }
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
> > 2.14.3
> >
> >
>=20
>=20
>=20
> --=20
> Marc-Andr=E9 Lureau
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
