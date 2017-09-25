Received: from eggs.gnu.org ([2001:4830:134:3::10]:44964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dwXcm-0002ci-N3
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 13:56:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dwXcj-0007gn-Lt
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 13:56:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dwXcj-0007gV-Fc
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 13:56:53 -0400
Date: Mon, 25 Sep 2017 18:56:38 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170925175637.GH2656@work-vm>
References: <20170824192730.8440-1-dgilbert@redhat.com>
	<20170824192730.8440-26-dgilbert@redhat.com>
	<20170830065002.GA10627@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830065002.GA10627@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [RFC v2 25/32] vhost+postcopy: Lock around
 set_mem_table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, a.perevalov@samsung.com, mst@redhat.com, marcandre.lureau@redhat.com, quintela@redhat.com, lvivier@redhat.com, aarcange@redhat.com, felipe@nutanix.com

* Peter Xu (peterx@redhat.com) wrote:
> On Thu, Aug 24, 2017 at 08:27:23PM +0100, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > **HACK - better solution needed **
> > We have the situation where:
> > 
> >      qemu                      bridge
> > 
> >      send set_mem_table
> >                               map memory
> >   a)                          mark area with UFD
> >                               send reply with map addresses
> >   b)                          start using
> >   c) receive reply
> > 
> >   As soon as (a) happens qemu might start seeing faults
> > from memory accesses (but doesn't until b); but it can't
> > process those faults until (c) when it's received the
> > mmap addresses.
> > 
> > Make the fault handler spin until it gets the reply in (c).
> > 
> > At the very least this needs some proper locks, but preferably
> > we need to split the message.
> 
> I see discussions about slave channel and ack mechanism in previous
> post.  So it's still not adopted (which looks doable)?  What's our
> further plan?

Yep I'm going to look at the slave channel stuff.

Dave

> -- 
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
