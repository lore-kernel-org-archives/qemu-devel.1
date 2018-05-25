Received: from eggs.gnu.org ([2001:4830:134:3::10]:35177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fMBIM-0000aw-W4
	for qemu-devel@nongnu.org; Fri, 25 May 2018 07:54:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fMBIM-00017S-2w
	for qemu-devel@nongnu.org; Fri, 25 May 2018 07:54:07 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:41636)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fMBIL-00017J-P8
	for qemu-devel@nongnu.org; Fri, 25 May 2018 07:54:05 -0400
Received: by mail-oi0-x244.google.com with SMTP id 11-v6so4320457ois.8
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 04:54:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9JwWR29YSBKGS1fmmOE=wrSQY+OeJxQc4kmAEHRXUzWQ@mail.gmail.com>
References: <1527086545-68024-1-git-send-email-mst@redhat.com>
	<1527086545-68024-8-git-send-email-mst@redhat.com>
	<CAFEAcA9JwWR29YSBKGS1fmmOE=wrSQY+OeJxQc4kmAEHRXUzWQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 May 2018 12:53:44 +0100
Message-ID: <CAFEAcA9mAMCznsf1hao2PFziXnATrCxa8Of33NckUGXxFU6yEQ@mail.gmail.com>
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

On 25 May 2018 at 12:06, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 23 May 2018 at 15:43, Michael S. Tsirkin <mst@redhat.com> wrote:
>> Switch to the header we imported from Linux,
>> this allows us to drop a hack in kvm_i386.h.
>> More code will be dropped in the next patch.
>>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
>> --- a/target/i386/cpu.h
>> +++ b/target/i386/cpu.h
>> @@ -688,8 +688,6 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
>>  #define CPUID_7_0_EDX_SPEC_CTRL     (1U << 26) /* Speculation Control */
>>  #define CPUID_7_0_EDX_SPEC_CTRL_SSBD  (1U << 31) /* Speculative Store Bypass Disable */
>>
>> -#define KVM_HINTS_DEDICATED (1U << 0)
>> -
>>  #define CPUID_8000_0008_EBX_IBPB    (1U << 12) /* Indirect Branch Prediction Barrier */
>>
>>  #define CPUID_XSAVE_XSAVEOPT   (1U << 0)
>
> Hi -- this seems like it will break compilation when we next
> update our copy of the Linux kernel headers, because (as of
> 4.17-rc6, at least), asm-x86/kvm_para.h doesn't define
> KVM_HINTS_DEDICATED.

For the moment I'm using this workaround (I wanted to do a header
update for something else I'm working on):

--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -48,6 +48,11 @@
 #include "exec/memattrs.h"
 #include "trace.h"

+/* Work around this kernel header constant changing its name */
+#ifndef KVM_HINTS_REALTIME
+#define KVM_HINTS_REALTIME KVM_HINTS_DEDICATED
+#endif
+
 //#define DEBUG_KVM

 #ifdef DEBUG_KVM
@@ -387,7 +392,7 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s,
uint32_t function,
             ret &= ~(1U << KVM_FEATURE_PV_UNHALT);
         }
     } else if (function == KVM_CPUID_FEATURES && reg == R_EDX) {
-        ret |= 1U << KVM_HINTS_DEDICATED;
+        ret |= 1U << KVM_HINTS_REALTIME;
         found = 1;
     }

thanks
-- PMM
