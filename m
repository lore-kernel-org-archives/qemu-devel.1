Received: from eggs.gnu.org ([2001:4830:134:3::10]:50856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cHE3n-0004cr-OK
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 13:13:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cHE3k-0002zK-Im
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 13:13:47 -0500
Received: from [2a01:4f8:140:52e5::2] (port=39090 helo=latin.grep.be)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wouter@grep.be>) id 1cHE3k-0002xy-Ck
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 13:13:44 -0500
Date: Wed, 14 Dec 2016 19:13:23 +0100
From: Wouter Verhelst <w@uter.be>
Message-ID: <20161214181323.mehzfmlf6z4pyajp@grep.be>
References: <20161214150840.10899-1-alex@alex.org.uk>
	<31576d46-c0ed-29b9-71a0-5aca1790799a@virtuozzo.com>
	<6D1B30FC-FD7E-474C-A8E3-FD87E7AA1364@alex.org.uk>
	<5e9150ed-2127-f2e8-f9db-a514e8f0ddf8@virtuozzo.com>
	<5E697C22-5FBB-49A2-A018-A6B96E29FE84@alex.org.uk>
	<94ef3ef2-b76f-fa5d-cbaf-8990ce2b1be8@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94ef3ef2-b76f-fa5d-cbaf-8990ce2b1be8@virtuozzo.com>
Subject: Re: [Qemu-devel] [Nbd] [PATCH] Further tidy-up on block status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Alex Bligh <alex@alex.org.uk>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>

On Wed, Dec 14, 2016 at 08:55:56PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> 14.12.2016 20:36, Alex Bligh wrote:
> >> On 14 Dec 2016, at 17:05, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
> >>> However, this raises another question. Wouter deliberately made the
> >>> query format freeform so that you could e.g. set a context like:
> >>>
> >>>     backup:modtime>201612081034
> >>>
> >>> which might (in theory) return a list of blocks which are newer than
> >>> the given timestamp. It would clearly be impossible to return all such
> >>> contexts. I wonder if we should carve out an exception here.
> >>>
> >>>
> >> Interesting. Even query 'backup:modtime>*' would be a problem, not only empty query list.
> >>
> >> Actually, we do not need to 'list contexts', as it is about management, not about data transfer. We only need a way to check, that particular query selects all needed contexts and no others. Just to be sure that we are know, what we will select by NBD_OPT_SET_META_CONTEXT with _same_ query.
> >>
> >> So, I suggest just to say, that _LIST_ can return error if too much contexts are selected. And same should be done for _SET_. And it should be documented that this result of query (list or error) should be equal for these two commands.
> > (two CCs that always bounce removed)
> >
> > Hmmm... Well in the '*' case, it's up to the namespace as to how it parses things, so '*' could be prohibited entirely or mean 'return the first 20 matching' or similar. So that's less of a problem. And 'set all' doesn't exist (unlike 'list all').
> >
> > I think in the LIST case we should allow the server to omit contexts under certain circumstances, and allow SET to return ETOOBIG.
> >
> 
> We can't prohibit '*' as query string as implementation defined. And we 
> shouldn't (I think) define its meaning. Opposite, we can define, that 
> query must not select more than 20 contexts, but I'm not sure that this 
> is good.

No, I don't think so, either.

I can see how "list all contexts" might be difficult to implement, in
the example of the dynamic contexts that I pointed out earlier. We could
muddle the spec further to fix that (hypothetical) problem, but I'm not
sure that's worth it.

Instead, I would suggest that the spec leave it up to the namespace spec
to define what gets listed when. The namespace should still give some
indication that a particular *type* of context is available, though;
e.g., _LIST_ could return 'backup:snapshot-diff{*}' as well as a list of
'backup:snapshot{snapshot-X}' contexts, where the latter are all
available snapshots, and the 'snapshot-diff' bit implies that the whole
cartesian product of all possible diffs between snapshots is possible in
a format of 'backup:snapshot-diff{snapshot-X:snapshot-Y}', or some such
(you get the idea).

The spec currently says that a server SHOULD allow choosing exports by
simply naming them, but doesn't make that a MUST; and it also says that
the query format is defined by the namespace. If we simply clarify that
the output of _LIST_ doesn't necessarily need to be a full list of all
that's available (that it may be symbolic in the case of namespaces that
allow things to be dynamically defined), we should be good.

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12
