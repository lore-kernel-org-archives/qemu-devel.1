Received: from eggs.gnu.org ([2001:4830:134:3::10]:49026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cRKOB-0005fp-7L
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 10:00:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cRKO7-0004uz-6H
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 10:00:35 -0500
Received: from smtp3.mundo-r.com ([212.51.32.191]:13558 helo=smtp4.mundo-r.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cRKO6-0004Kx-QR
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 10:00:31 -0500
Date: Wed, 11 Jan 2017 16:59:34 +0200
From: Alberto Garcia <berto@igalia.com>
Message-ID: <20170111145934.nogaszs5gvmn5bad@perseus.local>
References: <1476776717-24807-1-git-send-email-ppandit@redhat.com>
	<CAJ+F1CKnyE1d8nT_dj2D5St=2e9+W5Zx0zvXGxPDsOsg1NW66w@mail.gmail.com>
	<alpine.LFD.2.20.1611281003090.19776@wniryva>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1611281003090.19776@wniryva>
Subject: Re: [Qemu-devel] [PATCH] display: cirrus: check vga bits per
 pixel(bpp) value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, Qemu Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Huawei PSIRT <psirt@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>

On Mon, Nov 28, 2016 at 11:52:08AM +0530, P J P wrote:
> | > --- a/hw/display/cirrus_vga.c
> | > +++ b/hw/display/cirrus_vga.c
> | > @@ -272,6 +272,9 @@ static void cirrus_update_memory_access(CirrusVGAState
> | > *s);
> | >  static bool blit_region_is_unsafe(struct CirrusVGAState *s,
> | >                                    int32_t pitch, int32_t addr)
> | >  {
> | > +    if (!pitch) {
> | > +        return true;
> | > +    }
> | >
> | 
> | That doesn't look directly related to 'cirrus_get_bpp', care to explain?
> 
>   'blit_region_is_unsafe' is called from 'blit_is_unsafe' to check if blit 
> parameters (cirrus_blt_srcpitch/cirrus_blt_dstpitch)  are safe for 
> 'cirrus_do_copy'. These too could lead to div by zero in cirrus_do_copy

This change is causing display artifacts in QEMU 2.8.

What seems to happen is that blit_is_unsafe() is also called for
CIRRUS_BLTMODE_PATTERNCOPY, but in this case cirrus_blt_srcpitch is
not used. However, because of this new check if its value is 0 then
cirrus_bitblt_common_patterncopy() returns early and becomes a no-op.

Berto
