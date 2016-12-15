Received: from eggs.gnu.org ([2001:4830:134:3::10]:37190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cHXZP-0001mi-CP
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 10:03:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cHXZK-0004ne-Fy
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 10:03:43 -0500
Received: from [2a01:4f8:140:52e5::2] (port=40606 helo=latin.grep.be)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wouter@grep.be>) id 1cHXZK-0004ku-9c
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 10:03:38 -0500
Date: Thu, 15 Dec 2016 16:03:12 +0100
From: Wouter Verhelst <w@uter.be>
Message-ID: <20161215150312.dmxrxn7ujzq3apy6@grep.be>
References: <31576d46-c0ed-29b9-71a0-5aca1790799a@virtuozzo.com>
	<6D1B30FC-FD7E-474C-A8E3-FD87E7AA1364@alex.org.uk>
	<5e9150ed-2127-f2e8-f9db-a514e8f0ddf8@virtuozzo.com>
	<5E697C22-5FBB-49A2-A018-A6B96E29FE84@alex.org.uk>
	<94ef3ef2-b76f-fa5d-cbaf-8990ce2b1be8@virtuozzo.com>
	<20161214181323.mehzfmlf6z4pyajp@grep.be>
	<D71CECFD-E513-4372-BB54-BF8D8D521292@alex.org.uk>
	<3D392E31-DDA4-4316-B26D-871E94A83935@alex.org.uk>
	<20161214201858.lblzw2ayddidxfyp@grep.be>
	<58F412AB-8A4C-403F-AEE2-D2FB958D447A@alex.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58F412AB-8A4C-403F-AEE2-D2FB958D447A@alex.org.uk>
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

Hi Alex,

On Thu, Dec 15, 2016 at 10:04:05AM +0000, Alex Bligh wrote:
> 
> > On 14 Dec 2016, at 20:18, Wouter Verhelst <w@uter.be> wrote:
> > 
> >> +    * the server MAY return a context consisting of a namespace and
> >> +      a colon only (i.e. omitting the leaf-name) to indicate that
> >> +      the namespace contains a large number of possible contexts
> >> +      within that namespace (for instance a namespace `X-backup` with
> >> +      contexts that indicate whether blocks were written after
> >> +      a given date might accept queries of the form
> >> +      `'X-backup:modifiedtime>[unixdate]'` where `[unixdate]` is an
> >> +      arbitrary integer, and in this case it might simply
> >> +      return `X-backup:`)
> > 
> > This is way too detailed, I think. It should just allow namespaces to
> > define what _LIST_ may return, as long as the client is somehow able to
> > distill (through knowledge of the spec as well as the information sent
> > in reply to the _LIST_ command) all the metadata contexts it can
> > possibly select.
> 
> 
> OK, this part now reads:
> 
>     The server MUST either reply with an error (for instance `EINVAL`
>     if the option is not supported), or reply with a list of
>     `NBD_REP_META_CONTEXT` replies followed by `NBD_REP_ACK`.
> 
>     If zero queries are sent, then the server MUST return all
>     the metadata contexts that are available to the client to select
>     on the given export with `NBD_OPT_SET_META_CONTEXT`, save that:

This reads a bit awkward. I would do:

s/save that:/except as explained below/

>     If one or more queries are sent, then the server MUST return
>     those metadata contexts that are available to the client to
>     select on the given export with `NBD_OPT_SET_META_CONTEXT`,
>     and which match one or more of the queries given. The
>     support of wildcarding within the leaf-name portion of
>     the query string is dependent upon the namespace.
> 
>     In either case, however, for any given namespace the
>     server MAY, instead of exhaustively listing every
>     matching context available to select (or every context
>     available to select where no query is given), send
>     sufficient context records back to allow a client with
>     knowledge of the namespace to select any context. Each
>     namespace returned MUST still satisfy the rules for
>     namespaces (i.e. they must begin with the relevant
>     namespace, followed by a colon, then printable non-whitespace
>     UTF-8 characters,

Why restrict to non-whitespace characters? (printable makes sense...)

>     with the entire string not exceeding
>     255 bytes). This may be helpful where a client can
>     construct algorithmic queries. For instance, a client might
>     reply simply with the namespace with no leaf-name (e.g.
>     'X-FooBar:') or with a range of values (e.g.
>     'X-ModifiedDate:20160310-20161214'). The semantics of
>     such a reply are a matter for the definition of the
>     namespace.
> 
> Hope that works.

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12
