Received: from eggs.gnu.org ([2001:4830:134:3::10]:39970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cSPa8-00011p-V4
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 09:45:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cSPa5-0006Ya-TX
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 09:45:25 -0500
Date: Sat, 14 Jan 2017 15:45:00 +0100
From: Wouter Verhelst <w@uter.be>
Message-ID: <20170114144500.oxoqvrn5x4sdfo74@grep.be>
References: <CAMxP3BT7ncDLePmP7QfXMtbodJ81+9Frc01aCkipya3-BNL6AA@mail.gmail.com>
	<e6e26ad1-3fdf-85ac-0dc4-f4027123af6b@redhat.com>
	<2EAE3C4F-58AF-4594-A284-A69D8BC3EA8F@alex.org.uk>
	<CAJSP0QWXF2tS5q-BpmxR9ti0osjzZCFiRxdRDho4pDBLkD3UUQ@mail.gmail.com>
	<CAMxP3BQeUWwFLmb42=-XExRzdLe0egCaEUEF4kXLQ9khH9neWg@mail.gmail.com>
	<90b32a89-6dd8-1f83-4f6f-01bb5479252e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90b32a89-6dd8-1f83-4f6f-01bb5479252e@redhat.com>
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
Cc: Bob Chen <a175818323@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>

Hi Eric,

(side note: my mutt tells me that the signature on your message does not
validate. Not sure what's going on, but something you might want to look
into...)

On Thu, Jan 12, 2017 at 12:45:56PM -0600, Eric Blake wrote:
> For resize smaller, things are a lot trickier - how do you block access
> to a portion of a file that the client still thinks exist, but which the
> server has truncated away?  Maybe the easy way out is to state that the
> server MUST NOT resize smaller.

I would prefer something along the lines of "the server MUST NOT
activate the 'resize smaller' command (which it received out of band
from whereever) until the client asked for and was told the new size of
the device."

That is (with A & X being offsets, and B & Y being sizes, A+B < X):

client        			server			server mgmt
READ A,B        		no error
        						resize to X
READ X,Y        		no error
reread sizes
READ X,Y        		ENOSPC
READ A,B        		no error

In that scenario, it should be the responsibility of the server to
ensure there are no more readers; servers could implement that (if they
don't want to do the required bookkeeping and keep such requests as
pending) by simply sending ESHUTDOWN or some such.

> > What about an active `resize` request from the client? Considering some NBD
> > servers might have the capability to do instant resizing, not applying to
> > LVM or host block device, of course...
> 
> And perhaps the 're-read size' command can serve a dual purpose.  Since
> all NBD commands already include space for size and offset parameters,
> we could define that if the client passes 0/0 for size and offset, it
> wants to read the server's current size; if it passes 0/non-zero, it is
> asking the server to resize to the new non-zero size (and the server's
> success or error response tells whether the resize happened).

I agree with Alex that adding an active resize command to the NBD
protocol feels like a layering violation. We should probably not do
that.

> Should I spend time turning this idea into a more formal spec, along the
> lines of other NBD extension proposals?

Feel free.

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12
