Received: from eggs.gnu.org ([2001:4830:134:3::10]:56973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balducci@units.it>) id 1gP1OP-0001fv-Af
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 03:28:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balducci@units.it>) id 1gP1OL-0004YO-Ck
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 03:28:21 -0500
Received: from dschgrazlin2.univ.trieste.it ([140.105.55.81]:57528
	helo=dschgrazlin2.units.it) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balducci@units.it>) id 1gP1OL-0004Xx-1U
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 03:28:17 -0500
From: balducci@units.it
In-reply-to: Your message of "Mon, 19 Nov 2018 16:55:13 -0500."
	<jpgefbgag1q.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7279.1542702495.1@dschgrazlin2.units.it>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Nov 2018 09:27:51 +0100
Message-ID: <7280.1542702495@dschgrazlin2.units.it>
Subject: Re: [Qemu-devel] 3.1.0-rc{0,1} doesn't start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bandan Das <bsd@redhat.com>
Cc: qemu-devel@nongnu.org

hello

> incomplete because it can return 0 for data. Can you try this:
>
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index f524e7d929..4878ffb90b 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -2002,14 +2002,9 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
>  #endif
>  =

>      /* If host supports feature MSR, write down. */
> -    if (kvm_feature_msrs) {
> -        int i;
> -        for (i =3D 0; i < kvm_feature_msrs->nmsrs; i++)
> -            if (kvm_feature_msrs->indices[i] =3D=3D MSR_IA32_ARCH_CAPAB=
ILITIES) =

> {
> -                kvm_msr_entry_add(cpu, MSR_IA32_ARCH_CAPABILITIES,
> +    if (kvm_arch_get_supported_msr_feature(kvm_state, MSR_IA32_ARCH_CAP=
ABILI
> TIES)) {
> +        kvm_msr_entry_add(cpu, MSR_IA32_ARCH_CAPABILITIES,
>                                env->features[FEAT_ARCH_CAPABILITIES]);
> -                break;
> -            }
>      }
>  =

>      /*

I'm getting the same error message at start time (patch applied to
official  qemu-3.1.0-rc1 tarball):

----8<----
qemu: error: failed to set MSR 0x10a to 0x0
qemu: /home/balducci/tmp/install-us-d/qemu-3.1.0-rc1.d/qemu-3.1.0-rc1/targ=
et/i386/kvm.c:2206: kvm_put_msrs: Assertion `ret =3D=3D cpu->kvm_msr_buf->=
nmsrs' failed.
Aborted
---->8----

thanks a lot
ciao
-gabriele
