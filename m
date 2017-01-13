Received: from eggs.gnu.org ([2001:4830:134:3::10]:35841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cS3ON-0001uE-Ao
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 10:03:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cS3OH-0005yt-JT
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 10:03:47 -0500
Received: from mx5-phx2.redhat.com ([209.132.183.37]:43824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1cS3OH-0005yj-A5
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 10:03:41 -0500
Date: Fri, 13 Jan 2017 10:03:39 -0500 (EST)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>
Message-ID: <1587720065.2308546.1484319819288.JavaMail.zimbra@redhat.com>
In-Reply-To: <1484270047-24579-1-git-send-email-felipe@nutanix.com>
References: <1484270047-24579-1-git-send-email-felipe@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] libvhost-user: Start VQs on SET_VRING_CALL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Felipe Franciosi <felipe@nutanix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Marc-Andre Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Hi

----- Original Message -----
> Currently, VQs are started as soon as a SET_VRING_KICK is received. That
> is too early in the VQ setup process, as the backend might not yet have

I think we may want to reconsider queue_set_started(), move it elsewhere, since kick/call fds aren't mandatory to process the rings.

> a callfd to notify in case it received a kick and fully processed the
> request/command. This patch only starts a VQ when a SET_VRING_CALL is
> received.

I don't like that much, as soon as the kick fd is received, it should start polling it imho. callfd is optional, it may have one and not the other.

Perhaps it's best for now to delay the callfd notification with a flag until it is received?


> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
> ---
>  contrib/libvhost-user/libvhost-user.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/contrib/libvhost-user/libvhost-user.c
> b/contrib/libvhost-user/libvhost-user.c
> index af4faad..a46ef90 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -607,19 +607,6 @@ vu_set_vring_kick_exec(VuDev *dev, VhostUserMsg *vmsg)
>          DPRINT("Got kick_fd: %d for vq: %d\n", vmsg->fds[0], index);
>      }
>  
> -    dev->vq[index].started = true;
> -    if (dev->iface->queue_set_started) {
> -        dev->iface->queue_set_started(dev, index, true);
> -    }
> -
> -    if (dev->vq[index].kick_fd != -1 && dev->vq[index].handler) {
> -        dev->set_watch(dev, dev->vq[index].kick_fd, VU_WATCH_IN,
> -                       vu_kick_cb, (void *)(long)index);
> -
> -        DPRINT("Waiting for kicks on fd: %d for vq: %d\n",
> -               dev->vq[index].kick_fd, index);
> -    }
> -
>      return false;
>  }
>  
> @@ -661,6 +648,19 @@ vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *vmsg)
>  
>      DPRINT("Got call_fd: %d for vq: %d\n", vmsg->fds[0], index);
>  
> +    dev->vq[index].started = true;
> +    if (dev->iface->queue_set_started) {
> +        dev->iface->queue_set_started(dev, index, true);
> +    }
> +
> +    if (dev->vq[index].kick_fd != -1 && dev->vq[index].handler) {
> +        dev->set_watch(dev, dev->vq[index].kick_fd, VU_WATCH_IN,
> +                       vu_kick_cb, (void *)(long)index);
> +
> +        DPRINT("Waiting for kicks on fd: %d for vq: %d\n",
> +               dev->vq[index].kick_fd, index);
> +    }
> +
>      return false;
>  }
>  
> --
> 1.9.4
> 
> 
