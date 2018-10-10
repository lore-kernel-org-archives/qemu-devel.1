Received: from eggs.gnu.org ([2001:4830:134:3::10]:44257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gAJo8-00012o-K7
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 15:06:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gAJo5-0003CJ-EG
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 15:06:08 -0400
Date: Wed, 10 Oct 2018 20:05:53 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181010190552.GD2411@work-vm>
References: <20181008160536.6332-1-i.maximets@samsung.com>
	<CGME20181008160328eucas1p14fff8e1e5e5f065019353fb86b845340@eucas1p1.samsung.com>
	<20181008160536.6332-3-i.maximets@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008160536.6332-3-i.maximets@samsung.com>
Subject: Re: [Qemu-devel] [RFC 2/2] vhost-user: Fix userfaultfd leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ilya Maximets <i.maximets@samsung.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, qemu-stable@nongnu.org

* Ilya Maximets (i.maximets@samsung.com) wrote:
> 'fd' received from the vhost side is never freed.
> Also, everything (including 'postcopy_listen' state) should be
> cleaned up on vhost cleanup.
> 
> Fixes: 46343570c06e ("vhost+postcopy: Wire up POSTCOPY_END notify")
> Fixes: f82c11165ffa ("vhost+postcopy: Register shared ufd with postcopy")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Ilya Maximets <i.maximets@samsung.com>

Thanks,


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  hw/virtio/vhost-user.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index c442daa562..e09bed0e4a 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1280,6 +1280,7 @@ static int vhost_user_postcopy_end(struct vhost_dev *dev, Error **errp)
>          return ret;
>      }
>      postcopy_unregister_shared_ufd(&u->postcopy_fd);
> +    close(u->postcopy_fd.fd);
>      u->postcopy_fd.handler = NULL;
>  
>      trace_vhost_user_postcopy_end_exit();
> @@ -1419,6 +1420,12 @@ static int vhost_user_backend_cleanup(struct vhost_dev *dev)
>          postcopy_remove_notifier(&u->postcopy_notifier);
>          u->postcopy_notifier.notify = NULL;
>      }
> +    u->postcopy_listen = false;
> +    if (u->postcopy_fd.handler) {
> +        postcopy_unregister_shared_ufd(&u->postcopy_fd);
> +        close(u->postcopy_fd.fd);
> +        u->postcopy_fd.handler = NULL;
> +    }
>      if (u->slave_fd >= 0) {
>          qemu_set_fd_handler(u->slave_fd, NULL, NULL, NULL);
>          close(u->slave_fd);
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
