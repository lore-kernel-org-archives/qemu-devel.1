Received: from eggs.gnu.org ([2001:4830:134:3::10]:60934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evO2e-0003gK-4j
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 10:03:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evO2X-0005GH-SJ
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 10:03:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50590 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1evO2X-0005Ei-Lv
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 10:03:01 -0400
Date: Mon, 12 Mar 2018 14:02:51 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180312140250.GG3219@work-vm>
References: <20180308195811.24894-1-dgilbert@redhat.com>
	<20180308195811.24894-7-dgilbert@redhat.com>
	<CAJ+F1CKxdjmUX5-97kczL-xApYiXKgzeDa1-3J=fRKGT9yC0qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKxdjmUX5-97kczL-xApYiXKgzeDa1-3J=fRKGT9yC0qg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 06/29] vhost-user: Add
 'VHOST_USER_POSTCOPY_ADVISE' message
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
> > Wire up a notifier to send a VHOST_USER_POSTCOPY_ADVISE
> > message on an incoming advise.
> >
> > Later patches will fill in the behaviour/contents of the
> > message.
> >
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  contrib/libvhost-user/libvhost-user.c | 14 ++++++++++
> >  contrib/libvhost-user/libvhost-user.h |  3 +++
> >  docs/interop/vhost-user.txt           | 10 ++++++++
> >  hw/virtio/vhost-user.c                | 48 +++++++++++++++++++++++++=
++++++++++
> >  migration/postcopy-ram.h              |  1 +
> >  migration/savevm.c                    |  6 +++++
> >  6 files changed, 82 insertions(+)
> >
> > diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost=
-user/libvhost-user.c
> > index 2e358b5bce..71825d2dde 100644
> > --- a/contrib/libvhost-user/libvhost-user.c
> > +++ b/contrib/libvhost-user/libvhost-user.c
> > @@ -86,6 +86,7 @@ vu_request_to_string(unsigned int req)
> >          REQ(VHOST_USER_SET_VRING_ENDIAN),
> >          REQ(VHOST_USER_GET_CONFIG),
> >          REQ(VHOST_USER_SET_CONFIG),
> > +        REQ(VHOST_USER_POSTCOPY_ADVISE),
> >          REQ(VHOST_USER_MAX),
> >      };
> >  #undef REQ
> > @@ -856,6 +857,17 @@ vu_set_config(VuDev *dev, VhostUserMsg *vmsg)
> >      return false;
> >  }
> >
> > +static bool
> > +vu_set_postcopy_advise(VuDev *dev, VhostUserMsg *vmsg)
> > +{
> > +    /* TODO: Open ufd, pass it back in the request
> > +     * TODO: Add addresses
> > +     */
> > +    vmsg->payload.u64 =3D 0xcafe;
> > +    vmsg->size =3D sizeof(vmsg->payload.u64);
>=20
> Left over? Why send back a u64 with 0xcafe value?

I think because I didn't realise it could be an empty reply;  OK, v5
coming up with that removed once we're done with this set.

> > +    return true; /* =3D send a reply */
> > +}
> > +
> >  static bool
> >  vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
> >  {
> > @@ -927,6 +939,8 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg=
)
> >          return vu_set_config(dev, vmsg);
> >      case VHOST_USER_NONE:
> >          break;
> > +    case VHOST_USER_POSTCOPY_ADVISE:
> > +        return vu_set_postcopy_advise(dev, vmsg);
> >      default:
> >          vmsg_close_fds(vmsg);
> >          vu_panic(dev, "Unhandled request: %d", vmsg->request);
> > diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost=
-user/libvhost-user.h
> > index 96db29c4ce..00d78a8810 100644
> > --- a/contrib/libvhost-user/libvhost-user.h
> > +++ b/contrib/libvhost-user/libvhost-user.h
> > @@ -83,6 +83,9 @@ typedef enum VhostUserRequest {
> >      VHOST_USER_SET_VRING_ENDIAN =3D 23,
> >      VHOST_USER_GET_CONFIG =3D 24,
> >      VHOST_USER_SET_CONFIG =3D 25,
> > +    VHOST_USER_CREATE_CRYPTO_SESSION =3D 26,
> > +    VHOST_USER_CLOSE_CRYPTO_SESSION =3D 27,
> > +    VHOST_USER_POSTCOPY_ADVISE  =3D 28,
> >      VHOST_USER_MAX
> >  } VhostUserRequest;
> >
> > diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.tx=
t
> > index 91a572d781..acc4186c79 100644
> > --- a/docs/interop/vhost-user.txt
> > +++ b/docs/interop/vhost-user.txt
> > @@ -699,6 +699,16 @@ Master message types
> >       feature has been successfully negotiated.
> >       It's a required feature for crypto devices.
> >
> > + * VHOST_USER_POSTCOPY_ADVISE
> > +      Id: 28
> > +      Master payload: N/A
> > +      Slave payload: userfault fd + u64
>=20
> If the reply is modified, update doc as well
>=20
> > +
> > +      When VHOST_USER_PROTOCOL_F_PAGEFAULT is supported, the
> > +      master advises slave that a migration with postcopy enabled is=
 underway,
> > +      the slave must open a userfaultfd for later use.
> > +      Note that at this stage the migration is still in precopy mode=
.
> > +
> >  Slave message types
> >  -------------------
> >
> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > index aab35c4845..431858b219 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
> > @@ -78,6 +78,7 @@ typedef enum VhostUserRequest {
> >      VHOST_USER_SET_CONFIG =3D 25,
> >      VHOST_USER_CREATE_CRYPTO_SESSION =3D 26,
> >      VHOST_USER_CLOSE_CRYPTO_SESSION =3D 27,
> > +    VHOST_USER_POSTCOPY_ADVISE  =3D 28,
> >      VHOST_USER_MAX
> >  } VhostUserRequest;
> >
> > @@ -795,6 +796,50 @@ out:
> >      return ret;
> >  }
> >
> > +/*
> > + * Called at the start of an inbound postcopy on reception of the
> > + * 'advise' command.
> > + */
> > +static int vhost_user_postcopy_advise(struct vhost_dev *dev, Error *=
*errp)
> > +{
> > +    struct vhost_user *u =3D dev->opaque;
> > +    CharBackend *chr =3D u->chr;
> > +    int ufd;
> > +    VhostUserMsg msg =3D {
> > +        .hdr.request =3D VHOST_USER_POSTCOPY_ADVISE,
> > +        .hdr.flags =3D VHOST_USER_VERSION,
> > +    };
> > +
> > +    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
> > +        error_setg(errp, "Failed to send postcopy_advise to vhost");
> > +        return -1;
> > +    }
> > +
> > +    if (vhost_user_read(dev, &msg) < 0) {
> > +        error_setg(errp, "Failed to get postcopy_advise reply from v=
host");
> > +        return -1;
> > +    }
> > +
> > +    if (msg.hdr.request !=3D VHOST_USER_POSTCOPY_ADVISE) {
> > +        error_setg(errp, "Unexpected msg type. Expected %d received =
%d",
> > +                     VHOST_USER_POSTCOPY_ADVISE, msg.hdr.request);
> > +        return -1;
> > +    }
> > +
> > +    if (msg.hdr.size !=3D sizeof(msg.payload.u64)) {
> > +        error_setg(errp, "Received bad msg size.");
> > +        return -1;
> > +    }
> > +    ufd =3D qemu_chr_fe_get_msgfd(chr);
> > +    if (ufd < 0) {
> > +        error_setg(errp, "%s: Failed to get ufd", __func__);
> > +        return -1;
> > +    }
> > +
> > +    /* TODO: register ufd with userfault thread */
> > +    return 0;
> > +}
> > +
> >  static int vhost_user_postcopy_notifier(NotifierWithReturn *notifier=
,
> >                                          void *opaque)
> >  {
> > @@ -814,6 +859,9 @@ static int vhost_user_postcopy_notifier(NotifierW=
ithReturn *notifier,
> >          }
> >          break;
> >
> > +    case POSTCOPY_NOTIFY_INBOUND_ADVISE:
> > +        return vhost_user_postcopy_advise(dev, pnd->errp);
> > +
> >      default:
> >          /* We ignore notifications we don't know */
> >          break;
> > diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
> > index 2e879bbacb..0421c98d57 100644
> > --- a/migration/postcopy-ram.h
> > +++ b/migration/postcopy-ram.h
> > @@ -130,6 +130,7 @@ void postcopy_infrastructure_init(void);
> >   */
> >  enum PostcopyNotifyReason {
> >      POSTCOPY_NOTIFY_PROBE =3D 0,
> > +    POSTCOPY_NOTIFY_INBOUND_ADVISE,
> >  };
> >
> >  struct PostcopyNotifyData {
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index 358c5b51e2..1f2bf12a28 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -1386,6 +1386,7 @@ static int loadvm_postcopy_handle_advise(Migrat=
ionIncomingState *mis,
> >  {
> >      PostcopyState ps =3D postcopy_state_set(POSTCOPY_INCOMING_ADVISE=
);
> >      uint64_t remote_pagesize_summary, local_pagesize_summary, remote=
_tps;
> > +    Error *local_err =3D NULL;
> >
> >      trace_loadvm_postcopy_handle_advise();
> >      if (ps !=3D POSTCOPY_INCOMING_NONE) {
> > @@ -1451,6 +1452,11 @@ static int loadvm_postcopy_handle_advise(Migra=
tionIncomingState *mis,
> >          return -1;
> >      }
> >
> > +    if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_ADVISE, &local_err))=
 {
> > +        error_report_err(local_err);
> > +        return -1;
> > +    }
> > +
> >      if (ram_postcopy_incoming_init(mis)) {
> >          return -1;
> >      }
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
