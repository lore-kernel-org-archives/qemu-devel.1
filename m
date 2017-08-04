Received: from eggs.gnu.org ([2001:4830:134:3::10]:34687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ddcp8-0000sw-7E
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:40:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ddco4-0007QY-3B
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:39:30 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <8760e3ijng.fsf@dusky.pond.sub.org>
References: <8760e3ijng.fsf@dusky.pond.sub.org>
Date: Fri, 04 Aug 2017 15:38:19 +0200
Message-ID: <w51ini3v4fo.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Is the use of bdrv_getlength() in
 quorum_co_flush() kosher?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Fri 04 Aug 2017 02:48:03 PM CEST, Markus Armbruster wrote:
> Have a look at quorum_co_flush():
>
>             quorum_report_bad(QUORUM_OP_TYPE_FLUSH, 0,
>                               bdrv_getlength(s->children[i]->bs),
>                               s->children[i]->bs->node_name, result);
>
> bdrv_getlength() can fail.  Does it do the right thing then?

If it fails then it returns -errno, but then quorum_report_bad() turns
into uint64_t and assumes it's valid.

Since that number is then rounded up to the next multiple of
BDRV_SECTOR_SIZE in order to calculate end_sector, I think that what
happens in practice is that the user sees a QUORUM_REPORT_BAD event with
sectors-count = 0 (in most cases) or with a very high value in
sectors-count (if errno > BDRV_SECTOR_SIZE).

The result of bdrv_getlength() is only used to report the number of
affected sectors in the QUORUM_REPORT_BAD event, so there are no other
consequences.

Anyway I think it's a good idea not to make assumptions, detect the
error and pass 0 instead.

--- a/block/quorum.c
+++ b/block/quorum.c
@@ -785,8 +785,9 @@ static coroutine_fn int
quorum_co_flush(BlockDriverState *bs)
     for (i = 0; i < s->num_children; i++) {
         result = bdrv_co_flush(s->children[i]->bs);
         if (result) {
+            int64_t length = bdrv_getlength(s->children[i]->bs);
             quorum_report_bad(QUORUM_OP_TYPE_FLUSH, 0,
-                              bdrv_getlength(s->children[i]->bs),
+                              length > 0 ? length : 0,
                               s->children[i]->bs->node_name, result);
             result_value.l = result;
             quorum_count_vote(&error_votes, &result_value, i);

Berto
