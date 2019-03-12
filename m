Received: from eggs.gnu.org ([209.51.188.92]:50631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1h3XTK-0004iw-8V
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 22:48:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1h3XTJ-0000g6-0v
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 22:48:54 -0400
Received: from mga18.intel.com ([134.134.136.126]:31644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kevin.tian@intel.com>)
	id 1h3XTI-0000aV-OS
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 22:48:52 -0400
From: "Tian, Kevin" <kevin.tian@intel.com>
Date: Tue, 12 Mar 2019 02:48:39 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19C985486@SHSMSX104.ccr.corp.intel.com>
References: <1550566254-3545-1-git-send-email-yan.y.zhao@intel.com>
	<20190221134051.2c28893e@w520.home>
	<20190225022255.GP16456@joy-OptiPlex-7040>
	<20190307104421.534ea56f@w520.home>
	<AADFC41AFE54684AB9EE6CBC0274A5D19C97CA6B@SHSMSX104.ccr.corp.intel.com>
	<20190308091133.3073f5db@x1.home>	<20190308162146.GD2834@work-vm>
	<20190308150254.3d1af7d8@x1.home>
	<AADFC41AFE54684AB9EE6CBC0274A5D19C983C63@SHSMSX104.ccr.corp.intel.com>
	<20190311141919.0c675efc@x1.home>
In-Reply-To: <20190311141919.0c675efc@x1.home>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 0/5] QEMU VFIO live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "cjia@nvidia.com" <cjia@nvidia.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "aik@ozlabs.ru" <aik@ozlabs.ru>, "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@alibaba-inc.com>, "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "eauger@redhat.com" <eauger@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "eskultet@redhat.com" <eskultet@redhat.com>, "Yang, Ziye" <ziye.yang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "arei.gonglei@huawei.com" <arei.gonglei@huawei.com>, "felipe@nutanix.com" <felipe@nutanix.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>, "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>, "Liu, Changpeng" <changpeng.liu@intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "Wang, Zhi A" <zhi.a.wang@intel.com>, "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>

> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Tuesday, March 12, 2019 4:19 AM
> On Mon, 11 Mar 2019 02:33:11 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
>=20
[...]
>=20
> I think I've fully conceded any notion of security by obscurity towards
> opaque data already, but segregating types of device data still seems
> to unnecessarily impose a usage model on the vendor driver that I think
> we should try to avoid.  The migration interface should define the
> protocol through which userspace can save and restore the device state,
> not impose how the vendor driver exposes or manages that state.  Also, I
> got the impression (perhaps incorrectly) that you were trying to mmap
> live data to userspace, which would allow not only saving the state,
> but also unchecked state modification by userspace. I think we want
> more of a producer/consumer model of the state where consuming state
> also involves at least some degree of sanity or consistency checking.
> Let's not forget too that we're obviously dealing with non-open source
> driver in the mdev universe as well.

OK. I think for this part we are in agreement - as long as the goal of
this interface is clearly defined as such way. :-)

[...]
> > But I still didn't get your exact concern about security part. For
> > version yes we still haven't worked out a sane way to represent
> > vendor-specific compatibility requirement. But allowing user
> > space to modify data through this interface has really no difference
> > from allowing guest to modify data through trapped MMIO interface.
> > mdev driver should guarantee that operations through both interfaces
> > can modify only the state associated with the said mdev instance,
> > w/o breaking the isolation boundary. Then the former becomes just
> > a batch of operations to be verified in the same way as if they are
> > done individually through the latter interface.
>=20
> It seems like you're assuming a working model for the vendor driver and
> the data entering and exiting through this interface.  The vendor
> drivers can expose data any way that they want.  All we need to do is
> imagine that the migration data stream includes an array index count
> somewhere which the user could modify to trigger the in-kernel vendor
> driver to allocate an absurd array size and DoS the target.  This is
> probably the most simplistic attack, possibly knowing the state machine
> of the vendor driver a malicious user could trick it into providing
> host kernel data.  We're not necessarily only conveying state that the
> user already has access to via this interface, the vendor driver may
> include non-visible internal state as well.  Even the state that is
> user accessible is being pushed into the vendor driver via an alternate
> path from the user mediation we have on the existing paths.

Then I don't know how this concern can be effectively addressed=20
since you assume vendor drivers are not trusted here. and why do
you trust vendor drivers on mediating existing path but not this
alternative one? non-visible internal states just mean more stuff
to be carefully scrutinized, which is not essentially causing a=20
conceptual difference of trust level.

Or can this concern be partially mitigated if we create some=20
test cases which poke random data through the new interface,
and mark vendor drivers which pass such tests as trusted? Then
there is also an open who should be in charge of such certification=20
process...

Thanks
Kevin
