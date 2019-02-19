Received: from eggs.gnu.org ([209.51.188.92]:37962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gw1o0-0004bp-On
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 04:35:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gw1nu-0000kD-VL
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 04:35:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gw1nu-0000k0-Kt
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 04:35:06 -0500
References: <20190215174659.4007-1-v.maffione@gmail.com>
	<5159fece-5573-7d9e-b6fe-c5832138d63e@redhat.com>
	<CA+_eA9jMpjAvpX94N36+Kp52xZrtr6gbu=n9G78yYhnZRKYxgg@mail.gmail.com>
	<dcb76591-c022-a81e-43bc-fbb9b6830d15@redhat.com>
	<CA+_eA9j-OPfLNagPAoSPSZRBtsVFEPsBWg0-U7jfQxAYEZTdWA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d55bba13-9e03-77f3-998e-ea0c2c5ceccc@redhat.com>
Date: Tue, 19 Feb 2019 17:35:02 +0800
MIME-Version: 1.0
In-Reply-To: <CA+_eA9j-OPfLNagPAoSPSZRBtsVFEPsBWg0-U7jfQxAYEZTdWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 0/1] Allow TAP to unnegotiate virtio-net
 header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vincenzo Maffione <v.maffione@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>


On 2019/2/19 =E4=B8=8B=E5=8D=884:28, Vincenzo Maffione wrote:
> Il giorno mar 19 feb 2019 alle ore 07:48 Jason Wang <jasowang@redhat.co=
m>
> ha scritto:
>
>> On 2019/2/18 =E4=B8=8B=E5=8D=887:53, Vincenzo Maffione wrote:
>>> Hi Jason,
>>>     Thanks for the quick reply.
>>>
>>> My PV device (to be open sourced soon) uses the QEMU net backend
>> interface,
>>> in a way similar to virtio-net.
>>> For example it uses qemu_set_offload(), qemu_has_vnet_hdr_len(),
>>> qemu_using_vnet_hdr(), qemu_send_packet(), etc.
>>> This means that the device itself does not know which net backend is
>> using,
>>> of course.
>>> In addition to TAP, also the netmap backend supports the virtio-net
>> header,
>>> and so the PV device will work with both.
>>> Regarding the virtio-net header, the netmap backend is more flexible
>>> because you can change the virtio-net header length as you wish (choo=
sing
>>> between 0, 10 and 12 bytes).
>>
>> Interesting, actually, there's case that vnet header is not used even
>> for virtio-net, e.g for the case of XDP withouth csum support. If we
>> don't pass vnet header in this case, we may get even higher PPS.
>>
> I guess in this case we simply pass a zeroed header. According to my
> experience I think it's unlikely that PPS are affected by having 12
> additional bytes to copy around, as long as no processing is done on th=
e
> header. I may be wrong of course.


The problem is device doesn't know whether it was zeroed, so it need to=20
examine some fields.

Thanks


>
>>
>>> My problem cannot be solved by making sure that TAPs are opened witho=
ut
>>> IFF_VNET_HDR. What I want instead
>>> is to dynamically change the length of the virtio-net header that the
>>> backend accepts, switching between 12 bytes (virtio 1.0 header) and 0=
 (no
>>> header). By "dynamically" I mean while the guest (and the device) is
>>> running. This is possible and safe if we get rid of that assert().
>>> The virtio-net device does not need that flexibility (once you enable=
 the
>>> vtnet header, you never disable that again), so I guess that's why yo=
u
>> have
>>> that assert().
>>> My PV device can be reconfigured on the fly in such a way it may or n=
ot
>> may
>>> be aware of the virtio-net header, and as a consequence it may need t=
o
>> call
>>> qemu_using_vnet_hdr() with true or false (multiple times).
>>>
>>> Does it make sense?
>>
>> Yes, it is. But I think maybe it's better to send this patch with your
>> new PV device implementation.
>>
>> Sounds good, thanks.
> Cheers,
>    Vincenzo
>
>
>> Thanks
>>
>>
>>> Cheers,
>>>     Vincenzo
>>>
>>>
>>> Il giorno lun 18 feb 2019 alle ore 05:19 Jason Wang <jasowang@redhat.=
com
>>>
>>> ha scritto:
>>>
>>>> On 2019/2/16 =E4=B8=8A=E5=8D=881:46, Vincenzo Maffione wrote:
>>>>> Hi,
>>>>>      I was doing experiments with a custom paravirtualized net devi=
ce,
>>>>> and I ran into a limitation of the TAP backend. I see from the kern=
el
>>>>> code that it is not possible to set the TAP virtio-net header
>>>>> length to something different from 10 or 12, which means that it
>>>>> is not possible to set it to 0. That's fine.
>>>>> The QEMU implementation of the TAP backend already supports
>>>>> the case where virtio-net header is set to 10 or 12 in kernel,
>>>>> but the emulated/paravirtualized net device is not using that:
>>>>> the TAP backend will just strip/prepend a zeroed header in this cas=
e
>>>>> (e.g., see the if statement in tap_receive_iov()).
>>>>> However, the tap_using_vnet_hdr() has an assert() that prevents
>>>>> this situation to happen, and I don't understand why. Maybe it
>>>>> is a leftover? I tried to remove the assert and by doing that
>>>>> my paravirtualized device was able to stop using the virtio-net
>>>>> header.
>>>> Hi:
>>>>
>>>> If  I understand this correctly, your PV device is API compatible wi=
th
>>>> TAP? Then you may just adding code to call TUNSETIFF without
>> IFF_VNET_HDR?
>>>> Thanks
>>>>
>>>>
>>>>> Vincenzo Maffione (1):
>>>>>      net: tap: allow net frontends to un-negotiate virtio-net heade=
r
>>>>>
>>>>>     net/tap.c | 1 -
>>>>>     1 file changed, 1 deletion(-)
>>>>>
>
