Received: from eggs.gnu.org ([2001:4830:134:3::10]:41669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cGVEJ-000462-Nu
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 13:21:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cGVEE-0004GA-Sl
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 13:21:39 -0500
Received: from [2a01:4f8:140:52e5::2] (port=35606 helo=latin.grep.be)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wouter@grep.be>) id 1cGVEE-0004Ev-HU
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 13:21:34 -0500
Date: Mon, 12 Dec 2016 19:21:19 +0100
From: Wouter Verhelst <w@uter.be>
Message-ID: <20161212182119.dceppkzqb7gftsl5@grep.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gvohbgofdchu5s2e"
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH v4] doc: Add NBD_CMD_BLOCK_STATUS extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Bligh <alex@alex.org.uk>
Cc: Eric Blake <eblake@redhat.com>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Pavel Borzenkov <pborzenkov@virtuozzo.com>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Markus Pargmann <mpa@pengutronix.de>, John Snow <jsnow@redhat.com>


--gvohbgofdchu5s2e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

diff from v3 to v4:
- Remove some repetitive wording (some sections were written more than
  once);
- Rework the text to remove all lingering remains of the "extension"
  section that isn't being used anymore (the current version should
  therefore read much easier)
- Rename "BASE:allocation" to `base:allocation`;
- drop the "type" field in `NBD_OPT_META_CONTEXT`, replace it by
  `NBD_OPT_LIST_META_CONTEXT` and `NBD_OPT_SET_META_CONTEXT`, with semantics
  similar to `NBD_OPT_INFO` and `NBD_OPT_GO`;
- Add an export name to the `NBD_OPT_SET_META_CONTEXT` and
  `NBD_OPT_LIST_META_CONTEXT` options, since I can imagine that some
  metadata contexts might be export-specific;
- Various minor things too numerous to name here.

As a result, the patch from v3 to v4 (or even from whatever
extension-blockstatus was pointing to to v4) doesn't read very well. For
that reason, the output of "git diff
extension-structured-reply..extension-blockstatus" follows.

Note that I've also pushed my current version of the branch to the usual
place.

Comments?

diff --git a/doc/proto.md b/doc/proto.md
index c443494..5b48d25 100644
--- a/doc/proto.md
+++ b/doc/proto.md
@@ -681,6 +681,52 @@ This functionality has not yet been implemented by the=
 reference
 implementation, but was implemented by qemu and subsequently
 by other users, so has been moved out of the "experimental" section.
=20
+## Metadata querying
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
+To provide such classes of information, the NBD protocol has a generic
+framework for querying metadata; however, its use must first be
+negotiated, and one or more metadata contexts must be selected.
+
+The procedure works as follows:
+
+- First, during negotiation, the client MUST select one or more metadata
+  contexts with the `NBD_OPT_SET_META_CONTEXT` command. If needed, the cli=
ent
+  can use `NBD_OPT_LIST_META_CONTEXT` to list contexts.
+- During transmission, a client can then indicate interest in metadata
+  for a given region by way of the `NBD_CMD_BLOCK_STATUS` command, where
+  *offset* and *length* indicate the area of interest. The server MUST
+  then respond with the requested information, for all contexts which
+  were selected during negotiation. For every metadata context, the
+  server sends one set of extent chunks, where the sizes of the
+  extents MUST be less than or equal to the length as specified in the
+  request. Each extent comes with a *flags* field, the semantics of
+  which are defined by the metadata context.
+- A server MUST reply to `NBD_CMD_BLOCK_STATUS` with a structured reply
+  of type `NBD_REPLY_TYPE_BLOCK_STATUS`.
+
+A client MUST NOT use `NBD_CMD_BLOCK_STATUS` unless it selected a
+nonzero number of metadata contexts during negotiation. Servers SHOULD
+reply to clients doing so anyway with `EINVAL`.
+
+The reply to the `NBD_CMD_BLOCK_STATUS` request MUST be sent by a
+structured reply; this implies that in order to use metadata querying,
+structured replies MUST first be negotiated.
+
+This standard defines exactly one metadata context; it is called
+`base:allocation`, and it provided information on the basic allocation
+status of extents (that is, whether they are allocated at all in a
+sparse file context).
+
 ## Values
=20
 This section describes the value and meaning of constants (other than
@@ -768,8 +814,6 @@ The field has the following format:
   to that command to the client. In the absense of this flag, clients
   SHOULD NOT multiplex their commands over more than one connection to
   the export.
-- bit 9, `NBD_FLAG_SEND_BLOCK_STATUS`: defined by the experimental
-  `BLOCK_STATUS` [extension](https://github.com/NetworkBlockDevice/nbd/blo=
b/extension-blockstatus/doc/proto.md).
=20
 Clients SHOULD ignore unknown flags.
=20
@@ -871,6 +915,69 @@ of the newstyle negotiation.
=20
     Defined by the experimental `INFO` [extension](https://github.com/Netw=
orkBlockDevice/nbd/blob/extension-info/doc/proto.md).
=20
+- `NBD_OPT_LIST_META_CONTEXT` (10)
+
+    Return a list of `NBD_REP_META_CONTEXT` replies, one per context,
+    followed by an `NBD_REP_ACK`. If a server replies to such a request
+    with no error message, clients MAY send NBD_CMD_BLOCK_STATUS
+    commands during the transmission phase.
+
+    If the query string is syntactically invalid, the server SHOULD send
+    `NBD_REP_ERR_INVALID`. If the query string is syntactically valid
+    but finds no metadata contexts, the server MUST send a single
+    reply of type `NBD_REP_ACK`.
+
+    This option MUST NOT be requested unless structured replies have
+    been negotiated first. If a client attempts to do so, a server
+    SHOULD send `NBD_REP_ERR_INVALID`.
+
+    Data:
+    - 32 bits, length of export name
+    - String, name of export for which we wish to list, select, or
+      deselect, metadata contexts.
+    - 32 bits, length of query
+    - String, query to select a subset of the available metadata
+      contexts. If this is not specified (i.e., length is 4 and no
+      command is sent), then the server MUST send all the metadata
+      contexts it knows about. If specified, this query string MUST
+      start with a name that uniquely identifies a server
+      implementation; e.g., the reference implementation that
+      accompanies this document would support query strings starting
+      with 'nbd-server:'
+
+    The server MUST reply with a list of `NBD_REP_META_CONTEXT` replies,
+    followed by `NBD_REP_ACK`. The metadata context ID in these replies
+    is reserved and SHOULD be set to zero; clients SHOULD disregard it.
+
+- `NBD_OPT_SET_META_CONTEXT` (11)
+
+    Change the set of active metadata contexts. Issuing this command
+    replaces all previously-set metadata contexts; clients must ensure
+    that all metadata contexts they're interested in are selected with
+    the queries they sent.
+
+    Data:
+    - 32 bits, length of query
+    - String, query to select metadata contexts. The syntax of this
+      query is implementation-defined, except that it MUST start with a
+      namespace. This namespace may be one of the following:
+        - `base:`, for metadata contexts defined by this document;
+        - `nbd-server:`, for metadata contexts defined by the
+          implementation that accompanies this document (none
+          currently);
+        - `x-*:`, where `*` can be replaced by any random string not
+          containing colons, for local experiments. This SHOULD NOT be
+          used by metadata contexts that are expected to e widely used.
+        - third-party implementations can register additional
+          namespaces by simple request to the mailinglist.
+
+    The server MUST reply with a number of `NBD_REP_META_CONTEXT`
+    replies, one for each selected metadata context, each with a unique
+    metadata context ID. It is not an error if a
+    `NBD_OPT_SET_META_CONTEXT` option does not select any metadata
+    context, provided the client then does not attempt to issue
+    `NBD_CMD_BLOCK_STATUS` commands.
+
 #### Option reply types
=20
 These values are used in the "reply type" field, sent by the server
@@ -882,7 +989,7 @@ during option haggling in the fixed newstyle negotiatio=
n.
     information is available, or when sending data related to the option
     (in the case of `NBD_OPT_LIST`) has finished. No data.
=20
-* `NBD_REP_SERVER` (2)
+- `NBD_REP_SERVER` (2)
=20
     A description of an export. Data:
=20
@@ -897,10 +1004,18 @@ during option haggling in the fixed newstyle negotia=
tion.
       particular client request, this field is defined to be a string
       suitable for direct display to a human being.
=20
-* `NBD_REP_INFO` (3)
+- `NBD_REP_INFO` (3)
=20
     Defined by the experimental `INFO` [extension](https://github.com/Netw=
orkBlockDevice/nbd/blob/extension-info/doc/proto.md).
=20
+- `NBD_REP_META_CONTEXT` (4)
+
+    A description of a metadata context. Data:
+
+    - 32 bits, NBD metadata context ID.
+    - String, name of the metadata context. This is not required to be
+      a human-readable string, but it MUST be valid UTF-8 data.
+
 There are a number of error reply types, all of which are denoted by
 having bit 31 set. All error replies MAY have some data set, in which
 case that data is an error message string suitable for display to the user.
@@ -938,15 +1053,56 @@ case that data is an error message string suitable f=
or display to the user.
=20
     Defined by the experimental `INFO` [extension](https://github.com/Netw=
orkBlockDevice/nbd/blob/extension-info/doc/proto.md).
=20
-* `NBD_REP_ERR_SHUTDOWN` (2^32 + 7)
+* `NBD_REP_ERR_SHUTDOWN` (2^31 + 7)
=20
     The server is unwilling to continue negotiation as it is in the
     process of being shut down.
=20
-* `NBD_REP_ERR_BLOCK_SIZE_REQD` (2^32 + 8)
+* `NBD_REP_ERR_BLOCK_SIZE_REQD` (2^31 + 8)
=20
     Defined by the experimental `INFO` [extension](https://github.com/Netw=
orkBlockDevice/nbd/blob/extension-info/doc/proto.md).
=20
+##### Metadata contexts
+
+The `base:allocation` metadata context is the basic "allocated at all"
+metadata context. If an extent is marked with `NBD_STATE_HOLE` at that
+context, this means that the given extent is not allocated in the
+backend storage, and that writing to the extent MAY result in the ENOSPC
+error. This supports sparse file semantics on the server side. If a
+server has only one metadata context (the default), then writing to an
+extent which has `NBD_STATE_HOLE` clear MUST NOT fail with ENOSPC.
+
+It defines the following flags for the flags field:
+
+- `NBD_STATE_HOLE` (bit 0): if set, the block represents a hole (and
+  future writes to that area may cause fragmentation or encounter an
+  `ENOSPC` error); if clear, the block is allocated or the server could
+  not otherwise determine its status. Note that the use of
+  `NBD_CMD_TRIM` is related to this status, but that the server MAY
+  report a hole even where trim has not been requested, and also that a
+  server MAY report metadata even where a trim has been requested.
+- `NBD_STATE_ZERO` (bit 1): if set, the block contents read as all
+  zeroes; if clear, the block contents are not known. Note that the use
+  of `NBD_CMD_WRITE_ZEROES` is related to this status, but that the
+  server MAY report zeroes even where write zeroes has not been
+  requested, and also that a server MAY report unknown content even
+  where write zeroes has been requested.
+
+For the `base:allocation` context, the remainder of the flags field is
+reserved. Servers SHOULD set it to all-zero; clients MUST ignore unknown
+flags.
+
+For all other cases, this specification requires no specific semantics of
+metadata contexts, except that all the information they provide The only
+requirement of a metadata context is that it MUST be representable within =
the
+flags field as defined for `NBD_CMD_BLOCK_STATUS`.
+
+Likewise, the syntax of query strings is not specified by this document.
+
+Server implementations SHOULD document their syntax for query strings
+and semantics for resulting metadata contexts in a document like this
+one.
+
 ### Transmission phase
=20
 #### Flag fields
@@ -983,6 +1139,11 @@ valid may depend on negotiation during the handshake =
phase.
    content chunk in reply.  MUST NOT be set unless the transmission
    flags include `NBD_FLAG_SEND_DF`.  Use of this flag MAY trigger an
    `EOVERFLOW` error chunk, if the request length is too large.
+- bit 3, `NBD_CMD_FLAG_REQ_ONE`; valid during `NBD_CMD_BLOCK_STATUS`. If
+  set, the client is interested in only one extent per metadata
+  context. If this flag is present, the server SHOULD NOT send metadata
+  on more than one extent in the reply. Clients SHOULD NOT use this flag
+  on multiple requests for successive regions in the export.
=20
 ##### Structured reply flags
=20
@@ -1051,6 +1212,34 @@ interpret the "length" bytes of payload.
   64 bits: offset (unsigned) =20
   32 bits: hole size (unsigned, MUST be nonzero) =20
=20
+- `NBD_REPLY_TYPE_BLOCK_STATUS` (5)
+
+    *length* MUST be 4 + (a positive integer multiple of 8).  This reply
+    represents a series of consecutive block descriptors where the sum
+    of the lengths of the descriptors MUST not be greater than the
+    length of the original request. This chunk type MUST appear exactly
+    once per metadata ID in a structured reply.
+
+    The payload starts with:
+
+        * 32 bits, metadata context ID
+
+    and is followed by a list of one or more descriptors, each with this
+    layout:
+
+        * 32 bits, length (unsigned, MUST NOT be zero)
+        * 32 bits, status flags
+
+    If the client used the `NBD_CMD_FLAG_REQ_ONE` flag in the request,
+    then every reply chunk MUST NOT contain more than one descriptor.
+
+    Even if the client did not use the `NBD_CMD_FLAG_REQ_ONE` flag in
+    its request, the server MAY return less descriptors in the reply
+    than would be required to fully specify the whole range of requested
+    information to the client, if the number of descriptors would be
+    over 16 otherwise and looking up the information would be too
+    resource-intensive for the server.
+
 All error chunk types have bit 15 set, and begin with the same
 *error*, *message length*, and optional *message* fields as
 `NBD_REPLY_TYPE_ERROR`.  If non-zero, *message length* indicates
@@ -1085,7 +1274,7 @@ remaining structured fields at the end.
   were sent earlier in the structured reply, the server SHOULD NOT
   send multiple distinct offsets that lie within the bounds of a
   single content chunk.  Valid as a reply to `NBD_CMD_READ`,
-  `NBD_CMD_WRITE`, and `NBD_CMD_TRIM`.
+  `NBD_CMD_WRITE`, `NBD_CMD_TRIM`, and `NBD_CMD_BLOCK_STATUS`.
=20
   The payload is structured as:
=20
@@ -1259,6 +1448,79 @@ The following request types exist:
=20
     Defined by the experimental `WRITE_ZEROES` [extension](https://github.=
com/NetworkBlockDevice/nbd/blob/extension-write-zeroes/doc/proto.md).
=20
+* `NBD_CMD_BLOCK_STATUS` (7)
+
+    A block status query request. Length and offset define the range of
+    interest. Clients MUST NOT use this request unless metadata
+    contexts have been negotiated, which in turn requires the client to
+    first negotiate structured replies. For a successful return, the
+    server MUST use a structured reply, containing at least one chunk of
+    type `NBD_REPLY_TYPE_BLOCK_STATUS`.
+
+    The list of block status descriptors within the
+    `NBD_REPLY_TYPE_BLOCK_STATUS` chunk represent consecutive portions
+    of the file starting from specified *offset*, and the sum of the
+    *length* fields of each descriptor MUST not be greater than the
+    overall *length* of the request. This means that the server MAY
+    return less data than required. However the server MUST return at
+    least one status descriptor.  The server SHOULD use different
+    *status* values between consecutive descriptors, and SHOULD use
+    descriptor lengths that are an integer multiple of 512 bytes where
+    possible (the first and last descriptor of an unaligned query being
+    the most obvious places for an exception). The status flags are
+    intentionally defined so that a server MAY always safely report a
+    status of 0 for any block, although the server SHOULD return
+    additional status values when they can be easily detected.
+
+    If an error occurs, the server SHOULD set the appropriate error
+    code in the error field of either a simple reply or an error
+    chunk.  However, if the error does not involve invalid usage (such
+    as a request beyond the bounds of the file), a server MAY reply
+    with a single block status descriptor with *length* matching the
+    requested length, and *status* of 0 rather than reporting the
+    error.
+
+    Upon receiving an `NBD_CMD_BLOCK_STATUS` command, the server MUST
+    return the status of the device, where the status field of each
+    descriptor is determined by the following bits (all combinations of
+    these bits are possible):
+
+      - `NBD_STATE_HOLE` (bit 0): if set, the block represents a hole
+        (and future writes to that area may cause fragmentation or
+        encounter an `ENOSPC` error); if clear, the block is allocated
+        or the server could not otherwise determine its status.  Note
+        that the use of `NBD_CMD_TRIM` is related to this status, but
+        that the server MAY report a hole even where trim has not been
+        requested, and also that a server MAY report metadata even
+        where a trim has been requested. Additionally, clients should be
+        aware that servers may have no information on the storage
+        availability of an export; e.g., an export may be stored on a
+        sparsely-populated storage device itself, even if it doesn't
+        appear to be the case using regular system calls. As such, it is
+        not an error for a server to report an `ENOSPC` error on a
+        region of the file where the `base:allocation` context has
+        `NBD_STATE_HOLE` clear (although servers SHOULD attempt to avoid
+        this situation).
+      - `NBD_STATE_ZERO` (bit 1): if set, the block contents read as
+        all zeroes; if clear, the block contents are not known.  Note
+        that the use of `NBD_CMD_WRITE_ZEROES` is related to this
+        status, but that the server MAY report zeroes even where write
+        zeroes has not been requested, and also that a server MAY
+        report unknown content even where write zeroes has been
+        requested.
+
+    It is not an error for a server to report that a region of the
+    export has both `NBD_STATE_HOLE` set and `NBD_STATE_ZERO` clear. The
+    contents of such an area is undefined, and may not be stable;
+    clients who are aware of the existence of such a region SHOULD NOT
+    read it.
+
+A client MAY terminate the connection if it detects that the server has
+sent an invalid chunk (such as lengths in the
+`NBD_REPLY_TYPE_BLOCK_STATUS` not summing up to the requested length).
+The server SHOULD return `EINVAL` if it receives a `BLOCK_STATUS`
+request including one or more sectors beyond the size of the device.
+
 * Other requests
=20
     Some third-party implementations may require additional protocol

--=20
< ron> I mean, the main *practical* problem with C++, is there's like a doz=
en
       people in the world who think they really understand all of its rule=
s,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12

--gvohbgofdchu5s2e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEhzp22k7Yad9NSkS9wpQPlRvfCp0FAlhO6pAACgkQwpQPlRvf
Cp3I+hAA7Jn0pw3wfGHJiut9acmBYKdxOkw3uNr5QvDpHPf29wHwuBUf4YMxVN1/
kD+aaeU9X82cwulikdgOL5IpMTz4Ju3Q/SnXjUQNjNqlrRYDzKVuFZ08uJ4RSAHl
WfOELOvOQRMRH0z1oHSrKTFpA2tWvNUO8Px/vw8m1QBzuWzsQ0/9dTiGQ4KTlBB+
7dn6k3G9qX1YMOyOsht0ta4GOMA/GWEMVQ+S6k5Al77Mp88xY62CCYu1qpGTCyU8
BwuL/qYbNdn7GYLvAeLzZ/E4BTifvQsaR1sUh3RsEgOquWMs8WGrucUCkw8U527j
wCWIqed+hrUi6cUD26NhEwzeeFkEadupPIEoFxbkabkGOmnQLP2CMXYDsXB+l+Qz
Y9mhiWWALUIQ0IrSBu/9hePPMHouK5EOfLcw0zTtyZXDhjqHmvTkrhR9cuwBRfFn
zD5ZHdZtCT4p/PNltcYp+04EkAIbc6vRt0OZyecGb8cEm1jF+UtaC+BM0uPdbtkk
ZANEayxURqUVBeSC+nLryX6gsAAzBUlcRn7jQPRw+kpM/5fYpPvmGjcFYUPoIDsT
hKxlE6FhcKVpMv+N43mZUZUBOrhqeVWg7UHGRM/0rgnDafHZ4gPuiGfzJbdf0yjB
o1dGD6l2s8OSMin8A52GdDKABGe42ZJ9yfxqpACyLJWG6eIp2QE=
=GRYi
-----END PGP SIGNATURE-----

--gvohbgofdchu5s2e--
