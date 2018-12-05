Received: from eggs.gnu.org ([208.118.235.92]:42745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gUNVZ-0008BN-8q
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 22:05:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gUNS8-000614-Lg
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 22:02:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gUNS8-0005zU-7V
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 22:02:20 -0500
References: <CAHyh4xgZhGnEvkD5RiUazZ9Eq_jzr4=bXHfwBvCBkbOLN2UyKA@mail.gmail.com>
	<915953bd-cc9c-9456-b619-297138f68ae6@redhat.com>
	<20181204205541-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <fc1150b2-f71a-b527-cce1-9b33e0a11c6a@redhat.com>
Date: Wed, 5 Dec 2018 11:02:11 +0800
MIME-Version: 1.0
In-Reply-To: <20181204205541-mutt-send-email-mst@kernel.org>
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


On 2018/12/5 =E4=B8=8A=E5=8D=889:59, Michael S. Tsirkin wrote:
> On Wed, Dec 05, 2018 at 09:30:19AM +0800, Jason Wang wrote:
>> On 2018/12/5 =E4=B8=8A=E5=8D=882:37, Jintack Lim wrote:
>>> Hi,
>>>
>>> I'm wondering how the current implementation works when logging dirty
>>> pages during migration from vhost-net (in kernel) when used vIOMMU.
>>>
>>> I understand how vhost-net logs GPAs when not using vIOMMU. But when
>>> we use vhost with vIOMMU, then shouldn't vhost-net need to log the
>>> translated address (GPA) instead of the address written in the
>>> descriptor (IOVA) ? The current implementation looks like vhost-net
>>> just logs IOVA without translation in vhost_get_vq_desc() in
>>> drivers/vhost/net.c. It seems like QEMU doesn't do any further
>>> translation of the dirty log when syncing.
>>>
>>> I might be missing something. Could somebody shed some light on this?
>>
>> Good catch. It looks like a bug to me. Want to post a patch for this?
> This isn't going to be a quick fix: IOTLB UAPI is translating
> IOVA values directly to uaddr.
>
> So to fix it, we need to change IOVA messages to translate to GPA
> so GPA can be logged.
>
> for existing userspace We can try reverse translation uaddr->gpa as a
> hack for logging but that translation was never guaranteed to be unique=
.


We have memory table in vhost as well, so looks like we can do this in=20
kernel as well without disturbing UAPI?

Thanks


>
> Jason I think you'll have to work on it given the complexity.
>
>> Thanks
>>
>>
>>> Thanks,
>>> Jintack
>>>
>>>
