Received: from eggs.gnu.org ([2001:4830:134:3::10]:34738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1e5U6v-0005C0-QN
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 06:01:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1e5U6r-0001GM-So
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 06:01:01 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:53850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1e5U6r-0001Fk-L4
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 06:00:57 -0400
Received: by mail-wm0-x243.google.com with SMTP id q132so21354972wmd.2
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 03:00:57 -0700 (PDT)
Date: Fri, 20 Oct 2017 12:00:51 +0200
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171020100051.GE21393@stefanha-x1.localdomain>
References: <1508390650-19115-1-git-send-email-changpeng.liu@intel.com>
	<1508390650-19115-2-git-send-email-changpeng.liu@intel.com>
	<20171019140935.GG6205@stefanha-x1.localdomain>
	<20171019183147-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171019183147-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Changpeng Liu <changpeng.liu@intel.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, marcandre.lureau@redhat.com, felipe@nutanix.com, james.r.harris@intel.com

On Thu, Oct 19, 2017 at 06:36:00PM +0300, Michael S. Tsirkin wrote:
> On Thu, Oct 19, 2017 at 04:09:35PM +0200, Stefan Hajnoczi wrote:
> > On Thu, Oct 19, 2017 at 01:24:07PM +0800, Changpeng Liu wrote:
> > > @@ -922,6 +931,91 @@ static void vhost_user_set_iotlb_callback(struct vhost_dev *dev, int enabled)
> > >      /* No-op as the receive channel is not dedicated to IOTLB messages. */
> > >  }
> > >  
> > > +static int vhost_user_get_config(struct vhost_dev *dev, uint8_t *config,
> > > +                                 size_t config_len)
> > > +{
> > > +    VhostUserMsg msg = {
> > > +        .request = VHOST_USER_GET_CONFIG,
> > > +        .flags = VHOST_USER_VERSION,
> > > +        .size = config_len,
> > > +    };
> > > +
> > > +    if (config_len == 0 || config_len > VHOST_USER_PAYLOAD_SIZE) {
> > 
> > config_len should be limited to 256 bytes:
> > 
> >   if (config_len == 0 || config_len > sizeof(msg.payload.config) {
> 
> I would just limit it to a reasonable value, acceptable to
> both master and slave, not fail if it's bigger.
> 
> 
> > > +        error_report("bad config length");
> > > +        return -1;
> > > +    }
> > > +
> > > +    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
> > > +        return -1;
> > > +    }
> > > +
> > > +    if (vhost_user_read(dev, &msg) < 0) {
> > > +        return -1;
> > > +    }
> > > +
> > > +    if (msg.request != VHOST_USER_GET_CONFIG) {
> > > +        error_report("Received unexpected msg type. Expected %d received %d",
> > > +                     VHOST_USER_GET_CONFIG, msg.request);
> > > +        return -1;
> > > +    }
> > > +
> > > +    if (msg.size != config_len) {
> > > +        error_report("Received bad msg size.");
> > > +        return -1;
> > > +    }
> > > +
> > > +    memcpy(config, &msg.payload.config, config_len);
> > 
> > There is some complexity here: different virtio devices use different
> > amounts of config space.  Devices may append new fields to the config
> > space to support new features.
> > 
> > Therefore I think the simplest protocol is to always fetch the full
> > 256-byte configuration space.  This way the vhost-user slave process can
> > implement feature bits that the master process does not know about.
> > 
> > In other words, I don't think the master process knows how much of the
> > config space is used so it should always request 256 bytes.
> 
> Each device knows the max config space size.
> 
>     vdev->config_len = config_size;

I see you're referring to the field that is set in:

  void virtio_init(VirtIODevice *vdev, const char *name,
                   uint16_t device_id, size_t config_size)

How does this work for vhost-user where different slave programs may
offer different config sizes?

The QEMU master process does not know the correct size ahead of time.
The size depends on the vhost-user slave process.  This is why I suggest
using the full 256 bytes that the VIRTIO spec defines.
