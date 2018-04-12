Received: from eggs.gnu.org ([2001:4830:134:3::10]:55659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f6T3E-0005CE-5x
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 23:37:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f6T3B-00069y-1m
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 23:37:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45872 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1f6T3A-00069k-Sq
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 23:37:28 -0400
Date: Thu, 12 Apr 2018 06:37:25 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180412063708-mutt-send-email-mst@kernel.org>
References: <20180411072027.5656-1-tiwei.bie@intel.com>
	<fc66437c-ae8c-15fa-c8d3-6aa6bdb22a36@redhat.com>
	<20180411083853.qa6y6zevjpvamrdx@debian>
	<a6d0c105-5aa6-f578-a37f-39f1c2fed471@redhat.com>
	<20180411195957-mutt-send-email-mst@kernel.org>
	<8babe3ef-b401-58ec-b6d4-2b4a7e528560@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8babe3ef-b401-58ec-b6d4-2b4a7e528560@redhat.com>
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
To: Jason Wang <jasowang@redhat.com>
Cc: Tiwei Bie <tiwei.bie@intel.com>, cunming.liang@intel.com, qemu-devel@nongnu.org, peterx@redhat.com, zhihong.wang@intel.com, dan.daly@intel.com

On Thu, Apr 12, 2018 at 11:23:31AM +0800, Jason Wang wrote:
>=20
>=20
> On 2018=E5=B9=B404=E6=9C=8812=E6=97=A5 01:00, Michael S. Tsirkin wrote:
> > On Wed, Apr 11, 2018 at 09:41:05PM +0800, Jason Wang wrote:
> > > On 2018=E5=B9=B404=E6=9C=8811=E6=97=A5 16:38, Tiwei Bie wrote:
> > > > On Wed, Apr 11, 2018 at 04:01:19PM +0800, Jason Wang wrote:
> > > > > On 2018=E5=B9=B404=E6=9C=8811=E6=97=A5 15:20, Tiwei Bie wrote:
> > > > > > This patch introduces VHOST_USER_PROTOCOL_F_NEED_ALL_IOTLB
> > > > > > feature for vhost-user. By default, vhost-user backend needs
> > > > > > to query the IOTLBs from QEMU after meeting unknown IOVAs.
> > > > > > With this protocol feature negotiated, QEMU will provide all
> > > > > > the IOTLBs to vhost-user backend without waiting for the
> > > > > > queries from backend. This is helpful when using a hardware
> > > > > > accelerator which is not able to handle unknown IOVAs at the
> > > > > > vhost-user backend.
> > > > > >=20
> > > > > > Signed-off-by: Tiwei Bie<tiwei.bie@intel.com>
> > > > > > ---
> > > > > > The idea of this patch is to let QEMU push all the IOTLBs
> > > > > > to vhost-user backend without waiting for the queries from
> > > > > > the backend. Because hardware accelerator at the vhost-user
> > > > > > backend may not be able to handle unknown IOVAs.
> > > > > >=20
> > > > > > This is just a RFC for now. It seems that, it doesn't work
> > > > > > as expected when guest is using kernel driver (To handle
> > > > > > this case, it seems that some RAM regions' events also need
> > > > > > to be listened). Any comments would be appreciated! Thanks!
> > > > > Interesting, a quick question is why this is needed? Can we jus=
t use exist
> > > > > IOTLB update message?
> > > > Yeah, we are still using the existing IOTLB update messages
> > > > to send the IOTLB messages to backend. The only difference
> > > > is that, QEMU won't wait for the queries before sending the
> > > > IOTLB update messages.
> > > Yes, my question is not very clear. I mean why must need a new feat=
ure bit?
> > > It looks to me qemu code can work without this.
> > >=20
> > > Thanks
> > Generally we avoid adding new messages without a protocol feature bit=
.
> > While careful analysis might sometimes prove it's not a strict
> > requirement, it's just overall a clean and robust approach.
> >=20
>=20
> Right but the looks like the patch does not introduce any new type of
> messages.
>=20
> Thanks

In this case remote needs to know that it will send these messages.

--=20
MST
