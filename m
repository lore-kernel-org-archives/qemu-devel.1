Received: from eggs.gnu.org ([2001:4830:134:3::10]:44573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gAf1f-0006jC-EM
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:45:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gAf1c-0006U4-5X
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:45:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gAf1b-0006Tc-Vq
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:45:28 -0400
Date: Thu, 11 Oct 2018 18:45:10 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181011174509.GL2483@work-vm>
References: <CGME20181002140746eucas1p14d822ee1600d78687a73d6bf9a44e36b@eucas1p1.samsung.com>
	<20181002140947.4107-1-i.maximets@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002140947.4107-1-i.maximets@samsung.com>
Subject: Re: [Qemu-devel] [PATCH] vhost-user: Don't ask for reply on
 postcopy mem table set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ilya Maximets <i.maximets@samsung.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>

* Ilya Maximets (i.maximets@samsung.com) wrote:
> According to documentation, NEED_REPLY_MASK should not be set
> for VHOST_USER_SET_MEM_TABLE request in postcopy mode.
> This restriction was mistakenly applied to 'reply_supported'
> variable, which is local and used only for non-postcopy case.
> 
> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Fixes: 9bb38019942c ("vhost+postcopy: Send address back to qemu")
> Signed-off-by: Ilya Maximets <i.maximets@samsung.com>

Queued

> ---
>  hw/virtio/vhost-user.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index b041343632..c442daa562 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -374,8 +374,6 @@ static int vhost_user_set_mem_table_postcopy(struct vhost_dev *dev,
>      int fds[VHOST_MEMORY_MAX_NREGIONS];
>      int i, fd;
>      size_t fd_num = 0;
> -    bool reply_supported = virtio_has_feature(dev->protocol_features,
> -                                              VHOST_USER_PROTOCOL_F_REPLY_ACK);
>      VhostUserMsg msg_reply;
>      int region_i, msg_i;
>  
> @@ -384,10 +382,6 @@ static int vhost_user_set_mem_table_postcopy(struct vhost_dev *dev,
>          .hdr.flags = VHOST_USER_VERSION,
>      };
>  
> -    if (reply_supported) {
> -        msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
> -    }
> -
>      if (u->region_rb_len < dev->mem->nregions) {
>          u->region_rb = g_renew(RAMBlock*, u->region_rb, dev->mem->nregions);
>          u->region_rb_offset = g_renew(ram_addr_t, u->region_rb_offset,
> @@ -503,10 +497,6 @@ static int vhost_user_set_mem_table_postcopy(struct vhost_dev *dev,
>          return -1;
>      }
>  
> -    if (reply_supported) {
> -        return process_message_reply(dev, &msg);
> -    }
> -
>      return 0;
>  }
>  
> @@ -519,8 +509,7 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
>      size_t fd_num = 0;
>      bool do_postcopy = u->postcopy_listen && u->postcopy_fd.handler;
>      bool reply_supported = virtio_has_feature(dev->protocol_features,
> -                                          VHOST_USER_PROTOCOL_F_REPLY_ACK) &&
> -                                          !do_postcopy;
> +                                              VHOST_USER_PROTOCOL_F_REPLY_ACK);
>  
>      if (do_postcopy) {
>          /* Postcopy has enough differences that it's best done in it's own
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
