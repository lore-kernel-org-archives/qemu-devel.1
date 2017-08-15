Received: from eggs.gnu.org ([2001:4830:134:3::10]:40853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dhPON-0001jy-RB
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 20:07:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dhPOK-0002UH-MG
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 20:07:31 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:33482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dhPOK-0002U3-F0
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 20:07:28 -0400
Received: by mail-wm0-f44.google.com with SMTP id k20so20384625wmg.0
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 17:07:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
References: <20170814231552.24593-1-pbonzini@redhat.com>
Message-ID: <b1a81e45-a47c-7a9e-9ce4-60d363d08292@redhat.com>
Date: Tue, 15 Aug 2017 02:07:24 +0200
MIME-Version: 1.0
In-Reply-To: <20170814231552.24593-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ademaria@redhat.com, kraxel@redhat.com, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 15/08/2017 01:15, Paolo Bonzini wrote:
> Fixes this 2.10 regression:
> 
>   $ qemu-system-x86_64  -cpu host -m 6144 -vga qxl -device qxl
>   qemu-system-x86_64: util/qemu-thread-posix.c:64: qemu_mutex_lock: Assertion `mutex->initialized' failed.
> 
> Reported-by: ademaria@redhat.com
> Cc: kraxel@redhat.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Hmm, Gerd is on vacation but perhaps Marc-André can ack it?  Or just
revert the mutex->initialized patch for 2.10 (commit c096358e74,
"qemu-thread: Assert locks are initialized before using", 2017-07-04).

Paolo

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
> 
