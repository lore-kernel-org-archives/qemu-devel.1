Received: from eggs.gnu.org ([2001:4830:134:3::10]:38669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d3JEK-0003RL-4Q
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 05:27:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d3JEF-0003qr-Cj
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 05:27:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d3JEF-0003qM-6T
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 05:27:19 -0400
Date: Wed, 26 Apr 2017 10:27:14 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170426092714.GC2098@work-vm>
References: <1493179907-22516-1-git-send-email-thuth@redhat.com>
	<20170426081816.GA2098@work-vm>
	<CAFEAcA8kDDnSuMfU7tFwMQf9sMVzpz=+dkuroWGRXGtbPkdFzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8kDDnSuMfU7tFwMQf9sMVzpz=+dkuroWGRXGtbPkdFzg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] monitor: Check whether TCG is enabled
 before running the "info jit" code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On 26 April 2017 at 09:18, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> > * Thomas Huth (thuth@redhat.com) wrote:
> >> The "info jit" command currently aborts on Mac OS X with the message
> >> "qemu_mutex_lock: Invalid argument" when running with "-M accel=qtest".
> >> We should only call into the TCG code here if TCG has really been
> >> enabled and initialized.
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >>  monitor.c | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/monitor.c b/monitor.c
> >> index be282ec..3e0979d 100644
> >> --- a/monitor.c
> >> +++ b/monitor.c
> >> @@ -1086,6 +1086,11 @@ static void hmp_info_registers(Monitor *mon, const QDict *qdict)
> >>
> >>  static void hmp_info_jit(Monitor *mon, const QDict *qdict)
> >>  {
> >> +    if (!tcg_enabled()) {
> >> +        error_report("JIT information is only available with accel=tcg");
> >> +        return;
> >> +    }
> >> +
> >>      dump_exec_info((FILE *)mon, monitor_fprintf);
> >>      dump_drift_info((FILE *)mon, monitor_fprintf);
> >>  }
> >
> > so tcg_enabled checks tcg_ctx.code_gen_buffer != NULL
> > code_gen_buffer is set by code_gen_alloc
> > code_gen_alloc does a qemu_mutex_init of tb_lock
> > and the previous problem was an uninitialised tb_lock.
> >
> > So:
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >
> >
> > Peter: Does this fix the hmp test for you?
> 
> Yes, it does.
> 
> Tested-by: Peter Maydell <peter.maydell@linaro.org>

OK, I'll cook a new version of the HMP pull later with this in it.

Dave

> -- PMM
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
