Received: from eggs.gnu.org ([2001:4830:134:3::10]:32853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cHEnm-000655-0R
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 14:01:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cHEnl-0007cg-5h
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 14:01:18 -0500
Received: from mail.avalus.com ([2001:41c8:10:1dd::10]:52886)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cHEnk-0007cQ-Sp
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 14:01:17 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <20161214184937.uv5gwkijaofhjfd7@grep.be>
Date: Wed, 14 Dec 2016 19:01:15 +0000
Content-Transfer-Encoding: 7bit
Message-Id: <95CEC42B-486F-45F2-8879-ACF48C2380FD@alex.org.uk>
References: <20161214150840.10899-1-alex@alex.org.uk>
	<31576d46-c0ed-29b9-71a0-5aca1790799a@virtuozzo.com>
	<6D1B30FC-FD7E-474C-A8E3-FD87E7AA1364@alex.org.uk>
	<5e9150ed-2127-f2e8-f9db-a514e8f0ddf8@virtuozzo.com>
	<5E697C22-5FBB-49A2-A018-A6B96E29FE84@alex.org.uk>
	<94ef3ef2-b76f-fa5d-cbaf-8990ce2b1be8@virtuozzo.com>
	<20161214181323.mehzfmlf6z4pyajp@grep.be>
	<D71CECFD-E513-4372-BB54-BF8D8D521292@alex.org.uk>
	<20161214184937.uv5gwkijaofhjfd7@grep.be>
Subject: Re: [Qemu-devel] [Nbd] [PATCH] Further tidy-up on block status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wouter Verhelst <w@uter.be>
Cc: Alex Bligh <alex@alex.org.uk>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V . Lunev" <den@openvz.org>, John Snow <jsnow@redhat.com>

Wouter,

(Our mails crossed and I've actually pushed something, but no matter)

> On 14 Dec 2016, at 18:49, Wouter Verhelst <w@uter.be> wrote:
> 
> What I was trying to say is that I think the result to _LIST_ with no
> queries should return all information the client needs to theoretically
> build the list of all possible contexts, even if that list may be
> so large as to be unfeasible for it to be built (e.g., in case of a
> cartesian product between all possible other contexts). I gave one
> example, but there may be more.
> 
> My point is that if the query includes a namespace, the result should
> not be defined by our spec. If the query does not include a namespace,
> the result should be "complete" by whatever definition, but not
> unreasonable (i.e., don't just write a cartesian product to a client).
> 
> This could allow an interactive client to present a user with a list of
> possible contexts before performing analysis on the block device, say.

OK, so first of all, one of the changes I made earlier was that now
each of the commands carries a list of queries, the way you list
everything is not 'having a query that doesn't contain a namespace'
but rather doing a _LIST_ with no queries at all. But that's semantics
and orthogonal to the main point.

What I've proposed (and pushed - but feel free to alter it) is that

1. on _LIST_, the server can return fewer contexts than are available
   if returning all of them would consume undue levels of resources.

2. on _LIST_ where the contexts are 'algorithmic', the server can
   return e.g. 'X-Backup:' rather than 'X-Backup:modified>' and
   every integer.

3. On _SET_ if too many contexts are requested, the server may return
   an error (I think we need this anyway).

That nearly does what you ask for, but I'm not sure how you any query
could 'return all the information the client needs to build
the list of all possible contexts'. For instance, in my backup
example 'X-Backup:modified>[integer]' doesn't itself tell you
anything, as you don't know whether the integer is a unix
date time, in seconds after the epoch, milliseconds or whatever.
What, surely, as a client you want to know is 'does it support
the X-Backup: extension because I've read the spec for that and
know that it has X-Backup:modified if so'. So I've suggested it
return 'X-Backup:' only in that case, in which case from that
(*and the spec*) you know how to build any query.

-- 
Alex Bligh
