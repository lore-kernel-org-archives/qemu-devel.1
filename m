Received: from eggs.gnu.org ([209.51.188.92]:57684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjAlW-0007cR-PA
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 17:31:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjAfX-0002PC-VD
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 17:25:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:64123)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjAfX-0002Oz-Lj
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 17:25:19 -0500
Date: Mon, 14 Jan 2019 17:25:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190114172157-mutt-send-email-mst@kernel.org>
References: <20190109112728.9214-1-xieyongji@baidu.com>
	<20190109112728.9214-3-xieyongji@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109112728.9214-3-xieyongji@baidu.com>
Subject: Re: [Qemu-devel] [PATCH v4 for-4.0 2/7] vhost-user: Support
 transferring inflight buffer between qemu and backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: elohimes@gmail.com
Cc: marcandre.lureau@redhat.com, berrange@redhat.com, jasowang@redhat.com, maxime.coquelin@redhat.com, yury-kotov@yandex-team.ru, wrfsh@yandex-team.ru, qemu-devel@nongnu.org, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>

On Wed, Jan 09, 2019 at 07:27:23PM +0800, elohimes@gmail.com wrote:
> @@ -382,6 +397,30 @@ If VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD protocol feature is negotiated,
>  slave can send file descriptors (at most 8 descriptors in each message)
>  to master via ancillary data using this fd communication channel.
>  
> +Inflight I/O tracking
> +---------------------
> +
> +To support slave reconnecting, slave need to track inflight I/O in a
> +shared memory. VHOST_USER_GET_INFLIGHT_FD and VHOST_USER_SET_INFLIGHT_FD
> +are used to transfer the memory between master and slave. And to encourage
> +consistency, we provide a recommended format for this memory:

I think we should make a stronger statement and actually
just say what the format is. Not recommend it weakly.

> +
> +offset	 width	  description
> +0x0      0x400    region for queue0
> +0x400    0x400    region for queue1
> +0x800    0x400    region for queue2
> +...      ...      ...
> +
> +For each virtqueue, we have a 1024 bytes region.


Why is the size hardcoded? Why not a function of VQ size?


> The region's format is like:
> +
> +offset   width    description
> +0x0      0x1      descriptor 0 is in use or not
> +0x1      0x1      descriptor 1 is in use or not
> +0x2      0x1      descriptor 2 is in use or not
> +...      ...      ...
> +
> +For each descriptor, we use one byte to specify whether it's in use or not.
> +
>  Protocol features
>  -----------------
> 

I think that it's a good idea to have a version in this region.
Otherwise how are you going to handle compatibility when
this needs to be extended?



 
