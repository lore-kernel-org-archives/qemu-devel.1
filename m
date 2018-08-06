Received: from eggs.gnu.org ([2001:4830:134:3::10]:51490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fmfjV-0002ea-Oy
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 09:39:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fmfjU-0003TY-Pk
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 09:39:37 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:34174)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fmfjU-0003TC-JG
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 09:39:36 -0400
Received: by mail-oi0-x241.google.com with SMTP id 13-v6so22241043ois.1
	for <qemu-devel@nongnu.org>; Mon, 06 Aug 2018 06:39:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180803153235.4134-1-marcandre.lureau@redhat.com>
References: <20180803153235.4134-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Aug 2018 14:39:15 +0100
Message-ID: <CAFEAcA-bM7KiPp5P5S-UAT5b6v7X0ETVqCA01WOSihTyW37WMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio-gpu: fix crashes upon warm reboot
 with vga mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

On 3 August 2018 at 16:32, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> With vga=3D775 on the Linux command line a first boot of the VM running
> Linux works fine. After a warm reboot it crashes during Linux boot.
>
> Before that, valgrind points out bad memory write to console
> surface. The VGA code is not aware that virtio-gpu got a message
> surface scanout when the display is disabled. Let's reset VGA graphic
> mode when it is the case, so that a new display surface is created
> when doing further VGA operations.
>
> https://bugs.launchpad.net/qemu/+bug/1784900/
>
> Reported-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/hw/virtio/virtio-gpu.h |  1 +
>  hw/display/virtio-gpu.c        |  5 +++++
>  hw/display/virtio-vga.c        | 11 +++++++++++
>  3 files changed, 17 insertions(+)
>
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
> index 9780f755ef..d0321672f4 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -125,6 +125,7 @@ typedef struct VirtIOGPU {
>          uint32_t bytes_3d;
>      } stats;
>
> +    void (*disable_scanout)(struct VirtIOGPU *g, int scanout_id);
>      Error *migration_blocker;
>  } VirtIOGPU;

I guess for a last-minute 3.0 fix this is ok, but it looks
a bit weird to have a function pointer in a device instance
struct, which the user of the device has reached in and
set in order to modify the behaviour of the object...

thanks
-- PMM
