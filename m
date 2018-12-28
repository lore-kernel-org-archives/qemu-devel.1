Received: from eggs.gnu.org ([208.118.235.92]:51152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gctDT-0005jr-M5
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 09:34:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gct4q-0004Bc-HA
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 09:25:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gct4o-00044v-JK
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 09:25:28 -0500
References: <cover.1545806972.git.weijiang.yang@intel.com>
	<30d79c2d6fa0658cd2818c21da852fd4dfeeae1c.1545806972.git.weijiang.yang@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <97d6366b-df95-cf00-d652-3176547ae5ca@redhat.com>
Date: Fri, 28 Dec 2018 15:25:10 +0100
MIME-Version: 1.0
In-Reply-To: <30d79c2d6fa0658cd2818c21da852fd4dfeeae1c.1545806972.git.weijiang.yang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/4] Add CET SHSTK and IBT CPUID
 feature-word definitions.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Weijiang <weijiang.yang@intel.com>, qemu-devel@nongnu.org, rkrcmar@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com, yu-cheng.yu@intel.com, yi.z.zhang@intel.com, hjl.tools@gmail.com
Cc: Zhang Yi <yi.z.zhang@linux.intel.com>

On 26/12/18 09:25, Yang Weijiang wrote:
> @@ -1233,6 +1252,14 @@ static const ExtSaveArea x86_ext_save_areas[] =3D=
 {
>            { .feature =3D FEAT_7_0_ECX, .bits =3D CPUID_7_0_ECX_PKU,
>              .offset =3D offsetof(X86XSaveArea, pkru_state),
>              .size =3D sizeof(XSavePKRU) },
> +    [XSTATE_CET_U_BIT] =3D {
> +            .feature =3D FEAT_7_0_ECX, .bits =3D CPUID_7_0_ECX_CET_SHS=
TK,
> +            .offset =3D offsetof(X86XSaveArea, cet_u),

These offsets are incorrect, since supervisor states are only stored in
the compacted format.  In fact, in patch 4, supervisor states should
return 0 in CPUID(EAX=3D0Dh,ECX=3Dn).EBX.

You can use offset =3D=3D 0 to distinguish supervisor and user states, so
that supervisor states are skipped in xsave_area_size and x86_cpu_reset.

Thanks,

Paolo

> +            .size =3D sizeof(XSaveCETU) },
> +    [XSTATE_CET_S_BIT] =3D {
> +            .feature =3D FEAT_7_0_ECX, .bits =3D CPUID_7_0_ECX_CET_SHS=
TK,
> +            .offset =3D offsetof(X86XSaveArea, cet_s),
> +            .size =3D sizeof(XSaveCETS) },
>  };
> =20
>  static uint32_t xsave_area_size(uint64_t mask)
