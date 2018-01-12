Received: from eggs.gnu.org ([2001:4830:134:3::10]:53622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eZtBV-0004II-0e
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 01:51:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eZtBR-0007nC-W1
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 01:51:25 -0500
Received: from mga14.intel.com ([192.55.52.115]:35846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eZtBR-0007kH-NM
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 01:51:21 -0500
Message-ID: <5A585B77.4040404@intel.com>
Date: Fri, 12 Jan 2018 14:53:43 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <20171219162151.GA10889@stefanha-x1.localdomain>
	<1512291492.2209478.1513854089861.JavaMail.zimbra@redhat.com>
	<20180104104744.GC10106@stefanha-x1.localdomain>
	<5A4E0CDA.4060409@intel.com>
	<20180105154914.GH28322@stefanha-x1.localdomain>
	<5A53547D.2090602@intel.com>
	<20180108160921.GC11758@stefanha-x1.localdomain>
In-Reply-To: <20180108160921.GC11758@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] vhost-user graceful connect/disconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?windows-1252?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, mukawa@igel.co.jp, "Michael S. Tsirkin" <mst@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, n nikolaev <n.nikolaev@virtualopensystems.com>

On 01/09/2018 12:09 AM, Stefan Hajnoczi wrote:
> On Mon, Jan 08, 2018 at 07:22:37PM +0800, Wei Wang wrote:
>> On 01/05/2018 11:49 PM, Stefan Hajnoczi wrote:
>>> On Thu, Jan 04, 2018 at 07:15:38PM +0800, Wei Wang wrote:
>>>> On 01/04/2018 06:47 PM, Stefan Hajnoczi wrote:
>>>>> On Thu, Dec 21, 2017 at 06:01:29AM -0500, Marc-André Lureau wrote:
>>>>>
>>>>> I'm not going to prototype this yet, I'm working on virtio-vhost-user
>>>>> first, but eventually I might get back to -object vhost-user(-backend).
>>>>>
>>>> Hi Stefan, are you implementing the guest slave and vhost-pci driver (we've
>>>> posted to the dpdk mailinglist) as well? and do you have an estimation when
>>>> would the prototype be ready?
>>> I'm implementing the "[RFC virtio-dev] vhost-user-slave: add vhost-user
>>> slave device type" device in QEMU and DPDK in order to show how the
>>> ideas we've discussed work.
>>>
>>> Here is the VIRTIO spec link again:
>>> https://stefanha.github.io/virtio/vhost-user-slave.html#x1-2830007
>> There are four virtqueues documented in the spec, would two suffice? Request
>> and Response can be distinguished by VHOST_USER_REPLY_MASK.
> That's a good idea and I'll do it for the master-to-slave virtqueue.
>
> Unfortunately virtqueues are asymmetric so a single virtqueue cannot
> support the slave-to-master message flow (VHOST_USER_SET_SLAVE_REQ_FD):
> 1. Master puts an empty buffer onto vq.
> 2. Slave takes buffer and fills in a request.  The buffer is now used.
> 3. Master pops the used buffer but there is no way to reply back to the
>     slave!


Essentially, I think two virtqueues should be sufficient for 
guest-to-host and host-to-guest communication.

Host-to-guest virtqueue: used for master request/response messages 
passed to the guest slave (driver). The buffer can be primed by the 
guest driver (like virtio-net rxq).
Guest-to-host virtqueue: used for guest slave request/response messages, 
like virtio-net txq, it doesn't need to prime buffers in advance.


Best,
Wei
