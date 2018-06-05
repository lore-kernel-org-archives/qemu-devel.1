Received: from eggs.gnu.org ([2001:4830:134:3::10]:51773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1fQKEo-0003pD-8r
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 18:15:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1fQKEl-0003wR-CY
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 18:15:34 -0400
Received: from mail-sn1nam02on0125.outbound.protection.outlook.com
	([104.47.36.125]:20751
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <juterry@microsoft.com>)
	id 1fQKEl-0003sZ-6l
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 18:15:31 -0400
From: "Justin Terry (VM)" <juterry@microsoft.com>
Date: Tue, 5 Jun 2018 22:15:28 +0000
Message-ID: <20180605221500.21674-2-juterry@microsoft.com>
References: <20180605221500.21674-1-juterry@microsoft.com>
In-Reply-To: <20180605221500.21674-1-juterry@microsoft.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH 2/2] WHPX: register for unrecognized MSR exits
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

Some variations of Linux kernels end up accessing MSR's that the Windows
Hypervisor doesn't implement which causes a GP to be returned to the guest.
This fix registers QEMU for unimplemented MSR access and globally returns 0=
 on
reads and ignores writes. This behavior is allows the Linux kernel to probe=
 the
MSR with a write/read/check sequence it does often without failing the acce=
ss.

Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
---
 target/i386/whpx-all.c | 41 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index 99501bac57..57e53e1f1f 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -932,6 +932,7 @@ static int whpx_vcpu_run(CPUState *cpu)
=20
         case WHvRunVpExitReasonX64InterruptWindow:
             vcpu->window_registered =3D 0;
+            ret =3D 0;
             break;
=20
         case WHvRunVpExitReasonX64Halt:
@@ -943,6 +944,40 @@ static int whpx_vcpu_run(CPUState *cpu)
             ret =3D 1;
             break;
=20
+        case WHvRunVpExitReasonX64MsrAccess: {
+            WHV_REGISTER_VALUE reg_values[3] =3D {0};
+            WHV_REGISTER_NAME reg_names[3];
+            UINT32 reg_count;
+
+            reg_names[0] =3D WHvX64RegisterRip;
+            reg_names[1] =3D WHvX64RegisterRax;
+            reg_names[2] =3D WHvX64RegisterRdx;
+
+            reg_values[0].Reg64 =3D
+                vcpu->exit_ctx.VpContext.Rip +
+                vcpu->exit_ctx.VpContext.InstructionLength;
+
+            /*
+             * For all unsupported MSR access we:
+             *     ignore writes
+             *     return 0 on read.
+             */
+            reg_count =3D vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite ?
+                        1 : 3;
+
+            hr =3D whp_dispatch.WHvSetVirtualProcessorRegisters(
+                whpx->partition,
+                cpu->cpu_index,
+                reg_names, reg_count,
+                reg_values);
+
+            if (FAILED(hr)) {
+                error_report("WHPX: Failed to set MsrAccess state "
+                             " registers, hr=3D%08lx", hr);
+            }
+            ret =3D 0;
+            break;
+        }
         case WHvRunVpExitReasonX64Cpuid: {
             WHV_REGISTER_VALUE reg_values[5];
             WHV_REGISTER_NAME reg_names[5];
@@ -1010,7 +1045,6 @@ static int whpx_vcpu_run(CPUState *cpu)
         case WHvRunVpExitReasonUnrecoverableException:
         case WHvRunVpExitReasonInvalidVpRegisterValue:
         case WHvRunVpExitReasonUnsupportedFeature:
-        case WHvRunVpExitReasonX64MsrAccess:
         case WHvRunVpExitReasonException:
         default:
             error_report("WHPX: Unexpected VP exit code %d",
@@ -1378,6 +1412,7 @@ static int whpx_accel_init(MachineState *ms)
     }
=20
     memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
+    prop.ExtendedVmExits.X64MsrExit =3D 1;
     prop.ExtendedVmExits.X64CpuidExit =3D 1;
     hr =3D whp_dispatch.WHvSetPartitionProperty(
         whpx->partition,
@@ -1386,8 +1421,8 @@ static int whpx_accel_init(MachineState *ms)
         sizeof(WHV_PARTITION_PROPERTY));
=20
     if (FAILED(hr)) {
-        error_report("WHPX: Failed to enable partition extended X64CpuidEx=
it"
-                     " hr=3D%08lx", hr);
+        error_report("WHPX: Failed to enable partition extended X64MsrExit=
 and"
+                     " X64CpuidExit hr=3D%08lx", hr);
         ret =3D -EINVAL;
         goto error;
     }
--=20
2.13.6
