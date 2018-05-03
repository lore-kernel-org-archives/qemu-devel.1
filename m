Received: from eggs.gnu.org ([2001:4830:134:3::10]:33499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEGvx-0001ks-D9
	for qemu-devel@nongnu.org; Thu, 03 May 2018 12:18:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEGvt-00008a-B4
	for qemu-devel@nongnu.org; Thu, 03 May 2018 12:18:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44822 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fEGvt-000085-0T
	for qemu-devel@nongnu.org; Thu, 03 May 2018 12:18:13 -0400
References: <20161214150840.10899-1-alex@alex.org.uk>
	<20161214170956.32o6b27baf3bkmd4@grep.be>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6afae83e-1cf1-9090-950a-f0855a2f2227@redhat.com>
Date: Thu, 3 May 2018 11:18:03 -0500
MIME-Version: 1.0
In-Reply-To: <20161214170956.32o6b27baf3bkmd4@grep.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Nbd] [PATCH] Further tidy-up on block status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wouter Verhelst <w@uter.be>, Alex Bligh <alex@alex.org.uk>
Cc: nbd-general@lists.sourceforge.net, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, Pavel Borzenkov <pborzenkov@virtuozzo.com>, stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Markus Pargmann <mpa@pengutronix.de>, "Denis V . Lunev" <den@openvz.org>, John Snow <jsnow@redhat.com>

Reviving this discussion, as it still seems useful to incorporate now 
that BLOCK_STATUS is only recently part of the standard.

On 12/14/2016 11:09 AM, Wouter Verhelst wrote:

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
>    In case the server returns N extents, the sum of the *length* fields
>    of the first N-1 extents MUST NOT be greater than the overall *length*
>    of the request. The final extent MAY exceed the length of the request
>    if the server has that information anyway as a side effect of looking
>    up the required information and wishes to share it.
> 
> This would then result in the fact that the "length" field in the
> BLOCK_STATUS command would be little more than a hint, since we're
> saying that a server can return more data than requested (if it's
> available anyway) and less data than requested (if it would be too
> resource-intensive to provide all the information). Not sure whether all
> that makes much sense anymore, but hey.
> 
> In addition, the combination of a server providing more information than
> requested with a "REQ_ONE" flag and a length field of zero could be an
> interesting way to enumerate a whole export, too. Essentially, we could
> define that as a client saying "I'm interested in what the size of the
> extent at offset X is, and what its properties are".
> 
> Thoughts?
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
