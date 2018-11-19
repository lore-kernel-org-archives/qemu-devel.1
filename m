Received: from eggs.gnu.org ([2001:4830:134:3::10]:35852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gOlV7-0003Ag-27
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:30:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gOlV2-0005ll-IR
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:30:13 -0500
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:44918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gOlV2-0005km-46
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:30:08 -0500
Date: Mon, 19 Nov 2018 16:29:52 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <20181119152952.GA2405@sx9>
References: <20181118203312.5376-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <20181118203312.5376-1-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] docker: Add
 gentoo-mipsr5900el-cross image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Mike Frysinger <vapier@gentoo.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Many thanks, Philippe!

> The first patch adds a cross toolchain for the R5900 MIPS.
> It is working correctly but the patches provided by Fredrik in [1] don't
> have proper S-o-b, thus it is tagged RFC.
> Fredrik: any update on the status of those patches upstream?

With GCC 8.2.0 and a current Gentoo this is even simpler. You should
only need commit d728eb9085d8 ("MIPS: Default to --with-llsc for the
R5900 Linux target as well"):

https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=d728eb9085d8

For the o32 ABI with Glibc, only commit 8e3c00db16fc ("MIPS: Use `.set
mips2' to emulate LL/SC for the R5900 too") is needed:

https://sourceware.org/git/?p=glibc.git;a=commit;h=8e3c00db16fc

Eventually, with a future GCC/Glibc release, no patches will be needed.
[ I recommend removing the changelog part of the commits above, since
they might conflict with other GCC/Glibc versions; I've attached them
to this email for easy reference. ]

> I setup this image to try Fredrik's TCG tests in [2].

Nice! Would you like to test the n32 ABI in addition to the o32 ABI? It's
very easy to set that up as well.

> I don't think there is
> interest in running cross-compiled QEMU on a PS2... But we never know ;)

I wouldn't rule that out. ;)

> The failure I have is pkg-config using an incorrect path. I suppose I
> am not using the CROSSDEV_OVERLAY path correctly.
> Help from Gentoo developers would be appreciated!

Hmm... Did you follow the guide on how to configure the overlay?

Fredrik

--sdtB3X0nJg68CQEu
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="gcc.git-d728eb9085d8.patch"

>From d728eb9085d80b6c5ce1bc8b6f99859fe0f0aaa5 Mon Sep 17 00:00:00 2001
From: macro <macro@138bc75d-0d04-0410-961f-82ee72b054a4>
Date: Mon, 12 Nov 2018 23:16:40 +0000
Subject: [PATCH] MIPS: Default to --with-llsc for the R5900 Linux target as
 well

The Linux kernel requires and emulates LL and SC for the R5900 too.  The
special --without-llsc default for the R5900 is therefore not applicable
in that case.

Reviewed-by: Maciej W. Rozycki <macro@linux-mips.org>

2018-11-12  Fredrik Noring  <noring@nocrew.org>

	gcc/
	* config.gcc: Update with-llsc defaults for MIPS r5900.


git-svn-id: svn+ssh://gcc.gnu.org/svn/gcc/trunk@266038 138bc75d-0d04-0410-961f-82ee72b054a4

diff --git a/gcc/config.gcc b/gcc/config.gcc
index e2b9946..8525cb5 100644
--- a/gcc/config.gcc
+++ b/gcc/config.gcc
@@ -3795,14 +3795,14 @@ fi
 # Infer a default setting for --with-llsc.
 if test x$with_llsc = x; then
   case ${target} in
-    mips64r5900-*-* | mips64r5900el-*-* | mipsr5900-*-* | mipsr5900el-*-*)
-      # The R5900 doesn't support LL(D) and SC(D).
-      with_llsc=no
-      ;;
     mips*-*-linux*)
       # The kernel emulates LL and SC where necessary.
       with_llsc=yes
       ;;
+    mips64r5900-*-* | mips64r5900el-*-* | mipsr5900-*-* | mipsr5900el-*-*)
+      # The R5900 doesn't support LL(D) and SC(D).
+      with_llsc=no
+      ;;
   esac
 fi
 
-- 
2.9.3


--sdtB3X0nJg68CQEu
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="glibc.git-8e3c00db16fc.patch"

>From 8e3c00db16fcedea0ea47d93c2acb6d7d5ba9164 Mon Sep 17 00:00:00 2001
From: Fredrik Noring <noring@nocrew.org>
Date: Thu, 1 Nov 2018 14:36:48 +0000
Subject: [PATCH] MIPS: Use `.set mips2' to emulate LL/SC for the R5900 too

GAS treats the R5900 as MIPS III, with some modifications.  The MIPS III
designation means that the GNU C Library will try to assemble the LL and
SC instructions, even though they are not implemented in the R5900.  GAS
will therefore produce the following errors:

Error: opcode not supported on this processor: r5900 (mips3) `ll $2,0($4)'
Error: opcode not supported on this processor: r5900 (mips3) `sc $6,0($4)'

The MIPS II ISA override as used here enables the kernel to trap and
emulate the LL and SC instructions, as required.

This change has been tested by compiling the GNU C Library 2.27 with a
GCC 8.2.0 cross-compiler for mipsr5900el-unknown-linux-gnu under Gentoo.

	* sysdeps/mips/sys/tas.h (_test_and_set): Handle the R5900 CPU
	with the ISA override.

diff --git a/sysdeps/mips/sys/tas.h b/sysdeps/mips/sys/tas.h
index d5ed013..22cee94 100644
--- a/sysdeps/mips/sys/tas.h
+++ b/sysdeps/mips/sys/tas.h
@@ -38,10 +38,11 @@ __NTH (_test_and_set (int *__p, int __v))
 {
   int __r, __t;
 
+  /* The R5900 reports itself as MIPS III but it does not have LL/SC.  */
   __asm__ __volatile__
     ("/* Inline test and set */\n"
      ".set	push\n\t"
-#if _MIPS_SIM == _ABIO32 && __mips < 2
+#if _MIPS_SIM == _ABIO32 && (__mips < 2 || defined (_MIPS_ARCH_R5900))
      ".set	mips2\n\t"
 #endif
      "sync\n\t"
-- 
2.9.3


--sdtB3X0nJg68CQEu--
