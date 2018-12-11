Received: from eggs.gnu.org ([2001:4830:134:3::10]:39734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWp2a-00047T-Fe
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 15:54:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWp2Z-0001ni-2m
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 15:54:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gWp2Y-0001nD-S4
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 15:54:02 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 11 Dec 2018 18:53:45 -0200
Message-Id: <20181211205346.11118-4-ehabkost@redhat.com>
In-Reply-To: <20181211205346.11118-1-ehabkost@redhat.com>
References: <20181211205346.11118-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/4] target/i386/kvm.c: Don't mark cpuid_data as
 QEMU_PACKED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>

From: Peter Maydell <peter.maydell@linaro.org>

clang complains about taking the address of a packed
member of a struct:

target/i386/kvm.c:1245:27: warning: taking address of packed member 'cpui=
d' of class or structure '' may result in an unaligned pointer value [-Wa=
ddress-of-packed-member]
    c =3D cpuid_find_entry(&cpuid_data.cpuid, 1, 0);
                          ^~~~~~~~~~~~~~~~
target/i386/kvm.c:1297:31: warning: taking address of packed member 'cpui=
d' of class or structure '' may result in an unaligned pointer value [-Wa=
ddress-of-packed-member]
        c =3D cpuid_find_entry(&cpuid_data.cpuid, kvm_base, 0);
                              ^~~~~~~~~~~~~~~~

The kernel's definitions of struct kvm_cpuid2 and struct
kvm_cpuid_entry2 are carefully set up with padding fields
so that there is no between-struct padding anyway, so
the QEMU_PACKED annotation is unnecessary and might result
in the compiler generating worse code. Drop it, and instead
assert at build time that there is no stray padding.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20181210114654.31433-1-peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/kvm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index b2401d13ea..739cf8c8ea 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -864,7 +864,15 @@ int kvm_arch_init_vcpu(CPUState *cs)
     struct {
         struct kvm_cpuid2 cpuid;
         struct kvm_cpuid_entry2 entries[KVM_MAX_CPUID_ENTRIES];
-    } QEMU_PACKED cpuid_data;
+    } cpuid_data;
+    /*
+     * The kernel defines these structs with padding fields so there
+     * should be no extra padding in our cpuid_data struct.
+     */
+    QEMU_BUILD_BUG_ON(sizeof(cpuid_data) !=3D
+                      sizeof(struct kvm_cpuid2) +
+                      sizeof(struct kvm_cpuid_entry2) * KVM_MAX_CPUID_EN=
TRIES);
+
     X86CPU *cpu =3D X86_CPU(cs);
     CPUX86State *env =3D &cpu->env;
     uint32_t limit, i, j, cpuid_i;
--=20
2.18.0.rc1.1.g3f1ff2140
