Received: from eggs.gnu.org ([2001:4830:134:3::10]:51776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1fQKEo-0003pE-9l
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 18:15:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1fQKEl-0003vk-0p
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 18:15:34 -0400
Received: from mail-sn1nam02on0125.outbound.protection.outlook.com
	([104.47.36.125]:20751
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <juterry@microsoft.com>)
	id 1fQKEk-0003sZ-3E
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 18:15:30 -0400
From: "Justin Terry (VM)" <juterry@microsoft.com>
Date: Tue, 5 Jun 2018 22:15:27 +0000
Message-ID: <20180605221500.21674-1-juterry@microsoft.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH 1/2] WHPX workaround bug in OSVW handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "Justin Terry (VM)" <juterry@microsoft.com>

Adds a workaround to an incorrect value setting
CPUID Fn8000_0001_ECX[bit 9 OSVW] =3D 1. This can cause a guest linux kerne=
l
to panic when an issue to rdmsr C001_0140h returns 0. Disabling this featur=
e
correctly allows the guest to boot without accessing the osv workarounds.

Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
---
 target/i386/whpx-all.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index 6b42096698..99501bac57 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -964,6 +964,16 @@ static int whpx_vcpu_run(CPUState *cpu)
                 rdx =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
                 rbx =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
                 break;
+            case 0x80000001:
+                rax =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
+                /* Remove any support of OSVW */
+                rcx =3D
+                    vcpu->exit_ctx.CpuidAccess.DefaultResultRcx &
+                    ~CPUID_EXT3_OSVW;
+
+                rdx =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
+                rbx =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
+                break;
             default:
                 rax =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
                 rcx =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRcx;
@@ -1382,12 +1392,13 @@ static int whpx_accel_init(MachineState *ms)
         goto error;
     }
=20
-    UINT32 cpuidExitList[] =3D {1};
+    UINT32 cpuidExitList[] =3D {1, 0x80000001};
     hr =3D whp_dispatch.WHvSetPartitionProperty(
         whpx->partition,
         WHvPartitionPropertyCodeCpuidExitList,
         cpuidExitList,
         RTL_NUMBER_OF(cpuidExitList) * sizeof(UINT32));
+
     if (FAILED(hr)) {
         error_report("WHPX: Failed to set partition CpuidExitList hr=3D%08=
lx",
                      hr);
--=20
2.13.6
