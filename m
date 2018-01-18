Received: from eggs.gnu.org ([2001:4830:134:3::10]:49083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ecEAz-0008JA-F3
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 12:40:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ecEAy-0004cl-93
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 12:40:33 -0500
Date: Thu, 18 Jan 2018 18:40:27 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180118184027.5ff55338.cohuck@redhat.com>
In-Reply-To: <20180118183351.2a9c5506@p-imbrenda.boeblingen.de.ibm.com>
References: <1516035122-7617-1-git-send-email-imbrenda@linux.vnet.ibm.com>
	<20180118172034.3dda2622.cohuck@redhat.com>
	<20180118175229.42b27779@p-imbrenda.boeblingen.de.ibm.com>
	<20180118180240.7d678384.cohuck@redhat.com>
	<20180118182317.4ab785be@p-imbrenda.boeblingen.de.ibm.com>
	<20180118182547.2e1b630b.cohuck@redhat.com>
	<20180118183351.2a9c5506@p-imbrenda.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/1] s390x: fix storage attributes
 migration for non-small guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>

On Thu, 18 Jan 2018 18:33:51 +0100
Claudio Imbrenda <imbrenda@linux.vnet.ibm.com> wrote:

> On Thu, 18 Jan 2018 18:25:47 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> ...
> [snip]
> 
> > > > > > > diff --git a/hw/s390x/s390-stattrib-kvm.c
> > > > > > > b/hw/s390x/s390-stattrib-kvm.c index 41770a7..480551c 100644
> > > > > > > --- a/hw/s390x/s390-stattrib-kvm.c
> > > > > > > +++ b/hw/s390x/s390-stattrib-kvm.c
> > > > > > > @@ -116,7 +116,7 @@ static void
> > > > > > > kvm_s390_stattrib_synchronize(S390StAttribState *sa) for
> > > > > > > (cx = 0; cx + len <= max; cx += len) { clog.start_gfn = cx;
> > > > > > >              clog.count = len;
> > > > > > > -            clog.values = (uint64_t)(sas->incoming_buffer
> > > > > > > + cx
> > > > > > > * len);            
> > > > > > 
> > > > > > Hm, doesn't that even imply that you reference an area beyond
> > > > > > the buffer, as the <= max check does not catch this?          
> > > > > 
> > > > > what do you mean?
> > > > > 
> > > > > cx + len <= max catches the cases where you would write beyond
> > > > > the end of the buffer. if cx + len == max then we are filling
> > > > > the buffer to the last byte. and we will get out at the next
> > > > > iteration.        
> > > > 
> > > > Yes, but the problem is that your offset is too long, isn't it?
> > > > (Where cx + len <= max, but you use an offset of cx * len which
> > > > may be > max.)      
> > > 
> > > which is exactly why I'm removing that line. look at the very
> > > beginning of the line, there is a -
> > > 
> > > the replacement line (the one that starts with a +) has only cx    
> > 
> > Err, yes :) I simply wanted to comment that this looks worse than "not
> > migrated completely".  
> 
> yeah, that's true :) but the offset ended up big enough to always
> get -EFAULT from the kernel and get ignored by qemu afterwards, which
> then resulted in not all values being migrated.

So the moral is: If you're wrong, be really wrong? :)

> 
> should I change the description to explain the issue in more detail?

Just mentioning something like out-of-bounds due to wrong offset or so
would be good.
