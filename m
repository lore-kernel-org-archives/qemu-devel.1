Received: from eggs.gnu.org ([2001:4830:134:3::10]:60451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1gQJeR-0000Qz-O9
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 17:10:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1gQJeN-0003xu-Pq
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 17:10:15 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:37618)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1gQJeN-0003wp-Kq
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 17:10:11 -0500
From: Felipe Franciosi <felipe@nutanix.com>
Date: Fri, 23 Nov 2018 22:09:53 +0000
Message-ID: <0857657C-BEFF-4B65-A8A0-004CCE361FDB@nutanix.com>
References: <20181106143213.536d3311@w520.home>
In-Reply-To: <20181106143213.536d3311@w520.home>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0037AE15DB51E74886C0BCACCDEDFCBF@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] KVM Forum VFIO BoF summary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Jiang, Jerry (SW)" <Jerry.Jiang@amd.com>, "ziye.yang@intel.com" <ziye.yang@intel.com>, Changpeng Liu <changpeng.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@Alibaba-inc.com>, "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>, "Xue, Ken" <Ken.Xue@amd.com>, "Wang, Zhi A" <zhi.a.wang@intel.com>, James R Harris <james.r.harris@intel.com>, "benjamin.walker@intel.com" <benjamin.walker@intel.com>, Alexander Graf <agraf@suse.de>

Hi Alex,

I'm also terribly sorry for the delay in responding to this. I'm only now h=
aving the time resources to come back to this topic and figure out a way fo=
rward with my proposal. Please see my notes below (quoting only the relevan=
t sections).

> On Nov 6, 2018, at 9:32 PM, Alex Williamson <alex.williamson@redhat.com> =
wrote:
>=20
> There were mostly two main threads of discussion, the first was Filipe's
> discussion of a socket interface making use of the VFIO ABI to
> implement a userspace device model.  For a VM use case, QEMU would be
> modified to use a socket for the VFIO ABI, including shared memory for
> DMA.  Ideally this would be transparent for much of the QEMU vfio code
> outside of setup.  Effectively this becomes a userspace implementation
> of mdev as this could already be done using mdev, but it requires a
> vendor driver to expose the userspace interface and likely a longer
> round trip through the kernel and back to userspace. Either path
> allows device models in userspace that can be open or proprietary, but
> this new proposal eliminates the vendor kernel driver component.  Of
> course non-upstream kernel mdev vendor drivers do taint the host
> kernel, so they at least leave a breadcrumb.

Spot on. This can be done today via mdev, but it would unnecessarily involv=
e the kernel in the setup of devices. Also, since vfio is the only existing=
 bus driver for mdev, it would make little sense to implement an mdev "phys=
ical" driver (which wouldn't have a physical backing device) just to talk a=
 vfio-like abi back to userspace.

This "vfio-user" proposal is a perfect fit for Qemu. I think the correct de=
sign is to slightly rearchitect the vfio implementation in Qemu to allow fo=
r userspace backends through unix sockets, very much like vhost-user does i=
t for virtio devices today.

As a matter of fact, with something like this in place, I think the Qemu co=
de could potentially be simplified by moving some of the existing vhost-use=
r offloading code underneath it.

> I believe Filipe
> mentioned a conversation after the BoF with Alex Graf who had a related
> concern about using the socket approach to use this as a non-GPL
> backdoor for device models in QEMU and a suggested approach was a GPL
> handshake via the socket interface.

Not exactly. The GPL-violating concerns came from Paolo and Stefan (cc'd). =
Alex Graf (cc'd) came up with a solution for the concern which involves add=
ing a copyrighted "poem" to the protocol handshake. Qemu would then grant t=
he copyright for GPL applications, hence limiting who can use the protocol.

Vendors can obviously bypass this by using a GPL proxy application that tal=
ks to Qemu, but then uses a separate mechanism (possibly another unix socke=
t) to talk to other non-GPL applications. Vendors which distribute Qemu can=
 possibly also bypass this by modifying the protocol not to include the cop=
yrighted messages. Using either legal loophole approach, however, can lead =
to a lot of public point and shame.

The point I would like to discuss more widely (before going forwards with c=
ode) is whether vendors can actually make use of a GPL-only protocol. I und=
erstand the community desire of gathering efforts into GPL software, Qemu c=
ode and Virtio. A non-GPL implementation means that maybe some vendors cann=
ot use this.

I envision this protocol being used by userspace applications which _need_ =
to emulate a device outside Qemu for performance reasons, not license reaso=
ns (eg. a separate process can efficiently poll VQs from multiple VMs from =
a single core). Applications that already do that today, albeit open-source=
, are not GPL (eg. OVS, DPDK, SPDK).

This is why I'd like to hear more from Paolo and Stefan on why making this =
non-GPL is so bad. It is already possible today (via mdev), and similar app=
roaches already exist for a large number of device implementations via vhos=
t-user. Additionally, I would also like to hear from willing vendors that f=
eel they could _only_ benefit from this if it does not enforce GPL.

Finally, I want to clarify I am not opposing making this GPL-only. I just w=
ant to make sure the effort is justifiable (ie. there is reason for this to=
 enforce GPL peer applications given the existing vhost-user and mdev alter=
natives) and not in vain (ie. there are GPL use cases for this out there).

Thanks,
Felipe
