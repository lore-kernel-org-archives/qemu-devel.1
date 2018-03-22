Received: from eggs.gnu.org ([2001:4830:134:3::10]:45791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ez5tH-0000Sm-VN
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 15:28:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ez5tC-0007CH-PJ
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 15:28:47 -0400
Date: Thu, 22 Mar 2018 21:27:55 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1521746188-496856-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH v2 1/2] make: move generated headers to
 qemu-build/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, David Hildenbrand <david@redhat.com>, Jeff Cody <jcody@redhat.com>, Zhang Chen <zhangckid@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, Keith Busch <keith.busch@intel.com>, Max Filippov <jcmvbkbc@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Eric Blake <eblake@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Josh Durgin <jdurgin@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Alberto Garcia <berto@igalia.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Ben Warren <ben@skyportsystems.com>, Marcel Apfelbaum <marcel@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Markus Armbruster <armbru@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org, =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Anthony Perard <anthony.perard@citrix.com>, Liu Yuan <namei.unix@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Andrzej Zaborowski <balrogg@gmail.com>, Jason Wang <jasowang@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>, Amit Shah <amit@kernel.org>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>, Alistair Francis <alistair@alistair23.me>, Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>, Yuval Shaia <yuval.shaia@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org, John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>, Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, qemu-block@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Wen Congyang <wencongyang2@huawei.com>, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, Juan Quintela <quintela@redhat.com>, Max Reitz <mreitz@redhat.com>, Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, Hannes Reinecke <hare@suse.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Make sure all generated files go into qemu-build subdirectory.
We can then include them like this:
 #include "qemu-build/trace.h"

This serves two purposes:
- make it easy to detect which files are in the source
  directory (a bit more work for writers, easier for readers)
- reduce chances of conflicts with possible stale files in source
  directory (which could be left over from e.g. old patches, etc)

This patch needs to be merged with patch 2  of series updating all
files: sending it separately to avoid spamming the list.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 configure           |   6 +-
 Makefile            | 412 +++++++++++++++++++++++++++-------------------------
 rules.mak           |   5 +-
 .gitignore          |   1 +
 Makefile.objs       | 144 +++++++++---------
 Makefile.target     |  21 +--
 trace/Makefile.objs |  15 +-
 7 files changed, 313 insertions(+), 291 deletions(-)

diff --git a/configure b/configure
index 23a4f3b..7b0a183 100755
--- a/configure
+++ b/configure
@@ -6638,6 +6638,8 @@ if test "$gcov" = "yes" ; then
   echo "GCOV=$gcov_tool" >> $config_host_mak
 fi
 
+mkdir -p qemu-build
+
 # use included Linux headers
 if test "$linux" = "yes" ; then
   mkdir -p linux-headers
@@ -7046,10 +7048,10 @@ echo "QEMU_CFLAGS+=$cflags" >> $config_target_mak
 done # for target in $targets
 
 if [ "$dtc_internal" = "yes" ]; then
-  echo "config-host.h: subdir-dtc" >> $config_host_mak
+  echo "qemu-build/config-host.h: subdir-dtc" >> $config_host_mak
 fi
 if [ "$capstone" = "git" -o "$capstone" = "internal" ]; then
-  echo "config-host.h: subdir-capstone" >> $config_host_mak
+  echo "qemu-build/config-host.h: subdir-capstone" >> $config_host_mak
 fi
 if test -n "$LIBCAPSTONE"; then
   echo "LIBCAPSTONE=$LIBCAPSTONE" >> $config_host_mak
diff --git a/Makefile b/Makefile
index f799390..6fd90a8 100644
--- a/Makefile
+++ b/Makefile
@@ -89,102 +89,102 @@ endif
 
 include $(SRC_PATH)/rules.mak
 
-GENERATED_FILES = qemu-version.h config-host.h qemu-options.def
-GENERATED_FILES += qapi/qapi-builtin-types.h qapi/qapi-builtin-types.c
-GENERATED_FILES += qapi/qapi-types.h qapi/qapi-types.c
-GENERATED_FILES += qapi/qapi-types-block-core.h qapi/qapi-types-block-core.c
-GENERATED_FILES += qapi/qapi-types-block.h qapi/qapi-types-block.c
-GENERATED_FILES += qapi/qapi-types-char.h qapi/qapi-types-char.c
-GENERATED_FILES += qapi/qapi-types-common.h qapi/qapi-types-common.c
-GENERATED_FILES += qapi/qapi-types-crypto.h qapi/qapi-types-crypto.c
-GENERATED_FILES += qapi/qapi-types-introspect.h qapi/qapi-types-introspect.c
-GENERATED_FILES += qapi/qapi-types-migration.h qapi/qapi-types-migration.c
-GENERATED_FILES += qapi/qapi-types-misc.h qapi/qapi-types-misc.c
-GENERATED_FILES += qapi/qapi-types-net.h qapi/qapi-types-net.c
-GENERATED_FILES += qapi/qapi-types-rocker.h qapi/qapi-types-rocker.c
-GENERATED_FILES += qapi/qapi-types-run-state.h qapi/qapi-types-run-state.c
-GENERATED_FILES += qapi/qapi-types-sockets.h qapi/qapi-types-sockets.c
-GENERATED_FILES += qapi/qapi-types-tpm.h qapi/qapi-types-tpm.c
-GENERATED_FILES += qapi/qapi-types-trace.h qapi/qapi-types-trace.c
-GENERATED_FILES += qapi/qapi-types-transaction.h qapi/qapi-types-transaction.c
-GENERATED_FILES += qapi/qapi-types-ui.h qapi/qapi-types-ui.c
-GENERATED_FILES += qapi/qapi-builtin-visit.h qapi/qapi-builtin-visit.c
-GENERATED_FILES += qapi/qapi-visit.h qapi/qapi-visit.c
-GENERATED_FILES += qapi/qapi-visit-block-core.h qapi/qapi-visit-block-core.c
-GENERATED_FILES += qapi/qapi-visit-block.h qapi/qapi-visit-block.c
-GENERATED_FILES += qapi/qapi-visit-char.h qapi/qapi-visit-char.c
-GENERATED_FILES += qapi/qapi-visit-common.h qapi/qapi-visit-common.c
-GENERATED_FILES += qapi/qapi-visit-crypto.h qapi/qapi-visit-crypto.c
-GENERATED_FILES += qapi/qapi-visit-introspect.h qapi/qapi-visit-introspect.c
-GENERATED_FILES += qapi/qapi-visit-migration.h qapi/qapi-visit-migration.c
-GENERATED_FILES += qapi/qapi-visit-misc.h qapi/qapi-visit-misc.c
-GENERATED_FILES += qapi/qapi-visit-net.h qapi/qapi-visit-net.c
-GENERATED_FILES += qapi/qapi-visit-rocker.h qapi/qapi-visit-rocker.c
-GENERATED_FILES += qapi/qapi-visit-run-state.h qapi/qapi-visit-run-state.c
-GENERATED_FILES += qapi/qapi-visit-sockets.h qapi/qapi-visit-sockets.c
-GENERATED_FILES += qapi/qapi-visit-tpm.h qapi/qapi-visit-tpm.c
-GENERATED_FILES += qapi/qapi-visit-trace.h qapi/qapi-visit-trace.c
-GENERATED_FILES += qapi/qapi-visit-transaction.h qapi/qapi-visit-transaction.c
-GENERATED_FILES += qapi/qapi-visit-ui.h qapi/qapi-visit-ui.c
-GENERATED_FILES += qapi/qapi-commands.h qapi/qapi-commands.c
-GENERATED_FILES += qapi/qapi-commands-block-core.h qapi/qapi-commands-block-core.c
-GENERATED_FILES += qapi/qapi-commands-block.h qapi/qapi-commands-block.c
-GENERATED_FILES += qapi/qapi-commands-char.h qapi/qapi-commands-char.c
-GENERATED_FILES += qapi/qapi-commands-common.h qapi/qapi-commands-common.c
-GENERATED_FILES += qapi/qapi-commands-crypto.h qapi/qapi-commands-crypto.c
-GENERATED_FILES += qapi/qapi-commands-introspect.h qapi/qapi-commands-introspect.c
-GENERATED_FILES += qapi/qapi-commands-migration.h qapi/qapi-commands-migration.c
-GENERATED_FILES += qapi/qapi-commands-misc.h qapi/qapi-commands-misc.c
-GENERATED_FILES += qapi/qapi-commands-net.h qapi/qapi-commands-net.c
-GENERATED_FILES += qapi/qapi-commands-rocker.h qapi/qapi-commands-rocker.c
-GENERATED_FILES += qapi/qapi-commands-run-state.h qapi/qapi-commands-run-state.c
-GENERATED_FILES += qapi/qapi-commands-sockets.h qapi/qapi-commands-sockets.c
-GENERATED_FILES += qapi/qapi-commands-tpm.h qapi/qapi-commands-tpm.c
-GENERATED_FILES += qapi/qapi-commands-trace.h qapi/qapi-commands-trace.c
-GENERATED_FILES += qapi/qapi-commands-transaction.h qapi/qapi-commands-transaction.c
-GENERATED_FILES += qapi/qapi-commands-ui.h qapi/qapi-commands-ui.c
-GENERATED_FILES += qapi/qapi-events.h qapi/qapi-events.c
-GENERATED_FILES += qapi/qapi-events-block-core.h qapi/qapi-events-block-core.c
-GENERATED_FILES += qapi/qapi-events-block.h qapi/qapi-events-block.c
-GENERATED_FILES += qapi/qapi-events-char.h qapi/qapi-events-char.c
-GENERATED_FILES += qapi/qapi-events-common.h qapi/qapi-events-common.c
-GENERATED_FILES += qapi/qapi-events-crypto.h qapi/qapi-events-crypto.c
-GENERATED_FILES += qapi/qapi-events-introspect.h qapi/qapi-events-introspect.c
-GENERATED_FILES += qapi/qapi-events-migration.h qapi/qapi-events-migration.c
-GENERATED_FILES += qapi/qapi-events-misc.h qapi/qapi-events-misc.c
-GENERATED_FILES += qapi/qapi-events-net.h qapi/qapi-events-net.c
-GENERATED_FILES += qapi/qapi-events-rocker.h qapi/qapi-events-rocker.c
-GENERATED_FILES += qapi/qapi-events-run-state.h qapi/qapi-events-run-state.c
-GENERATED_FILES += qapi/qapi-events-sockets.h qapi/qapi-events-sockets.c
-GENERATED_FILES += qapi/qapi-events-tpm.h qapi/qapi-events-tpm.c
-GENERATED_FILES += qapi/qapi-events-trace.h qapi/qapi-events-trace.c
-GENERATED_FILES += qapi/qapi-events-transaction.h qapi/qapi-events-transaction.c
-GENERATED_FILES += qapi/qapi-events-ui.h qapi/qapi-events-ui.c
-GENERATED_FILES += qapi/qapi-introspect.c qapi/qapi-introspect.h
-GENERATED_FILES += qapi/qapi-doc.texi
-
-GENERATED_FILES += trace/generated-tcg-tracers.h
-
-GENERATED_FILES += trace/generated-helpers-wrappers.h
-GENERATED_FILES += trace/generated-helpers.h
+GENERATED_FILES = qemu-build/qemu-version.h qemu-build/config-host.h qemu-build/qemu-options.def
+GENERATED_FILES += qemu-build/qapi/qapi-builtin-types.h qemu-build/qapi/qapi-builtin-types.c
+GENERATED_FILES += qemu-build/qapi/qapi-types.h qemu-build/qapi/qapi-types.c
+GENERATED_FILES += qemu-build/qapi/qapi-types-block-core.h qemu-build/qapi/qapi-types-block-core.c
+GENERATED_FILES += qemu-build/qapi/qapi-types-block.h qemu-build/qapi/qapi-types-block.c
+GENERATED_FILES += qemu-build/qapi/qapi-types-char.h qemu-build/qapi/qapi-types-char.c
+GENERATED_FILES += qemu-build/qapi/qapi-types-common.h qemu-build/qapi/qapi-types-common.c
+GENERATED_FILES += qemu-build/qapi/qapi-types-crypto.h qemu-build/qapi/qapi-types-crypto.c
+GENERATED_FILES += qemu-build/qapi/qapi-types-introspect.h qemu-build/qapi/qapi-types-introspect.c
+GENERATED_FILES += qemu-build/qapi/qapi-types-migration.h qemu-build/qapi/qapi-types-migration.c
+GENERATED_FILES += qemu-build/qapi/qapi-types-misc.h qemu-build/qapi/qapi-types-misc.c
+GENERATED_FILES += qemu-build/qapi/qapi-types-net.h qemu-build/qapi/qapi-types-net.c
+GENERATED_FILES += qemu-build/qapi/qapi-types-rocker.h qemu-build/qapi/qapi-types-rocker.c
+GENERATED_FILES += qemu-build/qapi/qapi-types-run-state.h qemu-build/qapi/qapi-types-run-state.c
+GENERATED_FILES += qemu-build/qapi/qapi-types-sockets.h qemu-build/qapi/qapi-types-sockets.c
+GENERATED_FILES += qemu-build/qapi/qapi-types-tpm.h qemu-build/qapi/qapi-types-tpm.c
+GENERATED_FILES += qemu-build/qapi/qapi-types-trace.h qemu-build/qapi/qapi-types-trace.c
+GENERATED_FILES += qemu-build/qapi/qapi-types-transaction.h qemu-build/qapi/qapi-types-transaction.c
+GENERATED_FILES += qemu-build/qapi/qapi-types-ui.h qemu-build/qapi/qapi-types-ui.c
+GENERATED_FILES += qemu-build/qapi/qapi-builtin-visit.h qemu-build/qapi/qapi-builtin-visit.c
+GENERATED_FILES += qemu-build/qapi/qapi-visit.h qemu-build/qapi/qapi-visit.c
+GENERATED_FILES += qemu-build/qapi/qapi-visit-block-core.h qemu-build/qapi/qapi-visit-block-core.c
+GENERATED_FILES += qemu-build/qapi/qapi-visit-block.h qemu-build/qapi/qapi-visit-block.c
+GENERATED_FILES += qemu-build/qapi/qapi-visit-char.h qemu-build/qapi/qapi-visit-char.c
+GENERATED_FILES += qemu-build/qapi/qapi-visit-common.h qemu-build/qapi/qapi-visit-common.c
+GENERATED_FILES += qemu-build/qapi/qapi-visit-crypto.h qemu-build/qapi/qapi-visit-crypto.c
+GENERATED_FILES += qemu-build/qapi/qapi-visit-introspect.h qemu-build/qapi/qapi-visit-introspect.c
+GENERATED_FILES += qemu-build/qapi/qapi-visit-migration.h qemu-build/qapi/qapi-visit-migration.c
+GENERATED_FILES += qemu-build/qapi/qapi-visit-misc.h qemu-build/qapi/qapi-visit-misc.c
+GENERATED_FILES += qemu-build/qapi/qapi-visit-net.h qemu-build/qapi/qapi-visit-net.c
+GENERATED_FILES += qemu-build/qapi/qapi-visit-rocker.h qemu-build/qapi/qapi-visit-rocker.c
+GENERATED_FILES += qemu-build/qapi/qapi-visit-run-state.h qemu-build/qapi/qapi-visit-run-state.c
+GENERATED_FILES += qemu-build/qapi/qapi-visit-sockets.h qemu-build/qapi/qapi-visit-sockets.c
+GENERATED_FILES += qemu-build/qapi/qapi-visit-tpm.h qemu-build/qapi/qapi-visit-tpm.c
+GENERATED_FILES += qemu-build/qapi/qapi-visit-trace.h qemu-build/qapi/qapi-visit-trace.c
+GENERATED_FILES += qemu-build/qapi/qapi-visit-transaction.h qemu-build/qapi/qapi-visit-transaction.c
+GENERATED_FILES += qemu-build/qapi/qapi-visit-ui.h qemu-build/qapi/qapi-visit-ui.c
+GENERATED_FILES += qemu-build/qapi/qapi-commands.h qemu-build/qapi/qapi-commands.c
+GENERATED_FILES += qemu-build/qapi/qapi-commands-block-core.h qemu-build/qapi/qapi-commands-block-core.c
+GENERATED_FILES += qemu-build/qapi/qapi-commands-block.h qemu-build/qapi/qapi-commands-block.c
+GENERATED_FILES += qemu-build/qapi/qapi-commands-char.h qemu-build/qapi/qapi-commands-char.c
+GENERATED_FILES += qemu-build/qapi/qapi-commands-common.h qemu-build/qapi/qapi-commands-common.c
+GENERATED_FILES += qemu-build/qapi/qapi-commands-crypto.h qemu-build/qapi/qapi-commands-crypto.c
+GENERATED_FILES += qemu-build/qapi/qapi-commands-introspect.h qemu-build/qapi/qapi-commands-introspect.c
+GENERATED_FILES += qemu-build/qapi/qapi-commands-migration.h qemu-build/qapi/qapi-commands-migration.c
+GENERATED_FILES += qemu-build/qapi/qapi-commands-misc.h qemu-build/qapi/qapi-commands-misc.c
+GENERATED_FILES += qemu-build/qapi/qapi-commands-net.h qemu-build/qapi/qapi-commands-net.c
+GENERATED_FILES += qemu-build/qapi/qapi-commands-rocker.h qemu-build/qapi/qapi-commands-rocker.c
+GENERATED_FILES += qemu-build/qapi/qapi-commands-run-state.h qemu-build/qapi/qapi-commands-run-state.c
+GENERATED_FILES += qemu-build/qapi/qapi-commands-sockets.h qemu-build/qapi/qapi-commands-sockets.c
+GENERATED_FILES += qemu-build/qapi/qapi-commands-tpm.h qemu-build/qapi/qapi-commands-tpm.c
+GENERATED_FILES += qemu-build/qapi/qapi-commands-trace.h qemu-build/qapi/qapi-commands-trace.c
+GENERATED_FILES += qemu-build/qapi/qapi-commands-transaction.h qemu-build/qapi/qapi-commands-transaction.c
+GENERATED_FILES += qemu-build/qapi/qapi-commands-ui.h qemu-build/qapi/qapi-commands-ui.c
+GENERATED_FILES += qemu-build/qapi/qapi-events.h qemu-build/qapi/qapi-events.c
+GENERATED_FILES += qemu-build/qapi/qapi-events-block-core.h qemu-build/qapi/qapi-events-block-core.c
+GENERATED_FILES += qemu-build/qapi/qapi-events-block.h qemu-build/qapi/qapi-events-block.c
+GENERATED_FILES += qemu-build/qapi/qapi-events-char.h qemu-build/qapi/qapi-events-char.c
+GENERATED_FILES += qemu-build/qapi/qapi-events-common.h qemu-build/qapi/qapi-events-common.c
+GENERATED_FILES += qemu-build/qapi/qapi-events-crypto.h qemu-build/qapi/qapi-events-crypto.c
+GENERATED_FILES += qemu-build/qapi/qapi-events-introspect.h qemu-build/qapi/qapi-events-introspect.c
+GENERATED_FILES += qemu-build/qapi/qapi-events-migration.h qemu-build/qapi/qapi-events-migration.c
+GENERATED_FILES += qemu-build/qapi/qapi-events-misc.h qemu-build/qapi/qapi-events-misc.c
+GENERATED_FILES += qemu-build/qapi/qapi-events-net.h qemu-build/qapi/qapi-events-net.c
+GENERATED_FILES += qemu-build/qapi/qapi-events-rocker.h qemu-build/qapi/qapi-events-rocker.c
+GENERATED_FILES += qemu-build/qapi/qapi-events-run-state.h qemu-build/qapi/qapi-events-run-state.c
+GENERATED_FILES += qemu-build/qapi/qapi-events-sockets.h qemu-build/qapi/qapi-events-sockets.c
+GENERATED_FILES += qemu-build/qapi/qapi-events-tpm.h qemu-build/qapi/qapi-events-tpm.c
+GENERATED_FILES += qemu-build/qapi/qapi-events-trace.h qemu-build/qapi/qapi-events-trace.c
+GENERATED_FILES += qemu-build/qapi/qapi-events-transaction.h qemu-build/qapi/qapi-events-transaction.c
+GENERATED_FILES += qemu-build/qapi/qapi-events-ui.h qemu-build/qapi/qapi-events-ui.c
+GENERATED_FILES += qemu-build/qapi/qapi-introspect.c qemu-build/qapi/qapi-introspect.h
+GENERATED_FILES += qemu-build/qapi/qapi-doc.texi
+
+GENERATED_FILES += qemu-build/trace/generated-tcg-tracers.h
+
+GENERATED_FILES += qemu-build/trace/generated-helpers-wrappers.h
+GENERATED_FILES += qemu-build/trace/generated-helpers.h
 GENERATED_FILES += trace/generated-helpers.c
 
 ifdef CONFIG_TRACE_UST
-GENERATED_FILES += trace-ust-all.h
+GENERATED_FILES += qemu-build/trace-ust-all.h
 GENERATED_FILES += trace-ust-all.c
 endif
 
-GENERATED_FILES += module_block.h
+GENERATED_FILES += qemu-build/module_block.h
 
-TRACE_HEADERS = trace-root.h $(trace-events-subdirs:%=%/trace.h)
+TRACE_HEADERS = qemu-build/trace-root.h $(trace-events-subdirs:%=qemu-build/%/trace.h)
 TRACE_SOURCES = trace-root.c $(trace-events-subdirs:%=%/trace.c)
 TRACE_DTRACE =
 ifdef CONFIG_TRACE_DTRACE
-TRACE_HEADERS += trace-dtrace-root.h $(trace-events-subdirs:%=%/trace-dtrace.h)
+TRACE_HEADERS += qemu-build/trace-dtrace-root.h $(trace-events-subdirs:%=qemu-build/%/trace-dtrace.h)
 TRACE_DTRACE += trace-dtrace-root.dtrace $(trace-events-subdirs:%=%/trace-dtrace.dtrace)
 endif
 ifdef CONFIG_TRACE_UST
-TRACE_HEADERS += trace-ust-root.h $(trace-events-subdirs:%=%/trace-ust.h)
+TRACE_HEADERS += qemu-build/trace-ust-root.h $(trace-events-subdirs:%=qemu-build/%/trace-ust.h)
 endif
 
 GENERATED_FILES += $(TRACE_HEADERS)
@@ -199,7 +199,15 @@ tracetool-y += $(shell find $(SRC_PATH)/scripts/tracetool -name "*.py")
 
 %/trace.h: %/trace.h-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-%/trace.h-timestamp: $(SRC_PATH)/%/trace-events $(tracetool-y)
+
+%/qemu-build/trace.h:
+	$(call quiet-command, mkdir -p $(dir $@), "MKDIR", $(dir $@))
+	$(call quiet-command, \
+	  echo \#include \"$(patsubst %/qemu-build/trace.h, qemu-build/%/trace.h, $@)\" > $@,
+	  "GEN", $@)
+
+qemu-build/%/trace.h-timestamp: $(SRC_PATH)/%/trace-events $(tracetool-y) %/qemu-build/trace.h
+	$(call quiet-command,mkdir -p $(dir $@), "MKDIR $(dir $@)")
 	$(call quiet-command,$(TRACETOOL) \
 		--group=$(call trace-group-name,$@) \
 		--format=h \
@@ -217,7 +225,7 @@ tracetool-y += $(shell find $(SRC_PATH)/scripts/tracetool -name "*.py")
 
 %/trace-ust.h: %/trace-ust.h-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-%/trace-ust.h-timestamp: $(SRC_PATH)/%/trace-events $(tracetool-y)
+%/qemu-build/trace-ust.h-timestamp: $(SRC_PATH)/%/trace-events $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
 		--group=$(call trace-group-name,$@) \
 		--format=ust-events-h \
@@ -233,15 +241,15 @@ tracetool-y += $(shell find $(SRC_PATH)/scripts/tracetool -name "*.py")
 		--backends=$(TRACE_BACKENDS) \
 		$< > $@,"GEN","$(@:%-timestamp=%)")
 
-%/trace-dtrace.h: %/trace-dtrace.dtrace $(tracetool-y)
+%/qemu-build/trace-dtrace.h: %/trace-dtrace.dtrace $(tracetool-y)
 	$(call quiet-command,dtrace -o $@ -h -s $<, "GEN","$@")
 
 %/trace-dtrace.o: %/trace-dtrace.dtrace $(tracetool-y)
 
 
-trace-root.h: trace-root.h-timestamp
+qemu-build/trace-root.h: qemu-build/trace-root.h-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-trace-root.h-timestamp: $(SRC_PATH)/trace-events $(tracetool-y)
+qemu-build/trace-root.h-timestamp: $(SRC_PATH)/trace-events $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
 		--group=root \
 		--format=h \
@@ -257,18 +265,18 @@ trace-root.c-timestamp: $(SRC_PATH)/trace-events $(tracetool-y)
 		--backends=$(TRACE_BACKENDS) \
 		$< > $@,"GEN","$(@:%-timestamp=%)")
 
-trace-ust-root.h: trace-ust-root.h-timestamp
+qemu-build/trace-ust-root.h: qemu-build/trace-ust-root.h-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-trace-ust-root.h-timestamp: $(SRC_PATH)/trace-events $(tracetool-y)
+qemu-build/trace-ust-root.h-timestamp: $(SRC_PATH)/trace-events $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
 		--group=root \
 		--format=ust-events-h \
 		--backends=$(TRACE_BACKENDS) \
 		$< > $@,"GEN","$(@:%-timestamp=%)")
 
-trace-ust-all.h: trace-ust-all.h-timestamp
+qemu-build/trace-ust-all.h: qemu-build/trace-ust-all.h-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-trace-ust-all.h-timestamp: $(trace-events-files) $(tracetool-y)
+qemu-build/trace-ust-all.h-timestamp: $(trace-events-files) $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
 		--group=all \
 		--format=ust-events-h \
@@ -293,7 +301,7 @@ trace-dtrace-root.dtrace-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config
 		--backends=$(TRACE_BACKENDS) \
 		$< > $@,"GEN","$(@:%-timestamp=%)")
 
-trace-dtrace-root.h: trace-dtrace-root.dtrace
+qemu-build/trace-dtrace-root.h: trace-dtrace-root.dtrace
 	$(call quiet-command,dtrace -o $@ -h -s $<, "GEN","$@")
 
 trace-dtrace-root.o: trace-dtrace-root.dtrace
@@ -302,27 +310,28 @@ KEYCODEMAP_GEN = $(SRC_PATH)/ui/keycodemapdb/tools/keymap-gen
 KEYCODEMAP_CSV = $(SRC_PATH)/ui/keycodemapdb/data/keymaps.csv
 
 KEYCODEMAP_FILES = \
-		 ui/input-keymap-atset1-to-qcode.c \
-		 ui/input-keymap-linux-to-qcode.c \
-		 ui/input-keymap-qcode-to-atset1.c \
-		 ui/input-keymap-qcode-to-atset2.c \
-		 ui/input-keymap-qcode-to-atset3.c \
-		 ui/input-keymap-qcode-to-linux.c \
-		 ui/input-keymap-qcode-to-qnum.c \
-		 ui/input-keymap-qcode-to-sun.c \
-		 ui/input-keymap-qnum-to-qcode.c \
-		 ui/input-keymap-usb-to-qcode.c \
-		 ui/input-keymap-win32-to-qcode.c \
-		 ui/input-keymap-x11-to-qcode.c \
-		 ui/input-keymap-xorgevdev-to-qcode.c \
-		 ui/input-keymap-xorgkbd-to-qcode.c \
-		 ui/input-keymap-xorgxquartz-to-qcode.c \
-		 ui/input-keymap-xorgxwin-to-qcode.c \
+		 qemu-build/ui/input-keymap-atset1-to-qcode.c \
+		 qemu-build/ui/input-keymap-linux-to-qcode.c \
+		 qemu-build/ui/input-keymap-qcode-to-atset1.c \
+		 qemu-build/ui/input-keymap-qcode-to-atset2.c \
+		 qemu-build/ui/input-keymap-qcode-to-atset3.c \
+		 qemu-build/ui/input-keymap-qcode-to-linux.c \
+		 qemu-build/ui/input-keymap-qcode-to-qnum.c \
+		 qemu-build/ui/input-keymap-qcode-to-sun.c \
+		 qemu-build/ui/input-keymap-qnum-to-qcode.c \
+		 qemu-build/ui/input-keymap-usb-to-qcode.c \
+		 qemu-build/ui/input-keymap-win32-to-qcode.c \
+		 qemu-build/ui/input-keymap-x11-to-qcode.c \
+		 qemu-build/ui/input-keymap-xorgevdev-to-qcode.c \
+		 qemu-build/ui/input-keymap-xorgkbd-to-qcode.c \
+		 qemu-build/ui/input-keymap-xorgxquartz-to-qcode.c \
+		 qemu-build/ui/input-keymap-xorgxwin-to-qcode.c \
 		 $(NULL)
 
 GENERATED_FILES += $(KEYCODEMAP_FILES)
 
-ui/input-keymap-%.c: $(KEYCODEMAP_GEN) $(KEYCODEMAP_CSV) $(SRC_PATH)/ui/Makefile.objs
+qemu-build/ui/input-keymap-%.c: $(KEYCODEMAP_GEN) $(KEYCODEMAP_CSV) $(SRC_PATH)/ui/Makefile.objs
+	$(call quiet-command,mkdir -p $(dir $@), "MKDIR $(dir $@)")
 	$(call quiet-command,\
 	    stem=$* && src=$${stem%-to-*} dst=$${stem#*-to-} && \
 	    test -e $(KEYCODEMAP_GEN) && \
@@ -435,7 +444,8 @@ include $(SRC_PATH)/tests/Makefile.include
 
 all: $(DOCS) $(TOOLS) $(HELPERS-y) recurse-all modules
 
-qemu-version.h: FORCE
+qemu-build/qemu-version.h: FORCE
+	$(call quiet-command, mkdir -p qemu-build)
 	$(call quiet-command, \
 		(cd $(SRC_PATH); \
 		printf '#define QEMU_PKGVERSION '; \
@@ -459,9 +469,9 @@ qemu-version.h: FORCE
 	  rm $@.tmp; \
 	 fi)
 
-config-host.h: config-host.h-timestamp
-config-host.h-timestamp: config-host.mak
-qemu-options.def: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
+qemu-build/config-host.h: qemu-build/config-host.h-timestamp
+qemu-build/config-host.h-timestamp: config-host.mak
+qemu-build/qemu-options.def: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$@")
 
 SUBDIR_RULES=$(patsubst %,subdir-%, $(TARGET_DIRS))
@@ -527,7 +537,7 @@ libvhost-user.a: $(libvhost-user-obj-y)
 
 COMMON_LDADDS = libqemuutil.a
 
-qemu-img.o: qemu-img-cmds.h
+qemu-img.o: qemu-build/qemu-img-cmds.h
 
 qemu-img$(EXESUF): qemu-img.o $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 qemu-nbd$(EXESUF): qemu-nbd.o $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
@@ -545,11 +555,12 @@ ifdef CONFIG_MPATH
 scsi/qemu-pr-helper$(EXESUF): LIBS += -ludev -lmultipath -lmpathpersist
 endif
 
-qemu-img-cmds.h: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
+qemu-build/qemu-img-cmds.h: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
+	@mkdir -p $(dir $@)
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$@")
 
 qemu-ga$(EXESUF): LIBS = $(LIBS_QGA)
-qemu-ga$(EXESUF): QEMU_CFLAGS += -I qga/qapi-generated
+qemu-ga$(EXESUF): QEMU_CFLAGS += -iquote qga/qapi-generated
 
 qemu-keymap$(EXESUF): LIBS += $(XKBCOMMON_LIBS)
 qemu-keymap$(EXESUF): QEMU_CFLAGS += $(XKBCOMMON_CFLAGS)
@@ -591,82 +602,82 @@ qapi-modules = $(SRC_PATH)/qapi/qapi-schema.json $(SRC_PATH)/qapi/common.json \
                $(SRC_PATH)/qapi/transaction.json \
                $(SRC_PATH)/qapi/ui.json
 
-qapi/qapi-builtin-types.c qapi/qapi-builtin-types.h \
-qapi/qapi-types.c qapi/qapi-types.h \
-qapi/qapi-types-block-core.c qapi/qapi-types-block-core.h \
-qapi/qapi-types-block.c qapi/qapi-types-block.h \
-qapi/qapi-types-char.c qapi/qapi-types-char.h \
-qapi/qapi-types-common.c qapi/qapi-types-common.h \
-qapi/qapi-types-crypto.c qapi/qapi-types-crypto.h \
-qapi/qapi-types-introspect.c qapi/qapi-types-introspect.h \
-qapi/qapi-types-migration.c qapi/qapi-types-migration.h \
-qapi/qapi-types-misc.c qapi/qapi-types-misc.h \
-qapi/qapi-types-net.c qapi/qapi-types-net.h \
-qapi/qapi-types-rocker.c qapi/qapi-types-rocker.h \
-qapi/qapi-types-run-state.c qapi/qapi-types-run-state.h \
-qapi/qapi-types-sockets.c qapi/qapi-types-sockets.h \
-qapi/qapi-types-tpm.c qapi/qapi-types-tpm.h \
-qapi/qapi-types-trace.c qapi/qapi-types-trace.h \
-qapi/qapi-types-transaction.c qapi/qapi-types-transaction.h \
-qapi/qapi-types-ui.c qapi/qapi-types-ui.h \
-qapi/qapi-builtin-visit.c qapi/qapi-builtin-visit.h \
-qapi/qapi-visit.c qapi/qapi-visit.h \
-qapi/qapi-visit-block-core.c qapi/qapi-visit-block-core.h \
-qapi/qapi-visit-block.c qapi/qapi-visit-block.h \
-qapi/qapi-visit-char.c qapi/qapi-visit-char.h \
-qapi/qapi-visit-common.c qapi/qapi-visit-common.h \
-qapi/qapi-visit-crypto.c qapi/qapi-visit-crypto.h \
-qapi/qapi-visit-introspect.c qapi/qapi-visit-introspect.h \
-qapi/qapi-visit-migration.c qapi/qapi-visit-migration.h \
-qapi/qapi-visit-misc.c qapi/qapi-visit-misc.h \
-qapi/qapi-visit-net.c qapi/qapi-visit-net.h \
-qapi/qapi-visit-rocker.c qapi/qapi-visit-rocker.h \
-qapi/qapi-visit-run-state.c qapi/qapi-visit-run-state.h \
-qapi/qapi-visit-sockets.c qapi/qapi-visit-sockets.h \
-qapi/qapi-visit-tpm.c qapi/qapi-visit-tpm.h \
-qapi/qapi-visit-trace.c qapi/qapi-visit-trace.h \
-qapi/qapi-visit-transaction.c qapi/qapi-visit-transaction.h \
-qapi/qapi-visit-ui.c qapi/qapi-visit-ui.h \
-qapi/qapi-commands.h qapi/qapi-commands.c \
-qapi/qapi-commands-block-core.c qapi/qapi-commands-block-core.h \
-qapi/qapi-commands-block.c qapi/qapi-commands-block.h \
-qapi/qapi-commands-char.c qapi/qapi-commands-char.h \
-qapi/qapi-commands-common.c qapi/qapi-commands-common.h \
-qapi/qapi-commands-crypto.c qapi/qapi-commands-crypto.h \
-qapi/qapi-commands-introspect.c qapi/qapi-commands-introspect.h \
-qapi/qapi-commands-migration.c qapi/qapi-commands-migration.h \
-qapi/qapi-commands-misc.c qapi/qapi-commands-misc.h \
-qapi/qapi-commands-net.c qapi/qapi-commands-net.h \
-qapi/qapi-commands-rocker.c qapi/qapi-commands-rocker.h \
-qapi/qapi-commands-run-state.c qapi/qapi-commands-run-state.h \
-qapi/qapi-commands-sockets.c qapi/qapi-commands-sockets.h \
-qapi/qapi-commands-tpm.c qapi/qapi-commands-tpm.h \
-qapi/qapi-commands-trace.c qapi/qapi-commands-trace.h \
-qapi/qapi-commands-transaction.c qapi/qapi-commands-transaction.h \
-qapi/qapi-commands-ui.c qapi/qapi-commands-ui.h \
-qapi/qapi-events.c qapi/qapi-events.h \
-qapi/qapi-events-block-core.c qapi/qapi-events-block-core.h \
-qapi/qapi-events-block.c qapi/qapi-events-block.h \
-qapi/qapi-events-char.c qapi/qapi-events-char.h \
-qapi/qapi-events-common.c qapi/qapi-events-common.h \
-qapi/qapi-events-crypto.c qapi/qapi-events-crypto.h \
-qapi/qapi-events-introspect.c qapi/qapi-events-introspect.h \
-qapi/qapi-events-migration.c qapi/qapi-events-migration.h \
-qapi/qapi-events-misc.c qapi/qapi-events-misc.h \
-qapi/qapi-events-net.c qapi/qapi-events-net.h \
-qapi/qapi-events-rocker.c qapi/qapi-events-rocker.h \
-qapi/qapi-events-run-state.c qapi/qapi-events-run-state.h \
-qapi/qapi-events-sockets.c qapi/qapi-events-sockets.h \
-qapi/qapi-events-tpm.c qapi/qapi-events-tpm.h \
-qapi/qapi-events-trace.c qapi/qapi-events-trace.h \
-qapi/qapi-events-transaction.c qapi/qapi-events-transaction.h \
-qapi/qapi-events-ui.c qapi/qapi-events-ui.h \
-qapi/qapi-introspect.h qapi/qapi-introspect.c \
-qapi/qapi-doc.texi: \
-qapi-gen-timestamp ;
-qapi-gen-timestamp: $(qapi-modules) $(qapi-py)
+qemu-build/qapi/qapi-builtin-types.c qemu-build/qapi/qapi-builtin-types.h \
+qemu-build/qapi/qapi-types.c qemu-build/qapi/qapi-types.h \
+qemu-build/qapi/qapi-types-block-core.c qemu-build/qapi/qapi-types-block-core.h \
+qemu-build/qapi/qapi-types-block.c qemu-build/qapi/qapi-types-block.h \
+qemu-build/qapi/qapi-types-char.c qemu-build/qapi/qapi-types-char.h \
+qemu-build/qapi/qapi-types-common.c qemu-build/qapi/qapi-types-common.h \
+qemu-build/qapi/qapi-types-crypto.c qemu-build/qapi/qapi-types-crypto.h \
+qemu-build/qapi/qapi-types-introspect.c qemu-build/qapi/qapi-types-introspect.h \
+qemu-build/qapi/qapi-types-migration.c qemu-build/qapi/qapi-types-migration.h \
+qemu-build/qapi/qapi-types-misc.c qemu-build/qapi/qapi-types-misc.h \
+qemu-build/qapi/qapi-types-net.c qemu-build/qapi/qapi-types-net.h \
+qemu-build/qapi/qapi-types-rocker.c qemu-build/qapi/qapi-types-rocker.h \
+qemu-build/qapi/qapi-types-run-state.c qemu-build/qapi/qapi-types-run-state.h \
+qemu-build/qapi/qapi-types-sockets.c qemu-build/qapi/qapi-types-sockets.h \
+qemu-build/qapi/qapi-types-tpm.c qemu-build/qapi/qapi-types-tpm.h \
+qemu-build/qapi/qapi-types-trace.c qemu-build/qapi/qapi-types-trace.h \
+qemu-build/qapi/qapi-types-transaction.c qemu-build/qapi/qapi-types-transaction.h \
+qemu-build/qapi/qapi-types-ui.c qemu-build/qapi/qapi-types-ui.h \
+qemu-build/qapi/qapi-builtin-visit.c qemu-build/qapi/qapi-builtin-visit.h \
+qemu-build/qapi/qapi-visit.c qemu-build/qapi/qapi-visit.h \
+qemu-build/qapi/qapi-visit-block-core.c qemu-build/qapi/qapi-visit-block-core.h \
+qemu-build/qapi/qapi-visit-block.c qemu-build/qapi/qapi-visit-block.h \
+qemu-build/qapi/qapi-visit-char.c qemu-build/qapi/qapi-visit-char.h \
+qemu-build/qapi/qapi-visit-common.c qemu-build/qapi/qapi-visit-common.h \
+qemu-build/qapi/qapi-visit-crypto.c qemu-build/qapi/qapi-visit-crypto.h \
+qemu-build/qapi/qapi-visit-introspect.c qemu-build/qapi/qapi-visit-introspect.h \
+qemu-build/qapi/qapi-visit-migration.c qemu-build/qapi/qapi-visit-migration.h \
+qemu-build/qapi/qapi-visit-misc.c qemu-build/qapi/qapi-visit-misc.h \
+qemu-build/qapi/qapi-visit-net.c qemu-build/qapi/qapi-visit-net.h \
+qemu-build/qapi/qapi-visit-rocker.c qemu-build/qapi/qapi-visit-rocker.h \
+qemu-build/qapi/qapi-visit-run-state.c qemu-build/qapi/qapi-visit-run-state.h \
+qemu-build/qapi/qapi-visit-sockets.c qemu-build/qapi/qapi-visit-sockets.h \
+qemu-build/qapi/qapi-visit-tpm.c qemu-build/qapi/qapi-visit-tpm.h \
+qemu-build/qapi/qapi-visit-trace.c qemu-build/qapi/qapi-visit-trace.h \
+qemu-build/qapi/qapi-visit-transaction.c qemu-build/qapi/qapi-visit-transaction.h \
+qemu-build/qapi/qapi-visit-ui.c qemu-build/qapi/qapi-visit-ui.h \
+qemu-build/qapi/qapi-commands.h qemu-build/qapi/qapi-commands.c \
+qemu-build/qapi/qapi-commands-block-core.c qemu-build/qapi/qapi-commands-block-core.h \
+qemu-build/qapi/qapi-commands-block.c qemu-build/qapi/qapi-commands-block.h \
+qemu-build/qapi/qapi-commands-char.c qemu-build/qapi/qapi-commands-char.h \
+qemu-build/qapi/qapi-commands-common.c qemu-build/qapi/qapi-commands-common.h \
+qemu-build/qapi/qapi-commands-crypto.c qemu-build/qapi/qapi-commands-crypto.h \
+qemu-build/qapi/qapi-commands-introspect.c qemu-build/qapi/qapi-commands-introspect.h \
+qemu-build/qapi/qapi-commands-migration.c qemu-build/qapi/qapi-commands-migration.h \
+qemu-build/qapi/qapi-commands-misc.c qemu-build/qapi/qapi-commands-misc.h \
+qemu-build/qapi/qapi-commands-net.c qemu-build/qapi/qapi-commands-net.h \
+qemu-build/qapi/qapi-commands-rocker.c qemu-build/qapi/qapi-commands-rocker.h \
+qemu-build/qapi/qapi-commands-run-state.c qemu-build/qapi/qapi-commands-run-state.h \
+qemu-build/qapi/qapi-commands-sockets.c qemu-build/qapi/qapi-commands-sockets.h \
+qemu-build/qapi/qapi-commands-tpm.c qemu-build/qapi/qapi-commands-tpm.h \
+qemu-build/qapi/qapi-commands-trace.c qemu-build/qapi/qapi-commands-trace.h \
+qemu-build/qapi/qapi-commands-transaction.c qemu-build/qapi/qapi-commands-transaction.h \
+qemu-build/qapi/qapi-commands-ui.c qemu-build/qapi/qapi-commands-ui.h \
+qemu-build/qapi/qapi-events.c qemu-build/qapi/qapi-events.h \
+qemu-build/qapi/qapi-events-block-core.c qemu-build/qapi/qapi-events-block-core.h \
+qemu-build/qapi/qapi-events-block.c qemu-build/qapi/qapi-events-block.h \
+qemu-build/qapi/qapi-events-char.c qemu-build/qapi/qapi-events-char.h \
+qemu-build/qapi/qapi-events-common.c qemu-build/qapi/qapi-events-common.h \
+qemu-build/qapi/qapi-events-crypto.c qemu-build/qapi/qapi-events-crypto.h \
+qemu-build/qapi/qapi-events-introspect.c qemu-build/qapi/qapi-events-introspect.h \
+qemu-build/qapi/qapi-events-migration.c qemu-build/qapi/qapi-events-migration.h \
+qemu-build/qapi/qapi-events-misc.c qemu-build/qapi/qapi-events-misc.h \
+qemu-build/qapi/qapi-events-net.c qemu-build/qapi/qapi-events-net.h \
+qemu-build/qapi/qapi-events-rocker.c qemu-build/qapi/qapi-events-rocker.h \
+qemu-build/qapi/qapi-events-run-state.c qemu-build/qapi/qapi-events-run-state.h \
+qemu-build/qapi/qapi-events-sockets.c qemu-build/qapi/qapi-events-sockets.h \
+qemu-build/qapi/qapi-events-tpm.c qemu-build/qapi/qapi-events-tpm.h \
+qemu-build/qapi/qapi-events-trace.c qemu-build/qapi/qapi-events-trace.h \
+qemu-build/qapi/qapi-events-transaction.c qemu-build/qapi/qapi-events-transaction.h \
+qemu-build/qapi/qapi-events-ui.c qemu-build/qapi/qapi-events-ui.h \
+qemu-build/qapi/qapi-introspect.h qemu-build/qapi/qapi-introspect.c \
+qemu-build/qapi/qapi-doc.texi: \
+qemu-build/qapi-gen-timestamp ;
+qemu-build/qapi-gen-timestamp: $(qapi-modules) $(qapi-py)
 	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi-gen.py \
-		-o "qapi" -b $<, \
+		-o "qemu-build/qapi" -b $<, \
 		"GEN","$(@:%-timestamp=%)")
 	@>$@
 
@@ -709,7 +720,7 @@ vhost-user-scsi$(EXESUF): $(vhost-user-scsi-obj-y) libvhost-user.a
 vhost-user-blk$(EXESUF): $(vhost-user-blk-obj-y) libvhost-user.a
 	$(call LINK, $^)
 
-module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.mak
+qemu-build/module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.mak
 	$(call quiet-command,$(PYTHON) $< $@ \
 	$(addprefix $(SRC_PATH)/,$(patsubst %.mo,%.c,$(block-obj-m))), \
 	"GEN","$@")
@@ -723,7 +734,7 @@ clean:
 	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) qemu-ga TAGS cscope.* *.pod *~ */*~
 	rm -f fsdev/*.pod scsi/*.pod
 	rm -f qemu-img-cmds.h
-	rm -f ui/shader/*-vert.h ui/shader/*-frag.h
+	rm -f qemu-build/ui/shader/*-vert.h qemu-build/ui/shader/*-frag.h
 	@# May not be present in GENERATED_FILES
 	rm -f trace/generated-tracers-dtrace.dtrace*
 	rm -f trace/generated-tracers-dtrace.h*
@@ -735,6 +746,7 @@ clean:
 	rm -f $$d/qemu-options.def; \
         done
 	rm -f $(SUBDIR_DEVICES_MAK) config-all-devices.mak
+	find . -name 'qemu-build' -exec rm -fr {} +
 
 VERSION ?= $(shell cat VERSION)
 
@@ -882,22 +894,22 @@ cscope:
 	cscope -b -i"$(SRC_PATH)/cscope.files"
 
 # opengl shader programs
-ui/shader/%-vert.h: $(SRC_PATH)/ui/shader/%.vert $(SRC_PATH)/scripts/shaderinclude.pl
+qemu-build/ui/shader/%-vert.h: $(SRC_PATH)/ui/shader/%.vert $(SRC_PATH)/scripts/shaderinclude.pl
 	@mkdir -p $(dir $@)
 	$(call quiet-command,\
 		perl $(SRC_PATH)/scripts/shaderinclude.pl $< > $@,\
 		"VERT","$@")
 
-ui/shader/%-frag.h: $(SRC_PATH)/ui/shader/%.frag $(SRC_PATH)/scripts/shaderinclude.pl
+qemu-build/ui/shader/%-frag.h: $(SRC_PATH)/ui/shader/%.frag $(SRC_PATH)/scripts/shaderinclude.pl
 	@mkdir -p $(dir $@)
 	$(call quiet-command,\
 		perl $(SRC_PATH)/scripts/shaderinclude.pl $< > $@,\
 		"FRAG","$@")
 
 ui/shader.o: $(SRC_PATH)/ui/shader.c \
-	ui/shader/texture-blit-vert.h \
-	ui/shader/texture-blit-flip-vert.h \
-	ui/shader/texture-blit-frag.h
+	qemu-build/ui/shader/texture-blit-vert.h \
+	qemu-build/ui/shader/texture-blit-flip-vert.h \
+	qemu-build/ui/shader/texture-blit-frag.h
 
 # documentation
 MAKEINFO=makeinfo
@@ -935,7 +947,7 @@ qemu-monitor-info.texi: $(SRC_PATH)/hmp-commands-info.hx $(SRC_PATH)/scripts/hxt
 qemu-img-cmds.texi: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","$@")
 
-docs/interop/qemu-qmp-qapi.texi: qapi/qapi-doc.texi
+docs/interop/qemu-qmp-qapi.texi: qemu-build/qapi/qapi-doc.texi
 	@cp -p $< $@
 
 docs/interop/qemu-ga-qapi.texi: qga/qapi-generated/qga-qapi-doc.texi
diff --git a/rules.mak b/rules.mak
index 93a0702..97342fb 100644
--- a/rules.mak
+++ b/rules.mak
@@ -191,10 +191,11 @@ TRACETOOL=$(PYTHON) $(SRC_PATH)/scripts/tracetool.py
 
 # Generate timestamp files for .h include files
 
-config-%.h: config-%.h-timestamp
+qemu-build/config-%.h: qemu-build/config-%.h-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
 
-config-%.h-timestamp: config-%.mak $(SRC_PATH)/scripts/create_config
+qemu-build/config-%.h-timestamp: config-%.mak $(SRC_PATH)/scripts/create_config
+	$(call quiet-command,mkdir -p $(dir $@), "MKDIR $(dir $@)")
 	$(call quiet-command, sh $(SRC_PATH)/scripts/create_config < $< > $@,"GEN","$(TARGET_DIR)config-$*.h")
 
 .PHONY: clean-timestamp
diff --git a/.gitignore b/.gitignore
index 4055e12..e876a64 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,3 +1,4 @@
+**/qemu-build/
 /config-devices.*
 /config-all-devices.*
 /config-all-disas.*
diff --git a/Makefile.objs b/Makefile.objs
index c6c9b8f..4c10699 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -2,60 +2,60 @@
 # Common libraries for tools and emulators
 stub-obj-y = stubs/ crypto/
 util-obj-y = util/ qobject/ qapi/
-util-obj-y += qapi/qapi-builtin-types.o
-util-obj-y += qapi/qapi-types.o
-util-obj-y += qapi/qapi-types-block-core.o
-util-obj-y += qapi/qapi-types-block.o
-util-obj-y += qapi/qapi-types-char.o
-util-obj-y += qapi/qapi-types-common.o
-util-obj-y += qapi/qapi-types-crypto.o
-util-obj-y += qapi/qapi-types-introspect.o
-util-obj-y += qapi/qapi-types-migration.o
-util-obj-y += qapi/qapi-types-misc.o
-util-obj-y += qapi/qapi-types-net.o
-util-obj-y += qapi/qapi-types-rocker.o
-util-obj-y += qapi/qapi-types-run-state.o
-util-obj-y += qapi/qapi-types-sockets.o
-util-obj-y += qapi/qapi-types-tpm.o
-util-obj-y += qapi/qapi-types-trace.o
-util-obj-y += qapi/qapi-types-transaction.o
-util-obj-y += qapi/qapi-types-ui.o
-util-obj-y += qapi/qapi-builtin-visit.o
-util-obj-y += qapi/qapi-visit.o
-util-obj-y += qapi/qapi-visit-block-core.o
-util-obj-y += qapi/qapi-visit-block.o
-util-obj-y += qapi/qapi-visit-char.o
-util-obj-y += qapi/qapi-visit-common.o
-util-obj-y += qapi/qapi-visit-crypto.o
-util-obj-y += qapi/qapi-visit-introspect.o
-util-obj-y += qapi/qapi-visit-migration.o
-util-obj-y += qapi/qapi-visit-misc.o
-util-obj-y += qapi/qapi-visit-net.o
-util-obj-y += qapi/qapi-visit-rocker.o
-util-obj-y += qapi/qapi-visit-run-state.o
-util-obj-y += qapi/qapi-visit-sockets.o
-util-obj-y += qapi/qapi-visit-tpm.o
-util-obj-y += qapi/qapi-visit-trace.o
-util-obj-y += qapi/qapi-visit-transaction.o
-util-obj-y += qapi/qapi-visit-ui.o
-util-obj-y += qapi/qapi-events.o
-util-obj-y += qapi/qapi-events-block-core.o
-util-obj-y += qapi/qapi-events-block.o
-util-obj-y += qapi/qapi-events-char.o
-util-obj-y += qapi/qapi-events-common.o
-util-obj-y += qapi/qapi-events-crypto.o
-util-obj-y += qapi/qapi-events-introspect.o
-util-obj-y += qapi/qapi-events-migration.o
-util-obj-y += qapi/qapi-events-misc.o
-util-obj-y += qapi/qapi-events-net.o
-util-obj-y += qapi/qapi-events-rocker.o
-util-obj-y += qapi/qapi-events-run-state.o
-util-obj-y += qapi/qapi-events-sockets.o
-util-obj-y += qapi/qapi-events-tpm.o
-util-obj-y += qapi/qapi-events-trace.o
-util-obj-y += qapi/qapi-events-transaction.o
-util-obj-y += qapi/qapi-events-ui.o
-util-obj-y += qapi/qapi-introspect.o
+util-obj-y += qemu-build/qapi/qapi-builtin-types.o
+util-obj-y += qemu-build/qapi/qapi-types.o
+util-obj-y += qemu-build/qapi/qapi-types-block-core.o
+util-obj-y += qemu-build/qapi/qapi-types-block.o
+util-obj-y += qemu-build/qapi/qapi-types-char.o
+util-obj-y += qemu-build/qapi/qapi-types-common.o
+util-obj-y += qemu-build/qapi/qapi-types-crypto.o
+util-obj-y += qemu-build/qapi/qapi-types-introspect.o
+util-obj-y += qemu-build/qapi/qapi-types-migration.o
+util-obj-y += qemu-build/qapi/qapi-types-misc.o
+util-obj-y += qemu-build/qapi/qapi-types-net.o
+util-obj-y += qemu-build/qapi/qapi-types-rocker.o
+util-obj-y += qemu-build/qapi/qapi-types-run-state.o
+util-obj-y += qemu-build/qapi/qapi-types-sockets.o
+util-obj-y += qemu-build/qapi/qapi-types-tpm.o
+util-obj-y += qemu-build/qapi/qapi-types-trace.o
+util-obj-y += qemu-build/qapi/qapi-types-transaction.o
+util-obj-y += qemu-build/qapi/qapi-types-ui.o
+util-obj-y += qemu-build/qapi/qapi-builtin-visit.o
+util-obj-y += qemu-build/qapi/qapi-visit.o
+util-obj-y += qemu-build/qapi/qapi-visit-block-core.o
+util-obj-y += qemu-build/qapi/qapi-visit-block.o
+util-obj-y += qemu-build/qapi/qapi-visit-char.o
+util-obj-y += qemu-build/qapi/qapi-visit-common.o
+util-obj-y += qemu-build/qapi/qapi-visit-crypto.o
+util-obj-y += qemu-build/qapi/qapi-visit-introspect.o
+util-obj-y += qemu-build/qapi/qapi-visit-migration.o
+util-obj-y += qemu-build/qapi/qapi-visit-misc.o
+util-obj-y += qemu-build/qapi/qapi-visit-net.o
+util-obj-y += qemu-build/qapi/qapi-visit-rocker.o
+util-obj-y += qemu-build/qapi/qapi-visit-run-state.o
+util-obj-y += qemu-build/qapi/qapi-visit-sockets.o
+util-obj-y += qemu-build/qapi/qapi-visit-tpm.o
+util-obj-y += qemu-build/qapi/qapi-visit-trace.o
+util-obj-y += qemu-build/qapi/qapi-visit-transaction.o
+util-obj-y += qemu-build/qapi/qapi-visit-ui.o
+util-obj-y += qemu-build/qapi/qapi-events.o
+util-obj-y += qemu-build/qapi/qapi-events-block-core.o
+util-obj-y += qemu-build/qapi/qapi-events-block.o
+util-obj-y += qemu-build/qapi/qapi-events-char.o
+util-obj-y += qemu-build/qapi/qapi-events-common.o
+util-obj-y += qemu-build/qapi/qapi-events-crypto.o
+util-obj-y += qemu-build/qapi/qapi-events-introspect.o
+util-obj-y += qemu-build/qapi/qapi-events-migration.o
+util-obj-y += qemu-build/qapi/qapi-events-misc.o
+util-obj-y += qemu-build/qapi/qapi-events-net.o
+util-obj-y += qemu-build/qapi/qapi-events-rocker.o
+util-obj-y += qemu-build/qapi/qapi-events-run-state.o
+util-obj-y += qemu-build/qapi/qapi-events-sockets.o
+util-obj-y += qemu-build/qapi/qapi-events-tpm.o
+util-obj-y += qemu-build/qapi/qapi-events-trace.o
+util-obj-y += qemu-build/qapi/qapi-events-transaction.o
+util-obj-y += qemu-build/qapi/qapi-events-ui.o
+util-obj-y += qemu-build/qapi/qapi-introspect.o
 
 chardev-obj-y = chardev/
 
@@ -133,24 +133,24 @@ common-obj-$(CONFIG_FDT) += device_tree.o
 ######################################################################
 # qapi
 
-common-obj-y += qapi/qapi-commands.o
-common-obj-y += qapi/qapi-commands-block-core.o
-common-obj-y += qapi/qapi-commands-block.o
-common-obj-y += qapi/qapi-commands-char.o
-common-obj-y += qapi/qapi-commands-common.o
-common-obj-y += qapi/qapi-commands-crypto.o
-common-obj-y += qapi/qapi-commands-introspect.o
-common-obj-y += qapi/qapi-commands-migration.o
-common-obj-y += qapi/qapi-commands-misc.o
-common-obj-y += qapi/qapi-commands-net.o
-common-obj-y += qapi/qapi-commands-rocker.o
-common-obj-y += qapi/qapi-commands-run-state.o
-common-obj-y += qapi/qapi-commands-sockets.o
-common-obj-y += qapi/qapi-commands-tpm.o
-common-obj-y += qapi/qapi-commands-trace.o
-common-obj-y += qapi/qapi-commands-transaction.o
-common-obj-y += qapi/qapi-commands-ui.o
-common-obj-y += qapi/qapi-introspect.o
+common-obj-y += qemu-build/qapi/qapi-commands.o
+common-obj-y += qemu-build/qapi/qapi-commands-block-core.o
+common-obj-y += qemu-build/qapi/qapi-commands-block.o
+common-obj-y += qemu-build/qapi/qapi-commands-char.o
+common-obj-y += qemu-build/qapi/qapi-commands-common.o
+common-obj-y += qemu-build/qapi/qapi-commands-crypto.o
+common-obj-y += qemu-build/qapi/qapi-commands-introspect.o
+common-obj-y += qemu-build/qapi/qapi-commands-migration.o
+common-obj-y += qemu-build/qapi/qapi-commands-misc.o
+common-obj-y += qemu-build/qapi/qapi-commands-net.o
+common-obj-y += qemu-build/qapi/qapi-commands-rocker.o
+common-obj-y += qemu-build/qapi/qapi-commands-run-state.o
+common-obj-y += qemu-build/qapi/qapi-commands-sockets.o
+common-obj-y += qemu-build/qapi/qapi-commands-tpm.o
+common-obj-y += qemu-build/qapi/qapi-commands-trace.o
+common-obj-y += qemu-build/qapi/qapi-commands-transaction.o
+common-obj-y += qemu-build/qapi/qapi-commands-ui.o
+common-obj-y += qemu-build/qapi/qapi-introspect.o
 common-obj-y += qmp.o hmp.o
 endif
 
diff --git a/Makefile.target b/Makefile.target
index d0ec77a..1e6bc68 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -36,8 +36,8 @@ endif
 PROGS=$(QEMU_PROG) $(QEMU_PROGW)
 STPFILES=
 
-config-target.h: config-target.h-timestamp
-config-target.h-timestamp: config-target.mak
+qemu-build/config-target.h: qemu-build/config-target.h-timestamp
+qemu-build/config-target.h-timestamp: config-target.mak
 
 ifdef CONFIG_TRACE_SYSTEMTAP
 stap: $(QEMU_PROG).stp-installed $(QEMU_PROG).stp $(QEMU_PROG)-simpletrace.stp
@@ -100,7 +100,7 @@ obj-$(CONFIG_TCG_INTERPRETER) += disas/tci.o
 obj-y += fpu/softfloat.o
 obj-y += target/$(TARGET_BASE_ARCH)/
 obj-y += disas.o
-obj-$(call notempty,$(TARGET_XML_FILES)) += gdbstub-xml.o
+obj-$(call notempty,$(TARGET_XML_FILES)) += qemu-build/gdbstub-xml.o
 
 #########################################################
 # Linux user emulator target
@@ -148,7 +148,7 @@ else
 obj-y += hw/$(TARGET_BASE_ARCH)/
 endif
 
-GENERATED_FILES += hmp-commands.h hmp-commands-info.h
+GENERATED_FILES += qemu-build/hmp-commands.h qemu-build/hmp-commands-info.h
 
 endif # CONFIG_SOFTMMU
 
@@ -196,19 +196,22 @@ ifdef CONFIG_DARWIN
 	$(call quiet-command,SetFile -a C $@,"SETFILE","$(TARGET_DIR)$@")
 endif
 
-gdbstub-xml.c: $(TARGET_XML_FILES) $(SRC_PATH)/scripts/feature_to_c.sh
+qemu-build/gdbstub-xml.c: $(TARGET_XML_FILES) $(SRC_PATH)/scripts/feature_to_c.sh
+	$(call quiet-command,mkdir -p $(dir $@), "MKDIR $(dir $@)")
 	$(call quiet-command,rm -f $@ && $(SHELL) $(SRC_PATH)/scripts/feature_to_c.sh $@ $(TARGET_XML_FILES),"GEN","$(TARGET_DIR)$@")
 
-hmp-commands.h: $(SRC_PATH)/hmp-commands.hx $(SRC_PATH)/scripts/hxtool
+qemu-build/hmp-commands.h: $(SRC_PATH)/hmp-commands.hx $(SRC_PATH)/scripts/hxtool
+	$(call quiet-command,mkdir -p $(dir $@), "MKDIR $(dir $@)")
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$(TARGET_DIR)$@")
 
-hmp-commands-info.h: $(SRC_PATH)/hmp-commands-info.hx $(SRC_PATH)/scripts/hxtool
+qemu-build/hmp-commands-info.h: $(SRC_PATH)/hmp-commands-info.hx $(SRC_PATH)/scripts/hxtool
+	$(call quiet-command,mkdir -p $(dir $@), "MKDIR $(dir $@)")
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$(TARGET_DIR)$@")
 
 clean: clean-target
 	rm -f *.a *~ $(PROGS)
 	rm -f $(shell find . -name '*.[od]')
-	rm -f hmp-commands.h gdbstub-xml.c
+	rm -f qemu-build/hmp-commands.h qemu-build/gdbstub-xml.c
 ifdef CONFIG_TRACE_SYSTEMTAP
 	rm -f *.stp
 endif
@@ -223,5 +226,5 @@ ifdef CONFIG_TRACE_SYSTEMTAP
 	$(INSTALL_DATA) $(QEMU_PROG)-simpletrace.stp "$(DESTDIR)$(qemu_datadir)/../systemtap/tapset/$(QEMU_PROG)-simpletrace.stp"
 endif
 
-GENERATED_FILES += config-target.h
+GENERATED_FILES += qemu-build/config-target.h
 Makefile: $(GENERATED_FILES)
diff --git a/trace/Makefile.objs b/trace/Makefile.objs
index afd571c..5f5ff5b 100644
--- a/trace/Makefile.objs
+++ b/trace/Makefile.objs
@@ -7,18 +7,20 @@ $(BUILD_DIR)/trace-events-all: $(trace-events-files)
 ##################################################
 # Translation level
 
-$(obj)/generated-helpers-wrappers.h: $(obj)/generated-helpers-wrappers.h-timestamp
+qemu-build/$(obj)/generated-helpers-wrappers.h: qemu-build/$(obj)/generated-helpers-wrappers.h-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-$(obj)/generated-helpers-wrappers.h-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
+qemu-build/$(obj)/generated-helpers-wrappers.h-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
+	$(call quiet-command,mkdir -p $(dir $@), "MKDIR $(dir $@)")
 	$(call quiet-command,$(TRACETOOL) \
 		--group=root \
 		--format=tcg-helper-wrapper-h \
 		--backend=$(TRACE_BACKENDS) \
 		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
 
-$(obj)/generated-helpers.h: $(obj)/generated-helpers.h-timestamp
+qemu-build/$(obj)/generated-helpers.h: qemu-build/$(obj)/generated-helpers.h-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-$(obj)/generated-helpers.h-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
+qemu-build/$(obj)/generated-helpers.h-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
+	$(call quiet-command,mkdir -p $(dir $@), "MKDIR $(dir $@)")
 	$(call quiet-command,$(TRACETOOL) \
 		--group=root \
 		--format=tcg-helper-h \
@@ -39,9 +41,10 @@ $(obj)/generated-helpers.o: $(obj)/generated-helpers.c
 target-obj-y += generated-helpers.o
 
 
-$(obj)/generated-tcg-tracers.h: $(obj)/generated-tcg-tracers.h-timestamp
+qemu-build/$(obj)/generated-tcg-tracers.h: qemu-build/$(obj)/generated-tcg-tracers.h-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-$(obj)/generated-tcg-tracers.h-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
+qemu-build/$(obj)/generated-tcg-tracers.h-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
+	$(call quiet-command,mkdir -p $(dir $@), "MKDIR $(dir $@)")
 	$(call quiet-command,$(TRACETOOL) \
 		--group=root \
 		--format=tcg-h \
-- 
MST
