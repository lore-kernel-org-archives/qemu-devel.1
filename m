Received: from eggs.gnu.org ([2001:4830:134:3::10]:54074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fBzGT-0007hb-43
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:02:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fBzGP-00017N-DT
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:02:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38000 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fBzGP-00016l-85
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:01:57 -0400
Date: Fri, 27 Apr 2018 10:01:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180427090152.GB32172@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1524666934-8064-1-git-send-email-lidongchen@tencent.com>
	<1524666934-8064-4-git-send-email-lidongchen@tencent.com>
	<20180426164011.GM2631@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180426164011.GM2631@work-vm>
Subject: Re: [Qemu-devel] [PATCH v2 3/5] migration: remove unnecessary
 variables len in QIOChannelRDMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Lidong Chen <jemmy858585@gmail.com>, quintela@redhat.com, qemu-devel@nongnu.org, galsha@mellanox.com, aviadye@mellanox.com, licq@mellanox.com, adido@mellanox.com, Lidong Chen <lidongchen@tencent.com>

On Thu, Apr 26, 2018 at 05:40:11PM +0100, Dr. David Alan Gilbert wrote:
> * Lidong Chen (jemmy858585@gmail.com) wrote:
> > Because qio_channel_rdma_writev and qio_channel_rdma_readv maybe invoked
> > by different threads concurrently, this patch removes unnecessary variables
> > len in QIOChannelRDMA and use local variable instead.
> > 
> > Signed-off-by: Lidong Chen <lidongchen@tencent.com>
> 
> I'm OK with this patch as is; but now you're making me worried that I
> don't quite understand what thrads are accessing it at the same time; we
> need to document/comment what's accessed concurrently.

FWIW, I have always intended that QIOChannel impls be able to support
bidirectional I/O from multiple threads, provided they each are using
it in a different direction. So this is a mistake in my original RDMA
impl.

> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> > ---
> >  migration/rdma.c | 15 +++++++--------
> >  1 file changed, 7 insertions(+), 8 deletions(-)
> > 
> > diff --git a/migration/rdma.c b/migration/rdma.c
> > index c745427..f5c1d02 100644
> > --- a/migration/rdma.c
> > +++ b/migration/rdma.c
> > @@ -404,7 +404,6 @@ struct QIOChannelRDMA {
> >      QIOChannel parent;
> >      RDMAContext *rdma;
> >      QEMUFile *file;
> > -    size_t len;
> >      bool blocking; /* XXX we don't actually honour this yet */
> >  };
> >  
> > @@ -2640,6 +2639,7 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
> >      int ret;
> >      ssize_t done = 0;
> >      size_t i;
> > +    size_t len = 0;
> >  
> >      CHECK_ERROR_STATE();
> >  
> > @@ -2659,10 +2659,10 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
> >          while (remaining) {
> >              RDMAControlHeader head;
> >  
> > -            rioc->len = MIN(remaining, RDMA_SEND_INCREMENT);
> > -            remaining -= rioc->len;
> > +            len = MIN(remaining, RDMA_SEND_INCREMENT);
> > +            remaining -= len;
> >  
> > -            head.len = rioc->len;
> > +            head.len = len;
> >              head.type = RDMA_CONTROL_QEMU_FILE;
> >  
> >              ret = qemu_rdma_exchange_send(rdma, &head, data, NULL, NULL, NULL);
> > @@ -2672,8 +2672,8 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
> >                  return ret;
> >              }
> >  
> > -            data += rioc->len;
> > -            done += rioc->len;
> > +            data += len;
> > +            done += len;
> >          }
> >      }
> >  
> > @@ -2768,8 +2768,7 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
> >              }
> >          }
> >      }
> > -    rioc->len = done;
> > -    return rioc->len;
> > +    return done;
> >  }
> >  
> >  /*
> > -- 
> > 1.8.3.1
> > 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
