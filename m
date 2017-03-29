Received: from eggs.gnu.org ([2001:4830:134:3::10]:54025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ct9eA-0000wo-Bx
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 05:12:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ct9e5-000582-FE
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 05:12:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ct9e5-00057t-9N
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 05:12:01 -0400
References: <93cb45b7-feca-9340-5fbe-3cc1e60d9e7e@redhat.com>
	<aa8f8830-9426-7cf5-ec99-363035315aa3@redhat.com>
	<24333171-ada3-cfe8-647a-61dc6839144b@redhat.com>
	<59720527-123d-de99-7066-7c9d392b1a42@redhat.com>
	<2286dd90-c63b-d4ac-4212-f43c4a1ed8f8@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4f23135b-ad6d-7e1e-a0fd-cddaa788da7c@redhat.com>
Date: Wed, 29 Mar 2017 11:11:57 +0200
MIME-Version: 1.0
In-Reply-To: <2286dd90-c63b-d4ac-4212-f43c4a1ed8f8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] issues of region cache and iommu reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu devel <qemu-devel@nongnu.org>, Cornelia Huck <cornelia.huck@de.ibm.com>



On 29/03/2017 11:09, Jason Wang wrote:
>>>>
>>> This looks a good fix but may not solve this issue completely. Depends
>>> on the iova that guest uses, address_space_cache_init() may succeed even
>>> in this case since vtd does a passthrough translation in this case.
>> Can you explain this more?
> 
> Yes.  In this case, virtio-net-pci is not reset, but vtd has been reset.
> So virtio-net-pci will still try to use the iova of ring to setup the
> cache but now vtd treat iova as gpa since dmar has been disabled during
> reset. (E.g In my test with Linux driver, desc map succeed but used fail.)

That would be a Linux bug, the devices below the IOMMU have to be reset
first.

Paolo
