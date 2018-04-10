Received: from eggs.gnu.org ([2001:4830:134:3::10]:60512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f5pTJ-0002JA-Bk
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:21:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f5pTG-0004P9-6H
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:21:49 -0400
Date: Tue, 10 Apr 2018 11:21:34 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180410112134.2082edbf.cohuck@redhat.com>
In-Reply-To: <152326891065.266543.9487977590811413472.stgit@bahia.lan>
References: <152326891065.266543.9487977590811413472.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 for-2.13] vfio-ccw: introduce
 vfio_ccw_get_device()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org, qemu-stable@nongnu.org

On Mon, 09 Apr 2018 12:15:10 +0200
Greg Kurz <groug@kaod.org> wrote:

> A recent patch fixed leaks of the dynamically allocated vcdev->vdev.name
> field in vfio_ccw_realize(), but we now have three freeing sites for it.
> This is unfortunate and seems to indicate something is wrong with its
> life cycle.
> 
> The root issue is that vcdev->vdev.name is set before vfio_get_device()
> is called, which theoretically prevents to call vfio_put_device() to
> do the freeing. Well actually, we could call it anyway  because
> vfio_put_base_device() is a nop if the device isn't attached, but this
> would be confusing.
> 
> This patch hence moves all the logic of attaching the device, including
> the "already attached" check, to a separate vfio_ccw_get_device() function,
> counterpart of vfio_put_device(). While here, vfio_put_device() is renamed
> to vfio_ccw_put_device() for consistency.
> 
> Based-on: <152311222681.203086.8874800175539040298.stgit@bahia>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> v3: - make vfio_ccw_get_device() void and check err in caller
> ---
>  hw/vfio/ccw.c |   56 ++++++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 36 insertions(+), 20 deletions(-)

Thanks, applied.
