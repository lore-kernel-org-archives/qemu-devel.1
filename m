Received: from eggs.gnu.org ([2001:4830:134:3::10]:33803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ctBWy-0001zW-Lz
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 07:12:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ctBWv-0001od-BH
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 07:12:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59369)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1ctBWv-0001kM-19
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 07:12:45 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2TB8il8081250
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 07:12:41 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29gav8tcwd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 07:12:41 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 29 Mar 2017 12:12:38 +0100
References: <20170302185942.76255-1-pasic@linux.vnet.ibm.com>
	<20170303132149.34e5906a.cornelia.huck@de.ibm.com>
	<aa9b9219-f3a6-165c-2d92-156a9295adbb@linux.vnet.ibm.com>
	<20170303135012.17edb640.cornelia.huck@de.ibm.com>
	<d00802cc-150a-2263-604d-9c2eaa5c19d1@linux.vnet.ibm.com>
	<20170306155625.5c426793.cornelia.huck@de.ibm.com>
	<bf1f8af2-9d76-c148-24c5-7d00312c10d4@linux.vnet.ibm.com>
	<20170306170441.2a8f8b27.cornelia.huck@de.ibm.com>
	<20170323190609-mutt-send-email-mst@kernel.org>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 29 Mar 2017 13:12:35 +0200
MIME-Version: 1.0
In-Reply-To: <20170323190609-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Message-Id: <a286a86e-cc7f-27f5-98f1-a2836e0898d4@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] virtio: fail device if
 set_event_notifier fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: qemu-devel@nongnu.org



On 03/23/2017 06:09 PM, Michael S. Tsirkin wrote:
> On Mon, Mar 06, 2017 at 05:04:41PM +0100, Cornelia Huck wrote:
>> On Mon, 6 Mar 2017 16:21:13 +0100
>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
>>
>>> On 03/06/2017 03:56 PM, Cornelia Huck wrote:
>>>> On Fri, 3 Mar 2017 14:08:37 +0100
>>>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
>>>>
>>>>> On 03/03/2017 01:50 PM, Cornelia Huck wrote:
>>>>>> On Fri, 3 Mar 2017 13:43:32 +0100
>>>>>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
>>>>>>
>>>>>>> On 03/03/2017 01:21 PM, Cornelia Huck wrote:
>>>>>>>> On Thu,  2 Mar 2017 19:59:42 +0100
>>>>>>>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
>>> [...]
>>>>> I admit, I did not investigate this thoroughly, also because the pa=
tch
>>>>> is flawed regarding multi-thread anyway. After a quick investigatio=
n
>>>>> it seems the linux guest won't auto-reset the device so the guest s=
hould
>>>>> end up with a not working device. I think it's pretty likely that t=
he
>>>>> admin will check the logs if the device was important.
>>>>
>>>> Thinking a bit more about this, it seems setting the device broken i=
s
>>>> not the right solution for exactly that reason. Setting the virtio
>>>> device broken is a way to signal the guest to 'you did something
>>>> broken; please reset the device and start anew' (and that's how curr=
ent
>>>> callers use it). In our case, this is not the guest's fault.
>>>
>>> Do we have something to just say stuff broken without blaming the gue=
st?
>>> And device reset might not be that stupid at all in the given situati=
on,
>>> if we want to save what can be saved from the perspective of the gues=
t.
>>> (After reset stuff should work again until we hit the race again -- a=
nd
>>> since turning ioeventfd on/off should not happen that often during no=
rmal
>>> operation it could help limit damage suffered -- e.g. controlled shut=
down).
>>
>> Checking again, the spec says
>>
>> DEVICE_NEEDS_RESET (64) Indicates that the device has experienced an
>> error from which it can=E2=80=99t recover.
>>
>> Nothing about 'guest error'.
>>
>> The only problem is that legacy devices don't have that state, which
>> means they'll have a broken device through no fault of their own.
>>
>>>
>>>>
>>>> Maybe go back to the assert 'solution'? But I'm not sure that's enou=
gh
>>>> if production builds disable asserts...
>>>>
>>>
>>> I will wait a bit, maybe other virtio folks are going to have an=20
>>> opinion too.
>>>
>>> My concern about the assert solution is that for production it is
>>> either too rigorous (kill off, hopefully with a dump) or not
>>> enough (as you have mentioned, if NDEBUG assert does nothing).
>>>
>>>
>>> I think there are setups where a loss of device does not have to be
>>> fatal, and I would not like to be the one who makes it fatal (for the
>>> guest).
>>
>> Basically, it's a host bug (and not a bug specific to a certain
>> device). Moving the device which was impacted to a broken state may be
>> a useful mitigation.
>>
>> But yes, let's hear some other opinions.
>=20
> We don't support NDEBUG really so I think an assert is fine for now.

Thanks for your reply! You are right, virtio.c makes sure we do not have
NDEBUG defined, but at the very same  place a todo comment suggests that
not supporting NDEBUG is a temporary measure (and a so called technical
debt).

If my understanding is correct, I should use assert instead of
virtio_error for the next version. I that right?

> Handling unexpected errors more gracefully is laudable but I think we
> want a more systematic approach than just open-coding it in
> this specific place.
>=20

Sorry, I mistook virtio_error for the systematic approach for handling
(expected and unexpected) errors in virtio. Should I create a patch which
documents what is considered an (in)appropriate usage of virtio_error?

AFAIU (based on Connie's comments) virtio_error should not be used for
reporting QEMU errors (or should only be used to report guest errors).

By the way I have read the exchange on '[PATCH 1/5] virtio: Error object
based virtio_error()'. The things you suggest there do make a lot of
sense to me. Unfortunately I can't tell if I'm going to have the time to
come up with an appropriate patch(set), so I won't volunteer for now.

Regards,

Halil
