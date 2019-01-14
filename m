Received: from eggs.gnu.org ([209.51.188.92]:34566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gj08D-00021i-W2
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:10:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gj08C-0005kf-5q
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:10:13 -0500
Received: from mail.ispras.ru ([83.149.199.45]:41298)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gj08B-0005dy-UX
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:10:12 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <154703587757.13472.3898702635363120794.stgit@pasha-VirtualBox>
	<154703599022.13472.1704009113561450219.stgit@pasha-VirtualBox>
	<20190111104923.GD5010@dhcp-200-186.str.redhat.com>
In-Reply-To: <20190111104923.GD5010@dhcp-200-186.str.redhat.com>
Date: Mon, 14 Jan 2019 14:10:09 +0300
Message-ID: <001001d4abf9$b6ea93e0$24bfbba0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v9 19/21] replay: add BH oneshot event for
 block layer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Kevin Wolf' <kwolf@redhat.com>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, artem.k.pisarenko@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, mreitz@redhat.com, maria.klimushenkova@ispras.ru, kraxel@redhat.com, thomas.dullien@googlemail.com, pbonzini@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

> From: Kevin Wolf [mailto:kwolf@redhat.com]
> Am 09.01.2019 um 13:13 hat Pavel Dovgalyuk geschrieben:
> > Replay is capable of recording normal BH events, but sometimes
> > there are single use callbacks scheduled with aio_bh_schedule_oneshot
> > function. This patch enables recording and replaying such callbacks.
> > Block layer uses these events for calling the completion function.
> > Replaying these calls makes the execution deterministic.
> >
> > Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> 
> This still doesn't come even close to catching all BHs that need to be
> caught. While you managed to show a few BHs that actually don't need to
> be considered for recording when I asked for this in v7, most BHs in the
> block layer can in some way lead to device callbacks and must therefore
> be recorded.

Let's have a brief review. I can change all the places, but how
should I make a test case to be sure, that all of them are working ok?

aio_bh_schedule_oneshot is used in:
 - blk_abort_aio_request
 - bdrv_co_yield_to_drain
 - iscsi_co_generic_cb
 - nfs_co_generic_cb
 - null_aio_common
 - nvme_process_completion
 - nvme_rw_cb
 - rbd_finish_aiocb
 - vxhs_iio_callback
 - (and couple of others not in the block layer)

We must change this call to replay_bh_schedule_oneshot_event when
the result of the BH execution affects the replayed guest state
(e.g., interrupt request is generated or memory is written)

If you think that all of these can do that, then I should change
such function calls.

> How bad would it be to record some BHs even if recording them isn't
> necessary? I'd definitely try to err on the safe side here. Having two
> different sets of BH functions, you can't expect that people always use
> the right one (especially if you don't even make the existing code base
> consistently use the right one intially).

There are two possible options:
1. Execution hangs when recording. Kind of deadlock caused by the incorrect
   management of the events. E.g., adding stopping the VM and trying to flush
   the block layer queue.
2. Execution hangs when replaying. 
   One of the events that affect the guest state is missed or generated
   at the other moment (e.g., when BH is not linked to the execution step).
   Then the guest behaves differently and the order of the events in the log
   does not match the guest state (e.g., interrupt processing is not matched).

Pavel Dovgalyuk
