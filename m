Received: from eggs.gnu.org ([2001:4830:134:3::10]:49619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdZdI-0004SO-Ho
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:19:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdZdH-0007BU-CP
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:19:36 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180704150256.408d4a07.cohuck@redhat.com>
	<20180704133440.GE4334@localhost.localdomain>
	<CAFEAcA-RVBXBj=+nr_D=bexLP4Rwgs+xyjJQ8VoOM9aOOVUJ3A@mail.gmail.com>
	<20180706131103.4e713911.cohuck@redhat.com>
	<20180706145645.GB3939@localhost.localdomain>
	<20180709072953.GE7755@andariel.pipo.sk>
	<87k1q3ljgs.fsf@dusky.pond.sub.org>
	<20180710162208.7b1b5cdc.cohuck@redhat.com>
	<20180710143807.GJ5852@localhost.localdomain>
	<871sc9gdr2.fsf@dusky.pond.sub.org>
	<20180712070032.GW1148@andariel.pipo.sk>
Date: Thu, 12 Jul 2018 13:19:28 +0200
In-Reply-To: <20180712070032.GW1148@andariel.pipo.sk> (Peter Krempa's message
	of "Thu, 12 Jul 2018 09:00:32 +0200")
Message-ID: <87a7qwr9a7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [libvirt] [PULL 25/26] block: Remove deprecated
 -drive option serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Krempa <pkrempa@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Boris Fiuczynski <fiuczy@linux.ibm.com>, Qemu-block <qemu-block@nongnu.org>, Libvirt <libvir-list@redhat.com>, Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>

Peter Krempa <pkrempa@redhat.com> writes:

> On Thu, Jul 12, 2018 at 08:38:25 +0200, Markus Armbruster wrote:
>> Kevin Wolf <kwolf@redhat.com> writes:
>> > Am 10.07.2018 um 16:22 hat Cornelia Huck geschrieben:
>> >> On Tue, 10 Jul 2018 07:59:15 +0200
>> >> Markus Armbruster <armbru@redhat.com> wrote:
>> >> Would that be workable?
>> >
>> > I think the function should just take a message:
>> >
>> >     /* Works like error_report(), except for the WARNING/ERROR prefix
>> >      * and exit(1) if -no-deprecated-options is set */
>> >     void deprecation_report(const char *fmt, ...);
>> 
>> I like it.  The contract could use a bit of polish, but that's detail.
>> 
>> > We don't necessarily deprecate only options, but we might also deprecate
>> > monitor commands, specific options values (while keeping other values of
>> > the same option) etc.
>> 
>> Exactly.
>
> For monitor commands we luckily have QMP introspection which can help a
> lot in this case. At least for deprecating stuff that is expressable by
> the schema.

Introspection doesn't convey "deprecated", but...

> In libvirt we are actually doing schema validation of the blockdev-add
> arguments generators and most commands which are covered by the
> qemumonitorjsontest. The schema used is based on our capability
> detection so it's gathered from the most-recent version of qemu we have
> required for our tests (which is most of the time based on GIT version
> of qemu if there are any significant new features).
>
> If the deprecation will be expressable by the schema it should be rather
> simple to modify the schema validator to catch the deprecation flags and
> report errors in our testsuite.

... we can certainly make it if it's useful.

> CI-ifying of the above should be then also very simple. We'd just gather
> fresh QMP schema rather than using one from our test case pantry.
>
> Some time ago I also added testing of the commandline generator in
> libvirt with the most recent capabilities rather than using the
> historically declared capabilities that we've added when the test was
> created. This means that we actually test some valid combinations and
> also if stuff covered by our capability probing is removed the tests
> will catch it.
>
> I was also thinking of adding a tool which would use the above tests to
> attempt starting of a qemu process until the monitor shows up. That test
> then could also use -no-deprecated-options. I'm hoping waiting for the
> monitor is sufficient to excercise most of the code which could contain
> deprecation warnings. (Alternatively we can go through the
> pre-cpu-startup setup done on the monitor as well). Unfortunately doing
> this will not be as simple asi the test cases contain random disk paths
> and other resources which may not be available. This means that it will
> require some in-place modification and creative temporary resource
> usage.

Yes.

If you find QEMU makes testing something hard, we should talk.  Together
we might find a reasonable way to make it easier.
