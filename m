Received: from eggs.gnu.org ([2001:4830:134:3::10]:51200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dS1Ik-0001Aa-3N
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 09:22:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dS1Ie-0006fr-Vu
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 09:22:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dS1Ie-0006fg-Ms
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 09:22:00 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170613165313.20954-1-ehabkost@redhat.com>
	<87o9t8qy7d.fsf@dusky.pond.sub.org>
	<20170628174158.GG12152@localhost.localdomain>
	<87mv8r2sii.fsf@dusky.pond.sub.org>
	<20170629125706.GT12152@localhost.localdomain>
	<871sq1r9dh.fsf@dusky.pond.sub.org>
	<20170701142909.GE12152@localhost.localdomain>
Date: Mon, 03 Jul 2017 15:21:56 +0200
In-Reply-To: <20170701142909.GE12152@localhost.localdomain> (Eduardo Habkost's
	message of "Sat, 1 Jul 2017 11:29:09 -0300")
Message-ID: <87shidk64r.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Fri, Jun 30, 2017 at 01:40:58PM +0200, Markus Armbruster wrote:
> [...]
>> 
>> I doubt the macros make the bug fixing materially easier, and I doubt
>> they can reduce future bugs of this kind.  What they can do is letting
>> us get rid of error_propagate() boilerplate with relative ease.
>> 
>> If we switch to returning success/failure (which also gets rid of the
>> boilerplate), then the macros may still let us get rid of boilerplate
>> more quickly, for some additional churn.  Worthwhile?  Depends on how
>> long the return value change takes us.
>> 
>> I think the first order of business is to figure out whether we want to
>> pursue returning success/failure.
>
> About this, I'm unsure.  Returning error information in two separate
> locations (the return value and *errp) makes it easier to introduce bugs
> that are hard to detect.

I sympathize with this argument.  It's exactly what that made us avoid
returning a success/failure indication.

Except when we don't actually avoid it:

* Functions returning a pointer typically return non-null on success,
  null on failure.  Has inconsistency between return value and Error
  setting been a problem in practice?  Nope.

* Quite a few functions return 0 on success, -errno on failure, to let
  callers handle different errors differently.  Has inconsistency been a
  problem in practice?  Nope again.

  Aside: the original Error plan was to have callers check ErrorClass,
  but that didn't work out.

* Functions with a side effect typically either do their side effect and
  succeed, or do nothing and fail.  Inconsistency between side effect
  and claimed success is theoretically possible no matter how success is
  claimed: it's possible if the function returns success/failure, it's
  possible if it sets an Error on failure and doesn't on success, and
  it's possible if it does both.

My point is: returning void instead of success/failure gets rid only of
a part of a theoretical problem, which turns out not much of a problem
in practice.

>                           Especially when the tree is an inconsistent
> state where we mix -1/0, -errno/0, FALSE/TRUE, NULL/non-NULL and void
> functions.

This is basically ret<0/ret>=0, !ret/ret, void.

Getting rid of void would improve matters, wouldn't it?
