Received: from eggs.gnu.org ([2001:4830:134:3::10]:51526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gTsiv-0007my-2o
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 13:13:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gTsiq-0005cA-4g
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 13:13:37 -0500
References: <20181203100608.28538-1-jasowang@redhat.com>
	<20181203100608.28538-2-jasowang@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <04574bda-cac5-3faa-20a5-e192bded4b77@redhat.com>
Date: Mon, 3 Dec 2018 19:13:24 +0100
MIME-Version: 1.0
In-Reply-To: <20181203100608.28538-2-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V4 for 3.1 1/4] net: drop too large packet
 early
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: mst@redhat.com, liq3ea@163.com, liq3ea@gmail.com, qemu-stable@nongnu.org, ppandit@redhat.com, pbonzini@redhat.com, Eric Blake <eblake@redhat.com>

On 2018-12-03 11:06, Jason Wang wrote:
> We try to detect and drop too large packet (>INT_MAX) in 1592a9947036
> ("net: ignore packet size greater than INT_MAX") during packet
> delivering. Unfortunately, this is not sufficient as we may hit
> another integer overflow when trying to queue such large packet in
> qemu_net_queue_append_iov():
>=20
> - size of the allocation may overflow on 32bit
> - packet->size is integer which may overflow even on 64bit
>=20
> Fixing this by move the check to qemu_sendv_packet_async() which is
> the entrance of all networking codes and reduce the limit to
> NET_BUFSIZE to be more conservative.
>=20
> Cc: qemu-stable@nongnu.org
> Cc: Li Qiang <liq3ea@163.com>
> Reported-by: Li Qiang <liq3ea@gmail.com>
> Reviewed-by: Li Qiang <liq3ea@gmail.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  net/net.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

Since this is a critical patch for rc4, here's a verbose review...

> diff --git a/net/net.c b/net/net.c
> index 07c194a8f6..affe1877cf 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -712,15 +712,11 @@ ssize_t qemu_deliver_packet_iov(NetClientState *s=
ender,
>                                  void *opaque)
>  {
>      NetClientState *nc =3D opaque;
> -    size_t size =3D iov_size(iov, iovcnt);
>      int ret;
> =20
> -    if (size > INT_MAX) {
> -        return size;
> -    }
> =20
>      if (nc->link_down) {
> -        return size;
> +        return iov_size(iov, iovcnt);
>      }

In case you respin this patch again, please make
qemu_deliver_packet_iov() "static", so that it is clear that it can not
be called directly from the outside anymore. And in case there is no
need to respin, please consider to send a separate patch for 4.0 instead.

Ok, thinking now load about the call chain:

Anyway, qemu_deliver_packet_iov is not directly called from any other
file currently, so this is ok ...

So let's see how it is used in net.c ... it's only used as paramter
here: qemu_new_net_queue(qemu_deliver_packet_iov, nc) ...
qemu_new_net_queue() assigns it to NetQueue->deliver which is only used
within queue.c.

Functions using that ->deliver function pointer are the static functions
qemu_net_queue_deliver() and qemu_net_queue_deliver_iov(). First one
only uses one iov, so I don't think we can overflow the size here.
Second one is used in turn are used by the public function
qemu_net_queue_send_iov(). This has two callers, one in net.c in
qemu_sendv_packet_async() which you guard below =3D=3D> OK.
The other caller is in qemu_netfilter_pass_to_next() in filter.c - and
this function is called from many more other places ... but as far as I
can see, these don't call it in a way where the size could overflow.

=3D=3D> Removing the check in qemu_deliver_packet_iov() sounds ok to me, =
if
it is checked in qemu_sendv_packet_async() instead.

>      if (nc->receive_disabled) {
> @@ -745,10 +741,15 @@ ssize_t qemu_sendv_packet_async(NetClientState *s=
ender,
>                                  NetPacketSent *sent_cb)
>  {
>      NetQueue *queue;
> +    size_t size =3D iov_size(iov, iovcnt);
>      int ret;
> =20
> +    if (size > NET_BUFSIZE) {
> +        return size;
> +    }

It's a little bit unfortunate that the unsigned size will be cast to
ssize_t, so a very large size could suddenly change sign. But as Eric
already wrote in his mail, it seems like the callers are either ignoring
the return value, or just checking for !=3D 0, so it should be ok for now=
.

To be more consistent, maybe it would be better to always return an
negative error code here instead?

>      if (sender->link_down || !sender->peer) {
> -        return iov_size(iov, iovcnt);
> +        return size;
>      }
> =20
>      /* Let filters handle the packet first */
>=20

I think I'm fine if this patch is applied in its current shape for rc4, s=
o:

Reviewed-by: Thomas Huth <thuth@redhat.com>

... but please consider some follow-up patches to make
qemu_deliver_packet_iov() static, and maybe to return an error code in
qemu_sendv_packet_async() instead.
