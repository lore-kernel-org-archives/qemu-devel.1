Received: from eggs.gnu.org ([2001:4830:134:3::10]:45277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eJiXx-0005ga-UM
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:15:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eJiXr-00042S-Nn
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:15:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42968)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eJiXr-000420-Eu
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:15:39 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 28 Nov 2017 16:15:28 +0000
Message-Id: <20171128161529.3025-2-stefanha@redhat.com>
In-Reply-To: <20171128161529.3025-1-stefanha@redhat.com>
References: <20171128161529.3025-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] qemu-options: document missing
 memory-backend-file options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Hu Tao <hutao@cn.fujitsu.com>, Stefan Hajnoczi <stefanha@redhat.com>

This patch adds undocumented memory-backend-file options to the
documentation.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qemu-options.hx | 48 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 3728e9b4dd..f2cf0be193 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4189,18 +4189,24 @@ property must be set.  These objects are placed in the
 
 @table @option
 
-@item -object memory-backend-file,id=@var{id},size=@var{size},mem-path=@var{dir},share=@var{on|off},discard-data=@var{on|off}
+@item -object memory-backend-file,id=@var{id},size=@var{size},mem-path=@var{dir},share=@var{on|off},discard-data=@var{on|off},merge=@var{on|off},dump=@var{on|off},prealloc=@var{on|off},host-nodes=@var{host-nodes},policy=@var{default|preferred|bind|interleave}
 
 Creates a memory file backend object, which can be used to back
-the guest RAM with huge pages. The @option{id} parameter is a
-unique ID that will be used to reference this memory region
-when configuring the @option{-numa} argument. The @option{size}
-option provides the size of the memory region, and accepts
-common suffixes, eg @option{500M}. The @option{mem-path} provides
-the path to either a shared memory or huge page filesystem mount.
+the guest RAM with huge pages.
+
+The @option{id} parameter is a unique ID that will be used to reference this
+memory region when configuring the @option{-numa} argument.
+
+The @option{size} option provides the size of the memory region, and accepts
+common suffixes, eg @option{500M}.
+
+The @option{mem-path} provides the path to either a shared memory or huge page
+filesystem mount.
+
 The @option{share} boolean option determines whether the memory
 region is marked as private to QEMU, or shared. The latter allows
 a co-operating external process to access the QEMU memory region.
+
 Setting the @option{discard-data} boolean option to @var{on}
 indicates that file contents can be destroyed when QEMU exits,
 to avoid unnecessarily flushing data to the backing file.  Note
@@ -4208,6 +4214,34 @@ that @option{discard-data} is only an optimization, and QEMU
 might not discard file contents if it aborts unexpectedly or is
 terminated using SIGKILL.
 
+The @option{merge} boolean option enables memory merge, also known as
+MADV_MERGEABLE, so that Kernel Samepage Merging will consider the pages for
+memory deduplication.
+
+Setting the @option{dump} boolean option to @var{off} excludes the memory from
+core dumps. This feature is also known as MADV_DONTDUMP.
+
+The @option{prealloc} boolean option enables memory preallocation.
+
+The @option{host-nodes} option binds the memory range to a list of NUMA host
+nodes.
+
+The @option{policy} option sets the NUMA policy to one of the following values:
+
+@table @option
+@item @var{default}
+default host policy
+
+@item @var{preferred}
+prefer the given host node list for allocation
+
+@item @var{bind}
+restrict memory allocation to the given host node list
+
+@item @var{interleave}
+interleave memory allocations across the given host node list
+@end table
+
 @item -object rng-random,id=@var{id},filename=@var{/dev/random}
 
 Creates a random number generator backend which obtains entropy from
-- 
2.14.3
