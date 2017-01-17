Received: from eggs.gnu.org ([2001:4830:134:3::10]:59490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTa4F-0003qu-Un
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 15:09:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTa4C-0000D6-MP
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 15:09:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37620)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTa4C-0000Cj-Gk
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 15:09:16 -0500
Date: Tue, 17 Jan 2017 18:09:13 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170117200913.GO3491@thinpad.lan.raisama.net>
References: <1484664152-24446-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<1484664152-24446-2-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484664152-24446-2-git-send-email-douly.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] vl: Ensure the numa_post_machine_init
 func in the appropriate location
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: stefanha@redhat.com, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com, fanc.fnst@cn.fujitsu.com

On Tue, Jan 17, 2017 at 10:42:31PM +0800, Dou Liyang wrote:
> In the numa_post_machine_init(), we use CPU_FOREACH macro to set all
> CPUs' namu_node. So, we should make sure that we call it after Qemu
> has already initialied all the CPUs.
> 
> As we all know, the CPUs can be created by "-smp"(pc_new_cpu) or
> "-device"(qdev_device_add) command. But, before the device init,
> Qemu execute the numa_post_machine_init earlier. It makes the mapping
> of NUMA nodes and CPUs incorrect.
> 
> The patch move the numa_post_machine_init func in the appropriate
> location.
> 
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>

I would like to move cpu_index initialization to
qom/cpu.c:cpu_common_realizefn(), and remove
numa_post_machine_init() completely. But this fixes the bug while
we don't do that.

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Queued on numa-next. Thanks!

> ---
>  vl.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/vl.c b/vl.c
> index c643d3f..f38b0e2 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4549,8 +4549,6 @@ int main(int argc, char **argv, char **envp)
>  
>      cpu_synchronize_all_post_init();
>  
> -    numa_post_machine_init();
> -
>      if (qemu_opts_foreach(qemu_find_opts("fw_cfg"),
>                            parse_fw_cfg, fw_cfg_find(), NULL) != 0) {
>          exit(1);
> @@ -4571,6 +4569,9 @@ int main(int argc, char **argv, char **envp)
>                            device_init_func, NULL, NULL)) {
>          exit(1);
>      }
> +
> +    numa_post_machine_init();
> +
>      rom_reset_order_override();
>  
>      /* Did we create any drives that we failed to create a device for? */
> -- 
> 2.5.5
> 
> 
> 

-- 
Eduardo
