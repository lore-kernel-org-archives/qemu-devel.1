Received: from eggs.gnu.org ([2001:4830:134:3::10]:54437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vadim.galitsyn@profitbricks.com>) id 1dO3cq-0006Rd-1N
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 11:02:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vadim.galitsyn@profitbricks.com>) id 1dO3co-0002Gc-8y
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 11:02:28 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:34489)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vadim.galitsyn@profitbricks.com>)
	id 1dO3cn-0002Fz-Td
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 11:02:26 -0400
Received: by mail-wr0-x22c.google.com with SMTP id 77so27178480wrb.1
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 08:02:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <874lva21jb.fsf@dusky.pond.sub.org>
References: <20170613140546.28227-1-vadim.galitsyn@profitbricks.com>
	<20170614092040.GB2687@work-vm>
	<CAPHE7NqmDh-BKNg1-r8FNXw=qFSs9vdHPBO9gYc61js7fTkOpg@mail.gmail.com>
	<20170614154043.GE2687@work-vm> <874lva21jb.fsf@dusky.pond.sub.org>
From: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
Date: Thu, 22 Jun 2017 17:02:03 +0200
Message-ID: <CAPHE7NppPyGfe=29twDOUdWT=CXcJ8M935AbmtvPNS3-KorYzA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Markus Armbruster <armbru@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, imammedo@redhat.com, Mohammed Gamal <mgamal@redhat.com>, qemu-devel@nongnu.org

Hi Markus,

Thank you for the input.

> However, your query-memory looks like it could fail.

With the latest version of a patch (
http://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg03475.html)
"query-memory" can fail only in two cases:

a) if in QOM there is an object of type of TYPE_PC_DIMM which has no
property of type PC_DIMM_SIZE_PROP, or
b) PC_DIMM_SIZE_PROP is not represented as an integer.

As far as I understand both (a) and (b) can happen only in case if QOM
somehow corrupted which is not a normal case
(please correct me if I am wrong).

Please also note, this is not the last version of the patch since new
functionality was suggested
to be included (NUMA information).

If patch will be accepted, I think we would need a test case for it since
command output differs once memory
was hot-added/removed per given NUMA node. When final functionality will be
negotiated, I will come up
with test scenario and test case itself.

Thank you,
Vadim


On Tue, Jun 20, 2017 at 4:10 PM, Markus Armbruster <armbru@redhat.com>
wrote:

> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
>
> > * Vadim Galitsyn (vadim.galitsyn@profitbricks.com) wrote:
> >> Hi Dave,
> >>
> >> Thank you for the feedback!
> >>
> >> > I think you need to use the PRIu64 macros rather than 'lu' for the
> types
> >> > of the ints there to keep it portable.
> >>
> >> Agree, patch v3 will include this change.
> >
> > Thanks.
> >
> >> > Other than that; please add a test entry to tests/test-hmp.c
> >> > and I'm guessing you'll also need a qmp test for it.
> >>
> >> As far as I can see in tests/test-hmp.c, it's automatically there.
> >> The routine test_info_commands() enumerates all the available "info"
> >> sub-commands with "info help" and tries to execute them, so it looks
> >> like no extra stuff needs to be done here (please correct me if I am
> wrong).
> >
> > Ah yes you're right; I forgot the 'info' commands were automatic.
> >
> >> Regarding to QMP test, I cannot find any test under tests/ which
> >> does similar job as in tests/test-hmp.c. There is neither HMP commands
> >> iteration nor command-specific separate tests. Under tests/qapi-schema/
> >> there are set of .json's though, however, again, it looks more like
> general
> >> tests set (not commands-specific one).
> >>
> >> It seems that all the HMP related tests do general checks -- targeting
> >> HMP "engine" itself. I would say, Avocado (avocado-vt) test suite can
> >> be extended with "query-memory" test, and I can certainly provide one.
> >> But this topic is for another mainling list.
> >
> > Yes hmm not sure where to put the qmp test, I just know that Markus does
> > like them (I think he's out this week).
>
> The best time to start requiring tests for new QMP commands is when the
> first command is added.  We missed that opportunity.  The second best
> time is right now[*].
>
> The QMP equivalent to test-hmp.c's test_info_commands() would be good
> enough for query-FOOs that can't fail.  We should have that.  It's not
> fair to ask you to write it.  Not least because doing it right involves
> introspection, which is going to be a bit hairy.  I guess I'll have to
> do it myself[**].
>
> However, your query-memory looks like it could fail.  Failure modes need
> to be covered by test cases.  Please either explain why it can't
> actually fail, or explain why testing the failure isn't practical, or
> write a suitable test.  A mere sketch hacked into qmp-test.c is
> perfectly okay, we can take it from there together.
>
>
>
> [*] Or rather last March:
> Message-ID: <871sugkrw5.fsf@dusky.pond.sub.org>
> https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg00296.html
>
> [**] Surprise me!  Patches welcome :)
>
