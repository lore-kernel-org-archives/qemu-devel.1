Received: from eggs.gnu.org ([2001:4830:134:3::10]:53402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dmcrt-0001Im-6s
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:31:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dmcro-0007Bo-K3
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:31:32 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:38734)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dmcro-0007BM-B8
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:31:28 -0400
Received: by mail-wm0-x242.google.com with SMTP id u26so3068418wma.5
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 02:31:28 -0700 (PDT)
Date: Tue, 29 Aug 2017 10:31:24 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170829093124.GE25960@stefanha-x1.localdomain>
References: <20170828015654.2530-1-Sergio.G.DelReal@gmail.com>
	<20170828015654.2530-5-Sergio.G.DelReal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170828015654.2530-5-Sergio.G.DelReal@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 04/14] hvf: add fields to CPUState and
 CPUX86State; add definitions
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

On Sun, Aug 27, 2017 at 08:56:44PM -0500, Sergio Andres Gomez Del Real wrote:
> This commit adds some fields specific to hvf in CPUState and
> CPUX86State. It also adds some handy #defines.
> 
> Signed-off-by: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>
> ---
>  include/qom/cpu.h |  8 ++++++++
>  target/i386/cpu.h | 23 +++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index 25eefea7ab..c46eb61240 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -407,6 +407,14 @@ struct CPUState {
>       * unnecessary flushes.
>       */
>      uint16_t pending_tlb_flush;
> +
> +    // HVF

Please see ./CODING_STYLE "7. Comment style":

  We use traditional C-style /* */ comments and avoid // comments.

> +    bool hvf_vcpu_dirty;
> +    uint64_t hvf_fd; // fd of vcpu created by HVF

File descriptors are ints, why is this uint64_t?

This also raises an issue: none of these fields are used in the patch.
This makes it hard to review the code.  I don't know whether the
definitions are correct without seeing the code that uses them.

Please structure the patch series so that patches are self-contained,
logical changes that can be reviewed in isolation.  These field
definitions should be made in the same patch uses the fields.

> +    // Supporting data structures for VMCS capabilities
> +    // and x86 emulation state
> +    struct hvf_vcpu_caps* hvf_caps;
> +    struct hvf_x86_state* hvf_x86;

Coding style:
1. Please use typedef struct {...} TypeName.
2. Please use TypeName *ptr.

>  };
>  
>  QTAILQ_HEAD(CPUTailQ, CPUState);
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 051867399b..7d90f08b98 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -82,15 +82,19 @@
>  #define R_GS 5
>  
>  /* segment descriptor fields */
> +#define DESC_G_SHIFT    23
>  #define DESC_G_MASK     (1 << 23)
>  #define DESC_B_SHIFT    22
>  #define DESC_B_MASK     (1 << DESC_B_SHIFT)
>  #define DESC_L_SHIFT    21 /* x86_64 only : 64 bit code segment */
>  #define DESC_L_MASK     (1 << DESC_L_SHIFT)
> +#define DESC_AVL_SHIFT  20
>  #define DESC_AVL_MASK   (1 << 20)
> +#define DESC_P_SHIFT    15
>  #define DESC_P_MASK     (1 << 15)
>  #define DESC_DPL_SHIFT  13
>  #define DESC_DPL_MASK   (3 << DESC_DPL_SHIFT)
> +#define DESC_S_SHIFT    12
>  #define DESC_S_MASK     (1 << 12)

Please reuse the new constants to avoid duplication (just like existing
code for DESC_B_MASK does):

  #define DESC_S_SHIFT    12
  #define DESC_S_MASK     (1 << DESC_S_SHIFT)
