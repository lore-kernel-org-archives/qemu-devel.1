Received: from eggs.gnu.org ([2001:4830:134:3::10]:49354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cGXXP-0000ln-7A
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 15:49:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cGXXK-0004CT-3k
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 15:49:31 -0500
Received: from [2a01:4f8:140:52e5::2] (port=35793 helo=latin.grep.be)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wouter@grep.be>) id 1cGXXJ-0004B1-Ti
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 15:49:26 -0500
Date: Mon, 12 Dec 2016 21:49:13 +0100
From: Wouter Verhelst <w@uter.be>
Message-ID: <20161212204913.oaatvexhnndyhhwa@grep.be>
References: <20161212182119.dceppkzqb7gftsl5@grep.be>
	<bbdb71c7-540e-f5d9-c779-adddf4a0c79c@redhat.com>
	<20161212202615.llsqhojp2xztfao3@grep.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161212202615.llsqhojp2xztfao3@grep.be>
Subject: Re: [Qemu-devel] [Nbd] [PATCH v4] doc: Add NBD_CMD_BLOCK_STATUS
 extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Pavel Borzenkov <pborzenkov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Pargmann <mpa@pengutronix.de>, "Denis V. Lunev" <den@openvz.org>, John Snow <jsnow@redhat.com>

On Mon, Dec 12, 2016 at 09:26:15PM +0100, Wouter Verhelst wrote:
> > Do we still want to require servers to always send 16 extents (when not
> > limited to exactly 1), or is it better to just state that as long as the
> > server sends at least one extent (so that the client can make progress),
> > then the server can shorten the reply if it is resource-intensive to
> > provide details over the entire client request?
> 
> Hrm, I wanted to drop that (I did drop another reference to that thing,
> I though), but apparently I forgot.

...and I still did. I don't think it's worth sending another full diff
from extension-structured-reply for that, but here's the diff from v5:

diff --git a/doc/proto.md b/doc/proto.md
index 526f71a..1d6db4b 100644
--- a/doc/proto.md
+++ b/doc/proto.md
@@ -1242,9 +1242,11 @@ interpret the "length" bytes of payload.
     Even if the client did not use the `NBD_CMD_FLAG_REQ_ONE` flag in
     its request, the server MAY return less descriptors in the reply
     than would be required to fully specify the whole range of requested
-    information to the client, if the number of descriptors would be
-    over 16 otherwise and looking up the information would be too
-    resource-intensive for the server.
+    information to the client, if looking up the information would be
+    too resource-intensive for the server, so long as at least one
+    extent is returned. Servers should however be aware that most
+    clients implementations will then simply ask for the next extent
+    instead.

Regards,

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12
