Received: from eggs.gnu.org ([2001:4830:134:3::10]:57296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fznOl-0007Em-An
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 14:28:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fznOk-0005MQ-92
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 14:28:27 -0400
Date: Tue, 11 Sep 2018 14:28:08 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180911182808.GP22117@localhost.localdomain>
References: <cover.1536642773.git.jcody@redhat.com>
	<570e8585c94d6f1bd7406ce5d35f68a82b6ea28c.1536642773.git.jcody@redhat.com>
	<0385dca9-60e7-388c-56e1-fbf2b75ff8f0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0385dca9-60e7-388c-56e1-fbf2b75ff8f0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] block/rbd: Attempt to parse legacy
 filenames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jsnow@redhat.com, qemu-stable@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com

On Tue, Sep 11, 2018 at 01:03:44PM -0500, Eric Blake wrote:
> On 9/11/18 12:15 AM, Jeff Cody wrote:
> >When we converted rbd to get rid of the older key/value-centric
> >encoding format, we broke compatibility with image files with backing
> >file strings encoded in the old format.
> >
> >This leaves a bit of an ugly conundrum, and a hacky solution.
> >
> >If the initial attempt to parse the "proper" options fails, it assumes
> >that we may have an older key/value encoded filename.  Fall back to
> >attempting to parse the filename, and extract the required options from
> >it.  If that fails, pass along the original error message.
> >
> >This approach has a potential drawback: if for some reason there are
> >some options supplied the new way, and some the old way, we may not
> >catch all the old options if they are not required options (since it
> >won't cause the initial failure).
> 
> No one should be mixing new and old, though.
> 
> >
> >Signed-off-by: Jeff Cody <jcody@redhat.com>
> >---
> >  block/rbd.c | 30 +++++++++++++++++++++++++++---
> >  1 file changed, 27 insertions(+), 3 deletions(-)
> >
> >diff --git a/block/rbd.c b/block/rbd.c
> >index a8e79d01d2..bce86b8bde 100644
> >--- a/block/rbd.c
> >+++ b/block/rbd.c
> >@@ -685,7 +685,7 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
> >      BlockdevOptionsRbd *opts = NULL;
> >      const QDictEntry *e;
> >      Error *local_err = NULL;
> >-    char *keypairs, *secretid;
> >+    char *keypairs, *secretid, *filename;
> >      int r;
> >      keypairs = g_strdup(qdict_get_try_str(options, "=keyvalue-pairs"));
> >@@ -700,8 +700,32 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
> >      r = qemu_rbd_convert_options(bs, options, &opts, &local_err);
> >      if (local_err) {
> >-        error_propagate(errp, local_err);
> >-        goto out;
> 
> Oh, my comment about simplifying this in 1/2 is probably moot, now that you
> are doing a lot more based on local_err rather than just blindly propagating
> it.
> 
> >+        /* If the initial attempt to convert and process the options failed,
> >+         * we may be attempting to open an image file that has the rbd options
> >+         * specified in the older format consisting of all key/value pairs
> >+         * encoded in the filename.  Go ahead and attempt to parse the
> >+         * filename, and see if we can pull out the required options */
> >+        Error *parse_err = NULL;
> >+
> >+        filename = g_strdup(qdict_get_try_str(options, "filename"));
> 
> You already spotted your leak.
> 
> >+        qdict_del(options, "filename");
> >+
> >+        qemu_rbd_parse_filename(filename, options, NULL);
> >+
> >+        g_free(keypairs);
> 
> Wait. Why are you unilaterally freeing any previously-parsed keypairs in
> favor of the ones parsed out of the filename?  I'd rather that we insist on
> only old behavior, or only new, and not some mix.  Thus, if we already
> detected keypairs at all, we should declare this situation as an error,
> rather than throwing them away.
> 

Good point.  I'll flag (local_err && keypairs) as an error.

I also just realized I need to check for NULL filename, and error out as
well in that case.

> >+        keypairs = g_strdup(qdict_get_try_str(options, "=keyvalue-pairs"));
> >+        if (keypairs) {
> >+            qdict_del(options, "=keyvalue-pairs");
> >+        }
> >+
> >+        r = qemu_rbd_convert_options(bs, options, &opts, &parse_err);
> >+        if (parse_err) {
> >+            /* if the second attempt failed, pass along the original error
> >+             * message for the current format */
> >+            error_propagate(errp, local_err);
> >+            error_free(parse_err);
> >+            goto out;
> >+        }
> >      }
> 
> The idea of trying two parses makes sense, but I'm hoping v2 better handles
> the case of detecting bad attempts to mix-and-match behavior. Furthermore,
> is there an iotests that you can modify (or add) as a regression test for
> this working the way we want?

Hmm... yes, that should be doable.  I'm not sure if I can do it without the
'success' path being a timeout when there is no ceph server present, though.
I'll see what I can do.

-Jeff
