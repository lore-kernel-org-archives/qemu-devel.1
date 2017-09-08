Received: from eggs.gnu.org ([2001:4830:134:3::10]:60956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fedora.dm0@gmail.com>) id 1dqKct-0004S7-6r
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:51:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fedora.dm0@gmail.com>) id 1dqKcr-0007mF-Ul
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:51:23 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:34494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fedora.dm0@gmail.com>)
	id 1dqKcr-0007jT-Q4
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:51:21 -0400
Received: by mail-oi0-x244.google.com with SMTP id a197so1958036oib.1
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 07:51:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170908094002.GH3609@redhat.com>
References: <20170831142430.16665-1-berrange@redhat.com>
	<87r2vhfsc2.fsf@dusky.pond.sub.org>
	<20170908094002.GH3609@redhat.com>
From: David Michael <fedora.dm0@gmail.com>
Date: Fri, 8 Sep 2017 07:51:19 -0700
Message-ID: <CAEvUa7=wy5Ujfek51LfqYp2iT7h2kieDjN7p5Zna8_bPFdUxdA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 0/5] qapi: support py2 & py3 in parallel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

On Fri, Sep 8, 2017 at 2:40 AM, Daniel P. Berrange <berrange@redhat.com> wrote:
> On Fri, Sep 08, 2017 at 11:33:01AM +0200, Markus Armbruster wrote:
>> "Daniel P. Berrange" <berrange@redhat.com> writes:
>>
>> > Since I claimed that supporting py2 & py3 in parallel would be easy
>> > for QEMU, I figured I ought to actually give it a try to backup that
>> > assertion.
>> >
>> > This small patch series is the result of that effort. I tested this
>> > series on Fedora 26 using 2.7.13 and Python 3.6.2.
>> >
>> > To test with py3, I hacked config-host.mak to change the PYTHON
>> > variable to point to 'python3' binary, then compared the following
>> > generated content for the files:
>> >
>> >    qmp-commands.h qapi-types.h  qapi-visit.h  qapi-event.h
>> >    qmp-marshal.c qapi-types.c qapi-visit.c qapi-event.c
>> >    qmp-introspect.c qmp-introspect.h
>> >
>> > with that generated under py2 to see they are identical.
>> >
>> > It is possible there's still more bugs hiding that could impact
>> > on 2.6 or earlier versions of 3.x or 2.7.x, so this probably
>> > needs a bit wider testing, but I think the series illustrates
>> > the broad scope of the changes we can expect. Only the need
>> > to adapt to different module import locations adds to the
>> > line count, and that's fairly minimal.
>>
>> This hasn't made it to the front of my review queue, but I got a quick
>> question meanwhile.
>>
>> I guess this was triggered by the discussion of David's "[PATCH]
>> scripts: Support building with Python 3".  How does it differ from
>> David's patch?  Is it derived from it?  Or is it an independently
>> developed replacement?
>
> I didn't notice David's existed. In terms of the qapi file changes,
> his patch appears equivelent to combining my patches 2->5.
>
> He didn't seem to convert the print statement to a print function
> though (my patch 1), so I'm surprised his changes actually work
> with py3...

It looks like all of those qapi.py print statements are for handling
errors, so my builds must not have hit any of them.  I had skimmed the
output of pylint for errors, and it seems the print statements are
only listed as warnings when printing to stderr, which I had
overlooked.

    W:1945, 8: Expression "((print) >> (sys.stderr), ('%s: %s') %
((sys.argv[0], str(err))))" is assigned to nothing
(expression-not-assigned

And instead of importing the print function, I just switched to
sys.stderr.write etc. in qapi2texi.py.

Thanks.

David
