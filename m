Received: from eggs.gnu.org ([2001:4830:134:3::10]:52382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eZCh5-0005b9-1V
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 04:29:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eZCh1-0000Jn-T2
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 04:29:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1eZCh1-0000IR-KK
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 04:29:07 -0500
References: <20180107123224.100877-1-marcel@redhat.com>
	<20180107123224.100877-5-marcel@redhat.com>
	<20180109113911.1746995b.cohuck@redhat.com>
	<20180109110833.GA5975@yuvallap>
	<20180109135125.2b3a511e.cohuck@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <4b9f28b1-f3a4-ba84-3b34-232bfd12947c@redhat.com>
Date: Wed, 10 Jan 2018 11:28:59 +0200
MIME-Version: 1.0
In-Reply-To: <20180109135125.2b3a511e.cohuck@redhat.com>
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
To: Cornelia Huck <cohuck@redhat.com>, Yuval Shaia <yuval.shaia@oracle.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, mst@redhat.com, borntraeger@de.ibm.com

On 09/01/2018 14:51, Cornelia Huck wrote:
> On Tue, 9 Jan 2018 13:08:33 +0200
> Yuval Shaia <yuval.shaia@oracle.com> wrote:
> 
>> On Tue, Jan 09, 2018 at 11:39:11AM +0100, Cornelia Huck wrote:
>>> On Sun,  7 Jan 2018 14:32:23 +0200
>>> Marcel Apfelbaum <marcel@redhat.com> wrote:
> 
>>>> diff --git a/hw/rdma/vmw/pvrdma_dev_api.h b/hw/rdma/vmw/pvrdma_dev_api.h
>>>> new file mode 100644
>>>> index 0000000000..bf1986a976
>>>> --- /dev/null
>>>> +++ b/hw/rdma/vmw/pvrdma_dev_api.h
>>>> @@ -0,0 +1,602 @@
>>>> +/*
>>>> + * QEMU VMWARE paravirtual RDMA device definitions
>>>> + *
>>>> + * Copyright (C) 2018 Oracle
>>>> + * Copyright (C) 2018 Red Hat Inc
>>>> + *
>>>> + * Authors:
>>>> + *     Yuval Shaia <yuval.shaia@oracle.com>
>>>> + *     Marcel Apfelbaum <marcel@redhat.com>
>>>> + *
>>>> + * This work is licensed under the terms of the GNU GPL, version 2.
>>>> + * See the COPYING file in the top-level directory.
>>>> + *
>>>> + */
>>>> +
>>>> +#ifndef PVRDMA_DEV_API_H
>>>> +#define PVRDMA_DEV_API_H
>>>> +
>>>> +/*
>>>> + * Following is an interface definition for PVRDMA device as provided by
>>>> + * VMWARE.
>>>> + * See original copyright from Linux kernel v4.14.5 header file
>>>> + * drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h
>>>
>>> Could that file be exported as UAPI in the kernel and added to the
>>> linux-headers script?
>>
>> We took this approach as apposed to kernel-headers with the following on
>> our mind:
>> (1) This is the convention used in vmxnet3.
>> (2) vmw_pvrdma was introduced only lately, taking the kernel-headers
>> approach will force specific kernel on a host in order to compile QEMU.
> 
> qemu will get the kernel headers once from the upstream kernel and then
> will be able to be built everywhere.
> 
>> (3) To support VMWare's pvrdma device we took a snapshot of existing
>> driver/device settings and breezed there. This is driver/device API and we
>> can't allow our self to chase VMWare's tail whenever they are changing the
>> API. Just consider a case where they will change for example the ARM bit.
> 
> But as want to enable the existing device driver, you'll want to be
> able to produce a compatible device anyway, don't you? Also, wouldn't
> VMWare break older kernels if they suddenly changed the api?
> 

I think it was a missunderstanding here :)

We don't actually need the VMware headers here in order to compile the device.
Requesting the pvrdma headers to be present really limits the hosts we could
compile QEMU without an actual benefit.

The headers describe the data structures passed by the Guest driver to the PVRDMA device.
Having them on the host should not be a requirement, we could simply define our own
structs but it would be harder to maintain. (diffing with linux headers to see what's new)

Note we don't care about ABI changes, we emulate a PCI device, not
a para-virt one, the driver has the contract to pass the same data definitions always.
If the data changes, there are 2 options:
1. Pass another "version nr" on the command channel (DSR) and we declare as not supported
    by this device and fail gracefully.
2. Use another device id.

We looked for what are the options for *not requiring* the headers to be present
and we saw two in QEMU:
1.  Adding it to include/standard-headers/linux/
But it seemed to much, only our device need them.
2. Adding it to the hw/rdma/vwm directory
Please look at: (hw/net/vmxnet3.h)

The second option seemed better, but we could go with "1."
if I got it right and you think is cleaner.
But again, the first option kind of requires updating the
linux headers always, but we want quite the opposite, to not
be connected to the changes.
I hope is more clear now.


> [Also, is there a canonical reference for this API?]
> 

Linux Kernel PVRDMA driver implementation...

>>
>> Just IMHO.
>>

Thanks a lot for your inputs, much appreciated!
Marcel

>>>
>>> (...)
>>>    
>>>> diff --git a/hw/rdma/vmw/pvrdma_ib_verbs.h b/hw/rdma/vmw/pvrdma_ib_verbs.h
>>>> new file mode 100644
>>>> index 0000000000..cf1430024b
>>>> --- /dev/null
>>>> +++ b/hw/rdma/vmw/pvrdma_ib_verbs.h
>>>> @@ -0,0 +1,433 @@
>>>> +/*
>>>> + * QEMU VMWARE paravirtual RDMA device definitions
>>>> + *
>>>> + * Copyright (C) 2018 Oracle
>>>> + * Copyright (C) 2018 Red Hat Inc
>>>> + *
>>>> + * Authors:
>>>> + *     Yuval Shaia <yuval.shaia@oracle.com>
>>>> + *     Marcel Apfelbaum <marcel@redhat.com>
>>>> + *
>>>> + * This work is licensed under the terms of the GNU GPL, version 2.
>>>> + * See the COPYING file in the top-level directory.
>>>> + *
>>>> + */
>>>> +
>>>> +#ifndef PVRDMA_IB_VERBS_H
>>>> +#define PVRDMA_IB_VERBS_H
>>>> +
>>>> +/*
>>>> + * VMWARE headers we got from Linux kernel do not fully comply QEMU coding
>>>> + * standards in sense of types and defines used.
>>>> + * Since we didn't want to change VMWARE code, following set of typedefs
>>>> + * and defines needed to compile these headers with QEMU introduced.
>>>> + */
>>>> +
>>>> +#define u8     uint8_t
>>>> +#define u16    unsigned short
>>>> +#define u32    uint32_t
>>>> +#define u64    uint64_t
>>>
>>> I think the headers update already takes care of some conversions.
>>> Otherwise, same comment as for the header above.
>>
>> Sorry, i'm not following, can you elaborate on that?
> 
> There's some post processing done by the headers update. But I think
> you'd need to use __u8 and friends for an exported header anyway.
> 
>>
>>>    
>>>> +
>>>> +/*
>>>> + * Following is an interface definition for PVRDMA device as provided by
>>>> + * VMWARE.
>>>> + * See original copyright from Linux kernel v4.14.5 header file
>>>> + * drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
>>>> + */
>>>
>>> (...)
>>>    
>>>> diff --git a/hw/rdma/vmw/vmw_pvrdma-abi.h b/hw/rdma/vmw/vmw_pvrdma-abi.h
>>>> new file mode 100644
>>>> index 0000000000..8cfb9d7745
>>>> --- /dev/null
>>>> +++ b/hw/rdma/vmw/vmw_pvrdma-abi.h
>>>> @@ -0,0 +1,311 @@
>>>> +/*
>>>> + * QEMU VMWARE paravirtual RDMA device definitions
>>>> + *
>>>> + * Copyright (C) 2018 Oracle
>>>> + * Copyright (C) 2018 Red Hat Inc
>>>> + *
>>>> + * Authors:
>>>> + *     Yuval Shaia <yuval.shaia@oracle.com>
>>>> + *     Marcel Apfelbaum <marcel@redhat.com>
>>>> + *
>>>> + * This work is licensed under the terms of the GNU GPL, version 2.
>>>> + * See the COPYING file in the top-level directory.
>>>> + *
>>>> + */
>>>> +
>>>> +#ifndef VMW_PVRDMA_ABI_H
>>>> +#define VMW_PVRDMA_ABI_H
>>>> +
>>>> +/*
>>>> + * Following is an interface definition for PVRDMA device as provided by
>>>> + * VMWARE.
>>>> + * See original copyright from Linux kernel v4.14.5 header file
>>>> + * include/uapi/rdma/vmw_pvrdma-abi.h
>>>> + */
>>>
>>> This one is already exported.
>>
>> Same argument as above.
> 
> Well, I sure hope VMWare is not planning to change an exported ABI in
> an incompatible way...
> 
