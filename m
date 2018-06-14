Received: from eggs.gnu.org ([2001:4830:134:3::10]:59287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fTUrT-0006uc-PB
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 12:12:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fTUrO-0005rn-OH
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 12:12:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42190
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1fTUrO-0005re-IG
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 12:12:30 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5EGADMS035641
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 12:12:30 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2jkt31nhss-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 12:12:29 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Thu, 14 Jun 2018 10:12:29 -0600
References: <cover.1528832686.git.alifm@linux.ibm.com>
	<dd7e90c5b3de6f98218908c7f57d9d0286089ad5.1528832686.git.alifm@linux.ibm.com>
	<20180613093700.GG27901@redhat.com>
	<7b51465a-b7c1-58ec-1ef6-9fe791e96bbf@linux.ibm.com>
	<20180613150512.GA19901@redhat.com>
	<5833f4ec-dcd1-19ac-2848-facf31aec7cf@linux.ibm.com>
	<20180614082155.GI6355@redhat.com>
	<79597909-fdb5-2983-19ac-74332229c8ef@linux.ibm.com>
	<20180614151048.GA18967@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Thu, 14 Jun 2018 12:12:23 -0400
MIME-Version: 1.0
In-Reply-To: <20180614151048.GA18967@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <28dca328-6920-91a1-0962-b336a3ffcb5b@linux.ibm.com>
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
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, qemu-devel@nongnu.org, frankja@linux.ibm.com, mst@redhat.com, borntraeger@de.ibm.com, arei.gonglei@huawei.com, longpeng2@huawei.com, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, mjrosato@linux.vnet.ibm.com



On 06/14/2018 11:10 AM, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Jun 14, 2018 at 10:50:40AM -0400, Farhan Ali wrote:
>>
>>
>> On 06/14/2018 04:21 AM, Daniel P. Berrang=C3=A9 wrote:
>>> On Wed, Jun 13, 2018 at 07:28:08PM +0200, Halil Pasic wrote:
>>>>
>>>>
>>>> On 06/13/2018 05:05 PM, Daniel P. Berrang=C3=A9 wrote:
>>>>> On Wed, Jun 13, 2018 at 11:01:05AM -0400, Farhan Ali wrote:
>>>>>> Hi Daniel
>>>>>>
>>>>>> On 06/13/2018 05:37 AM, Daniel P. Berrang=C3=A9 wrote:
>>>>>>> On Tue, Jun 12, 2018 at 03:48:34PM -0400, Farhan Ali wrote:
>>>>>>>> The virtio-crypto driver currently propagates to the guest
>>>>>>>> all the cipher algorithms that the backend cryptodev can
>>>>>>>> support. But in certain cases where the guest has more
>>>>>>>> performant mechanism to handle some algorithms, it would be
>>>>>>>> useful to propagate only a subset of the algorithms.
>>>>>>>
>>>>>>> I'm not really convinced by this.
>>>>>>>
>>>>>>> The performance of crypto algorithms has many influencing
>>>>>>> factors, making it pretty hard to decide which is best
>>>>>>> without actively testing specific impls and comparing
>>>>>>> them in a manner which matches the application usage
>>>>>>> pattern. eg in theory the kernel crypto impl of an alg
>>>>>>> is faster than a userspace impl, if the kernel uses
>>>>>>> hardware accel and userspace does not. This, however,
>>>>>>> ignores the overhead of the kernel/userspace switch.
>>>>>>> The real world performance winner, thus depends on the
>>>>>>> amount of data being processed in each operation. Some
>>>>>>> times userspace can win & sometimes kernel space can
>>>>>>> win. This is even more relevant to virtio-crypto as
>>>>>>> it has more expensive context switches.
>>>>>>
>>>>>> True. But what if the guest can perform some crypto algorithms wit=
hout a
>>>>>> incurring a VM exit? For example in s390 we have the cpacf instruc=
tions to
>>>>>> perform crypto and this instruction is implemented for us by our h=
ardware
>>>>>> virtualization technology. In such a case it would be better not t=
o use
>>>>>> virtio-crypto's implementation of such a crypto algorithm.
>>>>>>
>>>>>> At the same time we would like to take advantage of virtio-crypto'=
s
>>>>>> acceleration capabilities for certain crypto algorithms for which =
there is
>>>>>> no hardware assistance.
>>>>>
>>>>> IIUC, the kernel's crypto layer can support multiple implementation=
s of
>>>>> any algorithm. Providers can report a priority against implementati=
ons
>>>>> which influences which impl is used in practice. So if there's a na=
tive
>>>>> instruction for a partiuclar algorithm I would expect the impl regi=
stered
>>>>> for that to be designated higher priority than other impls, so that=
 it is
>>>>> used in preference to other impls.
>>>>>
>>>>
>>>> AFAIR the problem here is that in (the guest) kernel the virtio-cryp=
to
>>>> driver has to register it's crypto algo implementations with a prior=
ity
>>>> (single number), which dictates if it's going to be the preferred (u=
sed)
>>>> implementation of the algorithm or not. The virtio-crypto driver doe=
s this
>>>> without having information about the (comparative or absolute) perfo=
rmance
>>>> of it's implementation (which depends on the backend among others). =
I don't think
>>>> any dynamic re-prioritization of the algorithms takes place (e.g. ba=
sed on how these
>>>> perform in for the given configuration).
>>>>
>>>> I think the strategy of the virtio-crypto is to rather overstate, th=
an
>>>> understate the performance of it's implementation. If we were to 'be
>>>> conservative' and say, 'hey we don't know nothing about the performa=
nce,
>>>> let's make it lowest priority implementation' the implementations pr=
ovided
>>>> by virtio-crypto would end up being used only if there is no other
>>>> implementation. And that does not sound like a good idea either.
>>>
>>>
>>> This problem you describe, however, is something that applies to *any=
*
>>> kerenl code that is registering a crypto algo impl for accelerator
>>> hardware. A non-virtualized crypto cards in bare metal likewise canno=
t
>>> assume that its AES impl is better then the host CPU's  aes-ni instru=
ction.
>>>
>>>> So the idea is to give the user the power to effectively not provide
>>>> an algorithm via virtio-crypto. That is, if the user observes a perf=
ormance
>>>> degradation because of virtio-crypto, he can turn off the bad algori=
thms
>>>> at the device. That way overstatement becomes a much smaller problem.
>>>> The user can turn off the bad algorithms for reasons other than perf=
ormance
>>>> too.
>>>>
>>>> Of course there are other ways to deal with the problem of virtio-cr=
ypto
>>>> driver not knowing how good it's implementation of a given algo is. =
We
>>>> could make the in kernel crypto priorities dynamically adjustable in=
 general
>>>> or we could provide the user with means to specify the priorities (e=
.g.
>>>> as module parameter) with which the virtio-crypto driver registers e=
ach algo.
>>>> Both of these would be knobs in the guest. It's hard to tell if thes=
e first
>>>> one would be useful in scenarios not involving virtualization. Same =
goes
>>>> for some kind of dynamic priority management for crypto algorithm im=
plementations
>>>> in the Linux kernel. I assume the people involved with the respectiv=
e
>>>> subsystem do not see the necessity for something like that.
>>>
>>> It still feels like this is a problem for the guest OS to solve. If y=
ou
>>> put a physical crypto accelerator in a bare metal machine, that has t=
he
>>> same problem you describe here, so the kernel surely already needs to=
 find
>>> a viable solution for this problem.
>>>
>>
>> How would the guest OS know which algo is better? As you mentioned it =
does
>> depend on few factors and the best the kernel can do is use some sort =
of
>> heuristics. Such a solution might not be very dynamic and might not wo=
rk for
>> all the cases for a user.
>=20
> Which is better will likely depend on the application using it. One mig=
ht
> be better for use by the kernel, while another is better for use by a
> userspace application, or two userspace apps might have different prefe=
rences.
>=20
>> Shouldn't we use virtualization to give us the flexibility that we don=
't
>> have with physical crypto accelerator? The crypto accelerator might no=
t know
>> if it's implementation is any better, but the user can experiment and =
see
>> what works better.
>=20
> It is better to provide it all to the guest and let the guest decide wh=
ich
> is best to use.  If nothing else the virtio-crypto kernel module itself
> can have module parameters to control the priority it gives to each
> algorithm, or can avoid registering certain algorithms.  Doing it guest
> side is more flexible, because realistically many virt host deployments
> will never give the guest admin ability to control this from the host
> side, so a guest kernel config ability will be the only thing available.
>=20

I am not sure if putting all that complexity on the guest OS is the=20
right approach. I thought it would be better to let the user decide=20
through device definition what algorithms should be available to the=20
guest. But I am open to other approaches and suggestion :)

I would like to know if Arei or Longpeng(Mike) has any suggestion=20
regarding this?

Thanks
Farhan
