Received: from eggs.gnu.org ([2001:4830:134:3::10]:46571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e1pUf-0000tY-3a
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 04:02:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e1pUd-0001OR-RQ
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 04:02:25 -0400
Date: Tue, 10 Oct 2017 10:02:01 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171010080201.GB4177@dhcp-200-186.str.redhat.com>
References: <CAEfK_45dZvxvBNQpPLo71ZJhrPN5_GJr8uJ2pJZpCaFf0+i3YA@mail.gmail.com>
	<62e835a4-ba5d-e620-47d2-180932a33426@redhat.com>
	<20171006135425.GF26575@redhat.com>
	<CAEfK_444_fPwjnj1M8w8XNFFwiMJW-pdN7R1Tdu+FfvB38ZBtw@mail.gmail.com>
	<20171006140137.GH26575@redhat.com>
	<CAEfK_455Hr1afv-H6=9QMQErDGZJtOBgFMk2F8QJshYTLgOa1Q@mail.gmail.com>
	<e46a6b2d-83e2-d558-028c-94ad41af8fa2@redhat.com>
	<CAEfK_44_43d5_KaGUf-FH7bHxre5BP1wCQu96p38bhskUqU+Ug@mail.gmail.com>
	<87h8v7lcan.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h8v7lcan.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] Patch to add helpful tracing output for driver
 authors in NVMe emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Doug Gale <doug16k@gmail.com>, Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel <qemu-devel@nongnu.org>, mreitz@redhat.com, keith.busch@intel.com

Am 10.10.2017 um 08:58 hat Markus Armbruster geschrieben:
> Doug Gale <doug16k@gmail.com> writes:
> 
> > I used exclamations as a concise way of indicating that the driver did
> > something nonsensical, or horribly invalid, like something likely to
> > cause a memory corruption, trying to start the controller with a
> > nonsense configuration, providing invalid PRDs or writing to
> > unrecognized MMIO offsets that might hang or do something extremely
> > bad on a poorly implemented controller. Exclaiming is not shouting, I
> > thought shouting was when it was all uppercase.
> >
> > If a driver might trash memory or hang a controller, maybe it should
> > shout at the driver author or person investigating an unstable VM.
> > None of those messages with exclamations should ever happen. If any of
> > them are possible when the driver is correct, then I have made a
> > mistake.
> 
> Please do not top-quote on this mailing list.
> 
> Existing tracepoints do not use exclamation marks to signal severity.
> 
> Consider using assertions for "if this happens, either the program's
> state is shot (and continuing is unsafe), or the author's mental state
> was shot (and continuing is probably unsafe, too)" conditions.
> Tracepoints are for tracing.

Assertions are for checking that assumptions in qemu code hold true.
Here it's about bad guest code, and you can't let qemu abort for that.

Tracing is the right tool to detect bad guest code, and I think it makes
sense to mark conditions that shouldn't happen with a correctly
operating guest driver. I'm not sure if an exclamation mark is the best
syntax for this, because I wouldn't have intuitively understood what
it's supposed to tell me.

If we do use the exclamation mark, we should document it somewhere
(docs/devel/tracing.txt?) and make it a qemu-wide pattern. If not, we
should choose something else and still document it and use it
consistently.

Kevin

> > On Mon, Oct 9, 2017 at 11:52 AM, Eric Blake <eblake@redhat.com> wrote:
> >> On 10/07/2017 02:51 AM, Doug Gale wrote:
> >>> Completely re-implemented patch, with significant improvements (now
> >>> specifies values in several places I missed, also reduced the amount
> >>> of redundant lines). I used the nvme_ as the tracing infrastructure
> >>> prefix. Tested with -trace nvme_* on the qemu command line, worked for
> >>> me.
> >>
> >> This information belongs...
> >>
> >>>
> >>>>From 166f57458d60d363a10a0933c3e860985531ac96 Mon Sep 17 00:00:00 2001
> >>> From: Doug Gale <doug16k@gmail.com>
> >>> Date: Thu, 5 Oct 2017 19:02:03 -0400
> >>> Subject: [PATCH] Add tracing output to NVMe emulation to help driver authors.
> >>>
> >>> This uses the tracing infrastructure using nvme_ as the prefix.
> >>>
> >>> Signed-off-by: Doug Gale <doug16k@gmail.com>
> >>> ---
> >>
> >> ...here, after the --- separator.  It is useful to the patch reviewer,
> >> but does not need to be in the 'git log' history.  The maintainers use
> >> 'git am' to process incoming patches, which automatically prunes review
> >> comments located in this location.
> >>
> >> Also, since this is a version 2 patch, it is best if your subject line
> >> includes 'v2', and if you send the patch as a new top-level thread
> >> rather than in-reply-to v1.  This can be done with 'git send-email -v2'.
> >>
> >> The subject line is atypical; we tend to prefer 'topic: Short summary',
> >> where you are missing the topic, you had a trailing dot that is not
> >> typical, and where your line is longer than usual.  A better subject
> >> line might be:
> >>
> >> nvme: Add tracing output
> >>
> >>
> >> For more helpful information on patch submission:
> >>
> >> https://wiki.qemu.org/Contribute/SubmitAPatch
> >>
> >> I didn't look closely at the patch itself, but did notice:
> >>
> >>> +nvme_mmio_start_failed(void) "setting controller enable bit failed!"
> >>> +nvme_mmio_start_success(void) "setting controller enable bit succeeded"
> >>> +nvme_mmio_stopped(void) "cleared controller enable bit"
> >>> +nvme_mmio_shutdown_set(void) "shutdown bit set"
> >>> +nvme_mmio_shutdown_cleared(void) "shutdown bit cleared"
> >>> +nvme_mmio_ignored(uint64_t offset, uint64_t data) "invalid MMIO
> >>> write, offset=0x%"PRIx64", data=%"PRIx64"!"
> >>
> >> You have a couple of traces with a trailing '!'; that is atypical,
> >> because we don't need our traces to shout at the user.
