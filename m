Received: from eggs.gnu.org ([2001:4830:134:3::10]:57902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1d5oCq-0003Nn-16
	for qemu-devel@nongnu.org; Wed, 03 May 2017 02:56:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1d5oCm-0001FV-V4
	for qemu-devel@nongnu.org; Wed, 03 May 2017 02:56:12 -0400
References: <20170502162955.1610-1-lvivier@redhat.com>
	<20170502162955.1610-2-lvivier@redhat.com>
	<20170502200903.GE3482@thinpad.lan.raisama.net>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <a3a0a0c8-6eb5-c3ac-2eec-8e7eecaf1d25@redhat.com>
Date: Wed, 3 May 2017 08:56:04 +0200
MIME-Version: 1.0
In-Reply-To: <20170502200903.GE3482@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 1/1] numa: equally distribute memory on
 nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On 02/05/2017 22:09, Eduardo Habkost wrote:
> On Tue, May 02, 2017 at 06:29:55PM +0200, Laurent Vivier wrote:
> [...]
>> diff --git a/numa.c b/numa.c
>> index 6fc2393..750fd95 100644
>> --- a/numa.c
>> +++ b/numa.c
>> @@ -294,6 +294,42 @@ static void validate_numa_cpus(void)
>>      g_free(seen_cpus);
>>  }
>>  
>> +void numa_legacy_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
>> +                                 int nb_nodes, ram_addr_t size)
>> +{
>> +    int i;
>> +    uint64_t usedmem = 0;
>> +
>> +    /* Align each node according to the alignment
>> +     * requirements of the machine class
>> +     */
>> +
>> +    for (i = 0; i < nb_nodes - 1; i++) {
>> +        nodes[i].node_mem = (size / nb_nodes) &
>> +                            ~((1 << mc->numa_mem_align_shift) - 1);
>> +        usedmem += nodes[i].node_mem;
>> +    }
>> +    nodes[i].node_mem = size - usedmem;
>> +}
>> +
>> +void numa_default_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
>> +                                  int nb_nodes, ram_addr_t size)
>> +{
>> +    int i;
>> +    uint64_t usedmem = 0, node_mem;
>> +    uint64_t granularity = size / nb_nodes;
>> +    uint64_t propagate = 0;
>> +
>> +    for (i = 0; i < nb_nodes - 1; i++) {
>> +        node_mem = (granularity + propagate) &
>> +                   ~((1 << mc->numa_mem_align_shift) - 1);
>> +        propagate = granularity + propagate - node_mem;
>> +        nodes[i].node_mem = node_mem;
>> +        usedmem += node_mem;
>> +    }
>> +    nodes[i].node_mem = ram_size - usedmem;
> 
> I believe you meant 'size - usedmem' here.
> 
> I can fix this while applying the patch, if that's OK. The rest
> of the patch looks good to me.

Yes, you're right. You can fix this and apply.

Thanks,
Laurent
