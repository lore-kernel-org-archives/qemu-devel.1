Received: from eggs.gnu.org ([2001:4830:134:3::10]:32866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=667e0e3bc=anthony.perard@citrix.com>)
	id 1fIwp2-0002Au-Kb
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:50:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=667e0e3bc=anthony.perard@citrix.com>)
	id 1fIwoz-0002Sl-IN
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:50:28 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:16139)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=667e0e3bc=anthony.perard@citrix.com>)
	id 1fIwoz-0002Rk-7p
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:50:25 -0400
Date: Wed, 16 May 2018 14:50:20 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20180516135020.GF2057@perard.uk.xensource.com>
References: <1525461967-32174-1-git-send-email-paul.durrant@citrix.com>
	<1525461967-32174-2-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1525461967-32174-2-git-send-email-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/8] xen_backend: add grant table helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: xen-devel@lists.xenproject.org, qemu-block@nongnu.org, qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>

On Fri, May 04, 2018 at 08:26:00PM +0100, Paul Durrant wrote:
> This patch adds grant table helper functions to the xen_backend code to
> localize error reporting and use of xen_domid.
> 
> The patch also defers the call to xengnttab_open() until just before the
> initialise method in XenDevOps is invoked. This method is responsible for
> mapping the shared ring. No prior method requires access to the grant table.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> ---
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> 
> v2:
>  - New in v2
> ---
>  hw/xen/xen_backend.c         | 123 ++++++++++++++++++++++++++++++++++++++-----
>  include/hw/xen/xen_backend.h |  33 ++++++++++++
>  2 files changed, 144 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/xen/xen_backend.c b/hw/xen/xen_backend.c
> index 7445b50..50412d6 100644
> --- a/hw/xen/xen_backend.c
> +++ b/hw/xen/xen_backend.c
> @@ -106,6 +106,103 @@ int xen_be_set_state(struct XenDevice *xendev, enum xenbus_state state)
>      return 0;
>  }
>  
> +void xen_be_set_max_grant_refs(struct XenDevice *xendev,
> +                               unsigned int nr_refs)

Is it fine to ignore error from set_max_grants and continue ? xen_disk.c
seems to fail the initialisation if set_max_grants call fails. On the
other end, xen-usb.c just keep going.

> +{
> +    assert(xendev->ops->flags & DEVOPS_FLAG_NEED_GNTDEV);
> +
> +    if (xengnttab_set_max_grants(xendev->gnttabdev, nr_refs)) {
> +        xen_pv_printf(xendev, 0, "xengnttab_set_max_grants failed: %s\n",
> +                      strerror(errno));
> +    }
> +}
> +

> +int xen_be_copy_grant_refs(struct XenDevice *xendev,
> +                           bool to_domain,
> +                           XenGrantCopySegment segs[],
> +                           unsigned int nr_segs)
> +{
> +    xengnttab_grant_copy_segment_t *xengnttab_segs;
> +    unsigned int i;
> +    int rc;
> +
> +    assert(xendev->ops->flags & DEVOPS_FLAG_NEED_GNTDEV);
> +
> +    xengnttab_segs = g_new0(xengnttab_grant_copy_segment_t, nr_segs);
> +
> +    for (i = 0; i < nr_segs; i++) {
> +        XenGrantCopySegment *seg = &segs[i];
> +        xengnttab_grant_copy_segment_t *xengnttab_seg = &xengnttab_segs[i];
> +
> +        if (to_domain) {
> +            xengnttab_seg->flags = GNTCOPY_dest_gref;
> +            xengnttab_seg->dest.foreign.domid = xen_domid;
> +            xengnttab_seg->dest.foreign.ref = seg->dest.foreign.ref;
> +            xengnttab_seg->dest.foreign.offset = seg->dest.foreign.offset;
> +            xengnttab_seg->source.virt = seg->source.virt;
> +        } else {
> +            xengnttab_seg->flags = GNTCOPY_source_gref;
> +            xengnttab_seg->source.foreign.domid = xen_domid;
> +            xengnttab_seg->source.foreign.ref = seg->source.foreign.ref;
> +            xengnttab_seg->source.foreign.offset =
> +                seg->source.foreign.offset;
> +            xengnttab_seg->dest.virt = seg->dest.virt;
> +        }

That's not going to work because xengnttab_grant_copy_segment_t doesn't
exist on Xen 4.7.

> +
> +        xengnttab_seg->len = seg->len;
> +    }
> +
> +    rc = xengnttab_grant_copy(xendev->gnttabdev, nr_segs, xengnttab_segs);

Thanks,

-- 
Anthony PERARD
