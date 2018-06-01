Received: from eggs.gnu.org ([2001:4830:134:3::10]:51693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1fOaWT-0004tX-Na
	for qemu-devel@nongnu.org; Thu, 31 May 2018 23:14:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1fOaWQ-000611-HS
	for qemu-devel@nongnu.org; Thu, 31 May 2018 23:14:37 -0400
Received: from mga05.intel.com ([192.55.52.43]:14309)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1fOaWQ-0005kT-6H
	for qemu-devel@nongnu.org; Thu, 31 May 2018 23:14:34 -0400
Message-ID: <5B10BAF5.5080901@intel.com>
Date: Fri, 01 Jun 2018 11:18:13 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1524550428-27173-1-git-send-email-wei.w.wang@intel.com>
	<1524550428-27173-5-git-send-email-wei.w.wang@intel.com>
	<20180529181221-mutt-send-email-mst@kernel.org>
	<5B0E6AE9.2030505@intel.com>
	<20180530154325-mutt-send-email-mst@kernel.org>
	<5B0F5D74.603@intel.com>
	<20180531203837-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180531203837-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 4/5] virtio-balloon:
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
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com, zhang.zhanghailiang@huawei.com

On 06/01/2018 01:42 AM, Michael S. Tsirkin wrote:
> On Thu, May 31, 2018 at 10:27:00AM +0800, Wei Wang wrote:
>> On 05/30/2018 08:47 PM, Michael S. Tsirkin wrote:
>>> On Wed, May 30, 2018 at 05:12:09PM +0800, Wei Wang wrote:
>>>> On 05/29/2018 11:24 PM, Michael S. Tsirkin wrote:
>>>>> On Tue, Apr 24, 2018 at 02:13:47PM +0800, Wei Wang wrote:
>>>>>> +/*
>>>>>> + * Balloon will report pages which were free at the time of this call. As the
>>>>>> + * reporting happens asynchronously, dirty bit logging must be enabled before
>>>>>> + * this call is made.
>>>>>> + */
>>>>>> +void balloon_free_page_start(void)
>>>>>> +{
>>>>>> +    balloon_free_page_start_fn(balloon_opaque);
>>>>>> +}
>>>>> Please create notifier support, not a single global.
>>>> OK. The start is called at the end of bitmap_sync, and the stop is called at
>>>> the beginning of bitmap_sync. In this case, we will need to add two
>>>> migration states, MIGRATION_STATUS_BEFORE_BITMAP_SYNC and
>>>> MIGRATION_STATUS_AFTER_BITMAP_SYNC, right?
>>> If that's the way you do it, you need to ask migration guys, not me.
>> Yeah, I know.. thanks for the virtio part.
>>
>>>>> +
>>>>> +static bool virtio_balloon_free_page_support(void *opaque)
>>>>> +{
>>>>> +    VirtIOBalloon *s = opaque;
>>>>> +    VirtIODevice *vdev = VIRTIO_DEVICE(s);
>>>>> +
>>>>> +    return virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT);
>>>>> or if poison is negotiated.
>>>> Will make it
>>>> return virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT) &&
>>>> !virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)
>>> I mean the reverse:
>>> 	virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT) ||
>>> 	virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)
>>>
>>>
>>> If poison has been negotiated you must migrate the
>>> guest supplied value even if you don't use it for hints.
>>
>> Just a little confused with the logic. Writing it that way means that we are
>> taking this possibility "virtio_vdev_has_feature(vdev,
>> VIRTIO_BALLOON_F_FREE_PAGE_HINT)=fasle, virtio_vdev_has_feature(vdev,
>> VIRTIO_BALLOON_F_PAGE_POISON)=true" into account, and let the support
>> function return true when F_FREE_PAGE_HINT isn't supported.
> All I am saying is that in this configuration, you must migrate
> the poison value programmed by guest even if you do not
> yet use it without VIRTIO_BALLOON_F_FREE_PAGE_HINT.
>
> Right now you have
> a section:
> +    .needed = virtio_balloon_free_page_support,
>
> which includes the poison value.
>
> So if guest migrates after writing the poison value,
> it's lost. Not nice.
>
>> If guest doesn't support F_FREE_PAGE_HINT, it doesn't support the free page
>> reporting (even the free page vq). I'm not sure why we tell the migration
>> thread that the free page reporting feature is supported via this support
>> function. If the support function simply returns false when F_FREE_PAGE_HINT
>> isn't negotiated, the legacy migration already migrates the poisoned pages
>> (not skipped, but may be compressed).
>>
>> I think it would be better to simply use the original "return
>> virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)" here.
>
> So maybe you should put the poison value in a separate section then.

Yes, that looks good to me, thanks.

Best,
Wei
