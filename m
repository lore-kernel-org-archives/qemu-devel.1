Received: from eggs.gnu.org ([2001:4830:134:3::10]:42627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYE9z-0005p1-6h
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:46:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYE9x-0000nY-UJ
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:46:27 -0500
Received: from mail-vk0-x22e.google.com ([2607:f8b0:400c:c05::22e]:34305)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cYE9x-0000nN-PA
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:46:25 -0500
Received: by mail-vk0-x22e.google.com with SMTP id r136so218178103vke.1
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:46:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170130151409.20444-1-jgross@suse.com>
References: <20170130151409.20444-1-jgross@suse.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jan 2017 15:46:04 +0000
Message-ID: <CAFEAcA_LB-+O+eDKoj1=s7xi4OsCo1dhnw9Ao48XzqZaZ91PLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] xen: use qdev_unplug() insteda of g_free()
 in xen_pv_find_xendev()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juergen Gross <jgross@suse.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, xen-devel@lists.xenproject.org, Anthony PERARD <anthony.perard@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>

On 30 January 2017 at 15:14, Juergen Gross <jgross@suse.com> wrote:
> The error exits of xen_pv_find_xendev() free the new xen-device via
> g_free() which is wrong.
>
> As the xen-device has been initialized as qdev it must be removed
> via qdev_unplug().
>
> This bug has been introduced with commit 3a6c9172ac5951e6dac2b3f6
> ("xen: create qdev for each backend device").
>
> Reported-by: Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
> Tested-by: Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  hw/xen/xen_backend.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/xen/xen_backend.c b/hw/xen/xen_backend.c
> index d119004..030772b 100644
> --- a/hw/xen/xen_backend.c
> +++ b/hw/xen/xen_backend.c
> @@ -145,7 +145,7 @@ static struct XenDevice *xen_be_get_xendev(const char=
 *type, int dom, int dev,
>      xendev->evtchndev =3D xenevtchn_open(NULL, 0);
>      if (xendev->evtchndev =3D=3D NULL) {
>          xen_pv_printf(NULL, 0, "can't open evtchn device\n");
> -        g_free(xendev);
> +        qdev_unplug(&xendev->qdev, NULL);
>          return NULL;
>      }
>      fcntl(xenevtchn_fd(xendev->evtchndev), F_SETFD, FD_CLOEXEC);
> @@ -155,7 +155,7 @@ static struct XenDevice *xen_be_get_xendev(const char=
 *type, int dom, int dev,
>          if (xendev->gnttabdev =3D=3D NULL) {
>              xen_pv_printf(NULL, 0, "can't open gnttab device\n");
>              xenevtchn_close(xendev->evtchndev);
> -            g_free(xendev);
> +            qdev_unplug(&xendev->qdev, NULL);
>              return NULL;
>          }
>      } else {

I think this will leak memory (and that we're already leaking
memory), because the code is creating the xendev with
    xendev =3D g_malloc0(ops->size);
    object_initialize(&xendev->qdev, ops->size, TYPE_XENBACKEND);

This is saying "I own and am responsible for freeing the memory
that the device object lives in". If you want the object system
to handle freeing the memory for you when the reference count
goes to zero, then you need to create it with
   xendev =3D object_new()
which we can't do here because we're allocating ops->size bytes
rather than just the size of the object type.

Two options I think:
 (1) have your code do
    OBJECT(xendev)->free =3D g_free;
 after the object_initialize (to tell the object system how
to free this object)
 (2) call both qdev_unplug and g_free

I think (1) is better because it will definitely work even
if the qdev bus system is holding on to an object reference
after it returns from qdev_unplug() for some reason, and
it will also mean we free the memory when we do a
qdev_unplug in xen_pv_del_xendev(), rather than leaking it.

Side note: Using DEVICE(xendev) is better QOM style than
&xendev->qdev.

(The weirdness with doing a g_malloc0(ops->size) appears
to be because Xen backends have their own setup for saying
"allocate this many bytes for my data", rather than having
XenBlkDev, XenConsole, etc be QOM subclasses of XenDevice.
Presumably that code all predates QEMU's QOMification.)

We also do OBJECT(thing)->free =3D something in hw/core/sysbus.c;
maybe we should have a function to abstract this away?
Not sure.

thanks
-- PMM
