Received: from eggs.gnu.org ([2001:4830:134:3::10]:58539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cHEcn-0006H2-6D
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 13:49:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cHEcj-0004Ex-3C
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 13:49:57 -0500
Received: from [2a01:4f8:140:52e5::2] (port=39137 helo=latin.grep.be)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wouter@grep.be>) id 1cHEci-0004Eg-Sp
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 13:49:53 -0500
Date: Wed, 14 Dec 2016 19:49:37 +0100
From: Wouter Verhelst <w@uter.be>
Message-ID: <20161214184937.uv5gwkijaofhjfd7@grep.be>
References: <20161214150840.10899-1-alex@alex.org.uk>
	<31576d46-c0ed-29b9-71a0-5aca1790799a@virtuozzo.com>
	<6D1B30FC-FD7E-474C-A8E3-FD87E7AA1364@alex.org.uk>
	<5e9150ed-2127-f2e8-f9db-a514e8f0ddf8@virtuozzo.com>
	<5E697C22-5FBB-49A2-A018-A6B96E29FE84@alex.org.uk>
	<94ef3ef2-b76f-fa5d-cbaf-8990ce2b1be8@virtuozzo.com>
	<20161214181323.mehzfmlf6z4pyajp@grep.be>
	<D71CECFD-E513-4372-BB54-BF8D8D521292@alex.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D71CECFD-E513-4372-BB54-BF8D8D521292@alex.org.uk>
Subject: Re: [Qemu-devel] [Nbd] [PATCH] Further tidy-up on block status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Bligh <alex@alex.org.uk>
Cc: "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V . Lunev" <den@openvz.org>, John Snow <jsnow@redhat.com>

On Wed, Dec 14, 2016 at 06:18:58PM +0000, Alex Bligh wrote:
> 
> > On 14 Dec 2016, at 18:13, Wouter Verhelst <w@uter.be> wrote:
> > 
> > Instead, I would suggest that the spec leave it up to the namespace spec
> > to define what gets listed when. The namespace should still give some
> > indication that a particular *type* of context is available, though;
> > e.g., _LIST_ could return 'backup:snapshot-diff{*}' as well as a list of
> > 'backup:snapshot{snapshot-X}' contexts, where the latter are all
> > available snapshots, and the 'snapshot-diff' bit implies that the whole
> > cartesian product of all possible diffs between snapshots is possible in
> > a format of 'backup:snapshot-diff{snapshot-X:snapshot-Y}', or some such
> > (you get the idea).
> > 
> > The spec currently says that a server SHOULD allow choosing exports by
> > simply naming them, but doesn't make that a MUST; and it also says that
> > the query format is defined by the namespace. If we simply clarify that
> > the output of _LIST_ doesn't necessarily need to be a full list of all
> > that's available (that it may be symbolic in the case of namespaces that
> > allow things to be dynamically defined), we should be good.
> 
> Let me have a go at a change.
> 
> However, note that Vladimir was answering a slightly different question.

Actually not :)

> I was asking about listing ALL contexts (previously an empty query
> string, now a zero length list of queries), not a 'backup:*' type
> thing.

What I was trying to say is that I think the result to _LIST_ with no
queries should return all information the client needs to theoretically
build the list of all possible contexts, even if that list may be
so large as to be unfeasible for it to be built (e.g., in case of a
cartesian product between all possible other contexts). I gave one
example, but there may be more.

My point is that if the query includes a namespace, the result should
not be defined by our spec. If the query does not include a namespace,
the result should be "complete" by whatever definition, but not
unreasonable (i.e., don't just write a cartesian product to a client).

This could allow an interactive client to present a user with a list of
possible contexts before performing analysis on the block device, say.

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12
