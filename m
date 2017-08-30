Received: from eggs.gnu.org ([2001:4830:134:3::10]:42748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dmwuw-0006v0-Px
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 02:56:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dmwut-0001Oz-OL
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 02:56:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dmwut-0001Oi-Ei
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 02:55:59 -0400
Date: Wed, 30 Aug 2017 14:55:46 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170830065546.GE5920@pxdev.xzpeter.org>
References: <20170824192730.8440-1-dgilbert@redhat.com>
	<20170824192730.8440-27-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170824192730.8440-27-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 26/32] vhost: Add VHOST_USER_POSTCOPY_END
 message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, a.perevalov@samsung.com, mst@redhat.com, marcandre.lureau@redhat.com, quintela@redhat.com, lvivier@redhat.com, aarcange@redhat.com, felipe@nutanix.com

On Thu, Aug 24, 2017 at 08:27:24PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> This message is sent just before the end of postcopy to get the
> client to stop using userfault since we wont respond to any more
> requests.  It should close userfaultfd so that any other pages
> get mapped to the backing file automatically by the kernel, since
> at this point we know we've received everything.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

(I feel like the title should be for "vub", not "vhost"?)

Reviewed-by: Peter Xu <peterx@redhat.com>

> ---
>  contrib/libvhost-user/libvhost-user.c | 23 +++++++++++++++++++++++
>  contrib/libvhost-user/libvhost-user.h |  1 +
>  docs/interop/vhost-user.txt           |  8 ++++++++
>  hw/virtio/vhost-user.c                |  1 +
>  4 files changed, 33 insertions(+)
> 
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
> index d816851c6d..23bff47649 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -67,6 +67,7 @@ vu_request_to_string(int req)
>          REQ(VHOST_USER_SET_VRING_ENDIAN),
>          REQ(VHOST_USER_POSTCOPY_ADVISE),
>          REQ(VHOST_USER_POSTCOPY_LISTEN),
> +        REQ(VHOST_USER_POSTCOPY_END),
>          REQ(VHOST_USER_MAX),
>      };
>  #undef REQ
> @@ -893,6 +894,26 @@ vu_set_postcopy_listen(VuDev *dev, VhostUserMsg *vmsg)
>      vmsg->payload.u64 = 0; /* Success */
>      return true;
>  }
> +
> +static bool
> +vu_set_postcopy_end(VuDev *dev, VhostUserMsg *vmsg)
> +{
> +    DPRINT("%s: Entry\n", __func__);
> +    dev->postcopy_listening = false;
> +    if (dev->postcopy_ufd > 0) {
> +        close(dev->postcopy_ufd);
> +        dev->postcopy_ufd = -1;
> +        DPRINT("%s: Done close\n", __func__);
> +    }
> +
> +    vmsg->fd_num = 0;
> +    vmsg->payload.u64 = 0;
> +    vmsg->size = sizeof(vmsg->payload.u64);
> +    vmsg->flags = VHOST_USER_VERSION |  VHOST_USER_REPLY_MASK;
> +    DPRINT("%s: exit\n", __func__);
> +    return true;
> +}
> +
>  static bool
>  vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
>  {
> @@ -962,6 +983,8 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
>          return vu_set_postcopy_advise(dev, vmsg);
>      case VHOST_USER_POSTCOPY_LISTEN:
>          return vu_set_postcopy_listen(dev, vmsg);
> +    case VHOST_USER_POSTCOPY_END:
> +        return vu_set_postcopy_end(dev, vmsg);
>      default:
>          vmsg_close_fds(vmsg);
>          vu_panic(dev, "Unhandled request: %d", vmsg->request);
> diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
> index 29c11ba56c..a78596e6fd 100644
> --- a/contrib/libvhost-user/libvhost-user.h
> +++ b/contrib/libvhost-user/libvhost-user.h
> @@ -68,6 +68,7 @@ typedef enum VhostUserRequest {
>      VHOST_USER_SET_VRING_ENDIAN = 23,
>      VHOST_USER_POSTCOPY_ADVISE  = 24,
>      VHOST_USER_POSTCOPY_LISTEN  = 25,
> +    VHOST_USER_POSTCOPY_END     = 26,
>      VHOST_USER_MAX
>  } VhostUserRequest;
>  
> diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
> index b2a548c94d..d6586e0b43 100644
> --- a/docs/interop/vhost-user.txt
> +++ b/docs/interop/vhost-user.txt
> @@ -627,6 +627,14 @@ Master message types
>  
>        Master advises slave that a transition to postcopy mode has happened.
>  
> + * VHOST_USER_POSTCOPY_END
> +      Id: 26
> +      Slave payload: u64
> +
> +      Master advises that postcopy migration has now completed.  The
> +      slave must disable the userfaultfd. The response is an acknowledgement
> +      only.
> +
>  Slave message types
>  -------------------
>  
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 4d03383a66..c2e55be0fd 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -71,6 +71,7 @@ typedef enum VhostUserRequest {
>      VHOST_USER_SET_VRING_ENDIAN = 23,
>      VHOST_USER_POSTCOPY_ADVISE  = 24,
>      VHOST_USER_POSTCOPY_LISTEN  = 25,
> +    VHOST_USER_POSTCOPY_END     = 26,
>      VHOST_USER_MAX
>  } VhostUserRequest;
>  
> -- 
> 2.13.5
> 

-- 
Peter Xu
