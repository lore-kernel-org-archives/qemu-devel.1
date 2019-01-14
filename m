Received: from eggs.gnu.org ([209.51.188.92]:35704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gj3kk-0006ih-8D
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:02:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gj3kf-0005dz-CH
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:02:14 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:52605)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gj3kf-0005dQ-2g
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:02:09 -0500
Date: Mon, 14 Jan 2019 10:02:06 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20190114150206.GA11818@flamenco>
References: <87lg3rui28.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lg3rui28.fsf@linaro.org>
Subject: Re: [Qemu-devel] Remaining CI failures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>

On Fri, Jan 11, 2019 at 19:10:07 +0000, Alex Bennée wrote:
> So trying to narrow down the remaining failures in the CI system. There
> is one with a patch in flight (use g_usleep instead of sleep) but there
> remains two failure modes, both erratic.
> 
> tests/qht-par:
> 
> I can trigger this on my dev machine with a gprof enabled build:
> 
>   # QEMU configure log Fri Jan 11 14:10:45 GMT 2019
>   # Configured with: './configure' '--disable-tools' '--disable-docs' '--enable-gprof' '--enable-gcov'
> 
> I only seem to be able to trigger it when running via the wrapper in the
> make system:
> 
>   retry.py -n 30 --invert make check-tests/test-qht-par
> 
> Eventually this crashes with:
> 
>   ERROR:tests/test-qht-par.c:20:test_qht: assertion failed (rc == 0): (35584 == 0)
> 
> Leaving a core dump for the child:

I can't replicate this on my machine :-(

I suspect this is probably related to the fact that gprof
is not even meant to support multi-threaded programs (like qht-bench).

Given that we've fixed the sleep issue (thanks!) and that there is no use
in running test-qht-par under gprof, I propose to permanently skip
it under gprof, e.g.:

--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -88,7 +88,8 @@ check-unit-y += tests/test-rcu-simpleq$(EXESUF)
 check-unit-y += tests/test-rcu-tailq$(EXESUF)
 check-unit-y += tests/test-qdist$(EXESUF)
 check-unit-y += tests/test-qht$(EXESUF)
-# FIXME: {test-qht-par + gprof} often break on Travis CI
+# test-qht-par invokes qht-bench, which is multi-threaded.
+# gprof doesn't support multi-threaded programs, so skip this test under gprof.
 check-unit-$(call lnot,$(CONFIG_GPROF)) += tests/test-qht-par$(EXESUF)
 check-unit-y += tests/test-bitops$(EXESUF)
 check-unit-y += tests/test-bitcnt$(EXESUF)

If you agree, I can submit a proper patch with the above.

Thanks,

		Emilio
