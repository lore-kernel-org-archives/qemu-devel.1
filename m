Received: from eggs.gnu.org ([2001:4830:134:3::10]:56213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dKiQZ-0008TR-6N
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:48:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dKiQW-0002Ib-3k
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:47:59 -0400
Received: from mga06.intel.com ([134.134.136.31]:42446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dKiQV-0002F3-Py
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:47:56 -0400
Message-ID: <593FB550.6090903@intel.com>
Date: Tue, 13 Jun 2017 17:50:08 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1496653049-44530-1-git-send-email-wei.w.wang@intel.com>
	<20170605182514-mutt-send-email-mst@kernel.org>
	<5937511D.5070205@intel.com>
	<20170608220006-mutt-send-email-mst@kernel.org>
	<593A0F47.5080806@intel.com> <593E5F46.5080704@intel.com>
	<20170612234035-mutt-send-email-mst@kernel.org>
	<593F57C0.9080701@intel.com>
	<4639c51b-32a6-3528-2ed6-c5f6296b6300@redhat.com>
	<593F6133.9050804@intel.com>
	<65faf3f9-a839-0b04-c740-6b2a60a51cf6@redhat.com>
	<593F8153.7080209@intel.com>
	<f8a64b2c-e769-4e9c-1cc6-ad31ea266010@redhat.com>
	<593F9187.6040800@intel.com>
	<9f196d71-f06b-7520-ca03-e94bf3b5a986@redhat.com>
In-Reply-To: <9f196d71-f06b-7520-ca03-e94bf3b5a986@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [virtio-dev] Re: [virtio-dev] Re: [PATCH v1]
 virtio-net: enable configurable tx queue size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "stefanha@gmail.com" <stefanha@gmail.com>, "armbru@redhat.com" <armbru@redhat.com>, "jan.scheurich@ericsson.com" <jan.scheurich@ericsson.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>

On 06/13/2017 05:04 PM, Jason Wang wrote:
>
>
> On 2017年06月13日 15:17, Wei Wang wrote:
>> On 06/13/2017 02:29 PM, Jason Wang wrote:
>>> The issue is what if there's a mismatch of max #sgs between qemu and
>>>>>> When the vhost backend is used, QEMU is not involved in the data 
>>>>>> path.
>>>>>> The vhost backend
>>>>>> directly gets what is offered by the guest from the vq. Why would
>>>>>> there be a mismatch of
>>>>>> max #sgs between QEMU and vhost, and what is the QEMU side max #sgs
>>>>>> used for? Thanks.
>>>>> You need query the backend max #sgs in this case at least. no? If not
>>>>> how do you know the value is supported by the backend?
>>>>>
>>>>> Thanks
>>>>>
>>>> Here is my thought: vhost backend has already been supporting 1024 
>>>> sgs,
>>>> so I think it might not be necessary to query the max sgs that the 
>>>> vhost
>>>> backend supports. In the setup phase, when QEMU detects the backend is
>>>> vhost, it assumes 1024 max sgs is supported, instead of giving an 
>>>> extra
>>>> call to query.
>>>
>>> We can probably assume vhost kernel supports up to 1024 sgs. But how 
>>> about for other vhost-user backends?
>>>
>> So far, I haven't seen any vhost backend implementation supporting 
>> less than 1024 sgs.
>
> Since vhost-user is an open protocol we can not check each 
> implementation (some may be even close sourced). For safety, we need 
> an explicit clarification on this.
>
>>
>>
>>> And what you said here makes me ask one of my questions in the past:
>>>
>>> Do we have plan to extend 1024 to a larger value or 1024 looks good 
>>> for the future years? If we only care about 1024, there's even no 
>>> need for a new config filed, a feature flag is more than enough. If 
>>> we want to extend it to e.g 2048, we definitely need to query vhost 
>>> backend's limit (even for vhost-kernel).
>>>
>>
>> According to virtio spec (e.g. 2.4.4), unreasonably large descriptors 
>> are
>> not encouraged to be used by the guest. If possible, I would suggest 
>> to use
>> 1024 as the largest number of descriptors that the guest can chain, 
>> even when
>> we have larger queue size in the future. That is,
>> if (backend == QEMU backend)
>>     config.max_chain_size = 1023 (defined by the qemu backend 
>> implementation);
>> else if (backend == vhost)
>>     config.max_chain_size = 1024;
>>
>> It is transparent to the guest. From the guest's point of view, all 
>> it knows is a value
>> given to him via reading config.max_chain_size.
>
> So not transparent actually, guest at least guest need to see and 
> check for this. So the question still, since you only care about two 
> cases in fact:
>
> - backend supports 1024
> - backend supports <1024 (qemu or whatever other backends)
>
> So it looks like a new feature flag is more than enough. If 
> device(backends) support this feature, it can make sure 1024 sgs is 
> supported?
>

That wouldn't be enough. For example, QEMU3.0 backend supports 
max_chain_size=1023,
while QEMU4.0 backend supports max_chain_size=1021. How would the guest know
the max size with the same feature flag? Would it still chain 1023 
descriptors with QEMU4.0?

Best,
Wei
