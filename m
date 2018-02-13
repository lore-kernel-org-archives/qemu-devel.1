Received: from eggs.gnu.org ([2001:4830:134:3::10]:42588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1elcDA-00080i-6w
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:09:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1elcD6-0006yu-7d
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:09:36 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34030 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1elcD6-0006yL-2K
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:09:32 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 124ED4022909
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 15:09:20 +0000 (UTC)
Date: Tue, 13 Feb 2018 15:09:12 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180213150911.GG2378@work-vm>
References: <1518531279-11966-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518531279-11966-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] io/channel-command: Delay the killing of
 the child after closing the pipe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Cornelia Huck <cohuck@redhat.com>

* Thomas Huth (thuth@redhat.com) wrote:
> We are currently facing some migration failure on s390x when running
> certain avocado tests, e.g. when running the test
> type_specific.io-github-autotest-qemu.migrate.with_reboot.exec.gzip_exec.
> This test is using 'migrate -d "exec:nc localhost 5200"' for the migration.
> The problem is detected at the receiving side, where the migration stream
> apparently ends too early. However, the cause for the problem is the
> sending side: After writing the migration stream into the pipe to netcat,
> the source QEMU calls qio_channel_command_close() which closes the pipe
> and immediately (!) kills the child process afterwards. So if the
> sending netcat did not read the final bytes from the pipe yet, or
> if it did not manage to send out all its buffers yet, it is killed
> before the whole migration stream is passed to the destination side.

Thanks for tracking that down!

> To ease the situation at least a little bit, we should give the child
> process at least some few more time slices before we kill it with
> SIGTERM and then with SIGKILL. With this change, the avocado test now
> succeeds here in 10 out of 10 runs.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  io/channel-command.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/io/channel-command.c b/io/channel-command.c
> index 319c5ed..f64db3e 100644
> --- a/io/channel-command.c
> +++ b/io/channel-command.c
> @@ -177,11 +177,11 @@ static int qio_channel_command_abort(QIOChannelCommand *ioc,
>              return -1;
>          }
>      } else if (ret == 0) {
> -        if (step == 0) {
> +        if (step == 4) {
>              kill(ioc->pid, SIGTERM);
> -        } else if (step == 1) {
> +        } else if (step == 8) {
>              kill(ioc->pid, SIGKILL);
> -        } else {
> +        } else if (step >= 9) {

Hmm.  This seems pretty arbitrary; if I understand correctly you're
saying it'll get a SIGTERM after 4 (arbitrary) * 10ms (arbitrary).

Who is to say that's enough for a scp or gzip or the like?

Dave

>              error_setg(errp,
>                         "Process %llu refused to die",
>                         (unsigned long long)ioc->pid);
> -- 
> 1.8.3.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
