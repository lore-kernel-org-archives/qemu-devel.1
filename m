Received: from eggs.gnu.org ([209.51.188.92]:47233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gk2Ry-0008Ru-Vt
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 02:50:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gk2Ry-0002zd-8r
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 02:50:54 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gk2Ry-0002z4-30
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 02:50:54 -0500
Received: by mail-wm1-f65.google.com with SMTP id g67so4641569wmd.2
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 23:50:53 -0800 (PST)
Date: Thu, 17 Jan 2019 08:50:49 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190117075049.lm5sbws73swdmrgq@steredhat>
References: <20190116174941.342900-1-sgarzare@redhat.com>
	<00ff0393-1eab-9bc4-6370-0f959df9dca0@redhat.com>
	<bbec0a30-6b3e-6ba1-b439-7cc72999ea6b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbec0a30-6b3e-6ba1-b439-7cc72999ea6b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/5] pvh: add new PVH option rom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Maran Wilson <maran.wilson@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>, George Kennedy <george.kennedy@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Richard Henderson <rth@twiddle.net>

Hi Paolo,

On Wed, Jan 16, 2019 at 10:17:15PM +0100, Paolo Bonzini wrote:
> On 16/01/19 19:31, Paolo Bonzini wrote:
> > 
> > I get this:
> > 
> >   CC      optionrom/pvh_main.o
> > /tmp/ccoel69H.s: Assembler messages:
> > /tmp/ccoel69H.s:171: Error: attempt to move .org backwards
> > 
> > when applying this series on CentOS 7.
> 
> Oops, the issue was actaually in linux_dma - I was confused by make -j
> reordering the output.  The fix is trivial

Thanks for the fix! I didn't have this error on Fedora 29 (gcc 8.2.1).

> 
> --- a/pc-bios/optionrom/linuxboot_dma.c
> +++ b/pc-bios/optionrom/linuxboot_dma.c
> @@ -20,10 +20,6 @@
>   *     Richard W.M. Jones <rjones@redhat.com>
>   */
> 
> -#include <stdint.h>
> -#include "optrom.h"
> -#include "optrom_fw_cfg.h"
> -
>  asm(
>  ".text\n"
>  ".global _start\n"
> @@ -62,6 +58,10 @@ asm(
>  "   jmp load_kernel\n"
>  );
> 
> +#include <stdint.h>
> +#include "optrom.h"
> +#include "optrom_fw_cfg.h"
> +
>  static inline void set_es(void *addr)
>  {
>      uint32_t seg = (uint32_t)addr >> 4;
> 
> 
> Also, the $? in the new rule should be $^.  I wouldn't use a pattern
> rule for that, writing it explicitly as "pvh.img: pvh.S pvh_main.c"

I'll fix the Makefile.

Thanks,
Stefano

> 
> Thanks,
> 
> Paolo
