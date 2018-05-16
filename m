Received: from eggs.gnu.org ([2001:4830:134:3::10]:40347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fIqPU-00080l-53
	for qemu-devel@nongnu.org; Wed, 16 May 2018 02:59:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fIqPR-0000kZ-0L
	for qemu-devel@nongnu.org; Wed, 16 May 2018 02:59:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fIqPQ-0000jo-PH
	for qemu-devel@nongnu.org; Wed, 16 May 2018 02:59:36 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180504074207.22634-1-famz@redhat.com>
	<20180504074207.22634-3-famz@redhat.com>
Date: Wed, 16 May 2018 08:59:31 +0200
In-Reply-To: <20180504074207.22634-3-famz@redhat.com> (Fam Zheng's message of
	"Fri, 4 May 2018 15:42:05 +0800")
Message-ID: <87h8n8qe5o.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 2/4] slirp: Use QAPI enum to replace
 TCPS_* macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Jan Kiszka <jan.kiszka@siemens.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>

Fam Zheng <famz@redhat.com> writes:

> This is a mechanical patch that does search-and-replace and adding
> necessary "#include" for pulling in the QAPI enum definition. The string
> lookup could use the QAPI helper, and is left for the next patch.
>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  slirp/misc.c      |  23 ++++++------
>  slirp/tcp.h       |  21 ++---------
>  slirp/tcp_input.c | 103 +++++++++++++++++++++++++++---------------------------
>  slirp/tcp_subr.c  |  25 ++++++-------
>  slirp/tcp_timer.c |   7 ++--
>  5 files changed, 84 insertions(+), 95 deletions(-)
>
> diff --git a/slirp/misc.c b/slirp/misc.c
> index 260187b6b6..ee617bc3c4 100644
> --- a/slirp/misc.c
> +++ b/slirp/misc.c
> @@ -11,6 +11,7 @@
>  #include "monitor/monitor.h"
>  #include "qemu/error-report.h"
>  #include "qemu/main-loop.h"
> +#include "qapi/qapi-commands-net.h"

Uh, why doesn't "qapi/qapi-types-net.h" suffice?

Same elsewhere.

>  
>  #ifdef DEBUG
>  int slirp_debug = DBG_CALL|DBG_MISC|DBG_ERROR;
> @@ -208,17 +209,17 @@ fork_exec(struct socket *so, const char *ex, int do_pty)
>  void slirp_connection_info(Slirp *slirp, Monitor *mon)
>  {
>      const char * const tcpstates[] = {
> -        [TCPS_CLOSED]       = "CLOSED",
> -        [TCPS_LISTEN]       = "LISTEN",
> -        [TCPS_SYN_SENT]     = "SYN_SENT",
> -        [TCPS_SYN_RECEIVED] = "SYN_RCVD",
> -        [TCPS_ESTABLISHED]  = "ESTABLISHED",
> -        [TCPS_CLOSE_WAIT]   = "CLOSE_WAIT",
> -        [TCPS_FIN_WAIT_1]   = "FIN_WAIT_1",
> -        [TCPS_CLOSING]      = "CLOSING",
> -        [TCPS_LAST_ACK]     = "LAST_ACK",
> -        [TCPS_FIN_WAIT_2]   = "FIN_WAIT_2",
> -        [TCPS_TIME_WAIT]    = "TIME_WAIT",
> +        [USERNET_TCP_STATE_CLOSED]       = "CLOSED",
> +        [USERNET_TCP_STATE_LISTEN]       = "LISTEN",
> +        [USERNET_TCP_STATE_SYN_SENT]     = "SYN_SENT",
> +        [USERNET_TCP_STATE_SYN_RECEIVED] = "SYN_RCVD",
> +        [USERNET_TCP_STATE_ESTABLISHED]  = "ESTABLISHED",
> +        [USERNET_TCP_STATE_CLOSE_WAIT]   = "CLOSE_WAIT",
> +        [USERNET_TCP_STATE_FIN_WAIT_1]   = "FIN_WAIT_1",
> +        [USERNET_TCP_STATE_CLOSING]      = "CLOSING",
> +        [USERNET_TCP_STATE_LAST_ACK]     = "LAST_ACK",
> +        [USERNET_TCP_STATE_FIN_WAIT_2]   = "FIN_WAIT_2",
> +        [USERNET_TCP_STATE_TIME_WAIT]    = "TIME_WAIT",
>      };
>      struct in_addr dst_addr;
>      struct sockaddr_in src;

This is "the string lookup" mentioned in the commit message.

> diff --git a/slirp/tcp.h b/slirp/tcp.h
> index 174d3d960c..f766e684e6 100644
> --- a/slirp/tcp.h
> +++ b/slirp/tcp.h
> @@ -133,24 +133,9 @@ struct tcphdr {
   /*
    * TCP FSM state definitions.
    * Per RFC793, September, 1981.
    */
>  
>  #define TCP_NSTATES     11

Let's replace this one by USERNET_TCP_STATE_NONE or
USERNET_TCP_STATE__MAX - 1.

>  
> -#define TCPS_CLOSED             0       /* closed */
> -#define TCPS_LISTEN             1       /* listening for connection */
> -#define TCPS_SYN_SENT           2       /* active, have sent syn */
> -#define TCPS_SYN_RECEIVED       3       /* have send and received syn */
> -/* states < TCPS_ESTABLISHED are those where connections not established */
> -#define TCPS_ESTABLISHED        4       /* established */
> -#define TCPS_CLOSE_WAIT         5       /* rcvd fin, waiting for close */
> -/* states > TCPS_CLOSE_WAIT are those where user has closed */
> -#define TCPS_FIN_WAIT_1         6       /* have closed, sent fin */
> -#define TCPS_CLOSING            7       /* closed xchd FIN; await FIN ACK */
> -#define TCPS_LAST_ACK           8       /* had fin and close; await FIN ACK */
> -/* states > TCPS_CLOSE_WAIT && < TCPS_FIN_WAIT_2 await ACK of FIN */
> -#define TCPS_FIN_WAIT_2         9       /* have closed, fin is acked */
> -#define TCPS_TIME_WAIT          10      /* in 2*msl quiet wait after close */

The replacements added in the previous patch lack these comments.
Should we copy them over?  Including the reference to RFC793 above.

> -
> -#define TCPS_HAVERCVDSYN(s)     ((s) >= TCPS_SYN_RECEIVED)
> -#define TCPS_HAVEESTABLISHED(s) ((s) >= TCPS_ESTABLISHED)
> -#define TCPS_HAVERCVDFIN(s)     ((s) >= TCPS_TIME_WAIT)
> +#define TCPS_HAVERCVDSYN(s)     ((s) >= USERNET_TCP_STATE_SYN_RECEIVED)
> +#define TCPS_HAVEESTABLISHED(s) ((s) >= USERNET_TCP_STATE_ESTABLISHED)
> +#define TCPS_HAVERCVDFIN(s)     ((s) >= USERNET_TCP_STATE_TIME_WAIT)

New in the previous patch is USERNET_TCP_STATE_NONE.  Are these macros
prepared for it?  The comments on _NONE make me doubt:

  +# - States where connections are not established: none, closed, listen, syn-sent,
  +#   syn-received

Yet TCPS_HAVEESTABLISHED(USERNET_TCP_STATE_NONE) yields true.

  +# 'none' state is used only when host forwarding

Should we document that it must not be passed to these macros?

Do we really need USERNET_TCP_STATE_NONE?  See next patch.

>  
>  /*
>   * TCP sequence numbers are 32 bit integers operated
[Remainder of the patch snipped; it looks completely mechanical]
