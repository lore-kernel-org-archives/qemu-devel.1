Received: from eggs.gnu.org ([2001:4830:134:3::10]:41956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e5Crh-0006ML-08
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:36:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e5Crd-0006iD-T3
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:36:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1e5Crd-0006he-Jt
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:36:05 -0400
Date: Thu, 19 Oct 2017 18:36:00 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171019183147-mutt-send-email-mst@kernel.org>
References: <1508390650-19115-1-git-send-email-changpeng.liu@intel.com>
	<1508390650-19115-2-git-send-email-changpeng.liu@intel.com>
	<20171019140935.GG6205@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171019140935.GG6205@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v4 1/4] vhost-user: add new vhost user
 messages to support virtio config space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Changpeng Liu <changpeng.liu@intel.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, marcandre.lureau@redhat.com, felipe@nutanix.com, james.r.harris@intel.com

On Thu, Oct 19, 2017 at 04:09:35PM +0200, Stefan Hajnoczi wrote:
> On Thu, Oct 19, 2017 at 01:24:07PM +0800, Changpeng Liu wrote:
> > @@ -922,6 +931,91 @@ static void vhost_user_set_iotlb_callback(struct vhost_dev *dev, int enabled)
> >      /* No-op as the receive channel is not dedicated to IOTLB messages. */
> >  }
> >  
> > +static int vhost_user_get_config(struct vhost_dev *dev, uint8_t *config,
> > +                                 size_t config_len)
> > +{
> > +    VhostUserMsg msg = {
> > +        .request = VHOST_USER_GET_CONFIG,
> > +        .flags = VHOST_USER_VERSION,
> > +        .size = config_len,
> > +    };
> > +
> > +    if (config_len == 0 || config_len > VHOST_USER_PAYLOAD_SIZE) {
> 
> config_len should be limited to 256 bytes:
> 
>   if (config_len == 0 || config_len > sizeof(msg.payload.config) {

I would just limit it to a reasonable value, acceptable to
both master and slave, not fail if it's bigger.


> > +        error_report("bad config length");
> > +        return -1;
> > +    }
> > +
> > +    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
> > +        return -1;
> > +    }
> > +
> > +    if (vhost_user_read(dev, &msg) < 0) {
> > +        return -1;
> > +    }
> > +
> > +    if (msg.request != VHOST_USER_GET_CONFIG) {
> > +        error_report("Received unexpected msg type. Expected %d received %d",
> > +                     VHOST_USER_GET_CONFIG, msg.request);
> > +        return -1;
> > +    }
> > +
> > +    if (msg.size != config_len) {
> > +        error_report("Received bad msg size.");
> > +        return -1;
> > +    }
> > +
> > +    memcpy(config, &msg.payload.config, config_len);
> 
> There is some complexity here: different virtio devices use different
> amounts of config space.  Devices may append new fields to the config
> space to support new features.
> 
> Therefore I think the simplest protocol is to always fetch the full
> 256-byte configuration space.  This way the vhost-user slave process can
> implement feature bits that the master process does not know about.
> 
> In other words, I don't think the master process knows how much of the
> config space is used so it should always request 256 bytes.

Each device knows the max config space size.

    vdev->config_len = config_size;

I don't think we need to hard-code 256 bytes in there.


> > +    return 0;
> > +}
> > +
> > +static int vhost_user_set_config(struct vhost_dev *dev, const uint8_t *config,
> > +                                 size_t config_len)
> > +{
> > +    bool reply_supported = virtio_has_feature(dev->protocol_features,
> > +                                              VHOST_USER_PROTOCOL_F_REPLY_ACK);
> > +
> > +    VhostUserMsg msg = {
> > +        .request = VHOST_USER_SET_CONFIG,
> > +        .flags = VHOST_USER_VERSION,
> > +        .size = config_len,
> > +    };
> > +
> > +    if (reply_supported) {
> > +        msg.flags |= VHOST_USER_NEED_REPLY_MASK;
> > +    }
> > +
> > +    if (config_len == 0 || config_len > VHOST_USER_PAYLOAD_SIZE) {
> 
> Same thing here: config_len > sizeof(msg.payload.config)
