Received: from eggs.gnu.org ([209.51.188.92]:35174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gkCR2-00041c-58
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:30:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gkCQm-0000mr-TH
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:30:28 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:37419)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gkCQl-0000Hv-Na
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:30:20 -0500
Date: Thu, 17 Jan 2019 13:30:02 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20190117183002.GA21582@flamenco>
References: <20190117132703.17790-1-alex.bennee@linaro.org>
	<CAFEAcA_E2Lf9Zh2WhVDddJiD5TPPyLk1RvT7_Asn4vXnao1NjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA_E2Lf9Zh2WhVDddJiD5TPPyLk1RvT7_Asn4vXnao1NjQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 0/7] check-softfloat,
 fp-bench and clang compile fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Jan 17, 2019 at 17:37:54 +0000, Peter Maydell wrote:
> On Thu, 17 Jan 2019 at 13:27, Alex Bennée <alex.bennee@linaro.org> wrote:
> >
> > The following changes since commit 4b9f0b0f7c84eea2dfb0d5be3e0254bc91319dbc:
> >
> >   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-01-15 17:24:00 +0000)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/stsquad/qemu.git tags/pull-fpu-next-170119-1
(snip)
> 
> FreeBSD, OSX, x86-64 Linux clang builds:
(snip)
> PPC64, AArch64:
(snip)
> NetBSD:
(snip)

I have added a few commits to fix these -- diff below.
Note that one fix requires a small change in the testfloat
submodule, which I'm pulling here.

Alex, can you cherry-pick the commits in this branch?

  https://github.com/cota/qemu/tree/bennee-pull

They should go in before adding fp-test to the automated build,
of course. I left them at the top to make it easier for
you to cherry-pick.

Also, since this will require a respin, you might want to fix the
"Makfile" typo in patch 7's title.

> S390X host:
> Looks like a failure running the tests, but no diagnostics about
> what exactly went wrong or clear "test failed" indicator:
> 
> cd /home/linux1/qemu/build/all/tests/fp && ./fp-test -s -l 1
> i32_to_f16 i64_to_f16 i32_to_f32 i64_t
> o_f32 i32_to_f64 i64_to_f64 i32_to_f128 i64_to_f128 >
> int-to-float.out 2>  int-to-float.err
> /home/linux1/qemu/tests/Makefile.include:913: recipe for target
> 'check-softfloat-conv' failed
> make: *** [check-softfloat-conv] Error 1

What are the contents of "int-to-float.err"?

Thanks,

		Emilio

---
diff --git a/tests/fp/Makefile b/tests/fp/Makefile
index 5019dcdca0..5a35e7c210 100644
--- a/tests/fp/Makefile
+++ b/tests/fp/Makefile
@@ -65,8 +65,7 @@ QEMU_CFLAGS += $(TF_OPTS)
 TF_CFLAGS :=
 TF_CFLAGS += -Wno-strict-prototypes
 TF_CFLAGS += -Wno-unknown-pragmas
-TF_CFLAGS += -Wno-discarded-qualifiers
-TF_CFLAGS += -Wno-maybe-uninitialized
+TF_CFLAGS += -Wno-uninitialized
 TF_CFLAGS += -Wno-missing-prototypes
 TF_CFLAGS += -Wno-return-type
 TF_CFLAGS += -Wno-unused-function
diff --git a/tests/fp/berkeley-testfloat-3 b/tests/fp/berkeley-testfloat-3
index ca9fa2ba05..5a59dcec19 160000
--- a/tests/fp/berkeley-testfloat-3
+++ b/tests/fp/berkeley-testfloat-3
@@ -1 +1 @@
-Subproject commit ca9fa2ba05625ba929958f163b01747e07dd39cc
+Subproject commit 5a59dcec19327396a011a17fd924aed4fec416b3
diff --git a/tests/fp/fp-test.c b/tests/fp/fp-test.c
index fca576309c..2a35ef601d 100644
--- a/tests/fp/fp-test.c
+++ b/tests/fp/fp-test.c
@@ -789,7 +789,7 @@ static int set_init_flags(const char *flags)
     return 0;
 }

-static uint8_t slow_clear_flags(void)
+static uint_fast8_t slow_clear_flags(void)
 {
     uint8_t prev = slowfloat_exceptionFlags;

@@ -797,7 +797,7 @@ static uint8_t slow_clear_flags(void)
     return prev;
 }

-static uint8_t qemu_clear_flags(void)
+static uint_fast8_t qemu_clear_flags(void)
 {
     uint8_t prev = qemu_flags_to_sf(qsf.float_exception_flags);
