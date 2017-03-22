Received: from eggs.gnu.org ([2001:4830:134:3::10]:43529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cqZV2-00008V-A1
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 02:12:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cqZUx-0005hA-Bi
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 02:12:00 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:41332
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1cqZUx-0005h2-5N
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 02:11:55 -0400
References: <20170321223151.12984-1-Andrew.Baumann@microsoft.com>
	<158d19e3-feaf-84fb-6d7b-22f6204858fd@redhat.com>
	<DM5PR03MB2827F4507244124CB15683209E3D0@DM5PR03MB2827.namprd03.prod.outlook.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <b0b934af-0957-ce61-60ff-5cdf45e869f1@weilnetz.de>
Date: Wed, 22 Mar 2017 07:11:51 +0100
MIME-Version: 1.0
In-Reply-To: <DM5PR03MB2827F4507244124CB15683209E3D0@DM5PR03MB2827.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] virtio: fix vring_align() on 64-bit win32
 platforms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Baumann <Andrew.Baumann@microsoft.com>, Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>

Am 22.03.2017 um 00:06 schrieb Andrew Baumann:
>> From: Eric Blake [mailto:eblake@redhat.com]
>> Sent: Tuesday, 21 March 2017 15:52
>>
>> On 03/21/2017 05:31 PM, Andrew Baumann wrote:
>>> "long" is 32-bits on win32, but we need to promote it to a 64-bit hwaddr
>>> before negating, or else the top half of the address is truncated
>>>
>>> Signed-off-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
>>> ---
>>>  include/hw/virtio/virtio.h | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>>> index 15efcf2..a0a8543 100644
>>> --- a/include/hw/virtio/virtio.h
>>> +++ b/include/hw/virtio/virtio.h
>>> @@ -34,7 +34,7 @@ struct VirtQueue;
>>>  static inline hwaddr vring_align(hwaddr addr,
>>>                                               unsigned long align)
>>>  {
>>> -    return (addr + align - 1) & ~(align - 1);
>>> +    return (addr + align - 1) & ~(hwaddr)(align - 1);
>>
>> Why not just use the QEMU_ALIGN_DOWN macro, instead of open-coding it?
>
> Well, this code is aligning up, but yes the ALIGN_UP macro looks like it should also avoid the type promotion problem. This patch is just the minimally-invasive change after discovering the bug.
>
> Let me know if you want me to spin another patch with the macro.
>
> Andrew

Yes, please use QEMU_ALIGN_UP in an updated patch.
This is a bug fix needed for v2.9.0.

Fixing all other code locations which round up or down
with Coccinelle is a separate task, nothing which is
needed for the next QEMU version.

Thanks,
Stefan
