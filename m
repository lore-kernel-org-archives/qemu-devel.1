Received: from eggs.gnu.org ([2001:4830:134:3::10]:55392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gUo4N-0000CN-0u
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 02:27:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gUo4I-0004EW-Mh
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 02:27:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gUo4I-0004BN-AO
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 02:27:30 -0500
References: <CAHyh4xgZhGnEvkD5RiUazZ9Eq_jzr4=bXHfwBvCBkbOLN2UyKA@mail.gmail.com>
	<915953bd-cc9c-9456-b619-297138f68ae6@redhat.com>
	<20181204205541-mutt-send-email-mst@kernel.org>
	<fc1150b2-f71a-b527-cce1-9b33e0a11c6a@redhat.com>
	<20181205082228-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b8248abd-c609-b75b-c8e6-ed4193a7554e@redhat.com>
Date: Thu, 6 Dec 2018 15:27:19 +0800
MIME-Version: 1.0
In-Reply-To: <20181205082228-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Logging dirty pages from vhost-net in-kernel with
 vIOMMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jintack Lim <jintack@cs.columbia.edu>, QEMU Devel Mailing List <qemu-devel@nongnu.org>


On 2018/12/5 =E4=B8=8B=E5=8D=889:32, Michael S. Tsirkin wrote:
> On Wed, Dec 05, 2018 at 11:02:11AM +0800, Jason Wang wrote:
>> On 2018/12/5 =E4=B8=8A=E5=8D=889:59, Michael S. Tsirkin wrote:
>>> On Wed, Dec 05, 2018 at 09:30:19AM +0800, Jason Wang wrote:
>>>> On 2018/12/5 =E4=B8=8A=E5=8D=882:37, Jintack Lim wrote:
>>>>> Hi,
>>>>>
>>>>> I'm wondering how the current implementation works when logging dir=
ty
>>>>> pages during migration from vhost-net (in kernel) when used vIOMMU.
>>>>>
>>>>> I understand how vhost-net logs GPAs when not using vIOMMU. But whe=
n
>>>>> we use vhost with vIOMMU, then shouldn't vhost-net need to log the
>>>>> translated address (GPA) instead of the address written in the
>>>>> descriptor (IOVA) ? The current implementation looks like vhost-net
>>>>> just logs IOVA without translation in vhost_get_vq_desc() in
>>>>> drivers/vhost/net.c. It seems like QEMU doesn't do any further
>>>>> translation of the dirty log when syncing.
>>>>>
>>>>> I might be missing something. Could somebody shed some light on thi=
s?
>>>> Good catch. It looks like a bug to me. Want to post a patch for this=
?
>>> This isn't going to be a quick fix: IOTLB UAPI is translating
>>> IOVA values directly to uaddr.
>>>
>>> So to fix it, we need to change IOVA messages to translate to GPA
>>> so GPA can be logged.
>>>
>>> for existing userspace We can try reverse translation uaddr->gpa as a
>>> hack for logging but that translation was never guaranteed to be uniq=
ue.
>>
>> We have memory table in vhost as well, so looks like we can do this in
>> kernel as well without disturbing UAPI?
>>
>> Thanks
> Let me try to rephrase.
>
> Yes, as a temporary bugfix we can do the uaddr to gpa translations.
> It is probably good enough for what QEMU does now.
>
> However it can break some legal userspace, since it is possible to
> have multiple UADDR mappings for a single GPA.
> In that setup the vhost table would only have one of these
> and it's possible that IOTLB would use another one.


Consider we are logging GPA, so it doesn't matter which UADDR in this=20
case since we finally get a same GPA. Maybe you mean multiple GPA=20
mappings for a single UADDR? Then we may want to log all possible GPA in=20
this case.


>
> And generally it's a better idea security-wise to make
> iotlb talk in GPA terms. This way whoever sets the static
> GPA-to-UADDR mappings controls security, and the dynamic
> and more fragile iova mappings can not break QEMU security.


AFAIK, this may only work if memory table and IOTLB entries were set by=20
different process I believe. Consider it's all set by qemu, and qemu=20
will go through GPA-UADDR mapping before setting device IOTLB. It's=20
probably not a gain for us now.


>
> So we need a UAPI extension with a feature flag.
>

Yes.

Thanks


>>> Jason I think you'll have to work on it given the complexity.
>>>
>>>> Thanks
>>>>
>>>>
>>>>> Thanks,
>>>>> Jintack
>>>>>
>>>>>
