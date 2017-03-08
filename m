Received: from eggs.gnu.org ([2001:4830:134:3::10]:49955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1clYHm-0006V4-VE
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 04:53:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1clYHi-0003hE-4q
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 04:53:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1clYHh-0003h4-Uj
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 04:53:30 -0500
References: <1488876478-6889-1-git-send-email-jasowang@redhat.com>
	<313e32c5-140d-ec13-6b10-98043756f2e6@redhat.com>
	<f3e9db7e-f3ab-1ae5-4da6-05dbd8d0206f@redhat.com>
	<61938aa1-2698-f55e-ea1c-e7d96da0b5d7@redhat.com>
	<20170308103023.5e0d9d81.cornelia.huck@de.ibm.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <31903f0c-a3e7-6acc-5e31-84d08507c513@redhat.com>
Date: Wed, 8 Mar 2017 17:53:23 +0800
MIME-Version: 1.0
In-Reply-To: <20170308103023.5e0d9d81.cornelia.huck@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio: destroy region cache during reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com



On 2017=E5=B9=B403=E6=9C=8808=E6=97=A5 17:30, Cornelia Huck wrote:
> On Wed, 8 Mar 2017 14:22:06 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>
>> On 2017=E5=B9=B403=E6=9C=8808=E6=97=A5 11:21, Jason Wang wrote:
>>> On 2017=E5=B9=B403=E6=9C=8807=E6=97=A5 18:55, Paolo Bonzini wrote:
>>>> On 07/03/2017 09:47, Jason Wang wrote:
>>>>> We don't destroy region cache during reset which can make the maps
>>>>> of previous driver leaked to a buggy or malicious driver that don't
>>>>> set vring address before starting to use the device.
>>>> I'm still not sure as to how this can happen.  Reset does clear
>>>> desc/used/avail, which should then be checked before accessing the
>>>> caches.
>>> But the code does not check them in fact? (E.g the attached qtest
>>> patch can still pass check-qtest).
>>>
>>> Thanks
>> Ok, the reproducer seems wrong. And I think what you mean is something
>> like the check done in virtio_queue_ready(). But looks like not all
>> virtqueue check for this. One example is virtio_net_handle_ctrl(), and
> Shouldn't the check for desc in virtio_queue_notify_vq() already take
> care of that?

Yes, I miss this.

>
>> there may be even more. So you want to fix them all?
> Obviously not speaking for Paolo, but I think the virtio core should
> have be audited for missing guards.
>

Probably, otherwise we need a careful auditing of all callers of caches.

Thanks
