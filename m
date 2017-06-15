Received: from eggs.gnu.org ([2001:4830:134:3::10]:53337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dLMCm-0001cg-3M
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 00:16:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dLMCi-0006Zg-T9
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 00:16:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dLMCi-0006ZA-K6
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 00:16:20 -0400
References: <4639c51b-32a6-3528-2ed6-c5f6296b6300@redhat.com>
	<593F6133.9050804@intel.com>
	<65faf3f9-a839-0b04-c740-6b2a60a51cf6@redhat.com>
	<593F8153.7080209@intel.com>
	<f8a64b2c-e769-4e9c-1cc6-ad31ea266010@redhat.com>
	<593F9187.6040800@intel.com>
	<9f196d71-f06b-7520-ca03-e94bf3b5a986@redhat.com>
	<593FB550.6090903@intel.com>
	<26250da7-b394-4964-8842-5c45bbe85e09@redhat.com>
	<6547dfcf-ea3a-f5f6-222d-40ff274654df@redhat.com>
	<20170614180459-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b59be2f1-ee8c-e660-4f82-bbe63e22b603@redhat.com>
Date: Thu, 15 Jun 2017 12:16:09 +0800
MIME-Version: 1.0
In-Reply-To: <20170614180459-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "stefanha@gmail.com" <stefanha@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jan.scheurich@ericsson.com" <jan.scheurich@ericsson.com>, "armbru@redhat.com" <armbru@redhat.com>, Wei Wang <wei.w.wang@intel.com>, "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>



On 2017=E5=B9=B406=E6=9C=8814=E6=97=A5 23:22, Michael S. Tsirkin wrote:
> On Wed, Jun 14, 2017 at 07:26:54PM +0800, Jason Wang wrote:
>>
>> On 2017=E5=B9=B406=E6=9C=8813=E6=97=A5 18:46, Jason Wang wrote:
>>>
>>> On 2017=E5=B9=B406=E6=9C=8813=E6=97=A5 17:50, Wei Wang wrote:
>>>> On 06/13/2017 05:04 PM, Jason Wang wrote:
>>>>>
>>>>> On 2017=E5=B9=B406=E6=9C=8813=E6=97=A5 15:17, Wei Wang wrote:
>>>>>> On 06/13/2017 02:29 PM, Jason Wang wrote:
>>>>>>> The issue is what if there's a mismatch of max #sgs between qemu =
and
>>>>>>>>>> When the vhost backend is used, QEMU is not
>>>>>>>>>> involved in the data path.
>>>>>>>>>> The vhost backend
>>>>>>>>>> directly gets what is offered by the guest from the vq. Why wo=
uld
>>>>>>>>>> there be a mismatch of
>>>>>>>>>> max #sgs between QEMU and vhost, and what is
>>>>>>>>>> the QEMU side max #sgs
>>>>>>>>>> used for? Thanks.
>>>>>>>>> You need query the backend max #sgs in this case
>>>>>>>>> at least. no? If not
>>>>>>>>> how do you know the value is supported by the backend?
>>>>>>>>>
>>>>>>>>> Thanks
>>>>>>>>>
>>>>>>>> Here is my thought: vhost backend has already been
>>>>>>>> supporting 1024 sgs,
>>>>>>>> so I think it might not be necessary to query the
>>>>>>>> max sgs that the vhost
>>>>>>>> backend supports. In the setup phase, when QEMU
>>>>>>>> detects the backend is
>>>>>>>> vhost, it assumes 1024 max sgs is supported, instead
>>>>>>>> of giving an extra
>>>>>>>> call to query.
>>>>>>> We can probably assume vhost kernel supports up to 1024
>>>>>>> sgs. But how about for other vhost-user backends?
>>>>>>>
>>>>>> So far, I haven't seen any vhost backend implementation
>>>>>> supporting less than 1024 sgs.
>>>>> Since vhost-user is an open protocol we can not check each
>>>>> implementation (some may be even close sourced). For safety, we
>>>>> need an explicit clarification on this.
>>>>>
>>>>>>
>>>>>>> And what you said here makes me ask one of my questions in the pa=
st:
>>>>>>>
>>>>>>> Do we have plan to extend 1024 to a larger value or 1024
>>>>>>> looks good for the future years? If we only care about
>>>>>>> 1024, there's even no need for a new config filed, a
>>>>>>> feature flag is more than enough. If we want to extend
>>>>>>> it to e.g 2048, we definitely need to query vhost
>>>>>>> backend's limit (even for vhost-kernel).
>>>>>>>
>>>>>> According to virtio spec (e.g. 2.4.4), unreasonably large
>>>>>> descriptors are
>>>>>> not encouraged to be used by the guest. If possible, I would
>>>>>> suggest to use
>>>>>> 1024 as the largest number of descriptors that the guest can
>>>>>> chain, even when
>>>>>> we have larger queue size in the future. That is,
>>>>>> if (backend =3D=3D QEMU backend)
>>>>>>      config.max_chain_size =3D 1023 (defined by the qemu
>>>>>> backend implementation);
>>>>>> else if (backend =3D=3D vhost)
>>>>>>      config.max_chain_size =3D 1024;
>>>>>>
>>>>>> It is transparent to the guest. From the guest's point of
>>>>>> view, all it knows is a value
>>>>>> given to him via reading config.max_chain_size.
>>>>> So not transparent actually, guest at least guest need to see
>>>>> and check for this. So the question still, since you only care
>>>>> about two cases in fact:
>>>>>
>>>>> - backend supports 1024
>>>>> - backend supports <1024 (qemu or whatever other backends)
>>>>>
>>>>> So it looks like a new feature flag is more than enough. If
>>>>> device(backends) support this feature, it can make sure 1024 sgs
>>>>> is supported?
>>>>>
>>>> That wouldn't be enough. For example, QEMU3.0 backend supports
>>>> max_chain_size=3D1023,
>>>> while QEMU4.0 backend supports max_chain_size=3D1021. How would the
>>>> guest know
>>>> the max size with the same feature flag? Would it still chain 1023
>>>> descriptors with QEMU4.0?
>>>>
>>>> Best,
>>>> Wei
>>> I believe we won't go back to less than 1024 in the future. It may be
>>> worth to add a unittest for this to catch regression early.
>>>
>>> Thanks
> I think I disagree with that. Smaller pipes a better (e.g. less cache
> pressure) and you only need huge pipes because host thread gets
> scheduled out for too long. With more CPUs there's less of a chance of
> an overcommit so we'll be able to get by with smaller pipes in the
> future.

Agree, but we are talking about the upper limit. Even if 1024 is=20
supported, small number of #sgs is still encouraged.

>
>> Consider the queue size is 256 now, I think maybe we can first make tx=
 queue
>> size configurable up to 1024, and then do the #sg stuffs on top.
>>
>> What's your opinion, Michael?
>>
>> Thanks
> With a kernel backend, 1024 is problematic since we are then unable
> to add any entries or handle cases where an entry crosses an MR region
> boundary. We could support up to 512 with a kernel backend but no one
> seems to want that :)

Then I see issues with indirect descriptors.

We try to allow up 1024 chained descriptors implicitly since=20
e0e9b406470b ("vhost: max s/g to match qemu"). If guest can submit=20
crossing MR descs, I'm afraid we've already had this bug since this=20
commit. And actually this seems conflict to what spec said in 2.4.5:

"""
The number of descriptors in the table is defined by the queue size for=20
this virtqueue: this is the maximum possible descriptor chain length.
"""

Technically, we had the same issue for rx since we allow 1024 queue size=20
now.

So actually, allowing the size to 1024 does not introduce any new trouble=
?
>
> With vhost-user the backend might be able to handle that. So an
> acceptable option would be to allow 1K with vhost-user backends
> only, trim it back with other backends.
>

I believe the idea is to clarify the maximum chain size instead of=20
having any assumption.

Thanks
