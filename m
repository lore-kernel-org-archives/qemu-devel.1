Received: from eggs.gnu.org ([2001:4830:134:3::10]:37158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTaGD-0000oZ-4l
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 15:21:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTaG8-0007Xf-Ha
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 15:21:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTaG8-0007X4-BI
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 15:21:36 -0500
Date: Tue, 17 Jan 2017 18:21:32 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170117202132.GP3491@thinpad.lan.raisama.net>
References: <1484664152-24446-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<1484664152-24446-3-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484664152-24446-3-git-send-email-douly.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] vl: Ensure the
 cpu_synchronize_all_post_init func in the appropriate location
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: stefanha@redhat.com, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com, fanc.fnst@cn.fujitsu.com, Igor Mammedov <imammedo@redhat.com>

On Tue, Jan 17, 2017 at 10:42:32PM +0800, Dou Liyang wrote:
> As the commit a4088c3eecb5f said, In the cpu_synchronize_all_post_init(),
> we also use CPU_FOREACH macro to set all CPUs' namu_node.

I can't find commit a4088c3eecb5f, is it the commit ID of your
previous patch on your local tree? I don't see any NUMA-related
code triggered cpu_synchronize_all_post_init().

>                                                           So, we should
> make sure that we call it after Qemu has already initialied all the CPUs.

> 
> The patch move the numa_post_machine_init func in the appropriate
> location.

This patch moves cpu_synchronize_all_post_init(), not
numa_post_machine_init(). Could you describe which bug you are
fixing, exactly? It doesn't seem to be related to NUMA.

> 
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> ---
>  vl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/vl.c b/vl.c
> index f38b0e2..75adc2a 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4547,8 +4547,6 @@ int main(int argc, char **argv, char **envp)
>  
>      audio_init();
>  
> -    cpu_synchronize_all_post_init();
> -
>      if (qemu_opts_foreach(qemu_find_opts("fw_cfg"),
>                            parse_fw_cfg, fw_cfg_find(), NULL) != 0) {
>          exit(1);
> @@ -4570,6 +4568,8 @@ int main(int argc, char **argv, char **envp)
>          exit(1);
>      }
>  
> +    cpu_synchronize_all_post_init();
> +
>      numa_post_machine_init();
>  
>      rom_reset_order_override();
> -- 
> 2.5.5
> 
> 
> 

-- 
Eduardo
