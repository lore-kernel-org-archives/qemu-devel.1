Received: from eggs.gnu.org ([209.51.188.92]:52121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gmF7m-0005zx-NL
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 04:47:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gmF7l-0004yE-Oi
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 04:47:10 -0500
References: <cover.1548171741.git.berto@igalia.com>
	<6ad371df66eecffccce29a0bd14695f40edd6120.1548171741.git.berto@igalia.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <735410dc-a63e-6a28-4526-2caa810a797d@redhat.com>
Date: Wed, 23 Jan 2019 10:46:54 +0100
MIME-Version: 1.0
In-Reply-To: <6ad371df66eecffccce29a0bd14695f40edd6120.1548171741.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] virtio-scsi: Forbid devices with
 different iothreads sharing a blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 22/01/19 16:53, Alberto Garcia wrote:
> This patch forbids attaching a disk to a SCSI device if its using a
> different AioContext. Test case included.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>

Should this be handled in common code?  However, everything else looks
good.  Thanks!

Paolo

> ---
>  hw/scsi/virtio-scsi.c      |  7 +++++++
>  tests/qemu-iotests/240     | 22 ++++++++++++++++++++++
>  tests/qemu-iotests/240.out | 20 ++++++++++++++++++++
>  3 files changed, 49 insertions(+)
> 
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index e1f7b208c7..eb90288f47 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -791,9 +791,16 @@ static void virtio_scsi_hotplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>      SCSIDevice *sd = SCSI_DEVICE(dev);
>  
>      if (s->ctx && !s->dataplane_fenced) {
> +        AioContext *ctx;
>          if (blk_op_is_blocked(sd->conf.blk, BLOCK_OP_TYPE_DATAPLANE, errp)) {
>              return;
>          }
> +        ctx = blk_get_aio_context(sd->conf.blk);
> +        if (ctx != s->ctx && ctx != qemu_get_aio_context()) {
> +            error_setg(errp, "Cannot attach a blockdev that is using "
> +                       "a different iothread");
> +            return;
> +        }
>          virtio_scsi_acquire(s);
>          blk_set_aio_context(sd->conf.blk, s->ctx);
>          virtio_scsi_release(s);
> diff --git a/tests/qemu-iotests/240 b/tests/qemu-iotests/240
> index 5d499c9a00..65cc3b39b1 100755
> --- a/tests/qemu-iotests/240
> +++ b/tests/qemu-iotests/240
> @@ -101,6 +101,28 @@ run_qemu <<EOF
>  { "execute": "quit"}
>  EOF
>  
> +echo
> +echo === Attach two SCSI disks using the same block device but different iothreads ===
> +echo
> +
> +run_qemu <<EOF
> +{ "execute": "qmp_capabilities" }
> +{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "node-name": "hd0", "read-only": true}}
> +{ "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "iothread0"}}
> +{ "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "iothread1"}}
> +{ "execute": "device_add", "arguments": {"id": "scsi0", "driver": "${virtio_scsi}", "iothread": "iothread0"}}
> +{ "execute": "device_add", "arguments": {"id": "scsi1", "driver": "${virtio_scsi}", "iothread": "iothread1"}}
> +{ "execute": "device_add", "arguments": {"id": "scsi-hd0", "driver": "scsi-hd", "drive": "hd0", "bus": "scsi0.0"}}
> +{ "execute": "device_add", "arguments": {"id": "scsi-hd1", "driver": "scsi-hd", "drive": "hd0", "bus": "scsi1.0"}}
> +{ "execute": "device_del", "arguments": {"id": "scsi-hd0"}}
> +{ "execute": "device_add", "arguments": {"id": "scsi-hd1", "driver": "scsi-hd", "drive": "hd0", "bus": "scsi1.0"}}
> +{ "execute": "device_del", "arguments": {"id": "scsi-hd1"}}
> +{ "execute": "device_del", "arguments": {"id": "scsi0"}}
> +{ "execute": "device_del", "arguments": {"id": "scsi1"}}
> +{ "execute": "blockdev-del", "arguments": {"node-name": "hd0"}}
> +{ "execute": "quit"}
> +EOF
> +
>  # success, all done
>  echo "*** done"
>  rm -f $seq.full
> diff --git a/tests/qemu-iotests/240.out b/tests/qemu-iotests/240.out
> index 701cb5c7d2..d76392966c 100644
> --- a/tests/qemu-iotests/240.out
> +++ b/tests/qemu-iotests/240.out
> @@ -31,4 +31,24 @@ QMP_VERSION
>  {"return": {}}
>  {"return": {}}
>  {"return": {}}
> +
> +=== Attach two SCSI disks using the same block device but different iothreads ===
> +
> +Testing:
> +QMP_VERSION
> +{"return": {}}
> +{"return": {}}
> +{"return": {}}
> +{"return": {}}
> +{"return": {}}
> +{"return": {}}
> +{"return": {}}
> +{"error": {"class": "GenericError", "desc": "Cannot attach a blockdev that is using a different iothread"}}
> +{"return": {}}
> +{"return": {}}
> +{"return": {}}
> +{"return": {}}
> +{"return": {}}
> +{"return": {}}
> +{"return": {}}
>  *** done
> 
