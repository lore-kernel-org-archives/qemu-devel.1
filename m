Received: from eggs.gnu.org ([2001:4830:134:3::10]:45056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpv1m-0002Ci-IW
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 07:31:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpv1l-0007st-7p
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 07:31:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dpv1k-0007sT-Um
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 07:31:21 -0400
Date: Thu, 7 Sep 2017 12:31:11 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170907113110.GJ2098@work-vm>
References: <20170824192730.8440-1-dgilbert@redhat.com>
	<20170824192730.8440-11-dgilbert@redhat.com>
	<CAJ+F1C+yWrNQPMEOft=S6WexkVve__rp_GLhkM0xR5kLyzSF6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1C+yWrNQPMEOft=S6WexkVve__rp_GLhkM0xR5kLyzSF6w@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 10/32] vhub: Support sending fds back to
 qemu
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
> Hi
>=20
> On Thu, Aug 24, 2017 at 12:27 PM, Dr. David Alan Gilbert (git)
> <dgilbert@redhat.com> wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > Allow replies with fds (for postcopy)
> >
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  contrib/libvhost-user/libvhost-user.c | 29 +++++++++++++++++++++++++=
+++-
> >  1 file changed, 28 insertions(+), 1 deletion(-)
> >
> > diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost=
-user/libvhost-user.c
> > index 8bbdf5fb40..47884c0a15 100644
> > --- a/contrib/libvhost-user/libvhost-user.c
> > +++ b/contrib/libvhost-user/libvhost-user.c
> > @@ -213,6 +213,30 @@ vu_message_write(VuDev *dev, int conn_fd, VhostU=
serMsg *vmsg)
> >  {
> >      int rc;
> >      uint8_t *p =3D (uint8_t *)vmsg;
> > +    char control[CMSG_SPACE(VHOST_MEMORY_MAX_NREGIONS * sizeof(int))=
] =3D { };
> > +    struct iovec iov =3D {
> > +        .iov_base =3D (char *)vmsg,
> > +        .iov_len =3D VHOST_USER_HDR_SIZE,
> > +    };
> > +    struct msghdr msg =3D {
> > +        .msg_iov =3D &iov,
> > +        .msg_iovlen =3D 1,
> > +        .msg_control =3D control,
> > +    };
> > +    struct cmsghdr *cmsg;
> > +
> > +    memset(control, 0, sizeof(control));
> > +    if (vmsg->fds) {
>=20
> This is going to be always true, right? Check vmsg->fd_num > 0 instead?

Ah yes, thanks.

> I would also add check or assert(vmsg->fd_num <=3D VHOST_MEMORY_MAX_NRE=
GIONS)

-    if (vmsg->fds) {
+    assert(vmsg->fd_num <=3D VHOST_MEMORY_MAX_NREGIONS);
+    if (vmsg->fd_num > 0) {

>=20
> > +        size_t fdsize =3D vmsg->fd_num * sizeof(int);
> > +        msg.msg_controllen =3D CMSG_SPACE(fdsize);
> > +        cmsg =3D CMSG_FIRSTHDR(&msg);
> > +        cmsg->cmsg_len =3D CMSG_LEN(fdsize);
> > +        cmsg->cmsg_level =3D SOL_SOCKET;
> > +        cmsg->cmsg_type =3D SCM_RIGHTS;
> > +        memcpy(CMSG_DATA(cmsg), vmsg->fds, fdsize);
> > +    } else {
> > +        msg.msg_controllen =3D 0;
> > +    }
> >
> >      /* Set the version in the flags when sending the reply */
> >      vmsg->flags &=3D ~VHOST_USER_VERSION_MASK;
> > @@ -220,7 +244,7 @@ vu_message_write(VuDev *dev, int conn_fd, VhostUs=
erMsg *vmsg)
> >      vmsg->flags |=3D VHOST_USER_REPLY_MASK;
> >
> >      do {
> > -        rc =3D write(conn_fd, p, VHOST_USER_HDR_SIZE);
> > +        rc =3D sendmsg(conn_fd, &msg, 0);
> >      } while (rc < 0 && (errno =3D=3D EINTR || errno =3D=3D EAGAIN));
> >
> >      do {
> > @@ -313,6 +337,7 @@ vu_get_features_exec(VuDev *dev, VhostUserMsg *vm=
sg)
> >      }
> >
> >      vmsg->size =3D sizeof(vmsg->payload.u64);
> > +    vmsg->fd_num =3D 0;
> >
> >      DPRINT("Sending back to guest u64: 0x%016"PRIx64"\n", vmsg->payl=
oad.u64);
> >
> > @@ -454,6 +479,7 @@ vu_set_log_base_exec(VuDev *dev, VhostUserMsg *vm=
sg)
> >      dev->log_size =3D log_mmap_size;
> >
> >      vmsg->size =3D sizeof(vmsg->payload.u64);
> > +    vmsg->fd_num =3D 0;
> >
> >      return true;
> >  }
> > @@ -698,6 +724,7 @@ vu_get_protocol_features_exec(VuDev *dev, VhostUs=
erMsg *vmsg)
> >
> >      vmsg->payload.u64 =3D features;
> >      vmsg->size =3D sizeof(vmsg->payload.u64);
> > +    vmsg->fd_num =3D 0;
> >
> >      return true;
> >  }
> > --
> > 2.13.5
> >
> >
>=20
> other than that
> Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Thanks.

Dave

>=20
>=20
> --=20
> Marc-Andr=E9 Lureau
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
