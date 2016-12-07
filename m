Received: from eggs.gnu.org ([2001:4830:134:3::10]:57561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEYqA-000239-Td
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 04:48:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEYqA-0006E0-6l
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 04:48:42 -0500
Date: Wed, 7 Dec 2016 10:48:32 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20161207094832.GA4773@noname.str.redhat.com>
References: <87oa0q1t21.fsf@dusky.pond.sub.org> <20161207025457.GB30227@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161207025457.GB30227@lemon>
Subject: Re: [Qemu-devel] [Qemu-block]  Meeting notes on -blockdev,
 dynamic backend reconfiguration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 07.12.2016 um 03:55 hat Fam Zheng geschrieben:
> On Mon, 12/05 13:03, Markus Armbruster wrote:
> > == Basic dynamic reconfiguration operation ==
> > 
> > The basic operation is "replace child".
> > 
> > Beware of race conditions.  Consider:
> > 
> >           BB
> >           |
> >     mirror-filter
> >           |
> >          BDS
> > 
> > Add a throttle filter under BB while the mirror job is running.  First
> > step, create the filter:
> > 
> >           BB    throttle-filter
> >           |     /
> >     mirror-filter
> >           |
> >          BDS
> > 
> > Second step, replace child of BB by the new filter:
> > 
> >           BB
> >           |
> >    throttle-filter
> >           |
> >     mirror-filter
> >           |
> >          BDS
> > 
> > But: if mirror-filter goes away between the two steps, the replace
> > brings it right back!
> > 
> > To guard against such races, we need to specify both ends of the edge
> > being replaced, i.e. parent, child name, actual child.  Then the replace
> > step fails if the mirror-filter has gone away.  We can either fail the
> > whole operation, or start over.
> > 
> > Alternatively, transactions, but that feels much more complex.
> > 
> 
> Isn't it easy to make creating throttle-filter and replacing child
> happen in the same critical section of BQL, without any coroutine
> yield?

Letting it happen in the same critical section of BQL would mean a
QMP transaction of blockdev-add (for the new throttle node) and
blockdev-replace-child or whatever it would be called. We weren't quite
confident that trying to make blockdev-add transactionable would be
possible or a good idea.

> If so I think there is no race to worry about, mirror-filter should go
> away only after a QMP command.

Currently, a mirror job goes away whenever it is done. This is not
directly tied to a QMP command.

Of course, in the new job API we want an explicit job-delete, so in
that case it wouldn't happen, but we need to keep the old case for
compatibility.

Kevin
