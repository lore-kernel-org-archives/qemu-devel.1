Received: from eggs.gnu.org ([2001:4830:134:3::10]:39309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyf1L-00040m-7W
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:47:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyf1F-0005EH-K9
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:47:19 -0400
Date: Wed, 21 Mar 2018 16:46:32 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1521642402-197739-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH v2] qemu: replace "" with <> in headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, David Hildenbrand <david@redhat.com>, Jeff Cody <jcody@redhat.com>, Zhang Chen <zhangckid@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, Keith Busch <keith.busch@intel.com>, Max Filippov <jcmvbkbc@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Eric Blake <eblake@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Josh Durgin <jdurgin@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Alberto Garcia <berto@igalia.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Ben Warren <ben@skyportsystems.com>, Marcel Apfelbaum <marcel@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Markus Armbruster <armbru@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org, =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Anthony Perard <anthony.perard@citrix.com>, Liu Yuan <namei.unix@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Andrzej Zaborowski <balrogg@gmail.com>, Jason Wang <jasowang@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>, Amit Shah <amit@kernel.org>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>, Alistair Francis <alistair@alistair23.me>, Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>, Yuval Shaia <yuval.shaia@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org, John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Wen Congyang <wencongyang2@huawei.com>, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, Juan Quintela <quintela@redhat.com>, Max Reitz <mreitz@redhat.com>, Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, Hannes Reinecke <hare@suse.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Our current scheme is to use
 #include ""
for internal headers, and
 #include <>
for external ones.

Unfortunately this is not based on compiler support: from C point of
view, the "" form merely looks up headers in the current directory
and then falls back on <> directories.

Thus, for example, a system header trace.h - should it be present - will
conflict with our local trace.h

As another example of problems, a header by the same name in the source
directory will always be picked up first - before any headers in
the include directory.

Let's change the scheme: make sure all headers that are not
in the source directory are included through a path
starting with qemu/ , thus:

 #include <>

headers in the same directory as source are included with

 #include ""

as per standard.

This (untested) patch is just to start the discussion and does not
change all of the codebase. If there's agreement, this will be
run on all code to converting code to this scheme.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 scripts/changeheaders.pl | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100755 scripts/changeheaders.pl

diff --git a/scripts/changeheaders.pl b/scripts/changeheaders.pl
new file mode 100755
index 0000000..22bd5b8
--- /dev/null
+++ b/scripts/changeheaders.pl
@@ -0,0 +1,20 @@
+#!/usr/bin/perl -pi
+
+if (m@^\s*#include\s+"([^"+]"@o) {
+    next;
+}
+
+my $hdr = $1;
+my $file = $ARGV;
+$file =~ s@/[^/]+$@@g;
+$file .= $hdr;
+
+if (-e $file) {
+    next;
+}
+
+if (m@^\s*#include\s+"qemu/@o) {
+    s@^(\s*#include\s+)"qemu/([^"]+)"(.*)$@$1<qemu/common/$2>$3@o) {
+} else {
+    s@^(\s*#include\s+)"([^"]+)"(.*)$@$1<qemu/$2>$3@o) {
+}
-- 
MST
