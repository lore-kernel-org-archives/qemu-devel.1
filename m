Received: from eggs.gnu.org ([2001:4830:134:3::10]:55409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f1EuZ-0007sa-P5
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 13:31:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f1EuW-0003Cm-FC
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 13:30:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60824 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1f1EuW-0003BX-9K
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 13:30:56 -0400
Date: Wed, 28 Mar 2018 20:30:42 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180328202823-mutt-send-email-mst@kernel.org>
References: <20180328155657.6434-1-maxime.coquelin@redhat.com>
	<20180328155657.6434-3-maxime.coquelin@redhat.com>
	<20180328195501-mutt-send-email-mst@kernel.org>
	<d18f36d7-fdba-c937-4a84-7d31faeca223@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d18f36d7-fdba-c937-4a84-7d31faeca223@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] vhost-user: back SET/GET_CONFIG
 requests with a protocol feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: changpeng.liu@intel.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org

On Wed, Mar 28, 2018 at 07:08:32PM +0200, Maxime Coquelin wrote:
> 
> 
> On 03/28/2018 06:55 PM, Michael S. Tsirkin wrote:
> > On Wed, Mar 28, 2018 at 05:56:57PM +0200, Maxime Coquelin wrote:
> > > Without a dedicated protocol feature, QEMU cannot know whether
> > > the backend can handle VHOST_USER_SET_CONFIG and
> > > VHOST_USER_GET_CONFIG messages.
> > > 
> > > This patch adds a protocol feature that is only advertised by
> > > QEMU if the device implements the config ops. The backend
> > > should only send VHOST_USER_SLAVE_CONFIG_CHANGE_MSG requests
> > > if the protocol feature has been negotiated.
> > > 
> > > Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> > 
> > I presume vhost user blk should fail init if the
> > protocol feature isn't negotiated then.
> 
> I did that and finally removed it.
> In the future, if for example we add config support for net device,
> we will want init to succeed even with old backend version that
> does not support it, right?
> 
> For the vhost user blk case, its init will fail right after,
> because it tries to get config, but will get an error instead.
> 
> As we only have vhost-user-blk supporting it for now, and since it
> is a mandatory feature, I fine to post a v2 that makes
> vhost_user_init() to fail.

Seems safer. We can remove restrictions but not add new ones.

> > 
> > > ---
> > >   docs/interop/vhost-user.txt | 21 ++++++++++++---------
> > >   hw/virtio/vhost-user.c      | 17 +++++++++++++++++
> > >   2 files changed, 29 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
> > > index c058c407df..534caab18a 100644
> > > --- a/docs/interop/vhost-user.txt
> > > +++ b/docs/interop/vhost-user.txt
> > > @@ -379,6 +379,7 @@ Protocol features
> > >   #define VHOST_USER_PROTOCOL_F_CROSS_ENDIAN   6
> > >   #define VHOST_USER_PROTOCOL_F_CRYPTO_SESSION 7
> > >   #define VHOST_USER_PROTOCOL_F_PAGEFAULT      8
> > > +#define VHOST_USER_PROTOCOL_F_CONFIG         9
> > >   Master message types
> > >   --------------------
> > > @@ -664,7 +665,8 @@ Master message types
> > >         Master payload: virtio device config space
> > >         Slave payload: virtio device config space
> > > -      Submitted by the vhost-user master to fetch the contents of the virtio
> > > +      When VHOST_USER_PROTOCOL_F_CONFIG is negotiated, this message is
> > > +      submitted by the vhost-user master to fetch the contents of the virtio
> > >         device configuration space, vhost-user slave's payload size MUST match
> > >         master's request, vhost-user slave uses zero length of payload to
> > >         indicate an error to vhost-user master. The vhost-user master may
> > > @@ -677,7 +679,8 @@ Master message types
> > >         Master payload: virtio device config space
> > >         Slave payload: N/A
> > > -      Submitted by the vhost-user master when the Guest changes the virtio
> > > +      When VHOST_USER_PROTOCOL_F_CONFIG is negotiated, this message is
> > > +      submitted by the vhost-user master when the Guest changes the virtio
> > >         device configuration space and also can be used for live migration
> > >         on the destination host. The vhost-user slave must check the flags
> > >         field, and slaves MUST NOT accept SET_CONFIG for read-only
> > > @@ -766,13 +769,13 @@ Slave message types
> > >        Slave payload: N/A
> > >        Master payload: N/A
> > > -     Vhost-user slave sends such messages to notify that the virtio device's
> > > -     configuration space has changed, for those host devices which can support
> > > -     such feature, host driver can send VHOST_USER_GET_CONFIG message to slave
> > > -     to get the latest content. If VHOST_USER_PROTOCOL_F_REPLY_ACK is
> > > -     negotiated, and slave set the VHOST_USER_NEED_REPLY flag, master must
> > > -     respond with zero when operation is successfully completed, or non-zero
> > > -     otherwise.
> > > +     When VHOST_USER_PROTOCOL_F_CONFIG is negotiated, vhost-user slave sends
> > > +     such messages to notify that the virtio device's configuration space has
> > > +     changed, for those host devices which can support such feature, host
> > > +     driver can send VHOST_USER_GET_CONFIG message to slave to get the latest
> > > +     content. If VHOST_USER_PROTOCOL_F_REPLY_ACK is negotiated, and slave set
> > > +     the VHOST_USER_NEED_REPLY flag, master must respond with zero when
> > > +     operation is successfully completed, or non-zero otherwise.
> > >   VHOST_USER_PROTOCOL_F_REPLY_ACK:
> > >   -------------------------------
> > > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > > index 44aea5c0a8..a045203b26 100644
> > > --- a/hw/virtio/vhost-user.c
> > > +++ b/hw/virtio/vhost-user.c
> > > @@ -46,6 +46,7 @@ enum VhostUserProtocolFeature {
> > >       VHOST_USER_PROTOCOL_F_CROSS_ENDIAN = 6,
> > >       VHOST_USER_PROTOCOL_F_CRYPTO_SESSION = 7,
> > >       VHOST_USER_PROTOCOL_F_PAGEFAULT = 8,
> > > +    VHOST_USER_PROTOCOL_F_CONFIG = 9,
> > >       VHOST_USER_PROTOCOL_F_MAX
> > >   };
> > > @@ -1211,6 +1212,12 @@ static int vhost_user_init(struct vhost_dev *dev, void *opaque)
> > >           dev->protocol_features =
> > >               protocol_features & VHOST_USER_PROTOCOL_FEATURE_MASK;
> > > +
> > > +        if (!dev->config_ops || !dev->config_ops->vhost_dev_config_notifier) {
> > > +            /* Dont acknowledge CONFIG feature if device doesn't support it */
> > > +            dev->protocol_features &= ~(1ULL << VHOST_USER_PROTOCOL_F_CONFIG);
> > > +        }
> > > +
> > >           err = vhost_user_set_protocol_features(dev, dev->protocol_features);
> > >           if (err < 0) {
> > >               return err;
> > > @@ -1405,6 +1412,11 @@ static int vhost_user_get_config(struct vhost_dev *dev, uint8_t *config,
> > >           .hdr.size = VHOST_USER_CONFIG_HDR_SIZE + config_len,
> > >       };
> > > +    if (!virtio_has_feature(dev->protocol_features,
> > > +                VHOST_USER_PROTOCOL_F_CONFIG)) {
> > > +        return -1;
> > > +    }
> > > +
> > >       if (config_len > VHOST_USER_MAX_CONFIG_SIZE) {
> > >           return -1;
> > >       }
> > > @@ -1448,6 +1460,11 @@ static int vhost_user_set_config(struct vhost_dev *dev, const uint8_t *data,
> > >           .hdr.size = VHOST_USER_CONFIG_HDR_SIZE + size,
> > >       };
> > > +    if (!virtio_has_feature(dev->protocol_features,
> > > +                VHOST_USER_PROTOCOL_F_CONFIG)) {
> > > +        return -1;
> > > +    }
> > > +
> > >       if (reply_supported) {
> > >           msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
> > >       }
> > > -- 
> > > 2.14.3
