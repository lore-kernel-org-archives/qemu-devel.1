Received: from eggs.gnu.org ([2001:4830:134:3::10]:60104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1FDs-0000B2-9W
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 13:50:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1FDp-0002R7-6n
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 13:50:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f1FDo-0002Pa-UJ
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 13:50:53 -0400
Date: Wed, 28 Mar 2018 14:50:50 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180328175050.GH5046@localhost.localdomain>
References: <20180326170658.606-1-juterry@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326170658.606-1-juterry@microsoft.com>
Subject: Re: [Qemu-devel] [PATCH] WHPX fixes an issue with CPUID 1 not
 returning CPUID_EXT_HYPERVISOR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Justin Terry (VM)" <juterry@microsoft.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net

On Mon, Mar 26, 2018 at 10:06:58AM -0700, Justin Terry (VM) wrote:
> Implements the CPUID trap for CPUID 1 to include the
> CPUID_EXT_HYPERVISOR flag in the ECX results. This was preventing some
> older linux kernels from booting when trying to access MSR's that dont
> make sense when virtualized.
> 
> Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
> ---
>  target/i386/whpx-all.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 78 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
> index bf33d320bf..58435178a4 100644
> --- a/target/i386/whpx-all.c
> +++ b/target/i386/whpx-all.c
> @@ -911,12 +911,62 @@ static int whpx_vcpu_run(CPUState *cpu)
>              ret = 1;
>              break;
>  
> +        case WHvRunVpExitReasonX64Cpuid: {
> +            WHV_REGISTER_VALUE reg_values[5] = {0};
> +            WHV_REGISTER_NAME reg_names[5];
> +            UINT32 reg_count = 5;
> +            UINT64 rip, rax, rcx, rdx, rbx;
> +
> +            rip = vcpu->exit_ctx.VpContext.Rip +
> +                  vcpu->exit_ctx.VpContext.InstructionLength;
> +            switch (vcpu->exit_ctx.CpuidAccess.Rax) {
> +            case 1:
> +                rax = vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
> +                /* Advertise that we are running on a hypervisor */
> +                rcx =
> +                    vcpu->exit_ctx.CpuidAccess.DefaultResultRcx |
> +                    CPUID_EXT_HYPERVISOR;
> +
> +                rdx = vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
> +                rbx = vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
> +                break;
> +            default:
> +                rax = vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
> +                rcx = vcpu->exit_ctx.CpuidAccess.DefaultResultRcx;
> +                rdx = vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
> +                rbx = vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;

Interesting, so the WHPX API already tries to provide default
values for the CPUID leaves.  Would it make sense to try and use
the values returned by cpu_x86_cpuid() in the future?

Is there a way to get the default CPUID results from the WHPX API
without calling WHvRunVirtualProcessor(), so QEMU can be aware of
what exactly the guest is seeing on CPUID?


> +            }
> +
> +            reg_names[0] = WHvX64RegisterRip;
> +            reg_names[1] = WHvX64RegisterRax;
> +            reg_names[2] = WHvX64RegisterRcx;
> +            reg_names[3] = WHvX64RegisterRdx;
> +            reg_names[4] = WHvX64RegisterRbx;
> +
> +            reg_values[0].Reg64 = rip;
> +            reg_values[1].Reg64 = rax;
> +            reg_values[2].Reg64 = rcx;
> +            reg_values[3].Reg64 = rdx;
> +            reg_values[4].Reg64 = rbx;
> +
> +            hr = WHvSetVirtualProcessorRegisters(whpx->partition,
> +                                                 cpu->cpu_index,
> +                                                 reg_names,
> +                                                 reg_count,
> +                                                 reg_values);
> +
> +            if (FAILED(hr)) {
> +                error_report("WHPX: Failed to set CpuidAccess state registers,"
> +                             " hr=%08lx", hr);
> +            }
> +            ret = 0;
> +            break;
> +        }
>          case WHvRunVpExitReasonNone:
>          case WHvRunVpExitReasonUnrecoverableException:
>          case WHvRunVpExitReasonInvalidVpRegisterValue:
>          case WHvRunVpExitReasonUnsupportedFeature:
>          case WHvRunVpExitReasonX64MsrAccess:
> -        case WHvRunVpExitReasonX64Cpuid:
>          case WHvRunVpExitReasonException:
>          default:
>              error_report("WHPX: Unexpected VP exit code %d",
> @@ -1272,6 +1322,33 @@ static int whpx_accel_init(MachineState *ms)
>          goto error;
>      }
>  
> +    memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
> +    prop.ExtendedVmExits.X64CpuidExit = 1;
> +    hr = WHvSetPartitionProperty(whpx->partition,
> +                                 WHvPartitionPropertyCodeExtendedVmExits,
> +                                 &prop,
> +                                 sizeof(WHV_PARTITION_PROPERTY));
> +
> +    if (FAILED(hr)) {
> +        error_report("WHPX: Failed to enable partition extended X64CpuidExit"
> +                     " hr=%08lx", hr);
> +        ret = -EINVAL;
> +        goto error;
> +    }
> +
> +    UINT32 cpuidExitList[] = {1};
> +    hr = WHvSetPartitionProperty(whpx->partition,
> +                                 WHvPartitionPropertyCodeCpuidExitList,
> +                                 cpuidExitList,
> +                                 RTL_NUMBER_OF(cpuidExitList) * sizeof(UINT32));
> +
> +    if (FAILED(hr)) {
> +        error_report("WHPX: Failed to set partition CpuidExitList hr=%08lx",
> +                     hr);
> +        ret = -EINVAL;
> +        goto error;
> +    }
> +
>      hr = WHvSetupPartition(whpx->partition);
>      if (FAILED(hr)) {
>          error_report("WHPX: Failed to setup partition, hr=%08lx", hr);
> -- 
> 2.11.0
> 

-- 
Eduardo
