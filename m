Received: from eggs.gnu.org ([2001:4830:134:3::10]:58209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1db4km-0006IP-TZ
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:52:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1db4kl-0001nS-TU
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:52:28 -0400
Date: Fri, 28 Jul 2017 13:52:07 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170728125207.GN31495@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170728123127.27921-1-olaf@aepfle.de>
	<d8aca223-4007-6524-9876-fe32fd81e893@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d8aca223-4007-6524-9876-fe32fd81e893@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] xen-disk: use g_malloc0 to fix build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Olaf Hering <olaf@aepfle.de>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:X86" <xen-devel@lists.xenproject.org>, "open list:Block layer core" <qemu-block@nongnu.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>

On Fri, Jul 28, 2017 at 07:43:59AM -0500, Eric Blake wrote:
> On 07/28/2017 07:31 AM, Olaf Hering wrote:
> > g_malloc0_n is available since glib-2.24. To allow build with older glib
> > versions use the generic g_malloc0, which is already used in many other
> > places in the code.
> > 
> > Fixes commit 3284fad728 ("xen-disk: add support for multi-page shared rings")
> > 
> > Signed-off-by: Olaf Hering <olaf@aepfle.de>
> > ---
> >  hw/block/xen_disk.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
> > index d42ed7070d..71deec17b0 100644
> > --- a/hw/block/xen_disk.c
> > +++ b/hw/block/xen_disk.c
> > @@ -1232,7 +1232,7 @@ static int blk_connect(struct XenDevice *xendev)
> >          return -1;
> >      }
> >  
> > -    domids = g_malloc0_n(blkdev->nr_ring_ref, sizeof(uint32_t));
> > +    domids = g_malloc0(blkdev->nr_ring_ref * sizeof(uint32_t));
> 
> This version is prone to multiplication overflow (well, maybe not, but
> you have to audit for that).  Wouldn't it be better to use:
> 
> domids = g_new0(blkdev->nr_ring_ref, uint32_t)

You mean   g_new0(uint32_t, blkdev->nr_ring_ref)  but yeah, g_new0 is
better than g_malloc0 pretty much every time.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
