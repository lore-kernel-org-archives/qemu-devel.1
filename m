Received: from eggs.gnu.org ([209.51.188.92]:54294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hE6CF-0001ih-0l
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:54:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hE6CD-0008AH-U2
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:54:54 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190410012413.31569-1-jsnow@redhat.com>
	<20190410012413.31569-3-jsnow@redhat.com>
Date: Wed, 10 Apr 2019 07:54:42 +0200
In-Reply-To: <20190410012413.31569-3-jsnow@redhat.com> (John Snow's message of
	"Tue, 9 Apr 2019 21:24:12 -0400")
Message-ID: <87sguq2yn1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC 2/3] pxtool: Add new qemu-img command
 info generation tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>

John Snow <jsnow@redhat.com> writes:

> Presently we use hxtool and a .hx format to generate a few things like
> the qemu_img subcommand dispatch table, the qemu_img help() display output,
> and a help output in qemu-img.texi.
>
> Unfortunately, this means that this information is duplicated in at least
> three places:
>
> (1) in qemu-img-cmds.hx as a human readable string
> (2) in qemu-img-cmds.hx as a texi string
> (3) in qemu-img.texi again, as a texi string
>
> We can do a little better, though: all of these sources can be generated
> from a single json file. Add a new small tool ("pxtool") that can do this.
>
> This tool can at least handle generating (1) and (2) from the same source
> without needing to reduplicate that information. Deduplicating (3) happens
> in the next patch.
>
> Notes:
>  - The json format was chosen to be very "stupid", and the command line
>    documentation is being kept one-per-line to make future diffs easier
>    to read.
>  - It's easy enough to generate the human-readable output from the texi
>    output by removing '@var{foo}' with 'foo'.
>  - The qemu-img command dispatch always calls img_cmdname, so we don't
>    need to store this information separately, either.
>  - The need for DEF() macros could be removed as well, but I left it in
>    to create a minimally disruptive patch.
> Signed-off-by: John Snow <jsnow@redhat.com>

We got just five .hx:

    qemu-img.cmds.hx            killed off by this patch
    qemu-options.hx             CLI QAPIfication should kill this off
    hw/audio/pl041.hx           misnamed, not actually food for hxtool
    hmp-commands.hx             no exit strategy
    hmp-commands-info.hx            for these two, yet

CLI QAPIfication got stuck in the back-burner, and as long as that's the
case, it's not an alternative to your patches.
