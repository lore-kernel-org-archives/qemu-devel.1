Received: from eggs.gnu.org ([2001:4830:134:3::10]:56246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fyBhU-0002za-Lr
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 04:01:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fyBhO-00013W-PR
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 04:01:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33976 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fyBhO-00011O-EE
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 04:01:02 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  7 Sep 2018 11:59:47 +0400
Message-Id: <20180907075948.26917-12-marcandre.lureau@redhat.com>
In-Reply-To: <20180907075948.26917-1-marcandre.lureau@redhat.com>
References: <20180907075948.26917-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 11/12] hostmem: add some properties
 description
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 backends/hostmem-memfd.c |  9 +++++++++
 backends/hostmem.c       | 14 ++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 1e20fe0ba8..789c8c3f87 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -144,14 +144,23 @@ memfd_backend_class_init(ObjectClass *oc, void *dat=
a)
                                    memfd_backend_get_hugetlb,
                                    memfd_backend_set_hugetlb,
                                    &error_abort);
+    object_class_property_set_description(oc, "hugetlb",
+                                          "Use huge pages",
+                                          &error_abort);
     object_class_property_add(oc, "hugetlbsize", "int",
                               memfd_backend_get_hugetlbsize,
                               memfd_backend_set_hugetlbsize,
                               NULL, NULL, &error_abort);
+    object_class_property_set_description(oc, "hugetlbsize",
+                                          "Huge pages size (ex: 2M, 1G)"=
,
+                                          &error_abort);
     object_class_property_add_bool(oc, "seal",
                                    memfd_backend_get_seal,
                                    memfd_backend_set_seal,
                                    &error_abort);
+    object_class_property_set_description(oc, "seal",
+                                          "Seal growing & shrinking",
+                                          &error_abort);
 }
=20
 static const TypeInfo memfd_backend_info =3D {
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 4908946cd3..1a89342039 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -397,27 +397,41 @@ host_memory_backend_class_init(ObjectClass *oc, voi=
d *data)
     object_class_property_add_bool(oc, "merge",
         host_memory_backend_get_merge,
         host_memory_backend_set_merge, &error_abort);
+    object_class_property_set_description(oc, "merge",
+        "Mark memory as mergeable", &error_abort);
     object_class_property_add_bool(oc, "dump",
         host_memory_backend_get_dump,
         host_memory_backend_set_dump, &error_abort);
+    object_class_property_set_description(oc, "dump",
+        "Set to 'off' to exclude from core dump", &error_abort);
     object_class_property_add_bool(oc, "prealloc",
         host_memory_backend_get_prealloc,
         host_memory_backend_set_prealloc, &error_abort);
+    object_class_property_set_description(oc, "prealloc",
+        "Preallocate memory", &error_abort);
     object_class_property_add(oc, "size", "int",
         host_memory_backend_get_size,
         host_memory_backend_set_size,
         NULL, NULL, &error_abort);
+    object_class_property_set_description(oc, "size",
+        "Size of the memory region (ex: 500M)", &error_abort);
     object_class_property_add(oc, "host-nodes", "int",
         host_memory_backend_get_host_nodes,
         host_memory_backend_set_host_nodes,
         NULL, NULL, &error_abort);
+    object_class_property_set_description(oc, "host-nodes",
+        "Binds memory to the list of NUMA host nodes", &error_abort);
     object_class_property_add_enum(oc, "policy", "HostMemPolicy",
         &HostMemPolicy_lookup,
         host_memory_backend_get_policy,
         host_memory_backend_set_policy, &error_abort);
+    object_class_property_set_description(oc, "policy",
+        "Set the NUMA policy", &error_abort);
     object_class_property_add_bool(oc, "share",
         host_memory_backend_get_share, host_memory_backend_set_share,
         &error_abort);
+    object_class_property_set_description(oc, "share",
+        "Mark the memory as private to QEMU or shared", &error_abort);
 }
=20
 static const TypeInfo host_memory_backend_info =3D {
--=20
2.19.0.rc1
