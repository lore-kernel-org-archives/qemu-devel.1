Received: from eggs.gnu.org ([2001:4830:134:3::10]:37196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fTNW9-0003aG-8C
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:22:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fTNW5-0005yf-3R
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:22:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36914 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fTNW4-0005yJ-Sg
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:22:01 -0400
Date: Thu, 14 Jun 2018 09:21:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180614082155.GI6355@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <cover.1528832686.git.alifm@linux.ibm.com>
	<dd7e90c5b3de6f98218908c7f57d9d0286089ad5.1528832686.git.alifm@linux.ibm.com>
	<20180613093700.GG27901@redhat.com>
	<7b51465a-b7c1-58ec-1ef6-9fe791e96bbf@linux.ibm.com>
	<20180613150512.GA19901@redhat.com>
	<5833f4ec-dcd1-19ac-2848-facf31aec7cf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5833f4ec-dcd1-19ac-2848-facf31aec7cf@linux.ibm.com>
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
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, frankja@linux.ibm.com, mst@redhat.com, borntraeger@de.ibm.com, arei.gonglei@huawei.com, longpeng2@huawei.com, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, mjrosato@linux.vnet.ibm.com

On Wed, Jun 13, 2018 at 07:28:08PM +0200, Halil Pasic wrote:
>=20
>=20
> On 06/13/2018 05:05 PM, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, Jun 13, 2018 at 11:01:05AM -0400, Farhan Ali wrote:
> > > Hi Daniel
> > >=20
> > > On 06/13/2018 05:37 AM, Daniel P. Berrang=C3=A9 wrote:
> > > > On Tue, Jun 12, 2018 at 03:48:34PM -0400, Farhan Ali wrote:
> > > > > The virtio-crypto driver currently propagates to the guest
> > > > > all the cipher algorithms that the backend cryptodev can
> > > > > support. But in certain cases where the guest has more
> > > > > performant mechanism to handle some algorithms, it would be
> > > > > useful to propagate only a subset of the algorithms.
> > > >=20
> > > > I'm not really convinced by this.
> > > >=20
> > > > The performance of crypto algorithms has many influencing
> > > > factors, making it pretty hard to decide which is best
> > > > without actively testing specific impls and comparing
> > > > them in a manner which matches the application usage
> > > > pattern. eg in theory the kernel crypto impl of an alg
> > > > is faster than a userspace impl, if the kernel uses
> > > > hardware accel and userspace does not. This, however,
> > > > ignores the overhead of the kernel/userspace switch.
> > > > The real world performance winner, thus depends on the
> > > > amount of data being processed in each operation. Some
> > > > times userspace can win & sometimes kernel space can
> > > > win. This is even more relevant to virtio-crypto as
> > > > it has more expensive context switches.
> > >=20
> > > True. But what if the guest can perform some crypto algorithms with=
out a
> > > incurring a VM exit? For example in s390 we have the cpacf instruct=
ions to
> > > perform crypto and this instruction is implemented for us by our ha=
rdware
> > > virtualization technology. In such a case it would be better not to=
 use
> > > virtio-crypto's implementation of such a crypto algorithm.
> > >=20
> > > At the same time we would like to take advantage of virtio-crypto's
> > > acceleration capabilities for certain crypto algorithms for which t=
here is
> > > no hardware assistance.
> >=20
> > IIUC, the kernel's crypto layer can support multiple implementations =
of
> > any algorithm. Providers can report a priority against implementation=
s
> > which influences which impl is used in practice. So if there's a nati=
ve
> > instruction for a partiuclar algorithm I would expect the impl regist=
ered
> > for that to be designated higher priority than other impls, so that i=
t is
> > used in preference to other impls.
> >=20
>=20
> AFAIR the problem here is that in (the guest) kernel the virtio-crypto
> driver has to register it's crypto algo implementations with a priority
> (single number), which dictates if it's going to be the preferred (used=
)
> implementation of the algorithm or not. The virtio-crypto driver does t=
his
> without having information about the (comparative or absolute) performa=
nce
> of it's implementation (which depends on the backend among others). I d=
on't think
> any dynamic re-prioritization of the algorithms takes place (e.g. based=
 on how these
> perform in for the given configuration).
>=20
> I think the strategy of the virtio-crypto is to rather overstate, than
> understate the performance of it's implementation. If we were to 'be
> conservative' and say, 'hey we don't know nothing about the performance=
,
> let's make it lowest priority implementation' the implementations provi=
ded
> by virtio-crypto would end up being used only if there is no other
> implementation. And that does not sound like a good idea either.


This problem you describe, however, is something that applies to *any*
kerenl code that is registering a crypto algo impl for accelerator
hardware. A non-virtualized crypto cards in bare metal likewise cannot
assume that its AES impl is better then the host CPU's  aes-ni instructio=
n.

> So the idea is to give the user the power to effectively not provide
> an algorithm via virtio-crypto. That is, if the user observes a perform=
ance
> degradation because of virtio-crypto, he can turn off the bad algorithm=
s
> at the device. That way overstatement becomes a much smaller problem.
> The user can turn off the bad algorithms for reasons other than perform=
ance
> too.
>=20
> Of course there are other ways to deal with the problem of virtio-crypt=
o
> driver not knowing how good it's implementation of a given algo is. We
> could make the in kernel crypto priorities dynamically adjustable in ge=
neral
> or we could provide the user with means to specify the priorities (e.g.
> as module parameter) with which the virtio-crypto driver registers each=
 algo.
> Both of these would be knobs in the guest. It's hard to tell if these f=
irst
> one would be useful in scenarios not involving virtualization. Same goe=
s
> for some kind of dynamic priority management for crypto algorithm imple=
mentations
> in the Linux kernel. I assume the people involved with the respective
> subsystem do not see the necessity for something like that.

It still feels like this is a problem for the guest OS to solve. If you
put a physical crypto accelerator in a bare metal machine, that has the
same problem you describe here, so the kernel surely already needs to fin=
d
a viable solution for this problem.=20


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
