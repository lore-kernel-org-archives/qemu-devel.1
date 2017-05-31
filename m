Received: from eggs.gnu.org ([2001:4830:134:3::10]:51864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dFz4p-0003lV-Jh
	for qemu-devel@nongnu.org; Wed, 31 May 2017 04:34:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dFz4l-0007H0-Ln
	for qemu-devel@nongnu.org; Wed, 31 May 2017 04:33:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dFz4l-0007Ge-FT
	for qemu-devel@nongnu.org; Wed, 31 May 2017 04:33:55 -0400
References: <20170526142858.19931-1-maxime.coquelin@redhat.com>
	<20170530211819-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7d4af4dd-270b-605f-9535-7bf8323e74c2@redhat.com>
Date: Wed, 31 May 2017 16:33:33 +0800
MIME-Version: 1.0
In-Reply-To: <20170530211819-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/6] vhost-user: Specify and implement
 device IOTLB support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: peterx@redhat.com, marcandre.lureau@gmail.com, vkaplans@redhat.com, wexu@redhat.com, yuanhan.liu@linux.intel.com, qemu-devel@nongnu.org, jfreiman@redhat.com



On 2017=E5=B9=B405=E6=9C=8831=E6=97=A5 02:20, Michael S. Tsirkin wrote:
> On Fri, May 26, 2017 at 04:28:52PM +0200, Maxime Coquelin wrote:
>> This series aims at specifying ans implementing the protocol update
>> required to support device IOTLB with user backends.
>>
>> In this second non-RFC version, main changes are:
>>   - spec fixes and clarification
>>   - rings information update has been restored back to ring enablement=
 time
>>   - Work around GCC 4.4.7 limitation wrt assignment in unnamed union a=
t
>> declaration time.
>>
>> The series can be tested with vhost_iotlb_proto_v2 branch on my gitlab
>> account[0].
>>
>> The slave requests channel part is re-used from Marc-Andr=C3=A9's seri=
es submitted
>> last year[1], with main changes from original version being request/fe=
ature
>> names renaming and addition of the REPLY_ACK feature support.
>>
>> Regarding IOTLB protocol, one noticeable change is the IOTLB miss requ=
est
>> reply made optionnal (i.e. only if slave requests it by setting the
>> VHOST_USER_NEED_REPLY flag in the message header). This change provide=
s
>> more flexibility in the backend implementation of the feature.
>>
>> The protocol is very close to kernel backends, except that a new
>> communication channel is introduced to enable the slave to send
>> requests to the master.
>>
>> [0]:https://gitlab.com/mcoquelin/dpdk-next-virtio/commits/vhost_iotlb_=
proto_v2
>> [1]:https://lists.gnu.org/archive/html/qemu-devel/2016-04/msg00095.htm=
l
> Overall, this looks good to me. I do think patch 3 isn't a good idea
> though, if slave wants something let it request it.
>
> Need to find out why does vhost in kernel want the used ring iotlb at
> start time - especially considering we aren't even guaranteed one entry
> covers the whole ring, and invalidates should affect all addresses at
> least in theory.
>
>

The reason is probably we want to verify whether or not we could=20
correctly access used ring in vhost_vq_init_access(). It was there since=20
vhost_net is introduced. We can think to remove this limitation maybe.

Thanks
