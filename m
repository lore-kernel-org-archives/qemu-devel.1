Received: from eggs.gnu.org ([2001:4830:134:3::10]:32838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dBFyO-00086W-7A
	for qemu-devel@nongnu.org; Thu, 18 May 2017 03:35:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dBFyJ-000779-Ax
	for qemu-devel@nongnu.org; Thu, 18 May 2017 03:35:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1dBFyJ-00076w-58
	for qemu-devel@nongnu.org; Thu, 18 May 2017 03:35:43 -0400
References: <20170511123246.31308-1-maxime.coquelin@redhat.com>
	<20170511123246.31308-4-maxime.coquelin@redhat.com>
	<20170511202154-mutt-send-email-mst@kernel.org>
	<8101cc11-51b7-9361-6506-25986aa652c4@redhat.com>
	<20170517194008-mutt-send-email-mst@kernel.org>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <74684170-6dc8-3146-6a93-9c5dd723d1eb@redhat.com>
Date: Thu, 18 May 2017 09:35:29 +0200
MIME-Version: 1.0
In-Reply-To: <20170517194008-mutt-send-email-mst@kernel.org>
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



On 05/17/2017 06:41 PM, Michael S. Tsirkin wrote:
> On Fri, May 12, 2017 at 01:21:18PM +0200, Maxime Coquelin wrote:
>>
>> On 05/11/2017 07:33 PM, Michael S. Tsirkin wrote:
>>> On Thu, May 11, 2017 at 02:32:43PM +0200, Maxime Coquelin wrote:
>>>> Vhost-kernel backend need to receive IOTLB entries for rings
>>>> information early, but vhost-user need the same information
>>>> earlier, before VHOST_USER_SET_VRING_ADDR is sent.
>>> Weird. What does VHOST_USER_SET_VRING_ADDR have to do with it?
>>>
>>> According to
>>> 	Starting and stopping rings
>>> in vhost user spec, vhost user does not access
>>> anything until ring is started and enabled.
>>>
>>>
>>>> This patch also trigger IOTLB miss for all rings informations
>>>> for robustness, even if in practice these adresses are on the
>>>> same page.
>> Actually, the DPDK vhost-user backend is compliant with the spec,
>> but when handling VHOST_USER_SET_VRING_ADDR request, it translates the
>> guest addresses into backend VAs, and check they are valid. I will make the
>> commit message clearer about this in next revision.
>>
>> The check could be done later, for example when the ring are started,
>> but it wouldn't change the need to trigger a miss at some point.
> I think it should be done later, yes. As long as ring is not
> started addresses should not be interpreted.
> 

Ok, then I'll move these addresses translations in the
VHOST_USER_SET_VRING_KICK handler.

Thanks,
Maxime
