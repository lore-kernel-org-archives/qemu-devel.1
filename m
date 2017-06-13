Received: from eggs.gnu.org ([2001:4830:134:3::10]:60975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dKfL6-0007p8-Pc
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 02:30:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dKfL1-0008Q2-Rr
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 02:30:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dKfL1-0008Pe-J1
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 02:30:03 -0400
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
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f8a64b2c-e769-4e9c-1cc6-ad31ea266010@redhat.com>
Date: Tue, 13 Jun 2017 14:29:49 +0800
MIME-Version: 1.0
In-Reply-To: <593F8153.7080209@intel.com>
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



On 2017=E5=B9=B406=E6=9C=8813=E6=97=A5 14:08, Wei Wang wrote:
> On 06/13/2017 11:55 AM, Jason Wang wrote:
>>
>> On 2017=E5=B9=B406=E6=9C=8813=E6=97=A5 11:51, Wei Wang wrote:
>>> On 06/13/2017 11:19 AM, Jason Wang wrote:
>>>>
>>>> On 2017=E5=B9=B406=E6=9C=8813=E6=97=A5 11:10, Wei Wang wrote:
>>>>> On 06/13/2017 04:43 AM, Michael S. Tsirkin wrote:
>>>>>> On Mon, Jun 12, 2017 at 05:30:46PM +0800, Wei Wang wrote:
>>>>>>> Ping for comments, thanks.
>>>>>> This was only posted a week ago, might be a bit too short for some
>>>>>> people.
>>>>> OK, sorry for the push.
>>>>>> A couple of weeks is more reasonable before you ping.  Also, I
>>>>>> sent a bunch of comments on Thu, 8 Jun 2017.  You should probably
>>>>>> address these.
>>>>>>
>>>>> I responded to the comments. The main question is that I'm not sure
>>>>> why we need the vhost backend to support VIRTIO_F_MAX_CHAIN_SIZE.
>>>>> IMHO, that should be a feature proposed to solve the possible issue
>>>>> caused by the QEMU implemented backend.
>>>> The issue is what if there's a mismatch of max #sgs between qemu and
>>>> vhost?
>>>>
>>> When the vhost backend is used, QEMU is not involved in the data path=
.
>>> The vhost backend
>>> directly gets what is offered by the guest from the vq. Why would
>>> there be a mismatch of
>>> max #sgs between QEMU and vhost, and what is the QEMU side max #sgs
>>> used for? Thanks.
>> You need query the backend max #sgs in this case at least. no? If not
>> how do you know the value is supported by the backend?
>>
>> Thanks
>>
> Here is my thought: vhost backend has already been supporting 1024 sgs,
> so I think it might not be necessary to query the max sgs that the vhos=
t
> backend supports. In the setup phase, when QEMU detects the backend is
> vhost, it assumes 1024 max sgs is supported, instead of giving an extra
> call to query.

We can probably assume vhost kernel supports up to 1024 sgs. But how=20
about for other vhost-user backends?

And what you said here makes me ask one of my questions in the past:

Do we have plan to extend 1024 to a larger value or 1024 looks good for=20
the future years? If we only care about 1024, there's even no need for a=20
new config filed, a feature flag is more than enough. If we want to=20
extend it to e.g 2048, we definitely need to query vhost backend's limit=20
(even for vhost-kernel).

Thanks

>
> The advantage is that people who is using the vhost backend can upgrade
> to use 1024 tx queue size by only applying the QEMU patches. Adding an=20
> extra
> call to query the size would need to patch their vhost backend (like=20
> vhost-user),
> which is difficult for them.
>
>
> Best,
> Wei
>
>
>
>
>
>
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>
