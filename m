Received: from eggs.gnu.org ([2001:4830:134:3::10]:42720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fRCbP-0004Z4-K4
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:18:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fRCbL-0005X4-MC
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:18:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60360 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fRCbL-0005WF-I7
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:18:27 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180604080630.10946-1-peterx@redhat.com>
	<87tvqeyfs2.fsf@dusky.pond.sub.org> <20180608044235.GA7736@xz-mi>
	<20180608080446.GH29183@stefanha-x1.localdomain>
Date: Fri, 08 Jun 2018 10:18:25 +0200
In-Reply-To: <20180608080446.GH29183@stefanha-x1.localdomain> (Stefan
	Hajnoczi's message of "Fri, 8 Jun 2018 09:04:46 +0100")
Message-ID: <87a7s5snce.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] monitor: postpone
 monitor_qmp_cleanup_queues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Peter Xu <peterx@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?M?= =?utf-8?Q?arc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, "Dr . David
	Alan Gilbert" <dgilbert@redhat.com>

Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Fri, Jun 08, 2018 at 12:42:35PM +0800, Peter Xu wrote:
>> On Thu, Jun 07, 2018 at 01:53:01PM +0200, Markus Armbruster wrote:
>> > Peter Xu <peterx@redhat.com> writes:
>> >=20
>> > > Previously we cleanup the queues when we got CLOSED event.  It was u=
sed
>> >=20
>> > we clean up
>> >=20
>> > > to make sure we won't leftover replies/events of a old client to a n=
ew
>> >=20
>> > we won't send leftover replies/events of an old client
>> >=20
>> > > client.  Now this patch postpones that until OPENED.
>> >=20
>> > What if OPENED never comes?
>>=20
>> Then we clean that up until destruction of the monitor.  IMHO it's
>> fine, but I'm not sure whether that's an overall acceptable approach.
>
> I think this patch fixes the problem at the wrong level.  Marc-Andr=C3=A9=
's
> fix seemed like a cleaner solution.

Is it the right solution?

I proposed another one:

[...]
>> > Here's what I think we should do on such EOF:
>> >=20
>> > 1. Shut down input
>> >=20
>> >    Stop reading input.  If input has its own file descriptor (as oppos=
ed
>> >    to a read/write fd shared with output), close it.
>> >=20
>> > 2. Flush output
>> >=20
>> >    Continue to write output until the queue becomes empty or we run in=
to
>> >    an error (such as EPIPE, telling us the output's consumer went away=
).
>> >    Works exactly as before, except we proceed to step 3 when the queue

exactly as before EOF

>> >    becomes empty.
>> >=20
>> > 3. Shut down output
>> >=20
>> >    Close the output file descriptor.
