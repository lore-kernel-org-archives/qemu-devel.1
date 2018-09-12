Received: from eggs.gnu.org ([2001:4830:134:3::10]:41274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g06iF-0005jW-R5
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 11:05:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g06b0-0008Qi-DN
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 10:58:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58520 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1g06b0-0008Pu-6R
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 10:58:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 17B8140214E2
	for <qemu-devel@nongnu.org>; Wed, 12 Sep 2018 14:58:20 +0000 (UTC)
References: <20180912123700.7708-1-kraxel@redhat.com>
	<20180912123700.7708-3-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <efd77dd1-0402-c68e-7ee9-e8b240c4abd9@redhat.com>
Date: Wed, 12 Sep 2018 09:58:15 -0500
MIME-Version: 1.0
In-Reply-To: <20180912123700.7708-3-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] display/stdvga: add edid support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>

On 9/12/18 7:37 AM, Gerd Hoffmann wrote:
> This patch adds edid support to the qemu stdvga.  It is turned off by
> default and can be enabled with the new edid property.  The patch also
> adds xres and yres properties to specify the video mode you want the
> guest use.  Works only with edid enabled and updated guest driver.
> 
> The mmio bar of the stdvga has some unused address space at the start.
> It was reserved just in case it'll be needed for virtio, but it turned
> out to not be needed for that.  So lets use that region to place the

s/lets/let's/

> EDID data block there.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   docs/specs/standard-vga.txt |  2 +-
>   hw/display/vga_int.h        |  2 +-
>   hw/display/vga-pci.c        | 42 ++++++++++++++++++++++++++++++++++++++----
>   hw/display/virtio-vga.c     |  2 +-
>   4 files changed, 41 insertions(+), 7 deletions(-)
> 
> diff --git a/docs/specs/standard-vga.txt b/docs/specs/standard-vga.txt
> index 19d2a74509..18f75f1b30 100644
> --- a/docs/specs/standard-vga.txt
> +++ b/docs/specs/standard-vga.txt
> @@ -61,7 +61,7 @@ MMIO area spec
>   
>   Likewise applies to the pci variant only for obvious reasons.
>   
> -0000 - 03ff : reserved, for possible virtio extension.
> +0000 - 03ff : edid data blob.


> +    if (edid) {
> +        qemu_edid_info info = {
> +            .prefx = d->xres,
> +            .prefy = d->yres,
> +        };
> +        qemu_edid_generate(d->edid, sizeof(d->edid), &info);
> +        qemu_edid_region_io(&subs[3], owner, d->edid, sizeof(d->edid));
> +        memory_region_add_subregion(parent, 0, &subs[3]);

Is there ever a risk that this could overflow?  Or, if the blob is 
always smaller than 0x3ff, should we still leave reserved bytes?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
