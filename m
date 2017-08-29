Received: from eggs.gnu.org ([2001:4830:134:3::10]:48418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCe-0001UU-IM
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCb-0005kQ-AL
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57531
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCb-0005jh-0a
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:21 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0E8JH099546
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:20 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cmr22ykdk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:20 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 20:16:19 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:14:27 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1503965694-10794-53-git-send-email-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 52/79] target/ppc: pass const string to
 kvmppc_is_mem_backend_page_size_ok()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

This function has three implementations. Two are stubs that do nothing
and the third one only passes the obj_path argument to:

Object *object_resolve_path(const char *path, bool *ambiguous);

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
(cherry picked from commit ec69355beffe138c0f97306e65410e5dbc605554)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/ppc/kvm.c     | 4 ++--
 target/ppc/kvm_ppc.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 9f1f132..89f3586 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -415,7 +415,7 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
     }
 }
=20
-bool kvmppc_is_mem_backend_page_size_ok(char *obj_path)
+bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path)
 {
     Object *mem_obj =3D object_resolve_path(obj_path, NULL);
     char *mempath =3D object_property_get_str(mem_obj, "mem-path", NULL)=
;
@@ -436,7 +436,7 @@ static inline void kvm_fixup_page_sizes(PowerPCCPU *c=
pu)
 {
 }
=20
-bool kvmppc_is_mem_backend_page_size_ok(char *obj_path)
+bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path)
 {
     return true;
 }
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 8e9f42d..eec5cca 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -57,7 +57,7 @@ int kvmppc_enable_hwrng(void);
 int kvmppc_put_books_sregs(PowerPCCPU *cpu);
 PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
=20
-bool kvmppc_is_mem_backend_page_size_ok(char *obj_path);
+bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path);
=20
 #else
=20
@@ -191,7 +191,7 @@ static inline uint64_t kvmppc_rma_size(uint64_t curre=
nt_size,
     return ram_size;
 }
=20
-static inline bool kvmppc_is_mem_backend_page_size_ok(char *obj_path)
+static inline bool kvmppc_is_mem_backend_page_size_ok(const char *obj_pa=
th)
 {
     return true;
 }
--=20
2.7.4
