Received: from eggs.gnu.org ([2001:4830:134:3::10]:52201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alexandr.iarygin@profitbricks.com>)
	id 1f5a9H-0004Oq-Ah
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 13:00:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alexandr.iarygin@profitbricks.com>)
	id 1f5a9D-0003Lt-8D
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 13:00:07 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34616)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alexandr.iarygin@profitbricks.com>)
	id 1f5a9D-0003Jg-0Y
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 13:00:03 -0400
Received: by mail-wm0-x243.google.com with SMTP id w2so18475547wmw.1
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 10:00:01 -0700 (PDT)
From: Alexandr Iarygin <alexandr.iarygin@profitbricks.com>
In-Reply-To: <1522186271-27743-5-git-send-email-babu.moger@amd.com>
References: <1522186271-27743-1-git-send-email-babu.moger@amd.com>
	<1522186271-27743-5-git-send-email-babu.moger@amd.com>
Date: Mon, 09 Apr 2018 18:59:58 +0200
Message-ID: <867epg48oh.fsf@profitbricks.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 4/9] i386: Add new property to control
 cache info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Babu Moger <babu.moger@amd.com>, mst@redhat.com, marcel@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, kash@tripleback.net, Alexandr Iarygin <alexandr.iarygin@profitbricks.com>

Hello,

Babu Moger <babu.moger@amd.com> writes:

> This will be used to control the cache information.
> By default new information will be displayed. If user
> passes "-cpu legacy-cache" then older information will
> be displayed even if the hardware supports new information.
>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  include/hw/i386/pc.h | 6 +++++-
>  target/i386/cpu.c    | 1 +
>  target/i386/cpu.h    | 5 +++++
>  3 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index ffee841..9cda1ab 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -327,7 +327,11 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
>          .driver   = "q35-pcihost",\
>          .property = "x-pci-hole64-fix",\
>          .value    = "off",\
> -    },
> +    },{\
> +        .driver   = TYPE_X86_CPU,\
> +        .property = "legacy-cache",\
> +        .value    = "off",\
> +    },\

Should be "on". Also note that this introduces extra '\' at the end.

>  
>  #define PC_COMPAT_2_9 \
>      HW_COMPAT_2_9 \
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 67faa53..f4fbe3a 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5132,6 +5132,7 @@ static Property x86_cpu_properties[] = {
>                       false),
>      DEFINE_PROP_BOOL("vmware-cpuid-freq", X86CPU, vmware_cpuid_freq, true),
>      DEFINE_PROP_BOOL("tcg-cpuid", X86CPU, expose_tcg, true),
> +    DEFINE_PROP_BOOL("legacy-cache", X86CPU, legacy_cache, false),

I'm wondering the reason why Intel L1 caches aren't shared per threads,
L2 not shared per threads/cores etc? I mean, changing that will also
require new compat flag with very similar name.

>  
>      /*
>       * From "Requirements for Implementing the Microsoft
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 806c34b..bbe13f2 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1394,6 +1394,11 @@ struct X86CPU {
>       */
>      bool enable_l3_cache;
>  
> +    /* Compatibility bits for old machine types.
> +     * If true present the old cache topology information
> +     */
> +    bool legacy_cache;
> +
>      /* Compatibility bits for old machine types: */
>      bool enable_cpuid_0xb;
>  
> -- 
> 1.8.3.1
