Received: from eggs.gnu.org ([2001:4830:134:3::10]:38585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dnKQ0-0007BF-E4
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:01:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dnKPu-0005zU-JB
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:01:40 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:37488)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dnKPu-0005yz-CZ
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:01:34 -0400
Received: by mail-wm0-x242.google.com with SMTP id x189so4072168wmg.4
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 01:01:34 -0700 (PDT)
Date: Thu, 31 Aug 2017 09:01:31 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170831080131.GC13619@stefanha-x1.localdomain>
References: <20170830082702.3011-1-Sergio.G.DelReal@gmail.com>
	<20170830082702.3011-5-Sergio.G.DelReal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830082702.3011-5-Sergio.G.DelReal@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 04/13] hvf: run hvf code through
 checkpatch.pl and fix style issues
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

On Wed, Aug 30, 2017 at 03:26:53AM -0500, Sergio Andres Gomez Del Real wrote:
> @@ -900,6 +904,9 @@ void cpu_synchronize_all_states(void)
>  
>      CPU_FOREACH(cpu) {
>          cpu_synchronize_state(cpu);
> +        if (hvf_enabled()) {
> +            hvf_cpu_synchronize_state(cpu);
> +        }

The other accelerators put their code into cpu_synchronize_state():

  static inline void cpu_synchronize_state(CPUState *cpu)
  {
      if (kvm_enabled()) {
          kvm_cpu_synchronize_state(cpu);
      }
      if (hax_enabled()) {
          hax_cpu_synchronize_state(cpu);
      }
  }

Why put the hvf code outside cpu_synchronize_state()?

>      }
>  }
>  
> @@ -909,6 +916,9 @@ void cpu_synchronize_all_post_reset(void)
>  
>      CPU_FOREACH(cpu) {
>          cpu_synchronize_post_reset(cpu);
> +        if (hvf_enabled()) {
> +            hvf_cpu_synchronize_post_reset(cpu);
> +        }

Same here.

>      }
>  }
>  
> @@ -918,6 +928,9 @@ void cpu_synchronize_all_post_init(void)
>  
>      CPU_FOREACH(cpu) {
>          cpu_synchronize_post_init(cpu);
> +        if (hvf_enabled()) {
> +            hvf_cpu_synchronize_post_init(cpu);
> +        }

Same here.

These changes are not checkpatch.pl fixes.  It's okay to have a huge
patch that just fixes checkpatch.pl issues, but please don't include
other changes in the patch.  They should go in separate commits with
proper commit messages/descriptions.

I'll wait for the next revision before reviewing this patch further.
