Received: from eggs.gnu.org ([2001:4830:134:3::10]:60251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1eEfAN-0003Vp-Aa
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 12:38:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1eEfAJ-0003Cj-4Q
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 12:38:31 -0500
Date: Tue, 14 Nov 2017 18:37:45 +0100
From: Wouter Verhelst <w@uter.be>
Message-ID: <20171114173745.egvtklxyrcprlcdn@grep.be>
References: <CAJSP0QWXF2tS5q-BpmxR9ti0osjzZCFiRxdRDho4pDBLkD3UUQ@mail.gmail.com>
	<CAMxP3BQeUWwFLmb42=-XExRzdLe0egCaEUEF4kXLQ9khH9neWg@mail.gmail.com>
	<90b32a89-6dd8-1f83-4f6f-01bb5479252e@redhat.com>
	<20170114144500.oxoqvrn5x4sdfo74@grep.be>
	<1ef924f8-1e58-fe54-dabc-06873a531412@redhat.com>
	<20170118080126.nyldkjhxdsxd4u2b@grep.be>
	<CAMxP3BTjBSQEhycavgyfWXEA6pTg=sxfHe5sf+nxVY9ejXWMXQ@mail.gmail.com>
	<20170122114339.l3ijhy3uymsru4ed@grep.be>
	<4a5a82d6-7d66-cfb4-bd42-cea596115f6f@redhat.com>
	<09ef1805-8361-5dff-300e-deede4863e55@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09ef1805-8361-5dff-300e-deede4863e55@redhat.com>
Subject: Re: [Qemu-devel] [Nbd] [Qemu-block] How to online resize qemu disk
 with nbd protocol?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Bob Chen <a175818323@gmail.com>, nbd list <nbd@other.debian.org>, Stefan Hajnoczi <stefanha@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>

On Tue, Nov 14, 2017 at 10:41:39AM -0600, Eric Blake wrote:
> Another thought - with structured replies, we finally have a way to let
> the client ask for the server to send resize information whenever the
> server wants, rather than having to be polled by a new client request
> all the time.  This is possible by having the server reply with a chunk
> without the NBD_REPLY_FLAG_DONE bit, for as many times as it wants,
> (that is, the server never officially ends the response to the single
> client request for on-going status, until the client sends an
> NBD_CMD_DISC).

Hrm, yeah, that could work.

Minor downside of this would be that a client would now be expected to
continue listening "forever" (probably needs to do a blocking read() or
a select() on the socket), whereas with the current situation a client
could get away with only reading for as long as it expects data.

I don't think that should be a blocker, but it might be something we
might want to document.

> I don't think the server should go into this mode without a flag bit
> from the client requesting it (as it potentially ties up a thread that
> could otherwise be used for parallel processing of other requests),

Yeah. I think we should probably initiate this with a BLOCK_STATUS
message that has a flag with which we mean "don't stop sending data on
the given region for contexts that support it".

However, I could imagine that there might be some cases wherein a server
might be able to go into such a mode for two or more metadata contexts,
and where a client might want to go into that mode for one of them but
not all of them, while still wanting some information from them.

This could be covered with metadata context syntax, but it's annoying
and shouldn't be necessary.

I'm starting to think I made a mistake when I said NBD_CMD_BLOCK_STATUS
can't take a metadata context ID. Okay, there's no space for it, but
that shouldn't have been a blocker.

Thoughts?

> and that the server could reject a repeat command with the flag if it
> is already serving a previous open-ended request.

Right.

On the other hand, I can imagine that a client might also want to tell
the server that it is no longer interested in an outstanding request. In
such a case, it should be able to cancel it.

-- 
Could you people please use IRC like normal people?!?

  -- Amaya Rodrigo Sastre, trying to quiet down the buzz in the DebConf 2008
     Hacklab
