Received: from eggs.gnu.org ([209.51.188.92]:37659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h2DjZ-0003ch-Pn
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 06:32:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h2DjX-00056q-MK
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 06:32:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1h2DjV-0004OH-8E
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 06:32:09 -0500
References: <20190225133744.7095-1-weijiang.yang@intel.com>
	<20190225133744.7095-5-weijiang.yang@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a3136176-6ea3-2a1e-57f6-33cc8abbff54@redhat.com>
Date: Fri, 8 Mar 2019 12:31:57 +0100
MIME-Version: 1.0
In-Reply-To: <20190225133744.7095-5-weijiang.yang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/5] Report CPUID xsave area support for
 CET.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Weijiang <weijiang.yang@intel.com>, cdupontd@redhat.com, rkrcmar@redhat.com, qemu-devel@nongnu.org, mst@redhat.com
Cc: Zhang Yi <yi.z.zhang@linux.intel.com>

On 25/02/19 14:37, Yang Weijiang wrote:
> @@ -4399,12 +4399,22 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t i=
ndex, uint32_t count,
>              *ebx =3D xsave_area_size(env->xcr0);
>          } else if (count =3D=3D 1) {
>              *eax =3D env->features[FEAT_XSAVE];
> +            *ecx =3D env->features[FEAT_XSAVE_SV_LO];
> +            *edx =3D env->features[FEAT_XSAVE_SV_HI];
> +            *ebx =3D xsave_area_size_compacted(x86_cpu_xsave_component=
s(cpu) |
> +                    x86_cpu_xsave_sv_components(cpu));

*ebx should not be necessary, KVM computes it automatically.  In fact it
doesn't depend on x86_cpu_xsave_components and
x86_cpu_xsave_sv_components, it depends on XCR0 and MSR_IA32_XSS, so you
can just drop it.

Paolo
