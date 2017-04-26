Received: from eggs.gnu.org ([2001:4830:134:3::10]:34704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1d3Pui-00009r-2M
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 12:35:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1d3Pue-0000S3-2U
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 12:35:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1d3Pud-0000Rw-Sh
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 12:35:32 -0400
References: <20170426100701.21893-1-lvivier@redhat.com>
	<20170426143108.GW3482@thinpad.lan.raisama.net>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <d23b0241-dc53-250a-82a6-be0ce156311a@redhat.com>
Date: Wed, 26 Apr 2017 18:35:27 +0200
MIME-Version: 1.0
In-Reply-To: <20170426143108.GW3482@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] numa: equally distribute memory on nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On 26/04/2017 16:31, Eduardo Habkost wrote:
> On Wed, Apr 26, 2017 at 12:07:01PM +0200, Laurent Vivier wrote:
>> When there is more nodes than memory available to put the minimum
>> allowed memory by node, all the memory is put on the last node.
>>
>> This is because we put (ram_size / nb_numa_nodes) &
>> ~((1 << mc->numa_mem_align_shift) - 1); on each node, and in this
>> case the value is 0. This is particularly true with pseries,
>> as the memory must be aligned to 256MB.
>>
>> To avoid this problem, this patch uses an error diffusion algorithm [1]
>> to distribute equally the memory on nodes.
> 
> Nice.
> 
> But we need compat code to keep the previous behavior on older
> machine-types. We can use either a new boolean MachineClass
> field, or a MachineClass method (mc->auto_assign_ram(), maybe?)
> that 2.9 machine-types could override.

You're right. I'm going to introduce a "numa_auto_assign_ram()" function
it the MachineClass.

Thanks,
Laurent
