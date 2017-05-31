Received: from eggs.gnu.org ([2001:4830:134:3::10]:52822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dG5ce-0004d5-7p
	for qemu-devel@nongnu.org; Wed, 31 May 2017 11:33:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dG5ca-00055K-00
	for qemu-devel@nongnu.org; Wed, 31 May 2017 11:33:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1dG5cZ-00054W-NN
	for qemu-devel@nongnu.org; Wed, 31 May 2017 11:33:15 -0400
References: <20170526142858.19931-1-maxime.coquelin@redhat.com>
	<20170530211819-mutt-send-email-mst@kernel.org>
	<7d4af4dd-270b-605f-9535-7bf8323e74c2@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <a14b541b-ef48-9531-5697-4b5f213e53d9@redhat.com>
Date: Wed, 31 May 2017 17:32:59 +0200
MIME-Version: 1.0
In-Reply-To: <7d4af4dd-270b-605f-9535-7bf8323e74c2@redhat.com>
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
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: peterx@redhat.com, marcandre.lureau@gmail.com, vkaplans@redhat.com, wexu@redhat.com, yuanhan.liu@linux.intel.com, qemu-devel@nongnu.org, jfreiman@redhat.com

Hi,

On 05/31/2017 10:33 AM, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B405=E6=9C=8831=E6=97=A5 02:20, Michael S. Tsirkin wrote:
>> On Fri, May 26, 2017 at 04:28:52PM +0200, Maxime Coquelin wrote:
>>> This series aims at specifying ans implementing the protocol update
>>> required to support device IOTLB with user backends.
>>>
>>> In this second non-RFC version, main changes are:
>>>   - spec fixes and clarification
>>>   - rings information update has been restored back to ring=20
>>> enablement time
>>>   - Work around GCC 4.4.7 limitation wrt assignment in unnamed union =
at
>>> declaration time.
>>>
>>> The series can be tested with vhost_iotlb_proto_v2 branch on my gitla=
b
>>> account[0].
>>>
>>> The slave requests channel part is re-used from Marc-Andr=C3=A9's ser=
ies=20
>>> submitted
>>> last year[1], with main changes from original version being=20
>>> request/feature
>>> names renaming and addition of the REPLY_ACK feature support.
>>>
>>> Regarding IOTLB protocol, one noticeable change is the IOTLB miss=20
>>> request
>>> reply made optionnal (i.e. only if slave requests it by setting the
>>> VHOST_USER_NEED_REPLY flag in the message header). This change provid=
es
>>> more flexibility in the backend implementation of the feature.
>>>
>>> The protocol is very close to kernel backends, except that a new
>>> communication channel is introduced to enable the slave to send
>>> requests to the master.
>>>
>>> [0]:https://gitlab.com/mcoquelin/dpdk-next-virtio/commits/vhost_iotlb=
_proto_v2=20
>>>
>>> [1]:https://lists.gnu.org/archive/html/qemu-devel/2016-04/msg00095.ht=
ml
>> Overall, this looks good to me. I do think patch 3 isn't a good idea
>> though, if slave wants something let it request it.
>>
>> Need to find out why does vhost in kernel want the used ring iotlb at
>> start time - especially considering we aren't even guaranteed one entr=
y
>> covers the whole ring, and invalidates should affect all addresses at
>> least in theory.
>>
>>
>=20
> The reason is probably we want to verify whether or not we could=20
> correctly access used ring in vhost_vq_init_access(). It was there sinc=
e=20
> vhost_net is introduced. We can think to remove this limitation maybe.

Even if we remove the limitation on Kernel side, we will still have to
keep this workaround for compatibility with older kernels. Having done=20
the test, I can confirm it is currently necessary.

Thanks,
Maxime
