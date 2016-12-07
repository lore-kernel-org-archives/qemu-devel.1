Received: from eggs.gnu.org ([2001:4830:134:3::10]:40808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cESOW-0001Ju-17
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 21:55:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cESOV-00014O-44
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 21:55:44 -0500
Date: Wed, 7 Dec 2016 10:55:34 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20161207025457.GB30227@lemon>
References: <87oa0q1t21.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87oa0q1t21.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] Meeting notes on -blockdev,
 dynamic backend reconfiguration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On Mon, 12/05 13:03, Markus Armbruster wrote:
> == Basic dynamic reconfiguration operation ==
> 
> The basic operation is "replace child".
> 
> Beware of race conditions.  Consider:
> 
>           BB
>           |
>     mirror-filter
>           |
>          BDS
> 
> Add a throttle filter under BB while the mirror job is running.  First
> step, create the filter:
> 
>           BB    throttle-filter
>           |     /
>     mirror-filter
>           |
>          BDS
> 
> Second step, replace child of BB by the new filter:
> 
>           BB
>           |
>    throttle-filter
>           |
>     mirror-filter
>           |
>          BDS
> 
> But: if mirror-filter goes away between the two steps, the replace
> brings it right back!
> 
> To guard against such races, we need to specify both ends of the edge
> being replaced, i.e. parent, child name, actual child.  Then the replace
> step fails if the mirror-filter has gone away.  We can either fail the
> whole operation, or start over.
> 
> Alternatively, transactions, but that feels much more complex.
> 

Isn't it easy to make creating throttle-filter and replacing child happen in the
same critical section of BQL, without any coroutine yield?  If so I think there
is no race to worry about, mirror-filter should go away only after a QMP command.

Fam
