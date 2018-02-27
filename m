Received: from eggs.gnu.org ([2001:4830:134:3::10]:44107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eqcCe-00080E-3y
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 05:09:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eqcCZ-0003lB-1O
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 05:09:44 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40778 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eqcCY-0003kB-RU
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 05:09:38 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8BDF74040852
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 10:09:38 +0000 (UTC)
Date: Tue, 27 Feb 2018 10:09:34 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180227100934.GA2847@work-vm>
References: <20180216131625.9639-1-dgilbert@redhat.com>
	<20180216131625.9639-25-dgilbert@redhat.com>
	<20180226222712-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226222712-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v3 24/29] vhost-user: Add
 VHOST_USER_POSTCOPY_END message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, marcandre.lureau@redhat.com, peterx@redhat.com, imammedo@redhat.com, quintela@redhat.com, aarcange@redhat.com

* Michael S. Tsirkin (mst@redhat.com) wrote:
> On Fri, Feb 16, 2018 at 01:16:20PM +0000, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > This message is sent just before the end of postcopy to get the
> > client to stop using userfault since we wont respond to any more
> > requests.  It should close userfaultfd so that any other pages
> > get mapped to the backing file automatically by the kernel, since
> > at this point we know we've received everything.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > ---
> >  contrib/libvhost-user/libvhost-user.c | 23 +++++++++++++++++++++++
> >  contrib/libvhost-user/libvhost-user.h |  1 +
> >  docs/interop/vhost-user.txt           |  8 ++++++++
> >  hw/virtio/vhost-user.c                |  1 +
> >  4 files changed, 33 insertions(+)
> > 
> > diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
> > index 1b224af706..1f988ab787 100644
> > --- a/contrib/libvhost-user/libvhost-user.c
> > +++ b/contrib/libvhost-user/libvhost-user.c
> > @@ -99,6 +99,7 @@ vu_request_to_string(unsigned int req)
> >          REQ(VHOST_USER_SET_CONFIG),
> >          REQ(VHOST_USER_POSTCOPY_ADVISE),
> >          REQ(VHOST_USER_POSTCOPY_LISTEN),
> > +        REQ(VHOST_USER_POSTCOPY_END),
> >          REQ(VHOST_USER_MAX),
> >      };
> >  #undef REQ
> > @@ -1095,6 +1096,26 @@ vu_set_postcopy_listen(VuDev *dev, VhostUserMsg *vmsg)
> >      vmsg->payload.u64 = 0; /* Success */
> >      return true;
> >  }
> > +
> > +static bool
> > +vu_set_postcopy_end(VuDev *dev, VhostUserMsg *vmsg)
> > +{
> > +    DPRINT("%s: Entry\n", __func__);
> > +    dev->postcopy_listening = false;
> > +    if (dev->postcopy_ufd > 0) {
> > +        close(dev->postcopy_ufd);
> > +        dev->postcopy_ufd = -1;
> > +        DPRINT("%s: Done close\n", __func__);
> > +    }
> > +
> > +    vmsg->fd_num = 0;
> > +    vmsg->payload.u64 = 0;
> > +    vmsg->size = sizeof(vmsg->payload.u64);
> > +    vmsg->flags = VHOST_USER_VERSION |  VHOST_USER_REPLY_MASK;
> > +    DPRINT("%s: exit\n", __func__);
> > +    return true;
> > +}
> > +
> >  static bool
> >  vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
> >  {
> > @@ -1170,6 +1191,8 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
> >          return vu_set_postcopy_advise(dev, vmsg);
> >      case VHOST_USER_POSTCOPY_LISTEN:
> >          return vu_set_postcopy_listen(dev, vmsg);
> > +    case VHOST_USER_POSTCOPY_END:
> > +        return vu_set_postcopy_end(dev, vmsg);
> >      default:
> >          vmsg_close_fds(vmsg);
> >          vu_panic(dev, "Unhandled request: %d", vmsg->request);
> > diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
> > index fcba53c3c3..9696b89f6e 100644
> > --- a/contrib/libvhost-user/libvhost-user.h
> > +++ b/contrib/libvhost-user/libvhost-user.h
> > @@ -84,6 +84,7 @@ typedef enum VhostUserRequest {
> >      VHOST_USER_SET_CONFIG = 25,
> >      VHOST_USER_POSTCOPY_ADVISE  = 26,
> >      VHOST_USER_POSTCOPY_LISTEN  = 27,
> > +    VHOST_USER_POSTCOPY_END     = 28,
> >      VHOST_USER_MAX
> >  } VhostUserRequest;
> >  
> > diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
> > index 5bbcab2cc4..4bf7d8ef99 100644
> > --- a/docs/interop/vhost-user.txt
> > +++ b/docs/interop/vhost-user.txt
> > @@ -697,6 +697,14 @@ Master message types
> >  
> >        Master advises slave that a transition to postcopy mode has happened.
> >  
> > + * VHOST_USER_POSTCOPY_END
> > +      Id: 28
> > +      Slave payload: u64
> > +
> > +      Master advises that postcopy migration has now completed.  The
> > +      slave must disable the userfaultfd. The response is an acknowledgement
> > +      only.
> > +
> >  Slave message types
> >  -------------------
> >  
> 
> Which protocol feature enables this message?

VHOST_USER_PROTOCOL_F_PAGEFAULT - if you have that,
AND postcopy-ram is enabled
AND postcopy mode is entered

you'll get VHOST_USER_POSTCOPY_LISTEN and sometime later
VHOST_USER_POSTCOPY_END.

Dave

> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > index 74807091a0..cf7923b25f 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
> > @@ -78,6 +78,7 @@ typedef enum VhostUserRequest {
> >      VHOST_USER_SET_CONFIG = 25,
> >      VHOST_USER_POSTCOPY_ADVISE  = 26,
> >      VHOST_USER_POSTCOPY_LISTEN  = 27,
> > +    VHOST_USER_POSTCOPY_END     = 28,
> >      VHOST_USER_MAX
> >  } VhostUserRequest;
> >  
> > -- 
> > 2.14.3
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
