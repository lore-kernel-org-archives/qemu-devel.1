Received: from eggs.gnu.org ([2001:4830:134:3::10]:45805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gFmOd-0005Bw-J5
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 16:38:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gFmOW-00029H-GS
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 16:38:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gFmOW-00026z-7p
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 16:38:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DC23B81DF0
	for <qemu-devel@nongnu.org>; Thu, 25 Oct 2018 20:38:14 +0000 (UTC)
Date: Thu, 25 Oct 2018 21:37:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181025203758.GA29995@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181025085256.20522-1-kraxel@redhat.com>
	<20181025085256.20522-4-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181025085256.20522-4-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] cirrus: mark as deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, Prasad J Pandit <ppandit@redhat.com>

On Thu, Oct 25, 2018 at 10:52:56AM +0200, Gerd Hoffmann wrote:
> While being at it deprecate cirrus too.
> 
> Reason (short version): use stdvga instead.
> Verbose version:
>     https://www.kraxel.org/blog/2014/10/qemu-using-cirrus-considered-harmful

Every single one of my guests is using cirrus. This wasn't an explicit
choice on my part, so I believe it is being used as the default in
virt-install.

I don't debate the points in the blog post above that stdvga is a
better choice, but I don't think that's enough to justify deprecating
cirrus at this point in time, because when it then gets deleted it
will break way too many existing deployments.

We need to socialize info in that blog post above more widely and
especially ensure that apps are not using that by default. I don't
see it being viable to formally deprecate it in QEMU any time soon
though given existing usage.

> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/display/cirrus_vga.c     | 2 ++
>  hw/display/cirrus_vga_isa.c | 2 ++
>  qemu-deprecated.texi        | 4 ++++
>  3 files changed, 8 insertions(+)
> 
> diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
> index d9b854d..2f16ba9 100644
> --- a/hw/display/cirrus_vga.c
> +++ b/hw/display/cirrus_vga.c
> @@ -3024,6 +3024,8 @@ static void cirrus_vga_class_init(ObjectClass *klass, void *data)
>      dc->vmsd = &vmstate_pci_cirrus_vga;
>      dc->props = pci_vga_cirrus_properties;
>      dc->hotpluggable = false;
> +    dc->deprecation_reason =
> +        "https://www.kraxel.org/blog/2014/10/qemu-using-cirrus-considered-harmful";
>  }
>  
>  static const TypeInfo cirrus_vga_info = {
> diff --git a/hw/display/cirrus_vga_isa.c b/hw/display/cirrus_vga_isa.c
> index fa10b74..c2d853c 100644
> --- a/hw/display/cirrus_vga_isa.c
> +++ b/hw/display/cirrus_vga_isa.c
> @@ -81,6 +81,8 @@ static void isa_cirrus_vga_class_init(ObjectClass *klass, void *data)
>      dc->realize = isa_cirrus_vga_realizefn;
>      dc->props = isa_cirrus_vga_properties;
>      set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
> +    dc->deprecation_reason =
> +        "https://www.kraxel.org/blog/2014/10/qemu-using-cirrus-considered-harmful";
>  }
>  
>  static const TypeInfo isa_cirrus_vga_info = {
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 7951a4f..1b1d434 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -120,6 +120,10 @@ or ``ivshmem-doorbell`` device types.
>  
>  Has known buffer overflow.
>  
> +@subsection cirrus (since 3.1)
> +
> +Use stdvga instead (-vga std or -device VGA).
> +
>  @section System emulator machines
>  
>  @subsection pc-0.10 and pc-0.11 (since 3.0)
> -- 
> 2.9.3
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
