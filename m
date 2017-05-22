Received: from eggs.gnu.org ([2001:4830:134:3::10]:58525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dCi0Q-0007rj-TG
	for qemu-devel@nongnu.org; Mon, 22 May 2017 03:43:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dCi0N-0006TV-P4
	for qemu-devel@nongnu.org; Mon, 22 May 2017 03:43:54 -0400
Received: from [59.151.112.132] (port=32286 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dCi0M-0006S5-SF
	for qemu-devel@nongnu.org; Mon, 22 May 2017 03:43:51 -0400
References: <cover.1495018956.git.maozy.fnst@cn.fujitsu.com>
	<7b167e0f406b66ae11313d4cde04396952d0902f.1495018956.git.maozy.fnst@cn.fujitsu.com>
	<87k25dictv.fsf@dusky.pond.sub.org>
	<257627fe-8645-33fe-8f20-0f896670d59d@cn.fujitsu.com>
	<87zie54cwi.fsf@dusky.pond.sub.org>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <6a19ec06-16ac-f54b-7a34-58d3b3f88b81@cn.fujitsu.com>
Date: Mon, 22 May 2017 15:43:04 +0800
MIME-Version: 1.0
In-Reply-To: <87zie54cwi.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 1/3] net/rocker: Remove the dead error
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: jasowang@redhat.com, jiri@resnulli.us, qemu-devel@nongnu.org, f4bug@amsat.org



On 05/22/2017 02:35 PM, Markus Armbruster wrote:
> Mao Zhongyi <maozy.fnst@cn.fujitsu.com> writes:
>
>> Hi, Markus
>> Thanks for review and sorry for replying late, I was on the weekend.
>
> No need to apologize for the weekend.  I hope you enjoyed it :)
>
>> On 05/19/2017 02:24 PM, Markus Armbruster wrote:
>>> Mao Zhongyi <maozy.fnst@cn.fujitsu.com> writes:
>>>
>>>> The function of_dpa_world_alloc is a wrapper around world_alloc(), which
>>>> returns null only when g_malloc0(size_t size) does. But g_malloc0() also
>>>> is a wrapper around g_malloc0_n(1, size) that ignore the fact that
>>>> g_malloc0() of 0 bytes, it doesn't returns null. So the error handling is
>>>> dead. Similar like desc_ring_alloc(), fp_port_alloc() etc. Remove these
>>>> entirely.
>>>>
>>>> Cc: jasowang@redhat.com
>>>> Cc: jiri@resnulli.us
>>>> Cc: f4bug@amsat.org
>>>> Cc: armbru@redhat.com
>>>> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
>>>> ---
>>>>  hw/net/rocker/rocker.c      | 32 --------------------------------
>>>>  hw/net/rocker/rocker_desc.c |  3 ---
>>>>  hw/net/rocker/rocker_fp.c   |  4 ----
>>>>  3 files changed, 39 deletions(-)
>>>>
>>>> diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
>>>> index 6e70fdd..b2b6dc7 100644
>>>> --- a/hw/net/rocker/rocker.c
>>>> +++ b/hw/net/rocker/rocker.c
>>>> @@ -1313,13 +1313,6 @@ static int pci_rocker_init(PCIDevice *dev)
>>>>
>>>>      r->worlds[ROCKER_WORLD_TYPE_OF_DPA] = of_dpa_world_alloc(r);
>>>>
>>>> -    for (i = 0; i < ROCKER_WORLD_TYPE_MAX; i++) {
>>>> -        if (!r->worlds[i]) {
>>>> -            err = -ENOMEM;
>>>> -            goto err_world_alloc;
>>>> -        }
>>>> -    }
>>>> -
>>>>      if (!r->world_name) {
>>>>          r->world_name = g_strdup(world_name(r->worlds[ROCKER_WORLD_TYPE_OF_DPA]));
>>>>      }
>>>
>>> Please also simplify world_alloc()
>>>
>>>    World *world_alloc(Rocker *r, size_t sizeof_private,
>>>                       enum rocker_world_type type, WorldOps *ops)
>>>    {
>>>        World *w = g_malloc0(sizeof(World) + sizeof_private);
>>>
>>>   -    if (w) {
>>>            w->r = r;
>>>            w->type = type;
>>>            w->ops = ops;
>>>            if (w->ops->init) {
>>>                w->ops->init(w);
>>>            }
>>>        }
>>>
>>>   -    return w;
>>>    }
>>
>> OK, I will fix it and search for the similar error handling from others allocation
>> functions.
>>
>>>
>>> and reindent.
>>>
>>>> @@ -1396,9 +1389,6 @@ static int pci_rocker_init(PCIDevice *dev)
>>>>      }
>>>>
>>>>      r->rings = g_new(DescRing *, rocker_pci_ring_count(r));
>>>> -    if (!r->rings) {
>>>> -        goto err_rings_alloc;
>>>> -    }
>>>>
>>>>      /* Rings are ordered like this:
>>>>       * - command ring
>>>> @@ -1410,14 +1400,9 @@ static int pci_rocker_init(PCIDevice *dev)
>>>>       * .....
>>>>       */
>>>>
>>>> -    err = -ENOMEM;
>>>>      for (i = 0; i < rocker_pci_ring_count(r); i++) {
>>>>          DescRing *ring = desc_ring_alloc(r, i);
>>>>
>>>> -        if (!ring) {
>>>> -            goto err_ring_alloc;
>>>> -        }
>>>> -
>>>>          if (i == ROCKER_RING_CMD) {
>>>>              desc_ring_set_consume(ring, cmd_consume, ROCKER_MSIX_VEC_CMD);
>>>>          } else if (i == ROCKER_RING_EVENT) {
>>>> @@ -1437,10 +1422,6 @@ static int pci_rocker_init(PCIDevice *dev)
>>>>              fp_port_alloc(r, r->name, &r->fp_start_macaddr,
>>>>                            i, &r->fp_ports_peers[i]);
>>>>
>>>> -        if (!port) {
>>>> -            goto err_port_alloc;
>>>> -        }
>>>> -
>>>>          r->fp_port[i] = port;
>>>>          fp_port_set_world(port, r->world_dflt);
>>>>      }
>>>> @@ -1449,25 +1430,12 @@ static int pci_rocker_init(PCIDevice *dev)
>>>>
>>>>      return 0;
>>>>
>>>> -err_port_alloc:
>>>> -    for (--i; i >= 0; i--) {
>>>> -        FpPort *port = r->fp_port[i];
>>>> -        fp_port_free(port);
>>>> -    }
>>>> -    i = rocker_pci_ring_count(r);
>>>> -err_ring_alloc:
>>>> -    for (--i; i >= 0; i--) {
>>>> -        desc_ring_free(r->rings[i]);
>>>> -    }
>>>> -    g_free(r->rings);
>>>> -err_rings_alloc:
>>>>  err_duplicate:
>>>>      rocker_msix_uninit(r);
>>>>  err_msix_init:
>>>>      object_unparent(OBJECT(&r->msix_bar));
>>>>      object_unparent(OBJECT(&r->mmio));
>>>>  err_world_type_by_name:
>>>> -err_world_alloc:
>>>>      for (i = 0; i < ROCKER_WORLD_TYPE_MAX; i++) {
>>>>          if (r->worlds[i]) {
>>>>              world_free(r->worlds[i]);
>>>> diff --git a/hw/net/rocker/rocker_desc.c b/hw/net/rocker/rocker_desc.c
>>>> index ac02797..bd7e364 100644
>>>> --- a/hw/net/rocker/rocker_desc.c
>>>> +++ b/hw/net/rocker/rocker_desc.c
>>>> @@ -347,9 +347,6 @@ DescRing *desc_ring_alloc(Rocker *r, int index)
>>>>      DescRing *ring;
>>>>
>>>>      ring = g_new0(DescRing, 1);
>>>> -    if (!ring) {
>>>> -        return NULL;
>>>> -    }
>>>>
>>>>      ring->r = r;
>>>>      ring->index = index;
>>>> diff --git a/hw/net/rocker/rocker_fp.c b/hw/net/rocker/rocker_fp.c
>>>> index 1305ac3..4b3c984 100644
>>>> --- a/hw/net/rocker/rocker_fp.c
>>>> +++ b/hw/net/rocker/rocker_fp.c
>>>> @@ -226,10 +226,6 @@ FpPort *fp_port_alloc(Rocker *r, char *sw_name,
>>>>  {
>>>>      FpPort *port = g_new0(FpPort, 1);
>>>>
>>>> -    if (!port) {
>>>> -        return NULL;
>>>> -    }
>>>> -
>>>>      port->r = r;
>>>>      port->index = index;
>>>>      port->pport = index + 1;
>>>
>>> There's more!
>>>
>>> In tx_consume():
>>>
>>>            }
>>>            iov[iovcnt].iov_len = frag_len;
>>>            iov[iovcnt].iov_base = g_malloc(frag_len);
>>>   -        if (!iov[iovcnt].iov_base) {
>>>   -            err = -ROCKER_ENOMEM;
>>>   -            goto err_no_mem;
>>>   -        }
>>>
>>>            if (pci_dma_read(dev, frag_addr, iov[iovcnt].iov_base,
>>>
>>> In rx_produce():
>>>
>>>        data = g_malloc(data_size);
>>>   -    if (!data) {
>>>   -        err = -ROCKER_ENOMEM;
>>>   -        goto out;
>>>   -    }
>>>        iov_to_buf(iov, iovcnt, 0, data, data_size);
>>>        pci_dma_write(dev, frag_addr, data, data_size);
>>>
>>> In rocker_test_dma_ctrl():
>>>
>>>        int i;
>>>
>>>        buf = g_malloc(r->test_dma_size);
>>>    -
>>>    -   if (!buf) {
>>>    -       DPRINTF("test dma buffer alloc failed");
>>>    -       return;
>>>    -   }
>>>
>>>        switch (val) {
>>>
>>> This is just the result of a quick grep for '\<g_' immediately followed
>>> by dead error handling in rocker.c.  Please do the same for the rest of
>>> the rocker sources, and additionally search for dead error handling
>>> separated from the allocation by function returns, like the one you
>>> fixed in pci_rocker_init().
>>
>> After reading your detailed explanation, I think I will try to do these:
>> 1. Searching for all the dead error handling in the rocker_*.c.
>> 2. All dead error handling from allocation functions will be as a separated
>>    patch. Similarly, from function returns as another patch. Is that right?
>
> A single patch to drop all dead error handling could be okay.  Hard to
> say before you see it.  Merging patches is less work than splitting
> them, so you might want to develop separate patches, then squash them
> together to see whether the result is easy enough to describe and
> understand.
>
> General advice: when you notice that writing a commit message is hard,
> stop and think whether it would be easier if the patch was split.
>

Hi, Markus

Benefited a lot from your pertinent advice. I think I got it.

Thanks:)
Mao
