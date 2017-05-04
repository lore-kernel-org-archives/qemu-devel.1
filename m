Received: from eggs.gnu.org ([2001:4830:134:3::10]:60634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1d6Fyg-0004pW-RQ
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:35:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1d6Fyf-0006Ww-OH
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:35:26 -0400
Date: Thu, 4 May 2017 14:34:58 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20170504123458.sehggkxpci3w2emq@kamzik.brq.redhat.com>
References: <1493816238-33120-1-git-send-email-imammedo@redhat.com>
	<1493816238-33120-19-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1493816238-33120-19-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 18/24] numa: remove no longer used
 numa_get_node_for_cpu()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org

On Wed, May 03, 2017 at 02:57:12PM +0200, Igor Mammedov wrote:
> it's been replaced by fetching mapping info from possible_cpus
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  include/sysemu/numa.h |  4 ----
>  numa.c                | 14 --------------
>  2 files changed, 18 deletions(-)
> 
> diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
> index 98d01e6..9077bb2 100644
> --- a/include/sysemu/numa.h
> +++ b/include/sysemu/numa.h
> @@ -32,10 +32,6 @@ void numa_set_mem_node_id(ram_addr_t addr, uint64_t size, uint32_t node);
>  void numa_unset_mem_node_id(ram_addr_t addr, uint64_t size, uint32_t node);
>  uint32_t numa_get_node(ram_addr_t addr, Error **errp);
>  
> -/* on success returns node index in numa_info,
> - * on failure returns nb_numa_nodes */
> -int numa_get_node_for_cpu(int idx);
> -
>  static inline bool numa_has_node_id(const CPUArchIdList *possible_cpus, int idx)
>  {
>      return possible_cpus->cpus[idx].props.has_node_id;
> diff --git a/numa.c b/numa.c
> index 872ee0d..06c42e9 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -583,20 +583,6 @@ MemdevList *qmp_query_memdev(Error **errp)
>      return list;
>  }
>  
> -int numa_get_node_for_cpu(int idx)
> -{
> -    int i;
> -
> -    assert(idx < max_cpus);
> -
> -    for (i = 0; i < nb_numa_nodes; i++) {
> -        if (test_bit(idx, numa_info[i].node_cpu)) {
> -            break;
> -        }
> -    }
> -    return i;
> -}
> -
>  void ram_block_notifier_add(RAMBlockNotifier *n)
>  {
>      QLIST_INSERT_HEAD(&ram_list.ramblock_notifiers, n, next);
> -- 
> 2.7.4
>

Reviewed-by: Andrew Jones <drjones@redhat.com> 
