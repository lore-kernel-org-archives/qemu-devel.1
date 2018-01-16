Received: from eggs.gnu.org ([2001:4830:134:3::10]:49483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebUG3-0005g1-TZ
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 11:38:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebUFz-0002rE-Nv
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 11:38:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ebUFz-0002po-E0
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 11:38:39 -0500
Date: Tue, 16 Jan 2018 18:38:27 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180116183754-mutt-send-email-mst@kernel.org>
References: <1516111613-18988-1-git-send-email-jianjay.zhou@huawei.com>
	<B2D15215269B544CADD246097EACE7473AB46F25@DGGEMM505-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B2D15215269B544CADD246097EACE7473AB46F25@DGGEMM505-MBS.china.huawei.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/4] cryptodev: add vhost support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, longpeng <longpeng2@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "roy.fan.zhang@intel.com" <roy.fan.zhang@intel.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>

On Tue, Jan 16, 2018 at 02:21:32PM +0000, Zhoujian (jay) wrote:
> VHOST_USER_CREATE_CRYPTO_SESSION and VHOST_USER_CLOSE_CRYPTO_SESSION are new
> added messages, they should be sent only when
> VHOST_USER_PROTOCOL_F_CRYPTO_SESSION feature has been successfully negotiated.
> 
> The differs between v2 and v3 are listed below, pls review, thanks!
> 
> ---
> diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
> index f43c63d..3aec685 100644
> --- a/docs/interop/vhost-user.txt
> +++ b/docs/interop/vhost-user.txt
> @@ -327,6 +327,7 @@ Protocol features
>  #define VHOST_USER_PROTOCOL_F_MTU            4
>  #define VHOST_USER_PROTOCOL_F_SLAVE_REQ      5
>  #define VHOST_USER_PROTOCOL_F_CROSS_ENDIAN   6
> +#define VHOST_USER_PROTOCOL_F_CRYPTO_SESSION 7
>  
>  Master message types
>  --------------------
> @@ -605,6 +606,9 @@ Master message types
>  
>        Create a session for crypto operation. The server side must return the
>        session id, 0 or positive for success, negative for failure.
> +      This request should be sent only when VHOST_USER_PROTOCOL_F_CRYPTO_SESSION
> +      feature has been successfully negotiated.
> +      It's a required feature for crypto devices.
>  
>   * VHOST_USER_CLOSE_CRYPTO_SESSION
>  
> @@ -614,6 +618,9 @@ Master message types
>  
>        Close a session for crypto operation which was previously
>        created by VHOST_USER_CREATE_CRYPTO_SESSION.
> +      This request should be sent only when VHOST_USER_PROTOCOL_F_CRYPTO_SESSION
> +      feature has been successfully negotiated.
> +      It's a required feature for crypto devices.
>  
>  Slave message types
>  -------------------
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 7865c6d..f779512 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -35,6 +35,7 @@ enum VhostUserProtocolFeature {
>      VHOST_USER_PROTOCOL_F_NET_MTU = 4,
>      VHOST_USER_PROTOCOL_F_SLAVE_REQ = 5,
>      VHOST_USER_PROTOCOL_F_CROSS_ENDIAN = 6,
> +    VHOST_USER_PROTOCOL_F_CRYPTO_SESSION = 7,
>  
>      VHOST_USER_PROTOCOL_F_MAX
>  };
> @@ -941,6 +942,8 @@ static int vhost_user_crypto_create_session(struct vhost_dev *dev,
>                                void *session_info,
>                                uint64_t *session_id)
>  {
> +    bool crypto_session = virtio_has_feature(dev->protocol_features,
> +                                       VHOST_USER_PROTOCOL_F_CRYPTO_SESSION);
>      CryptoDevBackendSymSessionInfo *sess_info = session_info;
>      VhostUserMsg msg = {
>          .request = VHOST_USER_CREATE_CRYPTO_SESSION,
> @@ -950,6 +953,11 @@ static int vhost_user_crypto_create_session(struct vhost_dev *dev,
>  
>      assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER);
>  
> +    if (!crypto_session) {
> +        error_report("vhost-user trying to send unhandled ioctl");
> +        return -1;
> +    }
> +
>      memcpy(&msg.payload.session.session_setup_data, sess_info,
>                sizeof(CryptoDevBackendSymSessionInfo));
>      if (sess_info->key_len) {
> @@ -994,6 +1002,8 @@ static int vhost_user_crypto_create_session(struct vhost_dev *dev,
>  static int
>  vhost_user_crypto_close_session(struct vhost_dev *dev, uint64_t session_id)
>  {
> +    bool crypto_session = virtio_has_feature(dev->protocol_features,
> +                                       VHOST_USER_PROTOCOL_F_CRYPTO_SESSION);
>      VhostUserMsg msg = {
>          .request = VHOST_USER_CLOSE_CRYPTO_SESSION,
>          .flags = VHOST_USER_VERSION,
> @@ -1001,6 +1011,11 @@ vhost_user_crypto_close_session(struct vhost_dev *dev, uint64_t session_id)
>      };
>      msg.payload.u64 = session_id;
>  
> +    if (!crypto_session) {
> +        error_report("vhost-user trying to send unhandled ioctl");
> +        return -1;
> +    }
> +
>      if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
>          error_report("vhost_user_write() return -1, close session failed");
>          return -1;
> 

Documentation and error messages could be improved, but I think this
is reasonable enough to put upstream and improve on top.


> > -----Original Message-----
> > From: Zhoujian (jay)
> > Sent: Tuesday, January 16, 2018 10:07 PM
> > To: qemu-devel@nongnu.org
> > Cc: mst@redhat.com; pbonzini@redhat.com; Huangweidong (C)
> > <weidong.huang@huawei.com>; stefanha@redhat.com; Zhoujian (jay)
> > <jianjay.zhou@huawei.com>; pasic@linux.vnet.ibm.com; longpeng
> > <longpeng2@huawei.com>; xin.zeng@intel.com; roy.fan.zhang@intel.com; Gonglei
> > (Arei) <arei.gonglei@huawei.com>
> > Subject: [PATCH v3 0/4] cryptodev: add vhost support
> > 
> > From: Gonglei <arei.gonglei@huawei.com>
> > 
> > I posted the RFC verion a few months ago for DPDK vhost-crypto implmention,
> > and now it's time to send the formal version. Because we need an user space
> > scheme for better performance.
> > 
> > The vhost user crypto server side patches had been sent to DPDK community,
> > pls see
> > 
> > [RFC PATCH 0/6] lib/librte_vhost: introduce new vhost_user crypto backend
> > support http://dpdk.org/ml/archives/dev/2017-November/081048.html
> > 
> > You also can get virtio-crypto polling mode driver from:
> > 
> > [PATCH] virtio: add new driver for crypto devices
> > http://dpdk.org/ml/archives/dev/2017-November/081985.html
> > 
> > Gonglei (4):
> >   cryptodev: add vhost-user as a new cryptodev backend
> >   cryptodev: add vhost support
> >   cryptodev-vhost-user: add crypto session handler
> >   cryptodev-vhost-user: set the key length
> > 
> >  backends/Makefile.objs                |   4 +
> >  backends/cryptodev-builtin.c          |   1 +
> >  backends/cryptodev-vhost-user.c       | 381
> > ++++++++++++++++++++++++++++++++++
> >  backends/cryptodev-vhost.c            | 297 ++++++++++++++++++++++++++
> >  docs/interop/vhost-user.txt           |  26 +++
> >  hw/virtio/Makefile.objs               |   2 +-
> >  hw/virtio/vhost-user.c                | 104 ++++++++++
> >  hw/virtio/virtio-crypto.c             |  70 +++++++
> >  include/hw/virtio/vhost-backend.h     |   8 +
> >  include/hw/virtio/virtio-crypto.h     |   1 +
> >  include/sysemu/cryptodev-vhost-user.h |  47 +++++
> >  include/sysemu/cryptodev-vhost.h      | 154 ++++++++++++++
> >  include/sysemu/cryptodev.h            |   8 +
> >  qemu-options.hx                       |  21 ++
> >  vl.c                                  |   4 +
> >  15 files changed, 1127 insertions(+), 1 deletion(-)  create mode 100644
> > backends/cryptodev-vhost-user.c  create mode 100644 backends/cryptodev-
> > vhost.c  create mode 100644 include/sysemu/cryptodev-vhost-user.h
> >  create mode 100644 include/sysemu/cryptodev-vhost.h
> > 
> > --
> > 1.8.3.1
> > 
