Received: from eggs.gnu.org ([2001:4830:134:3::10]:55839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gNyyy-0007lH-Ge
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 06:41:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gNyyv-0007GM-CS
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 06:41:48 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gNyyv-0007G1-5X
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 06:41:45 -0500
Received: by mail-wm1-x344.google.com with SMTP id f1-v6so2661084wmg.1
	for <qemu-devel@nongnu.org>; Sat, 17 Nov 2018 03:41:45 -0800 (PST)
References: <20181108160818.5485-1-yuval.shaia@oracle.com>
	<20181108160818.5485-14-yuval.shaia@oracle.com>
	<ee9f5ed6-f68b-eb45-2d2a-357ff1c47cf0@gmail.com>
	<20181111074541.GB2974@lap1>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <70f15298-24c2-d899-82fc-5d07e483474d@gmail.com>
Date: Sat, 17 Nov 2018 13:41:41 +0200
MIME-Version: 1.0
In-Reply-To: <20181111074541.GB2974@lap1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 13/22] hw/pvrdma: Make sure PCI function
 0 is vmxnet3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>
Cc: dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com



On 11/11/18 9:45 AM, Yuval Shaia wrote:
> On Sat, Nov 10, 2018 at 08:27:44PM +0200, Marcel Apfelbaum wrote:
>>
>> On 11/8/18 6:08 PM, Yuval Shaia wrote:
>>> Guest driver enforces it, we should also.
>>>
>>> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
>>> ---
>>>    hw/rdma/vmw/pvrdma.h      | 2 ++
>>>    hw/rdma/vmw/pvrdma_main.c | 3 +++
>>>    2 files changed, 5 insertions(+)
>>>
>>> diff --git a/hw/rdma/vmw/pvrdma.h b/hw/rdma/vmw/pvrdma.h
>>> index b019cb843a..10a3c4fb7c 100644
>>> --- a/hw/rdma/vmw/pvrdma.h
>>> +++ b/hw/rdma/vmw/pvrdma.h
>>> @@ -20,6 +20,7 @@
>>>    #include "hw/pci/pci.h"
>>>    #include "hw/pci/msix.h"
>>>    #include "chardev/char-fe.h"
>>> +#include "hw/net/vmxnet3_defs.h"
>>>    #include "../rdma_backend_defs.h"
>>>    #include "../rdma_rm_defs.h"
>>> @@ -85,6 +86,7 @@ typedef struct PVRDMADev {
>>>        RdmaBackendDev backend_dev;
>>>        RdmaDeviceResources rdma_dev_res;
>>>        CharBackend mad_chr;
>>> +    VMXNET3State *func0;
>>>    } PVRDMADev;
>>>    #define PVRDMA_DEV(dev) OBJECT_CHECK(PVRDMADev, (dev), PVRDMA_HW_NAME)
>>> diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
>>> index ac8c092db0..fa6468d221 100644
>>> --- a/hw/rdma/vmw/pvrdma_main.c
>>> +++ b/hw/rdma/vmw/pvrdma_main.c
>>> @@ -576,6 +576,9 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
>>>            return;
>>>        }
>>> +    /* Break if not vmxnet3 device in slot 0 */
>>> +    dev->func0 = VMXNET3(pci_get_function_0(pdev));
>>> +
>> I don't see the error code flow in case VMXNET3 is not func 0.
>> Am I missing something?
> Yes, this is a dynamic cast that will break the process when fail to cast.
>
> This is the error message that you will get in case that device on function
> 0 is not vmxnet3:
>
> pvrdma_main.c:589:pvrdma_realize: Object 0x557b959841a0 is not an instance of type vmxnet3

I am not sure we will see this error if QEMU is compiled in Release mode.
I think object_dynamic_cast_assert throws this error only if 
CONFIG_QOM_CAST_DEBUG
is set, and is possible the mentioned flag is not set in Release.

Thanks,
Marcel

>
>>
>> Thanks,
>> Marcel
>>
>>>        memdev_root = object_resolve_path("/objects", NULL);
>>>        if (memdev_root) {
>>>            object_child_foreach(memdev_root, pvrdma_check_ram_shared, &ram_shared);
