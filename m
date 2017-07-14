Received: from eggs.gnu.org ([2001:4830:134:3::10]:55414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dVyLM-0005nv-Uw
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:01:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dVyLG-0002Yz-Uy
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:01:09 -0400
Date: Fri, 14 Jul 2017 12:00:48 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170714110048.GC28095@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [Qemu-devel] qcow2 not cleaning up during image create failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>

I've just been looking at the qcow2 image creation code, and found that
if any method in qcow2_create2() returns an error, then we'll report that,
but leave the newly created image file on disk in some partially initialized
state. A user may unwittingly use this file later with undefined behaviour.
This is particularly bad if we fail to setup encryption, because the user
is left with a file with no encryption enabled.

So I'm wondering how is the best way to clean up after failure ?

Naively I would like to just unlink(filename), but IIUC, filename is
not guaranteed to refer to a local file, and AFAIK, there is not
bdrv_delete() method todo this portably.

If we can't delete a file (because its a block device or network
volume), then we must at least blank out the just-written qcow2
header with zeros.

Ideas / suggestions.

You can demo this easily, by adding  ret = -EINVAL; immediately
after the first blk_pwrite() call in qcow2_create2()

diff --git a/block/qcow2.c b/block/qcow2.c
index 75d3e3c731..205c924f6d 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2778,6 +2778,7 @@ static int qcow2_create2(const char *filename, int64_t total_size,
 
     ret = blk_pwrite(blk, 0, header, cluster_size, 0);
     g_free(header);
+    ret = -EINVAL;
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Could not write qcow2 header");
         goto out;


$ qemu-img  create -f qcow2 eek.img 1g
Formatting 'eek.img', fmt=qcow2 size=1073741824 cluster_size=65536 lazy_refcounts=off refcount_bits=16
qemu-img: eek.img: Could not write qcow2 header: Invalid argument

$ qemu-img info eek.img 
image: eek.img
file format: qcow2
virtual size: 0 (0 bytes)
disk size: 64K
cluster_size: 65536
Format specific information:
    compat: 1.1
    lazy refcounts: false
    refcount bits: 16
    corrupt: false


I imagine this may well affect other disk format drivers too.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
