Received: from eggs.gnu.org ([209.51.188.92]:53529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1ggY7n-0003zD-Gq
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:51:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1ggY7l-0002ug-Mq
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:51:39 -0500
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:29821)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1ggY7l-0002lp-CQ
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:51:37 -0500
Date: Mon, 7 Jan 2019 17:51:26 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <20190107165126.GA31835@sx9>
References: <cover.1541093316.git.noring@nocrew.org>
	<eecae865fc8f7934cc2d51b24cba7d8ac3ec37c6.1541093316.git.noring@nocrew.org>
	<BN6PR2201MB1251DBF84B71346A8B673CA6C6B60@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<20190101182745.GA17022@sx9>
	<BN6PR2201MB1251C334FE66ADF677BAE8D2C68E0@BN6PR2201MB1251.namprd22.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN6PR2201MB1251C334FE66ADF677BAE8D2C68E0@BN6PR2201MB1251.namprd22.prod.outlook.com>
Subject: Re: [Qemu-devel] [PATCH v2 09/12] tests/tcg/mips: Test R5900
 three-operand MADDU1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

Hi Aleksandar,

> Glad to see you back!

Likewise!

> Yes, one can say this is a step towards reenabling R5900 support.

Great!

> At this moment I have a question a suggestion for you:
> 
> - Question: Do you have somewhere link to n32 R5900 toolchain, or
> similar thing that would enable me to test R5900's n32 in QEMU

Yes. The only (small) changes needed for n32 are related to Glibc,
since the R5900 does not implement DMULT etc. in hardware. The attached
patch (see below) traps these instructions, but the Glibc patch proposal
(not yet submitted) will instead emulate them, which is believed to be
faster (with actual hardware; with QEMU it would most likely instead be
significantly slower since QEMU would need to emulate this emulation).

You will also need commit d728eb9085d8 ("MIPS: Default to --with-llsc for
the R5900 Linux target as well"), made for o32 and GCC, as explained in

https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg03649.html

unless you compile GCC from HEAD that already has it.

> (I'll do the tweaks in QEMU by myself for that, but I need a way
> to compile R5900 test programs for n32)?

I just verified that the only change needed with QEMU apart from reverting
commit 823f2897bdd7 ("target/mips: Disable R5900 support") is this:

--- a/linux-user/mips64/target_elf.h
+++ b/linux-user/mips64/target_elf.h
@@ -12,6 +12,9 @@ static inline const char *cpu_get_model(uint32_t eflags)
     if ((eflags & EF_MIPS_ARCH) == EF_MIPS_ARCH_64R6) {
         return "I6400";
     }
+    if ((eflags & EF_MIPS_MACH) == EF_MIPS_MACH_5900) {
+        return "R5900";
+    }
     return "5KEf";
 }
 #endif

> - Suggestion: The next MIPS pull request is scehuled for Friday,
> Jan 18, 2018. It would be fantastic if you could prepare the
> following by Jan 14:
> 
>   * Add 32 TCGv_i64 registers that would represent higher halves
>   of R5900 general purpose registers.
>   * Add TCGv_i32 register SA (shift amount).
>   * Perhaps consider adding higher halves of registers HI an LO
>   independently on HI/LO array used by DSP.
>   * It is customary to implement R/W access while introducing
>   such registers:
>     * Implement R/W access instructions to higher halves of
>     R5900 GPRs:
>       * LQ
>       * SQ
>     * Implement R/W access instructions to SA register:
>       * MFSA
>       * MTSA
>       * MTSAH
>       * MTSAB

Sounds good except I'm not sure it can be done before 14 January!

> I think a reasonable person would consider that the number and
> size of registers of emulated CPU is a fundamental thing that
> must be done before enabling its support - hence my suggestion
> above.

Well, no package in any popular Linux distribution require these R5900
extensions, or as far as I know, try to make use of them. So with an
initial use case of running a Linux distribution in user mode, support
for them is certainly not needed at all.

Of course, support would be needed if anyone would like to start
implementing R5900 specific extensions. Also, the Linux kernel needs a
few of those instructions, so implementing them would make it possible
to run the kernel in system mode, which would be very useful too.

> If you don't have enough time resources before Jan 14, that is
> fine too, do everything at your own pace.

Thanks!

> My vision is that we continue step by step amending R5900 until
> we reach a decent and stable state of emulation and than enable
> the R5900 support for end user. (I'll provide all the details
> later on.)

OK.

Fredrik

--- a/sysdeps/mips/mips64/addmul_1.S
+++ b/sysdeps/mips/mips64/addmul_1.S
@@ -33,6 +33,9 @@
 	.option pic2
 #endif
 ENTRY (__mpn_addmul_1)
+#ifdef _MIPS_ARCH_R5900
+	.set	mips3
+#endif
 #ifdef PIC
 	SETUP_GP /* ??? unused */
 #endif
diff --git a/sysdeps/mips/mips64/mul_1.S b/sysdeps/mips/mips64/mul_1.S
index 8707257a68..19e3ae5eae 100644
--- a/sysdeps/mips/mips64/mul_1.S
+++ b/sysdeps/mips/mips64/mul_1.S
@@ -34,6 +34,9 @@
 	.option pic2
 #endif
 ENTRY (__mpn_mul_1)
+#ifdef _MIPS_ARCH_R5900
+	.set	mips3
+#endif
 #ifdef __PIC__
 	SETUP_GP /* ??? unused */
 #endif
diff --git a/sysdeps/mips/mips64/submul_1.S b/sysdeps/mips/mips64/submul_1.S
index fb9a1c2375..763c5bb687 100644
--- a/sysdeps/mips/mips64/submul_1.S
+++ b/sysdeps/mips/mips64/submul_1.S
@@ -34,6 +34,9 @@
 	.option pic2
 #endif
 ENTRY (__mpn_submul_1)
+#ifdef _MIPS_ARCH_R5900
+	.set	mips3
+#endif
 #ifdef __PIC__
 	SETUP_GP /* ??? unused */
 #endif
diff --git a/sysdeps/mips/sys/tas.h b/sysdeps/mips/sys/tas.h
index d5ed013e28..ad797bfb1d 100644
--- a/sysdeps/mips/sys/tas.h
+++ b/sysdeps/mips/sys/tas.h
@@ -38,11 +38,14 @@ __NTH (_test_and_set (int *__p, int __v))
 {
   int __r, __t;
 
+  /* The R5900 reports itself as MIPS III but it does not have LL/SC.  */
   __asm__ __volatile__
     ("/* Inline test and set */\n"
      ".set	push\n\t"
 #if _MIPS_SIM == _ABIO32 && __mips < 2
      ".set	mips2\n\t"
+#elif defined (_MIPS_ARCH_R5900)
+     ".set	mips3\n\t"
 #endif
      "sync\n\t"
      "1:\n\t"
