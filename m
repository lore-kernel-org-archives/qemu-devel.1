Received: from eggs.gnu.org ([2001:4830:134:3::10]:60372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWOXT-00028p-Jj
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:36:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWOXO-0002kq-56
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:36:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gWOXN-0002kB-TU
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:36:06 -0500
Date: Mon, 10 Dec 2018 14:36:01 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181210163601.GA4669@habkost.net>
References: <20181207204107.GH7395@habkost.net>
	<20181209222738.GA9292@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181209222738.GA9292@flamenco>
Subject: Re: [Qemu-devel] Help needed: test-qht-par hangs on Travis
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org

On Sun, Dec 09, 2018 at 05:27:38PM -0500, Emilio G. Cota wrote:
> On Fri, Dec 07, 2018 at 18:41:07 -0200, Eduardo Habkost wrote:
> > I've noticed QEMU Travis builds are failing recently, and they
> > seem to happen only on the --enable-gprof jobs.  I have enabled
> > V=1 and noticed that the jobs are hanging inside test-qht-par.
> > 
> > Example here (look for "/qht/parallel/2threads-0%updates-1s"):
> > 
> > https://travis-ci.org/ehabkost/qemu-hacks/jobs/465081311
> > 
> > Does anybody have any idea why?
> 
> So if I read that output correctly, it seems that the second
> test in qht-par never completes.
> 
> Enabling gprof and gcov (as in that build) should just lower
> the throughput of the benchmark (test-qht-par invokes qht-bench),
> but the duration should be the same (1 second per test, so no need
> to wait for 10 minutes).
> 
> Can you try re-running the test, after applying the appended patch?
> (It disables the "resize" thread.)

It is running right now, here:
https://travis-ci.org/ehabkost/qemu-hacks/jobs/466074591

> 
> Also, does it reliably hang on Travis, or are these hangs
> intermittent?

It can be reproduced reliably.  qemu.git builds are failing since
Thursday:
https://travis-ci.org/qemu/qemu/builds

> 
> Thanks,
> 
> 		Emilio
> ---
> diff --git a/tests/test-qht-par.c b/tests/test-qht-par.c
> index d8a83caf5c..83ac92e430 100644
> --- a/tests/test-qht-par.c
> +++ b/tests/test-qht-par.c
> @@ -6,7 +6,7 @@
>   */
>  #include "qemu/osdep.h"
> 
> -#define TEST_QHT_STRING "tests/qht-bench 1>/dev/null 2>&1 -R -S0.1 -D10000 -N1 "
> +#define TEST_QHT_STRING "tests/qht-bench 1>/dev/null 2>&1 -R "
> 
>  static void test_qht(int n_threads, int update_rate, int duration)
>  {
> 

-- 
Eduardo
