Received: from eggs.gnu.org ([2001:4830:134:3::10]:37090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cEzsM-0003us-48
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 09:40:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cEzsI-000769-Ol
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 09:40:46 -0500
Received: from mail.avalus.com ([89.16.176.221]:36071)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cEzsI-00075k-DW
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 09:40:42 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <20161208094436.7o4rm54ob2xh4eui@grep.be>
Date: Thu, 8 Dec 2016 14:40:35 +0000
Content-Transfer-Encoding: 7bit
Message-Id: <42260F0E-9D94-44D4-A5FF-EE8F5962ADA0@alex.org.uk>
References: <1480073296-6931-1-git-send-email-vsementsov@virtuozzo.com>
	<F075D231-9CBE-437C-B9F0-0DE2AB98007B@alex.org.uk>
	<ed5f8fc7-c7c8-c678-668f-17047dbe0b23@redhat.com>
	<4329D951-F1D0-4B0B-99AB-9F1B7D3DA99B@alex.org.uk>
	<C9D4A99C-1E81-4144-976B-289FF959430B@alex.org.uk>
	<20161208094436.7o4rm54ob2xh4eui@grep.be>
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
To: Wouter Verhelst <w@uter.be>
Cc: Alex Bligh <alex@alex.org.uk>, John Snow <jsnow@redhat.com>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Pavel Borzenkov <pborzenkov@virtuozzo.com>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, Markus Pargmann <mpa@pengutronix.de>, "Denis V. Lunev" <den@openvz.org>

Wouter,

>> +- `NBD_OPT_META_CONTEXT` (10)
>> +
>> +    Return a list of `NBD_REP_META_CONTEXT` replies, one per context,
>> +    followed by an `NBD_REP_ACK`. If a server replies to such a request
>> +    with no error message, clients
>> 
>> "*the* server" / "*the* cient"
>> 
>> Perhaps only an 'NBD_REP_ERR_UNSUP' error should prevent the
>> client querying the server.
> 
> I don't think that's necessarily a good idea. I think if the server
> replies with NBD_REP_ERR_INVALID, that means it understands the option
> but the user sent something invalid and now we haven't selected any
> contexts. That means the server won't be able to provide any metadata
> during transmission, either.
> 
> Perhaps it should be made clearer that once contexts have been selected
> (even if errors occurred later on), NBD_CMD_BLOCK_STATUS MAY be used.
> 
>> +    MAY send NBD_CMD_BLOCK_STATUS
>> +    commands during the transmission phase.
>> 
>> Add: "If a server replies to such a request with NBD_REP_ERR_UNSUP,
>> the client MUST NOT send NBD_CMD_BLOCK_STATUS commands during the
>> transmission phase."
> 
> That would be counter to the above.

My main point is that the current text does not prohibit sending
NBD_CMD_BLOCK_STATUS if it hasn't been established that the server
supports it.

>> Why not just define the format of a metadata-context string to be
>> of the form '<namespace>:<name>' (perhaps this definition goes
>> elsewhere), and here just say the returned list is a left-match
>> of all the available metadata-contexts, i.e. all those metadata
>> contexts whose names either start or consist entirely of the
>> specified string. If an empty string is specified, all metadata
>> contexts are returned.
> 
> I also want to make it possible for an implementation to define its own
> syntax. Say, a "last-snapshot" thing, or something that says
> "diff:snapshot1-snapshot2", or whatever.

That's a good idea, but doesn't preclude using a colon as a namespace
separator.

>> +    The type may be one of:
>> +    - `NBD_META_LIST_CONTEXT` (1): the list of metadata contexts
>> +      selected by the query string is returned to the client without
>> +      changing any state (i.e., this does not add metadata contexts
>> +      for further usage).
>> 
>> Somewhere it should say this list is returned by sending
>> zero or more NBD_REP_META_CONTEXT records followed by a NBD_REP_ACK.
> 
> We do that above already.

Must have missed it.

>> A metadata context represents metadata concerning the selected
>> export in the form of a list of extents, each with a status. The
>> meaning of the metadata and the status is dependent upon the
>> context. Each metadata context has a name which is colon separated,
>> in the form '<namespace>:<name>'. Namespaces that start with "X-"
>> are vendor dependent extensions.
> 
> No, I wouldn't do that, since by definition, every namespace is
> vendor-dependent.
> 
> Maybe we could ask that people who want to implement their own metadata
> context type (rather than be compatible with an existing one) should
> register their namespace somewhere, though.

What I'm trying to say is that there should be three types of namespace:

* "BASE" (or better "base" as Vladimir points out) which is defined within
  the document, i.e. it will say "base:allocated" does X, "base:foo" does
  Y.
* Registered, e.g. "qemu", where the document would say: "The following
  is a list of registered namespaces: ... qemu: to qemu.org" or whatever.
* Unregistered, e.g. "X-Alex-Experiment" where the document merely mentions
  that namespaces beginning with "X-" can be used by anyone, like X- headers
  in SMTP and HTTP.

The purpose of distinguishing between registered and unregistered is
that otherwise we might get two vendors with a product called "fastnbd"
(or whatever) who both pick the same namespace.

I suppose an alternative would be to go the Java-ish way and suggest
people use a domain name (so 'qemu' would be 'qemu.org:whatever').

>> + metadata context is the basic "exists at all" metadata context.
>> 
>> Disagree. You're saying that if a server supports metadata contexts
>> at all, it must support this one.
> 
> No, I'm trying to say that this metadata context exposes whether the
> *block* exists at all (i.e., it exports NBD_STATE_HOLE). I should
> probably clarify that wording then, if you misunderstood it in that way.

Ah. Perhaps 'exists at all' itself is misleading. 'Occupies storage
space'. Or 'is not a hole'?

> No server MUST implement it (although we might want to make it a SHOULD)

Don't see why it should even be a 'SHOULD' to be honest. An nbd
server cooked up for a specific purpose, or with a backend that
can't provide that (or where there is never a hole) shouldn't
be criticised.

>> I think the last sentence is probably meant to read something like:
>> 
>> If a server supports the "BASE:allocation" metadata context, then
>> writing to an extent which has `NBD_STATE_HOLE` clear MUST NOT fail
>> with ENOSPC.
> 
> No, it can't.
> 
> Other metadata contexts may change the semantics to the extent that if
> the block is allocated at the BASE:allocation context, it would still
> need to space on another plane. In that case, writing to an area which
> is not STATE_HOLE might still fail.

I understand the point (though I'm slightly dubious about it given
the discussion we had with the WRITE_ZEROES extension where we agreed
I thought that the purpose of actual zeroes being written to disk
was to avoid ENOSPC errors). However, if that is the case, I'm not
sure what you're trying to say in the original text.

>> Why 512 bytes as opposed to 'minimum block size' (or is it because
>> that is also an experimental extension)?
> 
> Yes, and this extension does not depend on that one. Hence why it is
> also a SHOULD and not a MUST.

OK. As a separate discussion I think we should talk about promoting
WRITE_ZEROES and INFO. The former has a reference implementation,
I think Eric did a qemu implementation, and I did a gonbdserver
implementation. The latter I believe lacks a reference implementation.

>> +  The status flags are
>> +    intentionally defined so that a server MAY always safely report a
>> +    status of 0 for any block, although the server SHOULD return
>> +    additional status values when they can be easily detected.
>> +
>> +    If an error occurs, the server SHOULD set the appropriate error
>> +    code in the error field of either a simple reply or an error
>> +    chunk.
>> 
>> We should probably point out that you can return an error half way
>> through - that being the point of structured replies.
> 
> Right.
> 
> (also, I think it MUST NOT send a simple reply, but I'll fix that up
> separately)

A simple error reply would normally be permitted.

>> +  However, if the error does not involve invalid usage (such
>> +    as a request beyond the bounds of the file), a server MAY reply
>> +    with a single block status descriptor with *length* matching the
>> +    requested length, and *status* of 0 rather than reporting the
>> +    error.
>> 
>> Wht's the point of this? This appears to say that a server can lie
>> and return everything as not a hole, and not zero! Surely we're
>> already covered from the DoS angle?
> 
> I'm not sure, I believe that wording came from the original patch on
> which I based my work.

Sure, I think it's left over detritus.

>> +    Upon receiving an `NBD_CMD_BLOCK_STATUS` command, the server MUST
>> +    return the status of the device,
>> 
>> status of the metadata context
> 
> No, status of the device. A metadata context *describes* status, it
> *isn't* one.
> 
> Perhaps "status of the device as per the given metadata context", but
> hey.

It's actually 'device' I'm arguing with. Server side we refer to them
as 'exports'. Often they aren't files at all. In gonbdserver it
might be a Ceph connection elsewhere.

'return the status of the relevant portion of the export (as per the
given metadata context'?

>> +    A client SHOULD NOT read from an area that has both `NBD_STATE_HOLE`
>> +    set and `NBD_STATE_ZERO` clear.
>> 
>> That makes no sense, as normal data has both these bits clear! This
>> also implies that to comply with this SHOULD, a client needs to
>> request block status before any read, which is ridiculous. This
>> should be dropped.
> 
> No, it should not, although it may need rewording. It clarifies that
> having STATE_HOLE set (i.e., there's no valid data in the given range)
> and STATE_ZERO clear (i.e., we don't assert that it would read as
> all-zeroes) is not an invalid thing for a server to set. The spec here
> clarifies what a client should do with that information if it gets it
> (i.e., "don't read it, it doesn't contain anything interesting").

That's fair enough until the last bit in brackets. Rather than saying
a client SHOULD NOT read it, it should simply say that a read on
such areas will succeed but the data read is undefined (and may
not be stable).

> My WIP patch moves this out from the (older) "BLOCK_STATUS extension"
> section and into the main body of the spec. It also makes a few changes
> in wording as per what Vladimir suggested, and I was working on an
> NBD_OPT_LIST_META_CONTEXT rather than an NBD_OPT_META_CONTEXT
> negotiation option, with the idea that I'd add an OPT_ADD_META_CONTEXT
> and an OPT_DEL_META_CONTEXT later. Your idea of using a SET has merit
> though, so I'll update it to that effect.
> 
> It already removed the two bits that BASE:allocation doesn't use, and
> makes a few other changes as well. I haven't had the time to finish it
> and send it out for review though, but I'll definitely include your
> comments now.

Thanks.

-- 
Alex Bligh
