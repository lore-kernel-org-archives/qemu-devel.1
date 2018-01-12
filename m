Received: from eggs.gnu.org ([2001:4830:134:3::10]:48245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZyvD-0003L3-JC
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:59:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZyv9-0002h2-Ml
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:58:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eZyv9-0002fy-DF
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:58:55 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 781165F7B2
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 12:58:54 +0000 (UTC)
References: <20180112123453.yhc3vmar7iv5i4pz@sirius.home.kraxel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b08c64c2-3f50-814f-1ba1-a0f41d914f28@redhat.com>
Date: Fri, 12 Jan 2018 13:58:48 +0100
MIME-Version: 1.0
In-Reply-To: <20180112123453.yhc3vmar7iv5i4pz@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] booting uefi guests from virtio-scsi is broken
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>

On 12/01/2018 13:34, Gerd Hoffmann wrote:
>   Hi,
> 
> $subject says all.  bisect blames:
> 
> commit f68d98b21fa74155dc7c1fd212474379ac3c7531
> Author: Paolo Bonzini <pbonzini@redhat.com>
> Date:   Mon Nov 27 13:27:41 2017 +0100
> 
>     scsi: provide general-purpose functions to manage sense data
>     
>     Extract the common parts of scsi_sense_buf_to_errno, scsi_convert_sense
>     and scsi_target_send_command's REQUEST SENSE handling into two new
>     functions scsi_parse_sense_buf and scsi_build_sense_buf.
>     
>     Fix a bug in scsi_target_send_command along the way; the length was
>     written in buf[10] rather than buf[7].
>     
>     Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>     Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>     Fixes: b07fbce634 ("scsi-bus: correct responses for INQUIRY and REQUEST SENSE")
>     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> gdb:
> 
> Program received signal SIGSEGV, Segmentation fault.
> x000055b2a3ba9e32 in scsi_convert_sense (in_buf=0x0, in_len=0, buf=0x55b2a63fa000 "", len=4096, 
>     fixed=true) at /home/kraxel/projects/qemu/scsi/utils.c:325
> 325         fixed_in = (in_buf[0] & 2) == 0;
> 
> (gdb) bt
> #0  0x000055b2a3ba9e32 in scsi_convert_sense (in_buf=0x0, in_len=0, buf=0x55b2a63fa000 "", len=4096, fixed=true) at /home/kraxel/projects/qemu/scsi/utils.c:325
> #1  0x000055b2a39e5350 in scsi_disk_emulate_command (req=0x55b2a66c45e0, buf=0x55b2a66c4618 "\003")
>     at /home/kraxel/projects/qemu/hw/scsi/scsi-disk.c:2007
> #2  0x000055b2a39ec5d0 in scsi_req_enqueue (req=0x55b2a66c45e0)
>     at /home/kraxel/projects/qemu/hw/scsi/scsi-bus.c:832
> #3  0x000055b2a377a0f6 in virtio_scsi_handle_cmd_req_submit (s=0x55b2a6c78fb0, req=0x55b2a67c1c00)
>     at /home/kraxel/projects/qemu/hw/scsi/virtio-scsi.c:579
> #4  0x000055b2a377a337 in virtio_scsi_handle_cmd_vq (s=0x55b2a6c78fb0, vq=0x7f0f36c7a110)
>     at /home/kraxel/projects/qemu/hw/scsi/virtio-scsi.c:619
> #5  0x000055b2a377b686 in virtio_scsi_data_plane_handle_cmd (vdev=0x55b2a6c78fb0, vq=0x7f0f36c7a110) at /home/kraxel/projects/qemu/hw/scsi/virtio-scsi-dataplane.c:60
> #6  0x000055b2a379cfe8 in virtio_queue_notify_aio_vq (vq=0x7f0f36c7a110)
>     at /home/kraxel/projects/qemu/hw/virtio/virtio.c:1515
> #7  0x000055b2a379f124 in virtio_queue_host_notifier_aio_read (n=0x7f0f36c7a178)
>     at /home/kraxel/projects/qemu/hw/virtio/virtio.c:2388
> #8  0x000055b2a3c33f9b in aio_dispatch_handlers (ctx=0x55b2a584fce0)
>     at /home/kraxel/projects/qemu/util/aio-posix.c:406
> #9  0x000055b2a3c3412e in aio_dispatch (ctx=0x55b2a584fce0)
>     at /home/kraxel/projects/qemu/util/aio-posix.c:437
> #10 0x000055b2a3c2fc76 in aio_ctx_dispatch (source=0x55b2a584fce0, callback=0x0, user_data=0x0)
>     at /home/kraxel/projects/qemu/util/async.c:261
> #11 0x00007f0f56ef34c9 in g_main_context_dispatch () at /lib64/libglib-2.0.so.0
> #12 0x000055b2a3c32a86 in glib_pollfds_poll () at /home/kraxel/projects/qemu/util/main-loop.c:214
> #13 0x000055b2a3c32b77 in os_host_main_loop_wait (timeout=191617699)
>     at /home/kraxel/projects/qemu/util/main-loop.c:261
> #14 0x000055b2a3c32c33 in main_loop_wait (nonblocking=0)
>     at /home/kraxel/projects/qemu/util/main-loop.c:515
> #15 0x000055b2a3860c9c in main_loop () at /home/kraxel/projects/qemu/vl.c:1950
> #16 0x000055b2a3868991 in main (argc=92, argv=0x7fff4b2f2e38, envp=0x7fff4b2f3120)
>     at /home/kraxel/projects/qemu/vl.c:4780
> 
> cheers,
>   Gerd
> 

Sent pull request today.  Thanks anyway for the warning!

Paolo
