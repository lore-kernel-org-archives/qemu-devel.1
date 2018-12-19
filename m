Received: from eggs.gnu.org ([2001:4830:134:3::10]:37986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZbZ8-0001pn-8Q
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 08:07:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZbZ1-0006BP-DA
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 08:07:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gZbZ1-00069Q-3g
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 08:07:03 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181218112056.11727.96529.stgit@pasha-VirtualBox>
	<20181218112159.11727.39970.stgit@pasha-VirtualBox>
Date: Wed, 19 Dec 2018 14:06:48 +0100
In-Reply-To: <20181218112159.11727.39970.stgit@pasha-VirtualBox> (Pavel
	Dovgalyuk's message of "Tue, 18 Dec 2018 14:21:59 +0300")
Message-ID: <87imzpis2f.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v8 11/20] replay: introduce breakpoint at
 the specified step
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

> This patch introduces replay_break, replay_delete_break
> qmp and hmp commands.
> These commands allow stopping at the specified instruction.
> It may be useful for debugging when there are some known
> events that should be investigated.
> replay_break command has one argument - number of instructions
> executed since the start of the replay.
> replay_delete_break removes previously set breakpoint.
>
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
[...]
> diff --git a/qapi/misc.json b/qapi/misc.json
> index e47aea6..0bcb547 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -3148,6 +3148,37 @@
>    'returns': 'ReplayInfo' }
>  
>  ##
> +# @replay-break:
> +#
> +# Set breakpoint on the specified step of the replay.
> +# Execution stops when the specified step is reached.
> +#
> +# @step: execution step to stop at
> +#
> +# Since: 4.0
> +#
> +# Example:
> +#
> +# -> { "execute": "replay-break", "data": { "step": 220414 } }
> +#
> +##
> +{ 'command': 'replay-break', 'data': { 'step': 'int' } }
> +
> +##
> +# @replay-delete-break:
> +#
> +# Removes replay breakpoint.
> +#
> +# Since: 4.0
> +#
> +# Example:
> +#
> +# -> { "execute": "replay-delete-break" }
> +#
> +##
> +{ 'command': 'replay-delete-break' }
> +
> +##
>  # @xen-load-devices-state:
>  #
>  # Load the state of all devices from file. The RAM and the block devices

This interface can support at most one breakpoint.  That's okay; if you
want to schedule multiple stops, you queue them further up the stack,
and use this command to set the next one before you resume execution.

If we ever decide to queue in QEMU, we'd have to add optional breakpoint
names to these functions, defaulting to some implied name.  Not exactly
elegant, but workable.

What does replay-break do when the breakpoint has been set already?

What does it do when @step is in the past?

What does replay-delete-break do when no breakpoint has been set?

The answers to these questions need to be worked into the comamnd
documentation.

As mentioned in review of PATCH 10, having the documentation point to
query-replay might make sense.

[...]
