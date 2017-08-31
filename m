Received: from eggs.gnu.org ([2001:4830:134:3::10]:39256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dnOIN-0004F4-Bt
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 08:10:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dnOII-0007DK-9h
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 08:10:03 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:44620
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dnOIH-0007Cm-N9
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 08:09:58 -0400
References: <1503372250-5092-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<1503372250-5092-2-git-send-email-douly.fnst@cn.fujitsu.com>
	<20170830205554.GA17184@localhost.localdomain>
	<c242e349-96d9-d27a-35dd-7efb6c6e26ea@cn.fujitsu.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <47cd831d-31cc-6152-0c01-ba228dc52682@cn.fujitsu.com>
Date: Thu, 31 Aug 2017 20:09:53 +0800
MIME-Version: 1.0
In-Reply-To: <c242e349-96d9-d27a-35dd-7efb6c6e26ea@cn.fujitsu.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 1/2] hw/acpi-build: Fix SRAT memory
 building when there is no memory in node0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, pbonzini@redhat.com, mst@redhat.com, rth@twiddle.net

Hi Eduardo,

At 08/31/2017 06:38 PM, Dou Liyang wrote:
> Hi Eduardo,
>
> [...]
>>> +            continue;
>>>          }
>>
>> Now the nodes will be out of order, if node 0 has no RAM.  Why?
>>
>
> Because the code parsed the other node with RAM first, then parsed the
> node 0.
>
>> Why not implement this in the same way the PCI 4GB hole is
>> already implemented.  e.g.:
>>
>
> Indeed, it is better and more refined. I will do it in the next version.
>
>> #define HOLE_640K_START  (640 * 1024)
>> #define HOLE_640K_END   (1024 * 1024)
>>
>>     for (node = 0; node < pcms->numa_nodes; node++) {
>>         mem_base = next_base;
>>         mem_len = pcms->node_mem[node];
>>         next_base = mem_base + mem_len;
>>
>>         /* Cut out the 640K hole */
>>         if (mem_base <= HOLE_640K_START &&
>>             next_base > HOLE_640K_START) {
>>             mem_len -= next_base - HOLE_640K;
>>             if (mem_len > 0) {
>>                 numamem = acpi_data_push(table_data, sizeof *numamem);
>>                 build_srat_memory(numamem, mem_base, mem_len, node,
>>                                   MEM_AFFINITY_ENABLED);
>>             }
>>             mem_base = HOLE_640K_END;
>>             /* ... */
>
> BTW, in case
>
>    0
>    |-----------|-------|--------|-------
>    |           |       |        |
> mem_base      640K   next_base   1M
>
>
>  I wanna add a check here,
>
>             /* Check for the rare case: 640K < RAM < 1M */
>             if (next_base <= HOLE_640K_END) {
>                 next_base = HOLE_640K_END;
>                 continue;
>             }
>             mem_base = HOLE_640K_END;
>             mem_len = next_base - HOLE_640K_END;
>
> I guess no one would set a node with this less RAM,
> So, Is that necessary?
>

I post the V5 patches, and use your code.

It may be not very clearly, for the detail, Please see the new version.

Thanks,
	dou.

> Thanks,
>     dou.
>
>>         }
>>         /* Cut out the ACPI_PCI hole */
>>         if (mem_base <= pcms->below_4g_mem_size &&
>>             next_base > pcms->below_4g_mem_size) {
>>             mem_len -= next_base - pcms->below_4g_mem_size;
>>             /* ... *]
>>         }
>>         numamem = acpi_data_push(table_data, sizeof *numamem);
>>         build_srat_memory(numamem, mem_base, mem_len, node,
>>                           MEM_AFFINITY_ENABLED);
>>         /* ... */
>>     }
>>
>>> -        numamem = acpi_data_push(table_data, sizeof *numamem);
>>> -        build_srat_memory(numamem, mem_base, mem_len, i - 1,
>>> -                          MEM_AFFINITY_ENABLED);
>>> +        mem_base = build_srat_node_entry(table_data, pcms, i,
>>> +                                            mem_base,
>>> pcms->node_mem[i]);
>>>      }
>>>      slots = (table_data->len - numa_start) / sizeof *numamem;
>>>      for (; slots < pcms->numa_nodes + 2; slots++) {
>>> --
>>> 2.5.5
>>>
>>>
>>>
>>>
>>
