Received: from eggs.gnu.org ([2001:4830:134:3::10]:50781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cyXyk-0000r1-Bs
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 02:11:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cyXyh-0004f3-4h
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 02:11:38 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36354)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cyXyg-0004eZ-Uj
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 02:11:35 -0400
Received: by mail-wm0-x244.google.com with SMTP id q125so10450409wmd.3
	for <qemu-devel@nongnu.org>; Wed, 12 Apr 2017 23:11:34 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170406210917.6896-1-eblake@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c294a578-31ee-8f53-807e-82aa355df80d@redhat.com>
Date: Thu, 13 Apr 2017 14:11:26 +0800
MIME-Version: 1.0
In-Reply-To: <20170406210917.6896-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] event: Add signal information to SHUTDOWN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>



On 07/04/2017 05:09, Eric Blake wrote:
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

I follow Markus's suggestion and would even make them uppercase.
Uncommon, but I think justified in this case.

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

Maybe call qapi_event_send_shutdown from qemu_kill_report?  It is not
obvious that ShutdownSignal is unsigned (except to you and Laszlo of
course).

I think this patch is fine for now; calling qemu_system_killed() from
os-win32.c is an orthogonal improvement.

Paolo

>          if (no_shutdown) {
>              vm_stop(RUN_STATE_SHUTDOWN);
>          } else {
> 
