Received: from eggs.gnu.org ([2001:4830:134:3::10]:37549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCv3i-000488-Fa
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 17:12:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCv3h-0004cU-GF
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 17:12:26 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu,  9 Nov 2017 16:12:16 -0600
Message-Id: <20171109221216.10248-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11] iotests: Use new-style NBD connections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@virtuozzo.com, pbonzini@redhat.com, mreitz@redhat.com, Kevin Wolf <kwolf@redhat.com>

Old-style NBD is deprecated upstream (it is documented, but no
longer implemented in the reference implementation), and it is
severely limited (it cannot support structured replies, which
means it cannot support efficient handling of zeroes), when
compared to new-style NBD.  We are better off having our iotests
favor new-style everywhere (although some explicit tests,
particularly 83, still cover old-style for back-compat reasons);
this is as simple as supplying the empty string as the default
export name, as it does not change the URI needed to connect a
client to the server.  This also gives us more coverage of the
just-added structured reply code, when not overriding $QEMU_NBD
to intentionally point to an older server.

Signed-off-by: Eric Blake <eblake@redhat.com>
---

Proposing this for 2.11; it can either go in through the NBD
tree (although I just send my 2.11-rc1 pull request) or through
Max' iotest tree.

 tests/qemu-iotests/common.rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 0e8a33c696..dbae7d74ba 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -242,7 +242,7 @@ _make_test_img()
     if [ $IMGPROTO = "nbd" ]; then
         # Pass a sufficiently high number to -e that should be enough for all
         # tests
-        eval "$QEMU_NBD -v -t -b 127.0.0.1 -p 10810 -f $IMGFMT -e 42  $TEST_IMG_FILE >/dev/null &"
+        eval "$QEMU_NBD -v -t -b 127.0.0.1 -p 10810 -f $IMGFMT -e 42 -x '' $TEST_IMG_FILE >/dev/null &"
         sleep 1 # FIXME: qemu-nbd needs to be listening before we continue
     fi

-- 
2.13.6
