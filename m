Received: from eggs.gnu.org ([2001:4830:134:3::10]:43673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cJEk5-0008BE-V0
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 02:21:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cJEk1-0007F5-0O
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 02:21:45 -0500
Received: from mga03.intel.com ([134.134.136.65]:64961)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cJEk0-0007EM-Mz
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 02:21:40 -0500
Message-ID: <5858DC2E.7030807@intel.com>
Date: Tue, 20 Dec 2016 15:22:22 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
	<CAJ+F1CKWSznG3hxj0=F1UAJD+ZOZg=q+Oio1YnbsRyz6vy51FQ@mail.gmail.com>
	<5858B472.9000007@intel.com>
In-Reply-To: <5858B472.9000007@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [virtio-dev] Re: [RESEND Patch v1 00/37]
 Implementation of vhost-pci for inter-vm commucation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: mst@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org

On 12/20/2016 12:32 PM, Wei Wang wrote:
> Hi Marc-André, thanks for the comments.
>
> On 12/20/2016 12:43 AM, Marc-André Lureau wrote:
>
>> Another question, what are vpnet->rqs used for?
>
> This should be redundant, I will remove it.
>
I think I should explain more about this: the rqs field is redundant in 
the vpnet structure. But the rq is needed for the datapath.

The vhost-pci driver works like this (taking the single queue case as an 
example):
It has three queues, mirrored tq, mirrored rq (shared from virtio-net, 
buffers inside them are memory from the master guest) and the rq 
(buffers inside it are memory allocated by the slave guest itself). The 
packets grabbed from the mirrored rq, are copied to the buf got from the 
slave's own rq, and then delivered to the slave network stack. We need 
the rq because:
1) the buffers from the mirrored rq are from the master guest, so the 
slave network stack, by default, will free the skb buf that was not 
allocated;
2) the buffer fetched from the mirrored rq "avail" needs be returned to 
"used", it causes a problem if the buffer has been freed by the master 
and re-assigned to other code to use while it hasn't been handled by 
slave side network stack?
3) Interrupt support: we will need the rq interrupt, so that virtio-net 
can notify vhost-pci-net to grab packets.

Best,
Wei
