Received: from eggs.gnu.org ([2001:4830:134:3::10]:33591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eqglD-0007Ds-EH
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:01:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eqgl7-0003CO-Ps
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:01:43 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42038 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eqgl7-0003AM-Kj
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:01:37 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6238D8D6D0
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 15:01:33 +0000 (UTC)
Date: Tue, 27 Feb 2018 17:01:28 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180227165057-mutt-send-email-mst@kernel.org>
References: <20180216172910.8549-1-maxime.coquelin@redhat.com>
	<20180216172910.8549-3-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216172910.8549-3-maxime.coquelin@redhat.com>
Subject: Re: [Qemu-devel] [RFC 2/5] vhost-user: Introduce new request to
 send virtio device status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: stefanha@redhat.com, mlureau@redhat.com, qemu-devel@nongnu.org

On Fri, Feb 16, 2018 at 06:29:07PM +0100, Maxime Coquelin wrote:
> diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
> index 9fcf48d611..daa452bd36 100644
> --- a/docs/interop/vhost-user.txt
> +++ b/docs/interop/vhost-user.txt
> @@ -368,6 +368,7 @@ Protocol features
>  #define VHOST_USER_PROTOCOL_F_MTU            4
>  #define VHOST_USER_PROTOCOL_F_SLAVE_REQ      5
>  #define VHOST_USER_PROTOCOL_F_CROSS_ENDIAN   6
> +#define VHOST_USER_PROTOCOL_F_VIRTIO_STATUS  7
>  
>  Master message types
>  --------------------
> @@ -663,6 +664,19 @@ Master message types
>        field, and slaves MUST NOT accept SET_CONFIG for read-only
>        configuration space fields unless the live migration bit is set.
>  
> +* VHOST_USER_SET_VIRTIO_STATUS
> +
> +      Id: 26
> +      Equivalent ioctl: N/A
> +      Master payload: u64
> +      Slave payload: N/A
> +
> +      Sent by the vhost-user master to notify of virtio device status change.
> +      The payload is a u64 representing the virtio device status as defined in
> +      the virtio specification.
> +      The request should be sent only when VHOST_USER_PROTOCOL_F_VIRTIO_STATUS
> +      protocol feature has been negotiated.
> +
>  Slave message types
>  -------------------
>  

So for now backend was only activated after DRIVER_OK. Does this message
mean that we must send updates such as _DRIVER as well?

Further, this is kind of one-way, but there are several cases where device
modifies the status.  One is NEEDS_RESET. Another is clearing
of FEATURES_OK.


-- 
MST
