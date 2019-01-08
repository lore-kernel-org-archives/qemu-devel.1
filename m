Received: from eggs.gnu.org ([209.51.188.92]:41810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ggrIs-0007Ax-4Z
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 08:20:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ggrIp-0001xa-Jm
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 08:20:21 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181221165341.23736-1-vsementsov@virtuozzo.com>
	<20181221165341.23736-2-vsementsov@virtuozzo.com>
Date: Tue, 08 Jan 2019 14:20:07 +0100
In-Reply-To: <20181221165341.23736-2-vsementsov@virtuozzo.com> (Vladimir
	Sementsov-Ogievskiy's message of "Fri, 21 Dec 2018 19:53:40 +0300")
Message-ID: <875zuznv5k.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, eblake@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, nshirokovskiy@virtuozzo.com, pizhenwei@bytedance.com

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> Move to way of device selecting, however fall back to device name if
> path is not found.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  qapi/block-core.json |  4 ++--
>  blockdev.c           | 22 +++++++++++++++-------
>  2 files changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 762000f31f..bb70c51a57 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -489,7 +489,7 @@
>  # If only @device parameter is specified, remove all present latency histograms
>  # for the device. Otherwise, add/reset some of (or all) latency histograms.
>  #
> -# @device: device name to set latency histogram for.
> +# @id: The QOM path or name of the guest device.
>  #
>  # @boundaries: list of interval boundary values (see description in
>  #              BlockLatencyHistogramInfo definition). If specified, all

Is such overloaded semantics what we want in new interfaces?

Hmm, looks like there's ample precedence for it.  Escaped my grep at
first because its commonly documented as "The name or QOM path of the
guest device".  Suggest to stick to that for consistency.

> @@ -547,7 +547,7 @@
>  # <- { "return": {} }
>  ##
>  { 'command': 'x-block-latency-histogram-set',
> -  'data': {'device': 'str',
> +  'data': {'id': 'str',
>             '*boundaries': ['uint64'],
>             '*boundaries-read': ['uint64'],
>             '*boundaries-write': ['uint64'],
[...]
