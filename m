Received: from eggs.gnu.org ([2001:4830:134:3::10]:58339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gUaKX-0003lc-QT
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:47:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gUaKU-0004J3-ND
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:47:21 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:57479)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gUaKU-0004Fd-BZ
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:47:18 -0500
Date: Wed, 5 Dec 2018 11:47:16 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181205164716.GB8760@flamenco>
References: <20181124235553.17371-1-cota@braap.org> <871s6w2ljo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871s6w2ljo.fsf@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v6 00/13] hardfloat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>

On Wed, Dec 05, 2018 at 12:41:15 +0000, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
> 
> > v5: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02793.html
> >
> > Changes since v5:
> >
> > - Rebase on rth/tcg-next-for-4.0
> <snip>
> 
> Awesome work - the series is looking really good now and I think we are
> ready for a merge once the tree re-opens. I think there were a few
> wording changes and the #ifdef fix to apply so if you are happy to do
> that I'll slurp up v7 prepare a PR once it's ready.

Great, thanks for reviewing!

I just pushed v7. The changes are tiny (v6->v7 diff shown below)
so unless you want me to, I won't send it to the list.

  https://github.com/cota/qemu/tree/hardfloat-v7

I added your R-b's and the __FAST_MATH__ check:

$ git diff hardfloat-v6..hardfloat-v7
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 494422faab..59eac97d10 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -220,7 +220,11 @@ GEN_INPUT_FLUSH3(float64_input_flush3, float64)
  * the use of hardfloat, since hardfloat relies on the inexact flag being
  * already set.
  */
-#if defined(TARGET_PPC)
+#if defined(TARGET_PPC) || defined(__FAST_MATH__)
+# if defined(__FAST_MATH__)
+#  warning disabling hardfloat due to -ffast-math: hardfloat requires an exact \
+    IEEE implementation
+# endif
 # define QEMU_NO_HARDFLOAT 1
 # define QEMU_SOFTFLOAT_ATTR QEMU_FLATTEN
 #else

I also updated patch 7's commit message:
    [..]
    However, this approach will break on most hosts if we compile
    QEMU with flags that break IEEE compatibility. There is no way to detect
    all of these flags at compilation time, but at least we check for
    -ffast-math (which defines __FAST_MATH__) and disable hardfloat
    (plus emit a #warning) when it is set.

> Going forward I think we want to wire up the fp-test code so we can run
> it in CI via the rest of make check (or check-tcg?) but no need to hold
> up the merge for that.

Yes, I think starting with `make check' would make sense. We should
test with and without `-f x', to make sure that both soft and
hardfloat are tested. There are still some f80/f128 known errors
though, so we might want to disable the testing of those for now.

Thanks,

		Emilio
