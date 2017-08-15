Received: from eggs.gnu.org ([2001:4830:134:3::10]:33990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dhg8R-0001F7-1H
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 14:00:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dhg8K-0001ek-Um
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 14:00:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dhg8K-0001cF-M3
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 14:00:04 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 05AD46B364
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 18:00:01 +0000 (UTC)
Date: Tue, 15 Aug 2017 14:59:52 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170815175952.GU3108@localhost.localdomain>
References: <20170814215748.5158-1-ehabkost@redhat.com>
	<20170814215748.5158-3-ehabkost@redhat.com>
	<c78602cc-80e3-932b-5a0f-e3aa0003a183@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c78602cc-80e3-932b-5a0f-e3aa0003a183@redhat.com>
Subject: Re: [Qemu-devel] [RFC v4 02/13] qapi: qobject_compare() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Laine Stump <laine@redhat.com>, Max Reitz <mreitz@redhat.com>

On Tue, Aug 15, 2017 at 11:16:57AM -0500, Eric Blake wrote:
> On 08/14/2017 04:57 PM, Eduardo Habkost wrote:
> > The helper function will be useful when writing support code to
> > deal with device slot information.
> > 
> > TODO: documentation is incomplete and unclear, needs to be
> > improved.
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  include/qapi/util.h    | 39 +++++++++++++++++++++++++++++
> >  qapi/qapi-util.c       | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/test-qapi-util.c | 53 ++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 158 insertions(+)
> > 
> 
> > +/**
> > + * qobject_compare:
> > + *
> > + * Compare the value of @a and @b.
> > + *
> > + * If @a and @b have the same type and the same value (see list
> > + * of supported types below), return 0.
> > + *
> > + * If @a and @b are both strings, return strcmp(a, b).
> > + *
> > + * If @a and @b are numbers, return a negative value if a < b,
> > + * and a positive value if a > b.
> > + *
> > + * Otherwise (if @a and @b are not the same, have different types,
> > + * are of an unsupported type, or are different), return a non-zero value.
> 
> Is this number going to be commutative and distributive, in order to
> provide stable qsort()ing?  That is, if comparing a and b gives a
> positive number, then comparing b and a should give a negative number;
> and if comparing a and b then b and c results in two positive numbers,
> then comparing a and c should also give a positive number.  It is
> unclear from the documentation whether you are able to make this
> guarantee; and without it, it is unsafe to use this comparator in places
> that require stability.

No, I don't make that guarantee when the types don't match or in
the case of unsupported types.  That's a limitation of this
implementation.

Guaranteeing it when types don't match should be easy.
Guaranteeing it in the case of QTYPE_QDICT looks a bit harder.
Probably it's easier to simply implement full dictionary
comparison.

> 
> > + *
> > + * Note that this function doesn't support some types, and may
> > + * return false if the types are unsupported, or if the types don't
> > + * match exactly.
> 
> How is a return of false (== 0, which also means equivalent) correct?

This is a documentation bug.  Leftover from a version that
returned a boolean value (true for equal, false for not equal) in
the past.

> 
> > + *
> > + * Supported types:
> > + * - QTYPE_QNULL
> > + * - QTYPE_QSTRING
> > + * - QTYPE_QBOOL
> > + * - QTYPE_QNUM (integers only)
> > + * - QTYPE_QLIST
> > + *
> > + * Unsupported (always return false):
> > + * - QTYPE_QNUM (non-integer values)
> > + * - QTYPE_QDICT
> > + *
> > + * TODO: rewrite documentation to be clearer.
> > + * TODO: support non-integer QTYPE_NUM values and QTYPE_QDICT.
> 
> There's another patch series pending for qobject_is_equal(); should
> these two patches share approaches or even code?
> 
> https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg01134.html
> https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02459.html

I will take a look.  Thanks!

-- 
Eduardo
