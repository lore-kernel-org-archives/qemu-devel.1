Received: from eggs.gnu.org ([2001:4830:134:3::10]:44113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fTTtt-0000ve-FC
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:11:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fTTtp-0005wc-Du
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:11:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42340 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fTTtp-0005wC-6s
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:10:57 -0400
Date: Thu, 14 Jun 2018 16:10:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180614151048.GA18967@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <cover.1528832686.git.alifm@linux.ibm.com>
	<dd7e90c5b3de6f98218908c7f57d9d0286089ad5.1528832686.git.alifm@linux.ibm.com>
	<20180613093700.GG27901@redhat.com>
	<7b51465a-b7c1-58ec-1ef6-9fe791e96bbf@linux.ibm.com>
	<20180613150512.GA19901@redhat.com>
	<5833f4ec-dcd1-19ac-2848-facf31aec7cf@linux.ibm.com>
	<20180614082155.GI6355@redhat.com>
	<79597909-fdb5-2983-19ac-74332229c8ef@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <79597909-fdb5-2983-19ac-74332229c8ef@linux.ibm.com>
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
To: Farhan Ali <alifm@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, qemu-devel@nongnu.org, frankja@linux.ibm.com, mst@redhat.com, borntraeger@de.ibm.com, arei.gonglei@huawei.com, longpeng2@huawei.com, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, mjrosato@linux.vnet.ibm.com

On Thu, Jun 14, 2018 at 10:50:40AM -0400, Farhan Ali wrote:
>=20
>=20
> On 06/14/2018 04:21 AM, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, Jun 13, 2018 at 07:28:08PM +0200, Halil Pasic wrote:
> > >=20
> > >=20
> > > On 06/13/2018 05:05 PM, Daniel P. Berrang=C3=A9 wrote:
> > > > On Wed, Jun 13, 2018 at 11:01:05AM -0400, Farhan Ali wrote:
> > > > > Hi Daniel
> > > > >=20
> > > > > On 06/13/2018 05:37 AM, Daniel P. Berrang=C3=A9 wrote:
> > > > > > On Tue, Jun 12, 2018 at 03:48:34PM -0400, Farhan Ali wrote:
> > > > > > > The virtio-crypto driver currently propagates to the guest
> > > > > > > all the cipher algorithms that the backend cryptodev can
> > > > > > > support. But in certain cases where the guest has more
> > > > > > > performant mechanism to handle some algorithms, it would be
> > > > > > > useful to propagate only a subset of the algorithms.
> > > > > >=20
> > > > > > I'm not really convinced by this.
> > > > > >=20
> > > > > > The performance of crypto algorithms has many influencing
> > > > > > factors, making it pretty hard to decide which is best
> > > > > > without actively testing specific impls and comparing
> > > > > > them in a manner which matches the application usage
> > > > > > pattern. eg in theory the kernel crypto impl of an alg
> > > > > > is faster than a userspace impl, if the kernel uses
> > > > > > hardware accel and userspace does not. This, however,
> > > > > > ignores the overhead of the kernel/userspace switch.
> > > > > > The real world performance winner, thus depends on the
> > > > > > amount of data being processed in each operation. Some
> > > > > > times userspace can win & sometimes kernel space can
> > > > > > win. This is even more relevant to virtio-crypto as
> > > > > > it has more expensive context switches.
> > > > >=20
> > > > > True. But what if the guest can perform some crypto algorithms =
without a
> > > > > incurring a VM exit? For example in s390 we have the cpacf inst=
ructions to
> > > > > perform crypto and this instruction is implemented for us by ou=
r hardware
> > > > > virtualization technology. In such a case it would be better no=
t to use
> > > > > virtio-crypto's implementation of such a crypto algorithm.
> > > > >=20
> > > > > At the same time we would like to take advantage of virtio-cryp=
to's
> > > > > acceleration capabilities for certain crypto algorithms for whi=
ch there is
> > > > > no hardware assistance.
> > > >=20
> > > > IIUC, the kernel's crypto layer can support multiple implementati=
ons of
> > > > any algorithm. Providers can report a priority against implementa=
tions
> > > > which influences which impl is used in practice. So if there's a =
native
> > > > instruction for a partiuclar algorithm I would expect the impl re=
gistered
> > > > for that to be designated higher priority than other impls, so th=
at it is
> > > > used in preference to other impls.
> > > >=20
> > >=20
> > > AFAIR the problem here is that in (the guest) kernel the virtio-cry=
pto
> > > driver has to register it's crypto algo implementations with a prio=
rity
> > > (single number), which dictates if it's going to be the preferred (=
used)
> > > implementation of the algorithm or not. The virtio-crypto driver do=
es this
> > > without having information about the (comparative or absolute) perf=
ormance
> > > of it's implementation (which depends on the backend among others).=
 I don't think
> > > any dynamic re-prioritization of the algorithms takes place (e.g. b=
ased on how these
> > > perform in for the given configuration).
> > >=20
> > > I think the strategy of the virtio-crypto is to rather overstate, t=
han
> > > understate the performance of it's implementation. If we were to 'b=
e
> > > conservative' and say, 'hey we don't know nothing about the perform=
ance,
> > > let's make it lowest priority implementation' the implementations p=
rovided
> > > by virtio-crypto would end up being used only if there is no other
> > > implementation. And that does not sound like a good idea either.
> >=20
> >=20
> > This problem you describe, however, is something that applies to *any=
*
> > kerenl code that is registering a crypto algo impl for accelerator
> > hardware. A non-virtualized crypto cards in bare metal likewise canno=
t
> > assume that its AES impl is better then the host CPU's  aes-ni instru=
ction.
> >=20
> > > So the idea is to give the user the power to effectively not provid=
e
> > > an algorithm via virtio-crypto. That is, if the user observes a per=
formance
> > > degradation because of virtio-crypto, he can turn off the bad algor=
ithms
> > > at the device. That way overstatement becomes a much smaller proble=
m.
> > > The user can turn off the bad algorithms for reasons other than per=
formance
> > > too.
> > >=20
> > > Of course there are other ways to deal with the problem of virtio-c=
rypto
> > > driver not knowing how good it's implementation of a given algo is.=
 We
> > > could make the in kernel crypto priorities dynamically adjustable i=
n general
> > > or we could provide the user with means to specify the priorities (=
e.g.
> > > as module parameter) with which the virtio-crypto driver registers =
each algo.
> > > Both of these would be knobs in the guest. It's hard to tell if the=
se first
> > > one would be useful in scenarios not involving virtualization. Same=
 goes
> > > for some kind of dynamic priority management for crypto algorithm i=
mplementations
> > > in the Linux kernel. I assume the people involved with the respecti=
ve
> > > subsystem do not see the necessity for something like that.
> >=20
> > It still feels like this is a problem for the guest OS to solve. If y=
ou
> > put a physical crypto accelerator in a bare metal machine, that has t=
he
> > same problem you describe here, so the kernel surely already needs to=
 find
> > a viable solution for this problem.
> >=20
>=20
> How would the guest OS know which algo is better? As you mentioned it d=
oes
> depend on few factors and the best the kernel can do is use some sort o=
f
> heuristics. Such a solution might not be very dynamic and might not wor=
k for
> all the cases for a user.

Which is better will likely depend on the application using it. One might
be better for use by the kernel, while another is better for use by a
userspace application, or two userspace apps might have different prefere=
nces.

> Shouldn't we use virtualization to give us the flexibility that we don'=
t
> have with physical crypto accelerator? The crypto accelerator might not=
 know
> if it's implementation is any better, but the user can experiment and s=
ee
> what works better.

It is better to provide it all to the guest and let the guest decide whic=
h
is best to use.  If nothing else the virtio-crypto kernel module itself
can have module parameters to control the priority it gives to each
algorithm, or can avoid registering certain algorithms.  Doing it guest
side is more flexible, because realistically many virt host deployments
will never give the guest admin ability to control this from the host
side, so a guest kernel config ability will be the only thing available.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
