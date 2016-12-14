Received: from eggs.gnu.org ([2001:4830:134:3::10]:42363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cHDWV-0005CT-E2
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:39:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cHDWU-0001K3-Gb
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:39:23 -0500
Received: from mail.avalus.com ([2001:41c8:10:1dd::10]:50362)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cHDWU-0001Js-A8
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:39:22 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <20161214170956.32o6b27baf3bkmd4@grep.be>
Date: Wed, 14 Dec 2016 17:39:21 +0000
Content-Transfer-Encoding: 7bit
Message-Id: <42886594-E545-407C-9690-B73089887A6C@alex.org.uk>
References: <20161214150840.10899-1-alex@alex.org.uk>
	<20161214170956.32o6b27baf3bkmd4@grep.be>
Subject: Re: [Qemu-devel] [Nbd] [PATCH] Further tidy-up on block status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wouter Verhelst <w@uter.be>
Cc: Alex Bligh <alex@alex.org.uk>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Pavel Borzenkov <pborzenkov@virtuozzo.com>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, "Denis V . Lunev" <den@openvz.org>, Markus Pargmann <mpa@pengutronix.de>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>

Wouter,

> Right. I think we're getting close to a good spec now, for this thing.
> 
> One thing I've been thinking about that we might want to add:
> 
> There may be cases where a server, in performing the required calls to
> be able to handle a BLOCK_STATUS request, will end up with more
> information than the client asked; e.g., if the client asked information
> in the base:allocation context on an extent at offset X of length Y,
> then the server might conceivably do an lseek(SEEK_DATA) and/or
> lseek(SEEK_HOLE). The result of that call might be that the file offset
> will now point to a location Z, where Z > (X+Y).
> 
> Currently, our spec says "the sum of the *length* fields MUST not be
> greater than the overall *length* of request". This means that in
> essense, the server then has to throw away the information it has on the
> range Z - (X + Y). In case a client was interested in that information,
> that seems like a waste. I would therefore like to remove that
> requirement, by rephrasing that "sum of the *length* fields" thing into
> something along the following lines:
> 
>  In case the server returns N extents, the sum of the *length* fields
>  of the first N-1 extents MUST NOT be greater than the overall *length*
>  of the request. The final extent MAY exceed the length of the request
>  if the server has that information anyway as a side effect of looking
>  up the required information and wishes to share it.
> 
> This would then result in the fact that the "length" field in the
> BLOCK_STATUS command would be little more than a hint, since we're
> saying that a server can return more data than requested (if it's
> available anyway) and less data than requested (if it would be too
> resource-intensive to provide all the information). Not sure whether all
> that makes much sense anymore, but hey.

+1

> In addition, the combination of a server providing more information than
> requested with a "REQ_ONE" flag and a length field of zero could be an
> interesting way to enumerate a whole export, too. Essentially, we could
> define that as a client saying "I'm interested in what the size of the
> extent at offset X is, and what its properties are".

Also +1

-- 
Alex Bligh
