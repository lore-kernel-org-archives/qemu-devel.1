Received: from eggs.gnu.org ([2001:4830:134:3::10]:56719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ffOms-00012a-8x
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:09:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ffOmr-00021c-1I
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:09:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37842 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ffOmq-000212-Qm
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:09:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E6AF0401EF05
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 12:08:59 +0000 (UTC)
Date: Tue, 17 Jul 2018 20:08:55 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180717120855.GG20520@xz-mi>
References: <20180704084507.14560-1-peterx@redhat.com>
	<87o9f7jdzv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o9f7jdzv.fsf@dusky.pond.sub.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/9] monitor: enable OOB by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Mon, Jul 16, 2018 at 07:18:28PM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
>=20
> > Based-on: <20180703085358.13941-1-armbru@redhat.com>
>=20
> Now in master.
>=20
> > This work is based on Markus's latest out-of-band fixes:
> >   "[PATCH v2 00/32] ] qmp: Fixes and cleanups around OOB commands"
> >
> > Major stuff: some cleanups that were previously suggested by Markus o=
r
> > Eric.  Meanwhile fix up the flow control issue.  Since my proposal
> > here is to drop COMMAND_DROPPED event, then we don't need to introduc=
e
> > per-monitor event emission API any more.  Though Markus told me that
> > he might use that code somewhere else, so I'll post that per-monitor
> > event code out separately as RFC later.
> >
> > Patch 1-3: cleanups.
>=20
> I expect these to be ready in the next version.
>=20
> Since it's just cleanup, there's no need to rush these into 3.0 unless
> they enable something we want in 3.0.
>=20
> > Patch 4-7: solve the flow control issue reported by Markus that
> > response queue might overflow even if we have limitation on the
> > request queue.  Firstly we drop the COMMAND_DROP event since that
> > won't work for response queue (since queuing an event will need to
> > append to the response queue itself), then we use monitor suspend and
> > resume to control the flow.  Last, we apply that to response queue
> > too.
>=20
> These need work.  We need to agree on how exactly flow control should
> work.  Moreover, we need to reconcile your work with Marc-Andr=C3=A9's
> "[PATCH 00/12] RFC: monitor: various code simplification and fixes"
> (which I haven't fully reviewed yet).

Sure.

>=20
> > Patch 8-9: the original patches to enable out-of-band by default.
>=20
> I figure these patches are good; we just need to decide whether we're
> ready to enable OOB.  Let's review the known issues.
>=20
> * We might want to make "id" mandatory with exec-oob
>=20
>   Best to do that right in the first release that fully supports OOB.

Yeah, I'd say I would prefer it that way, but after all we're having
that optional now in master, so it's fine for me in either way.

>=20
> * OOB offered but rejected by client is not obviously the same as
>   OOB not offered
>=20
>   I still need to digest and reply to your
>   Message-ID: <20180629090115.GH2455@xz-mi>

As a summary of the reply - I think the only difference is where we
run the chardev IOs for the monitor:

- When OOB not offered: we run chardev IOs in main thread

- When OOB offered but client rejected: we run chardev IOs in iothread

The rest of the things should be all the same.

>=20
> * COMMAND_DROPPED is broken by design, and
> * Flow control limits only request queue; response buffer can still
>   grow without bounds
>=20
>   You proposed to drop COMMAND_DROPPED, and do flow control by corking
>   input, see above.
>=20
>   Getting rid of broken COMMAND_DROPPED is a blocker.  Fully functional
>   flow control isn't, since the QMP client is trusted.
>=20
> * We lack test coverage for flow control
> * test-qmp-cmds neglects to cover the OOB additions to qmp-dispatch.c
>=20
>   I'm inclined to treating lack of test coverage as a blocker.

I will look at this one before repost after 3.0.

>=20
> * scripts/qmp/ doesn't support OOB, yet.  qmp-shell.py in particular.
>=20
>   Not a blocker.

I'll possibly temporarily put this one aside.  If not, I'll leave a
FIXME there (or I'll just do).

>=20
> Whatever we don't address right away we should at least mark FIXME in
> the source code.
>=20
> Assuming my list is complete, and my assessments correct, then we're
> quite close to the point where we can enable OOB.  But since rc1 is
> tomorrow already, I feel enabling it in 3.0 has become unrealistic.  I
> understand we need it sooner rather than later for postcopy recovery.
> However, the current state should be servicable for teaching OOB to
> libvirt: just follow the recommendation to supply "id" (libvirt always
> does anyway), pretend COMMAND_DROPPED doesn't exist, and pretend flow
> control isn't an issue.

I guess the thing is not about COMMAND_DROPPED; it's about we're going
to drop the x-oob parameter.  Now we can only use that parameter to
enable out-of-band, and after we enable it by default we possibly want
to remove that x-oob parameter.  So we'd better provide a constant way
for libvirt to enable out-of-band first (and now I'll assume the
"exec-oob" interface won't change again).  But yes I think we can do
that after 3.0.

Thanks,

--=20
Peter Xu
