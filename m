Received: from eggs.gnu.org ([2001:4830:134:3::10]:47752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cW2iC-0001yC-GI
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 10:08:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cW2i2-0002sv-Po
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 10:08:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cW2i2-0002s9-Hw
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 10:08:34 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0OEnSD7103044
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 10:08:33 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 285jtvfeun-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 10:08:32 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 24 Jan 2017 15:08:30 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Tue, 24 Jan 2017 16:08:22 +0100
In-Reply-To: <20170124150823.30162-1-cornelia.huck@de.ibm.com>
References: <20170124150823.30162-1-cornelia.huck@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20170124150823.30162-2-cornelia.huck@de.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/2] s390x/kvm: include hw_accel.h instead of
 kvm.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, jfrei@linux.vnet.ibm.com, qemu-devel@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>

Commit b394662 ("kvm: move cpu synchronization code") switched
to hw_accel.h instead of kvm.h, but missed s390x, resulting in

  CC      s390x-softmmu/target/s390x/kvm.o
/home/cohuck/git/qemu/target/s390x/kvm.c: In function =E2=80=98kvm_sclp_s=
ervice_call=E2=80=99:
/home/cohuck/git/qemu/target/s390x/kvm.c:1034:5: error: implicit declarat=
ion of function =E2=80=98cpu_synchronize_state=E2=80=99 [-Werror=3Dimplic=
it-function-declaration]
     cpu_synchronize_state(CPU(cpu));
     ^
/home/cohuck/git/qemu/target/s390x/kvm.c:1034:5: error: nested extern dec=
laration of =E2=80=98cpu_synchronize_state=E2=80=99 [-Werror=3Dnested-ext=
erns]
/home/cohuck/git/qemu/target/s390x/kvm.c: In function =E2=80=98sigp_initi=
al_cpu_reset=E2=80=99:
/home/cohuck/git/qemu/target/s390x/kvm.c:1628:5: error: implicit declarat=
ion of function =E2=80=98cpu_synchronize_post_reset=E2=80=99 [-Werror=3Di=
mplicit-function-declaration]
     cpu_synchronize_post_reset(cs);
     ^
/home/cohuck/git/qemu/target/s390x/kvm.c:1628:5: error: nested extern dec=
laration of =E2=80=98cpu_synchronize_post_reset=E2=80=99 [-Werror=3Dneste=
d-externs]
/home/cohuck/git/qemu/target/s390x/kvm.c: In function =E2=80=98sigp_set_p=
refix=E2=80=99:
/home/cohuck/git/qemu/target/s390x/kvm.c:1665:5: error: implicit declarat=
ion of function =E2=80=98cpu_synchronize_post_init=E2=80=99 [-Werror=3Dim=
plicit-function-declaration]
     cpu_synchronize_post_init(cs);
     ^
/home/cohuck/git/qemu/target/s390x/kvm.c:1665:5: error: nested extern dec=
laration of =E2=80=98cpu_synchronize_post_init=E2=80=99 [-Werror=3Dnested=
-externs]
cc1: all warnings being treated as errors
/home/cohuck/git/qemu/rules.mak:64: recipe for target 'target/s390x/kvm.o=
' failed

Fix this.

Fixes: b394662 ("kvm: move cpu synchronization code")
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Acked-by: Vincent Palatin <vpalatin@chromium.org>
---
 target/s390x/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 3ac29f92b3..5ad0acbc82 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -32,7 +32,7 @@
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
-#include "sysemu/kvm.h"
+#include "sysemu/hw_accel.h"
 #include "hw/hw.h"
 #include "sysemu/device_tree.h"
 #include "qapi/qmp/qjson.h"
--=20
2.11.0
