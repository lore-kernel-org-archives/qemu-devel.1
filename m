Received: from eggs.gnu.org ([2001:4830:134:3::10]:37652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cUukO-0005tO-Vq
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 07:26:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cUukJ-00084F-Ax
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 07:26:20 -0500
Received: from [2a01:4f8:140:52e5::2] (port=46501 helo=latin.grep.be)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wouter@grep.be>) id 1cUukJ-000807-4u
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 07:26:15 -0500
Date: Sat, 21 Jan 2017 13:25:50 +0100
From: Wouter Verhelst <w@uter.be>
Message-ID: <20170121122550.qzm4u7lnzj3nxsmf@grep.be>
References: <20161214150840.10899-1-alex@alex.org.uk>
	<442dcfe4-8704-2898-655e-da383a0caf76@virtuozzo.com>
	<220990D0-ACB6-4F25-BADF-63898FE71BED@alex.org.uk>
	<0654e27f-9c2f-993c-befd-1f1e8e75aabf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0654e27f-9c2f-993c-befd-1f1e8e75aabf@redhat.com>
Subject: Re: [Qemu-devel] [Nbd]  [PATCH] Further tidy-up on block status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Alex Bligh <alex@alex.org.uk>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Pavel Borzenkov <pborzenkov@virtuozzo.com>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Pargmann <mpa@pengutronix.de>, "Denis V . Lunev" <den@openvz.org>, John Snow <jsnow@redhat.com>

On Fri, Jan 20, 2017 at 01:35:10PM -0600, Eric Blake wrote:
> On 01/20/2017 12:00 PM, Alex Bligh wrote:
> > 
> >> On 20 Jan 2017, at 17:04, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
> >>
> >> About extents: is 32bit length enough? We will have to send 4096 for empty 16tb disk..
> > 
> > The nbd protocol uniformly uses 32 bit lengths (for better or for worse). This is baked into the specification heavily.
> > 
> > I'm not sure sending 4,096 items for an empty 16TB disk is any great hardship to be honest.
> 
> If it truly matters, an idea that has already been floated on the list
> is to add a new NBD_CMD_FLAG_SCALE (or some other spelling) that states
> that a particular command is sending lengths scaled by a particular
> factor (by the block size? obviously it would have to be better
> specified).  Under this idea, the scaling factor would allow you to
> report larger extents for fewer back-and-forth operations, but it gets
> tricky if the scaling is allowed to get larger than the minimum
> granularity between extent changes.

Right, but people objected to it on grounds of it being too complicated
(which I think was a fair point).

> The other idea that has been floated is a way to report whether the
> entire export is known to be all-zero content at the time the client
> connects, which would trade 4096+ queries (you'd actually have to do
> more than 4096 queries, since length is < 4G, not <= 4G) with a single
> piece of information at the time the client connects.

That's pretty special-case, and I objected to it on those grounds :-)

However, I don't think there's anything necessarily wrong in changing
the size of the length field in the reply header of the
NBD_REPLY_TYPE_BLOCK_STATUS packet. That way, combined with the fact
that we'd already stated that a server may send more information than
was requested, a client could ask for metadata on an export, and if the
extent is the whole size of the export, the server could say so in a
single reply for all export sizes.

I suppose it'd be slightly odd to have the request use 32-bit lengths
and the response be expressed in 64-bit ones, but I suppose that's the
price we pay to remain a backwards compatible and not too complicated a
protocol.

> Either way, discussion on such enhancements are probably worth a new
> thread.

Sure.

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12
