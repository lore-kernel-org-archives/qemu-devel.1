Received: from eggs.gnu.org ([2001:4830:134:3::10]:41501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1f1I0E-0000GN-Q8
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 16:49:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1f1I0A-0003ex-8v
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 16:49:02 -0400
Received: from mail-cys01nam02on0129.outbound.protection.outlook.com
	([104.47.37.129]:58640
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <juterry@microsoft.com>)
	id 1f1I09-0003eO-V1
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 16:48:58 -0400
From: "Justin Terry (VM)" <juterry@microsoft.com>
Date: Wed, 28 Mar 2018 20:48:54 +0000
Message-ID: <DM5PR21MB0170C0B7995A9AC36D2F7C5BB6A30@DM5PR21MB0170.namprd21.prod.outlook.com>
References: <20180326170658.606-1-juterry@microsoft.com>
	<20180328175050.GH5046@localhost.localdomain>
In-Reply-To: <20180328175050.GH5046@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>

Hey Eduardo

Responses inline. Thanks!

> -----Original Message-----
> From: Eduardo Habkost <ehabkost@redhat.com>
> Sent: Wednesday, March 28, 2018 10:51 AM
> To: Justin Terry (VM) <juterry@microsoft.com>
> Cc: qemu-devel@nongnu.org; pbonzini@redhat.com; rth@twiddle.net
> Subject: Re: [PATCH] WHPX fixes an issue with CPUID 1 not returning
> CPUID_EXT_HYPERVISOR
>=20
> On Mon, Mar 26, 2018 at 10:06:58AM -0700, Justin Terry (VM) wrote:
> > Implements the CPUID trap for CPUID 1 to include the
> > CPUID_EXT_HYPERVISOR flag in the ECX results. This was preventing some
> > older linux kernels from booting when trying to access MSR's that dont
> > make sense when virtualized.
> >
> > Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
> > ---
> >  target/i386/whpx-all.c | 79
> > +++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 78 insertions(+), 1 deletion(-)
> >
> > diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c index
> > bf33d320bf..58435178a4 100644
> > --- a/target/i386/whpx-all.c
> > +++ b/target/i386/whpx-all.c
> > @@ -911,12 +911,62 @@ static int whpx_vcpu_run(CPUState *cpu)
> >              ret =3D 1;
> >              break;
> >
> > +        case WHvRunVpExitReasonX64Cpuid: {
> > +            WHV_REGISTER_VALUE reg_values[5] =3D {0};
> > +            WHV_REGISTER_NAME reg_names[5];
> > +            UINT32 reg_count =3D 5;
> > +            UINT64 rip, rax, rcx, rdx, rbx;
> > +
> > +            rip =3D vcpu->exit_ctx.VpContext.Rip +
> > +                  vcpu->exit_ctx.VpContext.InstructionLength;
> > +            switch (vcpu->exit_ctx.CpuidAccess.Rax) {
> > +            case 1:
> > +                rax =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
> > +                /* Advertise that we are running on a hypervisor */
> > +                rcx =3D
> > +                    vcpu->exit_ctx.CpuidAccess.DefaultResultRcx |
> > +                    CPUID_EXT_HYPERVISOR;
> > +
> > +                rdx =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
> > +                rbx =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
> > +                break;
> > +            default:
> > +                rax =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
> > +                rcx =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRcx;
> > +                rdx =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
> > +                rbx =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
>=20
> Interesting, so the WHPX API already tries to provide default values for =
the
> CPUID leaves.  Would it make sense to try and use the values returned by
> cpu_x86_cpuid() in the future?
>=20
> Is there a way to get the default CPUID results from the WHPX API without
> calling WHvRunVirtualProcessor(), so QEMU can be aware of what exactly
> the guest is seeing on CPUID?

The platform now has two ways to interact with CPUID.

1. (As the code is doing now). At partition creation time you can register =
for specific CPUID exits and then respond to the CPUID with your custom ans=
wer or with the Hypervisor defaults that were forwarded to you. Unfortunate=
ly, QEMU has no way to know the Hypervisor default ahead of time but QEMU c=
an make at least make a runtime decision about how to respond.
2. At partition creation time the platform allows QEMU to inject (set) the =
default responses for specific CPUID exits. This can now be done by setting=
 the  `WHV_X64_CPUID_RESULT` in the `CpuidResultList` of `WHV_PARTITION_PRO=
PERTY` to the exit values QEMU wants. So effectively you can know the answe=
rs ahead of time for any that you set but the answers are not dynamic.

The only issues/questions I have there are:

If we use [1] (like the code is now) I don't see any way to keep the exits =
in cpu_x86_cpuid() matched up with the registered exits to WHPX. This means=
 that WHPX would not be called in these cases and would instead get the Hyp=
ervisor default rather than the answer from cpu_x86_cpuid().

If we use [2] to inject the answers at creation time WHPX needs access to t=
he CPUX86State at accel init which also doesn't seem to be possible in QEMU=
 today. WHPX could basically just call cpu_x86_cpuid() for each CPUID QEMU =
cares about and plumb the answer before start. This has the best performanc=
e as we avoid the additional exits but has an issue in that the results mus=
t be known ahead of time.

And, we could obviously use a hybrid of the two for cases we know. Do you h=
ave any ideas that I could try out here on how you would like to see this w=
ork?

Thanks,
Justin

>=20
>=20
> > +            }
> > +
> > +            reg_names[0] =3D WHvX64RegisterRip;
> > +            reg_names[1] =3D WHvX64RegisterRax;
> > +            reg_names[2] =3D WHvX64RegisterRcx;
> > +            reg_names[3] =3D WHvX64RegisterRdx;
> > +            reg_names[4] =3D WHvX64RegisterRbx;
> > +
> > +            reg_values[0].Reg64 =3D rip;
> > +            reg_values[1].Reg64 =3D rax;
> > +            reg_values[2].Reg64 =3D rcx;
> > +            reg_values[3].Reg64 =3D rdx;
> > +            reg_values[4].Reg64 =3D rbx;
> > +
> > +            hr =3D WHvSetVirtualProcessorRegisters(whpx->partition,
> > +                                                 cpu->cpu_index,
> > +                                                 reg_names,
> > +                                                 reg_count,
> > +                                                 reg_values);
> > +
> > +            if (FAILED(hr)) {
> > +                error_report("WHPX: Failed to set CpuidAccess state re=
gisters,"
> > +                             " hr=3D%08lx", hr);
> > +            }
> > +            ret =3D 0;
> > +            break;
> > +        }
> >          case WHvRunVpExitReasonNone:
> >          case WHvRunVpExitReasonUnrecoverableException:
> >          case WHvRunVpExitReasonInvalidVpRegisterValue:
> >          case WHvRunVpExitReasonUnsupportedFeature:
> >          case WHvRunVpExitReasonX64MsrAccess:
> > -        case WHvRunVpExitReasonX64Cpuid:
> >          case WHvRunVpExitReasonException:
> >          default:
> >              error_report("WHPX: Unexpected VP exit code %d", @@
> > -1272,6 +1322,33 @@ static int whpx_accel_init(MachineState *ms)
> >          goto error;
> >      }
> >
> > +    memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
> > +    prop.ExtendedVmExits.X64CpuidExit =3D 1;
> > +    hr =3D WHvSetPartitionProperty(whpx->partition,
> > +                                 WHvPartitionPropertyCodeExtendedVmExi=
ts,
> > +                                 &prop,
> > +                                 sizeof(WHV_PARTITION_PROPERTY));
> > +
> > +    if (FAILED(hr)) {
> > +        error_report("WHPX: Failed to enable partition extended
> X64CpuidExit"
> > +                     " hr=3D%08lx", hr);
> > +        ret =3D -EINVAL;
> > +        goto error;
> > +    }
> > +
> > +    UINT32 cpuidExitList[] =3D {1};
> > +    hr =3D WHvSetPartitionProperty(whpx->partition,
> > +                                 WHvPartitionPropertyCodeCpuidExitList=
,
> > +                                 cpuidExitList,
> > +                                 RTL_NUMBER_OF(cpuidExitList) *
> > + sizeof(UINT32));
> > +
> > +    if (FAILED(hr)) {
> > +        error_report("WHPX: Failed to set partition CpuidExitList hr=
=3D%08lx",
> > +                     hr);
> > +        ret =3D -EINVAL;
> > +        goto error;
> > +    }
> > +
> >      hr =3D WHvSetupPartition(whpx->partition);
> >      if (FAILED(hr)) {
> >          error_report("WHPX: Failed to setup partition, hr=3D%08lx",
> > hr);
> > --
> > 2.11.0
> >
>=20
> --
> Eduardo
