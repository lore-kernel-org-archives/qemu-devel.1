Received: from eggs.gnu.org ([209.51.188.92]:45494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guLl5-0000nN-28
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:29:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guLl4-0003xv-6B
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:29:15 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:34641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guLl3-0003x2-VC
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:29:14 -0500
Received: by mail-ot1-x334.google.com with SMTP id 98so12237849oty.1
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 10:29:13 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 18:29:01 +0000
Message-ID: <CAFEAcA-W7AAFsrEkmUSpwqoQic7TDHnPGwnpFB_FQ25ad32n0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] QEMU xen coverity issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Paul Durrant <Paul.Durrant@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>

Hi; we've just done another Coverity run, and it's pulled up some
issues in the recently changed Xen code. Rather than track them
back to exactly which patches in the recent refactorings resulted
in them, I figured I'd just list them here. Could you take a
look at them, please ?

(1) CID 1398635: xen_block_complete_aio(): identical code in two branches

In hw/block/dataplane/xen_block_complete_aio():

the first switch has this code:
    case BLKIF_OP_WRITE:
    case BLKIF_OP_FLUSH_DISKCACHE:
        if (!request->req.nr_segments) {
            break;
        }
        break;

so the if() doesn't do anything. What was this supposed to be?

(2) Not spotted by coverity, but in a later switch in the same function:

    switch (request->req.operation) {
    case BLKIF_OP_WRITE:
    case BLKIF_OP_FLUSH_DISKCACHE:
        if (!request->req.nr_segments) {
            break;
        }
    case BLKIF_OP_READ:

If a switch case is supposed to fall through it should be
explicitly marked with a "/* fall through */" comment.

(3) CID 1398638: unused value in xen_block_set_vdev():

In hw/block/xen-block.c xen_block_set_vdev():

    if (vdev->type == XEN_BLOCK_VDEV_TYPE_DP) {
        if (qemu_strtoul(p, &end, 10, &vdev->disk)) {
            goto invalid;
        }

        if (*end == 'p') {
            p = (char *) ++end;    /* this assignment is unused */
            if (*end == '\0') {
                goto invalid;
            }
        }
    } else {
        vdev->disk = vbd_name_to_disk(p, &end);
    }

    if (*end != '\0') {
        p = (char *)end;
        [...]

The assignment to p which I've marked with a comment above
is never used, because we will either goto 'invalid' (which never
uses 'p') or we will take the "if (*end != '\0')" path which
overwrites 'p'. What is the intention here ?

(4) CID 1398640: vbd_name_to_disk() integer overflow:

In hw/block/xen-block.c vbd_name_to_disk(), if the name string
passed in is empty or doesn't start with a lowercase alphabetic
character, then we end the while loop with disk == 0. Then
we return "disk - 1" which underflows to UINT_MAX. This isn't
documented as being an error return for the function and the
caller doesn't check for it.

(5) CID 1398649: resource leak in xen_block_drive_create():

In hw/block/xen-block.c xen_block_drive_create() Coverity
complains that the call "driver_layer = qdict_new()" allocates
memory that's leaked because we don't save the pointer anywhere
but don't deallocate it before the end of the function either.
Coverity is not great at understanding our refcounting objects,
but this does look like either we're missing a qobject_unref()
or something should be keeping hold of the dictionary. Probably
best to ask a block layer expert.

thanks
-- PMM
