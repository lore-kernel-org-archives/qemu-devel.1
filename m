Received: from eggs.gnu.org ([2001:4830:134:3::10]:41946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eegu9-000500-Fi
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 07:45:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eegu6-0001yn-OP
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 07:45:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eegu6-0001xr-Aj
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 07:45:18 -0500
Date: Thu, 25 Jan 2018 12:45:11 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180125124511.GG1776@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180125123955.4919-1-klim.kireev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180125123955.4919-1-klim.kireev@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v4] chardev/char-socket: add POLLHUP handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Klim Kireev <klim.kireev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, marcandre.lureau@redhat.com

On Thu, Jan 25, 2018 at 03:39:55PM +0300, Klim Kireev wrote:
> The following behavior was observed for QEMU configured by libvirt
> to use guest agent as usual for the guests without virtio-serial
> driver (Windows or the guest remaining in BIOS stage).
> 
> In QEMU on first connect to listen character device socket
> the listen socket is removed from poll just after the accept().
> virtio_serial_guest_ready() returns 0 and the descriptor
> of the connected Unix socket is removed from poll and it will
> not be present in poll() until the guest will initialize the driver
> and change the state of the serial to "guest connected".
> 
> In libvirt connect() to guest agent is performed on restart and
> is run under VM state lock. Connect() is blocking and can
> wait forever.
> In this case libvirt can not perform ANY operation on that VM.
> 
> The bug can be easily reproduced this way:
> 
> Terminal 1:
> qemu-system-x86_64 -m 512 -device pci-serial,chardev=serial1 -chardev socket,id=serial1,path=/tmp/console.sock,server,nowait
> (virtio-serial and isa-serial also fit)
> 
> Terminal 2:
> minicom -D unix\#/tmp/console.sock
> (type something and press enter)
> C-a x (to exit)
> 
> Do 3 times:
> minicom -D unix\#/tmp/console.sock
> C-a x
> 
> It needs 4 connections, because the first one is accepted by QEMU, then two are queued by
> the kernel, and the 4th blocks.
> 
> The problem is that QEMU doesn't add a read watcher after succesful read
> until the guest device wants to acquire recieved data, so
> I propose to install a separate pullhup watcher regardless of
> whether the device waits for data or not.
> 
> Signed-off-by: Klim Kireev <klim.kireev@virtuozzo.com>
> ---
> Changelog:
> v2: Remove timer as a redundant feature
> 
> v3: Remove read call and return G_SOURCE_REMOVE
> 
> v4: Move to GSource API
> 
>  chardev/char-socket.c | 22 ++++++++++++++++++++++
>  dtc                   |  2 +-
>  2 files changed, 23 insertions(+), 1 deletion(-)


> diff --git a/dtc b/dtc
> index e54388015a..558cd81bdd 160000
> --- a/dtc
> +++ b/dtc
> @@ -1 +1 @@
> -Subproject commit e54388015af1fb4bf04d0bca99caba1074d9cc42
> +Subproject commit 558cd81bdd432769b59bff01240c44f82cfb1a9d

Presumably accidental. You can fix this by doing

  cd dtc
  git checkout e54388015af1fb4bf04d0bca99caba1074d9cc42
  cd ..
  git add dtc
  git commit --amend

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
