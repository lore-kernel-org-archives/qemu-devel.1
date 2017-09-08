Received: from eggs.gnu.org ([2001:4830:134:3::10]:59854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dqJBw-0002P2-CE
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:19:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dqJBv-0001JI-4M
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:19:28 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:43394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dqJBu-0001Ho-TQ
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:19:27 -0400
Received: by mail-wm0-x22f.google.com with SMTP id f145so6033315wme.0
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 06:19:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87efrhcsve.fsf@dusky.pond.sub.org>
References: <20170906105704.GC2215@work-vm> <20170906110629.GM15510@redhat.com>
	<20170906113157.GD2215@work-vm> <20170906115428.GP15510@redhat.com>
	<20170907081341.GA23040@pxdev.xzpeter.org>
	<87inguaclr.fsf@dusky.pond.sub.org>
	<20170907132259.GM30609@redhat.com> <87h8weo186.fsf@dusky.pond.sub.org>
	<20170907180900.GV2098@work-vm> <87k219fuq5.fsf@dusky.pond.sub.org>
	<20170908093212.GA2095@work-vm> <87efrhcsve.fsf@dusky.pond.sub.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 8 Sep 2017 14:19:24 +0100
Message-ID: <CAJSP0QWJPxns9N+Yi_Of39u=CJ4HyVCw2ZD=gfmB0JgfjjzewQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v2 0/8] monitor: allow per-monitor thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Xu <peterx@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>

On Fri, Sep 8, 2017 at 12:49 PM, Markus Armbruster <armbru@redhat.com> wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
>
>> * Markus Armbruster (armbru@redhat.com) wrote:
>>> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
>>>
>>> > * Markus Armbruster (armbru@redhat.com) wrote:
>>> >> "Daniel P. Berrange" <berrange@redhat.com> writes:
>>> >>
>>> >> > On Thu, Sep 07, 2017 at 02:59:28PM +0200, Markus Armbruster wrote:
>>> If we can't eliminate main loop hangs, any ideas on reducing their
>>> impact?
>>
>> Note there's two related things; main loop hangs and bql hangs; I'm not
>> sure that the two are always the same.
>>
>> Stefan mentioned some ways of doing asynchronous memory lookups/accesses
>> though I'm not sure they'd work in the postcopy case; but they'd need
>> work in lots of devices.
>> Some of the IO under the BQL might be fixable; IMHO in a lot of places
>> we don't really need the full BQL, we just need a 'you aren't going to
>> change the config' lock.
>
> This is all about reducing main loop hangs.  Another one is moving
> "slow" code out of the main loop, e.g. monitor commands.
>
> My question was aiming in a slightly different direction, however: given
> that the main loop can hang, is there anything we can do to mitigate
> known bad consequences of such hangs?

I don't think we can mitigate it completely but we can make it visible
and easier to study.

There were discussions about making the event loop observable in the
past.  In other words, logging which handler functions are firing.
That way you can debug scenarios where the loop is spinning
("main-loop: WARNING: I/O thread spun for 1000 iterations\n") and also
latency.  Collecting event handler latencies and looking at the
histogram would be interesting.  The outliers (e.g. 250+ microseconds)
are things that we should know about and consider refactoring.
