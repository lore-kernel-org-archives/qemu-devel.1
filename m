Received: from eggs.gnu.org ([2001:4830:134:3::10]:40106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1eqbxG-0002Kk-4L
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 04:53:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1eqbxC-0005UV-7z
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 04:53:50 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2259 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arei.gonglei@huawei.com>)
	id 1eqbxB-0005Sg-SH
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 04:53:46 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Tue, 27 Feb 2018 09:52:56 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA56A1AE@DGGEMA505-MBX.china.huawei.com>
References: <1490624810-44752-1-git-send-email-agraf@suse.de>
In-Reply-To: <1490624810-44752-1-git-send-email-agraf@suse.de>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] i386: Allow monitor / mwait cpuid override
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>, Zhuangyanying <ann.zhuangyanying@huawei.com>

Hi all,

Guests could achive good performance in 'Message Passing Workloads'=20
scenarios when knowing the X86_FEATURE_MWAIT feature which is presented by =
qemu.=20
the reason is that after knowing that feature,=20
the guest could use mwait method, which saves VMEXIT,=20
to do idle, and achives high performace in latency-sensitive scenario.

Is there any plan for this patch?=20

Or May I send a updated version based on yours? @Alex?

Thanks,
-Gonglei


> -----Original Message-----
> From: Qemu-devel
> [mailto:qemu-devel-bounces+arei.gonglei=3Dhuawei.com@nongnu.org] On
> Behalf Of Alexander Graf
> Sent: Monday, March 27, 2017 10:27 PM
> To: qemu-devel@nongnu.org
> Cc: Paolo Bonzini; Eduardo Habkost; Richard Henderson
> Subject: [Qemu-devel] [PATCH] i386: Allow monitor / mwait cpuid override
>=20
> KVM allows trap and emulate (read: NOP) of the MONITOR and MWAIT
> instructions. There is work undergoing to enable actual execution
> of these inside of KVM, but nobody really wants to expose the feature
> to the guest by default, as it would eat up all of the host CPU.
>=20
> So today there is no streamlined way to actually notify the guest that
> it's ok to execute MONITOR / MWAIT, even when we want to explicitly
> leave the guest in guest context.
>=20
> This patch adds a new -cpu parameter called "mwait" which - when
> enabled - force enables the MONITOR / MWAIT CPUID flag, even when
> the underlying accel framework does not explicitly advertise support.
>=20
> With that in place, we can explicitly allow users to specify that
> they want have the guest execute MONITOR / MWAIT in its idle loop.
>=20
> Signed-off-by: Alexander Graf <agraf@suse.de>
> ---
>  target/i386/cpu.c | 5 +++++
>  target/i386/cpu.h | 1 +
>  2 files changed, 6 insertions(+)
>=20
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 7aa7622..c44020b 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -3460,6 +3460,10 @@ static int x86_cpu_filter_features(X86CPU *cpu)
>              x86_cpu_get_supported_feature_word(w, false);
>          uint32_t requested_features =3D env->features[w];
>          env->features[w] &=3D host_feat;
> +        if (cpu->expose_monitor && (w =3D=3D FEAT_1_ECX)) {
> +            /* Force monitor feature in */
> +            env->features[w] |=3D CPUID_EXT_MONITOR;
> +        }
>          cpu->filtered_features[w] =3D requested_features &
> ~env->features[w];
>          if (cpu->filtered_features[w]) {
>              rv =3D 1;
> @@ -3988,6 +3992,7 @@ static Property x86_cpu_properties[] =3D {
>      DEFINE_PROP_BOOL("check", X86CPU, check_cpuid, true),
>      DEFINE_PROP_BOOL("enforce", X86CPU, enforce_cpuid, false),
>      DEFINE_PROP_BOOL("kvm", X86CPU, expose_kvm, true),
> +    DEFINE_PROP_BOOL("mwait", X86CPU, expose_monitor, false),
>      DEFINE_PROP_UINT32("phys-bits", X86CPU, phys_bits, 0),
>      DEFINE_PROP_BOOL("host-phys-bits", X86CPU, host_phys_bits, false),
>      DEFINE_PROP_BOOL("fill-mtrr-mask", X86CPU, fill_mtrr_mask, true),
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 07401ad..7400d00 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1214,6 +1214,7 @@ struct X86CPU {
>      bool check_cpuid;
>      bool enforce_cpuid;
>      bool expose_kvm;
> +    bool expose_monitor;
>      bool migratable;
>      bool max_features; /* Enable all supported features automatically */
>      uint32_t apic_id;
> --
> 1.8.5.6
>=20
