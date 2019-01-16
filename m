Received: from eggs.gnu.org ([209.51.188.92]:57699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gjsYx-0002Ra-K6
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 16:17:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gjsYs-00023Z-H7
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 16:17:24 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40750)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gjsYp-0001u0-29
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 16:17:20 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so8628194wrt.7
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 13:17:18 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
References: <20190116174941.342900-1-sgarzare@redhat.com>
	<00ff0393-1eab-9bc4-6370-0f959df9dca0@redhat.com>
Message-ID: <bbec0a30-6b3e-6ba1-b439-7cc72999ea6b@redhat.com>
Date: Wed, 16 Jan 2019 22:17:15 +0100
MIME-Version: 1.0
In-Reply-To: <00ff0393-1eab-9bc4-6370-0f959df9dca0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/5] pvh: add new PVH option rom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Maran Wilson <maran.wilson@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>, George Kennedy <george.kennedy@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Richard Henderson <rth@twiddle.net>

On 16/01/19 19:31, Paolo Bonzini wrote:
> On 16/01/19 18:49, Stefano Garzarella wrote:
>> This patch series is based on "[PATCH v3 0/4] QEMU changes to do PVH boot" and
>> provides a PVH option rom that can be used with SeaBIOS to boot uncompressed
>> kernel using the x86/HVM direct boot ABI.
>>
>> Patches 1 and 2 are to prepare the PVH option rom, moving common functions in
>> the new headers.  Patch 3 adds the new PVH option rom. Patch 4 uses it when we
>> are booting an uncompressed kernel using the x86/HVM direct boot ABI. Patch 5
>> adds the support of loading the initrd in the PVH option rom.
>>
>> Based-on: <1547554687-12687-1-git-send-email-liam.merwick@oracle.com>
> 
> I get this:
> 
>   CC      optionrom/pvh_main.o
> /tmp/ccoel69H.s: Assembler messages:
> /tmp/ccoel69H.s:171: Error: attempt to move .org backwards
> 
> when applying this series on CentOS 7.

Oops, the issue was actaually in linux_dma - I was confused by make -j
reordering the output.  The fix is trivial

--- a/pc-bios/optionrom/linuxboot_dma.c
+++ b/pc-bios/optionrom/linuxboot_dma.c
@@ -20,10 +20,6 @@
  *     Richard W.M. Jones <rjones@redhat.com>
  */

-#include <stdint.h>
-#include "optrom.h"
-#include "optrom_fw_cfg.h"
-
 asm(
 ".text\n"
 ".global _start\n"
@@ -62,6 +58,10 @@ asm(
 "   jmp load_kernel\n"
 );

+#include <stdint.h>
+#include "optrom.h"
+#include "optrom_fw_cfg.h"
+
 static inline void set_es(void *addr)
 {
     uint32_t seg = (uint32_t)addr >> 4;


Also, the $? in the new rule should be $^.  I wouldn't use a pattern
rule for that, writing it explicitly as "pvh.img: pvh.S pvh_main.c"

Thanks,

Paolo
