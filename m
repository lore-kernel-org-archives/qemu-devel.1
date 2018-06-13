Received: from eggs.gnu.org ([2001:4830:134:3::10]:47413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fT9ZI-0003Ej-GT
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 13:28:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fT9ZD-0005uo-DZ
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 13:28:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47424
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1fT9ZC-0005oC-Mw
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 13:28:19 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5DHOeDW010062
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 13:28:16 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2jk655ck94-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 13:28:16 -0400
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Wed, 13 Jun 2018 18:28:14 +0100
References: <cover.1528832686.git.alifm@linux.ibm.com>
	<dd7e90c5b3de6f98218908c7f57d9d0286089ad5.1528832686.git.alifm@linux.ibm.com>
	<20180613093700.GG27901@redhat.com>
	<7b51465a-b7c1-58ec-1ef6-9fe791e96bbf@linux.ibm.com>
	<20180613150512.GA19901@redhat.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Wed, 13 Jun 2018 19:28:08 +0200
MIME-Version: 1.0
In-Reply-To: <20180613150512.GA19901@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <5833f4ec-dcd1-19ac-2848-facf31aec7cf@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v1 1/1] virtio-crypto: Allow disabling of
 cipher algorithms for virtio-crypto device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Farhan Ali <alifm@linux.ibm.com>
Cc: qemu-devel@nongnu.org, frankja@linux.ibm.com, mst@redhat.com, borntraeger@de.ibm.com, arei.gonglei@huawei.com, longpeng2@huawei.com, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, mjrosato@linux.vnet.ibm.com



On 06/13/2018 05:05 PM, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Jun 13, 2018 at 11:01:05AM -0400, Farhan Ali wrote:
>> Hi Daniel
>>
>> On 06/13/2018 05:37 AM, Daniel P. Berrang=C3=A9 wrote:
>>> On Tue, Jun 12, 2018 at 03:48:34PM -0400, Farhan Ali wrote:
>>>> The virtio-crypto driver currently propagates to the guest
>>>> all the cipher algorithms that the backend cryptodev can
>>>> support. But in certain cases where the guest has more
>>>> performant mechanism to handle some algorithms, it would be
>>>> useful to propagate only a subset of the algorithms.
>>>
>>> I'm not really convinced by this.
>>>
>>> The performance of crypto algorithms has many influencing
>>> factors, making it pretty hard to decide which is best
>>> without actively testing specific impls and comparing
>>> them in a manner which matches the application usage
>>> pattern. eg in theory the kernel crypto impl of an alg
>>> is faster than a userspace impl, if the kernel uses
>>> hardware accel and userspace does not. This, however,
>>> ignores the overhead of the kernel/userspace switch.
>>> The real world performance winner, thus depends on the
>>> amount of data being processed in each operation. Some
>>> times userspace can win & sometimes kernel space can
>>> win. This is even more relevant to virtio-crypto as
>>> it has more expensive context switches.
>>
>> True. But what if the guest can perform some crypto algorithms without=
 a
>> incurring a VM exit? For example in s390 we have the cpacf instruction=
s to
>> perform crypto and this instruction is implemented for us by our hardw=
are
>> virtualization technology. In such a case it would be better not to us=
e
>> virtio-crypto's implementation of such a crypto algorithm.
>>
>> At the same time we would like to take advantage of virtio-crypto's
>> acceleration capabilities for certain crypto algorithms for which ther=
e is
>> no hardware assistance.
>=20
> IIUC, the kernel's crypto layer can support multiple implementations of
> any algorithm. Providers can report a priority against implementations
> which influences which impl is used in practice. So if there's a native
> instruction for a partiuclar algorithm I would expect the impl register=
ed
> for that to be designated higher priority than other impls, so that it =
is
> used in preference to other impls.
>=20

AFAIR the problem here is that in (the guest) kernel the virtio-crypto
driver has to register it's crypto algo implementations with a priority
(single number), which dictates if it's going to be the preferred (used)
implementation of the algorithm or not. The virtio-crypto driver does thi=
s
without having information about the (comparative or absolute) performanc=
e
of it's implementation (which depends on the backend among others). I don=
't think
any dynamic re-prioritization of the algorithms takes place (e.g. based o=
n how these
perform in for the given configuration).

I think the strategy of the virtio-crypto is to rather overstate, than
understate the performance of it's implementation. If we were to 'be
conservative' and say, 'hey we don't know nothing about the performance,
let's make it lowest priority implementation' the implementations provide=
d
by virtio-crypto would end up being used only if there is no other
implementation. And that does not sound like a good idea either.

So the idea is to give the user the power to effectively not provide
an algorithm via virtio-crypto. That is, if the user observes a performan=
ce
degradation because of virtio-crypto, he can turn off the bad algorithms
at the device. That way overstatement becomes a much smaller problem.
The user can turn off the bad algorithms for reasons other than performan=
ce
too.

Of course there are other ways to deal with the problem of virtio-crypto
driver not knowing how good it's implementation of a given algo is. We
could make the in kernel crypto priorities dynamically adjustable in gene=
ral
or we could provide the user with means to specify the priorities (e.g.
as module parameter) with which the virtio-crypto driver registers each a=
lgo.
Both of these would be knobs in the guest. It's hard to tell if these fir=
st
one would be useful in scenarios not involving virtualization. Same goes
for some kind of dynamic priority management for crypto algorithm impleme=
ntations
in the Linux kernel. I assume the people involved with the respective
subsystem do not see the necessity for something like that.

I hope, this clarifies the idea behind this patch.

Regards,
Halil
