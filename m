Received: from eggs.gnu.org ([209.51.188.92]:38955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1h1Lql-0000tc-7o
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 21:00:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1h1Lqj-0007QP-7D
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 21:00:03 -0500
Received: from mga04.intel.com ([192.55.52.120]:21567)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1h1Lqf-0007IH-FN
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 20:59:59 -0500
Message-ID: <5C7F2AC6.4080602@intel.com>
Date: Wed, 06 Mar 2019 10:04:54 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1544516693-5395-1-git-send-email-wei.w.wang@intel.com>
	<1544516693-5395-8-git-send-email-wei.w.wang@intel.com>
	<20190305145034.GF9811@work-vm>
In-Reply-To: <20190305145034.GF9811@work-vm>
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
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, peterx@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, nilal@redhat.com, riel@redhat.com

On 03/05/2019 10:50 PM, Dr. David Alan Gilbert wrote:
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
>> ---
>>   hw/virtio/virtio-balloon.c                      | 263 ++++++++++++++++++++++++
>>   include/hw/virtio/virtio-balloon.h              |  28 ++-
>>   include/standard-headers/linux/virtio_balloon.h |   5 +
>>   3 files changed, 295 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
>> +    if (dev->free_page_report_status == FREE_PAGE_REPORT_S_REQUESTED) {
>> +        config.free_page_report_cmd_id =
>> +                       cpu_to_le32(dev->free_page_report_cmd_id);
>> +    } else if (dev->free_page_report_status == FREE_PAGE_REPORT_S_STOP) {
>> +        config.free_page_report_cmd_id =
>> +                       cpu_to_le32(VIRTIO_BALLOON_FREE_PAGE_REPORT_STOP_ID);
>> +    } else if (dev->free_page_report_status == FREE_PAGE_REPORT_S_DONE) {
>> +        config.free_page_report_cmd_id =
>> +                       cpu_to_le32(VIRTIO_BALLOON_FREE_PAGE_REPORT_DONE_ID);
>> +    }
> It looks like somewhere in the last 3 months the name in the kernel
> changed; so I think I've fixed this correctly but please shout if it's
> wrong:
>
>      if (dev->free_page_report_status == FREE_PAGE_REPORT_S_REQUESTED) {
>          config.free_page_report_cmd_id =
>                         cpu_to_le32(dev->free_page_report_cmd_id);
>      } else if (dev->free_page_report_status == FREE_PAGE_REPORT_S_STOP) {
>          config.free_page_report_cmd_id =
>                         cpu_to_le32(VIRTIO_BALLOON_CMD_ID_STOP);
>      } else if (dev->free_page_report_status == FREE_PAGE_REPORT_S_DONE) {
>          config.free_page_report_cmd_id =
>                         cpu_to_le32(VIRTIO_BALLOON_CMD_ID_DONE);
>      }
>
> and I've dropped the kernel header update since it's already there.
>

Looks good. Thanks for the update.

Best,
Wei
