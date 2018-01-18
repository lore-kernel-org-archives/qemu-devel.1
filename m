Received: from eggs.gnu.org ([2001:4830:134:3::10]:46081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1ecE4j-0003LF-Bj
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 12:34:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1ecE4i-0006ob-Fl
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 12:34:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imbrenda@linux.vnet.ibm.com>)
	id 1ecE4i-0006oM-7F
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 12:34:04 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0IHTJIB093110
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 12:33:58 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fjwa1s5vb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 12:33:57 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <imbrenda@linux.vnet.ibm.com>;
	Thu, 18 Jan 2018 17:33:55 -0000
Date: Thu, 18 Jan 2018 18:33:51 +0100
From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
In-Reply-To: <20180118182547.2e1b630b.cohuck@redhat.com>
References: <1516035122-7617-1-git-send-email-imbrenda@linux.vnet.ibm.com>
	<20180118172034.3dda2622.cohuck@redhat.com>
	<20180118175229.42b27779@p-imbrenda.boeblingen.de.ibm.com>
	<20180118180240.7d678384.cohuck@redhat.com>
	<20180118182317.4ab785be@p-imbrenda.boeblingen.de.ibm.com>
	<20180118182547.2e1b630b.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20180118183351.2a9c5506@p-imbrenda.boeblingen.de.ibm.com>
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>

On Thu, 18 Jan 2018 18:25:47 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

...
[snip]

> > > > > > diff --git a/hw/s390x/s390-stattrib-kvm.c
> > > > > > b/hw/s390x/s390-stattrib-kvm.c index 41770a7..480551c 100644
> > > > > > --- a/hw/s390x/s390-stattrib-kvm.c
> > > > > > +++ b/hw/s390x/s390-stattrib-kvm.c
> > > > > > @@ -116,7 +116,7 @@ static void
> > > > > > kvm_s390_stattrib_synchronize(S390StAttribState *sa) for
> > > > > > (cx = 0; cx + len <= max; cx += len) { clog.start_gfn = cx;
> > > > > >              clog.count = len;
> > > > > > -            clog.values = (uint64_t)(sas->incoming_buffer
> > > > > > + cx
> > > > > > * len);          
> > > > > 
> > > > > Hm, doesn't that even imply that you reference an area beyond
> > > > > the buffer, as the <= max check does not catch this?        
> > > > 
> > > > what do you mean?
> > > > 
> > > > cx + len <= max catches the cases where you would write beyond
> > > > the end of the buffer. if cx + len == max then we are filling
> > > > the buffer to the last byte. and we will get out at the next
> > > > iteration.      
> > > 
> > > Yes, but the problem is that your offset is too long, isn't it?
> > > (Where cx + len <= max, but you use an offset of cx * len which
> > > may be > max.)    
> > 
> > which is exactly why I'm removing that line. look at the very
> > beginning of the line, there is a -
> > 
> > the replacement line (the one that starts with a +) has only cx  
> 
> Err, yes :) I simply wanted to comment that this looks worse than "not
> migrated completely".

yeah, that's true :) but the offset ended up big enough to always
get -EFAULT from the kernel and get ignored by qemu afterwards, which
then resulted in not all values being migrated.

should I change the description to explain the issue in more detail?

[snip]
...
