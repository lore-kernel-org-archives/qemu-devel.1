Received: from eggs.gnu.org ([2001:4830:134:3::10]:38355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gDEXB-0007QU-O2
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:04:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gDEXA-0006ql-Ca
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:04:41 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 18 Oct 2018 17:03:38 -0300
Message-Id: <20181018200422.4358-2-ehabkost@redhat.com>
In-Reply-To: <20181018200422.4358-1-ehabkost@redhat.com>
References: <20181018200422.4358-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 01/45] hostmem-file: fixed the memory leak while
 get pmem path.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Rob Herring <robh@kernel.org>, libvir-list@redhat.com, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Eduardo Habkost <ehabkost@redhat.com>, Michael Walle <michael@walle.cc>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Zhang Yi <yi.z.zhang@linux.intel.com>

From: Zhang Yi <yi.z.zhang@linux.intel.com>

object_get_canonical_path_component() returns a string which
must be freed using g_free().

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
Message-Id: <7328fb16c394eaf5d65437d11c2a9343647b6d3d.1535471899.git.yi.z.zhang@linux.intel.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 backends/hostmem-file.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index e64074954f..639c8d4307 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -145,20 +145,26 @@ static void file_memory_backend_set_pmem(Object *o, bool value, Error **errp)
     HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(o);
 
     if (host_memory_backend_mr_inited(backend)) {
+        char *path = object_get_canonical_path_component(o);
+
         error_setg(errp, "cannot change property 'pmem' of %s '%s'",
                    object_get_typename(o),
-                   object_get_canonical_path_component(o));
+                   path);
+        g_free(path);
         return;
     }
 
 #ifndef CONFIG_LIBPMEM
     if (value) {
         Error *local_err = NULL;
+        char *path = object_get_canonical_path_component(o);
+
         error_setg(&local_err,
                    "Lack of libpmem support while setting the 'pmem=on'"
                    " of %s '%s'. We can't ensure data persistence.",
                    object_get_typename(o),
-                   object_get_canonical_path_component(o));
+                   path);
+        g_free(path);
         error_propagate(errp, local_err);
         return;
     }
-- 
2.18.0.rc1.1.g3f1ff2140
