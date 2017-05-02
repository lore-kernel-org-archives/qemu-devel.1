Received: from eggs.gnu.org ([2001:4830:134:3::10]:32788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1d5WpU-0006Vo-Rq
	for qemu-devel@nongnu.org; Tue, 02 May 2017 08:22:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1d5WpP-0006BN-4c
	for qemu-devel@nongnu.org; Tue, 02 May 2017 08:22:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1d5WpO-0006AL-V1
	for qemu-devel@nongnu.org; Tue, 02 May 2017 08:22:51 -0400
References: <1493363372-16861-1-git-send-email-zhiyong.yang@intel.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <4b14ac87-f96b-0dac-73b7-b3209b01120a@redhat.com>
Date: Tue, 2 May 2017 14:22:40 +0200
MIME-Version: 1.0
In-Reply-To: <1493363372-16861-1-git-send-email-zhiyong.yang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/virtio: fix vhost user fails to startup
 when MQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhiyong Yang <zhiyong.yang@intel.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com



On 04/28/2017 09:09 AM, Zhiyong Yang wrote:
>     Qemu2.7~2.9 and vhost user for dpdk 17.02 release work together
> to cause failures of new connection when negotiating to set MQ.
> (one queue pair works well).
>     Because there exist some bugs in qemu code when introducing
> VHOST_USER_PROTOCOL_F_REPLY_ACK to qemu. When vhost_user_set_mem_table
> is invoked to deal with the vhost message VHOST_USER_SET_MEM_TABLE
> for the second time, qemu indeed doesn't send the messge (The message
> needs to be sent only once)but still will be waiting for dpdk's reply
> ack, then, qemu is always freezing, while DPDK is always waiting for
> next vhost message from qemu.
>    The patch aims to fix the bug, MQ can work well.
>    The same bug is found in function vhost_user_net_set_mtu, it is fixed
> at the same time.
>    DPDK related patch is as following:
>    http://www.dpdk.org/dev/patchwork/patch/23955/
> 
> Signed-off-by: Zhiyong Yang <zhiyong.yang@intel.com>
> ---
>   hw/virtio/vhost-user.c | 18 +++++++++++-------
>   1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 9334a8a..c2c54ce 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -205,10 +205,11 @@ static int vhost_user_write(struct vhost_dev *dev, VhostUserMsg *msg,
>       /*
>        * For non-vring specific requests, like VHOST_USER_SET_MEM_TABLE,
>        * we just need send it once in the first time. For later such
> -     * request, we just ignore it.
> +     * request, we just ignore it. In this case, return value is 1 which is
> +     * different from 0 that stands for message written successfully.
>        */
>       if (vhost_user_one_time_request(msg->request) && dev->vq_index != 0) {
> -        return 0;
> +        return 1;

I personally prefer the fix I suggested in the DPDK mail thread, as
returning a random positive value does look like a workaround:

"
I think the problem must be fixed generally and not per request.
Maybe in vhost_user_write() if one-time request, just clear the
VHOST_USER_NEED_REPLY flag. Then, in process_message_reply(), return
early if this flag isn't set.
"
