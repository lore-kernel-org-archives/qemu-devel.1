Received: from eggs.gnu.org ([2001:4830:134:3::10]:54181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1erktk-0000H0-1Q
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:38:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1erktj-000508-1L
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:38:56 -0500
MIME-Version: 1.0
In-Reply-To: <1513690383-27269-1-git-send-email-sochin.jiang@huawei.com>
References: <1513690383-27269-1-git-send-email-sochin.jiang@huawei.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 2 Mar 2018 13:38:52 +0000
Message-ID: <CAJSP0QW1OKnRwwvxvmYaBQ3uLgvU-p9_RQqMLqj7ydwOKyevMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] virtio-blk: notify guest
 directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "sochin.jiang" <sochin.jiang@huawei.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, Yi Fang <eric.fangyi@huawei.com>, Sergio Lopez <slp@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Dec 19, 2017 at 1:33 PM, sochin.jiang <sochin.jiang@huawei.com> wrote:
>  Till now, we've already notify guest as a batch mostly, an
>  extra BH won't decrease guest interrupts much, but cause a
>  significant notification loss. Generally, we could have 15%
>  or so performance lost in single queue IO models, as I tested.

Recent performance testing has shown that virtio-blk can underperform
virtio-scsi due to the extra latency added by the BH.

The virtqueue EVENT_IDX feature mitigates interrupts when the guest
interrupt handler has not had a chance to run yet.  Therefore, virtio
already offers one level of interrupt mitigation and the BH adds
additional latency on top.

The BH helps when the guest services interrupts very quickly
(defeating EVENT_IDX mitigation) and therefore the device raises
additional interrupts.  Network drivers in Linux solve this using
NAPI, where the driver disables interrupts during periods of high
completion rates.  We could do the same inside the guest driver and it
would not suffer from BH latency.

I now think that this patch would benefit most cases, although it may
harm the case mentioned above without further patches to the
virtio_blk.ko guest driver.

Please resend the patch with fio benchmark output in the commit
description and the issue I raised fixed:

> @@ -75,7 +67,12 @@ static void notify_guest_bh(void *opaque)
>      }
>  }
>
> -/* Context: QEMU global mutex held */

Please keep this doc comment for virtio_blk_data_plane_create().

Thanks,
Stefan
