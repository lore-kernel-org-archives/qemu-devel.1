Received: from eggs.gnu.org ([2001:4830:134:3::10]:41697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cyG2P-0006By-V7
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 07:02:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cyG2J-00033l-No
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 07:02:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cyG2J-00032W-Fx
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 07:02:07 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170406210917.6896-1-eblake@redhat.com>
Date: Wed, 12 Apr 2017 13:02:02 +0200
In-Reply-To: <20170406210917.6896-1-eblake@redhat.com> (Eric Blake's message
	of "Thu, 6 Apr 2017 16:09:17 -0500")
Message-ID: <877f2pnb2t.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] event: Add signal information to SHUTDOWN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>

Eric Blake <eblake@redhat.com> writes:

> qemu_kill_report() is already able to tell whether a shutdown
> was triggered by guest action (no output) or by a host signal
> (a message about termination is printed via error_report); but
> this information is then lost.  Libvirt would like to be able
> to distinguish between a SHUTDOWN event triggered solely by
> guest request and one triggered by a SIGTERM on the host.
>
> Enhance the SHUTDOWN event to pass the value of shutdown_signal
> through to the monitor client, suitably remapped into a
> platform-neutral string.  Note that mingw lacks decent signal

I understand the desire to distinguish between guest-initiated and
host-initiated shutdown, but I'm not sure why libvirt (or anyone) would
care for the exact signal.  Can you explain?

>                           Note that mingw lacks decent signal
> support, and will never report a signal because it never calls
> qemu_system_killed().

Awkward.

os-posix.c arranges for SIGINT, SIGHUP and SIGTERM to be caught.  Here's
the handler:

    static void termsig_handler(int signal, siginfo_t *info, void *c)
    {
        qemu_system_killed(info->si_signo, info->si_pid);
    }

    void qemu_system_killed(int signal, pid_t pid)
    {
        shutdown_signal = signal;
        shutdown_pid = pid;
        no_shutdown = 0;

        /* Cannot call qemu_system_shutdown_request directly because
         * we are in a signal handler.
         */
        shutdown_requested = 1;
        qemu_notify_event();
    }

The variables are all int or pid_t.  Works in practice (pedants might
ask for sig_atomic_t, but I won't).

In other words, these three signals are polite requests to terminate
QEMU.

Stefan, are there equivalent requests under Windows?  I guess there
might be one at least for SIGINT, namely whatever happens when you hit
^C on the console.

Could we arrange to run qemu_system_killed() then?

If not, could we at least distinguish between guest-initiated and
host-initiated shutdown?

> See also https://bugzilla.redhat.com/1384007
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  qapi/event.json | 20 +++++++++++++++++++-
>  vl.c            | 21 ++++++++++++++++++---
>  2 files changed, 37 insertions(+), 4 deletions(-)
>
> diff --git a/qapi/event.json b/qapi/event.json
> index e80f3f4..6aad475 100644
> --- a/qapi/event.json
> +++ b/qapi/event.json
> @@ -5,11 +5,29 @@
>  ##
>
>  ##
> +# @ShutdownSignal:
> +#
> +# The list of host signal types known to cause qemu to shut down a guest.
> +#
> +# @int: SIGINT
> +# @hup: SIGHUP
> +# @term: SIGTERM
> +#
> +# Since: 2.10
> +##
> +{ 'enum': 'ShutdownSignal', 'data': [ 'int', 'hup', 'term' ] }

I'd call them sigint, sighup, sigterm, but it's a matter of taste.

> +
> +##
>  # @SHUTDOWN:
>  #
>  # Emitted when the virtual machine has shut down, indicating that qemu is
>  # about to exit.
>  #
> +# @signal: If present, the shutdown was (probably) triggered due to
> +# the receipt of the given signal in the host, rather than by a guest
> +# action (note that there is an inherent race with a guest choosing to
> +# shut down near the same time the host sends a signal). (since 2.10)
> +#

Is the "(probably)" due to just Windows, or are there other reasons for
uncertainty?

>  # Note: If the command-line option "-no-shutdown" has been specified, qemu will
>  # not exit, and a STOP event will eventually follow the SHUTDOWN event
>  #
> @@ -21,7 +39,7 @@
>  #      "timestamp": { "seconds": 1267040730, "microseconds": 682951 } }
>  #
>  ##
> -{ 'event': 'SHUTDOWN' }
> +{ 'event': 'SHUTDOWN', 'data': { '*signal': 'ShutdownSignal' } }
>
>  ##
>  # @POWERDOWN:
> diff --git a/vl.c b/vl.c
> index 0b4ed52..af29b2c 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1626,9 +1626,23 @@ static int qemu_shutdown_requested(void)
>      return atomic_xchg(&shutdown_requested, 0);
>  }
>
> -static void qemu_kill_report(void)
> +static ShutdownSignal qemu_kill_report(void)
>  {
> +    ShutdownSignal ss = SHUTDOWN_SIGNAL__MAX;
>      if (!qtest_driver() && shutdown_signal != -1) {

Outside this patch's scope: could just as well use 0 instead of -1, as 0
can't be a valid signal number (kill() uses it for "check if we could
kill").

> +        switch (shutdown_signal) {
> +        case SIGINT:
> +            ss = SHUTDOWN_SIGNAL_INT;
> +            break;
> +#ifdef SIGHUP
> +        case SIGHUP:
> +            ss = SHUTDOWN_SIGNAL_HUP;
> +            break;
> +#endif
> +        case SIGTERM:
> +            ss = SHUTDOWN_SIGNAL_TERM;
> +            break;
> +        }
>          if (shutdown_pid == 0) {
>              /* This happens for eg ^C at the terminal, so it's worth
>               * avoiding printing an odd message in that case.
> @@ -1644,6 +1658,7 @@ static void qemu_kill_report(void)
>          }
>          shutdown_signal = -1;
>      }
> +    return ss;
>  }
>
>  static int qemu_reset_requested(void)
> @@ -1852,8 +1867,8 @@ static bool main_loop_should_exit(void)
>          qemu_system_suspend();
>      }
>      if (qemu_shutdown_requested()) {
> -        qemu_kill_report();
> -        qapi_event_send_shutdown(&error_abort);
> +        ShutdownSignal ss = qemu_kill_report();
> +        qapi_event_send_shutdown(ss < SHUTDOWN_SIGNAL__MAX, ss, &error_abort);
>          if (no_shutdown) {
>              vm_stop(RUN_STATE_SHUTDOWN);
>          } else {

Why not send the event within qemu_kill_report()?
