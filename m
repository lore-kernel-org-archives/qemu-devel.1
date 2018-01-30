Received: from eggs.gnu.org ([2001:4830:134:3::10]:56606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1egdkn-0002vZ-LX
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 16:48:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1egdkA-0006IH-OE
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 16:47:45 -0500
Received: from mail-bl2nam02on0086.outbound.protection.outlook.com
	([104.47.38.86]:27316
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1egdkA-0006EM-4I
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 16:47:06 -0500
References: <20180129174132.108925-1-brijesh.singh@amd.com>
	<20180129174132.108925-6-brijesh.singh@amd.com>
	<20180130174957.GD2536@work-vm>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <c60b5f53-2f50-1866-a2b9-fda8b7c2be39@amd.com>
Date: Tue, 30 Jan 2018 15:46:45 -0600
MIME-Version: 1.0
In-Reply-To: <20180130174957.GD2536@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v6 05/23] target/i386: add memory
 encryption feature cpuid support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: brijesh.singh@amd.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Richard Henderson <rth@twiddle.net>



On 1/30/18 11:49 AM, Dr. David Alan Gilbert wrote:
> * Brijesh Singh (brijesh.singh@amd.com) wrote:
>> AMD EPYC processors support memory encryption feature. The feature
>> is reported through CPUID 8000_001F[EAX].
>>
>> Fn8000_001F [EAX]:
>>  Bit 0   Secure Memory Encryption (SME) supported
>>  Bit 1   Secure Encrypted Virtualization (SEV) supported
>>  Bit 2   Page flush MSR supported
>>  Bit 3   Ecrypted State (SEV-ES) support
>>
>> when memory encryption feature is reported, CPUID 8000_001F[EBX] should
>> provide additional information regarding the feature (such as which page
>> table bit is used to mark pages as encrypted etc). The information in EB=
X
>> and ECX may vary from one family to another hence we use the host cpuid
>> to populate the EBX information.
> That's going to make it interesting for migration.  If the guest needs
> to know that C-bit position then you presumably can't migrate between
> those two host types, but we wouldn't have anything that currently
> stops us.
> We already have similar problems with variations in physical address
> size but normally get away with that, especially on smaller VMs.

Dave,

While building the page tables guest need to know the C-bit position.
The C-bit position in the guest is same as C-bit position on the host.
For migration case, we should be able to migrate SEV guest on same host
type (i.e all EPYC and Ryzen CPUs are based on family 17 and we should
be okay migrating the SEV guests among those host types).=C2=A0 Since C-bit
position is not fixed hence migrating to different host family will be
an issue.

-Brijesh
> Dave
>
>
>> The details for memory encryption CPUID is available in AMD APM
>> (http://support.amd.com/TechDocs/24593.pdf) Section 15.34.1
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Richard Henderson <rth@twiddle.net>
>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>>  target/i386/cpu.c | 36 ++++++++++++++++++++++++++++++++++++
>>  target/i386/cpu.h |  6 ++++++
>>  2 files changed, 42 insertions(+)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index a49d2221adc9..4147eb6e18a9 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -234,6 +234,7 @@ static void x86_cpu_vendor_words2str(char *dst, uint=
32_t vendor1,
>>  #define TCG_EXT4_FEATURES 0
>>  #define TCG_SVM_FEATURES 0
>>  #define TCG_KVM_FEATURES 0
>> +#define TCG_MEM_ENCRYPT_FEATURES 0
>>  #define TCG_7_0_EBX_FEATURES (CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_SMAP |=
 \
>>            CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ADX |=
 \
>>            CPUID_7_0_EBX_PCOMMIT | CPUID_7_0_EBX_CLFLUSHOPT |           =
 \
>> @@ -545,6 +546,20 @@ static FeatureWordInfo feature_word_info[FEATURE_WO=
RDS] =3D {
>>          .cpuid_reg =3D R_EDX,
>>          .tcg_features =3D ~0U,
>>      },
>> +    [FEAT_MEM_ENCRYPT] =3D {
>> +        .feat_names =3D {
>> +            "sme", "sev", "page-flush-msr", "sev-es",
>> +            NULL, NULL, NULL, NULL,
>> +            NULL, NULL, NULL, NULL,
>> +            NULL, NULL, NULL, NULL,
>> +            NULL, NULL, NULL, NULL,
>> +            NULL, NULL, NULL, NULL,
>> +            NULL, NULL, NULL, NULL,
>> +            NULL, NULL, NULL, NULL,
>> +        },
>> +        .cpuid_eax =3D 0x8000001F, .cpuid_reg =3D R_EAX,
>> +        .tcg_features =3D TCG_MEM_ENCRYPT_FEATURES,
>> +    }
>>  };
>> =20
>>  typedef struct X86RegisterInfo32 {
>> @@ -1965,6 +1980,9 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>>              CPUID_XSAVE_XGETBV1,
>>          .features[FEAT_6_EAX] =3D
>>              CPUID_6_EAX_ARAT,
>> +        /* Missing: SEV_ES */
>> +        .features[FEAT_MEM_ENCRYPT] =3D
>> +            CPUID_8000_001F_EAX_SME | CPUID_8000_001F_EAX_SEV,
>>          .xlevel =3D 0x8000000A,
>>          .model_id =3D "AMD EPYC Processor",
>>      },
>> @@ -3589,6 +3607,19 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t ind=
ex, uint32_t count,
>>              *edx =3D 0;
>>          }
>>          break;
>> +    case 0x8000001F:
>> +        if (env->features[FEAT_MEM_ENCRYPT] & CPUID_8000_001F_EAX_SEV) =
{
>> +            *eax =3D env->features[FEAT_MEM_ENCRYPT];
>> +            host_cpuid(0x8000001F, 0, NULL, ebx, NULL, NULL);
>> +            *ecx =3D 0;
>> +            *edx =3D 0;
>> +        } else {
>> +            *eax =3D 0;
>> +            *ebx =3D 0;
>> +            *ecx =3D 0;
>> +            *edx =3D 0;
>> +        }
>> +        break;
>>      case 0xC0000000:
>>          *eax =3D env->cpuid_xlevel2;
>>          *ebx =3D 0;
>> @@ -4036,10 +4067,15 @@ static void x86_cpu_expand_features(X86CPU *cpu,=
 Error **errp)
>>          x86_cpu_adjust_feat_level(cpu, FEAT_C000_0001_EDX);
>>          x86_cpu_adjust_feat_level(cpu, FEAT_SVM);
>>          x86_cpu_adjust_feat_level(cpu, FEAT_XSAVE);
>> +        x86_cpu_adjust_feat_level(cpu, FEAT_MEM_ENCRYPT);
>>          /* SVM requires CPUID[0x8000000A] */
>>          if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) {
>>              x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000000=
A);
>>          }
>> +        /* SEV requires CPUID[0x8000001F] */
>> +        if ((env->features[FEAT_MEM_ENCRYPT] & CPUID_8000_001F_EAX_SEV)=
) {
>> +            x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000001=
F);
>> +        }
>>      }
>> =20
>>      /* Set cpuid_*level* based on cpuid_min_*level, if not explicitly s=
et */
>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>> index f91e37d25dea..f7a0ab20fdd1 100644
>> --- a/target/i386/cpu.h
>> +++ b/target/i386/cpu.h
>> @@ -483,6 +483,7 @@ typedef enum FeatureWord {
>>      FEAT_6_EAX,         /* CPUID[6].EAX */
>>      FEAT_XSAVE_COMP_LO, /* CPUID[EAX=3D0xd,ECX=3D0].EAX */
>>      FEAT_XSAVE_COMP_HI, /* CPUID[EAX=3D0xd,ECX=3D0].EDX */
>> +    FEAT_MEM_ENCRYPT,   /* CPUID[8000_001F].EAX */
>>      FEATURE_WORDS,
>>  } FeatureWord;
>> =20
>> @@ -679,6 +680,11 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
>> =20
>>  #define CPUID_6_EAX_ARAT       (1U << 2)
>> =20
>> +#define CPUID_8000_001F_EAX_SME             (1U << 0) /* SME */
>> +#define CPUID_8000_001F_EAX_SEV             (1U << 1) /* SEV */
>> +#define CPUID_8000_001F_EAX_PAGE_FLUSH_MSR  (1U << 2) /* Page flush MSR=
 */
>> +#define CPUID_8000_001F_EAX_SEV_ES          (1U << 3) /* SEV-ES */
>> +
>>  /* CPUID[0x80000007].EDX flags: */
>>  #define CPUID_APM_INVTSC       (1U << 8)
>> =20
>> --=20
>> 2.9.5
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
