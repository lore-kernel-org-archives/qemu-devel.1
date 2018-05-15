Received: from eggs.gnu.org ([2001:4830:134:3::10]:37529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1fIaWn-0000yi-Dl
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:02:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1fIaWg-0005zb-OU
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:02:09 -0400
Received: from mail-sn1nam01on0138.outbound.protection.outlook.com
	([104.47.32.138]:38352
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <juterry@microsoft.com>)
	id 1fIaWg-0005xd-2N
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:02:02 -0400
From: "Justin Terry (VM)" <juterry@microsoft.com>
Date: Tue, 15 May 2018 14:01:58 +0000
Message-ID: <DM5PR21MB0170B4F7125E540206F12317B6930@DM5PR21MB0170.namprd21.prod.outlook.com>
References: <1526384258-3581-1-git-send-email-lpetrut@cloudbasesolutions.com>
In-Reply-To: <1526384258-3581-1-git-send-email-lpetrut@cloudbasesolutions.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] WHPX Add signature CPUID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "petrutlucian94@gmail.com" <petrutlucian94@gmail.com>
Cc: Lucian Petrut <lpetrut@cloudbasesolutions.com>, apilotti <apilotti@cloudbasesolutions.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>

Thanks for the patch Lucian. Looks good to me!

-Justin

> -----Original Message-----
> From: petrutlucian94@gmail.com <petrutlucian94@gmail.com>
> Sent: Tuesday, May 15, 2018 4:38 AM
> Cc: Lucian Petrut <lpetrut@cloudbasesolutions.com>; apilotti
> <apilotti@cloudbasesolutions.com>; Justin Terry (VM)
> <juterry@microsoft.com>; Paolo Bonzini <pbonzini@redhat.com>; Richard
> Henderson <rth@twiddle.net>; Eduardo Habkost <ehabkost@redhat.com>;
> open list:All patches CC here <qemu-devel@nongnu.org>
> Subject: [PATCH] WHPX Add signature CPUID
>=20
> From: Lucian Petrut <lpetrut@cloudbasesolutions.com>
>=20
> Adds the CPUID trap for CPUID 0x40000000, sending the WHPX signature to
> the guest upon request. This is consistent with other QEMU accelerators
> (KVM).
>=20
> Signed-off-by: Alessandro Pilotti <apilotti@cloudbasesolutions.com>
> Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
> Signed-off-by: Lucian Petrut <lpetrut@cloudbasesolutions.com>
> ---
> As opposed to the previous patch, this one will set the result of this sp=
ecific
> CPUID leaf when initializing the accelerator so that we avoid a vcpu exit=
.
>=20
>  target/i386/whpx-all.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>=20
> diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c index
> 5843517..c8310de 100644
> --- a/target/i386/whpx-all.c
> +++ b/target/i386/whpx-all.c
> @@ -29,6 +29,8 @@
>  #include <WinHvPlatform.h>
>  #include <WinHvEmulation.h>
>=20
> +#define WHPX_CPUID_SIGNATURE 0x40000000
> +
>  struct whpx_state {
>      uint64_t mem_quota;
>      WHV_PARTITION_HANDLE partition;
> @@ -1342,6 +1344,27 @@ static int whpx_accel_init(MachineState *ms)
>                                   cpuidExitList,
>                                   RTL_NUMBER_OF(cpuidExitList) * sizeof(U=
INT32));
>=20
> +    UINT32 signature[3] =3D {0};
> +    memcpy(signature, "WHPXWHPXWHPX", 12);
> +
> +    WHV_X64_CPUID_RESULT cpuidResultList[1] =3D {0};
> +    cpuidResultList[0].Function =3D WHPX_CPUID_SIGNATURE;
> +    cpuidResultList[0].Eax =3D 0;
> +    cpuidResultList[0].Ebx =3D signature[0];
> +    cpuidResultList[0].Ecx =3D signature[1];
> +    cpuidResultList[0].Edx =3D signature[2];
> +    hr =3D WHvSetPartitionProperty(whpx->partition,
> +                                 WHvPartitionPropertyCodeCpuidResultList=
,
> +                                 cpuidResultList,
> +                                 RTL_NUMBER_OF(cpuidResultList) *
> +                                    sizeof(WHV_X64_CPUID_RESULT));
> +    if (FAILED(hr)) {
> +        error_report("WHPX: Failed to set partition CpuidResultList hr=
=3D%08lx",
> +                     hr);
> +        ret =3D -EINVAL;
> +        goto error;
> +    }
> +
>      if (FAILED(hr)) {
>          error_report("WHPX: Failed to set partition CpuidExitList hr=3D%=
08lx",
>                       hr);
> --
> 2.7.4
