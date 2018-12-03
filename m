Received: from eggs.gnu.org ([2001:4830:134:3::10]:39095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gTqvR-0005wf-4U
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:18:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gTqvO-0002oJ-9c
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:18:25 -0500
References: <20181203100608.28538-1-jasowang@redhat.com>
	<20181203100608.28538-2-jasowang@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7a639e00-105f-cf6d-5198-9c6e022bf29d@redhat.com>
Date: Mon, 3 Dec 2018 10:18:15 -0600
MIME-Version: 1.0
In-Reply-To: <20181203100608.28538-2-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: mst@redhat.com, ppandit@redhat.com, liq3ea@163.com, liq3ea@gmail.com, pbonzini@redhat.com, thuth@redhat.com, qemu-stable@nongnu.org

On 12/3/18 4:06 AM, Jason Wang wrote:
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

s/move/moving/

> the entrance of all networking codes and reduce the limit to
> NET_BUFSIZE to be more conservative.

Please mention commit 1592a994 in the commit message (since you are 
effectively reverting that with this as its replacement), and if this is 
(as I suspect) an additional patch required for the complete fix to 
CVE-2018-10839, also mention that.

> 
> Cc: qemu-stable@nongnu.org
> Cc: Li Qiang <liq3ea@163.com>
> Reported-by: Li Qiang <liq3ea@gmail.com>
> Reviewed-by: Li Qiang <liq3ea@gmail.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>   net/net.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/net/net.c b/net/net.c
> index 07c194a8f6..affe1877cf 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -712,15 +712,11 @@ ssize_t qemu_deliver_packet_iov(NetClientState *sender,
>                                   void *opaque)
>   {
>       NetClientState *nc = opaque;
> -    size_t size = iov_size(iov, iovcnt);
>       int ret;
>   
> -    if (size > INT_MAX) {
> -        return size;
> -    }
>   
>       if (nc->link_down) {
> -        return size;
> +        return iov_size(iov, iovcnt);

Reverts 1592a994, and...

>       }
>   
>       if (nc->receive_disabled) {
> @@ -745,10 +741,15 @@ ssize_t qemu_sendv_packet_async(NetClientState *sender,
>                                   NetPacketSent *sent_cb)
>   {
>       NetQueue *queue;
> +    size_t size = iov_size(iov, iovcnt);
>       int ret;
>   
> +    if (size > NET_BUFSIZE) {
> +        return size;
> +    }

...returns early for packets larger than 68k (a much smaller limit than 
INT_MAX, which makes analysis for int overflow a lot easier) at a saner 
point in the code.  Returning a large value is weird, but auditing all 
callers:

hw/net/virtio-net.c:        ret = 
qemu_sendv_packet_async(qemu_get_subqueue(n->nic, queue_index),
  - only checks if ret is 0 (returns -EBUSY) or not (assumes packet was 
sent)
net/netmap.c:        iovsize = qemu_sendv_packet_async(&s->nc, s->iov, 
iovcnt,
  - only checks if ret is 0 (starts polling) or not (assumes packet was 
sent)
net/net.c:    return qemu_sendv_packet_async(nc, iov, iovcnt, NULL);
  - implementation of qemu_sendv_packet() - so we have to audit those 
callers as well:

hw/net/net_tx_pkt.c:        qemu_sendv_packet(nc, iov, iov_cnt);
hw/net/rocker/rocker_fp.c:        qemu_sendv_packet(nc, iov, iovcnt);
hw/net/rtl8139.c:            qemu_sendv_packet(qemu_get_queue(s->nic), 
iov, 3);
net/hub.c:        qemu_sendv_packet(&port->nc, iov, iovcnt);
- all four of these do not check the return status

So, it looks like none of the callers cares if the return value is 
overlarge (no further math on the values), just that it is non-zero 
(where the callers then presumably assume the packet was sent). 
However, I am not familiar enough with the code to know if skipping the 
packet by returning a non-zero value is going to have knock-on effects - 
that is, my audit shows what the callers do, but not whether it was sane.

> +
>       if (sender->link_down || !sender->peer) {
> -        return iov_size(iov, iovcnt);
> +        return size;
>       }

If this is indeed CVE fixing, then we want it in -rc4, but I don't know 
if the patch is correctly secure yet without answers to my questions. 
Especially on a CVE fix for -rc4, you want to make the reviewer's life 
as easy as possible by providing a commit message that includes enough 
details to make analysis easy.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
