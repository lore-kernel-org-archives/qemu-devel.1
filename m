Received: from eggs.gnu.org ([2001:4830:134:3::10]:47569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fzq9O-00072K-Ea
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 17:24:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fzq9I-0006oY-2N
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 17:24:44 -0400
Date: Tue, 11 Sep 2018 17:23:57 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180911212357.GR22117@localhost.localdomain>
References: <cover.1536698311.git.jcody@redhat.com>
	<c749883a9bce0234fff0813c1e1ec5a893328049.1536698311.git.jcody@redhat.com>
	<2cfec9c2-9619-b313-13f9-57bbd1be58ec@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cfec9c2-9619-b313-13f9-57bbd1be58ec@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/3] block/rbd: Attempt to parse legacy
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org, jsnow@redhat.com

On Tue, Sep 11, 2018 at 04:05:45PM -0500, Eric Blake wrote:
> On 9/11/18 3:43 PM, Jeff Cody wrote:
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
> >We do not support mixed modern usage alongside legacy keyvalue pair
> >usage.
> >
> >A deprecation warning has been added, although care should be taken
> >when actually deprecating since the impact is not limited to
> >commandline or qapi usage, but also opening existing images.
> >
> >Signed-off-by: Jeff Cody <jcody@redhat.com>
> >---
> >  block/rbd.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 51 insertions(+), 2 deletions(-)
> 
> Where's the patch to qemu/qemu-deprecated.texi to mention the new message
> and our advice on upgrading images to avoid triggering it?
> 

Argh, thanks - forgot that.  I'll spin a v3 with that as patch 4.

> >
> >diff --git a/block/rbd.c b/block/rbd.c
> >index b199450f9f..5090e4f662 100644
> >--- a/block/rbd.c
> >+++ b/block/rbd.c
> >@@ -678,6 +678,33 @@ static int qemu_rbd_convert_options(QDict *options, BlockdevOptionsRbd **opts,
> >      return 0;
> >  }
> >+static int qemu_rbd_attempt_legacy_options(QDict *options,
> >+                                           BlockdevOptionsRbd **opts,
> >+                                           char **keypairs)
> >+{
> >+    char *filename;
> >+    int r;
> >+
> >+    filename = g_strdup(qdict_get_try_str(options, "filename"));
> >+    if (!filename) {
> >+        return -EINVAL;
> >+    }
> >+    qdict_del(options, "filename");
> >+
> >+    qemu_rbd_parse_filename(filename, options, NULL);
> 
> Intentionally ignoring errors here,
> 
> >+
> >+    /* keypairs freed by caller */
> >+    *keypairs = g_strdup(qdict_get_try_str(options, "=keyvalue-pairs"));
> >+    if (*keypairs) {
> >+        qdict_del(options, "=keyvalue-pairs");
> >+    }
> >+
> >+    r = qemu_rbd_convert_options(options, opts, NULL);
> 
> and here. I guess we'll see how the caller is expecting things to behave.
> 
> >+
> >+    g_free(filename);
> >+    return r;
> >+}
> >+
> >  static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
> >                           Error **errp)
> >  {
> >@@ -700,8 +727,30 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
> >      r = qemu_rbd_convert_options(options, &opts, &local_err);
> >      if (local_err) {
> >-        error_propagate(errp, local_err);
> >-        goto out;
> >+        /* If keypairs are present, that means some options are present in
> >+         * the modern option format.  Don't attempt to parse legacy option
> >+         * formats, as we won't support mixed usage. */
> >+        if (keypairs) {
> >+            error_propagate(errp, local_err);
> >+            goto out;
> >+        }
> >+
> >+        /* If the initial attempt to convert and process the options failed,
> >+         * we may be attempting to open an image file that has the rbd options
> >+         * specified in the older format consisting of all key/value pairs
> >+         * encoded in the filename.  Go ahead and attempt to parse the
> >+         * filename, and see if we can pull out the required options. */
> >+        r = qemu_rbd_attempt_legacy_options(options, &opts, &keypairs);
> >+        if (r < 0) {
> >+            error_propagate(errp, local_err);
> >+            goto out;
> >+        }
> >+        /* Take care whenever deciding to actually deprecate; once this ability
> >+         * is removed, we will not be able to open any images with legacy-styled
> >+         * backing image strings. */
> >+        error_report("RBD options encoded in the filename as keyvalue pairs "
> >+                     "is deprecated.  Future versions may cease to parse "
> >+                     "these options in the future.");
> 
> Okay, so you're making a best-effort fallback to scrape out any remaining
> keyvalue pairs. If there was no filename (and hence no keyvalue pairs
> populated), we know up front that we lack enough information, so
> attempt_legacy_options() returns failure right away; if there was a
> filename, we don't know if we got all the required options (so ignoring
> errors was okay) - that will be up to later code to decipher, after we emit
> our warning that we already relied on legacy options (if the later code has
> all it needed, then only the warning is emitted; if later code fails, the
> user now has the warning in addition to the later failure message to help
> them resolve their images).
> 
> A bit confusing how it all fits together, but it seems to work out in the
> end.
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
>

Thanks for the review!
