Received: from eggs.gnu.org ([2001:4830:134:3::10]:56267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dTRpp-0001RU-Er
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 07:54:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dTRpm-0001IH-Cc
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 07:54:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dTRpm-0001Hx-63
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 07:54:06 -0400
Date: Fri, 7 Jul 2017 12:53:53 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170707115353.GD2451@work-vm>
References: <20170628190047.26159-1-dgilbert@redhat.com>
	<20170628190047.26159-25-dgilbert@redhat.com>
	<2f4c1067-14a4-d943-0dff-790d705778f1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f4c1067-14a4-d943-0dff-790d705778f1@redhat.com>
Subject: Re: [Qemu-devel] [RFC 24/29] vhost+postcopy: Lock around
 set_mem_table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: qemu-devel@nongnu.org, a.perevalov@samsung.com, marcandre.lureau@redhat.com, mst@redhat.com, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com

* Maxime Coquelin (maxime.coquelin@redhat.com) wrote:
> 
> 
> On 06/28/2017 09:00 PM, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert"<dgilbert@redhat.com>
> > 
> > **HACK - better solution needed **
> > We have the situation where:
> > 
> >       qemu                      bridge
> > 
> >       send set_mem_table
> >                                map memory
> >    a)                          mark area with UFD
> >                                send reply with map addresses
> >    b)                          start using
> >    c) receive reply
> > 
> >    As soon as (a) happens qemu might start seeing faults
> > from memory accesses (but doesn't until b); but it can't
> > process those faults until (c) when it's received the
> > mmap addresses.
> > 
> > Make the fault handler spin until it gets the reply in (c).
> > 
> > At the very least this needs some proper locks, but preferably
> > we need to split the message.
> 
> Yes, maybe the slave channel could be used to send the ufds with
> a dedicated request? The backend would set the reply-ack flag, so that
> it starts accessing the guest memory only when Qemu is ready to handle
> faults.

Yes, that would make life a lot easier.

> Note that the slave channel support has not been implemented in Qemu's
> libvhost-user yet, but this is something I can do if we feel the need.

Can you tell me a bit about how the slave channel works?

Dave

> Maxime
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
