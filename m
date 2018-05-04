Received: from eggs.gnu.org ([2001:4830:134:3::10]:52707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1fEUOf-0001GE-Mg
	for qemu-devel@nongnu.org; Fri, 04 May 2018 02:40:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1fEUOb-0000hg-80
	for qemu-devel@nongnu.org; Fri, 04 May 2018 02:40:49 -0400
Received: from latin.grep.be ([2a01:4f8:140:52e5::2]:49980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wouter@grep.be>) id 1fEUOa-0000U6-UB
	for qemu-devel@nongnu.org; Fri, 04 May 2018 02:40:45 -0400
Date: Fri, 4 May 2018 08:40:05 +0200
From: Wouter Verhelst <w@uter.be>
Message-ID: <20180504064005.GB7456@grep.be>
References: <20161214150840.10899-1-alex@alex.org.uk>
	<20161214170956.32o6b27baf3bkmd4@grep.be>
	<facb7ba3-edd3-45f9-ca6f-68ac7d5005c9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <facb7ba3-edd3-45f9-ca6f-68ac7d5005c9@redhat.com>
Subject: Re: [Qemu-devel] [Nbd] [PATCH] Further tidy-up on block status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Alex Bligh <alex@alex.org.uk>, nbd list <nbd@other.debian.org>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, "Denis V . Lunev" <den@openvz.org>, John Snow <jsnow@redhat.com>

On Thu, May 03, 2018 at 12:26:36PM -0500, Eric Blake wrote:
> [resend with updated list address and pruning addresses that bounced]
> 
> Reviving this discussion, as it still seems useful to incorporate now that
> BLOCK_STATUS is only recently part of the standard.

Yeah. I thought we'd incorporated it already at the time, but apparently
not.

I still think this is a good idea, and that we should do it.

> On 12/14/2016 11:09 AM, Wouter Verhelst wrote:
> 
> > One thing I've been thinking about that we might want to add:
> > 
> > There may be cases where a server, in performing the required calls to
> > be able to handle a BLOCK_STATUS request, will end up with more
> > information than the client asked; e.g., if the client asked information
> > in the base:allocation context on an extent at offset X of length Y,
> > then the server might conceivably do an lseek(SEEK_DATA) and/or
> > lseek(SEEK_HOLE). The result of that call might be that the file offset
> > will now point to a location Z, where Z > (X+Y).
> > 
> > Currently, our spec says "the sum of the *length* fields MUST not be
> > greater than the overall *length* of request". This means that in
> > essense, the server then has to throw away the information it has on the
> > range Z - (X + Y). In case a client was interested in that information,
> > that seems like a waste. I would therefore like to remove that
> > requirement, by rephrasing that "sum of the *length* fields" thing into
> > something along the following lines:
> > 
> >    In case the server returns N extents, the sum of the *length* fields
> >    of the first N-1 extents MUST NOT be greater than the overall *length*
> >    of the request. The final extent MAY exceed the length of the request
> >    if the server has that information anyway as a side effect of looking
> >    up the required information and wishes to share it.
> > 
> > This would then result in the fact that the "length" field in the
> > BLOCK_STATUS command would be little more than a hint, since we're
> > saying that a server can return more data than requested (if it's
> > available anyway) and less data than requested (if it would be too
> > resource-intensive to provide all the information). Not sure whether all
> > that makes much sense anymore, but hey.
> > 
> > In addition, the combination of a server providing more information than
> > requested with a "REQ_ONE" flag and a length field of zero could be an
> > interesting way to enumerate a whole export, too. Essentially, we could
> > define that as a client saying "I'm interested in what the size of the
> > extent at offset X is, and what its properties are".
> > 
> > Thoughts?
> > 
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 

-- 
Could you people please use IRC like normal people?!?

  -- Amaya Rodrigo Sastre, trying to quiet down the buzz in the DebConf 2008
     Hacklab
