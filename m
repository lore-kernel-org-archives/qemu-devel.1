Received: from eggs.gnu.org ([2001:4830:134:3::10]:60622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eZIYN-0004GJ-HG
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 10:44:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eZIYK-0002M3-FK
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 10:44:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eZIYK-0002LZ-8y
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 10:44:32 -0500
Date: Wed, 10 Jan 2018 15:44:26 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180110154426.GJ3205@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20180110153924.17391-1-edgar.kaziakhmedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180110153924.17391-1-edgar.kaziakhmedov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/1] io/channel-websock: handle
 continuous reads without any data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, den@openvz.org

On Wed, Jan 10, 2018 at 06:39:24PM +0300, Edgar Kaziakhmedov wrote:
> According to the current implementation of websocket protocol in QEMU,
> qio_channel_websock_handshake_io tries to read handshake from the
> channel to start communication over socket. But this approach
> doesn't cover scenario when socket was closed while handshaking.
> Therefore, if G_IO_IN is caught and qio_channel_read returns zero,
> error has to be set and connection has to be done.
> 
> Such behaviour causes 100% CPU load in main QEMU loop, because main loop
> poll continues to receive and handle G_IO_IN events from websocket.
> 
> Step to reproduce 100% CPU load:
> 1) start qemu with the simplest configuration
> $ qemu -vnc [::1]:1,websocket=7500
> 2) open any vnc listener (which doesn't follow websocket
> protocol)
> $ vncviewer :7500
> 3) kill listener
> 4) qemu main thread eats 100% CPU
> 
> Signed-off-by: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
> ---
>  io/channel-websock.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Thanks, I have queued this patch.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
