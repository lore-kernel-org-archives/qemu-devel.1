Received: from eggs.gnu.org ([2001:4830:134:3::10]:40301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eyr8x-0007Qj-JL
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 23:44:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eyr8u-00027x-Gd
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 23:43:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50422 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eyr8u-00027q-BZ
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 23:43:56 -0400
Date: Thu, 22 Mar 2018 11:43:37 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180322034337.GD32362@xz-mi>
References: <20180321065506.21091-1-peterx@redhat.com>
	<20180321065506.21091-3-peterx@redhat.com>
	<5f5af472-1606-ebe1-47c6-9b6bdc26cad9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5f5af472-1606-ebe1-47c6-9b6bdc26cad9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] tests: add oob-test for qapi-schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, Markus Armbruster <armbru@redhat.com>

On Wed, Mar 21, 2018 at 07:52:06AM -0500, Eric Blake wrote:
> On 03/21/2018 01:55 AM, Peter Xu wrote:
> > It simply tests the new OOB capability, and make sure the QAPISchema can
> > parse it correctly.
> 
> We also want negative tests that cover any new error messages in the qapi
> generator (such as 'allow-oob':'bad' diagnosing a non-bool, or
> 'allow-oob':false giving an error message that false is already the default
> such that only 'allow-oob':true makes sense).
> 
> Also, it's often easier to merge the positive test into the giant existing
> qapi-schema-test.json rather than creating a new positive test.

It seems that for one QAPI schema negative test only the first error
will be reported, then the script halts (so the 2nd negative test in
the same .json won't be reported).  To make it simple - I'll put the
positive test into qapi-schema-test.json, and add one negative test in
oob-test.json to check again strings (though in the code I'll only
allow 'false').

(Actually I'll need one liner change to check that value when parsing
 since it was not checked before...)

> 
> > +++ b/tests/qapi-schema/oob-test.out
> > @@ -0,0 +1,6 @@
> > +object q_empty
> > +enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
> > +    prefix QTYPE
> > +module oob-test.json
> > +command an-oob-command None -> None
> > +   gen=True success_response=True boxed=False oob=True
> 
> At any rate, the positive test addition is good. I may beat you to
> submitting a v2 patch that covers the error messages that I'm thinking of.

Will post another version (and I'll see whether I should queue more to
fix existing reported OOB problems).  Thanks,

-- 
Peter Xu
