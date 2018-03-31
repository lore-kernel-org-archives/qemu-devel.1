Received: from eggs.gnu.org ([2001:4830:134:3::10]:51320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f2FcP-0006Om-7X
	for qemu-devel@nongnu.org; Sat, 31 Mar 2018 08:28:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f2FcN-00024H-Iv
	for qemu-devel@nongnu.org; Sat, 31 Mar 2018 08:28:25 -0400
From: Eric Blake <eblake@redhat.com>
Date: Sat, 31 Mar 2018 07:28:14 -0500
Message-Id: <20180331122814.1954326-1-eblake@redhat.com>
In-Reply-To: <815919ea-1087-9567-9b81-d445aeacb102@redhat.com>
References: <815919ea-1087-9567-9b81-d445aeacb102@redhat.com>
Subject: [Qemu-devel] [PATCH nbd] RFC: doc: Separate namespace from
 leaf-name for metadata contexts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: nbd@other.debian.org, vsementsov@virtuozzo.com, w@uter.be

During implementation of NBD_CMD_BLOCK_STATUS in qemu, it was
discovered that parsing for the colon that separates the namespace
from the leaf-name can get awkward; a slight tweak to the wire
layout produces something a little friendlier to manipulate.

Since NBD strings are capped at 4k each, 16 bits is sufficient
for string lengths rather than 32.  On the request (in
NBD_OPT_LIST_META_CONTEXT and NBD_OPT_SET_META_CONTEXT), the
client must send the length of both namespace and leaf-name, as
the client is bundling together one or more queries into a
single wire transaction.  On reply (NBD_REP_META_CONTEXT), each
context is sent as a separate wire transaction, and therefore
the header length is sufficient to reconstruct the leaf-name
length without having to redundantly send that.

Since there is a known implementation of a prior description
of experimental block status in the wild (Virtuozzo, which used
SET but not LIST), this spec change also bumps the value of
NBD_OPT_SET_META_CONTEXT; that way, a mismatch between
experimental build and the layout documented here will fail to
negotiate meta contexts due to a difference in values, rather
than confusing one another with different layout expectations.

Signed-off-by: Eric Blake <eblake@redhat.com>
---

As mentioned in the cover letter, this has to go in at the same
time as the corresponding qemu patch, and prior to the qemu 2.12
release, if we like it.  Or we can ignore it.

 doc/proto.md | 78 +++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 46 insertions(+), 32 deletions(-)

diff --git a/doc/proto.md b/doc/proto.md
index 3abcf67..0e00d74 100644
--- a/doc/proto.md
+++ b/doc/proto.md
@@ -876,12 +876,13 @@ The reply to the `NBD_CMD_BLOCK_STATUS` request MUST be sent as a
 structured reply; this implies that in order to use metadata querying,
 structured replies MUST be negotiated first.

-Metadata contexts are identified by their names. The name MUST
-consist of a namespace, followed by a colon, followed by a leaf-name.
+Metadata contexts are identified by a namespace combined with a leaf-name.
 The namespace must consist entirely of printable non-whitespace
-UTF-8 characters other than colons, and be non-empty. The entire name
-(namespace, colon, and leaf-name) MUST follow the restrictions for
-strings as laid out earlier in this document.
+UTF-8 characters other than colons, and be non-empty. Both the namespace
+and leaf-name MUST follow the restrictions for
+strings as laid out earlier in this document.  For convenience, this
+document describes `namespace:leaf-name` as the name of a metadata
+context, even though the colon is not transmitted over the protocol.

 Namespaces MUST be consist of one of the following:
 - `base`, for metadata contexts defined by this document;
@@ -898,11 +899,11 @@ request to the mailing-list. The following additional third-party namespaces
 are currently registered:
 * (none)

-Save in respect of the `base:` namespace described below, this specification
+Save in respect of the `base` namespace described below, this specification
 requires no specific semantics of metadata contexts, except that all the
 information they provide MUST be representable within the flags field as
 defined for `NBD_REPLY_TYPE_BLOCK_STATUS`. Likewise, save in respect of
-the `base:` namespace, the syntax of query strings is not specified by this
+the `base` namespace, the syntax of query strings is not specified by this
 document, other than the recommendation that the empty leaf-name makes
 sense as a wildcard for a client query during `NBD_OPT_LIST_META_CONTEXT`,
 but SHOULD NOT select any contexts during `NBD_OPT_SET_META_CONTEXT`.
@@ -911,22 +912,22 @@ Server implementations SHOULD ensure the syntax for query strings they
 support and semantics for resulting metadata context is documented similarly
 to this document.

-### The `base:` metadata namespace
+### The `base` metadata namespace

-This standard defines exactly one metadata context; it is called
-`base:allocation`, and it provides information on the basic allocation
+This standard defines exactly one namespace, `base`, currently containing
+only one metadata context, `base:allocation`.  It provides information on the basic allocation
 status of extents (that is, whether they are allocated at all in a
 sparse file context).

-The query string within the `base:` metadata context can take
+The leaf-name portion of a query against the `base` namespace can take
 one of two forms:
-* `base:` - the server MUST ignore this form during
+* length 0 - the server MUST ignore this form during
   `NBD_OPT_SET_META_CONTEXT`, and MUST support this as a wildcard during
   `NBD_OPT_LIST_META_CONTEXT`, in which case the server's reply will
   contain a response for each supported metadata context within the
-  `base:` namespace (currently just `base:allocation`, although a
+  `base` namespace (currently just `base:allocation`, although a
   future revision of the standard might return multiple contexts); or
-* `base:[leaf-name]` to select `[leaf-name]` as a context leaf-name
+* non-empty string - select a context leaf-name
   that might exist within the `base` namespace.  If a `[leaf-name]`
   requested by the client is not recognized, the server MUST ignore
   it rather than report an error.
@@ -1297,15 +1298,15 @@ of the newstyle negotiation.
       contexts.
     - 32 bits, number of queries
     - Zero or more queries, each being:
-       - 32 bits, length of query.
-       - String, query to list a subset of the available metadata
-         contexts.  The syntax of this query is
-         implementation-defined, except that it MUST start with a
-         namespace and a colon.
+       - 16 bits, length of namespace (MUST be nonzero).
+       - String, namespace to select from.
+       - 16 bits, length of leaf-name (MAY be zero).
+       - String, leaf-name query. The syntax of this query is
+         implementation-defined according to the namespace.

-    For details on the query string, see the "Metadata querying"
+    For details on the namespace and query strings, see the "Metadata querying"
     section; note that a namespace may document that a different set
-    of queries are valid for `NBD_OPT_LIST_META_CONTEXT` than for
+    of leaf-name queries are valid for `NBD_OPT_LIST_META_CONTEXT` than for
     `NBD_OPT_SET_META_CONTEXT`, such as when using an empty
     leaf-name for wildcarding.

@@ -1313,8 +1314,7 @@ of the newstyle negotiation.
     length that would require reading beyond the original length given
     in the option header), the server MUST fail the request with
     `NBD_REP_ERR_INVALID`.  For requests that are semantically invalid
-    (such as lacking the required colon that delimits the namespace,
-    or using a leaf name that is invalid for a known namespace), the
+    (such as using a leaf name that is invalid for a known namespace), the
     server MAY fail the request with `NBD_REP_ERR_INVALID`.  However,
     the server MUST ignore query strings belonging to an unknown
     namespace.  If none of the query strings find any metadata
@@ -1359,16 +1359,15 @@ of the newstyle negotiation.
     'x-FooBar:') or with a range of values (e.g.
     'x-ModifiedDate:20160310-20161214'). The semantics of
     such a reply are a matter for the definition of the
-    namespace. However each namespace returned MUST begin
-    with the relevant namespace, followed by a colon, and then
-    other UTF-8 characters, with the entire string following the
+    namespace. However each returned context must include the
+    namespace, and the leaf-name must match
     restrictions for strings set out earlier in this
     document.

     The metadata context ID in these replies is reserved and SHOULD be
     set to zero; clients MUST disregard it.

-* `NBD_OPT_SET_META_CONTEXT` (10)
+* `NBD_OPT_SET_META_CONTEXT` (11)

     Change the set of active metadata contexts. Issuing this command
     replaces all previously-set metadata contexts (including when this
@@ -1393,10 +1392,11 @@ of the newstyle negotiation.
       contexts.
     - 32 bits, number of queries
     - Zero or more queries, each being:
-       - 32 bits, length of query
-       - String, query to select metadata contexts. The syntax of this
-         query is implementation-defined, except that it MUST start with a
-         namespace and a colon.
+       - 16 bits, length of namespace (MUST be nonzero).
+       - String, namespace to select from.
+       - 16 bits, length of leaf-name (SHOULD be nonzero).
+       - String, leaf-name query. The syntax of this query is
+         implementation-defined according to the namespace.

     If zero queries are sent, the server MUST select no metadata contexts.

@@ -1415,6 +1415,17 @@ of the newstyle negotiation.
     context, provided the client then does not attempt to issue
     `NBD_CMD_BLOCK_STATUS` commands.

+* Other requests
+
+    Some third-party implementations have experimented with additional
+    options not described in this document. In the interest of
+    interoperability, authors of such implementations SHOULD contact the
+    maintainer of this document, so that these messages can be listed here
+    to avoid conflicting implementations.
+
+    Currently one such message is known: `NBD_OPT_OLD_META_CONTEXT`, with
+    a value of 10, implemented by Virtuozzo.
+
 #### Option reply types

 These values are used in the "reply type" field, sent by the server
@@ -1584,7 +1595,10 @@ during option haggling in the fixed newstyle negotiation.
     A description of a metadata context. Data:

     - 32 bits, NBD metadata context ID.
-    - String, name of the metadata context. This is not required to be
+    - 16 bits, namespace length (MUST be nonzero)
+    - String, the namespace of the metadata context.
+    - String (length computed from length given in header minus 6 minus
+      the namespace length), the selected metadata leaf-name. This is not required to be
       a human-readable string, but it MUST be valid UTF-8 data.

 There are a number of error reply types, all of which are denoted by
-- 
2.14.3
