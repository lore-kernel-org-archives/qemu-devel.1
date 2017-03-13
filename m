Received: from eggs.gnu.org ([2001:4830:134:3::10]:52176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJl-0007XB-QP
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJj-0003YR-RM
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cnJJj-0003XY-LB
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:51 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 13 Mar 2017 07:18:10 +0100
Message-Id: <1489385927-6735-11-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-1-git-send-email-armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 10/47] qapi2texi: Fix up output around
 #optional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

We use tag #optional to mark optional members, like this:

    # @name: #optional The name of the guest

texi_body() strips #optional, but not whitespace around it.  For the
above, we get in qemu-qmp-qapi.texi

    @item @code{'name'} (optional)
     The name of the guest
    @end table

The extra space can lead to artifacts in output, e.g in
qemu-qmp-ref.7.pod

    =item C<'name'> (optional)

     The name of the guest

and then in qemu-qmp-ref.7

    .IX Item "name (optional)"
    .Vb 1
    \& The name of the guest
    .Ve

instead of intended plain

    .IX Item "name (optional)"
    The name of the guest

Get rid of these artifacts by removing whitespace around #optional
along with it.

This turns three minus signs in qapi-schema.json into markup, because
they're now at the beginning of the line.  Drop them, they're unwanted
there.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi-schema.json     | 6 +++---
 scripts/qapi2texi.py | 3 ++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index 17c766e..52141cd 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3779,11 +3779,11 @@
 #
 # @dstport: #optional destination port - mandatory for udp, optional for ip
 #
-# @ipv6: #optional - force the use of ipv6
+# @ipv6: #optional force the use of ipv6
 #
-# @udp: #optional - use the udp version of l2tpv3 encapsulation
+# @udp: #optional use the udp version of l2tpv3 encapsulation
 #
-# @cookie64: #optional - use 64 bit coookies
+# @cookie64: #optional use 64 bit coookies
 #
 # @counter: #optional have sequence counter
 #
diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 06d6abf..0f3e573 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -137,7 +137,8 @@ def texi_body(doc):
             desc = str(section)
             opt = ''
             if "#optional" in desc:
-                desc = desc.replace("#optional", "")
+                desc = re.sub(r'^ *#optional *\n?|\n? *#optional *$|#optional',
+                              '', desc)
                 opt = ' (optional)'
             body += "@item @code{'%s'}%s\n%s\n" % (arg, opt,
                                                    texi_format(desc))
-- 
2.7.4
