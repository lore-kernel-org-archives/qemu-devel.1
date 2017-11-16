Received: from eggs.gnu.org ([2001:4830:134:3::10]:32780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1eFGpZ-00024Q-BS
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 04:51:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1eFGpW-0006wn-5t
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 04:51:33 -0500
Date: Thu, 16 Nov 2017 10:51:16 +0100
From: Wouter Verhelst <w@uter.be>
Message-ID: <20171116095116.4weodui6w27clyre@grep.be>
References: <90b32a89-6dd8-1f83-4f6f-01bb5479252e@redhat.com>
	<20170114144500.oxoqvrn5x4sdfo74@grep.be>
	<1ef924f8-1e58-fe54-dabc-06873a531412@redhat.com>
	<20170118080126.nyldkjhxdsxd4u2b@grep.be>
	<CAMxP3BTjBSQEhycavgyfWXEA6pTg=sxfHe5sf+nxVY9ejXWMXQ@mail.gmail.com>
	<20170122114339.l3ijhy3uymsru4ed@grep.be>
	<4a5a82d6-7d66-cfb4-bd42-cea596115f6f@redhat.com>
	<09ef1805-8361-5dff-300e-deede4863e55@redhat.com>
	<20171114173745.egvtklxyrcprlcdn@grep.be>
	<cd864bff-b429-20aa-7fc9-2f9296581470@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd864bff-b429-20aa-7fc9-2f9296581470@redhat.com>
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

On Tue, Nov 14, 2017 at 01:06:17PM -0600, Eric Blake wrote:
> On 11/14/2017 11:37 AM, Wouter Verhelst wrote:
> > On Tue, Nov 14, 2017 at 10:41:39AM -0600, Eric Blake wrote:
> >> Another thought - with structured replies, we finally have a way to let
> >> the client ask for the server to send resize information whenever the
> >> server wants, rather than having to be polled by a new client request
> >> all the time.  This is possible by having the server reply with a chunk
> >> without the NBD_REPLY_FLAG_DONE bit, for as many times as it wants,
> >> (that is, the server never officially ends the response to the single
> >> client request for on-going status, until the client sends an
> >> NBD_CMD_DISC).
> > 
> > Hrm, yeah, that could work.
> > 
> > Minor downside of this would be that a client would now be expected to
> > continue listening "forever" (probably needs to do a blocking read() or
> > a select() on the socket), whereas with the current situation a client
> > could get away with only reading for as long as it expects data.
> > 
> > I don't think that should be a blocker, but it might be something we
> > might want to document.
> > 
> >> I don't think the server should go into this mode without a flag bit
> >> from the client requesting it (as it potentially ties up a thread that
> >> could otherwise be used for parallel processing of other requests),
> > 
> > Yeah. I think we should probably initiate this with a BLOCK_STATUS
> > message that has a flag with which we mean "don't stop sending data on
> > the given region for contexts that support it".
> 
> Now we're mixing NBD_CMD_BLOCK_STATUS and NBD_CMD_RESIZE;

Eh, right -- I had forgotten about RESIZE, actually :-)

> I was thinking of the open-ended command for being informed of all
> server-side-initiated size changes in response to RESIZE; but your mention of
> an open-ended BLOCK_STATUS has an interesting connotation of being able to
> get live updates as sections of a file are dirtied.

For instance, or whatever other metadata we end up sending through
BLOCK_STATUS.

> I also remember from talking with Vladimir during KVM Forum last month
> that one of the shortfalls of the NBD protocol is that you can only ever
> send a length of up to 32 bits on the command side (unless we introduce
> structured commands in addition to our current work to add structured
> replies);

Yes, and I'm thinking we should do so. This will obviously require more
negotiation.

Can be done fairly easily though:
- Client negotiates structured replies (don't think it makes sense to do
  structured requests without structured replies)
- Server sets an extra transmission flag to say "I am capable of
  receiving extended requests"
- Extended requests have a different magic number, and should have a
  "request length" field as well. I'm thinking we make it:

magic          (32b)
request length (16b)
type           (16b)
flags          (64b)
handle         (64b)
from           (64b)
data length    (64b)
(extra data)

Request length in this proposal should always be at least 320.

I made flags 64 bits rather than 16 as per the current format, because
that way everything is aligned on a 4-byte boundary, which makes things
a bit easier on some architectures (e.g., I know that sparc doesn't like
unaligned 64-bit access). 64 bits for flags looks like a bit of a waste,
but then if we're going to waste some bits somewhere, I guess it's best
to assign them to flags.

The idea is that "request length" is the length of the data that the
client is sending, and "data length" is the length of the range that
we're trying to deal with.

A write request would thus have to have request length be (data length +
320); a read request would have request length be 320, and expect data
to be returned of data length bytes.

A metadata request could then tack on extra data, where request length
of 320 implies "all negotiated metadata contexts", but anything more
than that would imply there are some metadata IDs passed along.

etc.

Thoughts?

[...]
> > However, I could imagine that there might be some cases wherein a server
> > might be able to go into such a mode for two or more metadata contexts,
> > and where a client might want to go into that mode for one of them but
> > not all of them, while still wanting some information from them.
> > 
> > This could be covered with metadata context syntax, but it's annoying
> > and shouldn't be necessary.
> > 
> > I'm starting to think I made a mistake when I said NBD_CMD_BLOCK_STATUS
> > can't take a metadata context ID. Okay, there's no space for it, but
> > that shouldn't have been a blocker.
> > 
> > Thoughts?
> 
> Nothing says the server has to reply the same length of information when
> replying for multiple selected metadata contexts; but if we allow
> different reply sizes all in one query, we may also need some way to
> easily tell that the server has stopped sending metadata for one context
> even though it is still providing additional replies for another context.

There is that too, yes.

> And maybe we do want to someday start thinking about structured
> requests; where being able to do per-command selection of metadata
> contexts (instead of per-export selection) may indeed be the first use case.

See above ;-)

> >> and that the server could reject a repeat command with the flag if it
> >> is already serving a previous open-ended request.
> > 
> > Right.
> > 
> > On the other hand, I can imagine that a client might also want to tell
> > the server that it is no longer interested in an outstanding request. In
> > such a case, it should be able to cancel it.
> 
> Good point - if we allow the client to request an open-ended reply, it's
> also nice to let the client decide how long that open-endedness should last.

Exactly.

-- 
Could you people please use IRC like normal people?!?

  -- Amaya Rodrigo Sastre, trying to quiet down the buzz in the DebConf 2008
     Hacklab
