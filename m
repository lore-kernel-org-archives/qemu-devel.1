Received: from eggs.gnu.org ([2001:4830:134:3::10]:55651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dVD5h-00024N-4c
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 04:33:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dVD5f-00019s-VA
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 04:33:49 -0400
Date: Wed, 12 Jul 2017 10:33:37 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170712083337.GC4917@noname.str.redhat.com>
References: <20170701153906.16588-1-el13635@mail.ntua.gr>
	<20170711151617.GK4335@noname.str.redhat.com>
	<20170711185035.peu4mbxiab5axwvz@postretch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <20170711185035.peu4mbxiab5axwvz@postretch>
Subject: Re: [Qemu-devel] [PATCH v2] block: fix leaks in bdrv_open_driver()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>, Max Reitz <mreitz@redhat.com>


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Am 11.07.2017 um 20:50 hat Manos Pitsidianakis geschrieben:
> On Tue, Jul 11, 2017 at 05:16:17PM +0200, Kevin Wolf wrote:
> >Am 01.07.2017 um 17:39 hat Manos Pitsidianakis geschrieben:
> >>bdrv_open_driver() is called in two places, bdrv_new_open_driver() and
> >>bdrv_open_common(). In the latter, failure cleanup in is in its caller,
> >>bdrv_open_inherit(), which unrefs the bs->file of the failed driver open if it
> >>exists.
> >>
> >>Let's move the bs->file cleanup to bdrv_open_driver() to take care of all
> >>callers and do not set bs->drv to NULL unless the driver's open function
> >>failed. When bs is destroyed by removing its last reference, bdrv_close()
> >>checks bs->drv to perform the needed cleanups and also call the driver's close
> >>function.
> >>
> >>Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> >>---
> >>
> >>v2:
> >> move bdrv_unref_child(bs, bs->file) to bdrv_open_driver
> >> do not set bs->drv to NULL if open succeeds
> >>
> >> block.c | 21 +++++++++++++--------
> >> 1 file changed, 13 insertions(+), 8 deletions(-)
> >>
> >>diff --git a/block.c b/block.c
> >>index 694396281b..df2a46990c 100644
> >>--- a/block.c
> >>+++ b/block.c
> >>@@ -1091,6 +1091,7 @@ static int bdrv_open_driver(BlockDriverState *bs, BlockDriver *drv,
> >> {
> >>     Error *local_err = NULL;
> >>     int ret;
> >>+    bool open_failed;
> >>
> >>     bdrv_assign_node_name(bs, node_name, &local_err);
> >>     if (local_err) {
> >>@@ -1111,7 +1112,9 @@ static int bdrv_open_driver(BlockDriverState *bs, BlockDriver *drv,
> >>         ret = 0;
> >>     }
> >>
> >>-    if (ret < 0) {
> >>+    open_failed = ret < 0;
> >>+
> >>+    if (open_failed) {
> >>         if (local_err) {
> >>             error_propagate(errp, local_err);
> >>         } else if (bs->filename[0]) {
> >>@@ -1142,10 +1145,15 @@ static int bdrv_open_driver(BlockDriverState *bs, BlockDriver *drv,
> >>     return 0;
> >>
> >> free_and_fail:
> >>-    /* FIXME Close bs first if already opened*/
> >>-    g_free(bs->opaque);
> >>-    bs->opaque = NULL;
> >>-    bs->drv = NULL;
> >>+    if (open_failed) {
> >>+        g_free(bs->opaque);
> >>+        bs->opaque = NULL;
> >>+        bs->drv = NULL;
> >>+    }
> >>+    if (bs->file != NULL) {
> >>+        bdrv_unref_child(bs, bs->file);
> >>+        bs->file = NULL;
> >>+    }
> >
> >Is this bdrv_unref_child() safe if we leave bs->drv set? Format drivers
> >expect that if an image is opened, it also has a valid bs->file.
> >
> >For example, if I add ret = -1 after refresh_total_sectors() (because I
> >couldn't find an easier way to make it fail intentionally), I get an
> >ugly heap corruption crash instead of a nice error message with this
> >patch.
> >
> This is triggered by bdrv_open_inherit doing
> QDECREF(bs->explicit_options) and leaving the dangling pointer. Not
> setting bs->drv means bdrv_close was called and tried to decref it
> again, causing the heap error. Setting bs->explicit_options = NULL;
> right below that fixes the heap corruption for me.

Wouldn't it be better to call drv->bdrv_close() instead and then set
bs->drv/opaque = NULL like for the other error path?

> I can send a seperate fix for this.

No, this doesn't fail before this patch, so it's a regression and we
can't merge the patch without a fix. You need to respin this one.

> I also saw that there's no reason to use a boolean, a label would do
> just fine so I can change that and finalize the patch in the next
> version if everything is okay with it.

Yes, that sounds better.

Kevin

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZZd7hAAoJEH8JsnLIjy/WOiQQAIYseN6QBEWiXUe2iL7YOZwy
FhS6hnIMCT4MnbVmA+alFKVPXacE6NVurhMZM6EuBu5YeRjQct/pipoVp0tMmmDd
kfCI8LqvSQbcNDZ9YDRkOST9YND/5e/41X/owAn1BUQQ2bSF92MXUvfLB6lnJBth
XRhf14PHCylL55mCsBn3x8yiGPfxxBeoTQRAdF/YcuxbuV8RRLm0tVo+ojOeQ7vE
NywYbZXPrpL68dHmFzuuKRcg84GI7iZyqP2Lqw5o+X1SD/VrXIyuvMQK9JqxTzzg
oeeg29fEtsf0dbWGguIU03AygS9WlfIoR3oGg8bFao16l+7j8QDyhUX3K/lmNAVk
VtpB8kKtBc6ZUg5pnnGXQ41fu9iKi99EoS48T2OETljFj+UQNN5ayl9B8+flHQGP
U2sI/O2Kf6QYQZkM9gQEnV7697xTxB5VkErkRTOrxulLXP39rSIVwDPBn3Fd61PB
sBVogZ7Ra2NWPCia5vAETR57npfbe4ZX1HLyWqcnCR4Ltuqi0d58+p0OmejMwZSQ
UpEzciSqGBGbITiEpNhBiW3Q5VgdqXcA2doFPLFDuPbd3+8SaYWFuTCXk6P0/P9x
q9DOouUWD2fCT83fXOkOzadpxMSlCMtXQ2Z5UuqpLlefXVma2x+bDlLqI5v1EZ7E
517WWscUzikHWyohpLUE
=yNvm
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
