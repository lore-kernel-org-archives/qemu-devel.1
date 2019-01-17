Received: from eggs.gnu.org ([209.51.188.92]:58242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gk7lB-0008Vn-05
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:31:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gk7kV-0007GA-5N
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:30:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gk7kU-00076e-P4
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:30:23 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190117073649.5399.97670.stgit@pasha-VirtualBox>
	<20190117073804.5399.15509.stgit@pasha-VirtualBox>
Date: Thu, 17 Jan 2019 14:30:10 +0100
In-Reply-To: <20190117073804.5399.15509.stgit@pasha-VirtualBox> (Pavel
	Dovgalyuk's message of "Thu, 17 Jan 2019 10:38:04 +0300")
Message-ID: <87k1j32yzh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v10 13/24] replay: implement replay-seek
 command
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
> the execution to the specified instruction count.
> The command automatically loads nearest snapshot and replays the execution
> to find the desired instruction count.
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
> v10:
>  - updated the descriptions
> ---
>  hmp-commands.hx           |   19 +++++++++
>  hmp.h                     |    1 
>  qapi/replay.json          |   20 ++++++++++
>  replay/replay-debugging.c |   92 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 132 insertions(+)
>
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index d529f24..57ec43c 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1924,6 +1924,25 @@ The command is ignored when there are no replay breakpoints.
>  ETEXI
>  
>      {
> +        .name       = "replay_seek",
> +        .args_type  = "icount:i",
> +        .params     = "icount",
> +        .help       = "replay execution to the specified instruction count",
> +        .cmd        = hmp_replay_seek,
> +    },
> +
> +STEXI
> +@item replay_seek @var{icount}
> +@findex replay_seek
> +Automatically proceeds to the instruction count @var{icount}, when
> +replaying the execution. The command automatically loads nearest
> +snapshot and replays the execution to find the desired instruction.
> +When there is no preceding snapshot or the execution is not replayed,
> +then the command is ignored and error message is displayed.

Sounds like roundabout way to say "then the command fails".  If that's
correct, then let's phrase it that way.

> +icount for the reference may be observed with 'info replay' command.
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
> index cb94991..0b5afce 100644
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
> +# Automatically proceeds to the instruction count @icount, when
> +# replaying the execution. The command automatically loads nearest
> +# snapshot and replays the execution to find the desired instruction.
> +# When there is no preceding snapshot or the execution is not replayed,
> +# then the command is ignored and error is returned.
> +# icount for the reference may be obtained with @query-replay command.

My comment on hmp-commands.hx applies.

> +#
> +# @icount: target instruction count
> +#
> +# Since: 4.0
> +#
> +# Example:
> +#
> +# -> { "execute": "replay-seek", "data": { "icount": 220414 } }
> +##
> +{ 'command': 'replay-seek', 'data': { 'icount': 'int' } }

[...]

QAPI schema part
Acked-by: Markus Armbruster <armbru@redhat.com>

Please consider my comment suggestions regardless.
