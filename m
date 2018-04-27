Received: from eggs.gnu.org ([2001:4830:134:3::10]:57250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1fC9Kj-00068I-Il
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 15:47:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1fC9Kf-0002yq-CJ
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 15:47:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55100 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1fC9Kf-0002yg-6C
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 15:47:01 -0400
References: <20180219114332.70443-1-marcel@redhat.com>
	<20180219114332.70443-10-marcel@redhat.com>
	<CAFEAcA8yh0hhbhqBM3-iBXWHB72qx--FmnwFdQiPt9Fx13Fzmg@mail.gmail.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <5026a614-5124-aecd-5221-5b105c82533b@redhat.com>
Date: Fri, 27 Apr 2018 22:46:51 +0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8yh0hhbhqBM3-iBXWHB72qx--FmnwFdQiPt9Fx13Fzmg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH PULL v2 09/10] hw/rdma: Implementation of
 PVRDMA device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Yuval Shaia <yuval.shaia@oracle.com>, Michael Tsirkin <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 27/04/2018 17:55, Peter Maydell wrote:
> On 19 February 2018 at 11:43, Marcel Apfelbaum <marcel@redhat.com> wrote:
>> From: Yuval Shaia <yuval.shaia@oracle.com>
>>
>> PVRDMA is the QEMU implementation of VMware's paravirtualized RDMA device.
>> It works with its Linux Kernel driver AS IS, no need for any special
>> guest modifications.
>>
>> While it complies with the VMware device, it can also communicate with
>> bare metal RDMA-enabled machines and does not require an RDMA HCA in the
>> host, it can work with Soft-RoCE (rxe).
>>
>> It does not require the whole guest RAM to be pinned allowing memory
>> over-commit and, even if not implemented yet, migration support will be
>> possible with some HW assistance.
>>
>> Implementation is divided into 2 components, rdma general and pvRDMA
>> specific functions and structures.
>>
>> The second PVRDMA sub-module - interaction with PCI layer.
>> - Device configuration and setup (MSIX, BARs etc).
>> - Setup of DSR (Device Shared Resources)
>> - Setup of device ring.
>> - Device management.
>>
>> Reviewed-by: Dotan Barak <dotanb@mellanox.com>
>> Reviewed-by: Zhu Yanjun <yanjun.zhu@oracle.com>
>> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
>> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
> 
> 
>> +static void free_ports(PVRDMADev *dev)
>> +{
>> +    int i;
>> +
>> +    for (i = 0; i < MAX_PORTS; i++) {
>> +        g_free(dev->rdma_dev_res.ports[i].gid_tbl);
> 
> Coverity (CID 1390628) points out that this is attempting to
> call free on an array, which is not valid...
>

Definitely a bug, thanks! (git_tbl is part of RdmaRmPort,
it makes no sense to free it)

We didn't catch it because, funny thing,
the QOM 'exit' function is not called when QEMU exits
for any device created with "-device".

[Adding Michael and Markus]
Does anybody know anything about this issue? Is it on purpose?
Am I getting it wrong?


>> +    }
>> +}
>> +
>> +static void init_ports(PVRDMADev *dev, Error **errp)
>> +{
>> +    int i;
>> +
>> +    memset(dev->rdma_dev_res.ports, 0, sizeof(dev->rdma_dev_res.ports));
>> +
>> +    for (i = 0; i < MAX_PORTS; i++) {
>> +        dev->rdma_dev_res.ports[i].state = PVRDMA_PORT_DOWN;
>> +
>> +        dev->rdma_dev_res.ports[i].pkey_tbl =
>> +            g_malloc0(sizeof(*dev->rdma_dev_res.ports[i].pkey_tbl) *
>> +                      MAX_PORT_PKEYS);
> 
> ...init_ports() is allocated memory into ports[i].pkey_tbl,
> so maybe this is what free_ports() is intended to be freeing ?
> 

Right, we will fix it.

Thanks again for running Coverity!
Marcel

>> +    }
>> +}
> 
> thanks
> -- PMM
> 
