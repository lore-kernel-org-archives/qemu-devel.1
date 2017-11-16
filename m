Received: from eggs.gnu.org ([2001:4830:134:3::10]:35785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eFOGi-0007We-Be
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:48:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eFOGh-000822-5c
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:48:04 -0500
References: <20171116170526.12643-1-david@redhat.com>
	<20171116170526.12643-3-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <8403a827-2212-0128-581b-149892335916@redhat.com>
Date: Thu, 16 Nov 2017 18:47:59 +0100
MIME-Version: 1.0
In-Reply-To: <20171116170526.12643-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 for-2.11 2/3] s390x/tcg: fix DIAG 308
 with > 1 VCPU (single threaded TCG)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

On 16.11.2017 18:05, David Hildenbrand wrote:
> Currently, single threaded TCG with > 1 VCPU gets stuck during IPL, whe=
n
> the bios tries to switch to the loaded kernel via DIAG 308.
>=20
> pause_all_vcpus()/resume_all_vcpus() should not be called from a VCPU.
>=20
> And there is also no need for it. run_on_cpu() will make sure that the
> CPUs exit KVM/TCG, where they get stopped. Once stopped, they will no
> longer run.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/diag.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index dbbb9e886f..52bc348808 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -27,7 +27,6 @@ static int modified_clear_reset(S390CPU *cpu)
>      S390CPUClass *scc =3D S390_CPU_GET_CLASS(cpu);
>      CPUState *t;
> =20
> -    pause_all_vcpus();
>      cpu_synchronize_all_states();

Hmm, thinking about this whole synchronization thingy, I guess it could
happen that a VCPU starts running again after the
cpu_synchronize_all_states() but before the reset. So we should do that
in one shot. Resulting in something like the following. Comments?



>From 14440f775e65bb88c1a95705fc9b438f4022f332 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Wed, 15 Nov 2017 17:30:02 +0100
Subject: [PATCH v1] s390x/tcg: fix DIAG 308 with > 1 VCPU (single threade=
d
 TCG)

Currently, single threaded TCG with > 1 VCPU gets stuck during IPL, when
the bios tries to switch to the loaded kernel via DIAG 308.

pause_all_vcpus()/resume_all_vcpus() should not be called from a VCPU.

And there is also no need for it. run_on_cpu() will make sure that the
CPUs exits KVM/TCG, where they get stopped. Once stopped, they will no
longer run. As we have to proper synchronize before and after the reset,
and have to hinder the VCPU from going back into TCG/KVM execution
after the sync, let's do the synchronization in the same shot.

Optimize so we don't do one additional round of synchronization on the
running CPU.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/diag.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index dbbb9e886f..8396124a5f 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -19,51 +19,65 @@
 #include "exec/exec-all.h"
 #include "hw/watchdog/wdt_diag288.h"
 #include "sysemu/cpus.h"
+#include "sysemu/hw_accel.h"
 #include "hw/s390x/ipl.h"
 #include "hw/s390x/s390-virtio-ccw.h"

+static void s390_do_sync_cpu_full_reset(CPUState *cs, run_on_cpu_data ar=
g)
+{
+    cpu_synchronize_state(cs);
+    cpu_reset(cs);
+    cpu_synchronize_post_reset(cs);
+}
+
 static int modified_clear_reset(S390CPU *cpu)
 {
     S390CPUClass *scc =3D S390_CPU_GET_CLASS(cpu);
+    CPUState *cs =3D CPU(cpu);
     CPUState *t;

-    pause_all_vcpus();
-    cpu_synchronize_all_states();
     CPU_FOREACH(t) {
-        run_on_cpu(t, s390_do_cpu_full_reset, RUN_ON_CPU_NULL);
+        if (t !=3D cs) {
+            run_on_cpu(t, s390_do_sync_cpu_full_reset, RUN_ON_CPU_NULL);
+        }
     }
     s390_cmma_reset();
     subsystem_reset();
     s390_crypto_reset();
-    scc->load_normal(CPU(cpu));
-    cpu_synchronize_all_post_reset();
-    resume_all_vcpus();
+    cpu_synchronize_state(cs);
+    cpu_reset(cs);
+    scc->load_normal(cs);
+    cpu_synchronize_post_reset(cs);
     return 0;
 }

-static inline void s390_do_cpu_reset(CPUState *cs, run_on_cpu_data arg)
+static void s390_do_sync_cpu_reset(CPUState *cs, run_on_cpu_data arg)
 {
     S390CPUClass *scc =3D S390_CPU_GET_CLASS(cs);

+    cpu_synchronize_state(cs);
     scc->cpu_reset(cs);
+    cpu_synchronize_post_reset(cs);
 }

 static int load_normal_reset(S390CPU *cpu)
 {
     S390CPUClass *scc =3D S390_CPU_GET_CLASS(cpu);
+    CPUState *cs =3D CPU(cpu);
     CPUState *t;

-    pause_all_vcpus();
-    cpu_synchronize_all_states();
     CPU_FOREACH(t) {
-        run_on_cpu(t, s390_do_cpu_reset, RUN_ON_CPU_NULL);
+        if (t !=3D cs) {
+            run_on_cpu(t, s390_do_sync_cpu_reset, RUN_ON_CPU_NULL);
+        }
     }
     s390_cmma_reset();
     subsystem_reset();
-    scc->initial_cpu_reset(CPU(cpu));
-    scc->load_normal(CPU(cpu));
-    cpu_synchronize_all_post_reset();
-    resume_all_vcpus();
+    cpu_synchronize_state(cs);
+    /* scc->initital_cpu_reset() is a superset of scc->cpu_reset() */
+    scc->initial_cpu_reset(cs);
+    scc->load_normal(cs);
+    cpu_synchronize_post_reset(cs);
     return 0;
 }

--=20
2.13.6



--=20

Thanks,

David / dhildenb
