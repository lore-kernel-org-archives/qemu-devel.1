Received: from eggs.gnu.org ([2001:4830:134:3::10]:38056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dah58-0006Pi-5O
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 07:35:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dah55-0004jO-FD
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 07:35:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1dah55-0004hx-6p
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 07:35:51 -0400
References: <20170628190047.26159-1-dgilbert@redhat.com>
	<20170628190047.26159-27-dgilbert@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <0ac99cfe-1cb6-e405-b4c0-1f1c407cf94f@redhat.com>
Date: Thu, 27 Jul 2017 13:35:35 +0200
MIME-Version: 1.0
In-Reply-To: <20170628190047.26159-27-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 26/29] vhost: Add VHOST_USER_POSTCOPY_END
 message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, a.perevalov@samsung.com, marcandre.lureau@redhat.com, mst@redhat.com, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com



On 06/28/2017 09:00 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> This message is sent just before the end of postcopy to get the
> client to stop using userfault since we wont respond to any more
> requests.  It should close userfaultfd so that any other pages
> get mapped to the backing file automatically by the kernel, since
> at this point we know we've received everything.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>   contrib/libvhost-user/libvhost-user.c | 23 +++++++++++++++++++++++
>   contrib/libvhost-user/libvhost-user.h |  1 +
>   hw/virtio/vhost-user.c                |  1 +
>   3 files changed, 25 insertions(+)
> 
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
> index d37052b7b0..c1716d1a62 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -68,6 +68,7 @@ vu_request_to_string(int req)
>           REQ(VHOST_USER_INPUT_GET_CONFIG),
>           REQ(VHOST_USER_POSTCOPY_ADVISE),
>           REQ(VHOST_USER_POSTCOPY_LISTEN),
> +        REQ(VHOST_USER_POSTCOPY_END),
>           REQ(VHOST_USER_MAX),
>       };
>   #undef REQ
> @@ -889,6 +890,26 @@ vu_set_postcopy_listen(VuDev *dev, VhostUserMsg *vmsg)
>   
>       return false;
>   }
> +
> +static bool
> +vu_set_postcopy_end(VuDev *dev, VhostUserMsg *vmsg)
> +{
> +    fprintf(stderr, "%s: Entry\n", __func__);
> +    dev->postcopy_listening = false;
> +    if (dev->postcopy_ufd > 0) {
> +        close(dev->postcopy_ufd);
> +        dev->postcopy_ufd = -1;
> +        fprintf(stderr, "%s: Done close\n", __func__);
> +    }
> +
> +    vmsg->fd_num = 0;
> +    vmsg->payload.u64 = 0;
> +    vmsg->size = sizeof(vmsg->payload.u64);
> +    vmsg->flags = VHOST_USER_VERSION |  VHOST_USER_REPLY_MASK;
> +    fprintf(stderr, "%s: exit\n", __func__);
> +    return true;
> +}
> +

It is what reply-ack is done for, so to avoid code duplication,
maybe Qemu could set VHOST_USER_NEED_REPLY_MASK bit when reply-ack
feature is supported.

I'm wondering if we shouldn't consider adding reply-ack feature support
to libvhost-user, and make postcopy support to depend on this feature.

Cheers,
Maxime
