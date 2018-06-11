Received: from eggs.gnu.org ([2001:4830:134:3::10]:51425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSP8Q-0000di-Vz
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:53:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSP8N-0008Ft-U7
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:53:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57324 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fSP8N-0008Fa-PH
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:53:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4DB034022931
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 15:53:31 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1525843212-31922-1-git-send-email-thuth@redhat.com>
Date: Mon, 11 Jun 2018 17:53:29 +0200
In-Reply-To: <1525843212-31922-1-git-send-email-thuth@redhat.com> (Thomas
	Huth's message of "Wed, 9 May 2018 07:20:12 +0200")
Message-ID: <87bmch48w6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Add an entry for
 qemu-options* files in main directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

Thomas Huth <thuth@redhat.com> writes:

> The file "qemu-options.h", "qemu-options.hx" and "qemu-options-wrapper.h"
> in the main directory are currently without maintainer according to our
> get_maintainers.pl script. Considering that the command line options are
> a public interface and thus quite important, this is quite a bad state.
> So I'd like to suggest to add these files to the "Command line option
> argument parsing" section now.
>
> And since I'm interested in the command line interface of QEMU, add
> myself as reviewer here.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e187b1f..6aa19dc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1413,7 +1413,9 @@ F: chardev/baum.c
>  
>  Command line option argument parsing
>  M: Markus Armbruster <armbru@redhat.com>
> +R: Thomas Huth <thuth@redhat.com>
>  S: Supported
> +F: qemu-options*
>  F: include/qemu/option.h
>  F: tests/test-keyval.c
>  F: tests/test-qemu-opts.c

CLI is like QMP in that there's infrastructure, interface and
implementation.

QMP infrastructure is MAINTAINERS sections QMP and QAPI.  These are
proper subsystems, with clear boundaries.  Its maintainers get copied on
relatively few patches.

QMP infrastructure doesn't own the actual commands[1], subsystems do.
For instance, the block subsystem owns commands dealing with block
devices.

The QMP interface is specified in the QAPI schema.  Again, QMP
infrastructure doesn't own it, subsystems do.  However, to maintain some
measure of cohesion, we co-maintain the interface: MAINTAINERS section
QAPI schema covers the complete schema, and subsystems cover individual
modules of the schema[2].

I think a similar arrangement make sense for CLI.  We'll get it for free
with CLI QAPIfication, but that'll take time.

Your patch does what is possible with a monolithic interface definition:
it dumps it all on one maintainer: me.  I'm struggling to keep up with
the QAPI schema, I'm not sure I can take more.

Note that "Command line option argument parsing" is phrased carefully:
it's not "CLI", not even "CLI parsing".  qemu-options* does not fit
there.  Two solutions: widen the section so it fits better, create a new
section.  The latter would be closer to how we do QMP.

What do you think?



[1] Although QMP's qmp.c serves as a kind of dumping ground.
[2] Although misc.json serves as a kind of dumping ground.
