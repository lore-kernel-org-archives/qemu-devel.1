Received: from eggs.gnu.org ([2001:4830:134:3::10]:44748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cHFt6-0001yb-NH
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 15:10:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cHFt2-0000u6-NJ
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 15:10:52 -0500
Received: from [2a01:4f8:140:52e5::2] (port=39252 helo=latin.grep.be)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wouter@grep.be>) id 1cHFt2-0000tu-GD
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 15:10:48 -0500
Date: Wed, 14 Dec 2016 21:10:31 +0100
From: Wouter Verhelst <w@uter.be>
Message-ID: <20161214201031.gcbem4n5gyl23tro@grep.be>
References: <20161214150840.10899-1-alex@alex.org.uk>
	<31576d46-c0ed-29b9-71a0-5aca1790799a@virtuozzo.com>
	<6D1B30FC-FD7E-474C-A8E3-FD87E7AA1364@alex.org.uk>
	<5e9150ed-2127-f2e8-f9db-a514e8f0ddf8@virtuozzo.com>
	<5E697C22-5FBB-49A2-A018-A6B96E29FE84@alex.org.uk>
	<94ef3ef2-b76f-fa5d-cbaf-8990ce2b1be8@virtuozzo.com>
	<20161214181323.mehzfmlf6z4pyajp@grep.be>
	<D71CECFD-E513-4372-BB54-BF8D8D521292@alex.org.uk>
	<20161214184937.uv5gwkijaofhjfd7@grep.be>
	<95CEC42B-486F-45F2-8879-ACF48C2380FD@alex.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95CEC42B-486F-45F2-8879-ACF48C2380FD@alex.org.uk>
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
Cc: "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, "Denis V . Lunev" <den@openvz.org>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>

On Wed, Dec 14, 2016 at 07:01:15PM +0000, Alex Bligh wrote:
> Wouter,
> 
> (Our mails crossed and I've actually pushed something, but no matter)
> 
> > On 14 Dec 2016, at 18:49, Wouter Verhelst <w@uter.be> wrote:
> > 
> > What I was trying to say is that I think the result to _LIST_ with no
> > queries should return all information the client needs to theoretically
> > build the list of all possible contexts, even if that list may be
> > so large as to be unfeasible for it to be built (e.g., in case of a
> > cartesian product between all possible other contexts). I gave one
> > example, but there may be more.
> > 
> > My point is that if the query includes a namespace, the result should
> > not be defined by our spec. If the query does not include a namespace,
> > the result should be "complete" by whatever definition, but not
> > unreasonable (i.e., don't just write a cartesian product to a client).
> > 
> > This could allow an interactive client to present a user with a list of
> > possible contexts before performing analysis on the block device, say.
> 
> OK, so first of all, one of the changes I made earlier was that now
> each of the commands carries a list of queries, the way you list
> everything is not 'having a query that doesn't contain a namespace'
> but rather doing a _LIST_ with no queries at all. But that's semantics
> and orthogonal to the main point.
> 
> What I've proposed (and pushed - but feel free to alter it) is that
> 
> 1. on _LIST_, the server can return fewer contexts than are available
>    if returning all of them would consume undue levels of resources.
> 
> 2. on _LIST_ where the contexts are 'algorithmic', the server can
>    return e.g. 'X-Backup:' rather than 'X-Backup:modified>' and
>    every integer.
> 
> 3. On _SET_ if too many contexts are requested, the server may return
>    an error (I think we need this anyway).
> 
> That nearly does what you ask for, but I'm not sure how you any query
> could 'return all the information the client needs to build
> the list of all possible contexts'. For instance, in my backup
> example 'X-Backup:modified>[integer]' doesn't itself tell you
> anything, as you don't know whether the integer is a unix
> date time, in seconds after the epoch, milliseconds or whatever.
> What, surely, as a client you want to know is 'does it support
> the X-Backup: extension because I've read the spec for that and
> know that it has X-Backup:modified if so'. So I've suggested it
> return 'X-Backup:' only in that case, in which case from that
> (*and the spec*) you know how to build any query.

Actually, it does do what I ask for :-)

A client which knows about spec X, Y, or Z, should get all the
information from a _LIST_ command that it needs in order to know whether
or not it can request a particular context or not. E.g., in the case of
a "modified more recent than X seconds ago", the _LIST_ command should
expose (somehow, defined by the spec of that context) that it supports
that particular syntax, without requiring a list of all possible
integers between 0 and 2^64 (for obvious reasons).

This does require that the client know about a particular spec before it
can query it, but that's going to be the case anyway -- a client should
have no business asking for a context of which it has no implementation,
since that would mean it is asking the server to send it information
that it is then going to throw away anyway, which makes no sense.

Additionally, this also allows a client which sees that no contexts were
returned for one of the queries in its _SET_ command to differentiate
beween "server does not support metadata context XYZ" and "server does
support metadata context XYZ, but there is no relevant metadata context
for the query I sent". Allowing a server to limit the information it
sends at an arbitrary cut-off point of "20" or whatever would *not* do
that, so I'm against it in the strongest of terms.

Put otherwise: the information sent in return of a _LIST_ command with
no query string (i.e., the command that asks for "everything") should be
"complete" in the sense that it should allow a client to know whether a
server has support for metadata context X, Y, or Z, even if that means
it may have to issue further _LIST_ queries later on, or if it may have
to combine some other information first.

In the absense of dynamic namespaces, that is most easily implemented by
just listing all metadata contexts in all namespaces that we know about,
but it doesn't *have* to be that.

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12
