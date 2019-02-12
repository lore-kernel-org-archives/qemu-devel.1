Received: from eggs.gnu.org ([209.51.188.92]:57322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gtU9V-00040H-AH
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 04:14:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gtU2V-00078V-8b
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 04:07:40 -0500
Date: Tue, 12 Feb 2019 10:07:20 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190212090720.GA5283@localhost.localdomain>
References: <20181221165341.23736-1-vsementsov@virtuozzo.com>
	<20181221165341.23736-2-vsementsov@virtuozzo.com>
	<20190211175410.GI8135@linux.fritz.box>
	<77422700-9c39-7b8a-33d0-efe666c4242d@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77422700-9c39-7b8a-33d0-efe666c4242d@virtuozzo.com>
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "eblake@redhat.com" <eblake@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, Denis Lunev <den@virtuozzo.com>, Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>, "pizhenwei@bytedance.com" <pizhenwei@bytedance.com>

Am 11.02.2019 um 19:30 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 11.02.2019 20:54, Kevin Wolf wrote:
> > Am 21.12.2018 um 17:53 hat Vladimir Sementsov-Ogievskiy geschrieben:
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
> >> @@ -547,7 +547,7 @@
> >>   # <- { "return": {} }
> >>   ##
> >>   { 'command': 'x-block-latency-histogram-set',
> >> -  'data': {'device': 'str',
> >> +  'data': {'id': 'str',
> >>              '*boundaries': ['uint64'],
> >>              '*boundaries-read': ['uint64'],
> >>              '*boundaries-write': ['uint64'],
> >> diff --git a/blockdev.c b/blockdev.c
> >> index a6f71f9d83..ff0d8ded5e 100644
> >> --- a/blockdev.c
> >> +++ b/blockdev.c
> >> @@ -4397,21 +4397,29 @@ void qmp_x_blockdev_set_iothread(const char *node_name, StrOrNull *iothread,
> >>   }
> >>   
> >>   void qmp_x_block_latency_histogram_set(
> >> -    const char *device,
> >> +    const char *id,
> >>       bool has_boundaries, uint64List *boundaries,
> >>       bool has_boundaries_read, uint64List *boundaries_read,
> >>       bool has_boundaries_write, uint64List *boundaries_write,
> >>       bool has_boundaries_flush, uint64List *boundaries_flush,
> >>       Error **errp)
> >>   {
> >> -    BlockBackend *blk = blk_by_name(device);
> >>       BlockAcctStats *stats;
> >>       int ret;
> >> +    Error *local_err = NULL;
> >> +    BlockBackend *blk = blk_by_qdev_id(id, &local_err);
> >>   
> >>       if (!blk) {
> >> -        error_setg(errp, "Device '%s' not found", device);
> >> -        return;
> >> +        blk = blk_by_name(id);
> >> +        if (!blk) {
> >> +            error_propagate(errp, local_err);
> >> +            return;
> >> +        } else {
> >> +            error_free(local_err);
> >> +            local_err = NULL;
> >> +        }
> >>       }
> > 
> > Why don't you use qmp_get_blk() here?
> > 
> 
> qmp_get_blk is used for cases when we have both @device and @id parameters, where @device is deprecated.
> 
> And one of previous iteration was a try to do it in this way (have both @id and @device). But it was
> considered to be bad idea for a new command, which don't need any backward compatibility. And we decided
> to merge two variants in @id.

Ah, right I missed that you dropped @device and just noticed that this
looks different from other commands. Calling blk_by_qdev_id() directly
makes sense then.

> So, do you suggest to drop blk_by_name() variant at all, and go through qmp_get_blk(NULL, id), which
> will call blk_by_qdev_id() and fail if not found?

Yes, we don't need the blk_by_name() path, it's only for the legacy
@device options.

In any case, you can't use the same option for blk_by_name() and
blk_by_qdev_id(). They are separate namespaces and the name could exist
in both of them. This is why the other commands have both @id and
@device instead of just a single option.

Kevin
