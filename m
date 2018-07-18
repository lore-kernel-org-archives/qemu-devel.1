Received: from eggs.gnu.org ([2001:4830:134:3::10]:52056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ffoX2-00008F-Ep
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:38:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ffoWw-0006g0-KV
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:38:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46376 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ffoWw-0006fo-Fx
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:38:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 12F21400E9BA
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 15:38:18 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180620071040.28729-1-peterx@redhat.com>
Date: Wed, 18 Jul 2018 17:38:11 +0200
In-Reply-To: <20180620071040.28729-1-peterx@redhat.com> (Peter Xu's message of
	"Wed, 20 Jun 2018 15:10:40 +0800")
Message-ID: <87y3e8lfks.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4] monitor: let cur_mon be per-thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> After the Out-Of-Band work, the monitor iothread may be accessing the
> cur_mon as well (via monitor_qmp_dispatch_one()).  Let's convert the
> cur_mon variable to be a per-thread variable to make sure there won't be
> a race between threads when accessing the variable.

Hmm... why hasn't the OOB work created such a race already?

A monitor reads, parses, dispatches and executes commands, formats and
sends replies.

Before OOB, all of that ran in the main thread.  Any access of cur_mon
should therefore be from the main thread.  No races.

OOB moves read, parse, format and send to an I/O thread.  Dispatch and
execute remain in the main thread.  *Except* for commands executed OOB,
dispatch and execute move to the I/O thread, too.

Why is this not racy?  I guess it relies on careful non-use of cur_mon
in any part that may now execute in the I/O thread.  Scary...

Should this go into 3.0 to reduce the risk of bugs?

> Note that thread variables are not initialized to a valid value when new
> thread is created.  However for our case we don't need to set it up,
> since the cur_mon variable is only used in such a pattern:
>
>   old_mon =3D cur_mon;
>   cur_mon =3D xxx;
>   (do something, read cur_mon if necessary in the stack)
>   cur_mon =3D old_mon;
>
> It plays a role as stack variable, so no need to be initialized at all.
> We only need to make sure the variable won't be changed unexpectedly by
> other threads.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> [peterx: touch up commit message a bit]
> Signed-off-by: Peter Xu <peterx@redhat.com>
