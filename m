Received: from eggs.gnu.org ([2001:4830:134:3::10]:40867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fToSD-0000r5-OQ
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 09:07:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fToS7-00018f-Ks
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 09:07:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59840
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fToS7-00018L-E2
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 09:07:43 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5FD0eHB097381
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 09:07:41 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2jmdfsskcw-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 09:07:41 -0400
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 15 Jun 2018 14:07:38 +0100
References: <cover.1528832686.git.alifm@linux.ibm.com>
	<dd7e90c5b3de6f98218908c7f57d9d0286089ad5.1528832686.git.alifm@linux.ibm.com>
	<20180613093700.GG27901@redhat.com>
	<7b51465a-b7c1-58ec-1ef6-9fe791e96bbf@linux.ibm.com>
	<20180613150512.GA19901@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 15 Jun 2018 15:07:34 +0200
MIME-Version: 1.0
In-Reply-To: <20180613150512.GA19901@redhat.com>
Content-Language: en-US
Message-Id: <6a00e901-2f51-68a7-5fe5-302431194334@de.ibm.com>
Content-Type: text/plain; charset=utf-8
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
Cc: qemu-devel@nongnu.org, frankja@linux.ibm.com, mst@redhat.com, pasic@linux.ibm.com, arei.gonglei@huawei.com, longpeng2@huawei.com, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, mjrosato@linux.vnet.ibm.com



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

Yes. This is what the kernel currently does. Back then I asked Gonglei to=
 reduce
the default priority of virtio-crypto  (it was 501 and thus higher than a=
nybody
else). Right now virtio-crypto has lower priority than the s390 cpacf cod=
e.

What does make sense though, is to actually have a mean to synchronize be=
tween
guest driver and host provider about what are actually supported operatio=
ns.

Right now you only have aes cbc. What happens now, when a new driver also=
 supports
lets say sha3, but the host does not. Having some kind of handshaking cer=
tainly=20
makes sense. Do we need this configurable? This is another question.=20
