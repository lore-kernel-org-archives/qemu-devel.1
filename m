Received: from eggs.gnu.org ([2001:4830:134:3::10]:44443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqMEb-0004j2-PD
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 12:02:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqMEW-0006Ne-3Y
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 12:02:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cqMEV-0006NP-RO
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 12:02:04 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170321031705.22291-1-eblake@redhat.com>
	<20170321031705.22291-2-eblake@redhat.com>
	<fb42e59d-f196-84a3-420f-dc488ef62c53@redhat.com>
	<6cb7d791-8cf5-3a48-572e-30370b1bf608@redhat.com>
	<13797820-ea41-0991-7825-a8e32fa0932a@redhat.com>
	<c2a8ff05-e4c8-48d0-63c7-572ea06c1c23@redhat.com>
Date: Tue, 21 Mar 2017 17:01:57 +0100
In-Reply-To: <c2a8ff05-e4c8-48d0-63c7-572ea06c1c23@redhat.com> (Eric Blake's
	message of "Tue, 21 Mar 2017 10:36:20 -0500")
Message-ID: <8760j2litm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2] tests: Expose regression in QemuOpts
 visitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

Eric Blake <eblake@redhat.com> writes:

> On 03/21/2017 08:33 AM, Laurent Vivier wrote:
>> On 21/03/2017 14:21, Eric Blake wrote:
>>> On 03/21/2017 04:01 AM, Laurent Vivier wrote:
>>>> On 21/03/2017 04:17, Eric Blake wrote:
>>>>> Commit 15c2f669e broke the ability of the QemuOpts visitor to
>>>>> flag extra input parameters, but the regression went unnoticed
>>>>> because of missing testsuite coverage.  Add a test to cover this.
>>>>
>>>> I don't know where I'm wrong, but when I run this test without the fix
>>>> it never fails.
>>>
>>> Intentional:
>>>
>>>
>>>>> +    v = opts_visitor_new(opts);
>>>>> +    /* FIXME: bogus should be diagnosed */
>>>>> +    visit_type_UserDefOptions(v, NULL, &userdef, &error_abort);
>>>
>>> The test is written with a FIXME here, then updated in the next patch to
>>> remove the fixme and adjust the condition to what we really want, so
>>> that 'make check-unit' is not broken in the meantime.
>> 
>> OK.
>> 
>> Why don't you reverse the patch order to have a commit to apply the fix
>> and a commit to apply the test (fully)?
>> 
>> Like this, it easy to not apply the fix and only the test to check the
>> test really detects the problem and the fix really fix it (it's what
>> I've tried to do)... and the "make check" is never broken.
>
> Applying just the one-liner fix to qapi/opts-visitor.c in isolation
> already causes a 'make check' failure; a careful read of 2/2 shows that
> I was adjusting the expected output of two separate tests, added over
> two separate commits, but both with a BUG/FIXME tag.  I'm not opposed to
> reworking the series to apply the testsuite coverage after the bug fix,
> if that is deemed necessary, but would like an opinion from Markus which
> way he would prefer (as this is the code he maintains) before causing
> myself artificial churn.

I really, really like to start with the problem statement (test case),
not the solution.  I also like see the solution's effect in the update
to the test case.

Since "make check" must not fail, and our (rickety) testing framework
doesn't let us express "this is expected to fail", the problem statement
can't be a failing test case, but has to be a test case expecting the
broken behavior.

If that's not good enough to convince you that it detects the problem, I
recommend to git-checkout tests/ after the fix into the tree before the
fix.
