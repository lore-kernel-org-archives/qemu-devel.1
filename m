Received: from eggs.gnu.org ([209.51.188.92]:58995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gk7mv-0000o9-VE
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:32:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gk7b2-0003Tt-6e
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:20:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46244)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gk7b1-0003Qz-HX
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:20:35 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190117073649.5399.97670.stgit@pasha-VirtualBox>
	<20190117073753.5399.4488.stgit@pasha-VirtualBox>
Date: Thu, 17 Jan 2019 14:20:30 +0100
In-Reply-To: <20190117073753.5399.4488.stgit@pasha-VirtualBox> (Pavel
	Dovgalyuk's message of "Thu, 17 Jan 2019 10:37:53 +0300")
Message-ID: <87y37j2zfl.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v10 11/24] replay: introduce info hmp/qmp
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

> This patch introduces 'info replay' monitor command and
> corresponding qmp request.
> These commands request the current record/replay mode, replay log file
> name, and the instruction count (number of recorded/replayed
> instructions).  The instruction count can be used with the
> replay_seek/replay_break commands added in the next two patches.
>
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
[...]
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 6d45c29..d70e584 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -28,7 +28,8 @@
>  #
>  # @icount: Current instruction count. Appears when execution record/replay
>  #          is enabled. Used for "time-traveling" to match the moment
> -#          in the recorded execution with the snapshots. (since 4.0)
> +#          in the recorded execution with the snapshots. This counter may
> +#          be obtained through @query-replay command (since 4.0)
>  #
>  # Since: 1.3
>  #
> diff --git a/qapi/replay.json b/qapi/replay.json
> index 9e13551..ef2fb4b 100644
> --- a/qapi/replay.json
> +++ b/qapi/replay.json
> @@ -24,3 +24,42 @@
>  ##
>  { 'enum': 'ReplayMode',
>    'data': [ 'none', 'record', 'play' ] }
> +
> +##
> +# @ReplayInfo:
> +#
> +# Record/replay information.
> +#
> +# @mode: current mode.
> +#
> +# @filename: name of the record/replay log file.
> +#            It is present only in record or replay modes, when the log
> +#            is recorded or replayed.
> +#
> +# @icount: current number of executed instructions.
> +#
> +# Since: 4.0
> +#
> +##
> +{ 'struct': 'ReplayInfo',
> +  'data': { 'mode': 'ReplayMode', '*filename': 'str', 'icount': 'int' } }
> +
> +##
> +# @query-replay:
> +#
> +# Retrieves the record/replay information.

Imperative mood: Retrieve the record/replay information.

> +# It includes current instruction count which may be used for replay-break and
> +# replay-seek commands.

Please wrap comment lines around column 70.

> +#
> +# Returns: record/replay information.
> +#
> +# Since: 4.0
> +#
> +# Example:
> +#
> +# -> { "execute": "query-replay" }
> +# <- { "return": { "mode": "play", "filename": "log.rr", "icount": 220414 } }
> +#
> +##
> +{ 'command': 'query-replay',
> +  'returns': 'ReplayInfo' }

Preferably with these minor touch-ups, QAPI schema part
Acked-by: Markus Armbruster <armbru@redhat.com>

[...]
