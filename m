Received: from eggs.gnu.org ([2001:4830:134:3::10]:32798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eeeaN-0007OY-Ev
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 05:16:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eeeaK-0000ZC-8C
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 05:16:47 -0500
Received: from mga09.intel.com ([134.134.136.24]:17630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eeeaJ-0000XZ-Vr
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 05:16:44 -0500
Message-ID: <5A69AF21.5000209@intel.com>
Date: Thu, 25 Jan 2018 18:19:13 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <20180119130653.24044-1-stefanha@redhat.com>
	<5A65C652.6080307@intel.com>
	<20180123111238.GC6565@stefanha-x1.localdomain>
	<5A673369.6050408@intel.com>
	<20180124114055.GC17193@stefanha-x1.localdomain>
In-Reply-To: <20180124114055.GC17193@stefanha-x1.localdomain>
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

On 01/24/2018 07:40 PM, Stefan Hajnoczi wrote:
> On Tue, Jan 23, 2018 at 09:06:49PM +0800, Wei Wang wrote:
>> On 01/23/2018 07:12 PM, Stefan Hajnoczi wrote:
>>> On Mon, Jan 22, 2018 at 07:09:06PM +0800, Wei Wang wrote:
>>>> On 01/19/2018 09:06 PM, Stefan Hajnoczi wrote:
>>>>
>>>>
>>>>    - Suppose in the future there is also a kernel virtio-vhost-user driver as
>>>> other PCI devices, can we unbind the kernel driver first, and then bind the
>>>> device to the dpdk driver? A normal PCI device should be able to smoothly
>>>> switch between the kernel driver and dpdk driver.
>>> It depends what you mean by "smoothly switch".
>>>
>>> If you mean whether it's possible to go from a kernel driver to
>>> vfio-pci, then the answer is yes.
>>>
>>> But if the kernel driver has an established vhost-user connection then
>>> it will be closed.  This is the same as reconnecting with AF_UNIX
>>> vhost-user.
>>>
>> Actually not only the case of switching to testpmd after kernel establishes
>> the connection, but also for several runs of testpmd. That is, if we run
>> testpmd, then exit testpmd. I think the second run of testpmd won't work.
> The vhost-user master must reconnect and initialize again (SET_FEATURES,
> SET_MEM_TABLE, etc).  Is your master reconnecting after the AF_UNIX
> connection is closed?

Is this an explicit qmp operation to make the master re-connect?

>
>> I'm thinking about caching the received master msgs in QEMU when
>> virtio_vhost_user_parse_m2s().
> Why is that necessary and how does QEMU know they are still up-to-date
> when a new connection is made?

OK. I think that's not needed if the master can reconnect.

>
>> Btw, I'm trying to run the code, but couldn't bind the virito-vhost-user
>> device to vfio-pci (reports Unknown device), not sure if it is because the
>> device type is "Unclassified device".
> You need to use the modified usertools/dpdk-devbind.py from my patch
> series inside the guest.  Please see:
> https://dpdk.org/ml/archives/dev/2018-January/088177.html

Thanks. I haven't got time on this yet due to some more urgent things. 
I'll try.

Best,
Wei
