Received: from eggs.gnu.org ([2001:4830:134:3::10]:54975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1cngiE-0001LX-AW
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 03:17:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1cngiB-0008NH-18
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 03:17:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:41314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jgross@suse.com>) id 1cngiA-0008Lq-Mu
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 03:17:38 -0400
References: <alpine.DEB.2.10.1703131650550.21520@sstabellini-ThinkPad-X260>
	<1489449360-14411-1-git-send-email-sstabellini@kernel.org>
	<1489449360-14411-5-git-send-email-sstabellini@kernel.org>
From: Juergen Gross <jgross@suse.com>
Message-ID: <5c51b719-737f-82f8-849c-2f2a16aeb213@suse.com>
Date: Tue, 14 Mar 2017 08:17:34 +0100
MIME-Version: 1.0
In-Reply-To: <1489449360-14411-5-git-send-email-sstabellini@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/9] xen/9pfs: connect to the frontend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, anthony.perard@citrix.com, groug@kaod.org, Stefano Stabellini <stefano@aporeto.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

On 14/03/17 00:55, Stefano Stabellini wrote:
> Write the limits of the backend to xenstore. Connect to the frontend.
> Upon connection, allocate the rings according to the protocol
> specification.
> 
> Initialize a QEMUBH to schedule work upon receiving an event channel
> notification from the frontend.
> 
> Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
> CC: anthony.perard@citrix.com
> CC: jgross@suse.com
> CC: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> CC: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/xen-9p-backend.c | 159 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 158 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
> index 35032d3..0e4a133 100644
> --- a/hw/9pfs/xen-9p-backend.c
> +++ b/hw/9pfs/xen-9p-backend.c
> @@ -17,8 +17,35 @@
>  #include "qemu/config-file.h"
>  #include "fsdev/qemu-fsdev.h"
>  
> +#define VERSIONS "1"
> +#define MAX_RINGS 8
> +#define MAX_RING_ORDER 8
> +
> +struct Xen9pfsRing {
> +    struct Xen9pfsDev *priv;
> +
> +    int ref;
> +    xenevtchn_handle   *evtchndev;
> +    int evtchn;
> +    int local_port;
> +    struct xen_9pfs_data_intf *intf;
> +    unsigned char *data;
> +    struct xen_9pfs_data ring;
> +
> +    QEMUBH *bh;
> +
> +    /* local copies, so that we can read/write PDU data directly from
> +     * the ring */
> +    RING_IDX out_cons, out_size, in_cons;
> +    bool inprogress;
> +};
> +
>  typedef struct Xen9pfsDev {
>      struct XenDevice xendev;  /* must be first */
> +    V9fsState state;
> +
> +    int num_rings;
> +    struct Xen9pfsRing *rings;
>  } Xen9pfsDev;
>  
>  static ssize_t xen_9pfs_pdu_vmarshal(V9fsPDU *pdu,
> @@ -67,22 +94,152 @@ static int xen_9pfs_init(struct XenDevice *xendev)
>      return 0;
>  }
>  
> +static void xen_9pfs_bh(void *opaque)
> +{
> +}
> +
> +static void xen_9pfs_evtchn_event(void *opaque)
> +{
> +}
> +
>  static int xen_9pfs_free(struct XenDevice *xendev)
>  {
> -    return -1;
> +    int i;
> +    struct Xen9pfsDev *xen_9pdev = container_of(xendev, struct Xen9pfsDev, xendev);
> +
> +    for (i = 0; i < xen_9pdev->num_rings; i++) {
> +        if (xen_9pdev->rings[i].data != NULL) {
> +            xengnttab_unmap(xen_9pdev->xendev.gnttabdev,
> +                    xen_9pdev->rings[i].data,
> +                    (1 << XEN_9PFS_RING_ORDER));
> +        }
> +        if (xen_9pdev->rings[i].intf != NULL) {
> +            xengnttab_unmap(xen_9pdev->xendev.gnttabdev,
> +                    xen_9pdev->rings[i].intf,
> +                    1);
> +        }
> +        if (xen_9pdev->rings[i].evtchndev > 0) {
> +            qemu_set_fd_handler(xenevtchn_fd(xen_9pdev->rings[i].evtchndev),
> +                    NULL, NULL, NULL);
> +            xenevtchn_unbind(xen_9pdev->rings[i].evtchndev, xen_9pdev->rings[i].local_port);
> +        }
> +        if (xen_9pdev->rings[i].bh != NULL) {
> +            qemu_bh_delete(xen_9pdev->rings[i].bh);
> +        }
> +    }
> +    g_free(xen_9pdev->rings);
> +    return 0;
>  }
>  
>  static int xen_9pfs_connect(struct XenDevice *xendev)
>  {
> +    int i;
> +    struct Xen9pfsDev *xen_9pdev = container_of(xendev, struct Xen9pfsDev, xendev);
> +    V9fsState *s = &xen_9pdev->state;
> +    QemuOpts *fsdev;
> +    char *security_model, *path;
> +
> +    if (xenstore_read_fe_int(&xen_9pdev->xendev, "num-rings",
> +                             &xen_9pdev->num_rings) == -1 ||
> +        xen_9pdev->num_rings > MAX_RINGS) {

What if num_rings is < 1?

> +        return -1;
> +    }
> +
> +    xen_9pdev->rings = g_malloc0(xen_9pdev->num_rings * sizeof(struct Xen9pfsRing));
> +    for (i = 0; i < xen_9pdev->num_rings; i++) {
> +        char str[16];
> +
> +        xen_9pdev->rings[i].priv = xen_9pdev;
> +        xen_9pdev->rings[i].evtchn = -1;
> +        xen_9pdev->rings[i].local_port = -1;
> +
> +        sprintf(str, "ring-ref%u", i);

use g_strdup_printf()?

> +        if (xenstore_read_fe_int(&xen_9pdev->xendev, str,
> +                                 &xen_9pdev->rings[i].ref) == -1) {
> +            goto out;
> +        }
> +        sprintf(str, "event-channel-%u", i);

use g_strdup_printf()?


Juergen
