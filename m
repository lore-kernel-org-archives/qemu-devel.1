Received: from eggs.gnu.org ([2001:4830:134:3::10]:46572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dXjlA-0000M8-GA
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:51:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dXjl6-0003H4-Gm
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:51:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dXjl6-0003Gw-9r
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:51:00 -0400
Date: Wed, 19 Jul 2017 09:50:58 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170719095058.4d46359d@Igors-MacBook-Pro.local>
In-Reply-To: <1500477452-59643-1-git-send-email-peng.hao2@zte.com.cn>
References: <1500477452-59643-1-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vhost: fix a migration failed because of
 vhost region merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>
Cc: mst@redhat.com, Wang Yechao <wang.yechao255@zte.com.cn>, qemu-devel@nongnu.org

On Wed, 19 Jul 2017 23:17:32 +0800
Peng Hao <peng.hao2@zte.com.cn> wrote:

> When a guest that has several hotplugged dimms is migrated, in
> destination host it will fail to resume. Because vhost regions of
> several dimms in source host are merged and in the restore stage
> in destination host it computes whether more than vhost slot limit
> before merging vhost regions of several dimms.
could you provide a bit more detailed description of the problem
including command line+used device_add commands on source and
command line on destination?

> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
> ---
>  hw/mem/pc-dimm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index ea67b46..bb0fa08 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -101,7 +101,7 @@ void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplugState *hpms,
>          goto out;
>      }
>  
> -    if (!vhost_has_free_slot()) {
> +    if (!vhost_has_free_slot() && runstate_is_running()) {
>          error_setg(&local_err, "a used vhost backend has no free"
>                                 " memory slots left");
>          goto out;
