Received: from eggs.gnu.org ([2001:4830:134:3::10]:36232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cWJFY-0002dQ-SJ
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 03:48:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cWJFU-0001H8-Us
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 03:48:16 -0500
Date: Wed, 25 Jan 2017 09:47:52 +0100
From: Wouter Verhelst <w@uter.be>
Message-ID: <20170125084752.4v2eb5qahk7oij6j@grep.be>
References: <2EAE3C4F-58AF-4594-A284-A69D8BC3EA8F@alex.org.uk>
	<CAJSP0QWXF2tS5q-BpmxR9ti0osjzZCFiRxdRDho4pDBLkD3UUQ@mail.gmail.com>
	<CAMxP3BQeUWwFLmb42=-XExRzdLe0egCaEUEF4kXLQ9khH9neWg@mail.gmail.com>
	<90b32a89-6dd8-1f83-4f6f-01bb5479252e@redhat.com>
	<20170114144500.oxoqvrn5x4sdfo74@grep.be>
	<1ef924f8-1e58-fe54-dabc-06873a531412@redhat.com>
	<20170118080126.nyldkjhxdsxd4u2b@grep.be>
	<CAMxP3BTjBSQEhycavgyfWXEA6pTg=sxfHe5sf+nxVY9ejXWMXQ@mail.gmail.com>
	<20170122114339.l3ijhy3uymsru4ed@grep.be>
	<4a5a82d6-7d66-cfb4-bd42-cea596115f6f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a5a82d6-7d66-cfb4-bd42-cea596115f6f@redhat.com>
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
Cc: Bob Chen <a175818323@gmail.com>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Stefan Hajnoczi <stefanha@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>

Hi Eric,

On Mon, Jan 23, 2017 at 08:54:48AM -0600, Eric Blake wrote:
> On 01/22/2017 05:43 AM, Wouter Verhelst wrote:
> > 
> > Having given this some more thought, I'm not entirely sure anymore that
> > an active resize from the NBD layer is necessarily a layering violation.
> > There might be other cases where this is useful, and e.g., the Linux
> > kernel also supports active resizes of block devices in some cases
> > (e.g., LVM). We'll also need to define what happens in case the resize
> > operation isn't possible for some reason (e.g., the size increase asks
> > for more space than the server's storage has available).
> > 
> > I suggest the following semantics:
> > 
> > - Add a transmission flag to indicate resize is possible for
> >   transmission phase (NBD_FLAG_SEND_RESIZE, flag 10). I don't see any
> >   need for an NBD_OPT_RESIZE or some such; just the flag should suffice.
> 
> Except that in previous threads, you've argued that burning per-export
> flags is rather expensive if it is instead soemthing that an NBD_OPT
> exchange could enable.

True, but I also said that flags make it easy to teach the kernel about
something, without requiring extra API calls.

Since this is just a thing of "it can be sent, doesn't need more
metadata than that", a flag seems appropriate.

> On the other hand, I could definitely see it being a per-export
> setting (not all exports have the ability to be resized), so it
> doesn't hurt my feelings to burn a per-export flag on this bit of
> information.

There's that too, yes.

> > - NBD_CMD_RESIZE (command 7): resize the export. The "offset" field
> >   contains the new size, "length" is reserved (why not the other way
> >   around? offset is 64 bits, length is 32)
> > - resize command can fail with:
> >   EPERM: server configuration does not allow this resize, or
> >   (optionally) other clients are using the same export and the request
> >   was for a smaller size.
> >   EIO: I/O error while trying to resize the device
> >   ENOSPC: new export size requires more space than is available
> >   ESHUTDOWN: server is shutting down
> > 
> > I've added an "extension-resize" branch with the above. If that works
> > for you, then run with it. If not, just implement what you want and send
> > updates as you go along.
> 
> You have at least one problem in there:
> 
> +    If the resize was successful, clients MAY now issue other requests
> +    up to the new size as requested in the request header. If the new
> +    size is larger than it was before the request, requests beyond the
> +    new size but not beyond the old one MUST fail with ENOSPC.
> 
> You probably want "if the new size is _smaller_ than it was before", as
> it is not possible to have requests beyond the new size but not beyond
> the old if the new size is larger than the old.

Ah, yes, thanks.

I notice that that paragraph is also redundant with the next one. I'll
fix that up tonight.

> I'm still thinking that allowing the client to query the current size is
> useful.  Over the weekend, I was thinking of SEEK_SET/SEEK_END semantics
> (SEEK_CUR doesn't really make sense, since we don't maintain a current
> offset), and wondering if we could improve the command as follows:
> 
> If invoked without flags, it operates with SEEK_SET semantics (the
> offset is the new requested size); if invoked with
> NBD_CMD_FLAG_RELATIVE, it operates with SEEK_END semantics (the offset
> is added to the existing size, and can be treated as a signed 64-bit
> negative number to shrink).  Either way, on success, the command replies
> with a structured reply containing the new 64-bit total size of the
> disk.  This would require the reply to be a structured reply, and the
> semantics of NBD_CMD_FLAG_RELATIVE with an offset of 0 becomes a way to
> probe the existing disk size (thus enabling the server to resize without
> client request, and perhaps used with some out-of-band means for the
> client to know that it should query the server for an updated size).

That seems elegant, yes.

> Also note that the server's reply of the current size may be slightly
> different than what was requested by the client (that is, we should
> allow the server to round the client's request up to an appropriate
> granularity) - we should probably require that the server can only round
> up (not down).

Probably works too, indeed.

> Thoughts?

I think there's merit in what you're suggesting. If you want to suggest
wording too, I'm all ears :-)

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12
