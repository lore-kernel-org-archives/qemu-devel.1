Received: from eggs.gnu.org ([2001:4830:134:3::10]:55926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1cbffp-0003rZ-7I
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 22:45:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1cbffo-0006h8-8h
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 22:45:33 -0500
Received: from mail-ua0-x236.google.com ([2607:f8b0:400c:c08::236]:34167)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eswierk@skyportsystems.com>)
	id 1cbffo-0006h0-07
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 22:45:32 -0500
Received: by mail-ua0-x236.google.com with SMTP id 35so125383048uak.1
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 19:45:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170209025212.GG22807@lemon.lan>
References: <CAO_EM_m9Z7WcxRZthAGgeDgJ6UuwKXwAOEH7NC2=hL8Cd4jABg@mail.gmail.com>
	<20170209014728.GF22807@lemon.lan>
	<CAO_EM_mJYNoxTLjKmTy18JhrL_zs_VLA32Y=Cw+LYqAGPzLN=w@mail.gmail.com>
	<20170209025212.GG22807@lemon.lan>
From: Ed Swierk <eswierk@skyportsystems.com>
Date: Wed, 8 Feb 2017 19:44:50 -0800
Message-ID: <CAO_EM_kh1mQZNhjRKi458u15kj0G6t=UEFBvM+wWhOX1fyi6VQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] virtio-scsi-pci iothread spins at 100%
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com

On Wed, Feb 8, 2017 at 6:52 PM, Fam Zheng <famz@redhat.com> wrote:
> This means virtio-scsi event vq handler is returning true but actually no
> progress is made. Can you try the following patch to see if it's because a
> stalled cache of VQ index?
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 6365706..7f7ab57 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2126,7 +2126,7 @@ static bool virtio_queue_host_notifier_aio_poll(void *opaque)
>      EventNotifier *n = opaque;
>      VirtQueue *vq = container_of(n, VirtQueue, host_notifier);
>
> -    if (virtio_queue_empty(vq)) {
> +    if (vring_avail_idx(vq) == vq->last_avail_idx) {
>          return false;
>      }

I tried this change but the behavior is the same, unfortunately.

--Ed
