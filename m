Received: from eggs.gnu.org ([2001:4830:134:3::10]:58764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dFjo6-0001Yt-O2
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:15:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dFjo5-0002BX-C6
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:15:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1dFjo5-0002BL-34
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:15:41 -0400
References: <20170526142858.19931-1-maxime.coquelin@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <3f97a248-dac2-c260-abf7-42b1a488ac3d@redhat.com>
Date: Tue, 30 May 2017 18:15:29 +0200
MIME-Version: 1.0
In-Reply-To: <20170526142858.19931-1-maxime.coquelin@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
To: mst@redhat.com, peterx@redhat.com, marcandre.lureau@gmail.com, vkaplans@redhat.com, jasowang@redhat.com, wexu@redhat.com, yuanhan.liu@linux.intel.com, qemu-devel@nongnu.org, jfreiman@redhat.com

Hi,

On 05/26/2017 04:28 PM, Maxime Coquelin wrote:
> This series aims at specifying ans implementing the protocol update
> required to support device IOTLB with user backends.
>=20
> In this second non-RFC version, main changes are:
>   - spec fixes and clarification
>   - rings information update has been restored back to ring enablement =
time
>   - Work around GCC 4.4.7 limitation wrt assignment in unnamed union at
> declaration time.
>=20
> The series can be tested with vhost_iotlb_proto_v2 branch on my gitlab
> account[0].
>=20
> The slave requests channel part is re-used from Marc-Andr=C3=A9's serie=
s submitted
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
>=20
> Marc-Andr=C3=A9 Lureau (2):
>    vhost-user: add vhost_user to hold the chr
>    vhost-user: add slave-req-fd support
>=20
> Maxime Coquelin (4):
>    vhost: propagate errors in vhost_device_iotlb_miss()
>    vhost: rework IOTLB messaging
>    vhost: extend ring information update for IOTLB to all rings
>    spec/vhost-user spec: Add IOMMU support
>=20
>   docs/specs/vhost-user.txt         | 118 ++++++++++++++++++++++++-
>   hw/virtio/vhost-backend.c         | 130 ++++++++++++++++------------
>   hw/virtio/vhost-user.c            | 177 +++++++++++++++++++++++++++++=
++++++++-
>   hw/virtio/vhost.c                 |  27 ++++--
>   include/hw/virtio/vhost-backend.h |  23 +++--
>   include/hw/virtio/vhost.h         |   2 +-
>   6 files changed, 397 insertions(+), 80 deletions(-)
>=20

I just noticed I missed the below change in the series.
I'll wait v2 is reviewed before posting the v3, or I can post v3 now if
you prefer.

Regards,
Maxime

------------------------------------------------------------------

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 22874a9..e037db6 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -77,6 +77,7 @@ static const int user_feature_bits[] =3D {
      VIRTIO_NET_F_HOST_UFO,
      VIRTIO_NET_F_MRG_RXBUF,
      VIRTIO_NET_F_MTU,
+    VIRTIO_F_IOMMU_PLATFORM,

      /* This bit implies RARP isn't sent by QEMU out of band */
      VIRTIO_NET_F_GUEST_ANNOUNCE,
