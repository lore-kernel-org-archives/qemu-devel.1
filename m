Received: from eggs.gnu.org ([2001:4830:134:3::10]:37141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fL4iJ-0000xi-Ps
	for qemu-devel@nongnu.org; Tue, 22 May 2018 06:40:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fL4iH-0004pN-9L
	for qemu-devel@nongnu.org; Tue, 22 May 2018 06:40:19 -0400
Date: Tue, 22 May 2018 12:40:08 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180522104008.GA6233@localhost.localdomain>
References: <20180518132114.4070-1-kwolf@redhat.com>
	<20180518132114.4070-37-kwolf@redhat.com>
	<998828bf-31ce-1778-6139-2a47e2b11db4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <998828bf-31ce-1778-6139-2a47e2b11db4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 36/40] job: Add lifecycle QMP commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, jsnow@redhat.com, jcody@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

Am 18.05.2018 um 20:12 hat Eric Blake geschrieben:
> On 05/18/2018 08:21 AM, Kevin Wolf wrote:
> > This adds QMP commands that control the transition between states of the
> > job lifecycle.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   qapi/job.json |  99 +++++++++++++++++++++++++++++++++++++++++++
> >   job-qmp.c     | 134 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >   MAINTAINERS   |   1 +
> >   Makefile.objs |   1 +
> >   trace-events  |   9 ++++
> >   5 files changed, 244 insertions(+)
> >   create mode 100644 job-qmp.c
> > 
> > +##
> > +# @job-dismiss:
> > +#
> > +# Deletes a job that is in the CONCLUDED state. This command only needs to be
> > +# run explicitly for jobs that don't have automatic dismiss enabled.
> 
> Did we decide whether it is valid to expect a job with automatic dismiss
> enabled (old-style block jobs) to use the new job control commands?

"job control commands" is a pretty broad term, so I'd say yes, it's
expected that you can use job-* commands on any job. For example,
job-pause/resume make perfect sense on a job with auto-dismiss=true.

> Or would it be reasonable to require that 'job-dismiss' is an error on
> jobs with auto-dismiss enabled

This, too, but only because it implicitly follows from the condition
specified above: You'll never catch a job in the CONCLUDED state when
you have auto-dismiss=true because it will immediately move on to NULL.

> (as in, if you're going to use new style jobs, you are guaranteed to
> also have auto-dismiss false, because we don't expose a way to change
> that flag in new-style jobs; and if you use old style jobs, all
> management of the job should be done through the old interfaces).

I'm not completely convinced that auto-dismiss=false is the only
"correct" setting. That might be the case for libvirt, but possibly not
for simple ad-hoc scripts with lower requirements.

We don't have any new jobs yet, so whether we expose the auto-* flags
there is a decision yet to be made.

Kevin
