Received: from eggs.gnu.org ([2001:4830:134:3::10]:53612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dnLcI-0002tA-AP
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:18:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dnLcF-0007vP-1Y
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:18:26 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:36391)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dnLcE-0007uY-Rf
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:18:22 -0400
Received: by mail-wr0-x22e.google.com with SMTP id p14so414764wrg.3
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 02:18:21 -0700 (PDT)
Date: Thu, 31 Aug 2017 10:18:17 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170831091817.GG13619@stefanha-x1.localdomain>
References: <20170830082702.3011-1-Sergio.G.DelReal@gmail.com>
	<20170830082702.3011-12-Sergio.G.DelReal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830082702.3011-12-Sergio.G.DelReal@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 11/13] hvf: move fields from CPUState to
 CPUX86State
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Cc: qemu-devel@nongnu.org

On Wed, Aug 30, 2017 at 03:27:00AM -0500, Sergio Andres Gomez Del Real wrote:
> @@ -1187,11 +1190,15 @@ typedef struct CPUX86State {
>      int32_t interrupt_injected;
>      uint8_t soft_interrupt;
>      uint8_t has_error_code;
> +    uint32_t ins_len;

This field seems unused in this patch?

> @@ -678,15 +687,15 @@ int hvf_init_vcpu(CPUState *cpu)
>      sigdelset(&set, SIG_IPI);
>  
>      int r;
> -    init_emu(cpu);
> -    init_decoder(cpu);
> +    init_emu();
> +    init_decoder();
>      init_cpuid(cpu);
>  
>      hvf_state->hvf_caps = (struct hvf_vcpu_caps *)g_malloc0(sizeof(struct hvf_vcpu_caps));
> -    cpu->hvf_x86 = (struct hvf_x86_state *)g_malloc0(sizeof(struct hvf_x86_state));
> +    env->hvf_emul = (HVFX86EmulatorState *)g_malloc0(sizeof(HVFX86EmulatorState));

Please use g_new0().  The cast isn't necessary because the C compiler
casts void * to any other pointer type without a warning:

  env->hvf_emul = g_new0(HVFX86EmulatorState, 1);

>  
>      r = hv_vcpu_create((hv_vcpuid_t *)&cpu->hvf_fd, HV_VCPU_DEFAULT);
> -    cpu->hvf_vcpu_dirty = 1;
> +    cpu->vcpu_dirty = 1;

cpu->vcpu_dirty is bool.  Please use true/false consistently instead of
1/0.

> @@ -356,13 +356,14 @@ typedef struct x68_segment_selector {
>      };
>  } __attribute__ ((__packed__)) x68_segment_selector;
>  
> -/* Definition of hvf_x86_state is here */
> -struct hvf_x86_state {
> -    int hlt;
> -    uint64_t init_tsc;
> +typedef struct lazy_flags {
> +    addr_t result;
> +    addr_t auxbits;
> +} lazy_flags;
>  
> +/* Definition of hvf_x86_state is here */

hvf_x86_state no longer exists.  This comment is outdated now?
