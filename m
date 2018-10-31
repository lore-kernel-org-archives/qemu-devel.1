Received: from eggs.gnu.org ([2001:4830:134:3::10]:47085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHeeO-0000V2-4L
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 20:46:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHeeL-0006aX-27
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 20:46:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gHeeK-0006Zj-Nf
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 20:46:20 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 30 Oct 2018 21:45:44 -0300
Message-Id: <20181031004550.15410-2-ehabkost@redhat.com>
In-Reply-To: <20181031004550.15410-1-ehabkost@redhat.com>
References: <20181031004550.15410-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/7] i386: correct cpu_x86_cpuid(0xd)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Intel SDM says for CPUID function 0DH, sub-function 0:

| =E2=80=A2 ECX enumerates the size (in bytes) required by the XSAVE inst=
ruction for an
|   XSAVE area containing all the user state components supported by this
|   processor.
| =E2=80=A2 EBX enumerates the size (in bytes) required by the XSAVE inst=
ruction for an
|   XSAVE area containing all the user state components corresponding to =
bits
|   currently set in XCR0.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Message-Id: <20180928104319.3296-1-bigeasy@linutronix.de>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1469a1be01..fe7c963e5e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4178,7 +4178,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index=
, uint32_t count,
             *ecx =3D xsave_area_size(x86_cpu_xsave_components(cpu));
             *eax =3D env->features[FEAT_XSAVE_COMP_LO];
             *edx =3D env->features[FEAT_XSAVE_COMP_HI];
-            *ebx =3D *ecx;
+            *ebx =3D xsave_area_size(env->xcr0);
         } else if (count =3D=3D 1) {
             *eax =3D env->features[FEAT_XSAVE];
         } else if (count < ARRAY_SIZE(x86_ext_save_areas)) {
--=20
2.18.0.rc1.1.g3f1ff2140
