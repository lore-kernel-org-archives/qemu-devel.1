Received: from eggs.gnu.org ([2001:4830:134:3::10]:40947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dhc4L-0001qG-If
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 09:39:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dhc4D-0003pr-Ne
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 09:39:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dhc4D-0003pO-Gt
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 09:39:33 -0400
Date: Tue, 15 Aug 2017 14:39:23 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170815133923.GL9674@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170814231552.24593-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170814231552.24593-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 2.10?] qxl: call
 qemu_spice_display_init_common for secondary devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, ademaria@redhat.com, kraxel@redhat.com

On Tue, Aug 15, 2017 at 01:15:52AM +0200, Paolo Bonzini wrote:
> Fixes this 2.10 regression:
> 
>   $ qemu-system-x86_64  -cpu host -m 6144 -vga qxl -device qxl
>   qemu-system-x86_64: util/qemu-thread-posix.c:64: qemu_mutex_lock: Assertion `mutex->initialized' failed.
> 
> Reported-by: ademaria@redhat.com
> Cc: kraxel@redhat.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/display/qxl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> index 7f8c73b56d..ae3677fd1e 100644
> --- a/hw/display/qxl.c
> +++ b/hw/display/qxl.c
> @@ -2054,6 +2054,7 @@ static void qxl_realize_common(PCIQXLDevice *qxl, Error **errp)
>      uint32_t pci_device_rev;
>      uint32_t io_size;
>  
> +    qemu_spice_display_init_common(&qxl->ssd);
>      qxl->mode = QXL_MODE_UNDEFINED;
>      qxl->generation = 1;
>      qxl->num_memslots = NUM_MEMSLOTS;
> @@ -2176,7 +2177,6 @@ static void qxl_realize_primary(PCIDevice *dev, Error **errp)
>      portio_list_add(&qxl->vga_port_list, pci_address_space_io(dev), 0x3b0);
>  
>      vga->con = graphic_console_init(DEVICE(dev), 0, &qxl_ops, qxl);
> -    qemu_spice_display_init_common(&qxl->ssd);
>  
>      qxl_realize_common(qxl, &local_err);
>      if (local_err) {

IIUC, we hit the abort because we have 2 QXL devices, and only
qxl_realize_primary() is calling  qemu_spice_display_init_common().
By moving the qemu_spice_display_init_common() call upto into
the qxl_realize_common() method, it also gets triggered by
qxl_realize_secondary(). It makes that we need to initialize the
'ssd' field for both primary and secondary displays

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
