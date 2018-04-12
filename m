Received: from eggs.gnu.org ([2001:4830:134:3::10]:43722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f6Yix-0007aB-0V
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 05:41:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f6Yis-00047k-16
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 05:40:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33870 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1f6Yir-00046m-S7
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 05:40:53 -0400
References: <20180411072027.5656-1-tiwei.bie@intel.com>
	<fc66437c-ae8c-15fa-c8d3-6aa6bdb22a36@redhat.com>
	<20180411083853.qa6y6zevjpvamrdx@debian>
	<20180411200127-mutt-send-email-mst@kernel.org>
	<20180412014439.d7uzqukwdejtmofh@debian>
	<0372329a-5106-e3ca-260a-8fe8aa5396b4@redhat.com>
	<20180412081014.l6umfz6hurczorl4@debian>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e1628d15-9ddd-f32a-fa10-88ba05d08fc2@redhat.com>
Date: Thu, 12 Apr 2018 17:40:32 +0800
MIME-Version: 1.0
In-Reply-To: <20180412081014.l6umfz6hurczorl4@debian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] vhost-user: introduce F_NEED_ALL_IOTLB
 protocol feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, peterx@redhat.com, qemu-devel@nongnu.org, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com



On 2018=E5=B9=B404=E6=9C=8812=E6=97=A5 16:10, Tiwei Bie wrote:
> On Thu, Apr 12, 2018 at 03:38:50PM +0800, Jason Wang wrote:
>> On 2018=E5=B9=B404=E6=9C=8812=E6=97=A5 09:44, Tiwei Bie wrote:
>>> On Wed, Apr 11, 2018 at 08:37:17PM +0300, Michael S. Tsirkin wrote:
>>>> On Wed, Apr 11, 2018 at 04:38:53PM +0800, Tiwei Bie wrote:
>>>>> On Wed, Apr 11, 2018 at 04:01:19PM +0800, Jason Wang wrote:
>>>>>> On 2018=E5=B9=B404=E6=9C=8811=E6=97=A5 15:20, Tiwei Bie wrote:
>>>>>>> This patch introduces VHOST_USER_PROTOCOL_F_NEED_ALL_IOTLB
>>>>>>> feature for vhost-user. By default, vhost-user backend needs
>>>>>>> to query the IOTLBs from QEMU after meeting unknown IOVAs.
>>>>>>> With this protocol feature negotiated, QEMU will provide all
>>>>>>> the IOTLBs to vhost-user backend without waiting for the
>>>>>>> queries from backend. This is helpful when using a hardware
>>>>>>> accelerator which is not able to handle unknown IOVAs at the
>>>>>>> vhost-user backend.
>>>>>>>
>>>>>>> Signed-off-by: Tiwei Bie<tiwei.bie@intel.com>
>>>>>>> ---
>>>>>>> The idea of this patch is to let QEMU push all the IOTLBs
>>>>>>> to vhost-user backend without waiting for the queries from
>>>>>>> the backend. Because hardware accelerator at the vhost-user
>>>>>>> backend may not be able to handle unknown IOVAs.
>>>>>>>
>>>>>>> This is just a RFC for now. It seems that, it doesn't work
>>>>>>> as expected when guest is using kernel driver (To handle
>>>>>>> this case, it seems that some RAM regions' events also need
>>>>>>> to be listened). Any comments would be appreciated! Thanks!
>>>>>> Interesting, a quick question is why this is needed? Can we just u=
se exist
>>>>>> IOTLB update message?
>>>>> Yeah, we are still using the existing IOTLB update messages
>>>>> to send the IOTLB messages to backend. The only difference
>>>>> is that, QEMU won't wait for the queries before sending the
>>>>> IOTLB update messages.
>>>> So I have a concern with that, in that without any flow
>>>> control the socket buffer used by vhost-user might become
>>>> full.
>>> Each IOTLB update message needs a reply. So I think it
>>> won't happen.
>> Is this what we've already done now? I don't find any statement on thi=
s in
>> vhost-user.txt?
>>
>> """
>>  =C2=A0* VHOST_USER_IOTLB_MSG
>>
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Id: 22
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Equivalent ioctl: N/A (equivalent to V=
HOST_IOTLB_MSG message type)
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Master payload: struct vhost_iotlb_msg
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Slave payload: u64
>>
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Send IOTLB messages with struct vhost_=
iotlb_msg as payload.
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Master sends such requests to update a=
nd invalidate entries in the
>> device
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IOTLB. The slave has to acknowledge th=
e request with sending zero as
>> u64
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 payload for success, non-zero otherwis=
e.
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This request should be send only when =
VIRTIO_F_IOMMU_PLATFORM feature
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 has been successfully negotiated.
>> """
> Yeah, it's what we've already done now. It's in the above
> statement you quoted:
>
> "The slave has to acknowledge the request with sending zero as
> u64 payload for success, non-zero otherwise."

My bad.

Actually, there's a minor optimization here. When QI is enabled, we only=20
need replay ack for wait descriptor, this allows some kinds of batching.=20
Another interesting idea is to send multiqueue request through a single=20
message.

Thanks

>
>> And you probably need to modify the following statement:
>>
>> """
>> The master isn't expected to take the initiative to send IOTLB update
>> messages,
>> as the slave sends IOTLB miss messages for the guest virtual memory ar=
eas it
>> needs to access.
>> """
> Yeah, you're right. Thanks! This statement needs some minor updates.
>
> Best regards,
> Tiwei Bie
>
>> Thanks
>>
>>
>>> Best regards,
>>> Tiwei Bie
>>>
