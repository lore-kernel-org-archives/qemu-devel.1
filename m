Received: from eggs.gnu.org ([2001:4830:134:3::10]:38201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cnpEi-0008EM-TB
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:23:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cnpEf-00020U-NG
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:23:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cnpEf-0001zW-Ej
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:23:45 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 986C6C05AA65
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 16:23:45 +0000 (UTC)
Date: Tue, 14 Mar 2017 16:23:41 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170314162340.GN2445@work-vm>
References: <20170313124434.1043-1-quintela@redhat.com>
	<20170314102142.GC2445@work-vm> <20170314114704.GJ2652@redhat.com>
	<20170314122222.GH2445@work-vm> <20170314123420.GN2652@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170314123420.GN2652@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 00/16] Multifd v4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org

* Daniel P. Berrange (berrange@redhat.com) wrote:
> On Tue, Mar 14, 2017 at 12:22:23PM +0000, Dr. David Alan Gilbert wrote:
> > * Daniel P. Berrange (berrange@redhat.com) wrote:
> > > On Tue, Mar 14, 2017 at 10:21:43AM +0000, Dr. David Alan Gilbert wrote:
> > > > * Juan Quintela (quintela@redhat.com) wrote:
> > > > > Hi
> > > > > 
> > > > > This is the 4th version of multifd. Changes:
> > > > > - XBZRLE don't need to be checked for
> > > > > - Documentation and defaults are consistent
> > > > > - split socketArgs
> > > > > - use iovec instead of creating something similar.
> > > > > - We use now the exported size of target page (another HACK removal)
> > > > > - created qio_chanel_{wirtev,readv}_all functions.  the _full() name
> > > > >   was already taken.
> > > > >   What they do is the same that the without _all() function, but if it
> > > > >   returns due to blocking it redo the call.
> > > > > - it is checkpatch.pl clean now.
> > > > > 
> > > > > Please comment, Juan.
> > > > 
> > > > High level things,
> > > >   a) I think you probably need to do some bandwidth measurements to show
> > > >     that multifd is managing to have some benefit - it would be good
> > > >     for the cover letter.
> > > 
> > > Presumably this would be a building block to solving the latency problems
> > > with post-copy, by reserving one channel for use transferring out of band
> > > pages required by target host page faults.
> > 
> > Right, it's on my list to look at;  there's some interesting questions about
> > the way in which the main fd carrying the headers interacts, and also what
> > happens to pages immediately after the requested page; for example, lets
> > say we're currently streaming at address 'S' and a postcopy request (P) comes in;
> > so what we currently have on one FD is:
> > 
> >     S,S+1....S+n,P,P+1,P+2,P+n
> > 
> > Note that when a request comes in we flip location so we start sending background
> > pages from P+1 on the assumption that they'll be wanted soon.
> > 
> > with 3 FDs this would go initially as:
> >     S    S+3 P+1 P+4
> >     S+1  S+4 P+2 ..
> >     S+2  P   P+3 ..
> > 
> > now if we had a spare FD for postcopy we'd do:
> >     S    S+3 P+1 P+4
> >     S+1  S+4 P+2 ..
> >     S+2  S+5 P+3 ..
> >     -    P   -   -
> > 
> > So 'P' got there quickly - but P+1 is stuck behind the S's; is that what we want?
> > An interesting alternative would be to switch which fd we keep free:
> >     S    S+3 -   -   -
> >     S+1  S+4 P+2 P+4
> >     S+2  S+5 P+3 P+5
> >     -    P   P+1 P+6
> >   
> > So depending on your buffering P+1 might also now be pretty fast; but that's
> > starting to get into heuristics about guessing how much you should put on
> > your previously low-queue'd fd.
> 
> Ah, I see, so you're essentially trying todo read-ahead when post-copy
> faults. It becomes even more fun when you have multiple page faults
> coming in, (quite likely with multi-vCPU guests), as you have P, Q, R, S
> come in, all of which want servicing quickly. So if you queue up too
> many P+n pages for read-ahead, you'd delay Q, R & S
> 
>      S    S+3 -   -   -
>      S+1  S+4 P+2 P+4 Q   R   ...
>      S+2  S+5 P+3 P+5 Q+1 R+1 ...
>      -    P   P+1 P+6 Q+2 ... ...
> 
> this tends to argue for overcommitting threads vs cpus. eg even if QEMU
> is confined to only use 2 host CPUs, it would be worth having 4 migration
> threads. They would contend for CPU time for AES encryption, but you
> would reduce chance of getting stuck behind large send-buffers.

Possibly although it becomes very heuristicy; and then I'm not sure what
happens when you find you've got AES offload hardware.
I also worry again about the fd carrying the headers, if the destination
gets bottlenecked reading pages off the other fd's it might not get to the
postcopy page.
So you can bottleneck on any of network bandwidth, source CPU bandwidth
or destination CPU bandwidth (which I think is where the current bottleneck
on one fd tends to be with no encryption/compression).

I think there's a syscall where you can ask how much is buffered in a socket,
of course that can only tell you about the sender, so really you do want to be
setup so that the source is trying to send no faster than the destination can
read it.

Dave

> Regards,
> Daniel
> -- 
> |: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
> |: http://libvirt.org              -o-             http://virt-manager.org :|
> |: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
