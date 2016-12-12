Received: from eggs.gnu.org ([2001:4830:134:3::10]:47997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cGXRa-0007KU-VK
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 15:43:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cGXRX-0002qF-HL
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 15:43:30 -0500
Received: from [2a01:4f8:140:52e5::2] (port=35784 helo=latin.grep.be)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wouter@grep.be>) id 1cGXRX-0002q1-7J
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 15:43:27 -0500
Date: Mon, 12 Dec 2016 21:43:13 +0100
From: Wouter Verhelst <w@uter.be>
Message-ID: <20161212204313.anhjire2gkwd6gzi@grep.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6bqavr3djtr4db7w"
Content-Disposition: inline
Subject: [Qemu-devel] [Nbd] [PATCH v5] doc: Add NBD_CMD_BLOCK_STATUS
 extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Pavel Borzenkov <pborzenkov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Pargmann <mpa@pengutronix.de>, "Denis V. Lunev" <den@openvz.org>, John Snow <jsnow@redhat.com>


--6bqavr3djtr4db7w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

v4 -> v5:

- Editorial improvements as suggested by Eric (with the exception of
  absence/absense, which would really need to be done on master if valid)
- Rework so that the NBD_STATE_* constants are defined in the "Metadata
  contexts" section *only*, where the `base:allocation` context is
  defined. The other sections now define how to send and receive
  metadata in general, without going into any detail on what that
  metadata might be (which is not their concern).

diff --git a/doc/proto.md b/doc/proto.md
index c443494..526f71a 100644
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
+structured replies MUST be negotiated first.
+
+This standard defines exactly one metadata context; it is called
+`base:allocation`, and it provides information on the basic allocation
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
+    - String, name of export for which we wish to list or select metadata
+      contexts.
+    - 32 bits, length of query
+    - String, query to select a subset of the available metadata
+      contexts. If this is not specified (i.e., the "length of query"
+      field is 0 and no query is sent), then the server MUST send all
+      the metadata contexts it knows about. If specified, this query
+      string MUST start with a name that uniquely identifies a server
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
+    the final query that they sent.
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
@@ -938,15 +1053,62 @@ case that data is an error message string suitable f=
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
+It is not an error for a server to report that a region of the
+export has both `NBD_STATE_HOLE` set and `NBD_STATE_ZERO` clear. The
+contents of such an area is undefined, and may not be stable;
+clients who are aware of the existence of such a region SHOULD NOT
+read it.
+
+For the `base:allocation` context, the remainder of the flags field is
+reserved. Servers SHOULD set it to all-zero; clients MUST ignore unknown
+flags.
+
+For all other cases, this specification requires no specific semantics of
+metadata contexts, except that all the information they provide MUST be
+representable within the flags field as defined for
+`NBD_REPLY_TYPE_BLOCK_STATUS`.
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
@@ -983,6 +1145,11 @@ valid may depend on negotiation during the handshake =
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
@@ -1051,6 +1218,34 @@ interpret the "length" bytes of payload.
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
@@ -1085,7 +1280,7 @@ remaining structured fields at the end.
   were sent earlier in the structured reply, the server SHOULD NOT
   send multiple distinct offsets that lie within the bounds of a
   single content chunk.  Valid as a reply to `NBD_CMD_READ`,
-  `NBD_CMD_WRITE`, and `NBD_CMD_TRIM`.
+  `NBD_CMD_WRITE`, `NBD_CMD_TRIM`, and `NBD_CMD_BLOCK_STATUS`.
=20
   The payload is structured as:
=20
@@ -1259,6 +1454,44 @@ The following request types exist:
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
+    type `NBD_REPLY_TYPE_BLOCK_STATUS`, where the status field of each
+    descriptor is determined by the flags field as defined by the
+    metadata context.
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
+    code in the error field of an error chunk. However, if the error
+    does not involve invalid usage (such as a request beyond the bounds
+    of the file), a server MAY reply with a single block status
+    descriptor with *length* matching the requested length, and *status*
+    of 0 rather than reporting the error.
+
+    A client MAY initiate a hard disconnect if it detects that the
+    server has sent an invalid chunk. The server SHOULD return `EINVAL`
+    if it receives a `NBD_CMD_BLOCK_STATUS` request including one or
+    more sectors beyond the size of the device.
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

--6bqavr3djtr4db7w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEhzp22k7Yad9NSkS9wpQPlRvfCp0FAlhPC94ACgkQwpQPlRvf
Cp2KhA//SdWqGJltiIVRB0Dyrcol0g7mKptB/fEV5mCbSAThyXILS8e+w/+2M8Tv
XtwqgVicdu68Wgg6GsrCMdnfzzr0cdtns5cH5jtuowEwoxxs4gYARS5t5y+NdoSu
9qplpkITtZYVjEZDkCbqmanSZQAr83vBeo+UR048IeYxX/8KofZq8yAVgEnHejX/
dNBxyaeULkxOYZpUoI/kozauqTY+7FL63UPvODsI72VshRC7ptsEIFmOTjeSEMoX
wslCbz0/kb/JiVPg2+pqKuHA38tufKh2+pifeBOsEf3rHzt6cOYgbzlTLehWuxj7
adjcjTYJ7ba6yUpz7bUlKX0bWBU56chyPYJqmScXWrfDEMc734UzFls1njWU8+wH
Xdc3PzOTXUCQP7TzxfzdXvHfdgpF96u/tRxW+DxX9NmoAjz5RZhw4N/lnQ8PaIUY
MJH58t2lacJ3MhB03xXvCO4zqRcfVYZkSGwLPwpunj8J+u0Q0d9QT23iYCdssXfm
Nuq9swS0z0dTNQSa0rEQ7/21vTK2vdCutViU+Cww1RZBUIOi0Lcer7MCiwRH/Ofr
N8miQdIQa0z9AORVARF+4StPKYp86n56IgJKdZKPka1BBbFb1LMmWIPHmVVw7ks9
qfJV9Q30C0QMrHg+3Xd1c8sq0nVZ/6AslXSl8Y0HpSwWWBmCKdQ=
=AqEe
-----END PGP SIGNATURE-----

--6bqavr3djtr4db7w--
