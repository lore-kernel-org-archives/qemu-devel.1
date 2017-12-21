Received: from eggs.gnu.org ([2001:4830:134:3::10]:43209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eRoYz-00026d-19
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 19:18:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eRoYu-0002I0-UU
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 19:18:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eRoYu-0002HA-Gr
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 19:18:12 -0500
Date: Thu, 21 Dec 2017 02:18:09 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171221021756-mutt-send-email-mst@kernel.org>
References: <1513132143-10758-1-git-send-email-changpeng.liu@intel.com>
	<1513132143-10758-2-git-send-email-changpeng.liu@intel.com>
	<CAJ+F1CKDUvseu=FsTXGY=2u1kiC0xh0xUMTmi4kuhA-KO2981Q@mail.gmail.com>
	<CAJ+F1CJsTk9uTfxyvVQtKSNbyyz9he+CSV5KH6PXQ6ym3QLwSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CJsTk9uTfxyvVQtKSNbyyz9he+CSV5KH6PXQ6ym3QLwSw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 1/4] vhost-user: add new vhost user
 messages to support virtio config space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Felipe Franciosi <felipe@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, james.r.harris@intel.com

On Wed, Dec 20, 2017 at 06:28:04PM +0000, Marc-Andr=E9 Lureau wrote:
> Michael, did you merge that one too? I think the series shouldn't be ap=
plied
> yet until my concerns are cleared.=A0 Thanks

OK I'll drop these for now.

> Le mer. 20 d=E9c. 2017 =E0 16:47, Marc-Andr=E9 Lureau <marcandre.lureau=
@gmail.com> a
> =E9crit=A0:
>=20
>     Hi
>=20
>     On Wed, Dec 13, 2017 at 3:29 AM, Changpeng Liu <changpeng.liu@intel=
.com>
>     wrote:
>     > Add VHOST_USER_GET_CONFIG/VHOST_USER_SET_CONFIG messages which ca=
n be
>     > used for live migration of vhost user devices, also vhost user de=
vices
>     > can benefit from the messages to get/set virtio config space from=
/to the
>     > I/O target. For the purpose to support virtio config space change=
,
>     > VHOST_USER_SET_CONFIG_FD message is added as the event notifier
>     > in case virtio config space change in the I/O target.
>=20
>     Why not use a new slave message instead of adding another fd to wat=
ch for?
>=20
>     VHOST_USER_SLAVE_SET_CONFIG: notify the master of device configurat=
ion
>     space change
>=20
>=20
>     >
>     > Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
>     > ---
>     >=A0 docs/interop/vhost-user.txt=A0 =A0 =A0 =A0|=A0 45 ++++++++++++=
++++
>     >=A0 hw/virtio/vhost-user.c=A0 =A0 =A0 =A0 =A0 =A0 | 107
>     ++++++++++++++++++++++++++++++++++++++
>     >=A0 hw/virtio/vhost.c=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=A0 64 ++=
+++++++++++++++++++++
>     >=A0 include/hw/virtio/vhost-backend.h |=A0 14 +++++
>     >=A0 include/hw/virtio/vhost.h=A0 =A0 =A0 =A0 =A0|=A0 16 ++++++
>     >=A0 5 files changed, 246 insertions(+)
>     >
>     > diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-use=
r.txt
>     > index 954771d..826ba18 100644
>     > --- a/docs/interop/vhost-user.txt
>     > +++ b/docs/interop/vhost-user.txt
>     > @@ -116,6 +116,19 @@ Depending on the request type, payload can b=
e:
>     >=A0 =A0 =A0 - 3: IOTLB invalidate
>     >=A0 =A0 =A0 - 4: IOTLB access fail
>     >
>     > + * Virtio device config space
>     > +=A0 =A0-----------------------------------
>     > +=A0 =A0| offset | size | flags | payload |
>     > +=A0 =A0-----------------------------------
>     > +
>     > +=A0 =A0Offset: a 32-bit offset of virtio device's configuration =
space
>     > +=A0 =A0Size: a 32-bit configuration space access size in bytes
>     > +=A0 =A0Flags: a 32-bit value:
>     > +=A0 =A0 - 0: Vhost master messages used for writeable fields
>     > +=A0 =A0 - 1: Vhost master messages used for live migration
>     > +=A0 =A0Payload: Size bytes array holding the contents of the vir=
tio
>     > +=A0 =A0 =A0 =A0device's configuration space
>     > +
>     >=A0 In QEMU the vhost-user message is implemented with the followi=
ng struct:
>     >
>     >=A0 typedef struct VhostUserMsg {
>     > @@ -129,6 +142,7 @@ typedef struct VhostUserMsg {
>     >=A0 =A0 =A0 =A0 =A0 VhostUserMemory memory;
>     >=A0 =A0 =A0 =A0 =A0 VhostUserLog log;
>     >=A0 =A0 =A0 =A0 =A0 struct vhost_iotlb_msg iotlb;
>     > +=A0 =A0 =A0 =A0 VhostUserConfig config;
>     >=A0 =A0 =A0 };
>     >=A0 } QEMU_PACKED VhostUserMsg;
>     >
>     > @@ -596,6 +610,37 @@ Master message types
>     >=A0 =A0 =A0 =A0 and expect this message once (per VQ) during devic=
e configuration
>     >=A0 =A0 =A0 =A0 (ie. before the master starts the VQ).
>     >
>     > + * VHOST_USER_GET_CONFIG
>=20
>     Please add an empty line (same style as other messages). Same for
>     other messages.
>=20
>     > +=A0 =A0 =A0 Id: 24
>     > +=A0 =A0 =A0 Equivalent ioctl: N/A
>     > +=A0 =A0 =A0 Master payload: virtio device config space
>=20
>     Why is the master sending the current config space? I suppose the
>     content should be meaningful then. Make that explicit in the spec
>     please
>=20
>     + missing Slave payload (make it explicit that size must match)
>=20
>     > +
>     > +=A0 =A0 =A0 Submitted by the vhost-user master to fetch the cont=
ents of the
>     virtio
>     > +=A0 =A0 =A0 device configuration space, vhost-user slave uses ze=
ro length of
>     payload
>     > +=A0 =A0 =A0 to indicate an error to vhost-user master. The vhost=
-user master
>     may
>     > +=A0 =A0 =A0 cache the contents to avoid repeated VHOST_USER_GET_=
CONFIG calls.
>     > +
>     > +* VHOST_USER_SET_CONFIG
>     > +=A0 =A0 =A0 Id: 25
>     > +=A0 =A0 =A0 Equivalent ioctl: N/A
>     > +=A0 =A0 =A0 Master payload: virtio device config space
>     > +
>     > +=A0 =A0 =A0 Submitted by the vhost-user master when the Guest ch=
anges the
>     virtio
>     > +=A0 =A0 =A0 device configuration space and also can be used for =
live migration
>     > +=A0 =A0 =A0 on the destination host. The vhost-user slave must c=
heck the flags
>     > +=A0 =A0 =A0 field, and slaves MUST NOT accept SET_CONFIG for rea=
d-only
>     > +=A0 =A0 =A0 configuration space fields unless the live migration=
 bit is set.
>=20
>     I would make reply mandatory for any newly introduced message. If n=
ot,
>     please add the message to the list that don't in "Communication"
>=20
>     > +
>     > +* VHOST_USER_SET_CONFIG_FD
>     > +=A0 =A0 =A0 Id: 26
>     > +=A0 =A0 =A0 Equivalent ioctl: N/A
>     > +=A0 =A0 =A0 Master payload: N/A
>     > +
>     > +=A0 =A0 =A0 Sets the notifier file descriptor, which is passed a=
s ancillary
>     data.
>     > +=A0 =A0 =A0 The vhost-user slave uses the file descriptor to not=
ify the
>     vhost-user
>     > +=A0 =A0 =A0 master of changes to the virtio configuration space.=
 The
>     vhost-user
>     > +=A0 =A0 =A0 master can read the virtio configuration space to ge=
t the latest
>     update.
>=20
>     Imho there should be a slave message instead.
>=20
>     > +
>     >=A0 Slave message types
>     >=A0 -------------------
>     >
>     > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>     > index 093675e..037c165 100644
>     > --- a/hw/virtio/vhost-user.c
>     > +++ b/hw/virtio/vhost-user.c
>     > @@ -26,6 +26,11 @@
>     >=A0 #define VHOST_MEMORY_MAX_NREGIONS=A0 =A0 8
>     >=A0 #define VHOST_USER_F_PROTOCOL_FEATURES 30
>     >
>     > +/*
>     > + * Maximum size of virtio device config space
>     > + */
>     > +#define VHOST_USER_MAX_CONFIG_SIZE 256
>     > +
>     >=A0 enum VhostUserProtocolFeature {
>     >=A0 =A0 =A0 VHOST_USER_PROTOCOL_F_MQ =3D 0,
>     >=A0 =A0 =A0 VHOST_USER_PROTOCOL_F_LOG_SHMFD =3D 1,
>     > @@ -65,6 +70,9 @@ typedef enum VhostUserRequest {
>     >=A0 =A0 =A0 VHOST_USER_SET_SLAVE_REQ_FD =3D 21,
>     >=A0 =A0 =A0 VHOST_USER_IOTLB_MSG =3D 22,
>     >=A0 =A0 =A0 VHOST_USER_SET_VRING_ENDIAN =3D 23,
>     > +=A0 =A0 VHOST_USER_GET_CONFIG =3D 24,
>     > +=A0 =A0 VHOST_USER_SET_CONFIG =3D 25,
>     > +=A0 =A0 VHOST_USER_SET_CONFIG_FD =3D 26,
>     >=A0 =A0 =A0 VHOST_USER_MAX
>     >=A0 } VhostUserRequest;
>     >
>     > @@ -92,6 +100,18 @@ typedef struct VhostUserLog {
>     >=A0 =A0 =A0 uint64_t mmap_offset;
>     >=A0 } VhostUserLog;
>     >
>     > +typedef struct VhostUserConfig {
>     > +=A0 =A0 uint32_t offset;
>     > +=A0 =A0 uint32_t size;
>     > +=A0 =A0 uint32_t flags;
>     > +=A0 =A0 uint8_t region[VHOST_USER_MAX_CONFIG_SIZE];
>     > +} VhostUserConfig;
>     > +
>     > +static VhostUserConfig c __attribute__ ((unused));
>     > +#define VHOST_USER_CONFIG_HDR_SIZE (sizeof(c.offset) \
>     > +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0+ sizeof(c.size) \
>     > +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0+ sizeof(c.flags))
>     > +
>     >=A0 typedef struct VhostUserMsg {
>     >=A0 =A0 =A0 VhostUserRequest request;
>     >
>     > @@ -109,6 +129,7 @@ typedef struct VhostUserMsg {
>     >=A0 =A0 =A0 =A0 =A0 VhostUserMemory memory;
>     >=A0 =A0 =A0 =A0 =A0 VhostUserLog log;
>     >=A0 =A0 =A0 =A0 =A0 struct vhost_iotlb_msg iotlb;
>     > +=A0 =A0 =A0 =A0 VhostUserConfig config;
>     >=A0 =A0 =A0 } payload;
>     >=A0 } QEMU_PACKED VhostUserMsg;
>     >
>     > @@ -922,6 +943,89 @@ static void vhost_user_set_iotlb_callback(st=
ruct
>     vhost_dev *dev, int enabled)
>     >=A0 =A0 =A0 /* No-op as the receive channel is not dedicated to IO=
TLB messages.
>     */
>     >=A0 }
>     >
>     > +static int vhost_user_get_config(struct vhost_dev *dev, uint8_t =
*config,
>     > +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0uint32_t config_len)
>     > +{
>     > +=A0 =A0 VhostUserMsg msg =3D {
>     > +=A0 =A0 =A0 =A0 msg.request =3D VHOST_USER_GET_CONFIG,
>     > +=A0 =A0 =A0 =A0 msg.flags =3D VHOST_USER_VERSION,
>     > +=A0 =A0 =A0 =A0 msg.size =3D VHOST_USER_CONFIG_HDR_SIZE + config=
_len,
>     > +=A0 =A0 };
>     > +
>     > +=A0 =A0 msg.payload.config.offset =3D 0;
>     > +=A0 =A0 msg.payload.config.size =3D config_len;
>     > +=A0 =A0 if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
>     > +=A0 =A0 =A0 =A0 return -1;
>     > +=A0 =A0 }
>=20
>     if config_len > VHOST_USER_MAX_CONFIG_SIZE, I think there will be a
>     stack overflow. Add an assert() ?
>=20
>     > +
>     > +=A0 =A0 if (vhost_user_read(dev, &msg) < 0) {
>     > +=A0 =A0 =A0 =A0 return -1;
>     > +=A0 =A0 }
>     > +
>     > +=A0 =A0 if (msg.request !=3D VHOST_USER_GET_CONFIG) {
>     > +=A0 =A0 =A0 =A0 error_report("Received unexpected msg type. Expe=
cted %d received
>     %d",
>     > +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0VHOST_USER_GET_CONFIG=
, msg.request);
>     > +=A0 =A0 =A0 =A0 return -1;
>     > +=A0 =A0 }
>     > +
>     > +=A0 =A0 if (msg.size !=3D VHOST_USER_CONFIG_HDR_SIZE + config_le=
n) {
>     > +=A0 =A0 =A0 =A0 error_report("Received bad msg size.");
>     > +=A0 =A0 =A0 =A0 return -1;
>     > +=A0 =A0 }
>     > +
>     > +=A0 =A0 memcpy(config, msg.payload.config.region, config_len);
>     > +
>     > +=A0 =A0 return 0;
>     > +}
>     > +
>     > +static int vhost_user_set_config(struct vhost_dev *dev, const ui=
nt8_t
>     *data,
>     > +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0uint32_t offset, uint32_t size,
>     uint32_t flags)
>     > +{
>     > +=A0 =A0 uint8_t *p;
>     > +=A0 =A0 bool reply_supported =3D virtio_has_feature(dev->protoco=
l_features,
>     > +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0
>     VHOST_USER_PROTOCOL_F_REPLY_ACK);
>     > +
>     > +=A0 =A0 VhostUserMsg msg =3D {
>     > +=A0 =A0 =A0 =A0 msg.request =3D VHOST_USER_SET_CONFIG,
>     > +=A0 =A0 =A0 =A0 msg.flags =3D VHOST_USER_VERSION,
>     > +=A0 =A0 =A0 =A0 msg.size =3D VHOST_USER_CONFIG_HDR_SIZE + size,
>     > +=A0 =A0 };
>     > +
>     > +=A0 =A0 if (reply_supported) {
>     > +=A0 =A0 =A0 =A0 msg.flags |=3D VHOST_USER_NEED_REPLY_MASK;
>     > +=A0 =A0 }
>     > +
>     > +=A0 =A0 msg.payload.config.offset =3D offset,
>     > +=A0 =A0 msg.payload.config.size =3D size,
>     > +=A0 =A0 msg.payload.config.flags =3D flags,
>     > +=A0 =A0 p =3D msg.payload.config.region;
>     > +=A0 =A0 memcpy(p, data, size);
>=20
>     here again, max config size should be checked.
>=20
>     > +
>     > +=A0 =A0 if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
>     > +=A0 =A0 =A0 =A0 return -1;
>     > +=A0 =A0 }
>     > +
>     > +=A0 =A0 if (reply_supported) {
>     > +=A0 =A0 =A0 =A0 return process_message_reply(dev, &msg);
>     > +=A0 =A0 }
>     > +
>     > +=A0 =A0 return 0;
>     > +}
>     > +
>     > +static int vhost_user_set_config_fd(struct vhost_dev *dev, int f=
d)
>     > +{
>     > +=A0 =A0 VhostUserMsg msg =3D {
>     > +=A0 =A0 =A0 =A0.request =3D VHOST_USER_SET_CONFIG_FD,
>     > +=A0 =A0 =A0 =A0.flags =3D VHOST_USER_VERSION,
>     > +=A0 =A0 };
>     > +
>     > +=A0 =A0 if (vhost_user_write(dev, &msg, &fd, 1) < 0) {
>     > +=A0 =A0 =A0 =A0 return -1;
>     > +=A0 =A0 }
>     > +
>     > +=A0 =A0 return 0;
>     > +}
>     > +
>     >=A0 const VhostOps user_ops =3D {
>     >=A0 =A0 =A0 =A0 =A0 .backend_type =3D VHOST_BACKEND_TYPE_USER,
>     >=A0 =A0 =A0 =A0 =A0 .vhost_backend_init =3D vhost_user_init,
>     > @@ -948,4 +1052,7 @@ const VhostOps user_ops =3D {
>     >=A0 =A0 =A0 =A0 =A0 .vhost_net_set_mtu =3D vhost_user_net_set_mtu,
>     >=A0 =A0 =A0 =A0 =A0 .vhost_set_iotlb_callback =3D vhost_user_set_i=
otlb_callback,
>     >=A0 =A0 =A0 =A0 =A0 .vhost_send_device_iotlb_msg =3D vhost_user_se=
nd_device_iotlb_msg,
>     > +=A0 =A0 =A0 =A0 .vhost_get_config =3D vhost_user_get_config,
>     > +=A0 =A0 =A0 =A0 .vhost_set_config =3D vhost_user_set_config,
>     > +=A0 =A0 =A0 =A0 .vhost_set_config_fd =3D vhost_user_set_config_f=
d,
>     >=A0 };
>     > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>     > index e4290ce..aa93398 100644
>     > --- a/hw/virtio/vhost.c
>     > +++ b/hw/virtio/vhost.c
>     > @@ -1358,6 +1358,9 @@ void vhost_dev_cleanup(struct vhost_dev *hd=
ev)
>     >=A0 =A0 =A0 for (i =3D 0; i < hdev->nvqs; ++i) {
>     >=A0 =A0 =A0 =A0 =A0 vhost_virtqueue_cleanup(hdev->vqs + i);
>     >=A0 =A0 =A0 }
>     > +=A0 =A0 if (hdev->config_ops) {
>     > +=A0 =A0 =A0 =A0 event_notifier_cleanup(&hdev->config_notifier);
>     > +=A0 =A0 }
>     >=A0 =A0 =A0 if (hdev->mem) {
>     >=A0 =A0 =A0 =A0 =A0 /* those are only safe after successful init *=
/
>     >=A0 =A0 =A0 =A0 =A0 memory_listener_unregister(&hdev->memory_liste=
ner);
>     > @@ -1505,6 +1508,67 @@ void vhost_ack_features(struct vhost_dev *=
hdev,
>     const int *feature_bits,
>     >=A0 =A0 =A0 }
>     >=A0 }
>     >
>     > +int vhost_dev_get_config(struct vhost_dev *hdev, uint8_t *config=
,
>     > +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uint32_t conf=
ig_len)
>     > +{
>     > +=A0 =A0 assert(hdev->vhost_ops);
>     > +
>     > +=A0 =A0 if (hdev->vhost_ops->vhost_get_config) {
>     > +=A0 =A0 =A0 =A0 return hdev->vhost_ops->vhost_get_config(hdev, c=
onfig,
>     config_len);
>     > +=A0 =A0 }
>     > +
>     > +=A0 =A0 return -1;
>     > +}
>     > +
>     > +int vhost_dev_set_config(struct vhost_dev *hdev, const uint8_t *=
data,
>     > +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uint32_t offs=
et, uint32_t size, uint32_t flags)
>     > +{
>     > +=A0 =A0 assert(hdev->vhost_ops);
>     > +
>     > +=A0 =A0 if (hdev->vhost_ops->vhost_set_config) {
>     > +=A0 =A0 =A0 =A0 return hdev->vhost_ops->vhost_set_config(hdev, d=
ata, offset,
>     > +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0size, flags);
>     > +=A0 =A0 }
>     > +
>     > +=A0 =A0 return -1;
>     > +}
>     > +
>     > +static void vhost_dev_config_notifier_read(EventNotifier *n)
>     > +{
>     > +=A0 =A0 struct vhost_dev *hdev =3D container_of(n, struct vhost_=
dev,
>     > +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0config_notifier);
>     > +
>     > +=A0 =A0 if (event_notifier_test_and_clear(n)) {
>     > +=A0 =A0 =A0 =A0 if (hdev->config_ops) {
>     > +=A0 =A0 =A0 =A0 =A0 =A0 hdev->config_ops->vhost_dev_config_notif=
ier(hdev);
>     > +=A0 =A0 =A0 =A0 }
>     > +=A0 =A0 }
>     > +}
>     > +
>     > +int vhost_dev_set_config_notifier(struct vhost_dev *hdev,
>     > +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 const VhostDevConfigOps *ops)
>     > +{
>     > +=A0 =A0 int r, fd;
>     > +
>     > +=A0 =A0 assert(hdev->vhost_ops);
>     > +
>     > +=A0 =A0 r =3D event_notifier_init(&hdev->config_notifier, 0);
>     > +=A0 =A0 if (r < 0) {
>     > +=A0 =A0 =A0 =A0 return r;
>     > +=A0 =A0 }
>     > +
>     > +=A0 =A0 hdev->config_ops =3D ops;
>     > +=A0 =A0 event_notifier_set_handler(&hdev->config_notifier,
>     > +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0v=
host_dev_config_notifier_read);
>     > +
>     > +=A0 =A0 if (hdev->vhost_ops->vhost_set_config_fd) {
>     > +=A0 =A0 =A0 =A0 fd=A0 =3D event_notifier_get_fd(&hdev->config_no=
tifier);
>     > +=A0 =A0 =A0 =A0 return hdev->vhost_ops->vhost_set_config_fd(hdev=
, fd);
>     > +=A0 =A0 }
>     > +
>     > +=A0 =A0 return -1;
>     > +}
>     > +
>     >=A0 /* Host notifiers must be enabled at this point. */
>     >=A0 int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev=
)
>     >=A0 {
>     > diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virti=
o/
>     vhost-backend.h
>     > index a7a5f22..8996d5f 100644
>     > --- a/include/hw/virtio/vhost-backend.h
>     > +++ b/include/hw/virtio/vhost-backend.h
>     > @@ -20,6 +20,11 @@ typedef enum VhostBackendType {
>     >=A0 =A0 =A0 VHOST_BACKEND_TYPE_MAX =3D 3,
>     >=A0 } VhostBackendType;
>     >
>     > +typedef enum VhostSetConfigType {
>     > +=A0 =A0 VHOST_SET_CONFIG_TYPE_MASTER =3D 0,
>     > +=A0 =A0 VHOST_SET_CONFIG_TYPE_MIGRATION =3D 1,
>     > +} VhostSetConfigType;
>     > +
>     >=A0 struct vhost_dev;
>     >=A0 struct vhost_log;
>     >=A0 struct vhost_memory;
>     > @@ -84,6 +89,12 @@ typedef void (*vhost_set_iotlb_callback_op)(st=
ruct
>     vhost_dev *dev,
>     >=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0int enabled);
>     >=A0 typedef int (*vhost_send_device_iotlb_msg_op)(struct vhost_dev=
 *dev,
>     >=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct vhost_iotlb_msg
>     *imsg);
>     > +typedef int (*vhost_set_config_op)(struct vhost_dev *dev, const =
uint8_t
>     *data,
>     > +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0uint32_t offset, uint32_t size,
>     > +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0uint32_t flags);
>     > +typedef int (*vhost_get_config_op)(struct vhost_dev *dev, uint8_=
t
>     *config,
>     > +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0uint32_t config_len);
>     > +typedef int (*vhost_set_config_fd_op)(struct vhost_dev *dev, int=
 fd);
>     >
>     >=A0 typedef struct VhostOps {
>     >=A0 =A0 =A0 VhostBackendType backend_type;
>     > @@ -118,6 +129,9 @@ typedef struct VhostOps {
>     >=A0 =A0 =A0 vhost_vsock_set_running_op vhost_vsock_set_running;
>     >=A0 =A0 =A0 vhost_set_iotlb_callback_op vhost_set_iotlb_callback;
>     >=A0 =A0 =A0 vhost_send_device_iotlb_msg_op vhost_send_device_iotlb=
_msg;
>     > +=A0 =A0 vhost_get_config_op vhost_get_config;
>     > +=A0 =A0 vhost_set_config_op vhost_set_config;
>     > +=A0 =A0 vhost_set_config_fd_op vhost_set_config_fd;
>     >=A0 } VhostOps;
>     >
>     >=A0 extern const VhostOps user_ops;
>     > diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.=
h
>     > index 467dc77..7f43a82 100644
>     > --- a/include/hw/virtio/vhost.h
>     > +++ b/include/hw/virtio/vhost.h
>     > @@ -46,6 +46,12 @@ struct vhost_iommu {
>     >=A0 =A0 =A0 QLIST_ENTRY(vhost_iommu) iommu_next;
>     >=A0 };
>     >
>     > +typedef struct VhostDevConfigOps {
>     > +=A0 =A0 /* Vhost device config space changed callback
>     > +=A0 =A0 =A0*/
>     > +=A0 =A0 void (*vhost_dev_config_notifier)(struct vhost_dev *dev)=
;
>     > +} VhostDevConfigOps;
>     > +
>     >=A0 struct vhost_memory;
>     >=A0 struct vhost_dev {
>     >=A0 =A0 =A0 VirtIODevice *vdev;
>     > @@ -76,6 +82,8 @@ struct vhost_dev {
>     >=A0 =A0 =A0 QLIST_ENTRY(vhost_dev) entry;
>     >=A0 =A0 =A0 QLIST_HEAD(, vhost_iommu) iommu_list;
>     >=A0 =A0 =A0 IOMMUNotifier n;
>     > +=A0 =A0 EventNotifier config_notifier;
>     > +=A0 =A0 const VhostDevConfigOps *config_ops;
>     >=A0 };
>     >
>     >=A0 int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>     > @@ -106,4 +114,12 @@ int vhost_net_set_backend(struct vhost_dev *=
hdev,
>     >=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct vho=
st_vring_file *file);
>     >
>     >=A0 int vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t io=
va, int
>     write);
>     > +int vhost_dev_get_config(struct vhost_dev *dev, uint8_t *config,
>     > +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uint32_t conf=
ig_len);
>     > +int vhost_dev_set_config(struct vhost_dev *dev, const uint8_t *d=
ata,
>     > +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uint32_t offs=
et, uint32_t size, uint32_t
>     flags);
>     > +/* notifier callback in case vhost device config space changed
>     > + */
>     > +int vhost_dev_set_config_notifier(struct vhost_dev *dev,
>     > +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 const VhostDevConfigOps *ops);
>     >=A0 #endif
>     > --
>     > 1.9.3
>     >
>     >
>=20
>=20
>=20
>     --
>     Marc-Andr=E9 Lureau
>=20
> --
> Marc-Andr=E9 Lureau
