Received: from eggs.gnu.org ([2001:4830:134:3::10]:41111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dFllM-0007ig-3r
	for qemu-devel@nongnu.org; Tue, 30 May 2017 14:21:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dFllI-0006Bh-4z
	for qemu-devel@nongnu.org; Tue, 30 May 2017 14:21:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49968)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dFllH-0006BW-Pv
	for qemu-devel@nongnu.org; Tue, 30 May 2017 14:20:56 -0400
Date: Tue, 30 May 2017 21:20:45 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170530211819-mutt-send-email-mst@kernel.org>
References: <20170526142858.19931-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170526142858.19931-1-maxime.coquelin@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/6] vhost-user: Specify and implement
 device IOTLB support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: peterx@redhat.com, marcandre.lureau@gmail.com, vkaplans@redhat.com, jasowang@redhat.com, wexu@redhat.com, yuanhan.liu@linux.intel.com, qemu-devel@nongnu.org, jfreiman@redhat.com

On Fri, May 26, 2017 at 04:28:52PM +0200, Maxime Coquelin wrote:
> This series aims at specifying ans implementing the protocol update
> required to support device IOTLB with user backends.
>=20
> In this second non-RFC version, main changes are:
>  - spec fixes and clarification
>  - rings information update has been restored back to ring enablement t=
ime
>  - Work around GCC 4.4.7 limitation wrt assignment in unnamed union at
> declaration time.
>=20
> The series can be tested with vhost_iotlb_proto_v2 branch on my gitlab
> account[0].
>=20
> The slave requests channel part is re-used from Marc-Andr=E9's series s=
ubmitted
> last year[1], with main changes from original version being request/fea=
ture
> names renaming and addition of the REPLY_ACK feature support.
>=20
> Regarding IOTLB protocol, one noticeable change is the IOTLB miss reque=
st
> reply made optionnal (i.e. only if slave requests it by setting the
> VHOST_USER_NEED_REPLY flag in the message header). This change provides
> more flexibility in the backend implementation of the feature.
>=20
> The protocol is very close to kernel backends, except that a new
> communication channel is introduced to enable the slave to send
> requests to the master.
>=20
> [0]: https://gitlab.com/mcoquelin/dpdk-next-virtio/commits/vhost_iotlb_=
proto_v2
> [1]: https://lists.gnu.org/archive/html/qemu-devel/2016-04/msg00095.htm=
l

Overall, this looks good to me. I do think patch 3 isn't a good idea
though, if slave wants something let it request it.

Need to find out why does vhost in kernel want the used ring iotlb at
start time - especially considering we aren't even guaranteed one entry
covers the whole ring, and invalidates should affect all addresses at
least in theory.


> Marc-Andr=E9 Lureau (2):
>   vhost-user: add vhost_user to hold the chr
>   vhost-user: add slave-req-fd support
>=20
> Maxime Coquelin (4):
>   vhost: propagate errors in vhost_device_iotlb_miss()
>   vhost: rework IOTLB messaging
>   vhost: extend ring information update for IOTLB to all rings
>   spec/vhost-user spec: Add IOMMU support
>=20
>  docs/specs/vhost-user.txt         | 118 ++++++++++++++++++++++++-
>  hw/virtio/vhost-backend.c         | 130 ++++++++++++++++------------
>  hw/virtio/vhost-user.c            | 177 ++++++++++++++++++++++++++++++=
+++++++-
>  hw/virtio/vhost.c                 |  27 ++++--
>  include/hw/virtio/vhost-backend.h |  23 +++--
>  include/hw/virtio/vhost.h         |   2 +-
>  6 files changed, 397 insertions(+), 80 deletions(-)
>=20
> --=20
> 2.9.4
