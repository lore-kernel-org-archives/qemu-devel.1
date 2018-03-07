Received: from eggs.gnu.org ([2001:4830:134:3::10]:58093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1etYlo-0008AS-NR
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 08:06:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1etYlk-00057v-PX
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 08:06:12 -0500
Received: from mga04.intel.com ([192.55.52.120]:1361)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1etYlk-00057I-HY
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 08:06:08 -0500
Message-ID: <5A9FE470.2090805@intel.com>
Date: Wed, 07 Mar 2018 21:09:04 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1519980450-3404-1-git-send-email-wei.w.wang@intel.com>
	<1519980450-3404-3-git-send-email-wei.w.wang@intel.com>
	<20180302203557-mutt-send-email-mst@kernel.org>
	<5A9CBB2F.8010400@intel.com>
	<20180305155642-mutt-send-email-mst@kernel.org>
	<5A9DF4E9.3090706@intel.com>
	<20180306042253-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180306042253-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/3] virtio-balloon:
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

On 03/06/2018 10:38 AM, Michael S. Tsirkin wrote:
> On Tue, Mar 06, 2018 at 09:54:49AM +0800, Wei Wang wrote:
>> On 03/05/2018 10:09 PM, Michael S. Tsirkin wrote:
>>> On Mon, Mar 05, 2018 at 11:36:15AM +0800, Wei Wang wrote:
>>>> On 03/03/2018 02:37 AM, Michael S. Tsirkin wrote:
>>>>> On Fri, Mar 02, 2018 at 04:47:29PM +0800, Wei Wang wrote:
>>>>>> diff --git a/include/sysemu/balloon.h b/include/sysemu/balloon.h
>>>>>> index af49e19..16a2aae 100644
>>>>>> --- a/include/sysemu/balloon.h
>>>>>> +++ b/include/sysemu/balloon.h
>>>>> ...
>>>>>
>>>>>> +typedef void (QEMUBalloonFreePageStart)(void *opaque);
>>>>>> +typedef void (QEMUBalloonFreePageStop)(void *opaque);
>>>>> So I think the rule is that no bitmap sync must happen
>>>>> between these two, otherwise a hint might arrive and
>>>>> override the sync output.
>>>>>
>>>>> Should be documented I think.
>>>>>
>>>> Yes, agree.
>>> Ideally we'd also detect violations and trigger an assert.
>> How about just invoking
>>
>> if (rs->free_page_support)
>>      balloon_free_page_stop();
>>
>> at the beginning of migration_bitmap_sync()? (balloon_free_page_stop will
>> just return if the optimization has stopped.)
>>
>> In this way, we can always have the guarantee that "no bitmap sync must
>> happen between these two"
> Why not. And in fact you can do balloon_free_page_start at the
> end of sync.

Sounds good. I implemented it this way in v4. In this case, we actually 
extend the usage of this optimization beyond the bulk stage. Though it 
shows similar test results as v3 which optimizes bulk stage only, but 
still good to leave the optimization there for the 2nd stage onward as 
well. It will speed up 2nd stage onward, for example, in this scenario: 
the guest writes page A, and then free(A) soon. After QEMU syncs bitmap, 
it sees bit of A is set, but now A is free page, the optimization can 
help to clear A from the bitmap.

Best,
Wei
