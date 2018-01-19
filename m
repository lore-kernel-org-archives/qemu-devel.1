Received: from eggs.gnu.org ([2001:4830:134:3::10]:48653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ecNhH-0000bf-TO
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 22:50:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ecNhC-000643-Vn
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 22:50:31 -0500
Received: from mga03.intel.com ([134.134.136.65]:11096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1ecNhC-0005vm-IS
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 22:50:26 -0500
Message-ID: <5A616B91.1020508@intel.com>
Date: Fri, 19 Jan 2018 11:52:49 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1516170720-4948-1-git-send-email-wei.w.wang@intel.com>	<1516170720-4948-2-git-send-email-wei.w.wang@intel.com>
	<871sio4qg2.fsf@secure.laptop>
In-Reply-To: <871sio4qg2.fsf@secure.laptop>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/4] virtio-balloon:
 VIRTIO_BALLOON_F_FREE_PAGE_VQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

On 01/17/2018 08:31 PM, Juan Quintela wrote:
> Wei Wang <wei.w.wang@intel.com> wrote:
>> The new feature enables the virtio-balloon device to receive the hint of
>> guest free pages from the free page vq, and clears the corresponding bits
>> of the free page from the dirty bitmap, so that those free pages are not
>> transferred by the migration thread.
>>
>> Without this feature, to local live migrate an 8G idle guest takes
>> ~2286 ms. With this featrue, it takes ~260 ms, which redues the
>> migration time to ~11%.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> Signed-off-by: Liang Li <liang.z.li@intel.com>
>> CC: Michael S. Tsirkin <mst@redhat.com>
> I hate to answer twice,but ...

Thanks for the second review :)

>
>
>> +static bool virtio_balloon_free_page_support(void *opaque)
>> +{
>> +    VirtIOBalloon *s = opaque;
>> +
>> +    if (!balloon_free_page_supported(s)) {
>> +        return false;
>> +    }
>> +
>> +    return true;
> return balloon_free_page_supported(s); ???

Forgot to clean this up. It is actually a duplicate of 
balloon_free_page_supported() now, I'll remove one of them in the next 
version.

>
>
>> @@ -312,6 +399,7 @@ static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
>>   
>>       config.num_pages = cpu_to_le32(dev->num_pages);
>>       config.actual = cpu_to_le32(dev->actual);
>> +    config.free_page_report_cmd_id = cpu_to_le32(dev->free_page_report_cmd_id);
>>   
>>       trace_virtio_balloon_get_config(config.num_pages, config.actual);
>>       memcpy(config_data, &config, sizeof(struct virtio_balloon_config));
>> @@ -418,6 +506,7 @@ static const VMStateDescription vmstate_virtio_balloon_device = {
>>       .fields = (VMStateField[]) {
>>           VMSTATE_UINT32(num_pages, VirtIOBalloon),
>>           VMSTATE_UINT32(actual, VirtIOBalloon),
>> +        VMSTATE_UINT32(free_page_report_cmd_id, VirtIOBalloon),
>>           VMSTATE_END_OF_LIST()
> No new version, no subsection, and we add a new field?
> I think that is wrong.  We need to send that only for old versions.
> Look at how was handled for ....
>
> [PATCH v2] hpet: recover timer offset correctly
>
> v2 discussion explains why we want to handle that way for different
> machine types.
>
> v3 does it correctly.

OK, I'll put it to a subsection.

>
>
> And I think that with this I have reviewed all the migration/vmstate
> bits, no?
>
> If something is missing, please ask.

Thanks. This is the only new device state that need to be saved. Please 
have a review of patch 2 as well, which makes the migration thread use 
this feature.

Best,
Wei
