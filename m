Received: from eggs.gnu.org ([2001:4830:134:3::10]:46026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cHG1G-0004h5-FP
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 15:19:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cHG1D-0002QQ-7y
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 15:19:18 -0500
Received: from [2a01:4f8:140:52e5::2] (port=39259 helo=latin.grep.be)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wouter@grep.be>) id 1cHG1D-0002Q7-0y
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 15:19:15 -0500
Date: Wed, 14 Dec 2016 21:18:58 +0100
From: Wouter Verhelst <w@uter.be>
Message-ID: <20161214201858.lblzw2ayddidxfyp@grep.be>
References: <20161214150840.10899-1-alex@alex.org.uk>
	<31576d46-c0ed-29b9-71a0-5aca1790799a@virtuozzo.com>
	<6D1B30FC-FD7E-474C-A8E3-FD87E7AA1364@alex.org.uk>
	<5e9150ed-2127-f2e8-f9db-a514e8f0ddf8@virtuozzo.com>
	<5E697C22-5FBB-49A2-A018-A6B96E29FE84@alex.org.uk>
	<94ef3ef2-b76f-fa5d-cbaf-8990ce2b1be8@virtuozzo.com>
	<20161214181323.mehzfmlf6z4pyajp@grep.be>
	<D71CECFD-E513-4372-BB54-BF8D8D521292@alex.org.uk>
	<3D392E31-DDA4-4316-B26D-871E94A83935@alex.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D392E31-DDA4-4316-B26D-871E94A83935@alex.org.uk>
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

On Wed, Dec 14, 2016 at 06:51:48PM +0000, Alex Bligh wrote:
> 
> > On 14 Dec 2016, at 18:18, Alex Bligh <alex@alex.org.uk> wrote:
> > 
> > Let me have a go at a change.
> 
> OK I've pushed a change. I reordered a few bits (to put the
> base:allocation next to the stuff that talks about metadata
> queries at the start), but the main change is below.
> 
> -- 
> Alex Bligh
> 
> 
> 
> @@ -970,15 +1029,38 @@ of the newstyle negotiation.
>         - String, query to list a subset of the available metadata
>           contexts.
> 
> -    If zero queries are sent, then the server MUST return all
> -    the metadata contexts that are available to the client to select
> -    on the given export with `NBD_OPT_SET_META_CONTEXT`.
> -
>      For details on the query string, see under `NBD_OPT_SET_META_CONTEXT`.
> 
>      The server MUST either reply with an error (for instance `EINVAL`
>      if the option is not supported), or reply with a list of
>      `NBD_REP_META_CONTEXT` replies followed by `NBD_REP_ACK`.
> +
> +    If zero queries are sent, then the server MUST return all
> +    the metadata contexts that are available to the client to select
> +    on the given export with `NBD_OPT_SET_META_CONTEXT`, save that:
> +
> +    If one or more queries are sent, then the server MUST return
> +    those metadata contexts that are available to the client to
> +    select on the given export with `NBD_OPT_SET_META_CONTEXT`,
> +    and which match one or more of the queries given. The
> +    support of wildcarding within the leaf-name portion of
> +    the query string is dependent upon the namespace.
> +
> +    In either case, however:
> +
> +    * the server MAY return an incomplete list if returning a
> +      complete list would require undue resources.

This part is a bad idea, as per my other mail. Returning a complete list
should not be optional, but the definition of "complete" doesn't have to
imply "list all possible context names".

> +    * the server MAY return a context consisting of a namespace and
> +      a colon only (i.e. omitting the leaf-name) to indicate that
> +      the namespace contains a large number of possible contexts
> +      within that namespace (for instance a namespace `X-backup` with
> +      contexts that indicate whether blocks were written after
> +      a given date might accept queries of the form
> +      `'X-backup:modifiedtime>[unixdate]'` where `[unixdate]` is an
> +      arbitrary integer, and in this case it might simply
> +      return `X-backup:`)

This is way too detailed, I think. It should just allow namespaces to
define what _LIST_ may return, as long as the client is somehow able to
distill (through knowledge of the spec as well as the information sent
in reply to the _LIST_ command) all the metadata contexts it can
possibly select.

>      The metadata context ID in these replies is reserved and SHOULD be
>      set to zero; clients MUST disregard it.
> 
> @@ -1009,7 +1091,9 @@ of the newstyle negotiation.
> 
>      If zero queries are sent, the server MUST select no metadata contexts.
> 
> -    The server MUST reply with a number of `NBD_REP_META_CONTEXT`
> +    The server MAY return `NBD_REP_ERR_TOO_BIG` if a request
> +    seeks to select too many contexts. Otherwise
> +    the server MUST reply with a number of `NBD_REP_META_CONTEXT`

This part makes sense.

>      replies, one for each selected metadata context, each with a unique
>      metadata context ID, followed by `NBD_REP_ACK`. The metadata context
>      ID is transient and may vary across calls to `NBD_OPT_SET_META_CONTEXT`;

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12
