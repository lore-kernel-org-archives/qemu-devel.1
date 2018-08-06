Received: from eggs.gnu.org ([2001:4830:134:3::10]:53836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fmfrU-0006yX-Br
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 09:47:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fmfrQ-0006fm-4u
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 09:47:52 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:53446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1fmfrP-0006fQ-Uo
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 09:47:48 -0400
Received: by mail-it0-f67.google.com with SMTP id 72-v6so17461015itw.3
	for <qemu-devel@nongnu.org>; Mon, 06 Aug 2018 06:47:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-bM7KiPp5P5S-UAT5b6v7X0ETVqCA01WOSihTyW37WMQ@mail.gmail.com>
References: <20180803153235.4134-1-marcandre.lureau@redhat.com>
	<CAFEAcA-bM7KiPp5P5S-UAT5b6v7X0ETVqCA01WOSihTyW37WMQ@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 6 Aug 2018 15:47:45 +0200
Message-ID: <CAMxuvazgmdke+bvnyY5RZJW=-vPXC6KAz9p9bmK+uVPcYF-coA@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

On Mon, Aug 6, 2018 at 3:39 PM, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
> On 3 August 2018 at 16:32, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
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
>
> I guess for a last-minute 3.0 fix this is ok, but it looks
> a bit weird to have a function pointer in a device instance
> struct, which the user of the device has reached in and
> set in order to modify the behaviour of the object...

It's not much different than pointing to a static const structure with
function pointers (I thought that was unnecessary for just one
function)

We could also have a VirtioGPUClass with virtual methods, and subclass
TYPE_VIRTIO_GPU. Also a bit over-complicated, and conflicting with my
vhost-user-gpu series. So we may eventually get there in 3.1 though.

>
> thanks
> -- PMM
