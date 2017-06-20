Received: from eggs.gnu.org ([2001:4830:134:3::10]:40501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dNJrD-0006No-7k
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:10:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dNJr9-0007nb-8d
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:10:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48979)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dNJr8-0007mI-Vi
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:10:11 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170613140546.28227-1-vadim.galitsyn@profitbricks.com>
	<20170614092040.GB2687@work-vm>
	<CAPHE7NqmDh-BKNg1-r8FNXw=qFSs9vdHPBO9gYc61js7fTkOpg@mail.gmail.com>
	<20170614154043.GE2687@work-vm>
Date: Tue, 20 Jun 2017 16:10:00 +0200
In-Reply-To: <20170614154043.GE2687@work-vm> (David Alan Gilbert's message of
	"Wed, 14 Jun 2017 16:40:43 +0100")
Message-ID: <874lva21jb.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] hmp,
 qmp: introduce "info memory" and "query-memory" commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>, imammedo@redhat.com, Mohammed Gamal <mgamal@redhat.com>, qemu-devel@nongnu.org

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Vadim Galitsyn (vadim.galitsyn@profitbricks.com) wrote:
>> Hi Dave,
>> 
>> Thank you for the feedback!
>> 
>> > I think you need to use the PRIu64 macros rather than 'lu' for the types
>> > of the ints there to keep it portable.
>> 
>> Agree, patch v3 will include this change.
>
> Thanks.
>
>> > Other than that; please add a test entry to tests/test-hmp.c
>> > and I'm guessing you'll also need a qmp test for it.
>> 
>> As far as I can see in tests/test-hmp.c, it's automatically there.
>> The routine test_info_commands() enumerates all the available "info"
>> sub-commands with "info help" and tries to execute them, so it looks
>> like no extra stuff needs to be done here (please correct me if I am wrong).
>
> Ah yes you're right; I forgot the 'info' commands were automatic.
>
>> Regarding to QMP test, I cannot find any test under tests/ which
>> does similar job as in tests/test-hmp.c. There is neither HMP commands
>> iteration nor command-specific separate tests. Under tests/qapi-schema/
>> there are set of .json's though, however, again, it looks more like general
>> tests set (not commands-specific one).
>> 
>> It seems that all the HMP related tests do general checks -- targeting
>> HMP "engine" itself. I would say, Avocado (avocado-vt) test suite can
>> be extended with "query-memory" test, and I can certainly provide one.
>> But this topic is for another mainling list.
>
> Yes hmm not sure where to put the qmp test, I just know that Markus does
> like them (I think he's out this week).

The best time to start requiring tests for new QMP commands is when the
first command is added.  We missed that opportunity.  The second best
time is right now[*].

The QMP equivalent to test-hmp.c's test_info_commands() would be good
enough for query-FOOs that can't fail.  We should have that.  It's not
fair to ask you to write it.  Not least because doing it right involves
introspection, which is going to be a bit hairy.  I guess I'll have to
do it myself[**].

However, your query-memory looks like it could fail.  Failure modes need
to be covered by test cases.  Please either explain why it can't
actually fail, or explain why testing the failure isn't practical, or
write a suitable test.  A mere sketch hacked into qmp-test.c is
perfectly okay, we can take it from there together.



[*] Or rather last March:
Message-ID: <871sugkrw5.fsf@dusky.pond.sub.org>
https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg00296.html

[**] Surprise me!  Patches welcome :)
