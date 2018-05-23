Received: from eggs.gnu.org ([2001:4830:134:3::10]:45527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLbGD-0000g6-D8
	for qemu-devel@nongnu.org; Wed, 23 May 2018 17:25:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLbG9-0003Zv-DA
	for qemu-devel@nongnu.org; Wed, 23 May 2018 17:25:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41616 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fLbG9-0003Zk-6e
	for qemu-devel@nongnu.org; Wed, 23 May 2018 17:25:25 -0400
Date: Thu, 24 May 2018 00:25:23 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180524002447-mutt-send-email-mst@kernel.org>
References: <20180412151232.17506-1-tiwei.bie@intel.com>
	<20180412151232.17506-4-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180412151232.17506-4-tiwei.bie@intel.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/6] vhost-user: support receiving file
 descriptors in slave_read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: jasowang@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com

On Thu, Apr 12, 2018 at 11:12:29PM +0800, Tiwei Bie wrote:
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>


Thinking about it, I think we should add a protocol
feature for this. This way remote can find out whether
it's safe to send this data to us.

> ---
>  hw/virtio/vhost-user.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 91edd95453..9cea2c8c51 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -854,14 +854,44 @@ static void slave_read(void *opaque)
>      VhostUserHeader hdr = { 0, };
>      VhostUserPayload payload = { 0, };
>      int size, ret = 0;
> +    struct iovec iov;
> +    struct msghdr msgh;
> +    int fd = -1;
> +    char control[CMSG_SPACE(sizeof(fd))];
> +    struct cmsghdr *cmsg;
> +    size_t fdsize;
> +
> +    memset(&msgh, 0, sizeof(msgh));
> +    msgh.msg_iov = &iov;
> +    msgh.msg_iovlen = 1;
> +    msgh.msg_control = control;
> +    msgh.msg_controllen = sizeof(control);
>  
>      /* Read header */
> -    size = read(u->slave_fd, &hdr, VHOST_USER_HDR_SIZE);
> +    iov.iov_base = &hdr;
> +    iov.iov_len = VHOST_USER_HDR_SIZE;
> +
> +    size = recvmsg(u->slave_fd, &msgh, 0);
>      if (size != VHOST_USER_HDR_SIZE) {
>          error_report("Failed to read from slave.");
>          goto err;
>      }
>  
> +    if (msgh.msg_flags & MSG_CTRUNC) {
> +        error_report("Truncated message.");
> +        goto err;
> +    }
> +
> +    for (cmsg = CMSG_FIRSTHDR(&msgh); cmsg != NULL;
> +         cmsg = CMSG_NXTHDR(&msgh, cmsg)) {
> +            if (cmsg->cmsg_level == SOL_SOCKET &&
> +                cmsg->cmsg_type == SCM_RIGHTS) {
> +                    fdsize = cmsg->cmsg_len - CMSG_LEN(0);
> +                    memcpy(&fd, CMSG_DATA(cmsg), fdsize);
> +                    break;
> +            }
> +    }
> +
>      if (hdr.size > VHOST_USER_PAYLOAD_SIZE) {
>          error_report("Failed to read msg header."
>                  " Size %d exceeds the maximum %zu.", hdr.size,
> @@ -885,9 +915,15 @@ static void slave_read(void *opaque)
>          break;
>      default:
>          error_report("Received unexpected msg type.");
> +        if (fd != -1) {
> +            close(fd);
> +        }
>          ret = -EINVAL;
>      }
>  
> +    /* Message handlers need to make sure that fd will be consumed. */
> +    fd = -1;
> +
>      /*
>       * REPLY_ACK feature handling. Other reply types has to be managed
>       * directly in their request handlers.
> @@ -920,6 +956,9 @@ err:
>      qemu_set_fd_handler(u->slave_fd, NULL, NULL, NULL);
>      close(u->slave_fd);
>      u->slave_fd = -1;
> +    if (fd != -1) {
> +        close(fd);
> +    }
>      return;
>  }
>  
> -- 
> 2.11.0
