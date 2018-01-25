Received: from eggs.gnu.org ([2001:4830:134:3::10]:42222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eeiBh-0005Yj-4W
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:07:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eeiBb-0004C0-QM
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:07:32 -0500
Received: from mail-wr0-f171.google.com ([209.85.128.171]:40005)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eeiBb-0004BX-Im
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:07:27 -0500
Received: by mail-wr0-f171.google.com with SMTP id 100so7807323wrb.7
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 06:07:27 -0800 (PST)
References: <20180119130653.24044-1-stefanha@redhat.com>
	<9048a120-a3be-404d-e977-39f40b4d4561@redhat.com>
	<20180122121751.GD31621@stefanha-x1.localdomain>
	<20180122215348-mutt-send-email-mst@kernel.org>
	<b0568f2d-928c-5124-757e-fe5b706c4df7@redhat.com>
	<20180123180515-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <514b4874-802a-3405-485e-1f84d760ec67@redhat.com>
Date: Thu, 25 Jan 2018 15:07:23 +0100
MIME-Version: 1.0
In-Reply-To: <20180123180515-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: zhiyong.yang@intel.com, Maxime Coquelin <maxime.coquelin@redhat.com>, Wei Wang <wei.w.wang@intel.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On 23/01/2018 17:07, Michael S. Tsirkin wrote:
>> It's not clear to me how to do this. E.g need a way to report failure to VM2
>> or #PF?
> 
> Why would there be a failure? qemu running vm1 would be responsible for
> preventing access to vm2's memory not mapped through an IOMMU.
> Basically munmap these.

Access to VM2's memory would use VM2's configured IOVAs for VM1's
requester id.  VM2's QEMU send device IOTLB messages to VM1's QEMU,
which would remap VM2's memory on the fly into VM1's BAR2.

It's not trivial to do it efficiently, but it's possible.  The important
thing is that, if VM2 has an IOMMU, QEMU must *not* connect to a
virtio-vhost-user device that lacks IOTLB support.  But that would be a
vhost-user bug, not a virtio-vhost-user bug---and that's the beauty of
Stefan's approach. :)

Paolo
