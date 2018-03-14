Received: from eggs.gnu.org ([2001:4830:134:3::10]:54684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1evwKj-0006KE-Ss
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 22:40:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1evwKg-0003E8-Qr
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 22:40:05 -0400
Received: from mga06.intel.com ([134.134.136.31]:42513)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1evwKg-0003Dl-Gj
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 22:40:02 -0400
Message-ID: <5AA88C35.90300@intel.com>
Date: Wed, 14 Mar 2018 10:43:01 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1520426065-40265-1-git-send-email-wei.w.wang@intel.com>
	<1520426065-40265-4-git-send-email-wei.w.wang@intel.com>
	<20180313183558-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180313183558-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v4 3/4] virtio-balloon:
 VIRTIO_BALLOON_F_FREE_PAGE_HINT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

On 03/14/2018 12:49 AM, Michael S. Tsirkin wrote:
> On Wed, Mar 07, 2018 at 08:34:24PM +0800, Wei Wang wrote:
>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> Signed-off-by: Liang Li <liang.z.li@intel.com>
>> CC: Michael S. Tsirkin <mst@redhat.com>
>> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> CC: Juan Quintela <quintela@redhat.com>
> I find it suspicious that neither unrealize nor reset
> functions have been touched at all.
> Are you sure you have thought through scenarious like
> hot-unplug or disabling the device by guest?
>    

OK. I think we can call balloon_free_page_stop in unrealize and reset.


>   
> +static void *virtio_balloon_poll_free_page_hints(void *opaque)
> +{
> +    VirtQueueElement *elem;
> +    VirtIOBalloon *dev = opaque;
> +    VirtQueue *vq = dev->free_page_vq;
> +    uint32_t id;
> +    size_t size;
> What makes it safe to poke at this device from multiple threads?
> I think that it would be safer to do it from e.g. BH.
>

Actually the free_page_optimization thread is the only user of 
free_page_vq, and there is only one optimization thread each time. Would 
this be safe enough?

Best,
Wei
