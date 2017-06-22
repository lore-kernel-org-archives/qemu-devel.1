Received: from eggs.gnu.org ([2001:4830:134:3::10]:59208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dNyTH-0004l9-Qs
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 05:32:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dNyTE-0005e4-O6
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 05:32:15 -0400
Received: from mga04.intel.com ([192.55.52.120]:1145)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dNyTE-0005dx-EM
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 05:32:12 -0400
Date: Thu, 22 Jun 2017 17:32:01 +0800
From: Zhong Yang <yang.zhong@intel.com>
Message-ID: <20170622093201.GD28944@yangzhon-Virtual>
References: <1498040401-16361-1-git-send-email-yang.zhong@intel.com>
	<1498040401-16361-14-git-send-email-yang.zhong@intel.com>
	<f43b3405-c7c8-a3e0-1b36-fea3e42b447f@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f43b3405-c7c8-a3e0-1b36-fea3e42b447f@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 13/15] tcg: disable tcg in CPUX86State
 struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, anthony.xu@intel.com, a.rigo@virtualopensystems.com, Thomas Huth <thuth@redhat.com>, yang.zhong@intel.com

On Wed, Jun 21, 2017 at 03:24:29PM -0700, Richard Henderson wrote:
> On 06/21/2017 03:19 AM, Yang Zhong wrote:
> >--- a/target/i386/cpu.h
> >+++ b/target/i386/cpu.h
> >@@ -52,7 +52,9 @@
> >  #include "exec/cpu-defs.h"
> >+#ifdef CONFIG_TCG
> >  #include "fpu/softfloat.h"
> >+#endif
> >  #define R_EAX 0
> >  #define R_ECX 1
> >@@ -1130,8 +1132,9 @@ typedef struct CPUX86State {
> >      /* Fields up to this point are cleared by a CPU reset */
> >      struct {} end_reset_fields;
> >-
> >+#ifdef CONFIG_TCG
> >      CPU_COMMON
> >+#endif
> 
> This is at the wrong level.  If !CONFIG_TCG, then CPU_COMMON should be empty.
> 
> 
> r~

  Hello Richard,

  In fact, i can remove this CONFIG_TCG for CPU_COMMON in the CPUX86State struct

  because there is one change in the same patch ID.

  diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h index 5f4e303..bc8e7f8 100644
  --- a/include/exec/cpu-defs.h
  +++ b/include/exec/cpu-defs.h
  @@ -25,7 +25,9 @@
 
  #include "qemu/host-utils.h"
  #include "qemu/queue.h"
 +#ifdef CONFIG_TCG
  #include "tcg-target.h"
 +#endif
  #ifndef CONFIG_USER_ONLY
  #include "exec/hwaddr.h"
  #endif
  @@ -54,7 +56,7 @@ typedef uint64_t target_ulong;  #error TARGET_LONG_SIZE undefined  #endif
 
 -#if !defined(CONFIG_USER_ONLY)
 +#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
  /* use a fully associative victim tlb of 8 entries */  #define CPU_VTLB_SIZE 8


 if tcg is disabled, CPU_COMMON_TLB is NULL.

 #define CPU_COMMON                                                      \
    /* soft mmu support */                                              \
    CPU_COMMON_TLB                                                      \

 So the CPU_COMMON should be NULL if the tcg is disabled.


 Yang
