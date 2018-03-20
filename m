Received: from eggs.gnu.org ([2001:4830:134:3::10]:59385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyFri-0003D6-RK
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 07:55:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyFrf-0004Nl-Pl
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 07:55:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55826 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eyFrf-0004NF-AR
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 07:55:39 -0400
Date: Tue, 20 Mar 2018 13:55:38 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180320135337-mutt-send-email-mst@kernel.org>
References: <1521224390-425343-1-git-send-email-mst@redhat.com>
	<B2D15215269B544CADD246097EACE7473ABF2928@DGGEMM505-MBS.china.huawei.com>
	<20180320043525-mutt-send-email-mst@kernel.org>
	<20180320080538.2e523aeb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320080538.2e523aeb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] vhost-user: avoid misaligned access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Zhoujian (jay)" <jianjay.zhou@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Tue, Mar 20, 2018 at 08:05:38AM +0100, Igor Mammedov wrote:
> On Tue, 20 Mar 2018 04:36:48 +0200
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Tue, Mar 20, 2018 at 02:01:07AM +0000, Zhoujian (jay) wrote:
> > > 
> > >   
> > > > -----Original Message-----
> > > > From: Michael S. Tsirkin [mailto:mst@redhat.com]
> > > > Sent: Saturday, March 17, 2018 2:20 AM
> > > > To: qemu-devel@nongnu.org
> > > > Cc: Zhoujian (jay) <jianjay.zhou@huawei.com>
> > > > Subject: [PATCH] vhost-user: avoid misaligned access
> > > > 
> > > > We can't pass a pointer to memory field directly since it's within a packed
> > > > structure, so isn't aligned.
> > > > Pass a pointer on stack and copy.
> > > > 
> > > > Fixes: 30c4cc7 ("vhost: used_memslots refactoring")
> > > > Cc: Jay Zhou <jianjay.zhou@huawei.com>
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > ---
> > > > 
> > > > I had to apply this to fix make check errors with clang.
> > > > Pls review, test and ack.
> > > > 
> > > > Thanks!
> > > > 
> > > >  hw/virtio/vhost-user.c | 14 +++++++++++---
> > > >  1 file changed, 11 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c index
> > > > c12fdd9..a44ee7f 100644
> > > > --- a/hw/virtio/vhost-user.c
> > > > +++ b/hw/virtio/vhost-user.c
> > > > @@ -396,6 +396,7 @@ static int vhost_user_set_mem_table_postcopy(struct
> > > > vhost_dev *dev,
> > > >      bool reply_supported = virtio_has_feature(dev->protocol_features,
> > > > 
> > > > VHOST_USER_PROTOCOL_F_REPLY_ACK);
> > > >      VhostUserMsg msg_reply;
> > > > +    VhostUserMemory memory = {};
> > > >      int region_i, msg_i;
> > > > 
> > > >      VhostUserMsg msg = {
> > > > @@ -407,10 +408,11 @@ static int vhost_user_set_mem_table_postcopy(struct
> > > > vhost_dev *dev,
> > > >          msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
> > > >      }
> > > > 
> > > > -    if (vhost_user_prepare_msg(dev, &msg.payload.memory, fds) < 0) {
> > > > +    if (vhost_user_prepare_msg(dev, &memory, fds) < 0) {
> > > >          error_report("Failed preparing vhost-user memory table msg");
> > > >          return -1;
> > > >      }
> > > > +    msg.payload.memory = memory;
> > > > 
> > > >      fd_num = msg.payload.memory.nregions;
> > > > 
> > > > @@ -549,16 +551,19 @@ static int vhost_user_set_mem_table(struct vhost_dev
> > > > *dev,
> > > >          .hdr.request = VHOST_USER_SET_MEM_TABLE,
> > > >          .hdr.flags = VHOST_USER_VERSION,
> > > >      };
> > > > +    VhostUserMemory memory = {};
> > > > 
> > > >      if (reply_supported) {
> > > >          msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
> > > >      }
> > > > 
> > > > -    if (vhost_user_prepare_msg(dev, &msg.payload.memory, fds) < 0) {
> > > > +    if (vhost_user_prepare_msg(dev, &memory, fds) < 0) {
> > > >          error_report("Failed preparing vhost-user memory table msg");
> > > >          return -1;
> > > >      }
> > > > 
> > > > +    msg.payload.memory = memory;
> > > > +
> > > >      fd_num = msg.payload.memory.nregions;
> > > > 
> > > >      if (!fd_num) {
> > > > @@ -1575,8 +1580,11 @@ static void vhost_user_set_used_memslots(struct
> > > > vhost_dev *dev)  {
> > > >      int fds[VHOST_MEMORY_MAX_NREGIONS];
> > > >      VhostUserMsg msg;
> > > > +    VhostUserMemory memory = {};
> > > > +
> > > > +    vhost_user_prepare_msg(dev, &memory, fds);
> > > > 
> > > > -    vhost_user_prepare_msg(dev, &msg.payload.memory, fds);
> > > > +    msg.payload.memory = memory;
> > > >  }  
> > 
> > FYI I think it's better to pass pointer to msg to
> > avoid alignment issues.
> > 
> > > Hi Michael, here should be like this:
> > > 
> > > 
> > > static void vhost_user_set_used_memslots(struct vhost_dev *dev)
> > >  {
> > >      int fds[VHOST_MEMORY_MAX_NREGIONS];
> > > -    VhostUserMsg msg;
> > > +    VhostUserMemory memory = {};
> > >  
> > > -    vhost_user_prepare_msg(dev, &msg.payload.memory, fds);
> > > +    vhost_user_prepare_msg(dev, &memory, fds);
> > >  }
> > > 
> > > 
> > > Regards,
> > > Jay  
> > 
> > 
> > But what's the point of all this? The structure is discarded
> > after being initialized. Doesn't look right to me.
> I think it was my idea,
> point is to share vhost_user_prepare_msg() between
> _set_used_memslots and _set_mem_table* instead of
> duplicating code, of cause at the cost of discarding
> results in vhost_user_set_used_memslots()

So vhost_user_prepare_msg has a side effect of setting a
global flag, that is why it's called here.
Pls add a comment both near vhost_user_prepare_msg and where
it's called.

> > 
> > > > 
> > > >  const VhostOps user_ops = {
> > > > --
> > > > MST  
> > 
