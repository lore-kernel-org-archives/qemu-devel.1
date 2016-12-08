Received: from eggs.gnu.org ([2001:4830:134:3::10]:36270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cEvGA-00087g-LV
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 04:45:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cEvG7-00028r-Bd
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 04:45:02 -0500
Received: from [2a01:4f8:140:52e5::2] (port=56405 helo=latin.grep.be)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wouter@grep.be>) id 1cEvG6-00021p-UG
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 04:44:59 -0500
Date: Thu, 8 Dec 2016 10:44:36 +0100
From: Wouter Verhelst <w@uter.be>
Message-ID: <20161208094436.7o4rm54ob2xh4eui@grep.be>
References: <1480073296-6931-1-git-send-email-vsementsov@virtuozzo.com>
	<F075D231-9CBE-437C-B9F0-0DE2AB98007B@alex.org.uk>
	<ed5f8fc7-c7c8-c678-668f-17047dbe0b23@redhat.com>
	<4329D951-F1D0-4B0B-99AB-9F1B7D3DA99B@alex.org.uk>
	<C9D4A99C-1E81-4144-976B-289FF959430B@alex.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C9D4A99C-1E81-4144-976B-289FF959430B@alex.org.uk>
Subject: Re: [Qemu-devel] [Nbd] [PATCH v3] doc: Add NBD_CMD_BLOCK_STATUS
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
Cc: John Snow <jsnow@redhat.com>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Pavel Borzenkov <pborzenkov@virtuozzo.com>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, Markus Pargmann <mpa@pengutronix.de>, "Denis V. Lunev" <den@openvz.org>

On Thu, Dec 08, 2016 at 03:39:19AM +0000, Alex Bligh wrote:
> 
> > On 2 Dec 2016, at 18:45, Alex Bligh <alex@alex.org.uk> wrote:
> > 
> > Thanks. That makes sense - or enough sense for me to carry on commenting!
> 
> 
> I finally had some time to go through this extension in detail. Rather
> than comment on all the individual patches, I squashed them into a single
> commit, did a 'git format-patch' on it, and commented on that.
> 
> diff --git a/doc/proto.md b/doc/proto.md
> index c443494..9c0981f 100644
> --- a/doc/proto.md
> +++ b/doc/proto.md
> @@ -871,6 +869,50 @@ of the newstyle negotiation.
> 
>     Defined by the experimental `INFO` [extension](https://github.com/NetworkBlockDevice/nbd/blob/extension-info/doc/proto.md).
> 
> +- `NBD_OPT_META_CONTEXT` (10)
> +
> +    Return a list of `NBD_REP_META_CONTEXT` replies, one per context,
> +    followed by an `NBD_REP_ACK`. If a server replies to such a request
> +    with no error message, clients
> 
> "*the* server" / "*the* cient"
> 
> Perhaps only an 'NBD_REP_ERR_UNSUP' error should prevent the
> client querying the server.

I don't think that's necessarily a good idea. I think if the server
replies with NBD_REP_ERR_INVALID, that means it understands the option
but the user sent something invalid and now we haven't selected any
contexts. That means the server won't be able to provide any metadata
during transmission, either.

Perhaps it should be made clearer that once contexts have been selected
(even if errors occurred later on), NBD_CMD_BLOCK_STATUS MAY be used.

> +    MAY send NBD_CMD_BLOCK_STATUS
> +    commands during the transmission phase.
> 
> Add: "If a server replies to such a request with NBD_REP_ERR_UNSUP,
> the client MUST NOT send NBD_CMD_BLOCK_STATUS commands during the
> transmission phase."

That would be counter to the above.

> +    If the query string is syntactically invalid, the server SHOULD send
> +    `NBD_REP_ERR_INVALID`.
> 
> 'MUST send' else it implies sending nothing is permissible.

Yes, I had already fixed that locally (but didn't push yet, because that
patch is... big, and needs some rework. I'll look at it again later,
incorporating your comments)

> +    If the query string is syntactically valid
> +    but finds no metadata contexts, the server MUST send a single
> +    reply of type `NBD_REP_ACK`.
> +
> +    This option MUST NOT be requested unless structured replies have
> 
> Active voice better:
> 
> "The client MUST NOT send this option unless" ...

Right.

> +    been negotiated first. If a client attempts to do so, a server
> +    SHOULD send `NBD_REP_ERR_INVALID`.
> +
> +    Data:
> +    - 32 bits, type
> +    - String, query to select a subset of the available metadata
> +      contexts. If this is not specified (i.e., length is 4 and no
> +      command is sent), then the server MUST send all the metadata
> +      contexts it knows about. If specified, this query string MUST
> +      start with a name that uniquely identifies a server
> +      implementation; e.g., the reference implementation that
> +      accompanies this document would support query strings starting
> +      with 'nbd-server:'
> 
> Why not just define the format of a metadata-context string to be
> of the form '<namespace>:<name>' (perhaps this definition goes
> elsewhere), and here just say the returned list is a left-match
> of all the available metadata-contexts, i.e. all those metadata
> contexts whose names either start or consist entirely of the
> specified string. If an empty string is specified, all metadata
> contexts are returned.

I also want to make it possible for an implementation to define its own
syntax. Say, a "last-snapshot" thing, or something that says
"diff:snapshot1-snapshot2", or whatever.

> +    The type may be one of:
> +    - `NBD_META_LIST_CONTEXT` (1): the list of metadata contexts
> +      selected by the query string is returned to the client without
> +      changing any state (i.e., this does not add metadata contexts
> +      for further usage).
> 
> Somewhere it should say this list is returned by sending
> zero or more NBD_REP_META_CONTEXT records followed by a NBD_REP_ACK.

We do that above already.

> +    - `NBD_META_ADD_CONTEXT` (2): the list of metadata contexts
> +      selected by the query string is added to the list of existing
> +      metadata contexts.
> +    - `NBD_META_DEL_CONTEXT` (3): the list of metadata contexts
> +      selected by the query string is removed from the list of used
> +      metadata contexts. Servers SHOULD NOT reuse existing metadata
> +      context IDs.
> +
> +    The syntax of the query string is not specified, except that
> +    implementations MUST support adding and removing individual metadata
> +    contexts by simply listing their names.
> 
> This seems slightly over complicated. Rather than have a list held
> by the server of active metadata contexts, we could simply have
> two NBD_OPT_ commands, say NBD_OPT_LIST_META_CONTEXTS and
> NBD_OPT_SET_META_CONTEXTS (which simply sets a list). Then no
> need for 'type', and _ADD_ and _DEL_.

Hrm. Probably better, yes.

> #### Option reply types
> 
> These values are used in the "reply type" field, sent by the server
> @@ -882,7 +924,7 @@ during option haggling in the fixed newstyle negotiation.
>     information is available, or when sending data related to the option
>     (in the case of `NBD_OPT_LIST`) has finished. No data.
> 
> ....
> 
> +- `NBD_REP_META_CONTEXT` (4)
> +
> +    A description of a metadata context. Data:
> +
> +    - 32 bits, NBD metadata context ID.
> +    - String, name of the metadata context. This is not required to be
> +      a human-readable string, but it MUST be valid UTF-8 data.
> 
> I would suggest puttig in a length of the string before the string,
> which will allow us to expand this later to add fields if necessary.
> This seems to be what we are doing elsewhere.

True enough.

> +    This specification declares one metadata context. It is called
> +    "BASE:allocation" and contains the basic "exists at all" context.
> +
> There are a number of error reply types, all of which are denoted by
> having bit 31 set. All error replies MAY have some data set, in which
> case that data is an error message string suitable for display to the user.
> @@ -938,15 +991,48 @@ case that data is an error message string suitable for display to the user.
> 
> ....
> 
> +##### Metadata contexts
> +
> 
> We're missing some explanation as to what these 'metadata contexts'
> things actually are. I suggest:
> 
> A metadata context represents metadata concerning the selected
> export in the form of a list of extents, each with a status. The
> meaning of the metadata and the status is dependent upon the
> context. Each metadata context has a name which is colon separated,
> in the form '<namespace>:<name>'. Namespaces that start with "X-"
> are vendor dependent extensions.

No, I wouldn't do that, since by definition, every namespace is
vendor-dependent.

Maybe we could ask that people who want to implement their own metadata
context type (rather than be compatible with an existing one) should
register their namespace somewhere, though.

> The 'BASE' namespace represents metadata contexts defined within this
> document. Other namespaces may be registered by reference within this
> document.
> 
> +The "BASE:allocation" 
> 
> Backticks: `BASE:allocation`

Right.

> + metadata context is the basic "exists at all" metadata context.
> 
> Disagree. You're saying that if a server supports metadata contexts
> at all, it must support this one.

No, I'm trying to say that this metadata context exposes whether the
*block* exists at all (i.e., it exports NBD_STATE_HOLE). I should
probably clarify that wording then, if you misunderstood it in that way.

No server MUST implement it (although we might want to make it a SHOULD)

> Why? It might just want to do the backup thing. There's no reason to
> make this compulsory.
> 
> +If an extent is marked with `NBD_STATE_HOLE` at that
> +context, this means that the given extent is not allocated in the
> +backend storage, and that writing to the extent MAY result in the ENOSPC
> +error. This supports sparse file semantics on the server side. If a
> +server has only one metadata context (the default), then writing to an
> +extent which has `NBD_STATE_HOLE` clear MUST NOT fail with ENOSPC.
> 
> I don't understand the purpose of the last sentence here. If a server
> does not support the 'BASE:allocation' metadata context then writing
> to any extent can fail with ENOSPC. What's the significance of having
> exactly one metadata context?

Yes, Vladimir also made that comment, and I've been modifying the text a
bit to that extent.

> I think the last sentence is probably meant to read something like:
> 
> If a server supports the "BASE:allocation" metadata context, then
> writing to an extent which has `NBD_STATE_HOLE` clear MUST NOT fail
> with ENOSPC.

No, it can't.

Other metadata contexts may change the semantics to the extent that if
the block is allocated at the BASE:allocation context, it would still
need to space on another plane. In that case, writing to an area which
is not STATE_HOLE might still fail.

> +For all other cases, this specification requires no specific semantics
> +of metadata contexts. Implementations could support metadata
> +contexts with semantics like the following:
> +
> +- Incremental snapshots; if a block is allocated in one metadata
> +  context, that implies that it is also allocated in the next level up.
> +- Various bits of data about the backend of the storage; e.g., if the
> +  storage is written on a RAID array, a metadata context could
> +  return information about the redundancy level of a given extent
> +- If the backend implements a write-through cache of some sort, or
> +  synchronises with other servers, a metadata context could state
> +  that an extent is "active" once it has reached permanent storage
> +  and/or is synchronized with other servers.
> +
> +The only requirement of a metadata context is that it MUST be
> +representable with the flags as defined for `NBD_CMD_BLOCK_STATUS`.
> +
> +Likewise, the syntax of query strings is not specified by this document.
> +
> +Server implementations SHOULD document their syntax for query strings
> +and semantics for resulting metadata contexts in a document like this
> +one.
> 
> This will need slightly tweaking with the namespace thing. Happy to
> have a go if that works.

Sure.

> ### Transmission phase
> 
> #### Flag fields
> @@ -983,6 +1069,9 @@ valid may depend on negotiation during the handshake phase.
>    content chunk in reply.  MUST NOT be set unless the transmission
>    flags include `NBD_FLAG_SEND_DF`.  Use of this flag MAY trigger an
>    `EOVERFLOW` error chunk, if the request length is too large.
> +- bit 3, `NBD_CMD_FLAG_REQ_ONE`; valid during `NBD_CMD_BLOCK_STATUS`. If
> +  set, the client is interested in only one extent per metadata
> +  context.
> 
> ##### Structured reply flags
> 
> @@ -1051,6 +1140,10 @@ interpret the "length" bytes of payload.
>   64 bits: offset (unsigned)  
>   32 bits: hole size (unsigned, MUST be nonzero)  
> 
> +- `NBD_REPLY_TYPE_BLOCK_STATUS` (5)
> +
> +  Defined by the experimental extension `BLOCK_STATUS`; see below.
> +
> All error chunk types have bit 15 set, and begin with the same
> *error*, *message length*, and optional *message* fields as
> `NBD_REPLY_TYPE_ERROR`.  If non-zero, *message length* indicates
> @@ -1085,7 +1178,7 @@ remaining structured fields at the end.
>   were sent earlier in the structured reply, the server SHOULD NOT
>   send multiple distinct offsets that lie within the bounds of a
>   single content chunk.  Valid as a reply to `NBD_CMD_READ`,
> -  `NBD_CMD_WRITE`, and `NBD_CMD_TRIM`.
> +  `NBD_CMD_WRITE`, `NBD_CMD_TRIM`, and `NBD_CMD_BLOCK_STATUS`.
> 
>   The payload is structured as:
> 
> @@ -1259,6 +1352,11 @@ The following request types exist:
> 
>     Defined by the experimental `WRITE_ZEROES` [extension](https://github.com/NetworkBlockDevice/nbd/blob/extension-write-zeroes/doc/proto.md).
> 
> +* `NBD_CMD_BLOCK_STATUS` (7)
> +
> +    Defined by the experimental `BLOCK_STATUS` extension; see below.
> 
> This is wrong, because the way we document extensions is that in the branch,
> it's as if the relevant extension is no longer experimental. So remove
> 'experimental'.
> 
> +
> * Other requests
> 
>     Some third-party implementations may require additional protocol
> @@ -1345,6 +1443,148 @@ written as branches which can be merged into master if and
> when those extensions are promoted to the normative version
> of the document in the master branch.
> 
> +### `BLOCK_STATUS` extension
> +
> +With the availability of sparse storage formats, it is often needed to
> +query the status of a particular range and read only those blocks of
> +data that are actually present on the block device.
> +
> +Some storage formats and operations over such formats express a
> +concept of data dirtiness. Whether the operation is block device
> +mirroring, incremental block device backup or any other operation with
> +a concept of data dirtiness, they all share a need to provide a list
> +of ranges that this particular operation treats as dirty.
> +
> +To provide such class of information, the `BLOCK_STATUS` extension
> +adds a new `NBD_CMD_BLOCK_STATUS` command which returns a list of
> +ranges with their respective states.  This extension is not available
> +unless the client also negotiates the `STRUCTURED_REPLY` extension.
> 
> 'unless the client and server negotiate'
> 
> +
> +* `NBD_REPLY_TYPE_BLOCK_STATUS`
> +
> +    *length* MUST be 4 + (a positive integer multiple of 8).  This reply
> +    represents a series of consecutive block descriptors where the sum
> +    of the lengths of the descriptors MUST not be greater than the
> +    length of the original request.
> 
> I'm a bit unhappy with this. The way structured replies work, the
> length of the replies is meant to add up to the lengh requested. I
> think implementations might write a reply processor and want to assume
> this. I know that the idea here is that the server can effectively
> 'give up' sending stuff - though with structured replies to be honest
> that's less of an issue. If we really need this ability, why not
> allow the server to send a final chunk that's in "don't know" state?

Not a bad idea.

> + This chunk type MUST appear at most
> +    once per metadata ID in a structured reply. Valid as a reply to
> +    `NBD_CMD_BLOCK_STATUS`.
> +
> +    Servers MUST return an `NBD_REPLY_TYPE_BLOCK_STATUS` chunk for every
> +    metadata context ID, except if the semantics of particular
> +    metadata contexts mean that the information for one active metadata
> +    context is implied by the information for another; e.g., if a
> +    particular metadata context can only have meaning for extents where
> +    the `NBD_STATE_HOLE` flag is cleared on the "BASE:allocation"
> +    context, servers MAY omit the relevant chunks for that context if
> +    they already sent an extent with the `NBD_STATE_HOLE` flag set in
> +    reply to the same `NBD_CMD_BLOCK_STATUS` command.
> +
> +    The payload starts with:
> +
> +        * 32 bits, metadata context ID
> +
> +    and is followed by a list of one or more descriptors, each with this
> +    layout:
> +
> +        * 32 bits, length (unsigned, MUST NOT be zero)
> +        * 32 bits, status flags
> +
> +    If the client used the `NBD_CMD_FLAG_REQ_ONE` flag in the request,
> +    then every reply chunk MUST NOT contain more than one descriptor.
> 
> Given you've defined length as '4+(a positive multiple of 8)'
> this suggests that you mean 'exactly one' here. One of those
> is wrong.

That would make it clearer, indeed (although "1" is "not more than one",
and "8" is also "a positive multiple of 8", so it's not *wrong*, per se,
it's just confusing)

> +    Even if the client did not use the `NBD_CMD_FLAG_REQ_ONE` flag in
> +    its request, the server MAY return less descriptors in the reply
> 
> s/less/fewer/
> 
> +    than would be required to fully specify the whole range of requested
> +    information to the client, if the number of descriptors would be
> +    over 16 otherwise and looking up the information would be too
> +    resource-intensive for the server.
> 
> Seems a bit odd we permit this sort of rate limiting but don't
> e.g. rate-limit read.

Yes, I suppose you're right.

> +* `NBD_CMD_BLOCK_STATUS`
> +
> +    A block status query request. Length and offset define the range of
> +    interest. Clients MUST NOT use this request unless metadata
> +    contexts have been negotiated, which in turn requires the client to
> +    first negotiate structured replies. For a successful return, the
> +    server MUST use a structured reply, containing at least one chunk of
> +    type `NBD_REPLY_TYPE_BLOCK_STATUS`.
> +
> +    The list of block status descriptors within the
> +    `NBD_REPLY_TYPE_BLOCK_STATUS` chunk represent consecutive portions
> +    of the file starting from specified *offset*, and the sum of the
> +    *length* fields of each descriptor MUST not be greater than the
> +    overall *length* of the request. This means that the server MAY
> +    return less data than required. However the server MUST return at
> +    least one status descriptor.  The server SHOULD use different
> +    *status* values between consecutive descriptors,
> 
> Why? This seems like a needless restriction.
> 
> +     and SHOULD use
> +    descriptor lengths that are an integer multiple of 512 bytes where
> +    possible (the first and last descriptor of an unaligned query being
> +    the most obvious places for an exception).
> 
> Why 512 bytes as opposed to 'minimum block size' (or is it because
> that is also an experimental extension)?

Yes, and this extension does not depend on that one. Hence why it is
also a SHOULD and not a MUST.

> +  The status flags are
> +    intentionally defined so that a server MAY always safely report a
> +    status of 0 for any block, although the server SHOULD return
> +    additional status values when they can be easily detected.
> +
> +    If an error occurs, the server SHOULD set the appropriate error
> +    code in the error field of either a simple reply or an error
> +    chunk.
> 
> We should probably point out that you can return an error half way
> through - that being the point of structured replies.

Right.

(also, I think it MUST NOT send a simple reply, but I'll fix that up
separately)

> +  However, if the error does not involve invalid usage (such
> +    as a request beyond the bounds of the file), a server MAY reply
> +    with a single block status descriptor with *length* matching the
> +    requested length, and *status* of 0 rather than reporting the
> +    error.
> 
> Wht's the point of this? This appears to say that a server can lie
> and return everything as not a hole, and not zero! Surely we're
> already covered from the DoS angle?

I'm not sure, I believe that wording came from the original patch on
which I based my work.

> +    Upon receiving an `NBD_CMD_BLOCK_STATUS` command, the server MUST
> +    return the status of the device,
> 
> status of the metadata context

No, status of the device. A metadata context *describes* status, it
*isn't* one.

Perhaps "status of the device as per the given metadata context", but
hey.

> + where the status field of each
> +    descriptor is determined by the following bits (all combinations of
> +    these bits are possible):
> 
> In my mind these status bits are defined entirely by the metadata
> context, and the definitions below apply only to `BASE:allocation`

Yes, Vladimir made a similar observation, and my WIP patch has that too.

> +
> +      - `NBD_STATE_HOLE` (bit 0): if set, the block represents a hole
> +        (and future writes to that area may cause fragmentation or
> +        encounter an `ENOSPC` error); if clear, the block is allocated
> +        or the server could not otherwise determine its status.  Note
> +        that the use of `NBD_CMD_TRIM` is related to this status, but
> +        that the server MAY report a hole even where trim has not been
> +        requested, and also that a server MAY report metadata even
> +        where a trim has been requested.
> +      - `NBD_STATE_ZERO` (bit 1): if set, the block contents read as
> +        all zeroes; if clear, the block contents are not known.  Note
> +        that the use of `NBD_CMD_WRITE_ZEROES` is related to this
> +        status, but that the server MAY report zeroes even where write
> +        zeroes has not been requested, and also that a server MAY
> +        report unknown content even where write zeroes has been
> +        requested.
> 
> So the above two are `BASE:allocation` only, but ...
> 
> +      - `NBD_STATE_CLEAN` (bit 2): if set, the block represents a
> +        portion of the file that is still clean because it has not
> +        been written; if clear, the block represents a portion of the
> +        file that is dirty, or where the server could not otherwise
> +        determine its status. The server MUST NOT set this bit for
> +        the "BASE:allocation" context, where it has no meaning.
> +      - `NBD_STATE_ACTIVE` (bit 3): if set, the block represents a
> +        portion of the file that is "active" in the given metadata
> +        context. The server MUST NOT set this bit for the
> +        "BASE:allocation" context, where it has no meaning.
> +
> +    The exact semantics of what it means for a block to be "clean" or
> +    "active" at a given metadata context is not defined by this
> +    specification, except that the default in both cases should be to
> +    clear the bit. That is, when the metadata context does not have
> +    knowledge of the relevant status for the given extent, or when the
> +    metadata context does not assign any meaning to it, the bits
> +    should be cleared.
> 
> .... all the above should go as these describe the QEMU incremental
> backup thing, which we agreed, I think, not to describe here.

Right.

> +    A client SHOULD NOT read from an area that has both `NBD_STATE_HOLE`
> +    set and `NBD_STATE_ZERO` clear.
> 
> That makes no sense, as normal data has both these bits clear! This
> also implies that to comply with this SHOULD, a client needs to
> request block status before any read, which is ridiculous. This
> should be dropped.

No, it should not, although it may need rewording. It clarifies that
having STATE_HOLE set (i.e., there's no valid data in the given range)
and STATE_ZERO clear (i.e., we don't assert that it would read as
all-zeroes) is not an invalid thing for a server to set. The spec here
clarifies what a client should do with that information if it gets it
(i.e., "don't read it, it doesn't contain anything interesting").

> +A client MAY close the connection if it detects that the server has
> +sent an invalid chunk (such as lengths in the
> +`NBD_REPLY_TYPE_BLOCK_STATUS` not summing up to the requested length).
> 
> I agree with the above, but this goes counter to the text above allowing
> the server to return lengths that do not sum to the requested length.
> Also the expression we use elsewhere is 'terminates transmission'
> for a close during the transmission phase.

Yes, indeed. I think I've been convinced that allowing the server to
send less data than was requested is indeed a bad idea (except when the
REQ_ONE bit is set), so I'll drop that, too.

> +The server SHOULD return `EINVAL` if it receives a `BLOCK_STATUS`
> +request including one or more sectors beyond the size of the device.
> +
> +The extension adds the following new command flag:
> +
> +- `NBD_CMD_FLAG_REQ_ONE`; valid during `NBD_CMD_BLOCK_STATUS`.
> +  SHOULD be set to 1 if the client wants to request information for only
> +  one extent per metadata context.
> +
> 
> Already handled above - this is a duplication

Yes.

My WIP patch moves this out from the (older) "BLOCK_STATUS extension"
section and into the main body of the spec. It also makes a few changes
in wording as per what Vladimir suggested, and I was working on an
NBD_OPT_LIST_META_CONTEXT rather than an NBD_OPT_META_CONTEXT
negotiation option, with the idea that I'd add an OPT_ADD_META_CONTEXT
and an OPT_DEL_META_CONTEXT later. Your idea of using a SET has merit
though, so I'll update it to that effect.

It already removed the two bits that BASE:allocation doesn't use, and
makes a few other changes as well. I haven't had the time to finish it
and send it out for review though, but I'll definitely include your
comments now.

Regards,

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12
