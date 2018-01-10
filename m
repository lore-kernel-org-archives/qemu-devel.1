Received: from eggs.gnu.org ([2001:4830:134:3::10]:33652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eZGZT-0004ZJ-GR
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 08:37:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eZGZS-0002cp-5P
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 08:37:35 -0500
Date: Wed, 10 Jan 2018 14:31:18 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180110143118.39b47b16@redhat.com>
In-Reply-To: <1515515975-28968-1-git-send-email-jianjay.zhou@huawei.com>
References: <1515515975-28968-1-git-send-email-jianjay.zhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 1/4] vhost: remove assertion to prevent
 crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jay Zhou <jianjay.zhou@huawei.com>
Cc: qemu-devel@nongnu.org, weidong.huang@huawei.com, mst@redhat.com, wangxinxin.wang@huawei.com, qemu-stable@nongnu.org, arei.gonglei@huawei.com, liuzhe13@huawei.com

On Wed, 10 Jan 2018 00:39:35 +0800
Jay Zhou <jianjay.zhou@huawei.com> wrote:

> Start QEMU with more DIMM devices than limit but without any
> vhost backends and then hotplug a vhost user backend, the VM
> will be crashed.
> Instead of asserting in vhost_user_set_mem_table(), error number
> is used to gracefully prevent device to start. This fixes the
> crash issue.

I'd rewrite commit message as following:
--
QEMU will assert on vhsot-user backed virtio device hotplug
if QEMU is using more RAM regions than VHOST_MEMORY_MAX_NREGIONS
(for example if it  were started with a lot of DIMM devices).

Fix it by returning error instead of asserting and let
callers of vhost_set_mem_table() handle error condition
gracefully.
--

>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
> ---
>  hw/virtio/vhost-user.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 093675e..8500562 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -317,11 +317,14 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
>                                       &offset);
>          fd = memory_region_get_fd(mr);
>          if (fd > 0) {
> +            if (fd_num == VHOST_MEMORY_MAX_NREGIONS) {
> +                error_report("Failed preparing vhost-user memory table msg");
> +                return -1;
> +            }
>              msg.payload.memory.regions[fd_num].userspace_addr = reg->userspace_addr;
>              msg.payload.memory.regions[fd_num].memory_size  = reg->memory_size;
>              msg.payload.memory.regions[fd_num].guest_phys_addr = reg->guest_phys_addr;
>              msg.payload.memory.regions[fd_num].mmap_offset = offset;
> -            assert(fd_num < VHOST_MEMORY_MAX_NREGIONS);
>              fds[fd_num++] = fd;
>          }
>      }
