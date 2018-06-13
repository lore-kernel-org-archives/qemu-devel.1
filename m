Received: from eggs.gnu.org ([2001:4830:134:3::10]:56310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fT7Ks-0003LC-Rt
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 11:05:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fT7Ko-0007g0-L0
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 11:05:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55606 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fT7Ko-0007eP-Fg
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 11:05:18 -0400
Date: Wed, 13 Jun 2018 16:05:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180613150512.GA19901@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <cover.1528832686.git.alifm@linux.ibm.com>
	<dd7e90c5b3de6f98218908c7f57d9d0286089ad5.1528832686.git.alifm@linux.ibm.com>
	<20180613093700.GG27901@redhat.com>
	<7b51465a-b7c1-58ec-1ef6-9fe791e96bbf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7b51465a-b7c1-58ec-1ef6-9fe791e96bbf@linux.ibm.com>
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
Cc: qemu-devel@nongnu.org, frankja@linux.ibm.com, mst@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, arei.gonglei@huawei.com, longpeng2@huawei.com, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, mjrosato@linux.vnet.ibm.com

On Wed, Jun 13, 2018 at 11:01:05AM -0400, Farhan Ali wrote:
> Hi Daniel
>=20
> On 06/13/2018 05:37 AM, Daniel P. Berrang=C3=A9 wrote:
> > On Tue, Jun 12, 2018 at 03:48:34PM -0400, Farhan Ali wrote:
> > > The virtio-crypto driver currently propagates to the guest
> > > all the cipher algorithms that the backend cryptodev can
> > > support. But in certain cases where the guest has more
> > > performant mechanism to handle some algorithms, it would be
> > > useful to propagate only a subset of the algorithms.
> >=20
> > I'm not really convinced by this.
> >=20
> > The performance of crypto algorithms has many influencing
> > factors, making it pretty hard to decide which is best
> > without actively testing specific impls and comparing
> > them in a manner which matches the application usage
> > pattern. eg in theory the kernel crypto impl of an alg
> > is faster than a userspace impl, if the kernel uses
> > hardware accel and userspace does not. This, however,
> > ignores the overhead of the kernel/userspace switch.
> > The real world performance winner, thus depends on the
> > amount of data being processed in each operation. Some
> > times userspace can win & sometimes kernel space can
> > win. This is even more relevant to virtio-crypto as
> > it has more expensive context switches.
>=20
> True. But what if the guest can perform some crypto algorithms without =
a
> incurring a VM exit? For example in s390 we have the cpacf instructions=
 to
> perform crypto and this instruction is implemented for us by our hardwa=
re
> virtualization technology. In such a case it would be better not to use
> virtio-crypto's implementation of such a crypto algorithm.
>=20
> At the same time we would like to take advantage of virtio-crypto's
> acceleration capabilities for certain crypto algorithms for which there=
 is
> no hardware assistance.

IIUC, the kernel's crypto layer can support multiple implementations of
any algorithm. Providers can report a priority against implementations
which influences which impl is used in practice. So if there's a native
instruction for a partiuclar algorithm I would expect the impl registered
for that to be designated higher priority than other impls, so that it is
used in preference to other impls.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
