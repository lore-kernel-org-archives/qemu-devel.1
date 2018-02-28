Received: from eggs.gnu.org ([2001:4830:134:3::10]:47392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1er6PT-0005UW-BK
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:25:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1er6PS-0003xD-GQ
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:24:59 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54260 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkrcmar@redhat.com>) id 1er6PS-0003wN-Aa
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:24:58 -0500
Date: Wed, 28 Feb 2018 19:24:21 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Message-ID: <20180228182420.GC8418@flask>
References: <1519439425-27883-1-git-send-email-babu.moger@amd.com>
	<1519439425-27883-4-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519439425-27883-4-git-send-email-babu.moger@amd.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/5] target/i386: Add support for
 CPUID_8000_001E for AMD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Babu Moger <babu.moger@amd.com>
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, pixo@polepetko.eu, Gary.Hook@amd.com

2018-02-23 21:30-0500, Babu Moger:
> From: Stanislav Lanci <pixo@polepetko.eu>
> 
> Populate threads/core_id/apic_ids/socket_id when CPUID_EXT3_TOPOEXT
> feature is supported. This is required to support hyperthreading
> feature on AMD CPUS. These are supported via CPUID_8000_001E extended
> functions.
> 
> Signed-off-by: Stanislav Lanci <pixo@polepetko.eu>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  target/i386/cpu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index a5a480e..191e850 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -3666,6 +3666,14 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>              *edx = 0;
>          }
>          break;
> +    case 0x8000001E:
> +        if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) {
> +            *eax = cpu->apic_id;
> +            *ebx = (cs->nr_threads - 1) << 8 | cpu->core_id;

Do we somewhere assert that AMD cannot have cpu->core_id > 255?
(qemu does allow weird configurations.)

Thanks.

> +            *ecx = cpu->socket_id;
> +            *edx = 0;
> +        }
> +        break;
>      case 0xC0000000:
>          *eax = env->cpuid_xlevel2;
>          *ebx = 0;
> -- 
> 1.8.3.1
> 
