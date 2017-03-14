Received: from eggs.gnu.org ([2001:4830:134:3::10]:52570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cncKk-0000uO-DK
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 22:37:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cncKh-0006Vi-DD
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 22:37:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cncKh-0006VB-6i
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 22:37:07 -0400
References: <1489386583-11564-1-git-send-email-jasowang@redhat.com>
	<20170313105515.75981fb9.cornelia.huck@de.ibm.com>
	<0178911d-a930-5031-5e9f-4fdedd51fe3e@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d6c5efef-14a0-370d-86a9-b4882c20066b@redhat.com>
Date: Tue, 14 Mar 2017 10:37:00 +0800
MIME-Version: 1.0
In-Reply-To: <0178911d-a930-5031-5e9f-4fdedd51fe3e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V2 1/3] virtio: guard against NULL pfn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org



On 2017=E5=B9=B403=E6=9C=8813=E6=97=A5 18:18, Paolo Bonzini wrote:
>
> On 13/03/2017 10:55, Cornelia Huck wrote:
>> On Mon, 13 Mar 2017 14:29:41 +0800
>> Jason Wang <jasowang@redhat.com> wrote:
>>
>>> To avoid access stale memory region cache after reset, this patch
>>> check the existence of virtqueue pfn for all exported virtqueue acces=
s
>>> helpers before trying to use them.
>>>
>>> Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>> ---
>>>   hw/virtio/virtio.c | 21 +++++++++++++++++++++
>>>   1 file changed, 21 insertions(+)
>>>
>>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>>> index efce4b3..76cc81b 100644
>>> --- a/hw/virtio/virtio.c
>>> +++ b/hw/virtio/virtio.c
>>> @@ -322,6 +322,10 @@ static int virtio_queue_empty_rcu(VirtQueue *vq)
>>>           return 0;
>>>       }
>>>
>>> +    if (unlikely(!vq->vring.avail)) {
>>> +        return 0;
>> Shouldn't that rather return !0 (denoting a non-existing queue as
>> empty)?
> Yes, and the check should also go first (before the function can return=
 0).
>
> Paolo

Yes, will fix in V3.

Thanks
