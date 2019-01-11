Received: from eggs.gnu.org ([209.51.188.92]:55728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ghsgW-0004BR-Ar
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 04:01:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ghseY-000149-5i
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 03:58:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ghseX-00013n-U8
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 03:58:58 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <154703587757.13472.3898702635363120794.stgit@pasha-VirtualBox>
	<154703595509.13472.7357387659078524086.stgit@pasha-VirtualBox>
Date: Fri, 11 Jan 2019 09:58:50 +0100
In-Reply-To: <154703595509.13472.7357387659078524086.stgit@pasha-VirtualBox>
	(Pavel Dovgalyuk's message of "Wed, 09 Jan 2019 15:12:35 +0300")
Message-ID: <87wonb7eph.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v9 13/21] replay: implement replay-seek
 command to proceed to the desired step
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, ciro.santilli@gmail.com, jasowang@redhat.com, quintela@redhat.com, mreitz@redhat.com, alex.bennee@linaro.org, maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com, dovgaluk@ispras.ru, artem.k.pisarenko@gmail.com, dgilbert@redhat.com, rth@twiddle.net

Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru> writes:

> This patch adds hmp/qmp commands replay_seek/replay-seek that proceed
> the execution to the specified step.
> The command automatically loads nearest snapshot and replay the execution
> to find the desired step.

"step" again.

>
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>
> --
>
> v2:
>  - renamed replay_seek qmp command into replay-seek
>    (suggested by Eric Blake)
> v7:
>  - small fixes related to Markus Armbruster's review
> v9:
>  - changed 'step' parameter name to 'icount'
>  - moved json stuff to replay.json and updated the description
>    (suggested by Markus Armbruster)
> ---
>  hmp-commands.hx           |   19 +++++++++
>  hmp.h                     |    1 
>  qapi/replay.json          |   20 ++++++++++
>  replay/replay-debugging.c |   91 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 131 insertions(+)
>
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 6d04c02..2839acc 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1924,6 +1924,25 @@ The command is ignored when there are no replay breakpoints.
>  ETEXI
>  
>      {
> +        .name       = "replay_seek",
> +        .args_type  = "icount:i",
> +        .params     = "icount",
> +        .help       = "rewinds replay to the step specified by icount",

We use imperative mood in .help: "rewind".

"Rewind" suggests going backward.  The command can do that.  But it can
also go forward.  What about:

"replay execution to the specified intruction count"

> +        .cmd        = hmp_replay_seek,
> +    },
> +
> +STEXI
> +@item replay_seek @var{icount}
> +@findex replay_seek
> +Automatically proceeds to the step specified by @var{icount}, when
> +replaying the execution. The command automatically loads nearest
> +snapshot and replay the execution to find the desired step.
> +When there is no preceding snapshot or the execution is not replayed,
> +then the command is ignored.

Uh, why isn't that an error?

> +icount for the reference may be observed with 'info replay' command.

This still uses both "step" and "instruction count".

I'm happy to help rephrasing, but first we need to nail down the failure
modes.

> +ETEXI
> +
> +    {
>          .name       = "info",
>          .args_type  = "item:s?",
>          .params     = "[subcommand]",
> diff --git a/hmp.h b/hmp.h
> index c9b9b4f..d6e1d7e 100644
> --- a/hmp.h
> +++ b/hmp.h
> @@ -151,5 +151,6 @@ void hmp_info_sev(Monitor *mon, const QDict *qdict);
>  void hmp_info_replay(Monitor *mon, const QDict *qdict);
>  void hmp_replay_break(Monitor *mon, const QDict *qdict);
>  void hmp_replay_delete_break(Monitor *mon, const QDict *qdict);
> +void hmp_replay_seek(Monitor *mon, const QDict *qdict);
>  
>  #endif
> diff --git a/qapi/replay.json b/qapi/replay.json
> index a63219c..7390f88 100644
> --- a/qapi/replay.json
> +++ b/qapi/replay.json
> @@ -99,3 +99,23 @@
>  #
>  ##
>  { 'command': 'replay-delete-break' }
> +
> +##
> +# @replay-seek:
> +#
> +# Automatically proceeds to the step specified by @icount when replaying
> +# the execution. The command automatically loads nearest
> +# snapshot and replay the execution to find the desired step.
> +# When there is no preceding snapshot or the execution is not replayed,
> +# then the command is ignored.
> +# icount for the reference may be obtained with @query-replay command.

My comments on hmp-commands.hx apply.

> +#
> +# @icount: destination execution step

s/execution step/instruction count/

Maybe s/destination/target/

> +#
> +# Since: 4.0
> +#
> +# Example:
> +#
> +# -> { "execute": "replay-seek", "data": { "icount": 220414 } }
> +##
> +{ 'command': 'replay-seek', 'data': { 'icount': 'int' } }
[...]
