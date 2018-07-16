Received: from eggs.gnu.org ([2001:4830:134:3::10]:58709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ff78s-0004VF-1Q
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 13:18:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ff78o-0003DT-TT
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 13:18:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44520 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ff78o-0003DA-NY
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 13:18:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0FD654022414
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 17:18:30 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180704084507.14560-1-peterx@redhat.com>
Date: Mon, 16 Jul 2018 19:18:28 +0200
In-Reply-To: <20180704084507.14560-1-peterx@redhat.com> (Peter Xu's message of
	"Wed, 4 Jul 2018 16:44:58 +0800")
Message-ID: <87o9f7jdzv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> Based-on: <20180703085358.13941-1-armbru@redhat.com>

Now in master.

> This work is based on Markus's latest out-of-band fixes:
>   "[PATCH v2 00/32] ] qmp: Fixes and cleanups around OOB commands"
>
> Major stuff: some cleanups that were previously suggested by Markus or
> Eric.  Meanwhile fix up the flow control issue.  Since my proposal
> here is to drop COMMAND_DROPPED event, then we don't need to introduce
> per-monitor event emission API any more.  Though Markus told me that
> he might use that code somewhere else, so I'll post that per-monitor
> event code out separately as RFC later.
>
> Patch 1-3: cleanups.

I expect these to be ready in the next version.

Since it's just cleanup, there's no need to rush these into 3.0 unless
they enable something we want in 3.0.

> Patch 4-7: solve the flow control issue reported by Markus that
> response queue might overflow even if we have limitation on the
> request queue.  Firstly we drop the COMMAND_DROP event since that
> won't work for response queue (since queuing an event will need to
> append to the response queue itself), then we use monitor suspend and
> resume to control the flow.  Last, we apply that to response queue
> too.

These need work.  We need to agree on how exactly flow control should
work.  Moreover, we need to reconcile your work with Marc-Andr=C3=A9's
"[PATCH 00/12] RFC: monitor: various code simplification and fixes"
(which I haven't fully reviewed yet).

> Patch 8-9: the original patches to enable out-of-band by default.

I figure these patches are good; we just need to decide whether we're
ready to enable OOB.  Let's review the known issues.

* We might want to make "id" mandatory with exec-oob

  Best to do that right in the first release that fully supports OOB.

* OOB offered but rejected by client is not obviously the same as
  OOB not offered

  I still need to digest and reply to your
  Message-ID: <20180629090115.GH2455@xz-mi>

* COMMAND_DROPPED is broken by design, and
* Flow control limits only request queue; response buffer can still
  grow without bounds

  You proposed to drop COMMAND_DROPPED, and do flow control by corking
  input, see above.

  Getting rid of broken COMMAND_DROPPED is a blocker.  Fully functional
  flow control isn't, since the QMP client is trusted.

* We lack test coverage for flow control
* test-qmp-cmds neglects to cover the OOB additions to qmp-dispatch.c

  I'm inclined to treating lack of test coverage as a blocker.

* scripts/qmp/ doesn't support OOB, yet.  qmp-shell.py in particular.

  Not a blocker.

Whatever we don't address right away we should at least mark FIXME in
the source code.

Assuming my list is complete, and my assessments correct, then we're
quite close to the point where we can enable OOB.  But since rc1 is
tomorrow already, I feel enabling it in 3.0 has become unrealistic.  I
understand we need it sooner rather than later for postcopy recovery.
However, the current state should be servicable for teaching OOB to
libvirt: just follow the recommendation to supply "id" (libvirt always
does anyway), pretend COMMAND_DROPPED doesn't exist, and pretend flow
control isn't an issue.

[...]
