Received: from eggs.gnu.org ([2001:4830:134:3::10]:59148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cHEef-00082k-OF
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 13:51:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cHEee-0004uY-Rn
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 13:51:53 -0500
Received: from mail.avalus.com ([2001:41c8:10:1dd::10]:52532)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cHEee-0004uU-GT
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 13:51:52 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <D71CECFD-E513-4372-BB54-BF8D8D521292@alex.org.uk>
Date: Wed, 14 Dec 2016 18:51:48 +0000
Content-Transfer-Encoding: 7bit
Message-Id: <3D392E31-DDA4-4316-B26D-871E94A83935@alex.org.uk>
References: <20161214150840.10899-1-alex@alex.org.uk>
	<31576d46-c0ed-29b9-71a0-5aca1790799a@virtuozzo.com>
	<6D1B30FC-FD7E-474C-A8E3-FD87E7AA1364@alex.org.uk>
	<5e9150ed-2127-f2e8-f9db-a514e8f0ddf8@virtuozzo.com>
	<5E697C22-5FBB-49A2-A018-A6B96E29FE84@alex.org.uk>
	<94ef3ef2-b76f-fa5d-cbaf-8990ce2b1be8@virtuozzo.com>
	<20161214181323.mehzfmlf6z4pyajp@grep.be>
	<D71CECFD-E513-4372-BB54-BF8D8D521292@alex.org.uk>
Subject: Re: [Qemu-devel] [Nbd] [PATCH] Further tidy-up on block status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wouter Verhelst <w@uter.be>
Cc: Alex Bligh <alex@alex.org.uk>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>


> On 14 Dec 2016, at 18:18, Alex Bligh <alex@alex.org.uk> wrote:
> 
> Let me have a go at a change.

OK I've pushed a change. I reordered a few bits (to put the
base:allocation next to the stuff that talks about metadata
queries at the start), but the main change is below.

-- 
Alex Bligh



@@ -970,15 +1029,38 @@ of the newstyle negotiation.
        - String, query to list a subset of the available metadata
          contexts.

-    If zero queries are sent, then the server MUST return all
-    the metadata contexts that are available to the client to select
-    on the given export with `NBD_OPT_SET_META_CONTEXT`.
-
     For details on the query string, see under `NBD_OPT_SET_META_CONTEXT`.

     The server MUST either reply with an error (for instance `EINVAL`
     if the option is not supported), or reply with a list of
     `NBD_REP_META_CONTEXT` replies followed by `NBD_REP_ACK`.
+
+    If zero queries are sent, then the server MUST return all
+    the metadata contexts that are available to the client to select
+    on the given export with `NBD_OPT_SET_META_CONTEXT`, save that:
+
+    If one or more queries are sent, then the server MUST return
+    those metadata contexts that are available to the client to
+    select on the given export with `NBD_OPT_SET_META_CONTEXT`,
+    and which match one or more of the queries given. The
+    support of wildcarding within the leaf-name portion of
+    the query string is dependent upon the namespace.
+
+    In either case, however:
+
+    * the server MAY return an incomplete list if returning a
+      complete list would require undue resources.
+
+    * the server MAY return a context consisting of a namespace and
+      a colon only (i.e. omitting the leaf-name) to indicate that
+      the namespace contains a large number of possible contexts
+      within that namespace (for instance a namespace `X-backup` with
+      contexts that indicate whether blocks were written after
+      a given date might accept queries of the form
+      `'X-backup:modifiedtime>[unixdate]'` where `[unixdate]` is an
+      arbitrary integer, and in this case it might simply
+      return `X-backup:`)
+
     The metadata context ID in these replies is reserved and SHOULD be
     set to zero; clients MUST disregard it.

@@ -1009,7 +1091,9 @@ of the newstyle negotiation.

     If zero queries are sent, the server MUST select no metadata contexts.

-    The server MUST reply with a number of `NBD_REP_META_CONTEXT`
+    The server MAY return `NBD_REP_ERR_TOO_BIG` if a request
+    seeks to select too many contexts. Otherwise
+    the server MUST reply with a number of `NBD_REP_META_CONTEXT`
     replies, one for each selected metadata context, each with a unique
     metadata context ID, followed by `NBD_REP_ACK`. The metadata context
     ID is transient and may vary across calls to `NBD_OPT_SET_META_CONTEXT`;
