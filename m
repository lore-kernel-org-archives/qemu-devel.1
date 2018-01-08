Received: from eggs.gnu.org ([2001:4830:134:3::10]:50745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eYVTb-0005ru-QO
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 06:20:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eYVTY-0008Sh-MD
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 06:20:23 -0500
Received: from mga06.intel.com ([134.134.136.31]:35913)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eYVTY-0008RF-Dm
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 06:20:20 -0500
Message-ID: <5A53547D.2090602@intel.com>
Date: Mon, 08 Jan 2018 19:22:37 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <20171219162151.GA10889@stefanha-x1.localdomain>
	<1512291492.2209478.1513854089861.JavaMail.zimbra@redhat.com>
	<20180104104744.GC10106@stefanha-x1.localdomain>
	<5A4E0CDA.4060409@intel.com>
	<20180105154914.GH28322@stefanha-x1.localdomain>
In-Reply-To: <20180105154914.GH28322@stefanha-x1.localdomain>
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

On 01/05/2018 11:49 PM, Stefan Hajnoczi wrote:
> On Thu, Jan 04, 2018 at 07:15:38PM +0800, Wei Wang wrote:
>> On 01/04/2018 06:47 PM, Stefan Hajnoczi wrote:
>>> On Thu, Dec 21, 2017 at 06:01:29AM -0500, Marc-André Lureau wrote:
>>>
>>> I'm not going to prototype this yet, I'm working on virtio-vhost-user
>>> first, but eventually I might get back to -object vhost-user(-backend).
>>>
>> Hi Stefan, are you implementing the guest slave and vhost-pci driver (we've
>> posted to the dpdk mailinglist) as well? and do you have an estimation when
>> would the prototype be ready?
> I'm implementing the "[RFC virtio-dev] vhost-user-slave: add vhost-user
> slave device type" device in QEMU and DPDK in order to show how the
> ideas we've discussed work.
>
> Here is the VIRTIO spec link again:
> https://stefanha.github.io/virtio/vhost-user-slave.html#x1-2830007

There are four virtqueues documented in the spec, would two suffice? 
Request and Response can be distinguished by VHOST_USER_REPLY_MASK.

>
> It integrates into DPDK's librte_vhost so that existing vhost-user code
> works over AF_UNIX and virtio-vhost-user without code duplication or
> rewriting the devices.
>
> I hope you'll like the code when it's done.  If not, it still has useful
> code and ideas that would be needed to complete the vhost-pci RFC work
> like extending the PCI transport in the VIRTIO spec, handling vhost-user
> reconnection, etc.
>
> I'm aiming to send an RFC in the next 2 weeks.
>

Thanks. There would be at least three Slave handlers I can imagine:
- QEMU Slave handler to send master requests/responses to the guest
- Guest Slave handler
- QEMU Slave handler to send Guest Requests/responses to the master
I'm curious to see the code how could one be implemented so that the 
other other two could reuse.

I think the key issue is that we have a different viewpoint of protocol 
gating and protocol relaying. It is a high-level direction we need to 
align first before we could get into more details. Hope your upcoming 
code can get us a decision. Please also remember to reuse the dpdk code 
that my coworker posted to the dpdk mailinglist wherever possible, it 
may save your time to debug.

Best,
Wei
