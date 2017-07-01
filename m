Received: from eggs.gnu.org ([2001:4830:134:3::10]:58160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dRJG8-000467-Lh
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 10:20:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dRJG5-0003X6-F3
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 10:20:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dRJG5-0003WC-6S
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 10:20:25 -0400
Date: Sat, 1 Jul 2017 11:20:20 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170701142020.GD12152@localhost.localdomain>
References: <20170613165313.20954-1-ehabkost@redhat.com>
	<87o9t8qy7d.fsf@dusky.pond.sub.org>
	<20170628174158.GG12152@localhost.localdomain>
	<87mv8r2sii.fsf@dusky.pond.sub.org>
	<20170629125706.GT12152@localhost.localdomain>
	<871sq1r9dh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871sq1r9dh.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [RFC 00/15] Error API: Flag errors in *errp even
 if errors are being ignored
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

On Fri, Jun 30, 2017 at 01:40:58PM +0200, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
> > On Thu, Jun 29, 2017 at 08:54:29AM +0200, Markus Armbruster wrote:
> >> Eduardo Habkost <ehabkost@redhat.com> writes:
> >> 
> >> > On Wed, Jun 28, 2017 at 11:05:26AM +0200, Markus Armbruster wrote:
> >> >> Eduardo Habkost <ehabkost@redhat.com> writes:
> > [...]
> >> >> > I understand the reason we need to support errp==NULL, as it
> >> >> > makes life simpler for callers that don't want any extra error
> >> >> > information.  However, this has the cost of making the functions
> >> >> > that report errors more complex and error-prone.
> >> >> >
> >> >> > (Evidence of that: the 34 ERR_IS_* cases handled by the "use
> >> >> > ERR_IS_* macros" patches in the series.  Where existing code will
> >> >> > crash or behave differently if errp is NULL.)
> >> >> 
> >> >> Which of them could *not* use a suitable return value instead of *errp?
> >> >
> >> > I don't know.  But I'm not trying to improve those 34 ERR_IS_* cases.  I
> >> > am trying to improve the 700+ functions that need the
> >> > local_err/error_propagate() boilerplate code today.  This series already
> >> > handles 346 of them automatically (see patch 14/15).
> >> 
> >> I agree the goal is reducing error_propagate() boilerplate.  I latched
> >> onto the 34 ERR_IS_* cases only because you presented them as examples.
> >
> > The 34 ERR_IS_* cases were evidence of how easy it is to introduce
> > mistakes with the current API.  Probably most of them are instances of
> > (1) and (2) below.
> 
> The current interface can be abused, but how much abuse actually creeps
> in?  I think we've been doing reasonably well there since we got rid of
> the bad examples and improved documentation.

See the 30+ cases touched by patch 09/15.  Except for the ones in
error.c, all of them look like bugs to me.

I didn't investigate when each of them were introduced, though.

> 
> Moreover, the revised interface could also be abused.  Nothing stops you
> from dereferencing errp before or after, the only thing that changes are
> the examples people see in code.  I'm afraid the people who reinvent bad
> examples from scratch despite the documentation telling them not to will
> also bypass any macros the documentation tells them to use.
> 
> *Especially* if we use macros only sometimes.  ERR_IS_SET(&err) makes no
> sense, so we'd still test err directly there, wouldn't we?

Any interface can be abused.  But I still believe a simpler and easier
interface for propagating errors is less likely to be abused.

But in either case, tools to detect abuse would be welcome.  We can
write Coccinelle scripts to detect most abuse of the existing error API.

> 
[...]
> >> > is fixed because ERR_IS_SET(errp) will work even if errp is NULL.
> >> >
> >> >> > TODO
> >> >> > ----
> >> >> >
> >> >> > * Simplify more cases of local_error/error_propagate() to use
> >> >> >   errp directly.
> >> >> > * Update API documentation and code examples.
> >> >> > * Add a mechanism to ensure errp is never NULL.
> >> >> >
> >> >> > Git branch
> >> >> > ----------
> >> >> >
> >> >> > This series depend on a few extra cleanups that I didn't submit
> >> >> > to qemu-devel yet.  A git branch including this series is
> >> >> > available at:
> >> >> >
> >> >> >   git://github.com/ehabkost/qemu-hacks.git work/err-api-rework-ignore-ptr-v1
> 
> I doubt the macros make the bug fixing materially easier, and I doubt
> they can reduce future bugs of this kind.  What they can do is letting
> us get rid of error_propagate() boilerplate with relative ease.
> 
> If we switch to returning success/failure (which also gets rid of the
> boilerplate), then the macros may still let us get rid of boilerplate
> more quickly, for some additional churn.  Worthwhile?  Depends on how
> long the return value change takes us.

My assumption is that it will take a very long time.

> 
> I think the first order of business is to figure out whether we want to
> pursue returning success/failure.

OK.  I will reply about that in a separate message.

-- 
Eduardo
