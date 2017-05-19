Received: from eggs.gnu.org ([2001:4830:134:3::10]:52502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dBeWx-00006c-1M
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:49:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dBeWu-0002pk-LH
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:49:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1dBeWu-0002oe-Av
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:49:04 -0400
References: <20170511123246.31308-1-maxime.coquelin@redhat.com>
	<20170511123246.31308-4-maxime.coquelin@redhat.com>
	<20170511202154-mutt-send-email-mst@kernel.org>
	<8101cc11-51b7-9361-6506-25986aa652c4@redhat.com>
	<20170517194008-mutt-send-email-mst@kernel.org>
	<74684170-6dc8-3146-6a93-9c5dd723d1eb@redhat.com>
	<34ccd41c-d799-21d9-ecf3-3903b68a24ea@redhat.com>
	<20170518181945-mutt-send-email-mst@kernel.org>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <9f994094-348e-3be9-de6b-e5a22c1c10be@redhat.com>
Date: Fri, 19 May 2017 11:48:52 +0200
MIME-Version: 1.0
In-Reply-To: <20170518181945-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/6] vhost: Update rings information for
 IOTLB earlier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: peterx@redhat.com, marcandre.lureau@gmail.com, vkaplans@redhat.com, jasowang@redhat.com, wexu@redhat.com, yuanhan.liu@linux.intel.com, qemu-devel@nongnu.org, jfreiman@redhat.com



On 05/18/2017 05:24 PM, Michael S. Tsirkin wrote:
> On Thu, May 18, 2017 at 04:45:23PM +0200, Maxime Coquelin wrote:
>> Hi Michael,
>>
>> On 05/18/2017 09:35 AM, Maxime Coquelin wrote:
>>>
>>>
>>> On 05/17/2017 06:41 PM, Michael S. Tsirkin wrote:
>>>> On Fri, May 12, 2017 at 01:21:18PM +0200, Maxime Coquelin wrote:
>>>>>
>>>>> On 05/11/2017 07:33 PM, Michael S. Tsirkin wrote:
>>>>>> On Thu, May 11, 2017 at 02:32:43PM +0200, Maxime Coquelin wrote:
>>>>>>> Vhost-kernel backend need to receive IOTLB entries for rings
>>>>>>> information early, but vhost-user need the same information
>>>>>>> earlier, before VHOST_USER_SET_VRING_ADDR is sent.
>>>>>> Weird. What does VHOST_USER_SET_VRING_ADDR have to do with it?
>>>>>>
>>>>>> According to
>>>>>>      Starting and stopping rings
>>>>>> in vhost user spec, vhost user does not access
>>>>>> anything until ring is started and enabled.
>>>>>>
>>>>>>
>>>>>>> This patch also trigger IOTLB miss for all rings informations
>>>>>>> for robustness, even if in practice these adresses are on the
>>>>>>> same page.
>>>>> Actually, the DPDK vhost-user backend is compliant with the spec,
>>>>> but when handling VHOST_USER_SET_VRING_ADDR request, it translates the
>>>>> guest addresses into backend VAs, and check they are valid. I
>>>>> will make the
>>>>> commit message clearer about this in next revision.
>>>>>
>>>>> The check could be done later, for example when the ring are started,
>>>>> but it wouldn't change the need to trigger a miss at some point.
>>>> I think it should be done later, yes. As long as ring is not
>>>> started addresses should not be interpreted.
>>>>
>>>
>>> Ok, then I'll move these addresses translations in the
>>> VHOST_USER_SET_VRING_KICK handler.
>> s/VHOST_USER_SET_VRING_KICK/VHOST_USER_SET_VRING_ENABLE/
> 
> Note that when protocol features are off ring is started in
> enabled state, but iommu requires protocol features.

OK, I will take care of this.

Note that currently in DPDK, the ring is created in enabled state,
so it is enabled as soon as started even with protocol features.
I have done the patch to fix this, will be posted with the patch that
do the ring addresses translations only when starting/enabling the ring.

Also, note that disabling VHOST_USER_F_PROTOCOL_FEATURES with latest
DPDK and QEMU seems broken. I'll add this to my todo list to understand
where the problem is, but this is lower priority.

>> I just looked at implementing this change, but I'm not convinced this is
>> the right thing to do.
>>
>> On backend side, it means saving temporarily the vhost_vring_addr struct
>> into the vq struct, and moving all what is done currently in
>> SET_VRING_ADDR handler to SET_VRING_ENABLE one.
> 
> Yes, and this is consistent with what the kernel does.
> 
>> My understanding of the "Starting and stopping rings" chapter of the
>> spec is that the ring must not be processed as long as not started and
>> enabled, not that the addresses passed should not be checked/translated
>> as it is done today both in DPDK and libvhost-user.
>>
>> If the addresses are invalid, isn't it better to know as soon as
>> possible?
>>
>> Cheers,
>> Maxime
> 
> There could be valid reasons to set an invalid address temporarily.
> For example to make sure connection is reset.

Ok.

Thanks,
Maxime
