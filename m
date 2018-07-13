Received: from eggs.gnu.org ([2001:4830:134:3::10]:58070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1fdx3C-0006Ky-M3
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 08:19:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1fdx3B-0004tc-MD
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 08:19:54 -0400
Date: Fri, 13 Jul 2018 14:19:45 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20180713121945.GE1933@paraplu>
References: <20180704145410.794-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704145410.794-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] throttle-groups: fix hang
 when group member leaves
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Wed, Jul 04, 2018 at 03:54:10PM +0100, Stefan Hajnoczi wrote:
> Throttle groups consist of members sharing one throttling state
> (including bps/iops limits).  Round-robin scheduling is used to ensure
> fairness.  If a group member already has a timer pending then other
> groups members do not schedule their own timers.  The next group member
> will have its turn when the existing timer expires.
> 
> A hang may occur when a group member leaves while it had a timer
> scheduled.  Although the code carefully removes the group member from
> the round-robin list, it does not schedule the next member.  Therefore
> remaining members continue to wait for the removed member's timer to
> expire.
> 
> This patch schedules the next request if a timer is pending.
> Unfortunately the actual bug is a race condition that I've been unable
> to capture in a test case.
> 
> Sometimes drive2 hangs when drive1 is removed from the throttling group:
> 
>   $ qemu ... -drive if=none,id=drive1,cache=none,format=qcow2,file=data1.qcow2,iops=100,group=foo \
>              -device virtio-blk-pci,id=virtio-blk-pci0,drive=drive1 \
>              -drive if=none,id=drive2,cache=none,format=qcow2,file=data2.qcow2,iops=10,group=foo \
>              -device virtio-blk-pci,id=virtio-blk-pci1,drive=drive2
>   (guest-console1)# fio -filename /dev/vda 4k-seq-read.job
>   (guest-console2)# fio -filename /dev/vdb 4k-seq-read.job
>   (qmp) {"execute": "block_set_io_throttle", "arguments": {"device": "drive1","bps": 0,"bps_rd": 0,"bps_wr": 0,"iops": 0,"iops_rd": 0,"iops_wr": 0}}

Hi Stefan,

I realize you want to preserve the long lines to not break the JSON QMP
command.  But, FWIW, you might want to format it using one of the
convenient websites: https://jsonformatter.org/

So your QMP command nicely wraps (for the 'cost' of 11 extra lines):

    {
      "execute": "block_set_io_throttle",
      "arguments": {
        "device": "drive1",
        "bps": 0,
        "bps_rd": 0,
        "bps_wr": 0,
        "iops": 0,
        "iops_rd": 0,
        "iops_wr": 0
      }
    }


[...]

-- 
/kashyap
