Received: from eggs.gnu.org ([2001:4830:134:3::10]:49234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fIbB3-0000n1-I9
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:43:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fIbB0-0003oC-7w
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:43:45 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56317)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fIbB0-0003md-0V
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:43:42 -0400
Received: by mail-wm0-f66.google.com with SMTP id a8-v6so1487083wmg.5
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 07:43:41 -0700 (PDT)
References: <1526384258-3581-1-git-send-email-lpetrut@cloudbasesolutions.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b1f9836f-96ee-d782-1882-51c97e21d252@redhat.com>
Date: Tue, 15 May 2018 16:43:38 +0200
MIME-Version: 1.0
In-Reply-To: <1526384258-3581-1-git-send-email-lpetrut@cloudbasesolutions.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] WHPX Add signature CPUID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: petrutlucian94@gmail.com
Cc: Lucian Petrut <lpetrut@cloudbasesolutions.com>, Eduardo Habkost <ehabkost@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Alessandro Pilotti <apilotti@cloudbasesolutions.com>, Justin Terry <juterry@microsoft.com>, Richard Henderson <rth@twiddle.net>

On 15/05/2018 13:37, petrutlucian94@gmail.com wrote:
> From: Lucian Petrut <lpetrut@cloudbasesolutions.com>
> 
> Adds the CPUID trap for CPUID 0x40000000, sending the WHPX signature
> to the guest upon request. This is consistent with other QEMU
> accelerators (KVM).
> 
> Signed-off-by: Alessandro Pilotti <apilotti@cloudbasesolutions.com>
> Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
> Signed-off-by: Lucian Petrut <lpetrut@cloudbasesolutions.com>

Is it worth defining a different signature?  Can WHPX implement part of
the Hyper-V spec, and if so would it be better to return the Hv
signature ("Hv#1") instead?

Thanks,

Paolo

> ---
> As opposed to the previous patch, this one will set the result of
> this specific CPUID leaf when initializing the accelerator so that
> we avoid a vcpu exit.
> 
>  target/i386/whpx-all.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
> index 5843517..c8310de 100644
> --- a/target/i386/whpx-all.c
> +++ b/target/i386/whpx-all.c
> @@ -29,6 +29,8 @@
>  #include <WinHvPlatform.h>
>  #include <WinHvEmulation.h>
>  
> +#define WHPX_CPUID_SIGNATURE 0x40000000
> +
>  struct whpx_state {
>      uint64_t mem_quota;
>      WHV_PARTITION_HANDLE partition;
> @@ -1342,6 +1344,27 @@ static int whpx_accel_init(MachineState *ms)
>                                   cpuidExitList,
>                                   RTL_NUMBER_OF(cpuidExitList) * sizeof(UINT32));
>  
> +    UINT32 signature[3] = {0};
> +    memcpy(signature, "WHPXWHPXWHPX", 12);
> +
> +    WHV_X64_CPUID_RESULT cpuidResultList[1] = {0};
> +    cpuidResultList[0].Function = WHPX_CPUID_SIGNATURE;
> +    cpuidResultList[0].Eax = 0;
> +    cpuidResultList[0].Ebx = signature[0];
> +    cpuidResultList[0].Ecx = signature[1];
> +    cpuidResultList[0].Edx = signature[2];
> +    hr = WHvSetPartitionProperty(whpx->partition,
> +                                 WHvPartitionPropertyCodeCpuidResultList,
> +                                 cpuidResultList,
> +                                 RTL_NUMBER_OF(cpuidResultList) *
> +                                    sizeof(WHV_X64_CPUID_RESULT));
> +    if (FAILED(hr)) {
> +        error_report("WHPX: Failed to set partition CpuidResultList hr=%08lx",
> +                     hr);
> +        ret = -EINVAL;
> +        goto error;
> +    }
> +
>      if (FAILED(hr)) {
>          error_report("WHPX: Failed to set partition CpuidExitList hr=%08lx",
>                       hr);
> 
