Received: from eggs.gnu.org ([2001:4830:134:3::10]:40191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1fHnlT-0002kt-Vk
	for qemu-devel@nongnu.org; Sun, 13 May 2018 05:58:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1fHnlT-00076v-6c
	for qemu-devel@nongnu.org; Sun, 13 May 2018 05:58:04 -0400
References: <20180513090613.27960-1-sw@weilnetz.de>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <cc3f26a7-a8b7-35a8-9ffa-c5940c9c1927@weilnetz.de>
Date: Sun, 13 May 2018 11:57:51 +0200
MIME-Version: 1.0
In-Reply-To: <20180513090613.27960-1-sw@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] disas/libvixl: Fix VIXL_FALLTHROUGH macro
 for QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developer <qemu-devel@nongnu.org>
Cc: qemu-arm@nongnu.org

Am 13.05.2018 um 11:06 schrieb Stefan Weil:
> It now prevents compiler warnings (enabled with -Wimplicit-fallthrough=
> or -Wextra) as intended.
> 
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
> 
> I suggest to add and use a similar macro QEMU_FALLTHROUGH()
> for the rest of the code and can provide a patch if that's
> fine for everyone.
> 
> Regards
> Stefan
> 
>  disas/libvixl/vixl/globals.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/disas/libvixl/vixl/globals.h b/disas/libvixl/vixl/globals.h
> index 61dc9f7f7e..33c4231d91 100644
> --- a/disas/libvixl/vixl/globals.h
> +++ b/disas/libvixl/vixl/globals.h
> @@ -112,6 +112,8 @@ inline void USE(T1, T2, T3, T4) {}
>  // C++11(201103L).
>  #if __has_warning("-Wimplicit-fallthrough") && __cplusplus >= 201103L
>    #define VIXL_FALLTHROUGH() [[clang::fallthrough]] //NOLINT
> +#elif defined(__GNUC__)
> +  #define VIXL_FALLTHROUGH() __attribute__((fallthrough))
>  #else
>    #define VIXL_FALLTHROUGH() do {} while (0)
>  #endif


Even with the above patch, disas/libvixl raises a compiler warning for a
fall through case. The patch below fixes that warning, but I am not sure
whether a fall through is correct there.

Stefan


diff --git a/disas/libvixl/vixl/a64/disasm-a64.cc
b/disas/libvixl/vixl/a64/disasm-a64.cc
index 7a58a5c087..5481d94209 100644
--- a/disas/libvixl/vixl/a64/disasm-a64.cc
+++ b/disas/libvixl/vixl/a64/disasm-a64.cc
@@ -2986,6 +2986,7 @@ int Disassembler::SubstituteImmediateField(const
Instruction* instr,
           return 3;
         }
       }
+      VIXL_FALLTHROUGH(); // ???
     }
     case 'C': {  // ICondB - Immediate Conditional Branch.
       int64_t offset = instr->ImmCondBranch() << 2;
