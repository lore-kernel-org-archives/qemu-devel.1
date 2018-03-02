Received: from eggs.gnu.org ([2001:4830:134:3::10]:44887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1errCB-0006hb-So
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 15:22:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1errC8-00064G-Oi
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 15:22:23 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42970 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1errC8-00063z-KV
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 15:22:20 -0500
Date: Fri, 2 Mar 2018 22:22:19 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180302222015-mutt-send-email-mst@kernel.org>
References: <cover.1519961667.git.jbaron@akamai.com>
	<c9d3cf2fbc3c64bb28e0438185d85d95b2088127.1519961667.git.jbaron@akamai.com>
	<7fc612d0-9610-9b07-d054-bb1438898f47@redhat.com>
	<c01a1ccd-a864-00a8-edf9-4a16c5dd6c32@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c01a1ccd-a864-00a8-edf9-4a16c5dd6c32@akamai.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/4] virtio-net: add linkspeed and duplex
 settings to virtio-net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Baron <jbaron@akamai.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org

On Fri, Mar 02, 2018 at 11:59:00AM -0500, Jason Baron wrote:
> On 03/02/2018 02:14 AM, Jason Wang wrote:
> >=20
> >=20
> > On 2018=E5=B9=B403=E6=9C=8802=E6=97=A5 11:46, Jason Baron wrote:
> >> Although linkspeed and duplex can be set in a linux guest via 'ethto=
ol
> >> -s',
> >> this requires custom ethtool commands for virtio-net by default.
> >>
> >> Introduce a new feature flag, VIRTIO_NET_F_SPEED_DUPLEX, which allow=
s
> >> the hypervisor to export a linkspeed and duplex setting. The user ca=
n
> >> subsequently overwrite it later if desired via: 'ethtool -s'.
> >>
> >> Linkspeed and duplex settings can be set as:
> >> '-device virtio-net,speed=3D10000,duplex=3Dfull'
> >=20
> > I was thinking whether or not it's better to decide the duplex by the
> > type of backends.
> >=20
> > E.g userspace and vhost-kernel implement a in fact half duplex. But d=
pdk
> > implement a full duplex.
>=20
> Interesting - could this be derived only from the backend 'type'. IE:
> NET_CLIENT_DRIVER_TAP, NET_CLIENT_DRIVER_VHOST_USER...
>=20
>=20
> I was also thinking this could be specified as 'duplex=3Dbackend', in
> addition to the proposed 'duplex=3Dfull' or 'duplex=3Dhalf'?
>=20
> Thanks,
>=20
> -Jason

I'd say it would make more sense to teach backends to obey what's
specified by the user. E.g. if vhost gets a duplex config,
create two threads.

But I think all that's for future, we can just fake it for
now - the current uses don't seem to particularly care about whether
virtio actually is or isn't a duplex.



> >=20
> > Thanks
> >=20
> >>
> >> where speed is [0...INT_MAX], and duplex is ["half"|"full"].
> >>
> >> Signed-off-by: Jason Baron<jbaron@akamai.com>
> >> Cc: "Michael S. Tsirkin"<mst@redhat.com>
> >> Cc: Jason Wang<jasowang@redhat.com>
> >> Cc:virtio-dev@lists.oasis-open.org
> >> ---
> >=20
