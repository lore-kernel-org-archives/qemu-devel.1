Received: from eggs.gnu.org ([2001:4830:134:3::10]:41669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1d6Xkw-00085S-Ew
	for qemu-devel@nongnu.org; Fri, 05 May 2017 03:34:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1d6Xks-00052l-IP
	for qemu-devel@nongnu.org; Fri, 05 May 2017 03:34:26 -0400
References: <1493363372-16861-1-git-send-email-zhiyong.yang@intel.com>
	<1493915136-19150-1-git-send-email-zhiyong.yang@intel.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <74adb9e5-a8cc-9335-3547-6c59fb74a752@redhat.com>
Date: Fri, 5 May 2017 09:34:14 +0200
MIME-Version: 1.0
In-Reply-To: <1493915136-19150-1-git-send-email-zhiyong.yang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] hw/virtio: fix vhost user fails to
 startup when MQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhiyong Yang <zhiyong.yang@intel.com>, qemu-devel@nongnu.org, mst@redhat.com
Cc: marcandre.lureau@gmail.com, qemu-stable <qemu-stable@nongnu.org>

Hi,

On 05/04/2017 06:25 PM, Zhiyong Yang wrote:
>   Qemu2.7~2.9 and vhost user for dpdk 17.02 release work together
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
> 
> Changes in V2:
> Thanks for Maxime's suggestion, if one-time request, clear the
> VHOST_USER_NEED_REPLY flag in function vhost_user_write,
> in process_message_reply(), return early, if this flag isn't set.
> 
>   hw/virtio/vhost-user.c | 21 +++++++++++++--------
>   1 file changed, 13 insertions(+), 8 deletions(-)
> 

Thanks for the quick fix, it looks good to me.
I forgot to ask you to cc qemu-stable, and reference the faulty commit:

Cc: qemu-stable@nongnu.org
Fixes: ca525ce5618b ("vhost-user: Introduce a new protocol feature 
REPLY_ACK.")

Maybe this can be amended when applied. Michael?

Other than that, feel free to add my:
Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks,
Maxime
