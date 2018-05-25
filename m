Received: from eggs.gnu.org ([2001:4830:134:3::10]:49411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fMAYR-0005GN-Va
	for qemu-devel@nongnu.org; Fri, 25 May 2018 07:06:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fMAYQ-0002HB-Qj
	for qemu-devel@nongnu.org; Fri, 25 May 2018 07:06:39 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:44885)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fMAYQ-0002Gl-Le
	for qemu-devel@nongnu.org; Fri, 25 May 2018 07:06:38 -0400
Received: by mail-ot0-x241.google.com with SMTP id g7-v6so5597349otj.11
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 04:06:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1527086545-68024-8-git-send-email-mst@redhat.com>
References: <1527086545-68024-1-git-send-email-mst@redhat.com>
	<1527086545-68024-8-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 May 2018 12:06:17 +0100
Message-ID: <CAFEAcA9JwWR29YSBKGS1fmmOE=wrSQY+OeJxQc4kmAEHRXUzWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 07/28] x86/cpu: use
 standard-headers/asm-x86.kvm_para.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, kvm-devel <kvm@vger.kernel.org>

On 23 May 2018 at 15:43, Michael S. Tsirkin <mst@redhat.com> wrote:
> Switch to the header we imported from Linux,
> this allows us to drop a hack in kvm_i386.h.
> More code will be dropped in the next patch.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -688,8 +688,6 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
>  #define CPUID_7_0_EDX_SPEC_CTRL     (1U << 26) /* Speculation Control */
>  #define CPUID_7_0_EDX_SPEC_CTRL_SSBD  (1U << 31) /* Speculative Store Bypass Disable */
>
> -#define KVM_HINTS_DEDICATED (1U << 0)
> -
>  #define CPUID_8000_0008_EBX_IBPB    (1U << 12) /* Indirect Branch Prediction Barrier */
>
>  #define CPUID_XSAVE_XSAVEOPT   (1U << 0)

Hi -- this seems like it will break compilation when we next
update our copy of the Linux kernel headers, because (as of
4.17-rc6, at least), asm-x86/kvm_para.h doesn't define
KVM_HINTS_DEDICATED. Here's the diff I get as part of
my attempt to run update-linux-headers:

--- a/include/standard-headers/asm-x86/kvm_para.h
+++ b/include/standard-headers/asm-x86/kvm_para.h
@@ -29,7 +29,7 @@
 #define KVM_FEATURE_PV_TLB_FLUSH       9
 #define KVM_FEATURE_ASYNC_PF_VMEXIT    10

-#define KVM_HINTS_DEDICATED      0
+#define KVM_HINTS_REALTIME      0

 /* The last 8 bits are used to indicate how to interpret the flags field
  * in pvclock structure. If no bits are set, all flags are ignored.

I'm not sure what's going on here -- commit 633711e8287 in
the kernel just renames the constant, but doesn't that
break userspace API ?

thanks
-- PMM
