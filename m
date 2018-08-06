Received: from eggs.gnu.org ([2001:4830:134:3::10]:44105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fmoDs-0001Qe-4n
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 18:43:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fmoDr-0003FR-5G
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 18:43:32 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33380)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fmoDq-0003EO-Rt
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 18:43:31 -0400
Received: by mail-wr1-x443.google.com with SMTP id g6-v6so13869388wrp.0
	for <qemu-devel@nongnu.org>; Mon, 06 Aug 2018 15:43:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180807001146-mutt-send-email-mst@kernel.org>
References: <20180803153235.4134-1-marcandre.lureau@redhat.com>
	<20180807001146-mutt-send-email-mst@kernel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 7 Aug 2018 00:43:28 +0200
Message-ID: <CAJ+F1C+Q0XT3=XVdxWUijdJGvR1YNcZ6cVE58X-P7L30n0U_OA@mail.gmail.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

Hi

On Mon, Aug 6, 2018 at 11:16 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Fri, Aug 03, 2018 at 05:32:35PM +0200, Marc-Andr=C3=A9 Lureau wrote:
>> With vga=3D775 on the Linux command line a first boot of the VM running
>> Linux works fine. After a warm reboot it crashes during Linux boot.
>>
>> Before that, valgrind points out bad memory write to console
>> surface. The VGA code is not aware that virtio-gpu got a message
>> surface scanout when the display is disabled. Let's reset VGA graphic
>> mode when it is the case, so that a new display surface is created
>> when doing further VGA operations.
>>
>> https://bugs.launchpad.net/qemu/+bug/1784900/
>>
>> Reported-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  include/hw/virtio/virtio-gpu.h |  1 +
>>  hw/display/virtio-gpu.c        |  5 +++++
>>  hw/display/virtio-vga.c        | 11 +++++++++++
>>  3 files changed, 17 insertions(+)
>>
>> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-g=
pu.h
>> index 9780f755ef..d0321672f4 100644
>> --- a/include/hw/virtio/virtio-gpu.h
>> +++ b/include/hw/virtio/virtio-gpu.h
>> @@ -125,6 +125,7 @@ typedef struct VirtIOGPU {
>>          uint32_t bytes_3d;
>>      } stats;
>>
>> +    void (*disable_scanout)(struct VirtIOGPU *g, int scanout_id);
>>      Error *migration_blocker;
>>  } VirtIOGPU;
>>
>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>> index ec366f4c35..3ddd29c0de 100644
>> --- a/hw/display/virtio-gpu.c
>> +++ b/hw/display/virtio-gpu.c
>> @@ -421,6 +421,11 @@ static void virtio_gpu_disable_scanout(VirtIOGPU *g=
, int scanout_id)
>>                                           scanout->height ?: 480,
>>                                           "Guest disabled display.");
>>      }
>> +
>> +    if (g->disable_scanout) {
>> +        g->disable_scanout(g, scanout_id);
>> +    }
>> +
>>      dpy_gfx_replace_surface(scanout->con, ds);
>>      scanout->resource_id =3D 0;
>>      scanout->ds =3D NULL;
>> diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
>> index 2b36f2899a..672b7f9ce2 100644
>> --- a/hw/display/virtio-vga.c
>> +++ b/hw/display/virtio-vga.c
>> @@ -75,6 +75,16 @@ static void virtio_vga_gl_block(void *opaque, bool bl=
ock)
>>      }
>>  }
>>
>> +static void virtio_vga_disable_scanout(VirtIOGPU *g, int scanout_id)
>> +{
>> +    VirtIOVGA *vvga =3D container_of(g, VirtIOVGA, vdev);
>> +
>> +    if (scanout_id =3D=3D 0) {
>> +        /* reset surface if needed */
>> +        vvga->vga.graphic_mode =3D -1;
>> +    }
>> +}
>> +
>>  static const GraphicHwOps virtio_vga_ops =3D {
>>      .invalidate =3D virtio_vga_invalidate_display,
>>      .gfx_update =3D virtio_vga_update_display,
>
> Would it make sense to add
> vga_disable_scanout() to hw/display/vga_int.h and
> poke at graphic_mode there?
>
> I'll leave the decision to you.

If Gerd doesn't chime in before RC4, I suggest to take that version.
He might want to update it or take a different approach post 3.0.

>
>> @@ -156,6 +166,7 @@ static void virtio_vga_realize(VirtIOPCIProxy *vpci_=
dev, Error **errp)
>>                                   vvga->vga_mrs, true);
>>
>>      vga->con =3D g->scanout[0].con;
>> +    g->disable_scanout =3D virtio_vga_disable_scanout;
>>      graphic_console_set_hwops(vga->con, &virtio_vga_ops, vvga);
>>
>>      for (i =3D 0; i < g->conf.max_outputs; i++) {
>
> While I really know very little about vga, it seems
> like that's the standard way to force full update so
>
>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

thanks



--=20
Marc-Andr=C3=A9 Lureau
