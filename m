Received: from eggs.gnu.org ([2001:4830:134:3::10]:44055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4PRA-0002Yq-QU
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 06:49:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4PRA-0000Tx-1Z
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 06:49:28 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171017001209.32276-1-f4bug@amsat.org>
	<20171017001209.32276-31-f4bug@amsat.org>
	<44b57d76-6d10-84c8-3a13-cdac7331c5d9@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <47c7b41d-23ff-3dd1-9c07-69bd5df08685@amsat.org>
Date: Tue, 17 Oct 2017 07:49:16 -0300
MIME-Version: 1.0
In-Reply-To: <44b57d76-6d10-84c8-3a13-cdac7331c5d9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 30/39] hw/display/vga: remove the old
 i386/pc dependency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Hi Thomas,

>> diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
>> index ad34a1f048..fe23b81442 100644
>> --- a/hw/display/vga_int.h
>> +++ b/hw/display/vga_int.h
>> @@ -25,8 +25,9 @@
>>  #ifndef HW_VGA_INT_H
>>  #define HW_VGA_INT_H
>>  
>> -#include "hw/hw.h"
>> +#include "exec/ioport.h"
>>  #include "exec/memory.h"
>> +#include "ui/console.h"
> 
> So vga_int.h now includes console.h (is it really necessary?) ...

The VGACommonState struct has a GraphicHwOps *hw_ops member.

> 
> [...]
>>  static inline bool isa_ne2000_init(ISABus *bus, int base, int irq, NICInfo *nd)
>>  {
>> diff --git a/hw/display/vga-isa-mm.c b/hw/display/vga-isa-mm.c
>> index 51ccbccc41..e887b45651 100644
>> --- a/hw/display/vga-isa-mm.c
>> +++ b/hw/display/vga-isa-mm.c
>> @@ -23,11 +23,9 @@
>>   */
>>  #include "qemu/osdep.h"
>>  #include "hw/hw.h"
>> -#include "ui/console.h"
> 
> ... and here you also remove it from the .c file - OK ...
> 
>> -#include "hw/i386/pc.h"
>> +#include "hw/display/vga.h"
>>  #include "vga_int.h"
>>  #include "ui/pixel_ops.h"
>> -#include "qemu/timer.h"
>>  
>>  #define VGA_RAM_SIZE (8192 * 1024)
>>  
>> diff --git a/hw/display/vga-isa.c b/hw/display/vga-isa.c
>> index 1af95562f2..9af43abee8 100644
>> --- a/hw/display/vga-isa.c
>> +++ b/hw/display/vga-isa.c
>> @@ -26,7 +26,7 @@
>>  #include "qemu/osdep.h"
>>  #include "hw/hw.h"
>>  #include "ui/console.h"
> 
> ... but here you keep it? I think you should either remove it here, too,

I missed this one.

> or not add the include in the header (which I'd prefer if the header
> itself does not depend on console.h).

Do you suggest me do declare GraphicHwOps opaque in "qemu/typedefs.h"?

> 
>> -#include "hw/i386/pc.h"
>> +#include "hw/isa/isa.h"
>>  #include "vga_int.h"
>>  #include "ui/pixel_ops.h"
>>  #include "qemu/timer.h"
>> diff --git a/hw/display/vga.c b/hw/display/vga.c
>> index ed24ef7076..0da4942a09 100644
>> --- a/hw/display/vga.c
>> +++ b/hw/display/vga.c
>> @@ -24,9 +24,9 @@
>>  #include "qemu/osdep.h"
>>  #include "qapi/error.h"
>>  #include "hw/hw.h"
>> -#include "vga.h"
>> +#include "hw/display/vga.h"
>>  #include "ui/console.h"
> 
> Here's another one --^

Oh this one too.
