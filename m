Received: from eggs.gnu.org ([2001:4830:134:3::10]:40610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIH5u-00088y-Mf
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 12:12:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIH5s-0003wf-DX
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 12:12:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41837
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dIH5s-0003wD-7t
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 12:12:32 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v56G8kWi091941
	for <qemu-devel@nongnu.org>; Tue, 6 Jun 2017 12:12:31 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2awp6by97y-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 12:12:31 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 6 Jun 2017 17:12:29 +0100
From: Greg Kurz <groug@kaod.org>
Date: Tue, 06 Jun 2017 18:12:24 +0200
In-Reply-To: <149676256806.31274.17021734547869850899.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <149676256806.31274.17021734547869850899.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <149676554488.4134.16095044562334102742.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] target/ppc: pass const string to
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-stable@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

This function has three implementations. Two are stubs that do nothing
and the third one only passes the obj_path argument to:

Object *object_resolve_path(const char *path, bool *ambiguous);

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
v2: - also patch inline stub
    - renamed patch and added changelog
---
 target/ppc/kvm.c     |    4 ++--
 target/ppc/kvm_ppc.h |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 51249ce79e55..88817620766c 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -478,7 +478,7 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
     }
 }
=20
-bool kvmppc_is_mem_backend_page_size_ok(char *obj_path)
+bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path)
 {
     Object *mem_obj =3D object_resolve_path(obj_path, NULL);
     char *mempath =3D object_property_get_str(mem_obj, "mem-path", NULL)=
;
@@ -499,7 +499,7 @@ static inline void kvm_fixup_page_sizes(PowerPCCPU *c=
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
index f48243d13ffc..eab7c8fdb325 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -64,7 +64,7 @@ int kvmppc_enable_hwrng(void);
 int kvmppc_put_books_sregs(PowerPCCPU *cpu);
 PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
=20
-bool kvmppc_is_mem_backend_page_size_ok(char *obj_path);
+bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path);
=20
 #else
=20
@@ -211,7 +211,7 @@ static inline uint64_t kvmppc_rma_size(uint64_t curre=
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
