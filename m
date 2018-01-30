Received: from eggs.gnu.org ([2001:4830:134:3::10]:55756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1egUge-0000fg-Eb
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 07:07:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1egUgY-00056P-H2
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 07:06:52 -0500
Received: from mga01.intel.com ([192.55.52.88]:49587)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1egUgY-00055Z-8P
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 07:06:46 -0500
Message-ID: <5A70606F.3030307@intel.com>
Date: Tue, 30 Jan 2018 20:09:19 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <20180119130653.24044-1-stefanha@redhat.com>
	<5A65C652.6080307@intel.com>
	<20180123111238.GC6565@stefanha-x1.localdomain>
	<5A673369.6050408@intel.com>
	<20180124114055.GC17193@stefanha-x1.localdomain>
	<5A69AF21.5000209@intel.com>
	<20180126144429.GD17788@stefanha-x1.localdomain>
In-Reply-To: <20180126144429.GD17788@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 0/2] virtio-vhost-user: add virtio-vhost-user
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, zhiyong.yang@intel.com, Maxime Coquelin <maxime.coquelin@redhat.com>, jasowang@redhat.com

On 01/26/2018 10:44 PM, Stefan Hajnoczi wrote:
> On Thu, Jan 25, 2018 at 06:19:13PM +0800, Wei Wang wrote:
>> On 01/24/2018 07:40 PM, Stefan Hajnoczi wrote:
>>> On Tue, Jan 23, 2018 at 09:06:49PM +0800, Wei Wang wrote:
>>>> On 01/23/2018 07:12 PM, Stefan Hajnoczi wrote:
>>>>> On Mon, Jan 22, 2018 at 07:09:06PM +0800, Wei Wang wrote:
>>>>>> On 01/19/2018 09:06 PM, Stefan Hajnoczi wrote:
>>>>>>
>>>>>>
>>>>>>     - Suppose in the future there is also a kernel virtio-vhost-user driver as
>>>>>> other PCI devices, can we unbind the kernel driver first, and then bind the
>>>>>> device to the dpdk driver? A normal PCI device should be able to smoothly
>>>>>> switch between the kernel driver and dpdk driver.
>>>>> It depends what you mean by "smoothly switch".
>>>>>
>>>>> If you mean whether it's possible to go from a kernel driver to
>>>>> vfio-pci, then the answer is yes.
>>>>>
>>>>> But if the kernel driver has an established vhost-user connection then
>>>>> it will be closed.  This is the same as reconnecting with AF_UNIX
>>>>> vhost-user.
>>>>>
>>>> Actually not only the case of switching to testpmd after kernel establishes
>>>> the connection, but also for several runs of testpmd. That is, if we run
>>>> testpmd, then exit testpmd. I think the second run of testpmd won't work.
>>> The vhost-user master must reconnect and initialize again (SET_FEATURES,
>>> SET_MEM_TABLE, etc).  Is your master reconnecting after the AF_UNIX
>>> connection is closed?
>> Is this an explicit qmp operation to make the master re-connect?
> I haven't tested it myself but I'm aware of two modes of operation:
>
> 1. -chardev socket,id=chardev0,...,server
>     -netdev vhost-user,chardev=chardev0
>
>     When the vhost-user socket is disconnected the peer needs to
>     reconnect.  In this case no special commands are necessary.
>
>     Here we're relying on DPDK librte_vhost's reconnection behavior.
>
> Or
>
> 2. -chardev socket,id=chardev0,...,reconnect=3
>     -netdev vhost-user,chardev=chardev0
>
>     When the vhost-user socket is disconnected a new connection attempt
>     will be made after 3 seconds.
>
> In both cases vhost-user negotiation will resume when the new connection
> is established.
>
> Stefan

I've been thinking about the issues, and it looks vhost-pci outperforms 
in this aspect.
Vhost-pci is like using a mail box. messages are just dropped into the 
box, and whenever vhost-pci pmd gets booted, it can always get the 
messages from the box, the negotiation between vhost-pci pmd and 
virtio-net is asynchronous.
Virtio-vhost-user is like a phone call, which is a synchronous 
communication. If one side is absent, then the other side will hang on 
without knowing when it could get connected or hang up with messages not 
passed (lost).

I also think the above solutions won't help. Please see below:

Background:
The vhost-user negotiation is split into 2 phases currently. The 1st 
phase happens when the connection is established, and we can find what's 
done in the 1st phase in vhost_user_init(). The 2nd phase happens when 
the master driver is loaded (e.g. run of virtio-net pmd) and set status 
to the device, and we can find what's done in the 2nd phase in 
vhost_dev_start(), which includes sending the memory info and virtqueue 
info. The socket is connected, till one of the QEMU devices exits, so 
pmd exiting won't end the QEMU side socket connection.

Issues:
Suppose we have both the vhost and virtio-net set up, and vhost pmd <-> 
virtio-net pmd communication works well. Now, vhost pmd exits 
(virtio-net pmd is still there). Some time later, we re-run vhost pmd, 
the vhost pmd doesn't know the virtqueue addresses of the virtio-net 
pmd, unless the virtio-net pmd reloads to start the 2nd phase of the 
vhost-user protocol. So the second run of the vhost pmd won't work.

Any thoughts?

Best,
Wei
