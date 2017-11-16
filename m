Received: from eggs.gnu.org ([2001:4830:134:3::10]:55077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1eFMup-0007YA-5S
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:21:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1eFMul-00058G-VE
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:21:23 -0500
Date: Thu, 16 Nov 2017 17:20:29 +0100
From: Wouter Verhelst <w@uter.be>
Message-ID: <20171116162029.jslqnlx3jsaz6wpy@grep.be>
References: <1ef924f8-1e58-fe54-dabc-06873a531412@redhat.com>
	<20170118080126.nyldkjhxdsxd4u2b@grep.be>
	<CAMxP3BTjBSQEhycavgyfWXEA6pTg=sxfHe5sf+nxVY9ejXWMXQ@mail.gmail.com>
	<20170122114339.l3ijhy3uymsru4ed@grep.be>
	<4a5a82d6-7d66-cfb4-bd42-cea596115f6f@redhat.com>
	<09ef1805-8361-5dff-300e-deede4863e55@redhat.com>
	<20171114173745.egvtklxyrcprlcdn@grep.be>
	<cd864bff-b429-20aa-7fc9-2f9296581470@redhat.com>
	<20171116095116.4weodui6w27clyre@grep.be>
	<11977343-24b6-9b1d-59e0-275de8b988cb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11977343-24b6-9b1d-59e0-275de8b988cb@redhat.com>
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

On Thu, Nov 16, 2017 at 09:30:41AM -0600, Eric Blake wrote:
> On 11/16/2017 03:51 AM, Wouter Verhelst wrote:
> 
> >> I also remember from talking with Vladimir during KVM Forum last month
> >> that one of the shortfalls of the NBD protocol is that you can only ever
> >> send a length of up to 32 bits on the command side (unless we introduce
> >> structured commands in addition to our current work to add structured
> >> replies);
> > 
> > Yes, and I'm thinking we should do so. This will obviously require more
> > negotiation.
> > 
> > Can be done fairly easily though:
> > - Client negotiates structured replies (don't think it makes sense to do
> >   structured requests without structured replies)
> > - Server sets an extra transmission flag to say "I am capable of
> >   receiving extended requests"
> > - Extended requests have a different magic number, and should have a
> >   "request length" field as well. I'm thinking we make it:
> > 
> > magic          (32b)
> > request length (16b)
> > type           (16b)
> > flags          (64b)
> > handle         (64b)
> > from           (64b)
> > data length    (64b)
> > (extra data)
> > 
> > Request length in this proposal should always be at least 320.
> 
> 320 bits, but we pass length in bytes, so 40.

Umm. Yes. I didn't sleep very well last night, sorry.

> > I made flags 64 bits rather than 16 as per the current format, because
> > that way everything is aligned on a 4-byte boundary, which makes things
> > a bit easier on some architectures (e.g., I know that sparc doesn't like
> > unaligned 64-bit access). 64 bits for flags looks like a bit of a waste,
> > but then if we're going to waste some bits somewhere, I guess it's best
> > to assign them to flags.
> > 
> > The idea is that "request length" is the length of the data that the
> > client is sending, and "data length" is the length of the range that
> > we're trying to deal with.
> 
> Yep, sounds reasonable.
> 
> > A write request would thus have to have request length be (data length +
> > 320); a read request would have request length be 320, and expect data
> > to be returned of data length bytes.
> 
> Umm, if data length is 64 bits, but request length is 16 bits, we can't
> properly support write requests with that much payload.

mumble mumble. Yes, of course. See above ;-)

> I think it goes
> back to the idea of block sizes: the maximum request that a server is
> willing to accept (advertised via INFO during NBD_OPT_GO) still applies,
> so you can't NBD_CMD_WRITE with more than that maximum size (and
> therefore your maximum request size can't be more than that size plus
> the overhead of the 40 byte header), but OTHER commands that CAN operate
> on larger chunks of the export (WRITE_ZEROES, BLOCK_STATUS, maybe a new
> extension LOCK for allowing fcntl()-like locking semantics) can now be
> accommodated, because they don't have to send large amounts of payload
> along with the request.
> 
> Keeping request length at 16 bits may therefore be too small (if we want
> to allow 32M write payloads), and may require us laying out the
> structured write header slightly differently (maybe fewer flag bits
> after all).

Right, so let's make it:

magic          (32b)
flags          (16b)
type           (16b)
handle         (64b)
from           (64b)
data length    (64b)
request length (64b)
(extra data)

That actually copies the same structure as the current request header, but:
- data length is extended from 32 bits to 64 bits, so that long requests can be
  made where they make sense. We should make it clear though that block
  size limitations still apply, and that a request to read 2^63 bytes of
  data is likely to be refused by a server.
- request lenght is added, also as a 64-bit value. I could be persuaded
  to make that a 32-bit value rather than a 64-bit one, though.

This way, common code can be used to handle all data up to and including
the "from" field; what's beyond that would need to be decided based upon
the value of the magic field (32-byte data length in case of old
requests, 2 64-byte length values in the other case).

Maybe, by the time we get here, it makes sense to also have "request
length" be 0 for a command that doesn't have any extra data beyond that
header. That would also make one particular case easier to read:

if(req.type == NBD_CMD_WRITE && req.data_length != req.request_length)
        return EINVAL;

However, the downside of that is that we include header length in all
other cases (negotiation, structured replies), and this one would then
be the odd one out; I could imagine that might cause too much confusion.
Not sure whether the minor advantage above is worth that.

> Or we can say that NBD_CMD_WRITE still has to use old-style requests.

Let's not :-)

> > A metadata request could then tack on extra data, where request length
> > of 320 implies "all negotiated metadata contexts", but anything more
> > than that would imply there are some metadata IDs passed along.
> 
> Again, 40 bytes (not 320 bits), but yeah, that would be the idea.

Right.

-- 
Could you people please use IRC like normal people?!?

  -- Amaya Rodrigo Sastre, trying to quiet down the buzz in the DebConf 2008
     Hacklab
