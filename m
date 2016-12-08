Received: from eggs.gnu.org ([2001:4830:134:3::10]:46623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cEpYT-0005ev-EM
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 22:39:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cEpYQ-0000UP-KP
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 22:39:33 -0500
Received: from mail.avalus.com ([2001:41c8:10:1dd::10]:52012)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cEpYQ-0000SV-AY
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 22:39:30 -0500
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <4329D951-F1D0-4B0B-99AB-9F1B7D3DA99B@alex.org.uk>
Date: Thu, 8 Dec 2016 03:39:19 +0000
Content-Transfer-Encoding: quoted-printable
Message-Id: <C9D4A99C-1E81-4144-976B-289FF959430B@alex.org.uk>
References: <1480073296-6931-1-git-send-email-vsementsov@virtuozzo.com>
	<F075D231-9CBE-437C-B9F0-0DE2AB98007B@alex.org.uk>
	<ed5f8fc7-c7c8-c678-668f-17047dbe0b23@redhat.com>
	<4329D951-F1D0-4B0B-99AB-9F1B7D3DA99B@alex.org.uk>
Subject: Re: [Qemu-devel] [PATCH v3] doc: Add NBD_CMD_BLOCK_STATUS extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Alex Bligh <alex@alex.org.uk>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Markus Pargmann <mpa@pengutronix.de>, Pavel Borzenkov <pborzenkov@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>, Wouter Verhelst <w@uter.be>, Paolo Bonzini <pbonzini@redhat.com>


> On 2 Dec 2016, at 18:45, Alex Bligh <alex@alex.org.uk> wrote:
>=20
> Thanks. That makes sense - or enough sense for me to carry on =
commenting!


I finally had some time to go through this extension in detail. Rather
than comment on all the individual patches, I squashed them into a =
single
commit, did a 'git format-patch' on it, and commented on that.

diff --git a/doc/proto.md b/doc/proto.md
index c443494..9c0981f 100644
--- a/doc/proto.md
+++ b/doc/proto.md
@@ -871,6 +869,50 @@ of the newstyle negotiation.

    Defined by the experimental `INFO` =
[extension](https://github.com/NetworkBlockDevice/nbd/blob/extension-info/=
doc/proto.md).

+- `NBD_OPT_META_CONTEXT` (10)
+
+    Return a list of `NBD_REP_META_CONTEXT` replies, one per context,
+    followed by an `NBD_REP_ACK`. If a server replies to such a request
+    with no error message, clients

"*the* server" / "*the* cient"

Perhaps only an 'NBD_REP_ERR_UNSUP' error should prevent the
client querying the server.

+    MAY send NBD_CMD_BLOCK_STATUS
+    commands during the transmission phase.

Add: "If a server replies to such a request with NBD_REP_ERR_UNSUP,
the client MUST NOT send NBD_CMD_BLOCK_STATUS commands during the
transmission phase."

+
+    If the query string is syntactically invalid, the server SHOULD =
send
+    `NBD_REP_ERR_INVALID`.

'MUST send' else it implies sending nothing is permissible.

+    If the query string is syntactically valid
+    but finds no metadata contexts, the server MUST send a single
+    reply of type `NBD_REP_ACK`.
+
+    This option MUST NOT be requested unless structured replies have

Active voice better:

"The client MUST NOT send this option unless" ...

+    been negotiated first. If a client attempts to do so, a server
+    SHOULD send `NBD_REP_ERR_INVALID`.
+
+    Data:
+    - 32 bits, type
+    - String, query to select a subset of the available metadata
+      contexts. If this is not specified (i.e., length is 4 and no
+      command is sent), then the server MUST send all the metadata
+      contexts it knows about. If specified, this query string MUST
+      start with a name that uniquely identifies a server
+      implementation; e.g., the reference implementation that
+      accompanies this document would support query strings starting
+      with 'nbd-server:'

Why not just define the format of a metadata-context string to be
of the form '<namespace>:<name>' (perhaps this definition goes
elsewhere), and here just say the returned list is a left-match
of all the available metadata-contexts, i.e. all those metadata
contexts whose names either start or consist entirely of the
specified string. If an empty string is specified, all metadata
contexts are returned.

+
+    The type may be one of:
+    - `NBD_META_LIST_CONTEXT` (1): the list of metadata contexts
+      selected by the query string is returned to the client without
+      changing any state (i.e., this does not add metadata contexts
+      for further usage).

Somewhere it should say this list is returned by sending
zero or more NBD_REP_META_CONTEXT records followed by a NBD_REP_ACK.

+    - `NBD_META_ADD_CONTEXT` (2): the list of metadata contexts
+      selected by the query string is added to the list of existing
+      metadata contexts.
+    - `NBD_META_DEL_CONTEXT` (3): the list of metadata contexts
+      selected by the query string is removed from the list of used
+      metadata contexts. Servers SHOULD NOT reuse existing metadata
+      context IDs.
+
+    The syntax of the query string is not specified, except that
+    implementations MUST support adding and removing individual =
metadata
+    contexts by simply listing their names.

This seems slightly over complicated. Rather than have a list held
by the server of active metadata contexts, we could simply have
two NBD_OPT_ commands, say NBD_OPT_LIST_META_CONTEXTS and
NBD_OPT_SET_META_CONTEXTS (which simply sets a list). Then no
need for 'type', and _ADD_ and _DEL_.

#### Option reply types

These values are used in the "reply type" field, sent by the server
@@ -882,7 +924,7 @@ during option haggling in the fixed newstyle =
negotiation.
    information is available, or when sending data related to the option
    (in the case of `NBD_OPT_LIST`) has finished. No data.

...

+- `NBD_REP_META_CONTEXT` (4)
+
+    A description of a metadata context. Data:
+
+    - 32 bits, NBD metadata context ID.
+    - String, name of the metadata context. This is not required to be
+      a human-readable string, but it MUST be valid UTF-8 data.

I would suggest puttig in a length of the string before the string,
which will allow us to expand this later to add fields if necessary.
This seems to be what we are doing elsewhere.

+
+    This specification declares one metadata context. It is called
+    "BASE:allocation" and contains the basic "exists at all" context.
+
There are a number of error reply types, all of which are denoted by
having bit 31 set. All error replies MAY have some data set, in which
case that data is an error message string suitable for display to the =
user.
@@ -938,15 +991,48 @@ case that data is an error message string suitable =
for display to the user.

...

+##### Metadata contexts
+

We're missing some explanation as to what these 'metadata contexts'
things actually are. I suggest:

A metadata context represents metadata concerning the selected
export in the form of a list of extents, each with a status. The
meaning of the metadata and the status is dependent upon the
context. Each metadata context has a name which is colon separated,
in the form '<namespace>:<name>'. Namespaces that start with "X-"
are vendor dependent extensions. The 'BASE' namespace represents
metadata contexts defined within this document. Other namespaces
may be registered by reference within this document.

+The "BASE:allocation"=20

Backticks: `BASE:allocation`

+ metadata context is the basic "exists at all" metadata context.

Disagree. You're saying that if a server supports metadata contexts
at all, it must support this one. Why? It might just want to do the
backup thing. There's no reason to make this compulsory.

+If an extent is marked with `NBD_STATE_HOLE` at that
+context, this means that the given extent is not allocated in the
+backend storage, and that writing to the extent MAY result in the =
ENOSPC
+error. This supports sparse file semantics on the server side. If a
+server has only one metadata context (the default), then writing to an
+extent which has `NBD_STATE_HOLE` clear MUST NOT fail with ENOSPC.

I don't understand the purpose of the last sentence here. If a server
does not support the 'BASE:allocation' metadata context then writing
to any extent can fail with ENOSPC. What's the significance of having
exactly one metadata context?

I think the last sentence is probably meant to read something like:

If a server supports the "BASE:allocation" metadata context, then
writing to an extent which has `NBD_STATE_HOLE` clear MUST NOT fail
with ENOSPC.

+For all other cases, this specification requires no specific semantics
+of metadata contexts. Implementations could support metadata
+contexts with semantics like the following:
+
+- Incremental snapshots; if a block is allocated in one metadata
+  context, that implies that it is also allocated in the next level up.
+- Various bits of data about the backend of the storage; e.g., if the
+  storage is written on a RAID array, a metadata context could
+  return information about the redundancy level of a given extent
+- If the backend implements a write-through cache of some sort, or
+  synchronises with other servers, a metadata context could state
+  that an extent is "active" once it has reached permanent storage
+  and/or is synchronized with other servers.
+
+The only requirement of a metadata context is that it MUST be
+representable with the flags as defined for `NBD_CMD_BLOCK_STATUS`.
+
+Likewise, the syntax of query strings is not specified by this =
document.
+
+Server implementations SHOULD document their syntax for query strings
+and semantics for resulting metadata contexts in a document like this
+one.

This will need slightly tweaking with the namespace thing. Happy to
have a go if that works.

+
### Transmission phase

#### Flag fields
@@ -983,6 +1069,9 @@ valid may depend on negotiation during the =
handshake phase.
   content chunk in reply.  MUST NOT be set unless the transmission
   flags include `NBD_FLAG_SEND_DF`.  Use of this flag MAY trigger an
   `EOVERFLOW` error chunk, if the request length is too large.
+- bit 3, `NBD_CMD_FLAG_REQ_ONE`; valid during `NBD_CMD_BLOCK_STATUS`. =
If
+  set, the client is interested in only one extent per metadata
+  context.

##### Structured reply flags

@@ -1051,6 +1140,10 @@ interpret the "length" bytes of payload.
  64 bits: offset (unsigned) =20
  32 bits: hole size (unsigned, MUST be nonzero) =20

+- `NBD_REPLY_TYPE_BLOCK_STATUS` (5)
+
+  Defined by the experimental extension `BLOCK_STATUS`; see below.
+
All error chunk types have bit 15 set, and begin with the same
*error*, *message length*, and optional *message* fields as
`NBD_REPLY_TYPE_ERROR`.  If non-zero, *message length* indicates
@@ -1085,7 +1178,7 @@ remaining structured fields at the end.
  were sent earlier in the structured reply, the server SHOULD NOT
  send multiple distinct offsets that lie within the bounds of a
  single content chunk.  Valid as a reply to `NBD_CMD_READ`,
-  `NBD_CMD_WRITE`, and `NBD_CMD_TRIM`.
+  `NBD_CMD_WRITE`, `NBD_CMD_TRIM`, and `NBD_CMD_BLOCK_STATUS`.

  The payload is structured as:

@@ -1259,6 +1352,11 @@ The following request types exist:

    Defined by the experimental `WRITE_ZEROES` =
[extension](https://github.com/NetworkBlockDevice/nbd/blob/extension-write=
-zeroes/doc/proto.md).

+* `NBD_CMD_BLOCK_STATUS` (7)
+
+    Defined by the experimental `BLOCK_STATUS` extension; see below.

This is wrong, because the way we document extensions is that in the =
branch,
it's as if the relevant extension is no longer experimental. So remove
'experimental'.

+
* Other requests

    Some third-party implementations may require additional protocol
@@ -1345,6 +1443,148 @@ written as branches which can be merged into =
master if and
when those extensions are promoted to the normative version
of the document in the master branch.

+### `BLOCK_STATUS` extension
+
+With the availability of sparse storage formats, it is often needed to
+query the status of a particular range and read only those blocks of
+data that are actually present on the block device.
+
+Some storage formats and operations over such formats express a
+concept of data dirtiness. Whether the operation is block device
+mirroring, incremental block device backup or any other operation with
+a concept of data dirtiness, they all share a need to provide a list
+of ranges that this particular operation treats as dirty.
+
+To provide such class of information, the `BLOCK_STATUS` extension
+adds a new `NBD_CMD_BLOCK_STATUS` command which returns a list of
+ranges with their respective states.  This extension is not available
+unless the client also negotiates the `STRUCTURED_REPLY` extension.

'unless the client and server negotiate'

+
+* `NBD_REPLY_TYPE_BLOCK_STATUS`
+
+    *length* MUST be 4 + (a positive integer multiple of 8).  This =
reply
+    represents a series of consecutive block descriptors where the sum
+    of the lengths of the descriptors MUST not be greater than the
+    length of the original request.

I'm a bit unhappy with this. The way structured replies work, the
length of the replies is meant to add up to the lengh requested. I
think implementations might write a reply processor and want to assume
this. I know that the idea here is that the server can effectively
'give up' sending stuff - though with structured replies to be honest
that's less of an issue. If we really need this ability, why not
allow the server to send a final chunk that's in "don't know" state?

+ This chunk type MUST appear at most
+    once per metadata ID in a structured reply. Valid as a reply to
+    `NBD_CMD_BLOCK_STATUS`.
+
+    Servers MUST return an `NBD_REPLY_TYPE_BLOCK_STATUS` chunk for =
every
+    metadata context ID, except if the semantics of particular
+    metadata contexts mean that the information for one active metadata
+    context is implied by the information for another; e.g., if a
+    particular metadata context can only have meaning for extents where
+    the `NBD_STATE_HOLE` flag is cleared on the "BASE:allocation"
+    context, servers MAY omit the relevant chunks for that context if
+    they already sent an extent with the `NBD_STATE_HOLE` flag set in
+    reply to the same `NBD_CMD_BLOCK_STATUS` command.
+
+    The payload starts with:
+
+        * 32 bits, metadata context ID
+
+    and is followed by a list of one or more descriptors, each with =
this
+    layout:
+
+        * 32 bits, length (unsigned, MUST NOT be zero)
+        * 32 bits, status flags
+
+    If the client used the `NBD_CMD_FLAG_REQ_ONE` flag in the request,
+    then every reply chunk MUST NOT contain more than one descriptor.

Given you've defined length as '4+(a positive multiple of 8)'
this suggests that you mean 'exactly one' here. One of those
is wrong.

+    Even if the client did not use the `NBD_CMD_FLAG_REQ_ONE` flag in
+    its request, the server MAY return less descriptors in the reply

s/less/fewer/

+    than would be required to fully specify the whole range of =
requested
+    information to the client, if the number of descriptors would be
+    over 16 otherwise and looking up the information would be too
+    resource-intensive for the server.

Seems a bit odd we permit this sort of rate limiting but don't
e.g. rate-limit read.

+
+* `NBD_CMD_BLOCK_STATUS`
+
+    A block status query request. Length and offset define the range of
+    interest. Clients MUST NOT use this request unless metadata
+    contexts have been negotiated, which in turn requires the client to
+    first negotiate structured replies. For a successful return, the
+    server MUST use a structured reply, containing at least one chunk =
of
+    type `NBD_REPLY_TYPE_BLOCK_STATUS`.
+
+    The list of block status descriptors within the
+    `NBD_REPLY_TYPE_BLOCK_STATUS` chunk represent consecutive portions
+    of the file starting from specified *offset*, and the sum of the
+    *length* fields of each descriptor MUST not be greater than the
+    overall *length* of the request. This means that the server MAY
+    return less data than required. However the server MUST return at
+    least one status descriptor.  The server SHOULD use different
+    *status* values between consecutive descriptors,

Why? This seems like a needless restriction.

+     and SHOULD use
+    descriptor lengths that are an integer multiple of 512 bytes where
+    possible (the first and last descriptor of an unaligned query being
+    the most obvious places for an exception).

Why 512 bytes as opposed to 'minimum block size' (or is it because
that is also an experimental extension)?

+  The status flags are
+    intentionally defined so that a server MAY always safely report a
+    status of 0 for any block, although the server SHOULD return
+    additional status values when they can be easily detected.
+
+    If an error occurs, the server SHOULD set the appropriate error
+    code in the error field of either a simple reply or an error
+    chunk.

We should probably point out that you can return an error half way
through - that being the point of structured replies.

+  However, if the error does not involve invalid usage (such
+    as a request beyond the bounds of the file), a server MAY reply
+    with a single block status descriptor with *length* matching the
+    requested length, and *status* of 0 rather than reporting the
+    error.

Wht's the point of this? This appears to say that a server can lie
and return everything as not a hole, and not zero! Surely we're
already covered from the DoS angle?

+    Upon receiving an `NBD_CMD_BLOCK_STATUS` command, the server MUST
+    return the status of the device,

status of the metadata context

+ where the status field of each
+    descriptor is determined by the following bits (all combinations of
+    these bits are possible):

In my mind these status bits are defined entirely by the metadata
context, and the definitions below apply only to `BASE:allocation`

+
+      - `NBD_STATE_HOLE` (bit 0): if set, the block represents a hole
+        (and future writes to that area may cause fragmentation or
+        encounter an `ENOSPC` error); if clear, the block is allocated
+        or the server could not otherwise determine its status.  Note
+        that the use of `NBD_CMD_TRIM` is related to this status, but
+        that the server MAY report a hole even where trim has not been
+        requested, and also that a server MAY report metadata even
+        where a trim has been requested.
+      - `NBD_STATE_ZERO` (bit 1): if set, the block contents read as
+        all zeroes; if clear, the block contents are not known.  Note
+        that the use of `NBD_CMD_WRITE_ZEROES` is related to this
+        status, but that the server MAY report zeroes even where write
+        zeroes has not been requested, and also that a server MAY
+        report unknown content even where write zeroes has been
+        requested.

So the above two are `BASE:allocation` only, but ...

+      - `NBD_STATE_CLEAN` (bit 2): if set, the block represents a
+        portion of the file that is still clean because it has not
+        been written; if clear, the block represents a portion of the
+        file that is dirty, or where the server could not otherwise
+        determine its status. The server MUST NOT set this bit for
+        the "BASE:allocation" context, where it has no meaning.
+      - `NBD_STATE_ACTIVE` (bit 3): if set, the block represents a
+        portion of the file that is "active" in the given metadata
+        context. The server MUST NOT set this bit for the
+        "BASE:allocation" context, where it has no meaning.
+
+    The exact semantics of what it means for a block to be "clean" or
+    "active" at a given metadata context is not defined by this
+    specification, except that the default in both cases should be to
+    clear the bit. That is, when the metadata context does not have
+    knowledge of the relevant status for the given extent, or when the
+    metadata context does not assign any meaning to it, the bits
+    should be cleared.

... all the above should go as these describe the QEMU incremental
backup thing, which we agreed, I think, not to describe here.

+
+    A client SHOULD NOT read from an area that has both =
`NBD_STATE_HOLE`
+    set and `NBD_STATE_ZERO` clear.

That makes no sense, as normal data has both these bits clear! This
also implies that to comply with this SHOULD, a client needs to
request block status before any read, which is ridiculous. This
should be dropped.

+
+A client MAY close the connection if it detects that the server has
+sent an invalid chunk (such as lengths in the
+`NBD_REPLY_TYPE_BLOCK_STATUS` not summing up to the requested length).

I agree with the above, but this goes counter to the text above allowing
the server to return lengths that do not sum to the requested length.
Also the expression we use elsewhere is 'terminates transmission'
for a close during the transmission phase.

+The server SHOULD return `EINVAL` if it receives a `BLOCK_STATUS`
+request including one or more sectors beyond the size of the device.
+
+The extension adds the following new command flag:
+
+- `NBD_CMD_FLAG_REQ_ONE`; valid during `NBD_CMD_BLOCK_STATUS`.
+  SHOULD be set to 1 if the client wants to request information for =
only
+  one extent per metadata context.
+

Already handled above - this is a duplication

## About this file

This file tries to document the NBD protocol as it is currently


--=20
Alex Bligh
