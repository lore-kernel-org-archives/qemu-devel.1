Received: from eggs.gnu.org ([2001:4830:134:3::10]:53980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1coGVI-00068A-EY
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 17:30:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1coGVE-00064n-BA
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 17:30:44 -0400
Received: from mail.kernel.org ([198.145.29.136]:34102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1coGVE-00063I-1V
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 17:30:40 -0400
Date: Wed, 15 Mar 2017 14:30:29 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <20170315104814.0e49c4d3@bahia.lab.toulouse-stg.fr.ibm.com>
Message-ID: <alpine.DEB.2.10.1703151408360.4807@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1703131650550.21520@sstabellini-ThinkPad-X260>
	<1489449360-14411-1-git-send-email-sstabellini@kernel.org>
	<1489449360-14411-5-git-send-email-sstabellini@kernel.org>
	<20170315104814.0e49c4d3@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v2 5/9] xen/9pfs: connect to the frontend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, anthony.perard@citrix.com, Stefano Stabellini <stefano@aporeto.com>, jgross@suse.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

On Wed, 15 Mar 2017, Greg Kurz wrote:
> On Mon, 13 Mar 2017 16:55:56 -0700
> Stefano Stabellini <sstabellini@kernel.org> wrote:
> 
> > Write the limits of the backend to xenstore. Connect to the frontend.
> > Upon connection, allocate the rings according to the protocol
> > specification.
> > 
> > Initialize a QEMUBH to schedule work upon receiving an event channel
> > notification from the frontend.
> > 
> > Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
> > CC: anthony.perard@citrix.com
> > CC: jgross@suse.com
> > CC: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> > CC: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/9pfs/xen-9p-backend.c | 159 ++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 158 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
> > index 35032d3..0e4a133 100644
> > --- a/hw/9pfs/xen-9p-backend.c
> > +++ b/hw/9pfs/xen-9p-backend.c
> > @@ -17,8 +17,35 @@
> >  #include "qemu/config-file.h"
> >  #include "fsdev/qemu-fsdev.h"
> >  
> > +#define VERSIONS "1"
> > +#define MAX_RINGS 8
> > +#define MAX_RING_ORDER 8
> > +
> > +struct Xen9pfsRing {
> > +    struct Xen9pfsDev *priv;
> > +
> > +    int ref;
> > +    xenevtchn_handle   *evtchndev;
> > +    int evtchn;
> > +    int local_port;
> > +    struct xen_9pfs_data_intf *intf;
> > +    unsigned char *data;
> > +    struct xen_9pfs_data ring;
> > +
> > +    QEMUBH *bh;
> > +
> > +    /* local copies, so that we can read/write PDU data directly from
> > +     * the ring */
> > +    RING_IDX out_cons, out_size, in_cons;
> > +    bool inprogress;
> > +};
> > +
> 
> QEMU Coding style requires a typedef.

OK


> FWIW, maybe you could also convert
> other structured types like XenDevice or XenDevOps.

I'll do in a separate series


> >  typedef struct Xen9pfsDev {
> >      struct XenDevice xendev;  /* must be first */
> > +    V9fsState state;
> > +
> > +    int num_rings;
> > +    struct Xen9pfsRing *rings;
> >  } Xen9pfsDev;
> >  
> >  static ssize_t xen_9pfs_pdu_vmarshal(V9fsPDU *pdu,
> > @@ -67,22 +94,152 @@ static int xen_9pfs_init(struct XenDevice *xendev)
> >      return 0;
> >  }
> >  
> > +static void xen_9pfs_bh(void *opaque)
> > +{
> > +}
> > +
> > +static void xen_9pfs_evtchn_event(void *opaque)
> > +{
> > +}
> > +
> >  static int xen_9pfs_free(struct XenDevice *xendev)
> >  {
> > -    return -1;
> > +    int i;
> > +    struct Xen9pfsDev *xen_9pdev = container_of(xendev, struct Xen9pfsDev, xendev);
> > +
> 
> Coding style.

OK


> > +    for (i = 0; i < xen_9pdev->num_rings; i++) {
> > +        if (xen_9pdev->rings[i].data != NULL) {
> > +            xengnttab_unmap(xen_9pdev->xendev.gnttabdev,
> > +                    xen_9pdev->rings[i].data,
> > +                    (1 << XEN_9PFS_RING_ORDER));
> > +        }
> > +        if (xen_9pdev->rings[i].intf != NULL) {
> > +            xengnttab_unmap(xen_9pdev->xendev.gnttabdev,
> > +                    xen_9pdev->rings[i].intf,
> > +                    1);
> > +        }
> > +        if (xen_9pdev->rings[i].evtchndev > 0) {
> > +            qemu_set_fd_handler(xenevtchn_fd(xen_9pdev->rings[i].evtchndev),
> > +                    NULL, NULL, NULL);
> > +            xenevtchn_unbind(xen_9pdev->rings[i].evtchndev, xen_9pdev->rings[i].local_port);
> > +        }
> > +        if (xen_9pdev->rings[i].bh != NULL) {
> > +            qemu_bh_delete(xen_9pdev->rings[i].bh);
> > +        }
> > +    }
> > +    g_free(xen_9pdev->rings);
> > +    return 0;
> >  }
> >  
> >  static int xen_9pfs_connect(struct XenDevice *xendev)
> >  {
> > +    int i;
> > +    struct Xen9pfsDev *xen_9pdev = container_of(xendev, struct Xen9pfsDev, xendev);
> 
> Coding style.

OK


> > +    V9fsState *s = &xen_9pdev->state;
> > +    QemuOpts *fsdev;
> > +    char *security_model, *path;
> > +
> > +    if (xenstore_read_fe_int(&xen_9pdev->xendev, "num-rings",
> > +                             &xen_9pdev->num_rings) == -1 ||
> > +        xen_9pdev->num_rings > MAX_RINGS) {
> > +        return -1;
> > +    }
> > +
> > +    xen_9pdev->rings = g_malloc0(xen_9pdev->num_rings * sizeof(struct Xen9pfsRing));
> > +    for (i = 0; i < xen_9pdev->num_rings; i++) {
> > +        char str[16];
> > +
> > +        xen_9pdev->rings[i].priv = xen_9pdev;
> > +        xen_9pdev->rings[i].evtchn = -1;
> > +        xen_9pdev->rings[i].local_port = -1;
> > +
> > +        sprintf(str, "ring-ref%u", i);
> > +        if (xenstore_read_fe_int(&xen_9pdev->xendev, str,
> > +                                 &xen_9pdev->rings[i].ref) == -1) {
> > +            goto out;
> > +        }
> > +        sprintf(str, "event-channel-%u", i);
> > +        if (xenstore_read_fe_int(&xen_9pdev->xendev, str,
> > +                                 &xen_9pdev->rings[i].evtchn) == -1) {
> > +            goto out;
> > +        }
> > +
> > +        xen_9pdev->rings[i].intf =  xengnttab_map_grant_ref(
> > +                xen_9pdev->xendev.gnttabdev,
> > +                xen_9pdev->xendev.dom,
> > +                xen_9pdev->rings[i].ref,
> > +                PROT_READ | PROT_WRITE);
> > +        if (!xen_9pdev->rings[i].intf) {
> > +            goto out;
> > +        }
> > +        xen_9pdev->rings[i].data = xengnttab_map_domain_grant_refs(
> > +                xen_9pdev->xendev.gnttabdev,
> > +                (1 << XEN_9PFS_RING_ORDER),
> > +                xen_9pdev->xendev.dom,
> > +                xen_9pdev->rings[i].intf->ref,
> > +                PROT_READ | PROT_WRITE);
> > +        if (!xen_9pdev->rings[i].data) {
> > +            goto out;
> > +        }
> > +        xen_9pdev->rings[i].ring.in = xen_9pdev->rings[i].data;
> > +        xen_9pdev->rings[i].ring.out = xen_9pdev->rings[i].data + XEN_9PFS_RING_SIZE;
> > +
> > +        xen_9pdev->rings[i].bh = qemu_bh_new(xen_9pfs_bh, &xen_9pdev->rings[i]);
> > +        xen_9pdev->rings[i].out_cons = 0;
> > +        xen_9pdev->rings[i].out_size = 0;
> > +        xen_9pdev->rings[i].inprogress = false;
> > +
> > +
> > +        xen_9pdev->rings[i].evtchndev = xenevtchn_open(NULL, 0);
> > +        if (xen_9pdev->rings[i].evtchndev == NULL) {
> > +            goto out;
> > +        }
> > +        fcntl(xenevtchn_fd(xen_9pdev->rings[i].evtchndev), F_SETFD, FD_CLOEXEC);
> > +        xen_9pdev->rings[i].local_port = xenevtchn_bind_interdomain
> > +            (xen_9pdev->rings[i].evtchndev, xendev->dom, xen_9pdev->rings[i].evtchn);
> > +        if (xen_9pdev->rings[i].local_port == -1) {
> > +            xen_pv_printf(xendev, 0, "xenevtchn_bind_interdomain failed port=%d\n",
> > +                          xen_9pdev->rings[i].evtchn);
> > +            goto out;
> > +        }
> > +        xen_pv_printf(xendev, 2, "bind evtchn port %d\n", xendev->local_port);
> > +        qemu_set_fd_handler(xenevtchn_fd(xen_9pdev->rings[i].evtchndev),
> > +                xen_9pfs_evtchn_event, NULL, &xen_9pdev->rings[i]);
> > +    }
> > +
> > +    security_model = xenstore_read_be_str(xendev, "security_model");
> > +    path = xenstore_read_be_str(xendev, "path");
> > +    s->fsconf.fsdev_id = g_malloc(strlen("xen9p") + 6);
> > +    sprintf(s->fsconf.fsdev_id, "xen9p%d", xendev->dev);
> 
> Please use g_strdup_printf().

I'll do


> > +    s->fsconf.tag = xenstore_read_fe_str(xendev, "tag");
> > +    v9fs_register_transport(s, &xen_9p_transport);
> > +    fsdev = qemu_opts_create(qemu_find_opts("fsdev"),
> > +            s->fsconf.tag,
> > +            1, NULL);
> > +    qemu_opt_set(fsdev, "fsdriver", "local", NULL);
> > +    qemu_opt_set(fsdev, "path", path, NULL);
> > +    qemu_opt_set(fsdev, "security_model", security_model, NULL);
> > +    qemu_opts_set_id(fsdev, s->fsconf.fsdev_id);
> > +    qemu_fsdev_add(fsdev);
> > +    v9fs_device_realize_common(s, NULL);
> > +
> >      return 0;
> > +
> > +out:
> > +    xen_9pfs_free(xendev);
> > +    return -1;
> >  }
> >  
> >  static void xen_9pfs_alloc(struct XenDevice *xendev)
> >  {
> > +    xenstore_write_be_str(xendev, "versions", VERSIONS);
> > +    xenstore_write_be_int(xendev, "max-rings", MAX_RINGS);
> > +    xenstore_write_be_int(xendev, "max-ring-page-order", MAX_RING_ORDER);
> >  }
> >  
> >  static void xen_9pfs_disconnect(struct XenDevice *xendev)
> >  {
> > +    /* Dynamic hotplug of PV filesystems at runtime is not supported. */
> 
> Does this mean that this function is never called ? Or that it should
> report an error ? Or print one ?

This function is called, but only at shutdown.



> In any case, it looks weird that it doesn't free the fsdev_id that
> was allocated in xen_9pfs_connect().

I'll free it in xen_9pfs_free


> >  }
> >  
> >  struct XenDevOps xen_9pfs_ops = {
> 
> 
