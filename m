Received: from eggs.gnu.org ([2001:4830:134:3::10]:52947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fV8aA-0003TD-UN
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 00:49:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fV8a7-0004qq-PL
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 00:49:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48502 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fV8a7-0004qZ-JQ
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 00:49:27 -0400
Date: Tue, 19 Jun 2018 12:49:09 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180619044909.GH16790@xz-mi>
References: <20180615014249.22730-1-peterx@redhat.com>
	<20180615014249.22730-5-peterx@redhat.com>
	<87wov02pk2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wov02pk2.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v3 4/6] docs: mention shared state protect
 for OOB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Eric Auger <eric.auger@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Fri, Jun 15, 2018 at 02:37:49PM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Out-Of-Band handlers need to protect shared state if there is any.
> > Mention it in the document.
> >
> > Suggested-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  docs/devel/qapi-code-gen.txt | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> > index 1366228b2a..bee9de35df 100644
> > --- a/docs/devel/qapi-code-gen.txt
> > +++ b/docs/devel/qapi-code-gen.txt
> > @@ -680,6 +680,9 @@ OOB command handlers must satisfy the following conditions:
>    Under normal QMP command execution, the following apply to each
>    command:
> 
>    - They are executed in order,
>    - They run only in main thread of QEMU,
>    - They have the BQL taken during execution.
> 
> Not this patch's fault, but this sounds awkward.  Perhaps "They run with
> the BQL held."
> 
>    When a command is executed with OOB, the following changes occur:
> 
>    - They can be completed before a pending in-band command,
>    - They run in a dedicated monitor thread,
>    - They do not take the BQL during execution.
> 
> "They run with the BQL not held".
> 
>    OOB command handlers must satisfy the following conditions:
> 
>    - It executes extremely fast,
> 
> "It terminates quickly"
> 
>    - It does not take any lock, or, it can take very small locks if all
>      critical regions also follow the rules for OOB command handler code,
> 
> "It takes only "fast" locks, i.e. all critical sections protected by any
> lock it takes also satisfy the conditions for OOB command handler code."
> Maybe make it the last item.
> 
> >  - It does not invoke system calls that may block,
> >  - It does not access guest RAM that may block when userfaultfd is
> >    enabled for postcopy live migration.
> 
> All these are corollaries of the first item.  But that's okay.
> 
> > +- It needs to protect any shared state, since as long as a command
> > +  supports Out-Of-Band it means the handler can be run in parallel
> > +  with the same handler running in the other thread.
> 
> "in another thread"
> 
> Not just the same handler is a potential problem.  Any code accessing
> shared state from another thread is.
> 
> "It needs" is not really a condition.
> 
> Perhaps we can make this a separate paragraph rather than an additional
> item:
> 
>    The restrictions on locking limit access to shared state.  Such
>    access requires synchronization, but OOB commands can't take the BQL
>    or any other "slow" lock.

Yes this looks good to me.  I'll apply the rest of suggestions in my
next post along with this patch.  I'll touch up the commit message a
bit too.

Thanks,

-- 
Peter Xu
