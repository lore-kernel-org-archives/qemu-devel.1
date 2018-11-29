Received: from eggs.gnu.org ([2001:4830:134:3::10]:35822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gSDEy-0004ji-Ui
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 22:43:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gSDEx-0005tC-UM
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 22:43:48 -0500
MIME-Version: 1.0
References: <20181129031230.31082-1-jasowang@redhat.com>
	<20181129031230.31082-2-jasowang@redhat.com>
In-Reply-To: <20181129031230.31082-2-jasowang@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 29 Nov 2018 11:43:10 +0800
Message-ID: <CAKXe6SLMOoMD3s_G9f7W0EiwOXM=LmUTWXGrae1p29A_tUqHzA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 3.1 1/4] net: drop too large packet
 early
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, mst@redhat.com, P J P <ppandit@redhat.com>, =?UTF-8?B?5p2O5by6?= <liq3ea@163.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org

Jason Wang <jasowang@redhat.com> =E4=BA=8E2018=E5=B9=B411=E6=9C=8829=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8811:12=E5=86=99=E9=81=93=EF=BC=9A

> We try to detect and drop too large packet (>INT_MAX) in 1592a9947036
> ("net: ignore packet size greater than INT_MAX") during packet
> delivering. Unfortunately, this is not sufficient as we may hit
> another integer overflow when trying to queue such large packet in
> qemu_net_queue_append_iov():
>
> - size of the allocation may overflow on 32bit
> - packet->size is integer which may overflow even on 64bit
>
> Fixing this by move the check to qemu_sendv_packet_async() which is
> the entrance of all networking codes and reduce the limit to
> NET_BUFSIZE to be more conservative.
>
> Cc: qemu-stable@nongnu.org
> Cc: Li Qiang <liq3ea@163.com>
> Reported-by: Li Qiang <liq3ea@gmail.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
>

Looks ok to me.

Reviewed-by: Li Qiang <liq3ea@gmail.com>


> ---
>  net/net.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/net/net.c b/net/net.c
> index 07c194a8f6..affe1877cf 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -712,15 +712,11 @@ ssize_t qemu_deliver_packet_iov(NetClientState
> *sender,
>                                  void *opaque)
>  {
>      NetClientState *nc =3D opaque;
> -    size_t size =3D iov_size(iov, iovcnt);
>      int ret;
>
> -    if (size > INT_MAX) {
> -        return size;
> -    }
>
>      if (nc->link_down) {
> -        return size;
> +        return iov_size(iov, iovcnt);
>      }
>
>      if (nc->receive_disabled) {
> @@ -745,10 +741,15 @@ ssize_t qemu_sendv_packet_async(NetClientState
> *sender,
>                                  NetPacketSent *sent_cb)
>  {
>      NetQueue *queue;
> +    size_t size =3D iov_size(iov, iovcnt);
>      int ret;
>
> +    if (size > NET_BUFSIZE) {
> +        return size;
> +    }
> +
>      if (sender->link_down || !sender->peer) {
> -        return iov_size(iov, iovcnt);
> +        return size;
>      }
>
>      /* Let filters handle the packet first */
> --
> 2.17.1
>
>
