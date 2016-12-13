Received: from eggs.gnu.org ([2001:4830:134:3::10]:55365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cGpb9-0008UN-Fl
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 11:06:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cGpb5-0005h6-6L
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 11:06:35 -0500
Received: from [2a01:4f8:140:52e5::2] (port=37172 helo=latin.grep.be)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wouter@grep.be>) id 1cGpb4-0005gr-Va
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 11:06:31 -0500
Date: Tue, 13 Dec 2016 17:06:10 +0100
From: Wouter Verhelst <w@uter.be>
Message-ID: <20161213160610.6xlwhvwq7xhee2wg@grep.be>
References: <20161212204313.anhjire2gkwd6gzi@grep.be>
	<2D482F67-8115-48CD-921D-5728BC1AD92B@alex.org.uk>
	<20161213150343.3g3fxjixbteum7ju@grep.be>
	<B6B52260-6814-40CB-AA00-E79099B8ED56@alex.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B6B52260-6814-40CB-AA00-E79099B8ED56@alex.org.uk>
Subject: Re: [Qemu-devel] [Nbd] [PATCH v5] doc: Add NBD_CMD_BLOCK_STATUS
 extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Bligh <alex@alex.org.uk>
Cc: "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>

On Tue, Dec 13, 2016 at 03:24:25PM +0000, Alex Bligh wrote:
> Wouter,
> > The spec should only specify how to select a particular namespace, and
> > then leave all parsing rules of query strings up to the namespace
> > specification.
> 
> I'm not quite sure why you want that,

Let's say you want to implement incremental backups (which is what we're
talking about, really). Your backup program would presumably know when
the last point in time is that we took a backup. In that context, you
could want to have a syntax to say "list all contexts that contain data
more recent than <previous backup point>" (or "select all contexts..."),
so as to actually select the backup.

> but if that's the case, I'd
> suggest the easiest thing to do would be to pass (separately) a
> namespace string, and a name-query, because you are prohibiting
> queries that cover more than one namespace

I think that would needlessly complicate matters, because there is
also...

> (though per our
> separate conversation, you can select context from more than
> one namespace with multiple queries)

... this.

>. It does seem a bit odd thought that if context 'foo:bar' is returned
>from _LIST_, there is no guarantee that selecting it as 'foo:bar' will
>work (as the matching is namespace dependent).

Yes. We should probably also make it clear that implementations SHOULD
allow the selection of a (subset of) metadata context(s) which are
returned by LIST by simply naming them individually.

[...]
> > Perhaps another way to deal with that would be to specify that an
> > implementation is not required to assign the same context IDs to the
> > same metadata contexts from one call to SET (or LIST) to the next; but I
> > thought it would be clearer if we were to explicitly make LIST return
> > "invalid" context IDs. Then again, maybe not.
> 
> You're completely correct here and you should ignore my suggestion.
> 
> Perhaps you should be even clearer and explicitly state that
> context IDs may change between sessions and even between successive
> use of the _SET_ command.

Makes sense, yes.

[...]
> >> * If a server has `base:allocation` AND another metadata context
> >>  (for instance `qemu:dirty`) then the rule you set out will not
> >>  apply.
> > 
> > Yes, and this is intentional, as I've explained before. The other
> > context's semantics should clarify whether that rule still applies or
> > not. Implementations that do not know of the other context should
> > however assume that it doesn't.
> 
> I think I must be being very stupid or am at least at cross-purposes.
> 
> Let's say the second context is (e.g.) 'colour:records_information_about_blue'
> (i.e. nothing at all to do with space or holes). Are you saying that the
> presence of that context might affect the interpretation of
> NBD_STATE_HOLE? Or just other contexts within the 'base:' space?
> Or that another context (e.g. perhaps compression) could be an independent
> cause of ENOSPC? If so should it be the responsibility of the other context
> to document that it does not affect that?
> 
> How about:
> 
> "If a server supports the `base:allocation` metadata context, then writing
> to an extent which has `NBD_STATE_HOLE` clear MUST NOT fail with ENOSPC
> unless for reasons specified in the definition of another context."

That is essentially what I mean, yes. The point though, is that I also
think a client should assume the worst.

(additionally, there may be reasons for ENOSPC that the server isn't
aware of; so even if NBD_STATE_HOLE is clear, it should still not be an
error for the server to return ENOSPC)

> >>> +For the `base:allocation` context, the remainder of the flags field is
> >>> +reserved. Servers SHOULD set it to all-zero;
> >> 
> >> Surely if we want to reserve them for extension, we need "Servers
> >> MUST set it to all-zero"
> > 
> > No, SHOULD, otherwise a future extension which adds meaning to those
> > bits will suddenly become incompatible with this spec. Think about it
> > ;-)
> 
> I did! If there is a future extension, it will change the spec to
> incorporate those bits, so they won't be included within 'the
> remainder' any more.

If we say MUST, a client would be within its rights to reject a future
version of the "base:allocation" data with more flags set as invalid,
and would therefore not be future-compliant. This is why it should be
SHOULD, not MUST.

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12
