Received: from eggs.gnu.org ([2001:4830:134:3::10]:38547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1eBR3b-0007Wv-5k
	for Qemu-devel@nongnu.org; Sun, 05 Nov 2017 14:58:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1eBR3X-00005v-9s
	for Qemu-devel@nongnu.org; Sun, 05 Nov 2017 14:58:11 -0500
Received: from latin.grep.be ([46.4.76.168]:53137)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wouter@grep.be>) id 1eBR3W-0008U1-VU
	for Qemu-devel@nongnu.org; Sun, 05 Nov 2017 14:58:07 -0500
Date: Sun, 5 Nov 2017 20:57:53 +0100
From: Wouter Verhelst <w@uter.be>
Message-ID: <20171105195753.4td423texl32uo4z@grep.be>
References: <d0e4e71e-981e-eec1-c996-74655079a860@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0e4e71e-981e-eec1-c996-74655079a860@redhat.com>
Subject: Re: [Qemu-devel] structured reply behavior for read of 0 bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, nbd list <nbd@other.debian.org>

Hi Eric,

On Fri, Nov 03, 2017 at 05:45:07PM -0500, Eric Blake wrote:
> As currently written, structured reply is documented as:
> 
> > NBD_REPLY_TYPE_OFFSET_DATA (1)
> > 
> > This chunk type is in the content chunk category. length MUST be at least
> > 9. It represents the contents of length - 8 bytes of the file, starting at
> > the absolute offset from the start of the export.
> 
> which implies that the data size must be non-zero. But clients can request a
> read of size 0 (the spec doesn't forbid it, but neither does it define
> special semantics for it), and the existing qemu implementation as of qemu
> commit f140e300 sends NBD_REPLY_TYPE_OFFSET_DATA with length of 8 and no data
> payload if the client requests a 0-byte read.  Should we specifically allow
> this particular answer, or should a 0-length read be answered solely by
> NBD_REPLY_TYPE_NONE, meaning that qemu's current behavior needs a tweak?
> Either way, I probably need another tweak to the NBD spec for structured
> reads.

I'd like to take a step back first and wonder what a zero-sized read
would actually mean. "Please read no data at this offset". What good
does that do? I can't see anything useful coming out of that.

If we can come up with some useful semantics that we could apply to a
zero-sized read, then I guess it makes sense to worry about handling it.
In the absense of that though, I think it is more appropriate to just
document that a client should not send it, but that a server's behaviour
upon such a command is not defined (other than that it should not cause
the server to quit, through a crash or otherwise).

In fact, the current spec, as you point out, already implicitly forbids
(with MUST) nonzero writes by requiring a data chunk to have nonzero
payload (and that can't happen when you have a zero-sized read). It
might make sense to make that explicit.

-- 
Could you people please use IRC like normal people?!?

  -- Amaya Rodrigo Sastre, trying to quiet down the buzz in the DebConf 2008
     Hacklab
