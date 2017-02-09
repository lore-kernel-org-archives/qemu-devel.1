Received: from eggs.gnu.org ([2001:4830:134:3::10]:33316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cbdpk-0000mG-Sc
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 20:47:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cbdpc-0004qQ-KP
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 20:47:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cbdpc-0004pf-1S
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 20:47:32 -0500
Date: Thu, 9 Feb 2017 09:47:28 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170209014728.GF22807@lemon.lan>
References: <CAO_EM_m9Z7WcxRZthAGgeDgJ6UuwKXwAOEH7NC2=hL8Cd4jABg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO_EM_m9Z7WcxRZthAGgeDgJ6UuwKXwAOEH7NC2=hL8Cd4jABg@mail.gmail.com>
Subject: Re: [Qemu-devel] virtio-scsi-pci iothread spins at 100%
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ed Swierk <eswierk@skyportsystems.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com

On Wed, 02/08 08:33, Ed Swierk wrote:
> Recently I noticed that when I configure a virtio-scsi-pci device
> using an iothread, as soon as the guest virtio-scsi driver loads, the
> iothread spins at 100%:
> 
>   -object iothread,id=iothread1 -device virtio-scsi-pci,iothread=iothread1
> 
> This occurs whether or not a disk is attached, with either
> poll-max-ns=0 or poll-max-ns=32768, and with Linux 3.13, 4.1 and 4.4
> guests. The iothread stops spinning as soon as the guest driver is
> unloaded.
> 
> I bisected the issue to commit 684e508c23d28af8d6ed2c62738a0f60447c8274:
> 
>   aio: add .io_poll_begin/end() callbacks
> 
> It doesn't seem to affect performance, but obviously consuming CPU
> cycles when there's no disk attached is undesirable. Is this an
> expected side effect of implementing iothread polling?

No, something is wrong. The polling shouldn't keep running when there is no I/O
activity.

Can you try "perf top" to see what poll handlers are spinning?

Fam
