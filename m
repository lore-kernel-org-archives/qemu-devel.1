Received: from eggs.gnu.org ([209.51.188.92]:41363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gtFlH-00062P-Vh
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:52:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gtFlH-0003X1-67
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:52:55 -0500
Date: Mon, 11 Feb 2019 18:52:47 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190211175247.GH8135@linux.fritz.box>
References: <20181221165341.23736-1-vsementsov@virtuozzo.com>
	<20181221165341.23736-2-vsementsov@virtuozzo.com>
	<875zuznv5k.fsf@dusky.pond.sub.org>
	<0b69aa1d-1a17-0ac6-52d4-a7ee7bd8eb75@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b69aa1d-1a17-0ac6-52d4-a7ee7bd8eb75@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/2] qapi: move to QOM path for
 x-block-latency-histogram-set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "eblake@redhat.com" <eblake@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, Denis Lunev <den@virtuozzo.com>, Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>, "pizhenwei@bytedance.com" <pizhenwei@bytedance.com>

Am 11.02.2019 um 18:39 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 08.01.2019 16:20, Markus Armbruster wrote:
> > Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
> > 
> >> Move to way of device selecting, however fall back to device name if
> >> path is not found.
> >>
> >> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >> ---
> >>   qapi/block-core.json |  4 ++--
> >>   blockdev.c           | 22 +++++++++++++++-------
> >>   2 files changed, 17 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/qapi/block-core.json b/qapi/block-core.json
> >> index 762000f31f..bb70c51a57 100644
> >> --- a/qapi/block-core.json
> >> +++ b/qapi/block-core.json
> >> @@ -489,7 +489,7 @@
> >>   # If only @device parameter is specified, remove all present latency histograms
> >>   # for the device. Otherwise, add/reset some of (or all) latency histograms.
> >>   #
> >> -# @device: device name to set latency histogram for.
> >> +# @id: The QOM path or name of the guest device.
> >>   #
> >>   # @boundaries: list of interval boundary values (see description in
> >>   #              BlockLatencyHistogramInfo definition). If specified, all
> > 
> > Is such overloaded semantics what we want in new interfaces?
> > 
> > Hmm, looks like there's ample precedence for it.  Escaped my grep at
> > first because its commonly documented as "The name or QOM path of the
> > guest device".  Suggest to stick to that for consistency.
> 
> 
> Interesting, that in cases you mean, documentation seems wrong:
> it goes through qmp_get_blk, which works like @id may be only QOM path, not name,
> so for the it should be @id: The QOM path.

It's really a QOM path relative to /machine/peripheral (see
find_device_state()), which is where named devices live, accessible
through their id. So relative paths are both QOM paths and names of
guest devices. (Relative paths aren't a QOM concept, though, which
provides only absolute and partial paths. The relative paths have a
one-off implementation here.)

So in the end, I think the description is actually correct, just with a
higher level perspective, ignoring all the low-level details.

Kevin
