Received: from eggs.gnu.org ([2001:4830:134:3::10]:51952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1d5VRs-0006cF-Bm
	for qemu-devel@nongnu.org; Tue, 02 May 2017 06:54:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1d5VRp-0003SG-AV
	for qemu-devel@nongnu.org; Tue, 02 May 2017 06:54:28 -0400
Received: from mail.ispras.ru ([83.149.199.45]:50764)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1d5VRo-0003Ro-TF
	for qemu-devel@nongnu.org; Tue, 02 May 2017 06:54:25 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20170428021317.24711-1-eblake@redhat.com>
	<20170428021317.24711-4-eblake@redhat.com>
	<87h918bmpz.fsf@dusky.pond.sub.org>
	<f0824e24-ea2b-4037-939b-2327435b4f24@redhat.com>
In-Reply-To: <f0824e24-ea2b-4037-939b-2327435b4f24@redhat.com>
Date: Tue, 2 May 2017 13:54:25 +0300
Message-ID: <001701d2c332$76ee1020$64ca3060$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] replay help [was: [PATCH v5 3/4] shutdown: Add
 source information to SHUTDOWN and RESET]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Eric Blake' <eblake@redhat.com>, 'Markus Armbruster' <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>

> From: Eric Blake [mailto:eblake@redhat.com]
> On 04/28/2017 10:01 AM, Markus Armbruster wrote:
> > Eric Blake <eblake@redhat.com> writes:
> >
> >> Libvirt would like to be able to distinguish between a SHUTDOWN
> >> event triggered solely by guest request and one triggered by a
> >> SIGTERM or other action on the host.  While qemu_kill_report() is
> >> already able to tell whether a shutdown was triggered by a host
> >> signal (but NOT by a host UI event, such as clicking the X on
> >> the window), that information was then lost after being printed
> >> to stderr.  The previous patch prepped things to use an enum
> >> internally; now it's time to wire it up through all callers, and
> >> to extend the SHUTDOWN and RESET events to report the details.
> >>
> 
> >> The replay driver needs a followup patch if we want to be able to
> >> faithfully replay the difference between a host- and guest-initiated
> >> shutdown (for now, the replayed event is always attributed to host).
> >
> > I'd prefer to get this right from the start, but that requires input
> > from replay guys.
> >
> > Scandalously, replay/ is not covered by MAINTAINERS.
> > scripts/get_maintainers.pl blames it on Pavel Dovgalyuk (cc'ed), and git
> > shows recent activity.  Pavel, please post a suitable patch to
> > MAINTAINERS, and please help us figure out what to do about replaying
> > reset here.
> 
> In particular, my questions include:
> 
> How sensitive is the enum ReplayEvents in replay-internal.h to
> additions? Do we have to worry about cross-version compatibility (where
> we can only add new events at the end), or can we reorder things at
> will?  I suspect that depends on whether you ever plan to replay a
> script recorded by old qemu while running new qemu.

There is no cross-version compatibility at all.
Changing any virtual device behavior makes whole previously recorded
replay log unusable.
Therefore we can add any events and update REPLAY_VERSION to prevent
cross-version launches.

> One idea would be to carve out a range of new enums in ReplayEvents,
> similar to how you have a range of CHECKPOINT_COUNT enums carved out;
> the range would be large enough to encode each cause of shutdown, and
> then you just map the range back into a reset request with the right
> cause. Another would be to modify the replay script file format: right
> now, it records a single byte for a shutdown request, but a single new
> enum triggers that we now read a second byte for the cause (where the
> second byte is directly the cause).  If replaying old streams matters,
> we still have to burn a new enum (so that you can tell the difference
> between old stream with no cause occupying one byte, vs. new stream with
> second byte giving the cause); if cross-version qemu doesn't matter (ie.
> upgrading qemu can invalidate all previously captured replay streams),
> then this version would better be served by repurposing the existing
> EVENT_SHUTDOWN enum in-place.

Replaying old stream does not matter.
I prefer new enum, because it will simplify comparisons and switches.

Pavel Dovgalyuk
