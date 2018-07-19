Received: from eggs.gnu.org ([2001:4830:134:3::10]:34932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fg3uX-0008I7-AF
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 04:03:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fg3uA-0007lQ-6X
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 04:03:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59290 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fg3uA-0007ki-07
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 04:03:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7BAC887AAA
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 08:03:17 +0000 (UTC)
Date: Thu, 19 Jul 2018 16:03:06 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180719080306.GF4071@xz-mi>
References: <20180620071040.28729-1-peterx@redhat.com>
	<87y3e8lfks.fsf@dusky.pond.sub.org> <20180719050145.GD4071@xz-mi>
	<87va9bitdp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87va9bitdp.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Jul 19, 2018 at 09:20:34AM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
>=20
> > On Wed, Jul 18, 2018 at 05:38:11PM +0200, Markus Armbruster wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >>=20
> >> > After the Out-Of-Band work, the monitor iothread may be accessing =
the
> >> > cur_mon as well (via monitor_qmp_dispatch_one()).  Let's convert t=
he
> >> > cur_mon variable to be a per-thread variable to make sure there wo=
n't be
> >> > a race between threads when accessing the variable.
> >>=20
> >> Hmm... why hasn't the OOB work created such a race already?
> >>=20
> >> A monitor reads, parses, dispatches and executes commands, formats a=
nd
> >> sends replies.
> >>=20
> >> Before OOB, all of that ran in the main thread.  Any access of cur_m=
on
> >> should therefore be from the main thread.  No races.
> >>=20
> >> OOB moves read, parse, format and send to an I/O thread.  Dispatch a=
nd
> >> execute remain in the main thread.  *Except* for commands executed O=
OB,
> >> dispatch and execute move to the I/O thread, too.
> >>=20
> >> Why is this not racy?  I guess it relies on careful non-use of cur_m=
on
> >> in any part that may now execute in the I/O thread.  Scary...
> >
> > I think it's because cur_mon is not really used in out-of-band comman=
d
> > executions - now we only have a few out-of-band enabled commands, and
> > IIUC none of them is using cur_mon (for example, in
> > qmp_migrate_recover() we don't even call error_report, and the code
> > path is quite straight forward to make sure of that).  So IIUC cur_mo=
n
> > variable is still only touched by main thread for now hence we should
> > be safe.  However that condition might change in the future when we
> > add more out-of-band capable commands.
> >
> > (not to mention that I don't even know whether there are real users o=
f
> >  out-of-band if we haven't yet started to support that for libvirt...=
)
>=20
> It's not just the actual OOB commands (there are just two), it's also
> the monitor code to read, parse, format and send.

My understanding is that read, parse, format, send will not touch
cur_mon (it was touched before but some patches in the out-of-band
series should have removed the last users when parsing).  So IIUC only
the dispatcher would touch that now.  I didn't consider the callers
like net_init_socket() and I'm only considering the monitor code (and
those callers should be only in the main thread too after all).

>=20
> >> Should this go into 3.0 to reduce the risk of bugs?
> >
> > Yes I think it would be good to have that even for 3.0, since it stil=
l
> > can be seen as a bug fix of existing code.
>=20
> Agreed.
>=20
> > Regards,
> >
> >> > Note that thread variables are not initialized to a valid value wh=
en new
> >> > thread is created.
>=20
> Confusing.  It sounds like @cur_mon's initial value would be
> indeterminate, like an automatic variable's.  Not true.  Variables with
> thread storage duration are initialized when the thread is created.
> Since @cur_mon's declaration lacks an initializer, it'll be initialized
> to a null pointer.  Your sentence is correct when you consider that nul=
l
> pointer not a valid value.

Yes that's what I meant.  So how about this?

  Note that the per-thread @cur_mon variable is not initialized to
  point to a valid Monitor struct when a new thread is created (the
  default value will be NULL).

Please feel free to tune it up.

>=20
> >> >                     However for our case we don't need to set it u=
p,
> >> > since the cur_mon variable is only used in such a pattern:
> >> >=20
> >> >   old_mon =3D cur_mon;
> >> >   cur_mon =3D xxx;
> >> >   (do something, read cur_mon if necessary in the stack)

[1]

> >> >   cur_mon =3D old_mon;
> >> >=20
> >> > It plays a role as stack variable, so no need to be initialized at=
 all.
> >> > We only need to make sure the variable won't be changed unexpected=
ly by
> >> > other threads.
>=20
> Do we need this paragraph?  The commit doesn't mess with @cur_mon's
> initial value at all...

I was trying to explain why we don't need to initialize that variable
for each thread.  A common idea (at least that's what I have had in
mind) is that when we create a new thread we should possibly inherit
that @cur_mon variable in a copy-on-write fashion for that new thread.
But that's not really necessary for the use case like above (as long
as we don't create thread during [1], and that's what we do).

If you think the patch explains itself better without these lines,
please feel free to drop it.

>=20
> >> > Reviewed-by: Eric Blake <eblake@redhat.com>
> >> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> >> > [peterx: touch up commit message a bit]
> >> > Signed-off-by: Peter Xu <peterx@redhat.com>

Thanks,

--=20
Peter Xu
