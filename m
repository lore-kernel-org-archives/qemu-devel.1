Received: from eggs.gnu.org ([2001:4830:134:3::10]:51520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eejPF-0006UL-KJ
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:25:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eejPC-0007GK-Vq
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:25:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eejPC-0007Fd-NR
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:25:34 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B50641F583
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 15:25:33 +0000 (UTC)
Date: Thu, 25 Jan 2018 15:25:01 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180125152501.GL1776@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180117164118.8510-1-berrange@redhat.com>
	<20180117164118.8510-5-berrange@redhat.com>
	<20180125151619.mywrqtexyvqqlcxj@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180125151619.mywrqtexyvqqlcxj@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [PATCH v7 4/4] hw: convert virtio-input-hid device
 to keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Thu, Jan 25, 2018 at 04:16:19PM +0100, Gerd Hoffmann wrote:
>   Hi,
> 
> > If the guest OS reboots, or otherwise re-initializes the virt-input device,
> > it will read the new keycode bitmap. No matter how many keys are defined,
> > the config space has a fixed 128 byte bitmap. There is, however, a size
> > field defiend which says how many bytes in the bitmap are used.
> 
> No.  There is a size field saying how big the bitmap is.  config space
> (as in: virtio device config space) is only as big as is actually
> needed, i.e. basically the highest set bit of the bitmap determines the
> config space size.

Oopps, I missed that subtlety, thinking we always read at least the
size of "struct virtio_input_config"

> 
> Debug patch ...
> 
> --- a/hw/input/virtio-input.c
> +++ b/hw/input/virtio-input.c
> @@ -255,6 +255,8 @@ static void virtio_input_device_realize(DeviceState
> *dev, Error **errp)
>      }
>      vinput->cfg_size += 8;
>      assert(vinput->cfg_size <= sizeof(virtio_input_config));
> +    fprintf(stderr, "%s: %s: %d bytes cfg space\n", __func__,
> +            object_get_typename(OBJECT(dev)), vinput->cfg_size);
>  
>      virtio_init(vdev, "virtio-input", VIRTIO_ID_INPUT,
>                  vinput->cfg_size);
> 
> ... prints this without the patch ...
> 
>   virtio_input_device_realize: virtio-keyboard-device: 29 bytes cfg space
> 
> ... and this with the patch:
> 
>   virtio_input_device_realize: virtio-keyboard-device: 37 bytes cfg space
> 
> 
> That seems to not have any bad side effects on live migration though.
> I can vmsave with unpatched qemu and vmload with patched qemu (and visa
> versa).

IIUC, the guest OS will only read this cfg data when the driver loads.

So during vmload, ths guest won't trigger this code path.

IIUC, to be affected by the incompatibility, the guest would have
to be vmsave+vmload'd / migrated, at the exact time window between
reading the config space size, and reading the config space data.

In the old -> new case, that's still safe as we simply don't read
all the data. In the new -> old case, we could be reading 37 bytes
when only 29 bytes of cfg space are mapped.

This is exceedingly unlikely to happen in practice, but I'm still
curious what happens if we try to read too much cfg space ?

> Agreeing with the analysis that guests should cope with the change just
> fine, worst case being that the newly added keys are not working on
> updated qemu without guest reboot.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
