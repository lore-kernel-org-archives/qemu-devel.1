Received: from eggs.gnu.org ([2001:4830:134:3::10]:42671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d0n2n-0007w7-9Z
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 06:41:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d0n2k-0003OJ-5P
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 06:41:05 -0400
Received: from mga09.intel.com ([134.134.136.24]:9034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1d0n2j-0003Nq-S7
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 06:41:02 -0400
Message-ID: <58F73F22.50108@intel.com>
Date: Wed, 19 Apr 2017 18:42:42 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <286AC319A985734F985F78AFA26841F7391EF490@shsmsx102.ccr.corp.intel.com>
	<20170419095748.GE3343@stefanha-x1.localdomain>
In-Reply-To: <20170419095748.GE3343@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [virtio-dev] Vhost-pci RFC2.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?windows-1252?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>

On 04/19/2017 05:57 PM, Stefan Hajnoczi wrote:
> On Wed, Apr 19, 2017 at 06:38:11AM +0000, Wang, Wei W wrote:
>> We made some design changes to the original vhost-pci design, and want to open
>> a discussion about the latest design (labelled 2.0) and its extension (2.1).
>> 2.0 design: One VM shares the entire memory of another VM
>> 2.1 design: One VM uses an intermediate memory shared with another VM for
>>                       packet transmission.
> Hi,
> Can you talk a bit about the motivation for the 2.x design and major
> changes compared to 1.x?

1.x refers to the design we presented at KVM Form before. The major
change includes:
1) inter-VM notification support
2) TX engine and RX engine, which is the structure built in the driver. From
the device point of view, the local rings of the engines need to be 
registered.

The motivation is to build a common design for 2.0 and 2.1.

>
> What is the relationship between 2.0 and 2.1?  Do you plan to upstream
> both?
2.0 and 2.1 use different ways to share memory.

2.0: VM1 shares the entire memory of VM2, which achieves 0 copy
between VMs while being less secure.
2.1: VM1 and VM2 use an intermediate shared memory to transmit
packets, which results in 1 copy between VMs while being more secure.

Yes, plan to upstream both. Since the difference is the way to share memory,
I think it wouldn't have too many patches to upstream 2.1 if 2.0 is 
ready (or
changing the order if needed).

>> For the convenience of discussion, I have some pictures presented at this link:
>> https://github.com/wei-w-wang/vhost-pci-discussion/blob/master/vhost-pci-rfc2.0.pdf
>>
>> Fig. 1 shows the common driver frame that we want use to build the 2.0 and 2.1
> What does "frame" mean in this context?  "Framework" or "design".
"design" is more accurate here. We want to have a fundamental common 
design,
(please have a check Fig. 1. ), and build 2.0 and 2.1 on it.

Best,
Wei
