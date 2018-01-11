Received: from eggs.gnu.org ([2001:4830:134:3::10]:42436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1eZQiO-0002bL-3h
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 19:27:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1eZQiK-0006Ag-Ue
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 19:27:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:50788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1eZQiK-00069L-Lg
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 19:27:24 -0500
Date: Wed, 10 Jan 2018 16:27:23 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <20180108102442.2ed55a71@bahia.lan>
Message-ID: <alpine.DEB.2.10.1801101627160.4603@sstabellini-ThinkPad-X260>
References: <151379897394.31252.4783267371691256574.stgit@bahia>
	<20180108102442.2ed55a71@bahia.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] 9pfs: drop v9fs_register_transport()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>

On Mon, 8 Jan 2018, Greg Kurz wrote:
> Stefano, can you ack/nack this one ?
> 
> On Wed, 20 Dec 2017 20:42:54 +0100
> Greg Kurz <groug@kaod.org> wrote:
> 
> > No good reasons to do this outside of v9fs_device_realize_common().
> > 
> > Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> > ---
> >  hw/9pfs/9p.c               |    6 +++++-
> >  hw/9pfs/9p.h               |   10 ++--------
> >  hw/9pfs/virtio-9p-device.c |    8 ++------
> >  hw/9pfs/xen-9p-backend.c   |    3 +--
> >  4 files changed, 10 insertions(+), 17 deletions(-)
> > 
> > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > index ccbc75265a52..2f836a59deac 100644
> > --- a/hw/9pfs/9p.c
> > +++ b/hw/9pfs/9p.c
> > @@ -3502,7 +3502,8 @@ void pdu_submit(V9fsPDU *pdu, P9MsgHeader *hdr)
> >  }
> >  
> >  /* Returns 0 on success, 1 on failure. */
> > -int v9fs_device_realize_common(V9fsState *s, Error **errp)
> > +int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
> > +                               Error **errp)
> >  {
> >      int i, len;
> >      struct stat stat;
> > @@ -3510,6 +3511,9 @@ int v9fs_device_realize_common(V9fsState *s, Error **errp)
> >      V9fsPath path;
> >      int rc = 1;
> >  
> > +    assert(!s->transport);
> > +    s->transport = t;
> > +
> >      /* initialize pdu allocator */
> >      QLIST_INIT(&s->free_list);
> >      QLIST_INIT(&s->active_list);
> > diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
> > index ea7657837784..e2aa64577fe1 100644
> > --- a/hw/9pfs/9p.h
> > +++ b/hw/9pfs/9p.h
> > @@ -346,7 +346,8 @@ void v9fs_path_sprintf(V9fsPath *path, const char *fmt, ...);
> >  void v9fs_path_copy(V9fsPath *lhs, V9fsPath *rhs);
> >  int v9fs_name_to_path(V9fsState *s, V9fsPath *dirpath,
> >                        const char *name, V9fsPath *path);
> > -int v9fs_device_realize_common(V9fsState *s, Error **errp);
> > +int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
> > +                               Error **errp);
> >  void v9fs_device_unrealize_common(V9fsState *s, Error **errp);
> >  
> >  V9fsPDU *pdu_alloc(V9fsState *s);
> > @@ -366,11 +367,4 @@ struct V9fsTransport {
> >      void        (*pdu_complete)(V9fsPDU *pdu, bool discard);
> >  };
> >  
> > -static inline int v9fs_register_transport(V9fsState *s, const V9fsTransport *t)
> > -{
> > -    assert(!s->transport);
> > -    s->transport = t;
> > -    return 0;
> > -}
> > -
> >  #endif
> > diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
> > index d874f48467ba..806e7573276c 100644
> > --- a/hw/9pfs/virtio-9p-device.c
> > +++ b/hw/9pfs/virtio-9p-device.c
> > @@ -201,17 +201,13 @@ static void virtio_9p_device_realize(DeviceState *dev, Error **errp)
> >      V9fsVirtioState *v = VIRTIO_9P(dev);
> >      V9fsState *s = &v->state;
> >  
> > -    if (v9fs_device_realize_common(s, errp)) {
> > -        goto out;
> > +    if (v9fs_device_realize_common(s, &virtio_9p_transport, errp)) {
> > +        return;
> >      }
> >  
> >      v->config_size = sizeof(struct virtio_9p_config) + strlen(s->fsconf.tag);
> >      virtio_init(vdev, "virtio-9p", VIRTIO_ID_9P, v->config_size);
> >      v->vq = virtio_add_queue(vdev, MAX_REQ, handle_9p_output);
> > -    v9fs_register_transport(s, &virtio_9p_transport);
> > -
> > -out:
> > -    return;
> >  }
> >  
> >  static void virtio_9p_device_unrealize(DeviceState *dev, Error **errp)
> > diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
> > index dc1e6c88885d..e2ae1ac148eb 100644
> > --- a/hw/9pfs/xen-9p-backend.c
> > +++ b/hw/9pfs/xen-9p-backend.c
> > @@ -448,7 +448,6 @@ static int xen_9pfs_connect(struct XenDevice *xendev)
> >      xen_9pdev->id = s->fsconf.fsdev_id =
> >          g_strdup_printf("xen9p%d", xendev->dev);
> >      xen_9pdev->tag = s->fsconf.tag = xenstore_read_fe_str(xendev, "tag");
> > -    v9fs_register_transport(s, &xen_9p_transport);
> >      fsdev = qemu_opts_create(qemu_find_opts("fsdev"),
> >              s->fsconf.tag,
> >              1, NULL);
> > @@ -457,7 +456,7 @@ static int xen_9pfs_connect(struct XenDevice *xendev)
> >      qemu_opt_set(fsdev, "security_model", xen_9pdev->security_model, NULL);
> >      qemu_opts_set_id(fsdev, s->fsconf.fsdev_id);
> >      qemu_fsdev_add(fsdev);
> > -    v9fs_device_realize_common(s, NULL);
> > +    v9fs_device_realize_common(s, &xen_9p_transport, NULL);
> >  
> >      return 0;
> >  
> > 
> 
> 
