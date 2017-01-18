Received: from eggs.gnu.org ([2001:4830:134:3::10]:45157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTpnC-000326-HA
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 07:56:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTpn8-00054o-0K
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 07:56:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTpn7-00054d-Q0
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 07:56:41 -0500
Date: Wed, 18 Jan 2017 10:56:38 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170118125638.GV3491@thinpad.lan.raisama.net>
References: <1484743207-10721-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<1484743207-10721-3-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484743207-10721-3-git-send-email-douly.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] numa: Remove the
 numa_post_machine_init function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org, vilanova@ac.upc.edu, izumi.taku@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com, fanc.fnst@cn.fujitsu.com

On Wed, Jan 18, 2017 at 08:40:06PM +0800, Dou Liyang wrote:
> Current default way of seting the CPUState::numa_node in the
> numa_post_machine_init() and calling it in vl.c:main() would
> make the data incorrect in case on cold/hot-plug CPUs.
> 
> Now, we move it to the qom/cpu.c:cpu_common_realizefn().
> So, Here we remove it.
> 
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>


Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Can be squashed in patch 1/3.

> ---
>  include/sysemu/numa.h |  1 -
>  numa.c                | 15 ---------------
>  vl.c                  |  2 --
>  3 files changed, 18 deletions(-)
> 
> diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
> index 8f09dcf..b8015a5 100644
> --- a/include/sysemu/numa.h
> +++ b/include/sysemu/numa.h
> @@ -25,7 +25,6 @@ typedef struct node_info {
>  
>  extern NodeInfo numa_info[MAX_NODES];
>  void parse_numa_opts(MachineClass *mc);
> -void numa_post_machine_init(void);
>  void query_numa_node_mem(uint64_t node_mem[]);
>  extern QemuOptsList qemu_numa_opts;
>  void numa_set_mem_node_id(ram_addr_t addr, uint64_t size, uint32_t node);
> diff --git a/numa.c b/numa.c
> index 379bc8a..5f68497 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -394,21 +394,6 @@ void parse_numa_opts(MachineClass *mc)
>      }
>  }
>  
> -void numa_post_machine_init(void)
> -{
> -    CPUState *cpu;
> -    int i;
> -
> -    CPU_FOREACH(cpu) {
> -        for (i = 0; i < nb_numa_nodes; i++) {
> -            assert(cpu->cpu_index < max_cpus);
> -            if (test_bit(cpu->cpu_index, numa_info[i].node_cpu)) {
> -                cpu->numa_node = i;
> -            }
> -        }
> -    }
> -}
> -
>  static void allocate_system_memory_nonnuma(MemoryRegion *mr, Object *owner,
>                                             const char *name,
>                                             uint64_t ram_size)
> diff --git a/vl.c b/vl.c
> index c643d3f..afe40ce 100644
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
> -- 
> 2.5.5
> 
> 
> 

-- 
Eduardo
