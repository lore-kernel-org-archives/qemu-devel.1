Received: from eggs.gnu.org ([2001:4830:134:3::10]:34662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cGocs-0004Ls-5R
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 10:04:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cGocm-0000gt-FA
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 10:04:18 -0500
Received: from [2a01:4f8:140:52e5::2] (port=37089 helo=latin.grep.be)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wouter@grep.be>) id 1cGocm-0000gE-5p
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 10:04:12 -0500
Date: Tue, 13 Dec 2016 16:03:43 +0100
From: Wouter Verhelst <w@uter.be>
Message-ID: <20161213150343.3g3fxjixbteum7ju@grep.be>
References: <20161212204313.anhjire2gkwd6gzi@grep.be>
	<2D482F67-8115-48CD-921D-5728BC1AD92B@alex.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2D482F67-8115-48CD-921D-5728BC1AD92B@alex.org.uk>
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
Cc: "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Pavel Borzenkov <pborzenkov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Pargmann <mpa@pengutronix.de>, "Denis V. Lunev" <den@openvz.org>

Alex,

(leaving out obvious grammar/language fixes that I have no problem with)

On Tue, Dec 13, 2016 at 02:09:19PM +0000, Alex Bligh wrote:
> Wouter,
> 
> Some comments below:
> 
> > On 12 Dec 2016, at 20:43, Wouter Verhelst <w@uter.be> wrote:
> ....
> > +## Metadata querying
> > +
> > +With the availability of sparse storage formats, it is often needed to
> > +query the status of a particular range and read only those blocks of
> > +data that are actually present on the block device.
> > +
> > +Some storage formats and operations over such formats express a
> > +concept of data dirtiness. Whether the operation is block device
> > +mirroring, incremental block device backup or any other operation with
> > +a concept of data dirtiness, they all share a need to provide a list
> > +of ranges that this particular operation treats as dirty.
> 
> I'm not sure this necessarily has anything to do with sparse storage
> formats. For instance the 'dirty' concept would work perfectly well
> on a non-sparse format. I propose the following to replace the two
> paragraphs above:
> 
> "It is often helpful for the client to be able to query the status
> of a range of blocks. The nature of the status that can be
> queried is in part implementation dependent. For instance,
> the status might represent:
> 
> * in a sparse storage format, whether the relevant blocks are
>   actually present on the backing device for the export; or
> 
> * whether the relevant blocks are 'dirty'; some storage formats
>   and operations over such formats express a concept of data dirtiness.
>   Whether the operation is block device mirroring, incremental block
>   device backup or any other operation with a concept of data dirtiness,
>   they all share a need to provide a list of ranges that this
>   particular operation treats as dirty.
> "

I suppose that works, yes.

[..]
> > +- During transmission, a client can then indicate interest in metadata
> > +  for a given region by way of the `NBD_CMD_BLOCK_STATUS` command, where
> > +  *offset* and *length* indicate the area of interest. The server MUST
> > +  then respond with the requested information, for all contexts which
> > +  were selected during negotiation. For every metadata context, the
> > +  server sends one set of extent chunks, where the sizes of the
> > +  extents MUST be less than or equal to the length as specified in the
> > +  request. Each extent comes with a *flags* field, the semantics of
> > +  which are defined by the metadata context.
> > +- A server MUST reply to `NBD_CMD_BLOCK_STATUS` with a structured reply
> > +  of type `NBD_REPLY_TYPE_BLOCK_STATUS`.
> > +
> > +A client MUST NOT use `NBD_CMD_BLOCK_STATUS` unless it selected a
> > +nonzero
> 
> "non-zero"
> 
> > number of metadata contexts during negotiation. Servers SHOULD
> > +reply to clients doing so anyway with `EINVAL`.
> 
> I had difficulty parsing "so". I think you mean "Servers SHOULD
> reply to clients sending `NBD_CMD_BLOCK_STATUS without
> selecting metadata contexts with"

Yes.

> But actually, why do we need to be so mean? Why can't we assume
> that if NBD_OPT_SET_META_CONTEXT is not sent, then all the metadata
> contexts should be selected?

No. If no metadata contexts have been negotiated, then no metadata
context IDs were assigned to contexts, so there is no mapping to
external names. As such, the data being sent in response to
NBD_CMD_BLOCK_STATUS would have no meaning to the client.

[...]
> > +    commands during the transmission phase.
> 
> "otherwise, the client MUST NOT send NBD_CMD_BLOCK_STATUS
> messages."
> 
> But actually isn't the telling question whether NBD_OPT_SET_META_CONTEXT
> works?
> 
> Actually, as this could be sent more than once, I think this whole
> thing would be better phrased as:
> 
> "A client MUST NOT send `NBD_CMD_BLOCK_STATUS` unless
> within the negotiation phase it sent `NBD_OPT_SET_META_CONTEXT`
> at least once, and the final time it was sent, the server
> responded without an error."

... and returned at least one metadata context (since we state elsewhere
that sending a SET command which selects nothing is not an error).

> obviously this would be better under _SET_ than _LIST_,
> but the sentence can go entirely from here.
> 
> Equally obviously, if we are making _SET_ optional (as
> lack of _SET_ means that all the contexts are selected)
> we just gate this on `NBD_FLAG_SEND_BLOCK_STATUS`

You can't, as per above.

> > +    If the query string is syntactically invalid, the server SHOULD send
> > +    `NBD_REP_ERR_INVALID`. If the query string is syntactically valid
> > +    but finds no metadata contexts, the server MUST send a single
> > +    reply of type `NBD_REP_ACK`.
> > +
> > +    This option MUST NOT be requested unless structured replies have
> > +    been negotiated first. If a client attempts to do so, a server
> > +    SHOULD send `NBD_REP_ERR_INVALID`.
> > +
> > +    Data:
> > +    - 32 bits, length of export name
> > +    - String, name of export for which we wish to list or select metadata
> > +      contexts.
> 
> Surely as this is _LIST_ this should read "list" not "list or select"?

Yes, I suppose. The data format for SET and LIST is the same, though, so
it could alternatively be reworded to point that out more clearly.

> > +    - 32 bits, length of query
> > +    - String, query to select a subset of the available metadata
> > +      contexts. If this is not specified (i.e., the "length of query"
> > +      field is 0 and no query is sent), then the server MUST send all
> > +      the metadata contexts it knows about.
> 
> 
> > If specified, this query
> > +      string MUST start with a name that uniquely identifies a server
> > +      implementation; e.g., the reference implementation that
> > +      accompanies this document would support query strings starting
> > +      with 'nbd-server:'
> 
> I'm not sure this is correct (particularly now you've adopted my "X-"
> suggestion), as for instance "base:" does not started with a server
> implementation.

Point.

> Better:
> 
> "If specified, the server MUST return the zero or more contexts
> whose names (including the namespace) consist of or start with
> the query string. For instance a query string of 'nbd-server:'
> would return all contexts within the 'nbd-server' namespace,
> and a string 'base:a' would return all context within the
> 'base' namespace that began with 'a'"

NAK. This imposes a particular syntax for parsing query strings upon
namespaces, which I explicitly do not wish to do.

The spec should only specify how to select a particular namespace, and
then leave all parsing rules of query strings up to the namespace
specification.

> > +    The server MUST reply with a list of `NBD_REP_META_CONTEXT` replies,
> > +    followed by `NBD_REP_ACK`. The metadata context ID in these replies
> > +    is reserved and SHOULD be set to zero; clients SHOULD disregard it.
> 
> Why is the context ID set to zero? Surely it would be really helpful
> for this to be filled in with the ID?

The ID could change depending on which contexts are actually selected:

First, I could imagine a context namespace which allows the client to
dynamically create a context (e.g., "create a snapshot now and use
that"), but where that would only be actually done when the client
actually chooses the metadata context.

Second, a namespace could create symbolic context names (e.g., "the
latest snapshot, whatever that may be"), whose ID could change between
the LIST and SET options (presumably that's a very small race window,
but a race is a race).

Third, a valid (and simple) way to implement mapping could be to assign
context IDs as array indices, where the array is dynamically created at
SET time, and where the server side does a for loop over the array, and
returns the metadata context ID as htonl() of its loop variable. This
would mean that there must be no gaps between the IDs at run time.

Perhaps another way to deal with that would be to specify that an
implementation is not required to assign the same context IDs to the
same metadata contexts from one call to SET (or LIST) to the next; but I
thought it would be clearer if we were to explicitly make LIST return
"invalid" context IDs. Then again, maybe not.

> > +- `NBD_OPT_SET_META_CONTEXT` (11)
> > +
> > +    Change the set of active metadata contexts. Issuing this command
> > +    replaces all previously-set metadata contexts; clients must ensure
> > +    that all metadata contexts they're interested in are selected with
> > +    the final query that they sent.
> > +
> > +    Data:
> > +    - 32 bits, length of query
> > +    - String, query to select metadata contexts.
> 
> Again as above, with s/return/select/:
> 
> "If not specified, the server MUST select all metadata contexts.
> If specified, the server MUST select the zero or more contexts
> whose names (including the namespace) consist of or start with
> the query string. For instance a query string of 'nbd-server:'
> would select all contexts within the 'nbd-server' namespace,
> and a string 'base:a' would select all context within the
> 'base' namespace that began with 'a'"

Again, NAK.

> > The syntax of this
> > +      query is implementation-defined,
> 
> Right, but I'd make this "The syntax of the metadata context
> name is implementation defined" - after all it's not only
> the 'query' that has the namespace, it's also the names
> themselves. Also perhaps move this elsewhere as it doesn't
> only apply to _SET_ but also to _LIST_.

Point.

> > except that it MUST start with a
> > +      namespace. This namespace may be one of the following:
> > +        - `base:`, for metadata contexts defined by this document;
> > +        - `nbd-server:`, for metadata contexts defined by the
> > +          implementation that accompanies this document (none
> > +          currently);
> > +        - `x-*:`, where `*` can be replaced by any random string not
> > +          containing colons, for local experiments.
> 
> Let's be a bit more restrictive:
> 
> where `*` can be replaced by an arbitrary string of non-whitespace
> printable UTF-8 characters, such that the total length of the name
> including namespace does not exceed 255 bytes.

That works, certainly.

> > This SHOULD NOT be
> > +          used by metadata contexts that are expected to e widely used.
> 
> "expected to be widely"

Has already been fixed :)

> > +        - third-party implementations can register additional
> > +          namespaces by simple request to the mailinglist.
> > +
> > +    The server MUST reply with a number of `NBD_REP_META_CONTEXT`
> > +    replies, one for each selected metadata context, each with a unique
> > +    metadata context ID
> 
> "followed by NBD_REP_ACK"

Right.

> > . It is not an error if a
> > +    `NBD_OPT_SET_META_CONTEXT` option does not select any metadata
> > +    context, provided the client then does not attempt to issue
> > +    `NBD_CMD_BLOCK_STATUS` commands.
> > +
> > #### Option reply types
> > 
> > These values are used in the "reply type" field, sent by the server
> > @@ -882,7 +989,7 @@ during option haggling in the fixed newstyle negotiation.
> >     information is available, or when sending data related to the option
> >     (in the case of `NBD_OPT_LIST`) has finished. No data.
> > 
> > -* `NBD_REP_SERVER` (2)
> > +- `NBD_REP_SERVER` (2)
> > 
> >     A description of an export. Data:
> > 
> > @@ -897,10 +1004,18 @@ during option haggling in the fixed newstyle negotiation.
> >       particular client request, this field is defined to be a string
> >       suitable for direct display to a human being.
> > 
> > -* `NBD_REP_INFO` (3)
> > +- `NBD_REP_INFO` (3)
> 
> These two probably belong in a different patch

3

(number of people telling me that. Yes, I know :-)

> >     Defined by the experimental `INFO` [extension](https://github.com/NetworkBlockDevice/nbd/blob/extension-info/doc/proto.md).
> > 
> > +- `NBD_REP_META_CONTEXT` (4)
> > +
> > +    A description of a metadata context. Data:
> > +
> > +    - 32 bits, NBD metadata context ID.
> > +    - String, name of the metadata context. This is not required to be
> > +      a human-readable string, but it MUST be valid UTF-8 data.
> 
> "consisting of printable non-whitespace UTF-8 characters not greater
> than 255 bytes in length"
> 
> Did we not say that we wanted to insert the length of the string to allow
> for expansion?

Ah, yes, forgot about that bit.

[...]
> > +##### Metadata contexts
> > +
> > +The `base:allocation` metadata context is the basic "allocated at all"
> > +metadata context. If an extent is marked with `NBD_STATE_HOLE` at that
> > +context, this means that the given extent is not allocated in the
> > +backend storage, and that writing to the extent MAY result in the ENOSPC
> > +error. This supports sparse file semantics on the server side. If a
> > +server has only one metadata context (the default), then writing to an
> > +extent which has `NBD_STATE_HOLE` clear MUST NOT fail with ENOSPC.
> 
> Again I'm still confused by this. I *think* you mean "If a server
> supports the `base:allocation` metadata context, then writing
> to an extent which has `NBD_STATE_HOLE` clear MUST NOT fail with ENOSPC.`
> 
> I say that because as currently phrased:
> 
> * If a server has one metadata context only, but it is not
>   `base:allocation`, then you implying something about writing
>   to an extent with a state that won't even exist.

Yes, that's wrong indeed. We should replace the "the default" bit by
"the base:allocation context".

> * If a server has `base:allocation` AND another metadata context
>   (for instance `qemu:dirty`) then the rule you set out will not
>   apply.

Yes, and this is intentional, as I've explained before. The other
context's semantics should clarify whether that rule still applies or
not. Implementations that do not know of the other context should
however assume that it doesn't.

[...]
> > +It is not an error for a server to report that a region of the
> > +export has both `NBD_STATE_HOLE` set and `NBD_STATE_ZERO` clear. The
> > +contents of such an area is undefined, and may not be stable;
> > +clients who are aware of the existence of such a region SHOULD NOT
> > +read it.
> 
> As per previous comment, there is no restriction on a client reading it.
> For instance, if it was a block within a long read, it might be
> sensible to read it.
> 
> How about: "the contents of such an area are undefined, and a client
> reading such an area should make no assumption as to its contents
> or stability."

That works.

> > +For the `base:allocation` context, the remainder of the flags field is
> > +reserved. Servers SHOULD set it to all-zero;
> 
> Surely if we want to reserve them for extension, we need "Servers
> MUST set it to all-zero"

No, SHOULD, otherwise a future extension which adds meaning to those
bits will suddenly become incompatible with this spec. Think about it
;-)

> > clients MUST ignore unknown
> > +flags.
> > +
> > +For all other cases, this specification requires no specific semantics of
> > +metadata contexts, except that all the information they provide MUST be
> > +representable within the flags field as defined for
> > +`NBD_REPLY_TYPE_BLOCK_STATUS`.
> > +
> > +Likewise, the syntax of query strings is not specified by this document.
> > +
> > +Server implementations SHOULD document their syntax for query strings
> > +and semantics for resulting metadata contexts in a document like this
> > +one.
> > +
> > ### Transmission phase
> > 
> > #### Flag fields
> > @@ -983,6 +1145,11 @@ valid may depend on negotiation during the handshake phase.
> >    content chunk in reply.  MUST NOT be set unless the transmission
> >    flags include `NBD_FLAG_SEND_DF`.  Use of this flag MAY trigger an
> >    `EOVERFLOW` error chunk, if the request length is too large.
> > +- bit 3, `NBD_CMD_FLAG_REQ_ONE`; valid during `NBD_CMD_BLOCK_STATUS`. If
> > +  set, the client is interested in only one extent per metadata
> > +  context. If this flag is present, the server SHOULD NOT send metadata
> 
> 'MUST NOT'?

I think it's not necessarily a problem for a server to ignore that,
especially in reply to clients which are doing the below.

> > +  on more than one extent in the reply. Clients SHOULD NOT use this flag
> > +  on multiple requests for successive regions in the export.
> 
> Perhaps better to simply note:
> 
> "Client implementors should note that using this flag on multiple
> contiguous requests is likely to be inefficient."
> 
> After all, it's no worse than multiple one block reads, which we do
> not preclude or have as a 'SHOULD NOT'.

That works too.

> > ##### Structured reply flags
> > 
> > @@ -1051,6 +1218,34 @@ interpret the "length" bytes of payload.
> >   64 bits: offset (unsigned)
> >   32 bits: hole size (unsigned, MUST be nonzero)
> > 
> > +- `NBD_REPLY_TYPE_BLOCK_STATUS` (5)
> > +
> > +    *length* MUST be 4 + (a positive integer multiple of 8).  This reply
> > +    represents a series of consecutive block descriptors where the sum
> > +    of the lengths of the descriptors
> 
> I think 'length fields within the descriptors' would be better, else
> you might mean the length of each descriptor itself, which is 8.

Fair enough.

> > MUST not be greater than the
> > +    length of the original request. This chunk type MUST appear exactly
> > +    once per metadata ID in a structured reply.
> > +
> > +    The payload starts with:
> > +
> > +        * 32 bits, metadata context ID
> > +
> > +    and is followed by a list of one or more descriptors, each with this
> > +    layout:
> > +
> > +        * 32 bits, length (unsigned, MUST NOT be zero)
> 
> Perhaps add: "the length of the extent to which which the status
> below applies".

Sounds good, yes.

> > +        * 32 bits, status flags
> > +
> > +    If the client used the `NBD_CMD_FLAG_REQ_ONE` flag in the request,
> > +    then every reply chunk MUST NOT contain more than one descriptor.
> > +
> > +    Even if the client did not use the `NBD_CMD_FLAG_REQ_ONE` flag in
> > +    its request, the server MAY return less descriptors in the reply
> 
> s/less/fewer/
> 
> > +    than would be required to fully specify the whole range of requested
> > +    information to the client, if the number of descriptors would be
> > +    over 16 otherwise
> 
> "otherwise be over 16"

That requirement was dropped already (with
<20161212204913.oaatvexhnndyhhwa@grep.be>)

[...]
> > +* `NBD_CMD_BLOCK_STATUS` (7)
> > +
> > +    A block status query request. Length and offset define the range of
> > +    interest. Clients MUST NOT use this request unless metadata
> > +    contexts have been negotiated,
> 
> I think you mean "have been selected"

Yes.

(feel free to update the branch with those suggestions I've not NAK'd,
as I think they make sense...)

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12
