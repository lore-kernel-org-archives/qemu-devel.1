Received: from eggs.gnu.org ([2001:4830:134:3::10]:41248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ezT9O-0006Hw-F5
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 16:18:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ezT9L-0001yF-4Y
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 16:18:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ezT9K-0001xh-Ug
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 16:18:55 -0400
Date: Fri, 23 Mar 2018 17:18:52 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180323201852.GB1396@localhost.localdomain>
References: <1521211002-4529-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1521211002-4529-1-git-send-email-wanpengli@tencent.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] i386/kvm: add support for
 KVM_CAP_X86_DISABLE_EXITS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>

On Fri, Mar 16, 2018 at 07:36:42AM -0700, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
>=20
> This patch adds support for KVM_CAP_X86_DISABLE_EXITS. Provides userspa=
ce with=20
> per-VM capability(KVM_CAP_X86_DISABLE_EXITS) to not intercept MWAIT/HLT=
/PAUSE=20
> in order that to improve latency in some workloads.
>=20
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>


Thanks.

Patch looks good (except for comment below), but I would like to
see QEMU documentation mentioning what exactly are the practical
consequences of setting "+kvm-hint-dedicated" (especially what
could happen if people enable the flag without properly
configuring vCPU pinning).


[...]
> +    if (env->features[FEAT_KVM_HINTS] & KVM_HINTS_DEDICATED) {
> +        int disable_exits =3D kvm_check_extension(cs->kvm_state, KVM_C=
AP_X86_DISABLE_EXITS);
> +        if (disable_exits) {
> +            disable_exits &=3D (KVM_X86_DISABLE_EXITS_MWAIT |
> +                              KVM_X86_DISABLE_EXITS_HLT |
> +                              KVM_X86_DISABLE_EXITS_PAUSE);
> +        }

Documentation/virtual/kvm/api.txt says that KVM_FEATURE_PV_UNHALT
shouldn't be enabled if disabling HLT exits.  This needs to be
handled by QEMU.

Probably the simplest solution is to not allow kvm-hint-dedicated
to be enabled if kvm-pv-unhalt is.  This should be mentioned in
QEMU documentation, also, especially considering that we might
enable kvm-pv-unhalt by default in future QEMU versions.


> +        if (kvm_vm_enable_cap(cs->kvm_state, KVM_CAP_X86_DISABLE_EXITS=
, 0, disable_exits)) {
> +            error_report("kvm: DISABLE EXITS not supported");
> +        }
> +    }
> +
>      qemu_add_vm_change_state_handler(cpu_update_state, env);
> =20
>      c =3D cpuid_find_entry(&cpuid_data.cpuid, 1, 0);
> --=20
> 2.7.4
>=20
>=20

--=20
Eduardo
