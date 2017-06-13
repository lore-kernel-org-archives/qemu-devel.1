Received: from eggs.gnu.org ([2001:4830:134:3::10]:43420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dKjLc-0005hm-Fs
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:46:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dKjLX-0004q5-Gs
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:46:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dKjLX-0004pu-7Y
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:46:51 -0400
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
	<593FB550.6090903@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <26250da7-b394-4964-8842-5c45bbe85e09@redhat.com>
Date: Tue, 13 Jun 2017 18:46:33 +0800
MIME-Version: 1.0
In-Reply-To: <593FB550.6090903@intel.com>
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
To: Wei Wang <wei.w.wang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "stefanha@gmail.com" <stefanha@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jan.scheurich@ericsson.com" <jan.scheurich@ericsson.com>, "armbru@redhat.com" <armbru@redhat.com>, "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>



On 2017=E5=B9=B406=E6=9C=8813=E6=97=A5 17:50, Wei Wang wrote:
> On 06/13/2017 05:04 PM, Jason Wang wrote:
>>
>>
>> On 2017=E5=B9=B406=E6=9C=8813=E6=97=A5 15:17, Wei Wang wrote:
>>> On 06/13/2017 02:29 PM, Jason Wang wrote:
>>>> The issue is what if there's a mismatch of max #sgs between qemu and
>>>>>>> When the vhost backend is used, QEMU is not involved in the data=20
>>>>>>> path.
>>>>>>> The vhost backend
>>>>>>> directly gets what is offered by the guest from the vq. Why would
>>>>>>> there be a mismatch of
>>>>>>> max #sgs between QEMU and vhost, and what is the QEMU side max #s=
gs
>>>>>>> used for? Thanks.
>>>>>> You need query the backend max #sgs in this case at least. no? If=20
>>>>>> not
>>>>>> how do you know the value is supported by the backend?
>>>>>>
>>>>>> Thanks
>>>>>>
>>>>> Here is my thought: vhost backend has already been supporting 1024=20
>>>>> sgs,
>>>>> so I think it might not be necessary to query the max sgs that the=20
>>>>> vhost
>>>>> backend supports. In the setup phase, when QEMU detects the=20
>>>>> backend is
>>>>> vhost, it assumes 1024 max sgs is supported, instead of giving an=20
>>>>> extra
>>>>> call to query.
>>>>
>>>> We can probably assume vhost kernel supports up to 1024 sgs. But=20
>>>> how about for other vhost-user backends?
>>>>
>>> So far, I haven't seen any vhost backend implementation supporting=20
>>> less than 1024 sgs.
>>
>> Since vhost-user is an open protocol we can not check each=20
>> implementation (some may be even close sourced). For safety, we need=20
>> an explicit clarification on this.
>>
>>>
>>>
>>>> And what you said here makes me ask one of my questions in the past:
>>>>
>>>> Do we have plan to extend 1024 to a larger value or 1024 looks good=20
>>>> for the future years? If we only care about 1024, there's even no=20
>>>> need for a new config filed, a feature flag is more than enough. If=20
>>>> we want to extend it to e.g 2048, we definitely need to query vhost=20
>>>> backend's limit (even for vhost-kernel).
>>>>
>>>
>>> According to virtio spec (e.g. 2.4.4), unreasonably large=20
>>> descriptors are
>>> not encouraged to be used by the guest. If possible, I would suggest=20
>>> to use
>>> 1024 as the largest number of descriptors that the guest can chain,=20
>>> even when
>>> we have larger queue size in the future. That is,
>>> if (backend =3D=3D QEMU backend)
>>>     config.max_chain_size =3D 1023 (defined by the qemu backend=20
>>> implementation);
>>> else if (backend =3D=3D vhost)
>>>     config.max_chain_size =3D 1024;
>>>
>>> It is transparent to the guest. From the guest's point of view, all=20
>>> it knows is a value
>>> given to him via reading config.max_chain_size.
>>
>> So not transparent actually, guest at least guest need to see and=20
>> check for this. So the question still, since you only care about two=20
>> cases in fact:
>>
>> - backend supports 1024
>> - backend supports <1024 (qemu or whatever other backends)
>>
>> So it looks like a new feature flag is more than enough. If=20
>> device(backends) support this feature, it can make sure 1024 sgs is=20
>> supported?
>>
>
> That wouldn't be enough. For example, QEMU3.0 backend supports=20
> max_chain_size=3D1023,
> while QEMU4.0 backend supports max_chain_size=3D1021. How would the=20
> guest know
> the max size with the same feature flag? Would it still chain 1023=20
> descriptors with QEMU4.0?
>
> Best,
> Wei

I believe we won't go back to less than 1024 in the future. It may be=20
worth to add a unittest for this to catch regression early.

Thanks

>
>
>
>
