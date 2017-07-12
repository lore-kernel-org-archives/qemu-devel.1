Received: from eggs.gnu.org ([2001:4830:134:3::10]:35300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dVK8z-0006Wo-DX
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:05:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dVK8v-0000D4-Ds
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:05:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1dVK8v-0000CL-7E
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:05:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0E492C04B93E
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 16:05:36 +0000 (UTC)
References: <20170712094149.23069-1-jfreimann@redhat.com>
	<20170712094149.23069-4-jfreimann@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <aab05543-5580-4dbb-a511-669e692e9778@redhat.com>
Date: Wed, 12 Jul 2017 18:05:20 +0200
MIME-Version: 1.0
In-Reply-To: <20170712094149.23069-4-jfreimann@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 3/3] libvhost-user: quit when no more
 data received
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jens Freimann <jfreimann@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mst@redhat.com, victork@redhat.com



On 07/12/2017 11:41 AM, Jens Freimann wrote:
> From: Jens Freimann<jfreiman@redhat.com>
> 
> When recvmsg() returns a message size of zero and
> errno is ENOENT end processing of vhost-user messages.
> 
> Without this we run into a vubr_panic() call and get
>       PANIC: Error while recvmsg: No such file or directory
>       Error while dispatching.
> 
> Add a switch "quit" to the vhost user device and set true to stop
> processing messages.
> 
> Signed-off-by: Jens Freimann<jfreiman@redhat.com>
> ---
>   contrib/libvhost-user/libvhost-user.c | 12 +++++++++++-
>   contrib/libvhost-user/libvhost-user.h |  1 +
>   2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
> index 9efb9da..5538859 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -161,7 +161,10 @@ vu_message_read(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
>           rc = recvmsg(conn_fd, &msg, 0);
>       } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
>   
> -    if (rc <= 0) {
> +    if (rc == 0 && (errno == ENOENT)) {
> +        vmsg->size = 0;
> +        dev->quit = true;
> +    } else if (rc < 0) {
>           vu_panic(dev, "Error while recvmsg: %s", strerror(errno));
>           return false;
>       }
> @@ -755,6 +758,10 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
>       DPRINT("Flags:   0x%x\n", vmsg->flags);
>       DPRINT("Size:    %d\n", vmsg->size);
>   
> +    if (dev->quit) {
> +        return true;
> +    }
> +

You may want to return false here, as true means a reply is requested?

Maxime
