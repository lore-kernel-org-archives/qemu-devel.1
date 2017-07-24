Received: from eggs.gnu.org ([2001:4830:134:3::10]:46353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dZeTG-0004hD-Sc
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:36:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dZeTE-0002k8-68
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:36:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1dZeTD-0002jI-Vf
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:36:28 -0400
References: <20170628190047.26159-1-dgilbert@redhat.com>
	<20170628190047.26159-14-dgilbert@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <0485818d-69e4-071e-572a-be4e111fe8c4@redhat.com>
Date: Mon, 24 Jul 2017 16:36:11 +0200
MIME-Version: 1.0
In-Reply-To: <20170628190047.26159-14-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 13/29] vhost+postcopy: Transmit 'listen' to
 client
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
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index b98fbe4834..1f70f5760f 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -67,6 +67,7 @@ typedef enum VhostUserRequest {
>       VHOST_USER_SET_SLAVE_REQ_FD = 21,
>       VHOST_USER_IOTLB_MSG = 22,
>       VHOST_USER_POSTCOPY_ADVISE  = 23,
> +    VHOST_USER_POSTCOPY_LISTEN  = 24,
>       VHOST_USER_MAX
>   } VhostUserRequest;
>   
> @@ -771,6 +772,25 @@ static int vhost_user_postcopy_advise(struct vhost_dev *dev, Error **errp)
>       return 0;
>   }
>   
> +/*
> + * Called at the switch to postcopy on reception of the 'listen' command.
> + */
> +static int vhost_user_postcopy_listen(struct vhost_dev *dev, Error **errp)
> +{
> +    VhostUserMsg msg = {
> +        .request = VHOST_USER_POSTCOPY_LISTEN,
> +        .flags = VHOST_USER_VERSION,
> +    };

I think it should use REPLY_ACK feature when available for two reasons:
1. The backend could reply nack if nregions is already set.
2. When leaving vhost_user_postcopy_listen(), the message might likely
    not have been handled yet by the backend.

> +    trace_vhost_user_postcopy_listen();
> +    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
> +        error_setg(errp, "Failed to send postcopy_listen to vhost");
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
>   static int vhost_user_postcopy_notifier(NotifierWithReturn *notifier,
>                                           void *opaque)
>   {
> @@ -793,6 +813,9 @@ static int vhost_user_postcopy_notifier(NotifierWithReturn *notifier,
>       case POSTCOPY_NOTIFY_INBOUND_ADVISE:
>           return vhost_user_postcopy_advise(dev, pnd->errp);
>   
> +    case POSTCOPY_NOTIFY_INBOUND_LISTEN:
> +        return vhost_user_postcopy_listen(dev, pnd->errp);
> +
>       default:
>           /* We ignore notifications we don't know */
>           break;
