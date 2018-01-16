Received: from eggs.gnu.org ([2001:4830:134:3::10]:51914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1ebS7Y-0006Mc-0O
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:21:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1ebS7U-0006vV-NH
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:21:47 -0500
Received: from [45.249.212.255] (port=55157 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1ebS7U-0006uU-0e
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:21:44 -0500
From: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Date: Tue, 16 Jan 2018 14:21:32 +0000
Message-ID: <B2D15215269B544CADD246097EACE7473AB46F25@DGGEMM505-MBS.china.huawei.com>
References: <1516111613-18988-1-git-send-email-jianjay.zhou@huawei.com>
In-Reply-To: <1516111613-18988-1-git-send-email-jianjay.zhou@huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 0/4] cryptodev: add vhost support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "mst@redhat.com" <mst@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, longpeng <longpeng2@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "roy.fan.zhang@intel.com" <roy.fan.zhang@intel.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>

VHOST_USER_CREATE_CRYPTO_SESSION and VHOST_USER_CLOSE_CRYPTO_SESSION are ne=
w
added messages, they should be sent only when
VHOST_USER_PROTOCOL_F_CRYPTO_SESSION feature has been successfully negotiat=
ed.

The differs between v2 and v3 are listed below, pls review, thanks!

---
diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
index f43c63d..3aec685 100644
--- a/docs/interop/vhost-user.txt
+++ b/docs/interop/vhost-user.txt
@@ -327,6 +327,7 @@ Protocol features
 #define VHOST_USER_PROTOCOL_F_MTU            4
 #define VHOST_USER_PROTOCOL_F_SLAVE_REQ      5
 #define VHOST_USER_PROTOCOL_F_CROSS_ENDIAN   6
+#define VHOST_USER_PROTOCOL_F_CRYPTO_SESSION 7
=20
 Master message types
 --------------------
@@ -605,6 +606,9 @@ Master message types
=20
       Create a session for crypto operation. The server side must return t=
he
       session id, 0 or positive for success, negative for failure.
+      This request should be sent only when VHOST_USER_PROTOCOL_F_CRYPTO_S=
ESSION
+      feature has been successfully negotiated.
+      It's a required feature for crypto devices.
=20
  * VHOST_USER_CLOSE_CRYPTO_SESSION
=20
@@ -614,6 +618,9 @@ Master message types
=20
       Close a session for crypto operation which was previously
       created by VHOST_USER_CREATE_CRYPTO_SESSION.
+      This request should be sent only when VHOST_USER_PROTOCOL_F_CRYPTO_S=
ESSION
+      feature has been successfully negotiated.
+      It's a required feature for crypto devices.
=20
 Slave message types
 -------------------
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 7865c6d..f779512 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -35,6 +35,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_NET_MTU =3D 4,
     VHOST_USER_PROTOCOL_F_SLAVE_REQ =3D 5,
     VHOST_USER_PROTOCOL_F_CROSS_ENDIAN =3D 6,
+    VHOST_USER_PROTOCOL_F_CRYPTO_SESSION =3D 7,
=20
     VHOST_USER_PROTOCOL_F_MAX
 };
@@ -941,6 +942,8 @@ static int vhost_user_crypto_create_session(struct vhos=
t_dev *dev,
                               void *session_info,
                               uint64_t *session_id)
 {
+    bool crypto_session =3D virtio_has_feature(dev->protocol_features,
+                                       VHOST_USER_PROTOCOL_F_CRYPTO_SESSIO=
N);
     CryptoDevBackendSymSessionInfo *sess_info =3D session_info;
     VhostUserMsg msg =3D {
         .request =3D VHOST_USER_CREATE_CRYPTO_SESSION,
@@ -950,6 +953,11 @@ static int vhost_user_crypto_create_session(struct vho=
st_dev *dev,
=20
     assert(dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_USER);
=20
+    if (!crypto_session) {
+        error_report("vhost-user trying to send unhandled ioctl");
+        return -1;
+    }
+
     memcpy(&msg.payload.session.session_setup_data, sess_info,
               sizeof(CryptoDevBackendSymSessionInfo));
     if (sess_info->key_len) {
@@ -994,6 +1002,8 @@ static int vhost_user_crypto_create_session(struct vho=
st_dev *dev,
 static int
 vhost_user_crypto_close_session(struct vhost_dev *dev, uint64_t session_id=
)
 {
+    bool crypto_session =3D virtio_has_feature(dev->protocol_features,
+                                       VHOST_USER_PROTOCOL_F_CRYPTO_SESSIO=
N);
     VhostUserMsg msg =3D {
         .request =3D VHOST_USER_CLOSE_CRYPTO_SESSION,
         .flags =3D VHOST_USER_VERSION,
@@ -1001,6 +1011,11 @@ vhost_user_crypto_close_session(struct vhost_dev *de=
v, uint64_t session_id)
     };
     msg.payload.u64 =3D session_id;
=20
+    if (!crypto_session) {
+        error_report("vhost-user trying to send unhandled ioctl");
+        return -1;
+    }
+
     if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
         error_report("vhost_user_write() return -1, close session failed")=
;
         return -1;


> -----Original Message-----
> From: Zhoujian (jay)
> Sent: Tuesday, January 16, 2018 10:07 PM
> To: qemu-devel@nongnu.org
> Cc: mst@redhat.com; pbonzini@redhat.com; Huangweidong (C)
> <weidong.huang@huawei.com>; stefanha@redhat.com; Zhoujian (jay)
> <jianjay.zhou@huawei.com>; pasic@linux.vnet.ibm.com; longpeng
> <longpeng2@huawei.com>; xin.zeng@intel.com; roy.fan.zhang@intel.com; Gong=
lei
> (Arei) <arei.gonglei@huawei.com>
> Subject: [PATCH v3 0/4] cryptodev: add vhost support
>=20
> From: Gonglei <arei.gonglei@huawei.com>
>=20
> I posted the RFC verion a few months ago for DPDK vhost-crypto implmentio=
n,
> and now it's time to send the formal version. Because we need an user spa=
ce
> scheme for better performance.
>=20
> The vhost user crypto server side patches had been sent to DPDK community=
,
> pls see
>=20
> [RFC PATCH 0/6] lib/librte_vhost: introduce new vhost_user crypto backend
> support http://dpdk.org/ml/archives/dev/2017-November/081048.html
>=20
> You also can get virtio-crypto polling mode driver from:
>=20
> [PATCH] virtio: add new driver for crypto devices
> http://dpdk.org/ml/archives/dev/2017-November/081985.html
>=20
> Gonglei (4):
>   cryptodev: add vhost-user as a new cryptodev backend
>   cryptodev: add vhost support
>   cryptodev-vhost-user: add crypto session handler
>   cryptodev-vhost-user: set the key length
>=20
>  backends/Makefile.objs                |   4 +
>  backends/cryptodev-builtin.c          |   1 +
>  backends/cryptodev-vhost-user.c       | 381
> ++++++++++++++++++++++++++++++++++
>  backends/cryptodev-vhost.c            | 297 ++++++++++++++++++++++++++
>  docs/interop/vhost-user.txt           |  26 +++
>  hw/virtio/Makefile.objs               |   2 +-
>  hw/virtio/vhost-user.c                | 104 ++++++++++
>  hw/virtio/virtio-crypto.c             |  70 +++++++
>  include/hw/virtio/vhost-backend.h     |   8 +
>  include/hw/virtio/virtio-crypto.h     |   1 +
>  include/sysemu/cryptodev-vhost-user.h |  47 +++++
>  include/sysemu/cryptodev-vhost.h      | 154 ++++++++++++++
>  include/sysemu/cryptodev.h            |   8 +
>  qemu-options.hx                       |  21 ++
>  vl.c                                  |   4 +
>  15 files changed, 1127 insertions(+), 1 deletion(-)  create mode 100644
> backends/cryptodev-vhost-user.c  create mode 100644 backends/cryptodev-
> vhost.c  create mode 100644 include/sysemu/cryptodev-vhost-user.h
>  create mode 100644 include/sysemu/cryptodev-vhost.h
>=20
> --
> 1.8.3.1
>=20
