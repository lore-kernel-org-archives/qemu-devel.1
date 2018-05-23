Received: from eggs.gnu.org ([2001:4830:134:3::10]:34603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1fLcvK-00074L-QI
	for qemu-devel@nongnu.org; Wed, 23 May 2018 19:12:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1fLcvH-0004PN-L9
	for qemu-devel@nongnu.org; Wed, 23 May 2018 19:12:02 -0400
Received: from mga11.intel.com ([192.55.52.93]:36350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1fLcvH-0004O8-Ax
	for qemu-devel@nongnu.org; Wed, 23 May 2018 19:11:59 -0400
Date: Thu, 24 May 2018 07:12:15 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180523231215.GA15604@debian>
References: <20180412151232.17506-1-tiwei.bie@intel.com>
	<20180412151232.17506-4-tiwei.bie@intel.com>
	<20180524002447-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180524002447-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v3 3/6] vhost-user:
 support receiving file descriptors in slave_read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com

On Thu, May 24, 2018 at 12:25:23AM +0300, Michael S. Tsirkin wrote:
> On Thu, Apr 12, 2018 at 11:12:29PM +0800, Tiwei Bie wrote:
> > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> 
> 
> Thinking about it, I think we should add a protocol
> feature for this. This way remote can find out whether
> it's safe to send this data to us.

Okay, I can add a protocol feature for this.
Do you think it's OK to keep this patch as is
(this patch just extends slave_read() to support
receiving file descriptors) and introduce the
new protocol feature in a new patch to allow
backends to send file descriptors?

Best regards,
Tiwei Bie

> 
> > ---
> >  hw/virtio/vhost-user.c | 41 ++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 40 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > index 91edd95453..9cea2c8c51 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
> > @@ -854,14 +854,44 @@ static void slave_read(void *opaque)
> >      VhostUserHeader hdr = { 0, };
> >      VhostUserPayload payload = { 0, };
> >      int size, ret = 0;
> > +    struct iovec iov;
> > +    struct msghdr msgh;
> > +    int fd = -1;
> > +    char control[CMSG_SPACE(sizeof(fd))];
> > +    struct cmsghdr *cmsg;
> > +    size_t fdsize;
> > +
> > +    memset(&msgh, 0, sizeof(msgh));
> > +    msgh.msg_iov = &iov;
> > +    msgh.msg_iovlen = 1;
> > +    msgh.msg_control = control;
> > +    msgh.msg_controllen = sizeof(control);
> >  
> >      /* Read header */
> > -    size = read(u->slave_fd, &hdr, VHOST_USER_HDR_SIZE);
> > +    iov.iov_base = &hdr;
> > +    iov.iov_len = VHOST_USER_HDR_SIZE;
> > +
> > +    size = recvmsg(u->slave_fd, &msgh, 0);
> >      if (size != VHOST_USER_HDR_SIZE) {
> >          error_report("Failed to read from slave.");
> >          goto err;
> >      }
> >  
> > +    if (msgh.msg_flags & MSG_CTRUNC) {
> > +        error_report("Truncated message.");
> > +        goto err;
> > +    }
> > +
> > +    for (cmsg = CMSG_FIRSTHDR(&msgh); cmsg != NULL;
> > +         cmsg = CMSG_NXTHDR(&msgh, cmsg)) {
> > +            if (cmsg->cmsg_level == SOL_SOCKET &&
> > +                cmsg->cmsg_type == SCM_RIGHTS) {
> > +                    fdsize = cmsg->cmsg_len - CMSG_LEN(0);
> > +                    memcpy(&fd, CMSG_DATA(cmsg), fdsize);
> > +                    break;
> > +            }
> > +    }
> > +
> >      if (hdr.size > VHOST_USER_PAYLOAD_SIZE) {
> >          error_report("Failed to read msg header."
> >                  " Size %d exceeds the maximum %zu.", hdr.size,
> > @@ -885,9 +915,15 @@ static void slave_read(void *opaque)
> >          break;
> >      default:
> >          error_report("Received unexpected msg type.");
> > +        if (fd != -1) {
> > +            close(fd);
> > +        }
> >          ret = -EINVAL;
> >      }
> >  
> > +    /* Message handlers need to make sure that fd will be consumed. */
> > +    fd = -1;
> > +
> >      /*
> >       * REPLY_ACK feature handling. Other reply types has to be managed
> >       * directly in their request handlers.
> > @@ -920,6 +956,9 @@ err:
> >      qemu_set_fd_handler(u->slave_fd, NULL, NULL, NULL);
> >      close(u->slave_fd);
> >      u->slave_fd = -1;
> > +    if (fd != -1) {
> > +        close(fd);
> > +    }
> >      return;
> >  }
> >  
> > -- 
> > 2.11.0
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 
