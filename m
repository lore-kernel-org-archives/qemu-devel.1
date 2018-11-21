Received: from eggs.gnu.org ([2001:4830:134:3::10]:40571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gPVCB-0001Vi-9y
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 11:17:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gPVC7-0002Q4-A1
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 11:17:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gPVC5-0002OK-7U
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 11:17:39 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 303083002E00
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 16:17:35 +0000 (UTC)
References: <20181121134151.23993-1-crosa@redhat.com>
	<20181121134151.23993-2-crosa@redhat.com>
	<87pnuy1lba.fsf@dusky.pond.sub.org>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <51ad7202-4ff0-dcd8-e107-eb6776203fbe@redhat.com>
Date: Wed, 21 Nov 2018 11:17:33 -0500
MIME-Version: 1.0
In-Reply-To: <87pnuy1lba.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] Acceptance tests: add test for
 set-numa-node error handler fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <pmathieu@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Igor Mammedov <imammedo@redhat.com>



On 11/21/18 10:50 AM, Markus Armbruster wrote:
> Cleber Rosa <crosa@redhat.com> writes:
> 
>> Commit a22528b918 fixed an issue that is exposed by means of the
>> "set-numa-node" QMP command (introduced in f3be67812).  This adds a
>> test that pretty much maps the steps documented on the fix.
>>
>> Additionally, given that 'set-numa-node' is only allowed in
>> 'preconfig' state, a specific check for that was added a separate
>> test.
>>
>> Tests: a22528b918c7d29795129b5a64c4cb44bb57a44d
>> Reference: f3be67812c226162f86ce92634bd913714445420
>> CC: Igor Mammedov <imammedo@redhat.com>
>> CC: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> ---
>>  tests/acceptance/set_numa_node.py | 41 +++++++++++++++++++++++++++++++
>>  1 file changed, 41 insertions(+)
>>  create mode 100644 tests/acceptance/set_numa_node.py
>>
>> diff --git a/tests/acceptance/set_numa_node.py b/tests/acceptance/set_numa_node.py
>> new file mode 100644
>> index 0000000000..0c55315231
>> --- /dev/null
>> +++ b/tests/acceptance/set_numa_node.py
>> @@ -0,0 +1,41 @@
>> +# Tests for QMP set-numa-node related behavior and regressions
>> +#
>> +# Copyright (c) 2018 Red Hat, Inc.
>> +#
>> +# Author:
>> +#  Cleber Rosa <crosa@redhat.com>
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2 or
>> +# later.  See the COPYING file in the top-level directory.
>> +
>> +from avocado_qemu import Test
>> +
>> +
>> +class SetNumaNode(Test):
>> +    """
>> +    :avocado: enable
>> +    :avocado: tags=quick,numa
>> +    """
>> +    def test_numa_not_supported(self):
>> +        self.vm.add_args('-nodefaults', '-S', '-preconfig')
>> +        self.vm.set_machine('none')
>> +        self.vm.launch()
>> +        res = self.vm.qmp('set-numa-node', type='node')
>> +        self.assertIsNotNone(res, 'Unexpected empty QMP response to "set-numa-node"')
>> +        self.assertEqual(res['error']['class'], 'GenericError')
>> +        self.assertEqual(res['error']['desc'],
>> +                         'NUMA is not supported by this machine-type')
> 
> Checking the QMP command fails a certain way takes you four lines[*].
> Such checks are pretty common in tests using QMP.  Consider creating a
> convenience method.
> 

Sure, that discussion is going on.  Part of it can be seen here:

https://trello.com/c/a4wBNsGX/63-better-test-failure-output#comment-5bf448b695549b5cfa92b638

In the near future, we'd like to have a number of convenience methods,
that would optimize both test writing time, and test debugging time,
with as relevant as possible failure messages.  Something like:

   self.assertQMP(command, 'error/desc', 'NUMA is not...')

That checks for errors general QMP error conditions is something we're
planning.

>> +        self.assertTrue(self.vm.is_running())
>> +        self.vm.qmp('x-exit-preconfig')
>> +        self.vm.shutdown()
>> +        self.assertEqual(self.vm.exitcode(), 0)
>> +
>> +    def test_no_preconfig(self):
>> +        self.vm.add_args('-nodefaults', '-S')
>> +        self.vm.set_machine('none')
>> +        self.vm.launch()
>> +        res = self.vm.qmp('set-numa-node', type='node')
>> +        self.assertIsNotNone(res, 'Unexpected empty QMP response to "set-numa-node"')
>> +        self.assertEqual(res['error']['class'], 'GenericError')
>> +        self.assertEqual(res['error']['desc'],
>> +                         "The command is permitted only in 'preconfig' state")
> 
> The test looks good to me.
> 
> It could also be done as a qtest in C.  Do we have guidance on when to
> use C / qtest and when to use Python / Avocado?
> 

TBH, I don't have such a guideline, and I'd probably be biased if I
tried to define one.  I've heard from more than one person, though, that
the perceived learning curve and general maintenance costs of
Python/Avocado tests seem to be way lower (IMMV, though).

> One possible argument for using Python more could be "tests are cheaper
> to create and easier to debug that way".  Do we have evidence for that,
> or at least gut feelings?
> 

Again, I'd be biased trying to answer that, and IMO this feels like an
emacs .vs. vi kind of question.  I dare to say that we're past that
point, and we should, if we receive any, just embrace contributions that
fall into this type of test.

> A possible argument against using Python could be much slower "make
> check".  I have no idea whether that's actually the case.
> 

My data is scarce, but considering that these two tests take 0.01s
seconds each on a low powered environment such as the one given by
Travis-CI:

https://travis-ci.org/clebergnu/qemu/jobs/457721176#L2051

I wouldn't be too worried about that right now.  And, these are not part
of "make check" anyway.

> Non-argument: requiring Avocado as a build dependency for testing.  I
> think that's totally fine as long as it's readily available on all our
> supported host platforms.  Same as for any other build dependency,
> really.
> 
> 
> [*] Would be more if you additionally checked res['error'] exists and is
> a dictionary.  I'm not saying you should, just that checking @res isn't
> None feels odd to me unless you do.
> 

You're right, that would indeed be an improvement.  Right now, if
res['error'] does not exist, the outcome is a test ERROR, instead of a
test FAILure.  That signals that there's a problem with the test (which
technically speaking is true), and depending how you look at it, it
could be said that it casts a shadow over the FAILure.

Having said that, we're aware of many areas in which the framework (both
in core Avocado and in the QEMU supporting code) can be improved.  The
general feeling is that we shouldn't wait until we have a supposedly
perfect environment before start writing tests.  Besides the coverage
value that those tests can bring, the improvement opportunities are best
seen during that process.

Thanks for the review and the very much valid points you raised.
- Cleber.
