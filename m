Received: from eggs.gnu.org ([2001:4830:134:3::10]:42718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gXh38-0006Ew-1s
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 01:34:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gXh34-0001Wy-PE
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 01:34:14 -0500
Received: from mga07.intel.com ([134.134.136.100]:52882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1gXh34-0001WN-G4
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 01:34:10 -0500
Message-ID: <5C135017.3070203@intel.com>
Date: Fri, 14 Dec 2018 14:39:19 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1544516693-5395-1-git-send-email-wei.w.wang@intel.com>
	<1544516693-5395-8-git-send-email-wei.w.wang@intel.com>
	<20181213154548.GP2313@work-vm>
In-Reply-To: <20181213154548.GP2313@work-vm>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v11 7/7] virtio-balloon:
 VIRTIO_BALLOON_F_FREE_PAGE_HINT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, quintela@redhat.com, peterx@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, nilal@redhat.com, riel@redhat.com

On 12/13/2018 11:45 PM, Dr. David Alan Gilbert wrote:
> * Wei Wang (wei.w.wang@intel.com) wrote:
>> The new feature enables the virtio-balloon device to receive hints of
>> guest free pages from the free page vq.
>>
>> A notifier is registered to the migration precopy notifier chain. The
>> notifier calls free_page_start after the migration thread syncs the dirty
>> bitmap, so that the free page optimization starts to clear bits of free
>> pages from the bitmap. It calls the free_page_stop before the migration
>> thread syncs the bitmap, which is the end of the current round of ram
>> save. The free_page_stop is also called to stop the optimization in the
>> case when there is an error occurred in the process of ram saving.
>>
>> Note: balloon will report pages which were free at the time of this call.
>> As the reporting happens asynchronously, dirty bit logging must be
>> enabled before this free_page_start call is made. Guest reporting must be
>> disabled before the migration dirty bitmap is synchronized.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> CC: Michael S. Tsirkin <mst@redhat.com>
>> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> CC: Juan Quintela <quintela@redhat.com>
>> CC: Peter Xu <peterx@redhat.com>
> I think I'm OK for this from the migration side, I'd appreciate
> someone checking the virtio and aio bits.
>
> I'm not too sure how it gets switched on and off - i.e. if we get a nice
> new qemu on a new kernel, what happens when I try and migrate to the
> same qemu on an older kernel without these hints?
>

This feature doesn't rely on the host kernel. Those hints are reported 
from the guest kernel.
So migration across different hosts wouldn't affect the use of this feature.
Please correct me if I didn't get your point.

Best,
Wei
