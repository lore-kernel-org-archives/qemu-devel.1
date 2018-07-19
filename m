Received: from eggs.gnu.org ([2001:4830:134:3::10]:47367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fg3F1-0006DC-5a
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 03:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fg3Ew-0005HQ-6V
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 03:20:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35302 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fg3Ew-0005HK-0F
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 03:20:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 10E5781A4EBF
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 07:20:41 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180620071040.28729-1-peterx@redhat.com>
	<87y3e8lfks.fsf@dusky.pond.sub.org> <20180719050145.GD4071@xz-mi>
Date: Thu, 19 Jul 2018 09:20:34 +0200
In-Reply-To: <20180719050145.GD4071@xz-mi> (Peter Xu's message of "Thu, 19 Jul
	2018 13:01:45 +0800")
Message-ID: <87va9bitdp.fsf@dusky.pond.sub.org>
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
Cc: Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> On Wed, Jul 18, 2018 at 05:38:11PM +0200, Markus Armbruster wrote:
>> Peter Xu <peterx@redhat.com> writes:
>>=20
>> > After the Out-Of-Band work, the monitor iothread may be accessing the
>> > cur_mon as well (via monitor_qmp_dispatch_one()).  Let's convert the
>> > cur_mon variable to be a per-thread variable to make sure there won't =
be
>> > a race between threads when accessing the variable.
>>=20
>> Hmm... why hasn't the OOB work created such a race already?
>>=20
>> A monitor reads, parses, dispatches and executes commands, formats and
>> sends replies.
>>=20
>> Before OOB, all of that ran in the main thread.  Any access of cur_mon
>> should therefore be from the main thread.  No races.
>>=20
>> OOB moves read, parse, format and send to an I/O thread.  Dispatch and
>> execute remain in the main thread.  *Except* for commands executed OOB,
>> dispatch and execute move to the I/O thread, too.
>>=20
>> Why is this not racy?  I guess it relies on careful non-use of cur_mon
>> in any part that may now execute in the I/O thread.  Scary...
>
> I think it's because cur_mon is not really used in out-of-band command
> executions - now we only have a few out-of-band enabled commands, and
> IIUC none of them is using cur_mon (for example, in
> qmp_migrate_recover() we don't even call error_report, and the code
> path is quite straight forward to make sure of that).  So IIUC cur_mon
> variable is still only touched by main thread for now hence we should
> be safe.  However that condition might change in the future when we
> add more out-of-band capable commands.
>
> (not to mention that I don't even know whether there are real users of
>  out-of-band if we haven't yet started to support that for libvirt...)

It's not just the actual OOB commands (there are just two), it's also
the monitor code to read, parse, format and send.

>> Should this go into 3.0 to reduce the risk of bugs?
>
> Yes I think it would be good to have that even for 3.0, since it still
> can be seen as a bug fix of existing code.

Agreed.

> Regards,
>
>> > Note that thread variables are not initialized to a valid value when n=
ew
>> > thread is created.

Confusing.  It sounds like @cur_mon's initial value would be
indeterminate, like an automatic variable's.  Not true.  Variables with
thread storage duration are initialized when the thread is created.
Since @cur_mon's declaration lacks an initializer, it'll be initialized
to a null pointer.  Your sentence is correct when you consider that null
pointer not a valid value.

>> >                     However for our case we don't need to set it up,
>> > since the cur_mon variable is only used in such a pattern:
>> >=20
>> >   old_mon =3D cur_mon;
>> >   cur_mon =3D xxx;
>> >   (do something, read cur_mon if necessary in the stack)
>> >   cur_mon =3D old_mon;
>> >=20
>> > It plays a role as stack variable, so no need to be initialized at all.
>> > We only need to make sure the variable won't be changed unexpectedly by
>> > other threads.

Do we need this paragraph?  The commit doesn't mess with @cur_mon's
initial value at all...

>> > Reviewed-by: Eric Blake <eblake@redhat.com>
>> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> > [peterx: touch up commit message a bit]
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
