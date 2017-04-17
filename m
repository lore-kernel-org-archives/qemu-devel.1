Received: from eggs.gnu.org ([2001:4830:134:3::10]:51614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1czxMr-0004kh-FN
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 23:30:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1czxMm-0001dF-FY
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 23:30:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1czxMm-0001cK-7R
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 23:30:16 -0400
Date: Mon, 17 Apr 2017 11:29:58 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170417032958.GA16703@pxdev.xzpeter.org>
References: <20170414174056.28946-1-maxime.coquelin@redhat.com>
	<20170414174056.28946-4-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170414174056.28946-4-maxime.coquelin@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 3/4] vhost-user: add slave-req-fd support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: mst@redhat.com, marcandre.lureau@gmail.com, vkaplans@redhat.com, jasowang@redhat.com, wexu@redhat.com, yuanhan.liu@linux.intel.com, qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Fri, Apr 14, 2017 at 07:40:55PM +0200, Maxime Coquelin wrote:

[...]

> @@ -486,6 +500,18 @@ Message types
>        If VHOST_USER_PROTOCOL_F_REPLY_ACK is negotiated, slave must respond
>        with zero in case the specified MTU is valid, or non-zero otherwise.
>  
> + * VHOST_USER_SET_SLAVE_REQ_FD
> +
> +      Id: 21
> +      Equivalent ioctl: N/A
> +      Master payload: N/A
> +
> +      Set the socket file descriptor for slave initiated requests. It is passed
> +      in the ancillary data.
> +      This request should be sent only when VHOST_USER_F_PROTOCOL_FEATURES
> +      has been negotiated, and protocol feature bit VHOST_USER_PROTOCOL_F_SLAVE_REQ
> +      bit is present in VHOST_USER_GET_PROTOCOL_FEATURES.

Here, do we need to mention REPLY_ACK as well? Like:

      If VHOST_USER_PROTOCOL_F_REPLY_ACK is negotiated, slave must
      respond with zero in case the slave request channel is setup
      correctly, or non-zero otherwise.

Since I see the other two users are mentioning it.

[...]

> +static int vhost_setup_slave_channel(struct vhost_dev *dev)
> +{
> +    VhostUserMsg msg = {
> +        .request = VHOST_USER_SET_SLAVE_REQ_FD,
> +        .flags = VHOST_USER_VERSION,
> +    };
> +    struct vhost_user *u = dev->opaque;
> +    int sv[2];
> +    bool reply_supported = virtio_has_feature(dev->protocol_features,
> +                                              VHOST_USER_PROTOCOL_F_REPLY_ACK);
> +
> +    if (!virtio_has_feature(dev->protocol_features,
> +                            VHOST_USER_PROTOCOL_F_SLAVE_REQ)) {
> +        return 0;
> +    }
> +
> +    if (socketpair(PF_UNIX, SOCK_STREAM, 0, sv) == -1) {
> +        error_report("socketpair() failed");
> +        return -1;
> +    }
> +
> +    u->slave_fd = sv[0];
> +    qemu_set_fd_handler(u->slave_fd, slave_read, NULL, dev);
> +
> +    if (reply_supported) {
> +        msg.flags |= VHOST_USER_NEED_REPLY_MASK;
> +    }
> +
> +    vhost_user_write(dev, &msg, &sv[1], 1);

Do we need to close(sv[1]) afterward?

> +
> +    if (reply_supported) {
> +        return process_message_reply(dev, msg.request);

Here do we need to cleanup u->slave_fd if backend replied something
wrong? Or I guess it might be leaked.

Thanks,

> +    }
> +
> +    return 0;
> +}
> +

-- 
Peter Xu
