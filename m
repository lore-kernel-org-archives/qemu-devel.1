Received: from eggs.gnu.org ([2001:4830:134:3::10]:46168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fYnhl-000409-C8
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 03:20:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fYnhh-00063b-DQ
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 03:20:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37132 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fYnhh-00062F-8R
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 03:20:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BA092818F6F8
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 07:20:24 +0000 (UTC)
Date: Fri, 29 Jun 2018 15:20:20 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180629072020.GF2455@xz-mi>
References: <20180620073223.31964-1-peterx@redhat.com>
	<871sctea4y.fsf@dusky.pond.sub.org>
	<87tvpoadcc.fsf_-_@dusky.pond.sub.org>
	<87wouk8vul.fsf@dusky.pond.sub.org>
	<20180627102043.GD30628@redhat.com>
	<8760248odg.fsf@dusky.pond.sub.org> <20180627120733.GD2516@xz-mi>
	<9e9dc7aa-1d4e-ca9d-c551-eb0fb36e88b8@redhat.com>
	<8736x75r4c.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8736x75r4c.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] monitor: enable OOB by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org

On Thu, Jun 28, 2018 at 09:04:19AM +0200, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
> > On 06/27/2018 07:07 AM, Peter Xu wrote:
> >
> >>>> Worse than that - broadcasting to all monitors is categorically broken.
> >>>> Different monitors make use the same "id" formatting scheme, so if you
> >>>> broadcast COMMAND_DROPPED to a different monitor you might have clashing
> >>>> "id" and thus incorrectly tell a client its command was dropped when in
> >>>> fact it was processed. You'd have to be fairly unlucky in timing, but
> >>>> it could happen.
> >>>
> >>> Right.  Must fix bug.
> >>
> >
> >>
> >> My current plan is that I can touch up scripts/qapi/events.py and
> >> related stuff to allow QMPEventFuncEmit to take a monitor parameter,
> >> then we pass in NULL when we want to send the event to all monitors.
> >>
> >> Would that work?
> >
> > Makes sense to me. Also, right now, ALL callers of qapi_event_send_*
> > pass &error_abort as their final parameter. If you're refactoring
> > everything anyways, you could get rid of that parameter on the
> > presumption that it doesn't buy us anything.
> 
> Let me try to turn presumption into fact :)
> 
> The generated qapi_event_send_FOO() can detect the following error
> conditions:
> 
> * Visitor fails.  But the QObject output visitor can't actually fail.
> 
>   Since the errp parameter is part of the abstract visitor interface, we
>   can't eliminate it.  We can pass &error_abort.
> 
> * emit() function fails.  Can't happen, either.
> 
>   Let's eliminate the unused errp parameter of QMPEventFuncEmit.

Hmm, I think I got your point.

> 
>   If we can eliminate the somewhat silly indirection through
>   qmp_event_get_func_emit(), even better.

It confused me before on why we had that after all. Let me give it a
shot.

Regards,

-- 
Peter Xu
