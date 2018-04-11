Received: from eggs.gnu.org ([2001:4830:134:3::10]:48037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f6JgZ-0001fd-PM
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 13:37:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f6JgW-0000K9-M5
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 13:37:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35892 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1f6JgW-0000JZ-F7
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 13:37:28 -0400
Date: Wed, 11 Apr 2018 20:37:17 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180411200127-mutt-send-email-mst@kernel.org>
References: <20180411072027.5656-1-tiwei.bie@intel.com>
	<fc66437c-ae8c-15fa-c8d3-6aa6bdb22a36@redhat.com>
	<20180411083853.qa6y6zevjpvamrdx@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180411083853.qa6y6zevjpvamrdx@debian>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] vhost-user: introduce F_NEED_ALL_IOTLB
 protocol feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: Jason Wang <jasowang@redhat.com>, peterx@redhat.com, qemu-devel@nongnu.org, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com

On Wed, Apr 11, 2018 at 04:38:53PM +0800, Tiwei Bie wrote:
> On Wed, Apr 11, 2018 at 04:01:19PM +0800, Jason Wang wrote:
> > On 2018=E5=B9=B404=E6=9C=8811=E6=97=A5 15:20, Tiwei Bie wrote:
> > > This patch introduces VHOST_USER_PROTOCOL_F_NEED_ALL_IOTLB
> > > feature for vhost-user. By default, vhost-user backend needs
> > > to query the IOTLBs from QEMU after meeting unknown IOVAs.
> > > With this protocol feature negotiated, QEMU will provide all
> > > the IOTLBs to vhost-user backend without waiting for the
> > > queries from backend. This is helpful when using a hardware
> > > accelerator which is not able to handle unknown IOVAs at the
> > > vhost-user backend.
> > >=20
> > > Signed-off-by: Tiwei Bie<tiwei.bie@intel.com>
> > > ---
> > > The idea of this patch is to let QEMU push all the IOTLBs
> > > to vhost-user backend without waiting for the queries from
> > > the backend. Because hardware accelerator at the vhost-user
> > > backend may not be able to handle unknown IOVAs.
> > >=20
> > > This is just a RFC for now. It seems that, it doesn't work
> > > as expected when guest is using kernel driver (To handle
> > > this case, it seems that some RAM regions' events also need
> > > to be listened). Any comments would be appreciated! Thanks!
> >=20
> > Interesting, a quick question is why this is needed? Can we just use =
exist
> > IOTLB update message?
>=20
> Yeah, we are still using the existing IOTLB update messages
> to send the IOTLB messages to backend. The only difference
> is that, QEMU won't wait for the queries before sending the
> IOTLB update messages.

So I have a concern with that, in that without any flow
control the socket buffer used by vhost-user might become
full.

We don't currently expect that.


Again, my understanding is that the biggest benefit from use of a
hardware accelerator is when notifications can be passed-through to the
guest.

And since that involves VFIO, and since VFIO already needs to support
all kinds of IOMMUs, one wonders whether one can just pass that directly
to the VFIO instead of shipping it to vhost-user.


> >=20
> > It looks to me at least kernel does not need this.
>=20
> Something similar in kernel vhost is that, for kernel vhost,
> QEMU needs to push the IOTLBs of some ring addrs to kernel
> vhost backend without waiting for the queries.
>=20
> Best regards,
> Tiwei Bie

That's really to work around a bug in kernel, we keep this around since
we want to support old kernels.

> >=20
> > Thanks
