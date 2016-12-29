Received: from eggs.gnu.org ([2001:4830:134:3::10]:51624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cMdLT-0000Y4-G4
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 11:14:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cMdLP-0004OA-2R
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 11:14:23 -0500
Received: from mail.avalus.com ([89.16.176.221]:41566)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cMdLO-0004O3-SE
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 11:14:18 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <71d6f278-be19-eaeb-7277-c3e6e4512e67@virtuozzo.com>
Date: Thu, 29 Dec 2016 16:14:17 +0000
Content-Transfer-Encoding: quoted-printable
Message-Id: <F9BB6FF1-4F72-4E98-B62F-24EEE5960445@alex.org.uk>
References: <20161214150840.10899-1-alex@alex.org.uk>
	<71d6f278-be19-eaeb-7277-c3e6e4512e67@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH] Further tidy-up on block status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Alex Bligh <alex@alex.org.uk>, Wouter Verhelst <w@uter.be>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Pavel Borzenkov <pborzenkov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Pargmann <mpa@pengutronix.de>, "Denis V . Lunev" <den@openvz.org>


> On 27 Dec 2016, at 14:09, Vladimir Sementsov-Ogievskiy =
<vsementsov@virtuozzo.com> wrote:
>=20
> What was the reason for it? Why not to negotiate forced structured =
read separately? Actually, this spec forces any server, which wants to =
implement structured reply implement structured read too. But what if it =
don't want to? If it only wants to implement BLOCK_STATUS?
>=20
> So, what about changing it, to allow BLOCK_STATUS (or other future =
structured replies) without structured read? Structured read is good =
only for sparse formats, when BLOCK_STATUS is more global. I understand, =
that servers may implement simple (and useless) one-chunk structured =
read, but I think that it is better to fix the spec, to not provoke =
servers use such workaround.

In essence the current reply format is broken, because it does not =
provide a means of delivering an error mid reply AND expects fixed =
length replies. Block Status is the poster child for something that =
benefits from structured replies.

So, BLOCK_STATUS requires structured replies. We thus have the choice =
between:
* Allowing structured replies to be implemented on a per-command basis
* Mandating that if structured replies are implemented, they are =
implemented universally

The second option is far simpler, and is what the current structured =
reply extension sets out. It's also a good nudge to server implementers =
(me included) to implement structured replies.

Your assumption that structured replies are only good for sparse formats =
is incorrect. It's good for anything that wants to include sensible =
error handling. As a server author, error handling at the moment is a =
pain. Most of us ALREADY break up large read requests (to avoid malloc() =
of huge amounts of memory), so we already have a read loop. If we don't =
then the 'one chunk' method is perfectly acceptable. If I implemented =
structured replies at all, I'd be sharing the code between multiple =
users in any case.

--=20
Alex Bligh
