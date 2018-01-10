Received: from eggs.gnu.org ([2001:4830:134:3::10]:45222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eZCLa-0000Mm-8d
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 04:07:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eZCL8-0005QR-1z
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 04:06:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1eZCL7-0005Mq-Kx
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 04:06:29 -0500
References: <20180107123224.100877-1-marcel@redhat.com>
	<20180107123224.100877-5-marcel@redhat.com>
	<20180109113911.1746995b.cohuck@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <49cb6227-5ab0-bf04-2353-589f9d0ce513@redhat.com>
Date: Wed, 10 Jan 2018 11:06:14 +0200
MIME-Version: 1.0
In-Reply-To: <20180109113911.1746995b.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V6 4/5] pvrdma: initial implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, imammedo@redhat.com, yuval.shaia@oracle.com, pbonzini@redhat.com, mst@redhat.com, borntraeger@de.ibm.com

Hi Cornelia,

On 09/01/2018 12:39, Cornelia Huck wrote:
> On Sun,  7 Jan 2018 14:32:23 +0200
> Marcel Apfelbaum <marcel@redhat.com> wrote:
> 
>> From: Yuval Shaia <yuval.shaia@oracle.com>
>>
>> PVRDMA is the QEMU implementation of VMware's paravirtualized RDMA device.
>> It works with its Linux Kernel driver AS IS, no need for any special guest
>> modifications.
>>
>> While it complies with the VMware device, it can also communicate with bare
>> metal RDMA-enabled machines and does not require an RDMA HCA in the host, it
>> can work with Soft-RoCE (rxe).
>>
>> It does not require the whole guest RAM to be pinned allowing memory
>> over-commit and, even if not implemented yet, migration support will be
>> possible with some HW assistance.
>>
>> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
>> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
>> ---
>>   Makefile.objs                      |   2 +
>>   configure                          |   9 +-
>>   default-configs/arm-softmmu.mak    |   1 +
>>   default-configs/i386-softmmu.mak   |   1 +
>>   default-configs/x86_64-softmmu.mak |   1 +
>>   hw/Makefile.objs                   |   1 +
>>   hw/rdma/Makefile.objs              |   6 +
>>   hw/rdma/rdma_backend.c             | 815 +++++++++++++++++++++++++++++++++++++
>>   hw/rdma/rdma_backend.h             |  92 +++++
>>   hw/rdma/rdma_backend_defs.h        |  62 +++
>>   hw/rdma/rdma_rm.c                  | 619 ++++++++++++++++++++++++++++
>>   hw/rdma/rdma_rm.h                  |  69 ++++
>>   hw/rdma/rdma_rm_defs.h             | 106 +++++
>>   hw/rdma/rdma_utils.c               |  52 +++
>>   hw/rdma/rdma_utils.h               |  43 ++
>>   hw/rdma/trace-events               |   5 +
>>   hw/rdma/vmw/pvrdma.h               | 122 ++++++
>>   hw/rdma/vmw/pvrdma_cmd.c           | 679 ++++++++++++++++++++++++++++++
>>   hw/rdma/vmw/pvrdma_dev_api.h       | 602 +++++++++++++++++++++++++++
>>   hw/rdma/vmw/pvrdma_dev_ring.c      | 139 +++++++
>>   hw/rdma/vmw/pvrdma_dev_ring.h      |  42 ++
>>   hw/rdma/vmw/pvrdma_ib_verbs.h      | 433 ++++++++++++++++++++
>>   hw/rdma/vmw/pvrdma_main.c          | 644 +++++++++++++++++++++++++++++
>>   hw/rdma/vmw/pvrdma_qp_ops.c        | 212 ++++++++++
>>   hw/rdma/vmw/pvrdma_qp_ops.h        |  27 ++
>>   hw/rdma/vmw/pvrdma_ring.h          | 134 ++++++
>>   hw/rdma/vmw/trace-events           |   5 +
>>   hw/rdma/vmw/vmw_pvrdma-abi.h       | 311 ++++++++++++++
>>   include/hw/pci/pci_ids.h           |   3 +
>>   29 files changed, 5233 insertions(+), 4 deletions(-)
>>   create mode 100644 hw/rdma/Makefile.objs
>>   create mode 100644 hw/rdma/rdma_backend.c
>>   create mode 100644 hw/rdma/rdma_backend.h
>>   create mode 100644 hw/rdma/rdma_backend_defs.h
>>   create mode 100644 hw/rdma/rdma_rm.c
>>   create mode 100644 hw/rdma/rdma_rm.h
>>   create mode 100644 hw/rdma/rdma_rm_defs.h
>>   create mode 100644 hw/rdma/rdma_utils.c
>>   create mode 100644 hw/rdma/rdma_utils.h
>>   create mode 100644 hw/rdma/trace-events
>>   create mode 100644 hw/rdma/vmw/pvrdma.h
>>   create mode 100644 hw/rdma/vmw/pvrdma_cmd.c
>>   create mode 100644 hw/rdma/vmw/pvrdma_dev_api.h
>>   create mode 100644 hw/rdma/vmw/pvrdma_dev_ring.c
>>   create mode 100644 hw/rdma/vmw/pvrdma_dev_ring.h
>>   create mode 100644 hw/rdma/vmw/pvrdma_ib_verbs.h
>>   create mode 100644 hw/rdma/vmw/pvrdma_main.c
>>   create mode 100644 hw/rdma/vmw/pvrdma_qp_ops.c
>>   create mode 100644 hw/rdma/vmw/pvrdma_qp_ops.h
>>   create mode 100644 hw/rdma/vmw/pvrdma_ring.h
>>   create mode 100644 hw/rdma/vmw/trace-events
>>   create mode 100644 hw/rdma/vmw/vmw_pvrdma-abi.h
> 
> (...)
> 
>> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
>> index b0d6e65038..0e7a3c1700 100644
>> --- a/default-configs/arm-softmmu.mak
>> +++ b/default-configs/arm-softmmu.mak
>> @@ -132,3 +132,4 @@ CONFIG_GPIO_KEY=y
>>   CONFIG_MSF2=y
>>   CONFIG_FW_CFG_DMA=y
>>   CONFIG_XILINX_AXI=y
>> +CONFIG_PVRDMA=y
>> diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
>> index 95ac4b464a..88298e4ef5 100644
>> --- a/default-configs/i386-softmmu.mak
>> +++ b/default-configs/i386-softmmu.mak
>> @@ -61,3 +61,4 @@ CONFIG_HYPERV_TESTDEV=$(CONFIG_KVM)
>>   CONFIG_PXB=y
>>   CONFIG_ACPI_VMGENID=y
>>   CONFIG_FW_CFG_DMA=y
>> +CONFIG_PVRDMA=y
>> diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_64-softmmu.mak
>> index 0221236825..f571da36eb 100644
>> --- a/default-configs/x86_64-softmmu.mak
>> +++ b/default-configs/x86_64-softmmu.mak
>> @@ -61,3 +61,4 @@ CONFIG_HYPERV_TESTDEV=$(CONFIG_KVM)
>>   CONFIG_PXB=y
>>   CONFIG_ACPI_VMGENID=y
>>   CONFIG_FW_CFG_DMA=y
>> +CONFIG_PVRDMA=y
> 
> Any reason you did not add this to other architectures?
>

We simply didn't test other architectures, but it could work.

> I added "CONFIG_PVRDMA=$(CONFIG_PCI)" to s390x-softmmu.mak, and it at
> least builds (did not try to actually get it to work, although I don't
> see any immediate blocker for that).
> 
We will add it to s390, sure.

Thanks,
Marcel

> (...)

[...]
