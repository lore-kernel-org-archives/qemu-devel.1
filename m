Received: from eggs.gnu.org ([2001:4830:134:3::10]:50975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dHnkJ-0007iu-Te
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 04:52:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dHnkF-0002UC-NU
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 04:52:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dHnkF-0002TU-Ds
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 04:52:15 -0400
References: <20170526142858.19931-1-maxime.coquelin@redhat.com>
	<20170530211819-mutt-send-email-mst@kernel.org>
	<7d4af4dd-270b-605f-9535-7bf8323e74c2@redhat.com>
	<20170601165540-mutt-send-email-mst@kernel.org>
	<04975954-9972-d900-0a88-b0a2587766e1@redhat.com>
	<20170602180458-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ea6e599e-a50f-3a1c-c61e-fdfcbf706e7f@redhat.com>
Date: Mon, 5 Jun 2017 16:51:55 +0800
MIME-Version: 1.0
In-Reply-To: <20170602180458-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: yuanhan.liu@linux.intel.com, qemu-devel@nongnu.org, peterx@redhat.com, Maxime Coquelin <maxime.coquelin@redhat.com>, marcandre.lureau@gmail.com, wexu@redhat.com, vkaplans@redhat.com, jfreiman@redhat.com



On 2017=E5=B9=B406=E6=9C=8802=E6=97=A5 23:24, Michael S. Tsirkin wrote:
> On Fri, Jun 02, 2017 at 01:53:11PM +0800, Jason Wang wrote:
>>
>> On 2017=E5=B9=B406=E6=9C=8801=E6=97=A5 21:59, Michael S. Tsirkin wrote=
:
>>> On Wed, May 31, 2017 at 04:33:33PM +0800, Jason Wang wrote:
>>>> On 2017=E5=B9=B405=E6=9C=8831=E6=97=A5 02:20, Michael S. Tsirkin wro=
te:
>>>>> On Fri, May 26, 2017 at 04:28:52PM +0200, Maxime Coquelin wrote:
>>>>>> This series aims at specifying ans implementing the protocol updat=
e
>>>>>> required to support device IOTLB with user backends.
>>>>>>
>>>>>> In this second non-RFC version, main changes are:
>>>>>>     - spec fixes and clarification
>>>>>>     - rings information update has been restored back to ring enab=
lement time
>>>>>>     - Work around GCC 4.4.7 limitation wrt assignment in unnamed u=
nion at
>>>>>> declaration time.
>>>>>>
>>>>>> The series can be tested with vhost_iotlb_proto_v2 branch on my gi=
tlab
>>>>>> account[0].
>>>>>>
>>>>>> The slave requests channel part is re-used from Marc-Andr=C3=A9's =
series submitted
>>>>>> last year[1], with main changes from original version being reques=
t/feature
>>>>>> names renaming and addition of the REPLY_ACK feature support.
>>>>>>
>>>>>> Regarding IOTLB protocol, one noticeable change is the IOTLB miss =
request
>>>>>> reply made optionnal (i.e. only if slave requests it by setting th=
e
>>>>>> VHOST_USER_NEED_REPLY flag in the message header). This change pro=
vides
>>>>>> more flexibility in the backend implementation of the feature.
>>>>>>
>>>>>> The protocol is very close to kernel backends, except that a new
>>>>>> communication channel is introduced to enable the slave to send
>>>>>> requests to the master.
>>>>>>
>>>>>> [0]:https://gitlab.com/mcoquelin/dpdk-next-virtio/commits/vhost_io=
tlb_proto_v2
>>>>>> [1]:https://lists.gnu.org/archive/html/qemu-devel/2016-04/msg00095=
.html
>>>>> Overall, this looks good to me. I do think patch 3 isn't a good ide=
a
>>>>> though, if slave wants something let it request it.
>>>>>
>>>>> Need to find out why does vhost in kernel want the used ring iotlb =
at
>>>>> start time - especially considering we aren't even guaranteed one e=
ntry
>>>>> covers the whole ring, and invalidates should affect all addresses =
at
>>>>> least in theory.
>>>>>
>>>>>
>>>> The reason is probably we want to verify whether or not we could cor=
rectly
>>>> access used ring in vhost_vq_init_access(). It was there since vhost=
_net is
>>>> introduced. We can think to remove this limitation maybe.
>>>>
>>>> Thanks
>>> Well that's only called if iotlb is disabled:
>>>
>>>           if (!vq->iotlb &&
>>>               !access_ok(VERIFY_READ, &vq->used->idx, sizeof vq->used=
->idx)) {
>>>                   r =3D -EFAULT;
>>>                   goto err;
>>>           }
>>>
>>> Could you try removing that and see what breaks?
>>>
>> Looks not, the issue is vhost_update_used_flags() which needs device I=
OTLB
>> translation. If we don't fill IOTLB in advance, it will return -EFAULT=
.
> Same for vhost_get_used, right?

Yes.

>
>> For simplicity, I don't implement control path device IOTLB miss.
>
> OK so this should be documented in vhost.h.  SET_BACKEND immediately
> writes and reads used ring. User must know this and pre-fault used flag=
s
> and index before setting backend.

Ok.

>> If you
>> care about the incomplete length, we can refine vhost_iotlb_miss() to =
make
>> sure it covers all size.
>>
>> Thanks
> No need imho, it's only the used flags field that's written, and the
> index that's read right?

Yes.

>    BTW I don't really know why do we do the write
> when event index is setup.  We probably shouldn't, should we?

Yes, looks like we shouldn't.

>
> It's worth considering whether we want this write into used ring at all=
.
> I put it there originally to help make sure we don't miss the first exi=
t, but
> event index seems to get by fine without this. So why does non event
> index code want it?

Spec said driver must initialize it to zero, so unless we want to=20
workaround a buggy driver we can remove this.

>
> I think that if we could get rid of both accesses, it would be
> nice. Would need a feature bit naturally and we'd need to
> support old kernels but at least it will be contained and
> well documented.
>

Technically we can, but we still need a workaround for old kernels. So=20
I'm not sure it's worth to do.

Thanks
