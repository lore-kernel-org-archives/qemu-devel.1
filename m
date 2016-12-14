Received: from eggs.gnu.org ([2001:4830:134:3::10]:56860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cHBAr-0004Pq-Bv
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:09:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cHBAp-0003Gd-6l
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:08:53 -0500
Received: from mail.avalus.com ([2001:41c8:10:1dd::10]:45524)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cHBAo-0003G8-S8
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:08:51 -0500
From: Alex Bligh <alex@alex.org.uk>
Date: Wed, 14 Dec 2016 15:08:40 +0000
Message-Id: <20161214150840.10899-1-alex@alex.org.uk>
Subject: [Qemu-devel] [PATCH] Further tidy-up on block status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wouter Verheist <w@uter.be>, nbd-general@lists.sourceforge.net
Cc: Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, stefanha@redhat.com, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, Pavel Borzenkov <pborzenkov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Pargmann <mpa@pengutronix.de>, "Denis V . Lunev" <den@openvz.org>, Alex Bligh <alex@alex.org.uk>

(NB: I've already applied this and pushed it)

* Change NBD_OPT_LIST_METADATA etc. to explicitly send a list of queries
  and add a count of queries so we can extend the command later (rather than
  rely on the length of option)

* For NBD_OPT_LIST_METADATA make absence of any query (as opposed to zero
  length query) list all contexts, as absence of any query is now simple.

* Move definition of namespaces in the document to somewhere more appopriate.

* Various other minor changes as discussed on the mailing list

Signed-off-by: Alex Bligh <alex@alex.org.uk>
---
 doc/proto.md | 179 +++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 112 insertions(+), 67 deletions(-)

diff --git a/doc/proto.md b/doc/proto.md
index e03f434..6955c76 100644
--- a/doc/proto.md
+++ b/doc/proto.md
@@ -683,15 +683,20 @@ by other users, so has been moved out of the "experimental" section.
 
 ## Metadata querying
 
-With the availability of sparse storage formats, it is often needed to
-query the status of a particular range and read only those blocks of
-data that are actually present on the block device.
+It is often helpful for the client to be able to query the status
+of a range of blocks. The nature of the status that can be
+queried is in part implementation dependent. For instance,
+the status might represent:
 
-Some storage formats and operations over such formats express a
-concept of data dirtiness. Whether the operation is block device
-mirroring, incremental block device backup or any other operation with
-a concept of data dirtiness, they all share a need to provide a list
-of ranges that this particular operation treats as dirty.
+* in a sparse storage format, whether the relevant blocks are
+  actually present on the backing device for the export; or
+
+* whether the relevant blocks are 'dirty'; some storage formats
+  and operations over such formats express a concept of data dirtiness.
+  Whether the operation is block device mirroring, incremental block
+  device backup or any other operation with a concept of data dirtiness,
+  they all share a need to provide a list of ranges that this
+  particular operation treats as dirty.
 
 To provide such classes of information, the NBD protocol has a generic
 framework for querying metadata; however, its use must first be
@@ -699,9 +704,11 @@ negotiated, and one or more metadata contexts must be selected.
 
 The procedure works as follows:
 
-- First, during negotiation, the client MUST select one or more metadata
+- First, during negotiation, if the client wishes to query metadata
+  during transmission, the client MUST select one or more metadata
   contexts with the `NBD_OPT_SET_META_CONTEXT` command. If needed, the client
-  can use `NBD_OPT_LIST_META_CONTEXT` to list contexts.
+  can use `NBD_OPT_LIST_META_CONTEXT` to list contexts that the server
+  supports.
 - During transmission, a client can then indicate interest in metadata
   for a given region by way of the `NBD_CMD_BLOCK_STATUS` command, where
   *offset* and *length* indicate the area of interest. The server MUST
@@ -715,13 +722,37 @@ The procedure works as follows:
   of type `NBD_REPLY_TYPE_BLOCK_STATUS`.
 
 A client MUST NOT use `NBD_CMD_BLOCK_STATUS` unless it selected a
-nonzero number of metadata contexts during negotiation. Servers SHOULD
-reply to clients doing so anyway with `EINVAL`.
+non-zero number of metadata contexts during negotiation. Servers SHOULD
+reply to clients sending `NBD_CMD_BLOCK_STATUS without
+selecting metadata contexts with `EINVAL`.
 
-The reply to the `NBD_CMD_BLOCK_STATUS` request MUST be sent by a
+The reply to the `NBD_CMD_BLOCK_STATUS` request MUST be sent as a
 structured reply; this implies that in order to use metadata querying,
 structured replies MUST be negotiated first.
 
+Metadata contexts are identified by their names. The name MUST
+consist of a namespace, followed by a colon, followed by a leaf-name.
+The namespace and the leaf-name must each consist entirely of
+printable non-whitespace UTF-8 characters other than colons,
+and be non-empty. The entire name (namespace, colon and leaf-name)
+MUST NOT exceed 255 bytes (and therefore botht he namespace and
+leaf-name are guaranteed to be smaller than 255 bytes).
+
+Namespaces MUST be consist of one of the following:
+- `base`, for metadata contexts defined by this document;
+- `nbd-server`, for metadata contexts defined by the
+   implementation that accompanies this document (none
+   currently);
+- `x-*`, where `*` can be replaced by any random string not
+   containing colons, for local experiments. This SHOULD NOT be
+   used by metadata contexts that are expected to be widely used.
+- A third-party namespace from the list below.
+
+Third-party implementations can register additional namespaces by simple
+request to the mailing-list. The following additional third-party namespaces
+are currently registered:
+* (none)
+
 This standard defines exactly one metadata context; it is called
 `base:allocation`, and it provides information on the basic allocation
 status of extents (that is, whether they are allocated at all in a
@@ -918,9 +949,7 @@ of the newstyle negotiation.
 - `NBD_OPT_LIST_META_CONTEXT` (10)
 
     Return a list of `NBD_REP_META_CONTEXT` replies, one per context,
-    followed by an `NBD_REP_ACK`. If a server replies to such a request
-    with no error message, clients MAY send NBD_CMD_BLOCK_STATUS
-    commands during the transmission phase.
+    followed by an `NBD_REP_ACK`.
 
     If the query string is syntactically invalid, the server SHOULD send
     `NBD_REP_ERR_INVALID`. If the query string is syntactically valid
@@ -932,51 +961,58 @@ of the newstyle negotiation.
     SHOULD send `NBD_REP_ERR_INVALID`.
 
     Data:
-    - 32 bits, length of export name
-    - String, name of export for which we wish to list or select metadata
+    - 32 bits, length of export name.
+    - String, name of export for which we wish to list metadata
       contexts.
-    - 32 bits, length of query
-    - String, query to select a subset of the available metadata
-      contexts. If this is not specified (i.e., the "length of query"
-      field is 0 and no query is sent), then the server MUST send all
-      the metadata contexts it knows about. If specified, this query
-      string MUST start with a name that uniquely identifies a server
-      implementation; e.g., the reference implementation that
-      accompanies this document would support query strings starting
-      with 'nbd-server:'
-
-    The server MUST reply with a list of `NBD_REP_META_CONTEXT` replies,
-    followed by `NBD_REP_ACK`. The metadata context ID in these replies
-    is reserved and SHOULD be set to zero; clients SHOULD disregard it.
+    - 32 bits, number of queries
+    - Zero or more queries, each being:
+       - 32 bits, length of query.
+       - String, query to list a subset of the available metadata
+         contexts.
+
+    If zero queries are sent, then the server MUST return all
+    the metadata contexts it knows about.
+
+    For details on the query string, see under `NBD_OPT_SET_META_CONTEXT`.
+
+    The server MUST either reply with an error (for instance `EINVAL`
+    if the option is not supported), or reply with a list of
+    `NBD_REP_META_CONTEXT` replies followed by `NBD_REP_ACK`.
+    The metadata context ID in these replies is reserved and SHOULD be
+    set to zero; clients MUST disregard it.
 
 - `NBD_OPT_SET_META_CONTEXT` (11)
 
     Change the set of active metadata contexts. Issuing this command
     replaces all previously-set metadata contexts; clients must ensure
-    that all metadata contexts they're interested in are selected with
+    that all metadata contexts they are interested in are selected with
     the final query that they sent.
 
+    A client MUST NOT send `NBD_CMD_BLOCK_STATUS` unless
+    within the negotiation phase it sent `NBD_OPT_SET_META_CONTEXT`
+    at least once, and the final time it was sent, the server
+    responded without an error, and returned at least one metadata
+    context.
+
     Data:
-    - 32 bits, length of query
-    - String, query to select metadata contexts. The syntax of this
-      query is implementation-defined, except that it MUST start with a
-      namespace. This namespace may be one of the following:
-        - `base:`, for metadata contexts defined by this document;
-        - `nbd-server:`, for metadata contexts defined by the
-          implementation that accompanies this document (none
-          currently);
-        - `x-*:`, where `*` can be replaced by any random string not
-          containing colons, for local experiments. This SHOULD NOT be
-          used by metadata contexts that are expected to be widely used.
-        - third-party implementations can register additional
-          namespaces by simple request to the mailinglist.
-
-    These two fields MAY be repeated as much as is necessary to select all
-    metadata contexts the client is interested in.
+    - 32 bits, length of export name.
+    - String, name of export for which we wish to list metadata
+      contexts.
+    - 32 bits, number of queries
+    - Zero or more queries, each being:
+       - 32 bits, length of query
+       - String, query to select metadata contexts. The syntax of this
+         query is implementation-defined, except that it MUST start with a
+         namespace and a colon.
+
+    If zero queries are sent, the server MUST select no metadata contexts.
 
     The server MUST reply with a number of `NBD_REP_META_CONTEXT`
     replies, one for each selected metadata context, each with a unique
-    metadata context ID. It is not an error if a
+    metadata context ID, followed by `NBD_REP_ACK`. The metadata context
+    ID is transient and may vary across calls to `NBD_OPT_SET_META_CONTEXT`;
+    clients MUST therefore treat the ID as an opaque value and not (for
+    instance) cache it between connections. It is not an error if a
     `NBD_OPT_SET_META_CONTEXT` option does not select any metadata
     context, provided the client then does not attempt to issue
     `NBD_CMD_BLOCK_STATUS` commands.
@@ -1071,9 +1107,10 @@ The `base:allocation` metadata context is the basic "allocated at all"
 metadata context. If an extent is marked with `NBD_STATE_HOLE` at that
 context, this means that the given extent is not allocated in the
 backend storage, and that writing to the extent MAY result in the ENOSPC
-error. This supports sparse file semantics on the server side. If a
-server has only one metadata context (the default), then writing to an
-extent which has `NBD_STATE_HOLE` clear MUST NOT fail with ENOSPC.
+error. This supports sparse file semantics on the server side.
+If a server supports the `base:allocation` metadata context, then writing
+to an extent which has `NBD_STATE_HOLE` clear MUST NOT fail with ENOSPC
+unless for reasons specified in the definition of another context.
 
 It defines the following flags for the flags field:
 
@@ -1082,20 +1119,21 @@ It defines the following flags for the flags field:
   `ENOSPC` error); if clear, the block is allocated or the server could
   not otherwise determine its status. Note that the use of
   `NBD_CMD_TRIM` is related to this status, but that the server MAY
-  report a hole even where trim has not been requested, and also that a
-  server MAY report metadata even where a trim has been requested.
+  report a hole even where `NBD_CMD_TRIM` has not been requested, and
+  also that a server MAY report that the block is allocated even where
+  `NBD_CMD_TRIM` has been requested.
 - `NBD_STATE_ZERO` (bit 1): if set, the block contents read as all
   zeroes; if clear, the block contents are not known. Note that the use
   of `NBD_CMD_WRITE_ZEROES` is related to this status, but that the
-  server MAY report zeroes even where write zeroes has not been
+  server MAY report zeroes even where `NBD_CMD_WRITE_ZEROES` has not been
   requested, and also that a server MAY report unknown content even
-  where write zeroes has been requested.
+  where `NBD_CMD_WRITE_ZEROES` has been requested.
 
 It is not an error for a server to report that a region of the
 export has both `NBD_STATE_HOLE` set and `NBD_STATE_ZERO` clear. The
-contents of such an area is undefined, and may not be stable;
-clients who are aware of the existence of such a region SHOULD NOT
-read it.
+contents of such an area are undefined, and a client
+reading such an area should make no assumption as to its contents
+or stability.
 
 For the `base:allocation` context, the remainder of the flags field is
 reserved. Servers SHOULD set it to all-zero; clients MUST ignore unknown
@@ -1150,9 +1188,10 @@ valid may depend on negotiation during the handshake phase.
    `EOVERFLOW` error chunk, if the request length is too large.
 - bit 3, `NBD_CMD_FLAG_REQ_ONE`; valid during `NBD_CMD_BLOCK_STATUS`. If
   set, the client is interested in only one extent per metadata
-  context. If this flag is present, the server SHOULD NOT send metadata
-  on more than one extent in the reply. Clients SHOULD NOT use this flag
-  on multiple requests for successive regions in the export.
+  context. If this flag is present, the server MUST NOT send metadata
+  on more than one extent in the reply. Client implementors should note
+  that using this flag on multiple contiguous requests is likely to be
+  inefficient.
 
 ##### Structured reply flags
 
@@ -1225,7 +1264,7 @@ interpret the "length" bytes of payload.
 
     *length* MUST be 4 + (a positive integer multiple of 8).  This reply
     represents a series of consecutive block descriptors where the sum
-    of the lengths of the descriptors MUST not be greater than the
+    of the length fields within the descriptors MUST not be greater than the
     length of the original request. This chunk type MUST appear exactly
     once per metadata ID in a structured reply.
 
@@ -1236,14 +1275,15 @@ interpret the "length" bytes of payload.
     and is followed by a list of one or more descriptors, each with this
     layout:
 
-        * 32 bits, length (unsigned, MUST NOT be zero)
+        * 32 bits, length of the extent to which the status below
+          applies (unsigned, MUST be non-zero)
         * 32 bits, status flags
 
     If the client used the `NBD_CMD_FLAG_REQ_ONE` flag in the request,
     then every reply chunk MUST NOT contain more than one descriptor.
 
     Even if the client did not use the `NBD_CMD_FLAG_REQ_ONE` flag in
-    its request, the server MAY return less descriptors in the reply
+    its request, the server MAY return fewer descriptors in the reply
     than would be required to fully specify the whole range of requested
     information to the client, if looking up the information would be
     too resource-intensive for the server, so long as at least one
@@ -1462,8 +1502,13 @@ The following request types exist:
 * `NBD_CMD_BLOCK_STATUS` (7)
 
     A block status query request. Length and offset define the range of
-    interest. Clients MUST NOT use this request unless metadata
-    contexts have been negotiated, which in turn requires the client to
+    interest.
+
+    A client MUST NOT send `NBD_CMD_BLOCK_STATUS` unless
+    within the negotiation phase it sent `NBD_OPT_SET_META_CONTEXT`
+    at least once, and the final time it was sent, the server
+    responded without an error, and returned at least one metadata
+    context. This in turn requires the client to
     first negotiate structured replies. For a successful return, the
     server MUST use a structured reply, containing at least one chunk of
     type `NBD_REPLY_TYPE_BLOCK_STATUS`, where the status field of each
-- 
2.9.3 (Apple Git-75)
