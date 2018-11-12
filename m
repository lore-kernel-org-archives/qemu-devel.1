Received: from eggs.gnu.org ([2001:4830:134:3::10]:37125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1gMACH-0000dZ-8g
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 06:16:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1gMACD-0007de-Mr
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 06:16:01 -0500
References: <1542006398-30037-1-git-send-email-marcolso@amazon.com>
From: Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <ae033bab-004b-0ea1-bedc-04190e5a48eb@oracle.com>
Date: Mon, 12 Nov 2018 19:15:28 +0800
MIME-Version: 1.0
In-Reply-To: <1542006398-30037-1-git-send-email-marcolso@amazon.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/3] blkdebug: fix one shot rule
 processing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc Olson <marcolso@amazon.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, jsnow@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Hi Marc,

When I play with the v3 patch set, the qemu hangs again and I need to kill it
with "kill -9".

I got below from guest:

[  104.828127] nvme nvme0: I/O 52 QID 1 timeout, aborting
[  104.828470] nvme nvme0: Abort status: 0x4001

nvme abort is not supported by qemu and therefore 0x4001 (NVME_INVALID_OPCODE |
NVME_DNR) is returned. qemu does not restart the device.


Below is the environment:

host: most recent qemu (master branch) with 3 patches applied, on top of Ubuntu
16.04.4 with 4.15.0-36-generic

guest: Ubuntu 16.04.4 with 4.13.0-39-generic.


The image to emulate nvme is a 128MB raw image (ext4). I randomly run "dd
if=/dev/zero of=output bs=1M count=30" on the nvme raw image to hit the
sector="40960" with "inject-delay" enabled as shown below:

[inject-delay]
event = "write_aio"
latency = "9999999999"
sector = "40960"


sudo ./x86_64-softmmu/qemu-system-x86_64 \
-drive file=os.img,format=raw,if=none,id=disk0 \
-device
virtio-blk-pci,drive=disk0,id=device0,num-queues=2,iothread=io1,bootindex=0 \
-object iothread,id=io1 \
-smp 2 -m 2000M -enable-kvm  -vnc :0 -monitor stdio \
-device nvme,drive=nvmedrive,serial=deadbeaf1 \
-drive file=blkdebug:blkdebug.config:nvme.img,format=raw,if=none,id=nvmedrive \
-net nic -net user,hostfwd=tcp::5022-:22

I will debug where it hangs.

Dongli Zhang


On 11/12/2018 03:06 PM, Marc Olson via Qemu-devel wrote:
> If 'once' is specified, the rule should execute just once, regardless if
> it is supposed to return an error or not. Take the example where you
> want the first IO to an LBA to succeed, but subsequent IOs to fail. You
> could either use state transitions, or create two rules, one with
> error = 0 and once set to true, and one with a non-zero error.
> 
> Signed-off-by: Marc Olson <marcolso@amazon.com>
> ---
>  block/blkdebug.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blkdebug.c b/block/blkdebug.c
> index 0759452..327049b 100644
> --- a/block/blkdebug.c
> +++ b/block/blkdebug.c
> @@ -488,7 +488,7 @@ static int rule_check(BlockDriverState *bs, uint64_t offset, uint64_t bytes)
>          }
>      }
>  
> -    if (!rule || !rule->options.inject.error) {
> +    if (!rule) {
>          return 0;
>      }
>  
> @@ -500,7 +500,7 @@ static int rule_check(BlockDriverState *bs, uint64_t offset, uint64_t bytes)
>          remove_rule(rule);
>      }
>  
> -    if (!immediately) {
> +    if (error && !immediately) {
>          aio_co_schedule(qemu_get_current_aio_context(), qemu_coroutine_self());
>          qemu_coroutine_yield();
>      }
> 
